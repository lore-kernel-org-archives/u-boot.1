Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE83C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E448869A6;
	Mon,  4 Sep 2023 15:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DNIO5Ae/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C694086741; Mon,  4 Sep 2023 15:24:56 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F58868FC
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 15:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a7ca8720a0so1082029b6e.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693833892; x=1694438692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8lslPRVfm6NTrysKbeVryJoeyX6XdYBTHhF5A4Rq53o=;
 b=DNIO5Ae//PrEUkERafjNL0RWwfVaaQPC3vT5XX0qebDPkbKRdjR+5jKL37Ly5K7eER
 nAaSxQWhmKyt7wQC2rjMVvb3eCgwd9Z9jy+5b3pUW3J6neNMFh6zh2v1G7UPoUhaH0GZ
 rKh/tbSAFfUHuHX0q7dXGbmgDZSEN2/yD4cyKK0UF4aYtPVsAnkUHgPClBYwHk8PXix/
 ollZJziwsaMqfkZ7qOQtxFX9kiu+cgKCGGLilwSzMBfKvAjXwZQgs6PaHHuGpb1Dlmge
 5xdEpUTm902qJ2ueVf5Iwks+YhMFd6hDfQ5nr/tAz6RXPL+SSi2UXQSnN2GCJk0X1/Ns
 MS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693833892; x=1694438692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lslPRVfm6NTrysKbeVryJoeyX6XdYBTHhF5A4Rq53o=;
 b=aid9AzQHCUAcETVOkBSxvBQif6qIYmZYshvoXcxSpHi4ifVYBdB6wryEOXyP6qGcep
 4WXbzC3sK/Bh+hYUZBJgSaiwamdvJN7zqM4qxyHIl/zITIHyWF+4WQNj3Ch+Ot8m20Dx
 sBM1MlLJxsp7Gt8Sie+buhXel6CxNQXAgYiGPY6jcQvNmEoIWDRMGASDPHfpp5yc/JGv
 osyyB0Tj25jL0q5CwiXbE27JivhEIxI3gSviwbPp6eRj/k7nc6KTU4StWKNhrMtY85Ge
 3pV/DuXFGxdGwr5mdsK4qiu/CL2anZkVPAzSEmNu4AN8XGnfqiP8/2QR+iWOlOGQD4vI
 H1dA==
X-Gm-Message-State: AOJu0YyCcFFixy+jL1SgWHIPpe1OyLa9a7ItFsm5+Q1dF6CLVTx5GqgC
 zTfupxbVQWWyCm1enGjeM5A=
X-Google-Smtp-Source: AGHT+IHdnP7dPCP4zSe7T9UfVrDq4rqcK/nXAeFQhXk5u3Nx13E6J9EPFhxSUm4rGmFKYRYIJVfZEw==
X-Received: by 2002:a05:6808:192a:b0:3a7:72e8:2728 with SMTP id
 bf42-20020a056808192a00b003a772e82728mr13811097oib.36.1693833892703; 
 Mon, 04 Sep 2023 06:24:52 -0700 (PDT)
Received: from debianfranco.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 bh37-20020a056808182500b003a368f3e0a6sm3934879oib.3.2023.09.04.06.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 06:24:52 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] verdin-imx8mp: drop unused tdx easy installer ifdef
Date: Mon,  4 Sep 2023 10:24:37 -0300
Message-Id: <20230904132437.36435-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Sep 2023 15:58:13 +0200
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

From: Hiago De Franco <hiago.franco@toradex.com>

Drop unused code related to CONFIG_TDX_EASY_INSTALLER, that existed only on
toradex downstream branch.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 include/configs/verdin-imx8mp.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/configs/verdin-imx8mp.h b/include/configs/verdin-imx8mp.h
index 942081ab84..d980bd66ae 100644
--- a/include/configs/verdin-imx8mp.h
+++ b/include/configs/verdin-imx8mp.h
@@ -36,20 +36,14 @@
 	func(DHCP, dhcp, na)
 #include <config_distro_bootcmd.h>
 
-#if defined(CONFIG_TDX_EASY_INSTALLER)
-#  define BOOT_SCRIPT	"boot-tezi.scr"
-#else
-#  define BOOT_SCRIPT	"boot.scr"
-#endif
-
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
 	MEM_LAYOUT_ENV_SETTINGS \
 	"bootcmd_mfg=fastboot 0\0" \
 	"boot_file=Image\0" \
-	"boot_scripts=" BOOT_SCRIPT "\0" \
-	"boot_script_dhcp=" BOOT_SCRIPT "\0" \
+	"boot_scripts=boot.scr\0" \
+	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc2\0" \
 	"fdt_board=dev\0" \
 	"initrd_addr=0x43800000\0" \
-- 
2.40.1

