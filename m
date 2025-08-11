Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101CFC87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 12:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58702832FE;
	Mon, 11 Aug 2025 14:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqyhwrAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F648331B; Mon, 11 Aug 2025 14:58:05 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 074108329B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bc61152d8so3558807b3a.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754917080; x=1755521880; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ypY9+0z4ajAjEu7Amojg9qJyiKH6ugKSPXm5TZduQew=;
 b=AqyhwrAJPuoJ/8WlS97j5ssClQSVvBGT3jA5Q3/RRXSR2iW6BufPFgXICX+3jIUDDT
 iGjErz/bOsY+oc/JIaGM0a4yESqIhuDbTJR39kb5iT388gJPQ2ujXKB7bRQqNzSu0IXh
 tfxFRaMR/8RwRpoFaS8i+oYAJ2Q0VB7qxqAuGu4C8vir5/Skw+uBXKsYu6fTtTJ88mWf
 JLUzBdrT7bsoxG9KCPf9c2Y4djicYLHIIMI6PDcEvnzRKSrrOEnSInNpg27L3qlqejzo
 uaFzB9bU4/2kAnAGaltRrYP9Hv49fQHfG9CSapeWT47BO45XQtvjaBL/A7Q92ySrxbKN
 nAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754917080; x=1755521880;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ypY9+0z4ajAjEu7Amojg9qJyiKH6ugKSPXm5TZduQew=;
 b=Eh0X6WPCvCHMpGwb9n6tDJMGy6a2GIzOdzVggIbZzxXo8h0Aam5y+16DExTr9gPe1Z
 Z3+4DCIeu6N3yyKXCFwd+JNghuO0azOtfWSXfYPTwjvPxhqtEmUtd2N0jInQ8pVbTyCv
 fJe/RCifSYhqtKKDGKZ0qfnwXkkPT4XpVN9vzkfnBbmKXHV+dz9e8fBDA16xaE6nFS5O
 8ZrqqJUghmAUJdqBz5JTth0jq7YWL3xtvhvqKN4x2n0E3vt8UnF5Bx+SeL/bpctuj+0T
 JeieEZYhwFqC8rZKmweG4fR8d6KWrbXc+RVUhjl/BDI9gTuUD5+iw8hjqTpbAy+VCf8g
 bYeA==
X-Gm-Message-State: AOJu0Yy3SFfeJ7aHUW+cbaf1QCPToIkXnAQpkwFiEd3Rmw3vWnk3D5Wu
 J3gbW7Juwa3RfBxgdZeu91ixk2GD66isRd8KUlhQaUm9W0QAkcD5CDAs
X-Gm-Gg: ASbGncuMM2bwdomh7cm9FcdsK+sQ7wconNeWCq3tYjaHICkzfjA9iL4u5LuO5HO2sOQ
 CdrBJ+6IwSXsLahE/hH1bbDALGrvbqxlAv+Ube14pp8owMA1GRcfk3VHbs/u5LSovVmUfoSq/HZ
 rxvp9DimMIVI5wsVuE+mZqJg4emmr+GBielC1sQ5Wq7nHhWRJzWzlr8FLjk1WZ1wr2FOq7ChJXU
 SyX8bVIWrAzAK1K43lMAQHmUuVtWwwcGociC1sYXHyVtVLM35HmVj6auqBqAZwzgeFim+tCzLe1
 Q9dJhz+IRWgeMpQ32DUodwX5KB9hHxl7F9V1o0mHq0rYflctPypDs1ezBLjEUigmG4kIBdQjpBA
 rqfRn1mcZmff5COghxb3kP/xwtEjbOY+SGQRjoADN
X-Google-Smtp-Source: AGHT+IEOZL6pMa2Ylzk9yiGc5prFuL6MtRPyxNe1TDEmGCoHmQTiIV01T/uohhBJ6AKxaCeYItu0xg==
X-Received: by 2002:a05:6a21:32a0:b0:240:1a3a:d7ec with SMTP id
 adf61e73a8af0-2405501258fmr20314048637.4.1754917080442; 
 Mon, 11 Aug 2025 05:58:00 -0700 (PDT)
Received: from [192.168.0.7] ([2804:14c:490:1191:2ce:dae9:57a1:9602])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4683722179sm3237560a12.13.2025.08.11.05.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 05:57:59 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Mon, 11 Aug 2025 09:57:50 -0300
Subject: [PATCH v2] arm: imx: imx9: soc: Fix env location when booting from USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-v2-fix-imx9-usb-boot-v2-1-3d89974e2881@toradex.com>
X-B4-Tracking: v=1; b=H4sIAM3omWgC/4WNTQ6DIBSEr2Leuq+RH6101Xs0LkSwvoViwBIaw
 91LvUCX32S+mQOC9WQD3KsDvI0UyK0F+KWCcR7Wl0UyhYHXvKk7xjBynCghLUnhO2jUzu0ou/a
 mlBKyFQaKunlbSufssy88U9id/5wvkf3SP4ORIUPVSCEmYXTHzKP4g7HpOroF+pzzF+vCTWO6A
 AAA
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

