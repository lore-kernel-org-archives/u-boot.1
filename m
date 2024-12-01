Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF03D4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 17:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CA58917A;
	Sun,  1 Dec 2024 18:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qtq0jhU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162D588DDD; Sun,  1 Dec 2024 15:43:01 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 174C28912B
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-84197c469cfso105412539f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064169; x=1733668969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7GlhtUW98LWibsgqEumMxFcYaXCFPVLCF9AXXPK+p6A=;
 b=Qtq0jhU3QrbZ5VziSmfs1QccxwcfNQNmor35xN8mKfbjTXMRdP4wia8f8gwjVnQw4u
 WO3itTi/r5Zy/09+qd1Oqx86iTm5MZFD1iOIaa/BORwBRbigRviF14lhS3qSAaeDUB6y
 E7zvJcE6lY3nWWEXHQDvzBd7asOtVpCdMlTq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064169; x=1733668969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GlhtUW98LWibsgqEumMxFcYaXCFPVLCF9AXXPK+p6A=;
 b=T22FMiTZVzinvMMoyjbJIFA5GNG6lDQHtREXEuNF1+1ebxxoyI/+hHa+6YVGdwiaIP
 NDvUUQ4IuF9iq+vDCqxot4seHuzZ8aA7/vteWAZDU6nAvy4JDJiAJigsUHkN/X+pUHV9
 0yageq3on4sAvLvxlZlVtvbvpmNHU0gv+N2pfcFvxHqyDV3MjWadi6/Wh2S6jIBQ6n62
 na+u8bpNc5PfgaHFVAhlhVOfv1WcNuGRWCIhoRIKmGEXq1ORUtIoo2uProXRZNw9E+T5
 3f6YQt/LZvTIb532tKy7cggggyudZU685Cm6LdwF8pEihKt90tOW2huYVPB60Z5krJZH
 s8tg==
X-Gm-Message-State: AOJu0Yyvr9Ko+xYKXSzl16ygEwsfPSNp0qqS4xlSbzT2BykR6hdjehS/
 hCEvkrFw1h8/fJCMNcmnQZKg9Iu/5i471QId6cQgMVsY13vpW1X6zmbddvPrVUmueO6s0HLcgFc
 =
X-Gm-Gg: ASbGncvT+UIemQfZQ4wtTIa6W8HdVUgvg+gjQahdmLxoNduQIYgvh1BS+ECBY7UOZft
 +OWvA3ghGhCSAf9L6EJCoXz4yjLwmPuGSrkBYytlG/kI1ETwi2HLXyBqNuff6WB5mSL7DjAxUTq
 +w0Z5IRKwEzACXkqK/Pd9sAmvwiHt9dQ60SqprEMhArBP3g3i/MaMNoGb5ywdlC6udmpoYqy051
 cpqw7oKHWkjKB1CizyQ8cffaRf+VYEIAYdiXIg9uAUO
X-Google-Smtp-Source: AGHT+IGQVNHgXsYsTV09vH7Og3kDTu6vU/IxP1cPbEZtSiMrOZMgAeUMdjgfBxE4dgdsXgLcljiAXQ==
X-Received: by 2002:a05:6602:140f:b0:841:a80a:f536 with SMTP id
 ca18e2360f4ac-843ed0253e2mr2151063639f.14.1733064168900; 
 Sun, 01 Dec 2024 06:42:48 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:42:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: [PATCH 0/8] Reverts and fixes for board failures
Date: Sun,  1 Dec 2024 07:42:28 -0700
Message-ID: <20241201144240.1664398-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Dec 2024 18:16:49 +0100
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

This series collects together a set of reverts and fixes to get most of
the boards in the sjg lab running again.

Unfortunately three of them have developed a failure which requires more
diagnosis, as it may just be a hardware failure.

For coral, the TPM tests fail, but the board is working, so this can be
dealt with separately.

One remaining issue is that I am not sure what happens if two people try
to run tests at the same time. Tests run as the same user so I need to
investigate how that is handled.


Simon Glass (8):
  CI: Drop extra condition for sjg lab
  Revert "power: regulator: Trigger probe of regulators which are
    always-on or boot-on"
  Revert "fdt: Correct condition for bloblist existing"
  Revert "fdt: Allow the devicetree to come from a bloblist"
  fdt: Allow the devicetree to come from a bloblist
  binman: Avoid skipping binman_init()
  Revert "global_data: Drop spl_handoff"
  CI: Drop broken boards from sjg lab

 .gitlab-ci.yml                             | 41 +++++++++--------
 arch/x86/cpu/intel_common/cpu_from_spl.c   |  4 +-
 arch/x86/lib/fsp2/fsp_dram.c               |  4 +-
 cmd/sb.c                                   |  6 +--
 common/bloblist.c                          |  1 +
 common/board_f.c                           | 12 +++++
 common/init/handoff.c                      | 12 -----
 doc/develop/devicetree/control.rst         |  6 +--
 drivers/clk/rockchip/clk_rk3399.c          |  3 +-
 drivers/power/regulator/regulator-uclass.c | 22 +++------
 dts/Kconfig                                |  8 ++++
 include/asm-generic/global_data.h          |  6 +++
 include/fdtdec.h                           |  3 +-
 include/handoff.h                          |  7 ---
 lib/binman.c                               |  1 -
 lib/fdtdec.c                               | 53 ++++++++--------------
 test/dm/regulator.c                        |  6 ++-
 17 files changed, 91 insertions(+), 104 deletions(-)

-- 
2.43.0

