Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE50C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 12:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 793648329B;
	Mon, 11 Aug 2025 14:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afFzyhW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C5C832BC; Mon, 11 Aug 2025 14:48:07 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835AA83291
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso53448865ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754916483; x=1755521283; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ypY9+0z4ajAjEu7Amojg9qJyiKH6ugKSPXm5TZduQew=;
 b=afFzyhW69KHaiNeuDlhu5YA5slmhL4VL9O/4ak3Y+w+tWE0OK9Dego5BSk+IVNT96L
 6p6S22EirqIwxqzo5hIk8Tx/d7T5ZUzXtCBGYQDaO8/CqwfSJ6oPjXbRaerQQJ+2CfIK
 h2a8gdQz386S43c1VrYfs/x3KLw/FPFdPyvo63oicb81fWMn4EMKi4iH8MRbTVsmCsPK
 0vlDRUoMQwxUFr+P5fpydWn1WmawrA5z43+tW2uVJTc5VpOGoVbohYsT4EHtfqx1NvDG
 UZgUK774Cp9UzCGrsHXN6MDTHJv+d76LB0miRR/bJ51MJjkC3NYgmpSZYNpKBQEv4C88
 ToDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754916483; x=1755521283;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ypY9+0z4ajAjEu7Amojg9qJyiKH6ugKSPXm5TZduQew=;
 b=r87flaNjgGMkbjNmSAePwOwyqew9YjAMiusSTBwDjn0fyc1Gpr1vrs2AjPDw2oSj0/
 1cSO1qVyQON1C1pFJciC/myWE1NhoNgkT6EZyWsNFkrm2/Wa2mRA1sVGQLbjyEprhmeI
 OWoIb6ESy+Oj43aGQvQVkv/8ce3OGoAPSenilLDSdVneSUhl6eZxAUnJ+jdt38WWzWxY
 IMUZZQhaosw3KMI7ZAlCctZe/hsv2Slvgbj5C3RQYHssZN4177toc4M9PES6GAYo30jw
 WRUQo3TxDOatzd5LOPUrL4dnMkx8bn6k6Gyx0BItwCHO3Yb3gnnOO3FmEysNtq2I7EM4
 EHag==
X-Gm-Message-State: AOJu0YzlUOdP0zAxQMoKQ1uwIkaw4Pv9jE5EuVfadPMJ1friPruFXeE/
 boQTDMduAXDwG1H4xdlhjGbcpnOiqWqXJ6tPmYJyXGbXXm61w27csngj
X-Gm-Gg: ASbGncsHqUXk6OtOkkBrYBX5QPc/511Dav2sN7mM9UJs4/L5PToJJ8I21guDqsxXUTh
 mAm7A0SPFTdMK57tABu4tPmUsK81ZNl4N4aN7U1JrOkwT49AD6Z/L5bl9a4qMY3wANdDpT4P/r0
 IuKpCswnEuvTETvCtsMtyLsdEX2Mxr1cz1YvxuVlqyoiZckdLJQ0UtiL+RPcg2waQub8qX3Kbl6
 4X0KfH5U+rYPlwtX7UwRmvewawFWiwlljnc6VV4WmVzFCeDanyWylu36JTWNsqNdevPmhxtSr01
 dd6NQPriSEY+YEjlTX2Oiu3Hw518as/fZHfnZ551JdLPEIjuuTvZze2CJe6BO1RvOyCiy/qIlNZ
 P2JyAISbNgXOXA+xXPoemb8Y6IO38F+NXg71AZVfglBDncg==
X-Google-Smtp-Source: AGHT+IFicrJBtfk4BxeUeYB9FNn/VLiLtobylWjT4Fix43DTRhkTGFkRDu9QX38TgYkYt+0uUhxEhQ==
X-Received: by 2002:a17:903:19e5:b0:240:763d:e9a6 with SMTP id
 d9443c01a7336-242c204f625mr168033325ad.25.1754916482954; 
 Mon, 11 Aug 2025 05:48:02 -0700 (PDT)
Received: from [192.168.0.7] ([2804:14c:490:1191:2ce:dae9:57a1:9602])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aac4b5sm271893245ad.169.2025.08.11.05.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 05:48:02 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Mon, 11 Aug 2025 09:47:57 -0300
Subject: [PATCH] arm: imx: imx9: soc: Fix env location when booting from
 USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-v2-fix-imx9-usb-boot-v1-1-95433f3db81d@toradex.com>
X-B4-Tracking: v=1; b=H4sIAHzmmWgC/x2MQQ5AMBAAvyJ7tokWpb4iDuhiD1RapEnj7xrHS
 WYmgifH5KHLIjh62LM9Eog8g3kbj5WQTWKQhayLVgh8JC4ckPeg8fYTTtZeWLWq0VqXlSoNpPR
 0lKR/2w/v+wGZgCZwZgAAAA==
X-Change-ID: 20250811-v2-fix-imx9-usb-boot-48679993463d
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Mailer: b4 0.14.2
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

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

On i.MX9 platforms, when booting from USB, the U-Boot environment is
always assumed to be in RAM. However, this causes the boot to hang when
`CONFIG_ENV_IS_NOWHERE` is not enabled. The boot also hangs even if the
environment is present in another storage media (for example, eMMC). Fix
the issue by correctly handling the U-Boot environment's location when
booting from USB. Also for i.MX95, set the environment location based on
the ENV config and not solely based on the boot device type.

Suggested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
v2:
- Changed the env location order on USB boot to maintain current
behavior on i.MX9
- Applied the fix to other i.MX9 platforms, not only i.MX95
- Added Suggested-by: Frieder Schrempf
v1: https://lore.kernel.org/u-boot/20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com/
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 13 ++++++++++---
 arch/arm/mach-imx/imx9/soc.c      |  8 +++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 13f13ca7d1056ac5a9f1b529b13e0d8dbe2462f1..f973652d0cbe8723b0cdc1a6235fbdd719146065 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -635,7 +635,8 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 	switch (dev) {
 	case QSPI_BOOT:
-		env_loc = ENVL_SPI_FLASH;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+			env_loc = ENVL_SPI_FLASH;
 		break;
 	case SD1_BOOT:
 	case SD2_BOOT:
@@ -643,10 +644,16 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	case MMC1_BOOT:
 	case MMC2_BOOT:
 	case MMC3_BOOT:
-		env_loc =  ENVL_MMC;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+			env_loc =  ENVL_MMC;
 		break;
 	default:
-		env_loc = ENVL_NOWHERE;
+		if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+			env_loc = ENVL_NOWHERE;
+		else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+			env_loc = ENVL_SPI_FLASH;
+		else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+			env_loc = ENVL_MMC;
 		break;
 	}
 
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 9fb82644f126b8717b2f2ba1c9e77fb75d2e7757..3f7dafdcce5d3c6df102fe0a2a5d0b61c394937b 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -809,7 +809,13 @@ enum env_location env_get_location(enum env_operation op, int prio)
 			return ENVL_FAT;
 		return ENVL_NOWHERE;
 	default:
-		return ENVL_NOWHERE;
+		if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+			return ENVL_NOWHERE;
+		else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+		else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+			return ENVL_MMC;
+		return ENVL_UNKNOWN;
 	}
 }
 

---
base-commit: b6e2cfca1a6fd10c8f12016a40d690d2ec61796c
change-id: 20250811-v2-fix-imx9-usb-boot-48679993463d

Best regards,
-- 
João Paulo Gonçalves <joao.goncalves@toradex.com>

