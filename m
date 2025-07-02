Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8BAC83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 13:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD95882F03;
	Wed,  2 Jul 2025 15:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aNNPtBja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF0182F00; Wed,  2 Jul 2025 15:49:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9151800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae0de1c378fso636817266b.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751464195; x=1752068995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtkH6X0rKvlr7AYqnxB4hT0D4EzDIGE74q5IzdtZQ90=;
 b=aNNPtBjaTFubdZluD2SOnXlg3mOLilRSpOz7eFXpw+Dw1DtEl/S061IPBPCvSEjBhb
 iqDimIo26NYYoJF2flDVANHucGoXgJRVgoJf2SwN1RYrE6JqhAYXe0zjPVDxj3eJM+oy
 cG347cgLyvg0HaDdmE4EKmfolWSex9jkNnykXUMy5lRxkVjheOt+h5TCoC0TEzuxJo8n
 x2Vx4IKgMJrvg0z2Dnd+L5i370KHCSTIn+D/cXwVPTQskuWs5pl+GVISOa2ELLuXx7el
 aCaUeMMc2Hg/3/wWprQ3c0+dcBkpry8957vGLsXTfFbiFJScA4UB3vk3QSQT5ALj6vNP
 4shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751464195; x=1752068995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtkH6X0rKvlr7AYqnxB4hT0D4EzDIGE74q5IzdtZQ90=;
 b=iEy8OCTiOz636jt8D20yTPQRom1KzPewY+0GAfifBtUpXen1087wFjBAkFmxC61sF/
 QjYAtjFqz/mDkSbPcLqO3FoeYrG6S8PwuCd839sje+1ea3E1UoQqoOYo956wfeyG7TIb
 T5ro31eKzCYZxdASkkScR7GeO32nYketqKa/ED7dyxrL5M3JvR0nFkux9VNAz2D+qy8Y
 xrO0KbkGvM2Mi6gT1GAaewuFAmz+yrU5KOIiOW11bDaBcs22Lgug0MQrzaLsxQJ+/5LN
 /pbpbLs57mI73IzOUoWyHQxmLu7x/N8jCLdNL/9QhiHA7Ny0m7h9ukw9c+FysOo9RpHz
 F9wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQBpuEd9sNKQAg/U7r9jCSEKn2aJlTUlWpgCGTrpUTuhr54IPm1mSuyXRkHro03koTXQROC5M=@lists.denx.de
X-Gm-Message-State: AOJu0YwkNWlXRAA9FzZb69UqQfD3/xejq3SyJkd2m/bsqYBiz0D4Y3aX
 ZO4WoT7u83IftqyOgth2BYs3D2a6SuTPgXYukv74VlF1qCOREX3dIVEC
X-Gm-Gg: ASbGncs30uxFmnHjhdOAoTq7QYhPlvgxgT9FH2FD3dvQeTVNrf2AL0tOjbrDlaCGYrS
 cp1fgyt3vTlxEeel8Mh/koA2Tvf1k5gIKDu+x6zPQStDW2Y2KiOQKRUIPBrRYWUmY1ZOBdxXwfJ
 nf+L2DkGav/MruxaAozAYL5kvewD4TtfsobFxJiKMU0a7VDp1QwPW3UxJM5nGBvjHG45TXDp4R5
 JmBDGrVD8+O0ATGU6mJObTprW5tqGTq62qOu0V0YeIzBi8eb0v3+mOfnkMPtCCEN5LosqbxXqI6
 oqXiyZ8hBOS6BVASIhWx0sA9IOBJL/qxa737vhMX7iWVeEs9m0kJBSLii29zxp5rDE8oIlPcOdO
 UoM/sLWs9nn19Bf4VC8o=
X-Google-Smtp-Source: AGHT+IE1qNXE1i03UYS9aXE7SYmUO2Z6Sy92aljvJAzLuly9OVPSaJe5zPPnCEenhoVB7yJB9HEB9Q==
X-Received: by 2002:a17:907:3d04:b0:ad2:425c:27ce with SMTP id
 a640c23a62f3a-ae3c2b52867mr287105166b.2.1751464195048; 
 Wed, 02 Jul 2025 06:49:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:1f00:7f2f:5fbe:4831])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c01bd1sm1101810666b.92.2025.07.02.06.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:49:53 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] configs: verdin-am62: enable RNG support for KASLR
Date: Wed,  2 Jul 2025 15:49:36 +0200
Message-ID: <20250702134942.1483436-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702134942.1483436-1-ghidoliemanuele@gmail.com>
References: <20250702134942.1483436-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Enable DM_RNG in U-Boot to populate /chosen/kaslr-seed automatically.
Enable OP-TEE, which supports RNG, to provide entropy.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-am62_a53_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 584c416bd83b..0b3bb6007ddf 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -169,6 +169,7 @@ CONFIG_DM_REGULATOR_TPS65219=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
@@ -176,6 +177,8 @@ CONFIG_SOC_TI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
@@ -194,3 +197,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_HEXDUMP=y
+# CONFIG_OPTEE_LIB is not set
-- 
2.43.0

