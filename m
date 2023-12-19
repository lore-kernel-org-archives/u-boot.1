Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E500AC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 21:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E48869CA;
	Tue, 19 Dec 2023 22:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OsLAQ6qt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0589874B7; Tue, 19 Dec 2023 22:11:34 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E378B85E44
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 22:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67f645f2e3fso4500076d6.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703020291; x=1703625091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iPiA6+KZdSfnNsJxLX2ZF0ZLJXzvj4dxL8rsufZ/zy4=;
 b=OsLAQ6qtJpFyWDFmTMYHWcwHkNR5OCM51PKfi0abSSe9NaoPzmI7PxtU6ebjtVRhjl
 kMspUdx3BrHnJres1ZLN6SG0GiXPIZQsq1Bxx77eV8rlbD+BIhLiSolN6Hf/ia72t68t
 0m8bIJEUBR0OPxvlYFexgwCprGIZPhUdvjOZxWs1eKQWhyweWHJ54PBUERAmzyETf2a3
 W2H5yBLshS3hCfG+aA1wKct7k94a7BEfOfO4sIh1Q49PsazzmQiryYimu6zix7ZEVJ5x
 ZWHtenp7Wswp5+23HKSubYtlBK762HzIRwVWMbnam35AELmIvb+I1mLRQZMh+szQx8eK
 USeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703020291; x=1703625091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iPiA6+KZdSfnNsJxLX2ZF0ZLJXzvj4dxL8rsufZ/zy4=;
 b=toAgjuHQY0NChHRNvvfcZL8C5j7DvGvVNg6OQ6VPSZ0Qpl/uOuD64maMCcE1gQSO4C
 m5d06ok8bldD5gdvePlQMQhID0nILMA+ULcu0VLVlJkpi3F3QDUjAizNrDnQD3bpTBRQ
 QaiFsejELBS5rvQ6g2MO8noGVd242vOKVuWxwzM27y690D74FIo5pNVSqX6Q+ZLn4s1o
 c74a6+L7VETWVPTPrOaRi+/j9BUfpJ3+w0ExQUwuAAnTLDqBbpIeZna3zwwPmO79weC/
 3YsDQ2NLlmE6O6CiExL2vRf2VSMNgGZM52cXRb8mdWuZnL7ss3RU5UjTbEnLbXlI49R6
 iCVQ==
X-Gm-Message-State: AOJu0Yz6hQSO379IDTUPVaAmLuV/Uxxh8oTC+3qb05EFO9SnMFAzSblk
 lkwwKF9h+PPESUfq1y8XnViI2WJ8JdUWAmNYfhg=
X-Google-Smtp-Source: AGHT+IE3JoAqmhGJxdBTeuoxcpK+TiKSw7vrEtWPU+OynVGZ1WvpWk5YZV1f6//M1Udjgxo6eR58jA==
X-Received: by 2002:a0c:c481:0:b0:67a:d3c4:7974 with SMTP id
 u1-20020a0cc481000000b0067ad3c47974mr19450297qvi.84.1703020291519; 
 Tue, 19 Dec 2023 13:11:31 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0cf38e000000b0067a33133420sm10709493qvk.110.2023.12.19.13.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 13:11:30 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/5] Handoff bloblist from previous boot stage
Date: Tue, 19 Dec 2023 13:11:07 -0800
Message-Id: <20231219211114.393193-1-raymond.mao@linaro.org>
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

Raymond Mao (5):
  bloblist: add API to check the register conventions
  qemu-arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader
  fdt: update the document and Kconfig description
  qemu-arm: get FDT from bloblist

 board/emulation/qemu-arm/Makefile        |  1 +
 board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++
 board/emulation/qemu-arm/qemu-arm.c      | 66 +++++++++++++++++++++++-
 common/bloblist.c                        | 62 +++++++++++++++-------
 configs/qemu_arm64_defconfig             |  3 ++
 doc/develop/devicetree/control.rst       |  6 +--
 dts/Kconfig                              |  7 ++-
 include/bloblist.h                       | 28 ++++++++++
 8 files changed, 167 insertions(+), 25 deletions(-)
 create mode 100644 board/emulation/qemu-arm/lowlevel_init.S

-- 
2.25.1

