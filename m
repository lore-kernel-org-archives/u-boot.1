Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04685C48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 18:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5DC87BFC;
	Mon,  5 Feb 2024 19:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f51O0anD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B5187AEC; Mon,  5 Feb 2024 19:59:06 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D13C87A80
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 19:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bfdb84c0ebso730044b6e.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707159541; x=1707764341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmKKM0YtfPjDtKVsLY1E5n2fAgf2nz6biKFfCG1I1l0=;
 b=f51O0anD/ok9VormlHK637XYWFNrc9RDn6VHRGwF64q0Cicw5VSZZyYFTcQWXfBi4x
 8AMEMtPVihBqH2HNSIXIJdetZOdEf3lTlaYrxlUZDAwX234wc0nDsHgCAtTRKuxjNfGG
 1O/jmQgLUSPmi2YkyqG+/xHRmBEDNSBnPg6cd2vyyHbF6S1unasDmcEiaqBfojSbBZZV
 tMD5Pz3Lic3aJJ6znWeCBkuhG75UlqG4OknwcPHm9GqiXBlSqmEejdSo+7QgA91d5vnL
 FFdcTe/GfROzOsWLk/2eSpVBu0kNrFYV1LkdhZwT+iwra/erelXd3loAq2904IELN8vS
 86OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707159541; x=1707764341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmKKM0YtfPjDtKVsLY1E5n2fAgf2nz6biKFfCG1I1l0=;
 b=S/DPW7h2v1Bumy5T5ZJja/oW60Rqkk9mKXU/11y1m0WyQUob39ni0jlwDHi5PJmXGb
 /4KUn18Mp9zELX+vinG6T5VBLzOw1oYrzVLsT3Rq3IWv1gLHxQoOArTLsMsIPL7YYpAY
 7ZVibXbihGlQVQOqJOIXdOX58V9RzACnZ91h/4YoZMWfCqqYsN7KXLboWzZyMRRw9aP6
 saFSPr/L0bTF1GOCgqWHWLnhuJmz6qKL9Vk3+Nlr+R+mQJUQwvk0fmu7AUqErj7FLX6m
 7QDk4JSnNSgrRMHRvufVYBoQGpfbwCqE1Sh0WZvAUVVZBJtwNAurUStOMHtacfi0b1YX
 pRbA==
X-Gm-Message-State: AOJu0YyYJtRvXctNC6Q/Lpm5iqSrud/n7PJS3I5OBYg3L78gZ7p0iOF8
 VQnLXCYpD/AssgXN2DkyGxjc3MzBTIboW2P9PjJGYTA0tHhCZbeyZU82A3aq
X-Google-Smtp-Source: AGHT+IEXNsoY25x11VESu+uRS/lRdKv3KIxMN3xi6CivvH/JuIDzD2BQX3ZHYQY8OYW/pH2TR0TKGg==
X-Received: by 2002:a05:6808:610:b0:3bf:dfd3:1816 with SMTP id
 y16-20020a056808061000b003bfdfd31816mr25977oih.26.1707159541130; 
 Mon, 05 Feb 2024 10:59:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWPdbyb1BFPvl7XZeO6lPHDWJx1qhxTW7+uRQ3cE78Qm7iPaKVV50LOBFN8apshgA4mE8Lv0OMYKDEiCOAnQzbN6KaYzXB7ECPNhFARcPBhu++6IYDFyE5ECTTcvfNF99Au6UVwG647FKBU3sFCfj/c6epSZ/X30UWvPW1O6WzQSQ8k784ftzeTR+fsQBpKWPNzHCBxf7PFxVRgPx+4pviJ
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 cn22-20020a056808351600b003bfdfc7e5d6sm65692oib.42.2024.02.05.10.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 10:59:00 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, jagan@amarulasolutions.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/4] board: rockchip: Add support for Powkiddy RGB10MAX3
Date: Mon,  5 Feb 2024 12:58:53 -0600
Message-Id: <20240205185855.21508-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205185855.21508-1-macroalpha82@gmail.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support to the RGxx3 device for the Powkiddy RGB10MAX3. This device
is extremely similar to all the other devices and can use the same
bootloader with the same detection logic.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/rk3566-anbernic-rgxx3.dts     | 9 ++++++---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 8 ++++++++
 doc/board/anbernic/rgxx3.rst               | 1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dts b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
index 9e0aa9e63b..c393c8d07a 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3.dts
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
@@ -12,9 +12,12 @@
  * set the correct dtb name for loading mainline Linux automatically.
  */
 	model = "RGXX3";
-	compatible = "anbernic,rg353m", "anbernic,rg353p",
-		     "anbernic,rg353v", "anbernic,rg353vs",
-		     "anbernic,rg503", "rockchip,rk3566";
+	compatible = "anbernic,rg-arc-d", "anbernic,rg-arc-s",
+		     "anbernic,rg353m", "anbernic,rg353p",
+		     "anbernic,rg353ps", "anbernic,rg353v",
+		     "anbernic,rg353vs", "anbernic,rg503",
+		     "powkiddy,rgb10max3", "powkiddy,rgb30",
+		     "powkiddy,rk2023", "rockchip,rk3566";
 };
 
 &cru {
diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index d05502f67a..5c57b902d1 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -50,6 +50,7 @@ enum rgxx3_device_id {
 	RGB30,
 	RK2023,
 	RGARCD,
+	RGB10MAX3,
 	/* Devices with duplicate ADC value */
 	RG353PS,
 	RG353VS,
@@ -107,6 +108,13 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
 		.detect_panel = 0,
 	},
+	[RGB10MAX3] = {
+		.adc_value = 765, /* Observed average from device */
+		.board = "rk3566-powkiddy-rgb10max3",
+		.board_name = "Powkiddy RGB10MAX3",
+		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
+		.detect_panel = 0,
+	},
 	/* Devices with duplicate ADC value */
 	[RG353PS] = {
 		.adc_value = 860, /* Observed average from device */
diff --git a/doc/board/anbernic/rgxx3.rst b/doc/board/anbernic/rgxx3.rst
index d159ed2f76..1e63e6951e 100644
--- a/doc/board/anbernic/rgxx3.rst
+++ b/doc/board/anbernic/rgxx3.rst
@@ -17,6 +17,7 @@ This allows U-Boot to boot the following Anbernic devices:
 Additionally, the following very similar non-Anbernic devices are also
 supported:
 
+ - Powkiddy RGB10MAX3
  - Powkiddy RGB30
  - Powkiddy RK2023
 
-- 
2.34.1

