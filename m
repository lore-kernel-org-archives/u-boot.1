Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4582C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E198783F;
	Thu, 21 Dec 2023 01:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CPiauPyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81434875C5; Thu, 21 Dec 2023 01:40:51 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC30F876C8
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-42795ea3e35so1564241cf.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119245; x=1703724045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3FImOp1PlD6mJ/tb8KDpg5Ogb6PPRfYgAowlA0GnWuY=;
 b=CPiauPyTEnyvfxXzIgzFxku/9zyZEG3w0J7dg9ipQATXczyixFJsycQIagxIKLGAv7
 WjjCFb57lwt32IwFGk4lxWXxkTJAh/ept/gReesvUYcLDTkwu14oAyVRuq1jfpFZv+VU
 mwEFkR/+HRGUHPr1pcIktWsd3/QNV0HsuObYHWA8pbsLNzSdBXXQAEgkN8DeKFtiMRq5
 gWWecAQJXJRKhRErdAxXJEdowATtIQK9dkdxz0/9GdO4l6Ua/N/txqUsez9YiQBeDh5s
 WZTs0ijW0mbZKaxaMk4ZV8x6P8MFcvT9K0udNUsIfDPTK6RyhnMFhTrGqaBtANNOD4Mr
 ERhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119245; x=1703724045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3FImOp1PlD6mJ/tb8KDpg5Ogb6PPRfYgAowlA0GnWuY=;
 b=aS2rHqzQ4YCUnxjv9ipwizb/VMyrAaUOjNiK0JSebGIzbbqYsF+alwxbchbRy3QsWS
 HsruI4BJZn9sVej5MRKbXFAx9ea2UPf1dlqapETQlc4ixIbJC6km4HXLHkHZ3OTlf3DY
 66DQLsRP+7jEKjgSBndpN60rCEPVeCPHeCNNzu1i4f+ufyv5TKs/NJ/o3rTnJmpHJYKD
 tZk0sD+ktoe8lEee5xPqTDk1vrhlrzueg9cB7sEbdMvwmSXag0V6iYxE5cqoAQhA2/5t
 CEZ3RWQrNag0OqRvFKuPh/W45FsrpvVuk8RsZlMnDnGl37pDRe7LzoLtKin1QWFvrzp1
 c4hg==
X-Gm-Message-State: AOJu0YzxWoOu8GPm/RXioEerXnHX9ks+iD9nQaEh+olCzhfgHArH2udC
 3mOWRE+EM4WiE9a+gc+Bgb/h1jYwD+13YwneFgk=
X-Google-Smtp-Source: AGHT+IEEsZFjJhTH5fgPIdbgBRNHwJbaQssI/dQ0SSpmLDaN73KqSjuLdL52vyAqDOO8gZFq9lGVEA==
X-Received: by 2002:ac8:7d4e:0:b0:427:8319:16fa with SMTP id
 h14-20020ac87d4e000000b00427831916famr3148114qtb.15.1703119245418; 
 Wed, 20 Dec 2023 16:40:45 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:40:44 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 0/9] Handoff bloblist from previous boot stage
Date: Wed, 20 Dec 2023 16:40:19 -0800
Message-Id: <20231221004030.581388-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch set depends on another series:
"[PATCH v3 00/14] Support Firmware Handoff spec via bloblist".

This patch set implements Qemu-Arm platform custom functions to retrieve
the bloblist (aka. Transfer List) from previous loader via boot arguments
when CONFIG_OF_BOARD option is enabled and all boot arguments are compliant to
the register conventions defined in the Firmware Handoff spec v0.9.

Qemu-Arm platform custom function will load the FDT from the bloblist if it
exists.
Otherwise it fallbacks to get the FDT from the specified memory address.

If a platform vendor wish to have different behaviors for loading bloblist
or FDT from the previous boot stage, it is required to implement the custom
functions board_bloblist_from_boot_arg() and board_fdt_blob_setup().

Raymond Mao (9):
  bloblist: add API to check the register conventions
  bloblist: check bloblist with specified buffer size
  bloblist: refactor of bloblist_reloc()
  arm: armv7: save boot arguments
  arm: armv8: save boot arguments
  qemu-arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader
  fdt: update the document and Kconfig description
  qemu-arm: get FDT from bloblist

 arch/arm/cpu/armv7/start.S          | 12 +++++
 arch/arm/cpu/armv8/start.S          | 14 ++++++
 board/emulation/qemu-arm/qemu-arm.c | 45 +++++++++++++++++-
 common/bloblist.c                   | 72 ++++++++++++++++++++---------
 common/board_f.c                    |  8 +---
 configs/qemu_arm64_defconfig        |  3 ++
 doc/develop/devicetree/control.rst  |  6 +--
 dts/Kconfig                         |  7 ++-
 include/bloblist.h                  | 34 ++++++++++++--
 test/bloblist.c                     |  8 ++--
 10 files changed, 165 insertions(+), 44 deletions(-)

-- 
2.25.1

