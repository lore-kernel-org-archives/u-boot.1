Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D039DFF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE3383FDB;
	Sun, 26 Apr 2026 15:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="R7rPr8D0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89228407E; Sun, 26 Apr 2026 15:57:22 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDBB83FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 15:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so121837685e9.0
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1777211840; x=1777816640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwUSqUqvxScCTp/sYtd0ZKNAQ0I4Rwbbyh86gDbXBz8=;
 b=R7rPr8D0KLXXA8jhruu+ZpdKEWLMBR3GZeXca9m4LOH2MSUZEMzAPon3E6cEIgN34J
 u4hWCYwMRMBGViuCESd9Lp5V9AWcqm6H0/nh/C1iz0dQXzZ/nYFe/24A+NhBFum1BcF8
 6t1kC7gOLPoaunFJB2p/cvOxsv7fOZUXDvjeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211840; x=1777816640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CwUSqUqvxScCTp/sYtd0ZKNAQ0I4Rwbbyh86gDbXBz8=;
 b=VnulGerJE2NDtWQyiPrs7bRw+ZtXlJSQrmL9v4r+Sw2PpL0vATFt60AXU0KVCjJg9s
 yBxkeTyb+S2yZH28raMGPrGL8NXQPoI9Jy9kyyPZVVQHRQKWS+5gEq+6o2JXSd+J/wIm
 TW1ox8/yRDP0ISRLS9cLIfOxE9BiX7Z9HzWd088nT0JSyQ2zdMsNFZIPrRlUrqDhE97Z
 Ys73wbhtOAzHcVvL6Mvrqd4y25C4Bbllor9/eWnEpJcU1I/NDc7voegXABfxusgSLivD
 LHECt4IjtvCtRHCA9LOsh14Gabb1YitkIvGEWJ3oCmIY2bVKJYv+Jyw55UCbcqZVEXnq
 0+eQ==
X-Gm-Message-State: AOJu0YxG4jSU16IOKeyuC5J5fn+slvf6wRdIwdFBnfAsmDGRo+1YXdni
 X2C/pm4BwaJeJeYGg4xTGOmMljFwPtKIdgX4I+uDytNILhngQjO53gc1I1l7pe8dtbORMtStGhw
 Rt9T/gUU=
X-Gm-Gg: AeBDiesppTE+5sLqXTkQcVnen2FLFurV9M0KAyipY4dMHICRHMa4OLpv1gh8kzQJgYp
 RySEA5UPYKFDRCGtWIzL8uGlrpJ7BA5E8phcL540uSFoXJLdF+7aP9XQTH5KZ5sEk9V82yvXahY
 dKeqrAmZlxUpvmcf//UoUOWY7ur3gKYus1R/XQJF75k8Ll9rZlR3Tmaxmf60vB/7PZdOzIVzScq
 XXZ1ZW8R5ecI04JyJWxKumBnx0iKw/utXZs95cuhhoGc/YOn3U5xXxjYCblA0G+hS4FG0ljy/Pw
 ONe2R9Wht0OhxYIqsgjmUrzPYiFQYYsD4jQgXWTa6Q5mISWofzKDkOu0yOCCzA7cooYviTmJUvm
 FhaRZGiOViCLJMni9ANBadnb0IPXb6ipU3ox96IB4z3Y4bmmrFewzPST9JZ+WTTV+2N3ARGjxj+
 KrswZZJ+JsoKj7kil7XBNJOCTlN6haD1XcU3OvCrVYxoHdxRaYGWbkwfKNUyE5FU4GWbDEPGRyQ
 VNNB840sH/6IE8t+bkohMYQ3EkPLBxxXmXS
X-Received: by 2002:a05:600c:1549:b0:48a:761:5808 with SMTP id
 5b1f17b1804b1-48a07615c09mr368985605e9.0.1777211840462; 
 Sun, 26 Apr 2026 06:57:20 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr.
 [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a682588f8sm119035785e9.10.2026.04.26.06.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:57:20 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: nm@ti.com, robertcnelson@gmail.com, Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 2/2] configs/j721e_{beaglebone64,
 evm}_a72_defconfig: enable UCmd for snagflash fastboot-uboot
Date: Sun, 26 Apr 2026 15:57:15 +0200
Message-ID: <20260426135715.1395250-2-romain.naour@smile.fr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260426135715.1395250-1-romain.naour@smile.fr>
References: <20260426135715.1395250-1-romain.naour@smile.fr>
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

Snagflash fastboot-uboot needs UCmd in U-Boot to work out of the box.

Further Snagflash support can be enabled using a configuration fragment
similar to am6x_a53_snagfactory.config [1].

Tested on SK-TDA4VM.

[1] 948ccdc82f594c1a76ed97a2adee55b21097f03e

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 configs/j721e_beagleboneai64_a72_defconfig | 2 ++
 configs/j721e_evm_a72_defconfig            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index abb53687ed6..76dea45ace2 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -98,6 +98,8 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
 CONFIG_FASTBOOT_BUF_SIZE=0x1c800000
+CONFIG_FASTBOOT_OEM_RUN=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index dac1c5ec82f..b12941f9c49 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -105,6 +105,8 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
 CONFIG_FASTBOOT_BUF_SIZE=0x1c800000
+CONFIG_FASTBOOT_OEM_RUN=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-- 
2.52.0

