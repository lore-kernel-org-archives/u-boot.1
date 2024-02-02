Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB46C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F71187BD6;
	Fri,  2 Feb 2024 17:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SsFO0mf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3454487BDC; Fri,  2 Feb 2024 17:04:16 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BA78791E
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d748f1320aso2682475ad.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706889852; x=1707494652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t1FsDmAF2QPYijV9s842Wj9EyfI5HO+HEqpX8JqtCMw=;
 b=SsFO0mf+9fR/WKuGY5rvcGSweg6u4wxb21oki8m/whCmw4Hc18XWsbOnDVBzZr3Qez
 WK9Dg0PSxrNJeQpfFcHEWrZAbwRKh+MQWyTt3DvybIsqC5PmSxyIYUAg2QJu4BLJy1t5
 Vgv7Mec0ZP14ID/0bhY7A1cgdmCpujGxGi2eMRDaL21GND/fnWCEzZH1o5VmdMc8IbMX
 ipsvpcy2FvwucYZsJ2dv21s6AA+L9RlmMXvCGkxg5WasMPrO74YikI/mRo7mgKDtgNCG
 D50CepWIndQey/HSbx1YqdRGb1AUbEzN76ZhYDd5s1jFoXOTNQDQeBtM3OdXd2nmRuqG
 Gztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706889852; x=1707494652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t1FsDmAF2QPYijV9s842Wj9EyfI5HO+HEqpX8JqtCMw=;
 b=jTJACPN16cK+2+XafMyw+OTDL3YGy2X64u9anaOofIC7nPE82lzVEVgwMKwAb8ED9g
 I92IIvB2MlvtXT6+5rEit3h78GT43aVz0wkCivsKK5jMZLebrqZP9VimDQmIpomxckMR
 LKyE3vjPHxCdVRtaLh/c80sw+Ppud6ukmbuL2REcS3MtMn2KdsWTmWvVr1SGxwLpO69n
 zrjMXpowKqnMsZSt+DMp96TasLIENTRFTqIrBmG4wR9RSIlY9HvFCxUh0DG6jzV+45ae
 JFBBwa7mjHR/wl8gCU4nhGxYTB73Ni7hdj7OclRmTfWgcFxjD5QqCGeo4sQB0MKR9AVb
 oiwg==
X-Forwarded-Encrypted: i=0;
 AJvYcCWdB1vAkx3UxmocI/bnRD7ydYsBOXHffB8DO2g6S1VSFP0ZQ3wr0Prkf5m7bnPRCjMC8fQUrwsQtCnN8k2ynj6HBayDfg==
X-Gm-Message-State: AOJu0Yze2P6qPb+heSDEG9AfTB83KDcF0U9Ps/Uxm+6XyOPjGgbooMb3
 qAXFPKd/rHvG0R363lgtA7XdA9sBxcBNbGrsiRAdOIuGH1ggpUKHpKWx6ZwP
X-Google-Smtp-Source: AGHT+IHHolLFdFlZ4TLoF78iG+XxGUHK2Tjx3IHyaDKlmWpYqyOAnJskbTOa1ZE0g4pbrGEajKBXKQ==
X-Received: by 2002:a17:902:ea82:b0:1d9:61ef:1876 with SMTP id
 x2-20020a170902ea8200b001d961ef1876mr4032282plb.1.1706889851945; 
 Fri, 02 Feb 2024 08:04:11 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVH6zhWMzryxGFP9GZpb+4JrAuXdWsvlyw3l8dHSA/OyW/rZqoAsdG56yYfBs7BhGoobICtkeJz6zIiwMVM9cpxJivp0hJn1SmZLGaqRAh+tPHt5nN+Tat/Ib6eMNCuGoIbi3AlPEWdcS63
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fa09:d56a:f130:f280])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a170902b7c400b001d8b8bf8e44sm1780086plz.92.2024.02.02.08.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 08:04:11 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de,
	trini@konsulko.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/3] mx6sabresd: Fix U-Boot corruption after saving the
 environment
Date: Fri,  2 Feb 2024 13:04:03 -0300
Message-Id: <20240202160405.4126192-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

U-Boot binary has grown in such a way that it goes beyond the reserved
area for the environment variables.
    
Running "saveenv" and rebooting the board causes U-Boot to hang because
of this overlap.
    
Fix this problem by selecting CONFIG_LTO so that the U-Boot proper
size can be reduced.
    
Also, to prevent this same problem to happen in the future, use
CONFIG_BOARD_SIZE_LIMIT, which can detect the overlap in build-time.
    
CONFIG_BOARD_SIZE_LIMIT is calculated as follows:

CONFIG_BOARD_SIZE_LIMIT = CONFIG_ENV_OFFSET - u-boot-img.dtb offset
CONFIG_BOARD_SIZE_LIMIT = 0xc000 - 69 * 1024
CONFIG_BOARD_SIZE_LIMIT = 715766

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Select LTO. (Tom)

 configs/mx6sabresd_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index a90efe4a7786..d4fb55622cf1 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -21,6 +21,9 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_PCI=y
+CONFIG_LTO=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=715766
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
-- 
2.34.1

