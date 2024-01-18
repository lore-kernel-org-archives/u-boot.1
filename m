Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1676C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A052E8718F;
	Thu, 18 Jan 2024 18:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CfzLUAis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434AC8746C; Thu, 18 Jan 2024 17:45:49 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA2986FB2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 17:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nickalilovic@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bd3b34a58dso6004013b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705596345; x=1706201145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDom8L9VDnYHqI5K+aoFC/YHjBAnOJZUuDNfeK2VNa4=;
 b=CfzLUAisBUKv9QOvg1vOjVHvPemNbmhIToEmGsC39RgqeUzuNoKHoobgS3o0Al+6gW
 3YXfII2WwAz2SXssoWrx4lX1pnM3GmhbN4X3XEQClMvZxHvEVy9V2OQ7gR8ui+7m7TQ/
 aGNQhokp/3aths/SrCWZeW+c7DOlTDM/f6xBJHoSsY01UIv6X6Kg3C4p1dLxqexeZkoZ
 P8zYuEumXKgaMzhSnj1uEisPP8a9pEv8DUX2EbGEBn151XbrMeXsBAz1AnXvcEN0nsc8
 mGRhBahO2aax08FmV2+lR6ZncjbDsgc/X+OZ/uTDADRt1PRodg/yhdtD3g8LjTKBnID2
 JHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705596345; x=1706201145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDom8L9VDnYHqI5K+aoFC/YHjBAnOJZUuDNfeK2VNa4=;
 b=etCpOsEBgKpviXNO3umqgU3uk70MG9s3RZvb8c9Ys5DaReNJqJNrSqiKaTXXon9ipG
 24dNAhzyZrUJbD28FeIJBcXvfJn7aV7yxmK4ZhLIeA8RtYeo8s93dUXbrQyGb94EmTK3
 f7mtlVTpYHreWXSQxdF8/I9zWbUh9wSWe7anUU3uTlVgZFppvC5vspOtA/dVpbmYXUvj
 lik5gMDX7SdQ/jKBoLAmvGTlWZmh7xWvdTX9+F8Jc/ED2aoBxt+xmA7n1KKcXJSWwV8U
 ISPP7Mfy4xgIasEeaz26jp5ik/le+Asn96gGA4Azelfzz8mYwTpDL9wM03YsprrBWhe/
 P/Vg==
X-Gm-Message-State: AOJu0YyE/18gvbHMw8Knk4EYEgjwJeBqE2FRUR+S7W84+wdmn+yCYzbX
 wwiqleIdv/3MlpEd6p8OdtkssmxPkWEF2G9oWsYYKmP5zb4AAhQcDDe92mleTbA=
X-Google-Smtp-Source: AGHT+IGXU9inyXThAEu9ZpnRDVHEkzKyma31neCiRGv0zOAkseGzHvKeOcuiB5LA1r4Pc/BbYXQmNg==
X-Received: by 2002:a05:6808:14ce:b0:3bd:941d:9c36 with SMTP id
 f14-20020a05680814ce00b003bd941d9c36mr1505985oiw.70.1705596345143; 
 Thu, 18 Jan 2024 08:45:45 -0800 (PST)
Received: from nick-Inspiron-5680.home ([70.29.79.15])
 by smtp.gmail.com with ESMTPSA id
 vv18-20020a05620a563200b00783574d5017sm3627368qkn.19.2024.01.18.08.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 08:45:44 -0800 (PST)
From: Nick Alilovic <nickalilovic@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, jagan@amarulasolutions.com,
 linux-sunxi@lists.linux.dev, Nick Alilovic <nickalilovic@gmail.com>
Subject: [PATCH v2] configs: Transpeed 8K618-T: Add Transpeed 8K618-T board
 support
Date: Thu, 18 Jan 2024 11:45:08 -0500
Message-Id: <20240118164508.43617-1-nickalilovic@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jan 2024 18:02:23 +0100
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

Signed-off-by: Nick Alilovic <nickalilovic@gmail.com>
---
This defconfig relies on the synced sun50i-h618-transpeed-8k618-t.dts file.

 configs/transpeed-8k618-t_defconfig | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 configs/transpeed-8k618-t_defconfig

diff --git a/configs/transpeed-8k618-t_defconfig b/configs/transpeed-8k618-t_defconfig
new file mode 100644
index 0000000000..020d3974af
--- /dev/null
+++ b/configs/transpeed-8k618-t_defconfig
@@ -0,0 +1,27 @@
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
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_AXP313_POWER=y
+CONFIG_AXP_DCDC3_VOLT=1360
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.34.1

