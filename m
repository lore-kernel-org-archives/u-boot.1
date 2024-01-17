Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374FAC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4DC87A1A;
	Wed, 17 Jan 2024 18:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="It325kdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3664879E2; Wed, 17 Jan 2024 17:38:33 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D10FA8753C
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 17:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nickalilovic@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7831362c9bcso868669385a.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705509510; x=1706114310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRSAypqqIP1jQMTrlYCO4pCGABYvy6tncIcDPJFqsRI=;
 b=It325kdG6pA1NqSg06hFznaV7fc8Xw2nOV2/aAItksr62R3jJS0RP6RZ1pey59E5Sb
 Tdp1wvZDuzlpEBBkJGeqlmL1fne74IKjlG92mtEvBdpJmP874K/R4Nb5rVBQoaC3cJ/D
 R8vN6BRK0G1daLkG5y7gZVYDRnsqfSqzteht0tdKS8dTD47I8+t/h/sc2KELb4sD2eQT
 rWWJq3LupVOzyGC06vsHkA8UMXNCisxrRa9XY9wNOCNawZ5/Yz4yI0ebzWTpGMPn7YOl
 fW5B3zEhnOViO7spCl6QsqL7hozZE1BsnXRUBf/YYTA7cnb7FKzJn9KEXqTbG77CODQn
 0CLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705509510; x=1706114310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRSAypqqIP1jQMTrlYCO4pCGABYvy6tncIcDPJFqsRI=;
 b=VyKPyZkWsKZ3GLMwQLkLIi5mN0cVXLP4YAz9iMe+j53PcmVZ+fqUkFyjP+ormymEUm
 gHkG1qOmH6qu9qjm7OUPXefwrnPrgqPElSmNu5ZoSXkiLVvk9Iiba3XXTDvTa2QoZc8i
 zq0Ta/8fD3dXb6wwll+TLZczN4z8ISRqFXoUnBeRVd5NfDHOtZYchUW2FJG4EvEagR9b
 6XV76uUjnBeAn2UjOrvSbUl+UR1yckKsMeM2dUolgxmzOINIm5cNQ190EyjMWG6z48Am
 SOrNuknE8jw3g7cE/yZw7GnmpPsh+BW6hjfpP4s0yEgNkE5btzsBUW4fkOPhhmshvjXl
 jjHg==
X-Gm-Message-State: AOJu0YwqjVgqk1O7S+GpujlgjVmTnVZxcOVNAv2IVQiA/WSi2lf6uXdy
 i5Hm2j9Y6BFbznYVcXhHTBdcZwnOFoZH8g==
X-Google-Smtp-Source: AGHT+IGLqFm/gr1s2B4ba7dsGDsf9um5bzuADhUWGl9JQa3AyWkXAal12KAeW00hfqfWuGgt2rs9EA==
X-Received: by 2002:a37:c40d:0:b0:783:53f2:8288 with SMTP id
 d13-20020a37c40d000000b0078353f28288mr7619866qki.151.1705509510418; 
 Wed, 17 Jan 2024 08:38:30 -0800 (PST)
Received: from localhost.localdomain
 (bras-vprn-ckvlon1747w-lp130-29-70-29-79-15.dsl.bell.ca. [70.29.79.15])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a05620a038900b00783237b3330sm4623850qkm.31.2024.01.17.08.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 08:38:30 -0800 (PST)
From: Nick Alilovic <nickalilovic@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, jagan@amarulasolutions.com,
 linux-sunxi@lists.linux.dev, Nick Alilovic <nickalilovic@gmail.com>
Subject: [PATCH 2/2] configs: Transpeed 8K618-T: Add Transpeed 8K618-T board
 support
Date: Wed, 17 Jan 2024 11:37:56 -0500
Message-Id: <20240117163756.63875-2-nickalilovic@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117163756.63875-1-nickalilovic@gmail.com>
References: <20240117163756.63875-1-nickalilovic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jan 2024 18:11:27 +0100
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

This is a Chinese TV box based on Allwinner H618 SoC.

The DRAM parameters were derived from the values found in a firmware update.

This patch will add transpeed-8k618-t_defconfig to the configs directory.

Signed-off-by: Nick Alilovic <nickalilovic@gmail.com>
---
 configs/transpeed-8k618-t_defconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 configs/transpeed-8k618-t_defconfig

diff --git a/configs/transpeed-8k618-t_defconfig b/configs/transpeed-8k618-t_defconfig
new file mode 100644
index 0000000000..7090577199
--- /dev/null
+++ b/configs/transpeed-8k618-t_defconfig
@@ -0,0 +1,25 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-transpeed-8k618-t"
+CONFIG_SPL=y
+CONFIG_DRAM_SUN50I_H616_DX_ODT=0x03030303
+CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUN50I_H616_CA_DRI=0x1f12
+CONFIG_DRAM_SUN50I_H616_TPR0=0xc0001002
+CONFIG_DRAM_SUN50I_H616_TPR10=0x2f1107
+CONFIG_DRAM_SUN50I_H616_TPR11=0xddddcccc
+CONFIG_DRAM_SUN50I_H616_TPR12=0xeddc7665
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
+CONFIG_DRAM_CLK=648
+CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_AXP313_POWER=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_AXP_DCDC3_VOLT=1360
-- 
2.34.1

