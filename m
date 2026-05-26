Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF3FCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD08847B0;
	Tue, 26 May 2026 15:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oGqzNREd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5830847AF; Tue, 26 May 2026 15:10:06 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9A3846D3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69d994bfde4so1833264eaf.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801002; x=1780405802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zfL4p7ohchmV+323+L2LE95ipGaYZDhmm0cb1RCmrVk=;
 b=oGqzNREdXmtxLR7A6lEBiGbu+bHYm3ll8iF2sB/LAHF8I8MTkWrVI06jbVCilGF+0j
 ifTjJw7e3h2jFtOBfuTR3oo8DvTqhKsTyuz1cbpp7jphDHnVH6OYSWgQTZ7P9qTKEvxB
 xi4zMqorKlu1hpZFvPmDL2CUIuTlV3Hu7XSBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801002; x=1780405802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfL4p7ohchmV+323+L2LE95ipGaYZDhmm0cb1RCmrVk=;
 b=N5SufXyPkczqehC05edLNm420NlUd4eqorU/KkaJYho3Fj7KSPO/GN45Mtb3vP3LAa
 EOEVtw7RM/QGtyXBazbLm12WmEp0rnMiNlqg0vhyVLqOa8nOcrOD8Yu2Jh/LwseSPjgV
 pEsY/zgdb/ojl4C7T/VPkxYx6h81mDhqa93lSrZmzznvxTmIjxmsryc7KmzKUz/YuHaV
 ccRfLxdctGyUuP2gvfMOeU+sWvDaNj5S9yk+Adr1z2OFLSfVy1cRlVgOIM50WVuw4v74
 OzK0MMegfS07yKJEhjlTN3nydwjUHE+nxjan51LI1MqTKIHqY47ZNJgSLNt2dqMc3TiV
 d3ww==
X-Gm-Message-State: AOJu0Yx0UCOq2Godd+ZdiI+DJtrwkjea+sDasBeiFklfHABPB0jHqcUs
 lQ42fhoEh5FOg8nKRZ7LhaAZhdwTkgcQ/scTFb0EEuVnIoZ2iDtr8H3FbwD++Ms/EaxHsYfYRj0
 cstzUT/ns5xc=
X-Gm-Gg: Acq92OFfAgiFFYEH3i+VMV2+FXT8vMcZQXamYDpS9LtEw4A/c4xMXj9kfdwVw6dfqx5
 UiaJt5pTcTi0zoRCicg6SluRUidSTu+p07e58hsGsDuziQ2mYQPXfhMuyjn4sp++fSrMmquT2fE
 fJvGXk/jxTmMhG4He3RoVp3PgdUIIkwjSOAognp9GuOWLwbzeVTQBiD6rIP3/TVI2/HOjSE3HWZ
 I/zBlZ/qSyHNLgcJsAIw2vnN6k09LVQFja78kM8wVjau+SWxgKdK7AM7WnxpiQFmur6/csHrqXE
 vm0AxxHIRmzgOhLH+TdAZf5eQpOpbGot0L966CgFJKNB6zSJvMVq1RHDMpMi1SQ5sqY8ibHXqnu
 c0wcFpr2o19v3TExHo7+eFMaUClv/lK82LqQWoSb7hDaGoXRFaVyw54I3wjcROsNRZ8M238Bzn8
 Xnl9yEZEQMm+ROXCWs7sbqLmOT1Tsh
X-Received: by 2002:a05:6820:178e:b0:69b:56aa:1525 with SMTP id
 006d021491bc7-69d7e83e0f8mr11374418eaf.0.1779801001801; 
 Tue, 26 May 2026 06:10:01 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 0/9] x86: Move zboot state into struct bootm_info
Date: Tue, 26 May 2026 07:09:06 -0600
Message-ID: <20260526130931.2103552-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Most of the x86 zboot command keeps its state in a file-scope struct,
separate from the bootm code. Move this state into struct bootm_info so
the rest of the bootm logic can reach it directly, then drop the
now-redundant base_ptr argument from zimage_dump()

The series also includes some small clean-updates: making
do_zboot_states() static, renaming zboot_run() to make its purpose
clearer, and dropping a duplicate zimage_dump() declaration.

The kernel-version display is wrong in bootstd when the bzImage address
is not known, so a fix for this is included.

Also use strlcpy() in label_boot() for safer string handling.

Note: this series was split from an earlier, larger series originally
sent in late 2024. The eventual goal is to support booting without
CONFIG_CMDLINE and with Boot Loader Specification (BLS).


Simon Glass (9):
  x86: Make do_zboot_states() static
  x86: Rename zboot_run() to zboot_run_args()
  x86: Drop duplicate definition of zimage_dump()
  x86: Move x86 zboot state into struct bootm_info
  x86: Rename state to bmi
  x86: Move the bootm state for zimage into cmd/
  x86: boot: Correct display of kernel version
  x86: Drop the unnecessary base_ptr argument to zboot_dump()
  boot: Use strlcpy() in label_boot()

 arch/x86/include/asm/zimage.h | 57 +++++-----------------
 arch/x86/lib/zimage.c         | 91 ++++++++++++++++++-----------------
 boot/bootmeth_cros.c          |  6 +--
 boot/pxe_utils.c              |  2 +-
 cmd/bootflow.c                |  8 ++-
 cmd/x86/zboot.c               | 33 +++++++------
 include/bootm.h               | 48 +++++++++++++++---
 7 files changed, 131 insertions(+), 114 deletions(-)

---
base-commit: 8d5f30b52f7c800c2177188fc4d331fb7af2c46a
branch: stb5a

-- 
2.43.0

