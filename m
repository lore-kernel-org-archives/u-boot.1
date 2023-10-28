Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2B0C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 12:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD2E878CA;
	Sat, 28 Oct 2023 14:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fJ71z6td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD45587867; Sat, 28 Oct 2023 11:48:47 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E9187836
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 11:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=deathcamel58@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7c08b7744so22859077b3.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698486524; x=1699091324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6C90npguHgeKnlnIYHTBoRaHFmGIanBv7tr3kbSmAhQ=;
 b=fJ71z6td8q7kAQxHjByjbJMFcv8kA/31nIvBo379KfxYe8N6nGZSAGziXKhucemRqL
 iazJaZPtmUB/oGDH+tqvWJL0S6E0mAO0QRgVK/7qObfBe56w+rjc6tzYzH7v9WA6GSFE
 4B4E/MA3NhrL89PYTEXcLLR9WAQSWUN5Hp7mvcmf+Wf5Xb7uVgyIrVc3BoKCXhhVtl/q
 LHRa5Wt2PVLFM6F4FTBVXh4PzQZ56ZZdRxb3wJH6zsAGbjvrdDtmXhPYL85UvmlZwdr9
 +adEKCb2wNdmtm2ivM6NOnfa5d9UpU1aesbTCHZj8R8zltFkiX1z+d93H5BEZSMAy5RX
 Bg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698486524; x=1699091324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6C90npguHgeKnlnIYHTBoRaHFmGIanBv7tr3kbSmAhQ=;
 b=Yv2fBacvWgkDmikBvqv4QUZItt3k3I2BvBoYvju5Fo5yaghnDXO4Dq6Ys8l7rOatIZ
 0u/FR610d8Kp9s9S5DhjBqnCzP8hyqRUnuPNL7jQKBvdLw5cvrjYdIbshw9ac1kpAQWI
 JC9ibHG2WooLl+sfMqkb6hq6CFodI7AGGZ+BljwzqXE7Jcuc9++s3+REGpasCgT5xdVo
 lpq4UoiStgWLmlGHlkEkADwbQGCLFpBagcGFeBIuOmQZ5w0z83QKGLeBRRefC47DeD4w
 1/G6hXXK86xle8dj/bN/PkZxYCQo6ZgeU2uxCRqSliGsJuH5f5/dEeVaJn6lotHpJBws
 gorQ==
X-Gm-Message-State: AOJu0YzA4UwZ4Scdn35pMz1fRL5mZw4Jq1n7Comca2yr3pOq0PKuWu+y
 z4V1COly7GACpa0O6El/ARqdqTNuHFg=
X-Google-Smtp-Source: AGHT+IGcZ9FtW2IgAStkXfA1ePrUEegV5dXTktZ81PCMXm8ckyfrVlkTUoOUQclCeqIgdjTvQI9Pkw==
X-Received: by 2002:a81:e703:0:b0:5a4:db86:4ea8 with SMTP id
 x3-20020a81e703000000b005a4db864ea8mr4339272ywl.31.1698486523666; 
 Sat, 28 Oct 2023 02:48:43 -0700 (PDT)
Received: from localhost.localdomain
 (96-83-12-73-static.hfc.comcastbusiness.net. [96.83.12.73])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a81a24f000000b005837633d9cbsm1632648ywg.64.2023.10.28.02.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 02:48:43 -0700 (PDT)
From: Dylan Corrales <deathcamel58@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Dylan Corrales <deathcamel58@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] hikey960: Fix 404 links
Date: Sat, 28 Oct 2023 05:46:39 -0400
Message-Id: <20231028094639.925912-1-deathcamel58@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Oct 2023 14:59:32 +0200
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

The build instructions for the hikey960 had some broken links. Update
the links to use new vendor URLs. Also change build instructions to
reference a different file name.

Signed-off-by: Dylan Corrales <deathcamel58@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

 board/hisilicon/hikey960/README | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/board/hisilicon/hikey960/README b/board/hisilicon/hikey960/README
index e1e330d535..6e01862f8a 100644
--- a/board/hisilicon/hikey960/README
+++ b/board/hisilicon/hikey960/README
@@ -26,12 +26,12 @@ First get all the sources
   > git clone https://github.com/ARM-software/arm-trusted-firmware
   > git clone https://github.com/96boards-hikey/OpenPlatformPkg -b testing/hikey960_v1.3.4
   > git clone https://github.com/96boards-hikey/l-loader -b testing/hikey960_v1.2
-  > wget http://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey960/release/config
-  > wget http://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey960/release/hisi-sec_usb_xloader.img
-  > wget http://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey960/release/hisi-sec_uce_boot.img
-  > wget http://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey960/release/sec_xloader.img
-  > wget http://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey960/release/recovery.bin
-  > wget http://snapshots.linaro.org/96boards/reference-platform/components/uefi-staging/latest/hikey960/release/hikey_idt
+  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/config
+  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_usb_xloader.img
+  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_uce_boot.img
+  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hisi-sec_xloader.img
+  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/recovery.bin
+  > wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/hikey_idt
 
 Get the SCP_BL2 lpm3.img binary. It is shipped as part of the UEFI source.
 The latest version can be obtained from the OpenPlatformPkg repo.
@@ -126,7 +126,7 @@ following command
 Now, the images can be flashed using fastboot:
 
   > sudo fastboot flash ptable ~/hikey960/bin/prm_ptable.img
-  > sudo fastboot flash xloader ~/hikey960/bin/sec_xloader.img
+  > sudo fastboot flash xloader ~/hikey960/bin/hisi-sec_xloader.img
   > sudo fastboot flash fastboot ~/hikey960/bin/l-loader.bin
   > sudo fastboot flash fip ~/hikey960/bin/fip.bin
 
-- 
2.34.1

