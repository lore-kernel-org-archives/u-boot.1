Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C7C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 21:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4AD87A9F;
	Mon,  8 Jan 2024 22:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DgeY3yP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA60987A9F; Mon,  8 Jan 2024 22:11:52 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95CD87A46
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 22:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cdf90e5cdeso291346a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704748309; x=1705353109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+S7Zi86W+AX+v5AQNZPooUlGA/2kVfinAuIGj+HpK48=;
 b=DgeY3yP1nh7x133367BqI5mpQ4+liUfkh8a4dm6R2OxuQsyA8ghkOsUe60qCIOu+6g
 1XpMLJHkpSojZEuGD94gu7HoXRiJEWSNdbDGddXsT9K2nyUbKN3viI+Krv7hZtag5B9K
 EdAx3ICmGexq6KdbxNrWpXq3X93fdPM4g/TbEZmm3nvxvUdVOJB9cmZ7lHrSCmTue2Ir
 7oyLFSTQDKwMQXo2wlIvTkdg5dvL1f65VjojpJYpzjjZZjaJU2bACKi1mJ8q/38L9lib
 VTUi1qug91BJFTg53gV2zEs2Gk33LEjhU7m0Tenv1pO78+D4+F8kWIPO62rWkv3I6g3+
 2P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704748309; x=1705353109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+S7Zi86W+AX+v5AQNZPooUlGA/2kVfinAuIGj+HpK48=;
 b=PNnBDKB6I3fpXueRFO5tBgeupm6CbMIdhSRcSc/WlN42qRnq/Nvo5UnaxODxzgaDV4
 JEBp1tkYcRoOerV8bMBul1A9jzs/TEdkon3rTNYbHbgKvSPKWHaAj9xZsW+cmikcRVoc
 5LA1+A5A/6v3gtnnXIHea/U8WlEAZ7L3dWd+JC4+9iVw9V5LMCCe18CMFPRxGpireLy1
 y6nmjd3ECRyGh8dxEMw0ySlor0knw5bc5d2A0jSMP2nKEj8sbArz3Lp2ETgpj+APSa98
 h42gXyicvATv4o+LM+kqyyVFcbKDGCPAWJnwD9ATY3WOYnsx+uENgJi9uzxv1akIOI4s
 jUWQ==
X-Gm-Message-State: AOJu0YwoSX9qLHnpJRWh0jTxaw0qAaii7cMFpZ3siDwx/N3QfypcA1o0
 9krMN7KzKbtBdKK2MzoYazCTehWRftE=
X-Google-Smtp-Source: AGHT+IEQtHMSCQkqHiQnJDB4epMwCcy88hrv2FwxLwoqydlBkQV6dRT9H8mrYguOtne28R07jcWp8g==
X-Received: by 2002:a05:6a20:4a09:b0:199:7f36:d88f with SMTP id
 fr9-20020a056a204a0900b001997f36d88fmr7334933pzb.1.1704748309153; 
 Mon, 08 Jan 2024 13:11:49 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:63f2:cfe7:4b90:23c])
 by smtp.gmail.com with ESMTPSA id
 r11-20020aa7988b000000b006d9aa6592d0sm304581pfl.82.2024.01.08.13.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 13:11:48 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: m.othacehe@gmail.com, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] imx9: Select BINMAN at SoC level
Date: Mon,  8 Jan 2024 18:11:39 -0300
Message-Id: <20240108211140.3270595-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108211140.3270595-1-festevam@gmail.com>
References: <20240108211140.3270595-1-festevam@gmail.com>
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

All i.MX93 targets rely on using binman to generate the U-Boot
binary.

Select it at the SoC level instead of per board.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/imx9/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 76c4129d79e0..961d6f527ab6 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -12,6 +12,7 @@ config IMX9_LOW_DRIVE_MODE
 
 config IMX9
 	bool
+	select BINMAN
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
 
@@ -29,12 +30,10 @@ choice
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
-	select BINMAN
 	select IMX93
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
-	select BINMAN
 	select IMX93
 	select IMX9_LPDDR4X
 
-- 
2.34.1

