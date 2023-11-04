Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A707DC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 21:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0977786FF4;
	Sat,  4 Nov 2023 22:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RpbPFXdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07186870B3; Sat,  4 Nov 2023 22:52:51 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FAC86053
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 22:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3593f3ef420so2185305ab.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699134767; x=1699739567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P888Z8YXSifNT3WnhQJKmUVKjlQjxCIt/hfQBQkUlmk=;
 b=RpbPFXdYDCaPIrcfTlZoMMeTOEFIcbFvKD1iPuOfOYqweK6YxK9pyyQiC+4dl6vo6l
 OHQ2kVahYD6/1BHyvSDKx2nK9klkcW47PIGn20wH3Fq6uXSEbAcJUuLMwdiHUIX8G7HP
 NxwLWPo+aX12uvF9y1hN19IPHjRoW/GerZFTBIZazBfyS43g4Nz5bp2nNxg6ap5H2caD
 MPFi2vaZhgKUZhJ9hSeocNg1WVGMfQBi3w4CIf0VFRoCxAj8Lr93BQdoIWYykVjwZMEG
 zJN75sq+uWzd0aIhLpkS1Jb4zdF1es7lbUyFXbiLVhG/q7j67SdACw1ELLC28TZd01SJ
 gPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699134767; x=1699739567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P888Z8YXSifNT3WnhQJKmUVKjlQjxCIt/hfQBQkUlmk=;
 b=ogDxkbD2ETR1s7cf1KksIUlVpn21DpSafcyCWvKwmCBTyiLU32o2/uiCwXAkwcfrda
 073WBuCkyIMcb9ZvrKQqMrtElbnyynAuXw9fmu5F1MzSss5k6u5Vc4apNmd4PVavVwBK
 zw2c3RviGVsAOVYkl2DQ+SM3ljOnIF5Gn056MLGraCsgWsh1980JzfZMGUe6e0VKK6IG
 KkK12obslgUrllS2KKohymPXZ4RpPp6kX6C4kDTujRVAh2r2nuq3/FMjJbPAFKdmIVRn
 k3ufby7HfKoviG1cLf0rsAwzoc0DUMT+4gw/15HSuyAjAQZI503nDDxQINTAUuQOJkId
 uVXA==
X-Gm-Message-State: AOJu0Yz18QTHOAEplMu3ccFm4npVUfIpdghIdCCDsDYu93cPZNf6v/nS
 bngzJrVfMJHQfzlmR8iVdH0=
X-Google-Smtp-Source: AGHT+IGk83CxVbUbNc8JNfloKRQZ+q8agyp+HFSlQhwNedlFD5ROmeOgOW8Dimez4Jb+q1vjsCuWOA==
X-Received: by 2002:a5d:924a:0:b0:7a9:7aa9:c175 with SMTP id
 e10-20020a5d924a000000b007a97aa9c175mr27119941iol.1.1699134767404; 
 Sat, 04 Nov 2023 14:52:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b4e9:3424:1f72:d6d3])
 by smtp.gmail.com with ESMTPSA id
 o68-20020a257347000000b00da0abddeb02sm2239669ybc.34.2023.11.04.14.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 14:52:46 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/2] pico-pi-imx6ul: Connvert to DM_SERIAL
Date: Sat,  4 Nov 2023 18:52:41 -0300
Message-Id: <20231104215242.310349-1-festevam@gmail.com>
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

The conversion to DM_SERIAL is mandatory, so select this option.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None

 configs/pico-pi-imx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 1eee1e6c2ff5..3af968d55128 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -70,6 +70,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
-- 
2.34.1

