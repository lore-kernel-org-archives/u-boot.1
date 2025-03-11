Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952F4C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9412681A02;
	Tue, 11 Mar 2025 14:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MHs/+t5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E148F81875; Tue, 11 Mar 2025 11:33:16 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD58581335
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e56b229d60so11464608a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689185; x=1742293985;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YC/IBcNwbXUuXsQy3U6gg2aohdcL33lcUmQx2355Vjk=;
 b=MHs/+t5ZlkDlo5+oZeMOWODV+Sxfx3b6q82EDudYEDRAaDOKHHXA1fU3ncaf1hGLfx
 2rgSDEAmhShoCoIW9f6FXlrDZIUDN3ZINONB9OWJa8NJDaGUGoCHpWbWzVlD8gDjLcgR
 C2DE0nrhXDYSoC9eyYPGXpAw1OzXtnN2GwMWsfNcb2Wc7p2OyYJE/+ZiOOEbHtCi6okz
 0vMuhRjC+UA/sLlZ5/wIBPTKyQud4ZbunMI5NMBCCkdeXstRtabhUEHLFw5WYG806cNK
 0paDks8b7LlDvVWxTbQiv916ebW5liq25fj9LWKZIwgqOWOQivFuj0JIV41B+0KG+93I
 amxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689185; x=1742293985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YC/IBcNwbXUuXsQy3U6gg2aohdcL33lcUmQx2355Vjk=;
 b=p3bY2wlp18g8SkWuKmuHPa9cIL5jHhyxbf2MJNLLpsKFCV3rMOWEmDt9FH2oClFLqi
 4PZWN9GWeWyfheduuY3Y4sH5FXOKolMNlNTuVp96UqltbVS6vOI2QP+Eo3sYFoa/LJVe
 QuIl6JEOwT+LXBw8Z7ciqhGL7+S0Q7Tq+Voull3QOZjrGP8+4pKgTGjjA6tR5/ZPGFXu
 UHXVMgFV6aE4GQJ4XIhQmFHW/XdeTFSsTsHWivxtTatpnS4MwdGGxcfC23jHcAQTMD83
 h+5w21bwfFeNYdiOkxIcOfxrEEYeSB0OjvLPYrqfute5vNV//QwUc9FsznXUSeYS43nw
 KhuA==
X-Gm-Message-State: AOJu0YyjyucbzMY3ja6yjCTTM0rqUjaKrMZWVGAL44uzWM/uemTTlocc
 gmZS5aOW4wo26ozT9JV5h/AepDNiSeLTz17yXaxBXsMD0m8OQn8PBPfYUG6VWOOIO6FLSVyzm0B
 1
X-Gm-Gg: ASbGncv3JKqDzMUXB4FPviQB3RL11djP4KgA6g5vuug1W60+DqgYgOL0JffDJzsr0HV
 eDoLxM+zU05rzb5XwwkJWjShj5eO9D49Ymug2FD/wYQP4iygwfsxMeQv/UV3EZdG3HgxiSr4F4q
 uvIh0q35mTtkp5DW5LEPfePukaP77n5L51E4UeH+EchOgNnUW3B2k72sPqPmjp728KeJGwLekXm
 scl1/qtEA+jSG1NpfnHCoKIu+FADGsb1Tt/S8O+m4IxWg11WsIArhsRIrElhGU8Xp4SlYlqGojZ
 +i7kycLBKofBsUXImPazZsRdre4v6X+rThx+HXHT
X-Google-Smtp-Source: AGHT+IGQ0V9Q8rqoKugUD5xjkvsSs7RqCMFBoEyvMVWg599k8M6o4WzxRXmjMCXk0siTU3WevnD3Uw==
X-Received: by 2002:a17:907:cb21:b0:ac2:26a6:febf with SMTP id
 a640c23a62f3a-ac2ba563dadmr248109466b.20.1741689185108; 
 Tue, 11 Mar 2025 03:33:05 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-5e5c733f69csm8041155a12.1.2025.03.11.03.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:33:04 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:56 +0100
Subject: [PATCH 17/19] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-17-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Q+gVDEd7CdFr7Ul+S0GGAqyf/NS1Jv1HZohmT+hppSc=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCDo87xWp5l33+/DVRr5pdhpzb9066/Hh/H7P1M7yJ
 Y8sXM/c7ShlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmUviU4X/CA/Gz7y+/m75Y
 v2Le4p+6QarvH7B/2JB+9caTKzHL5mU2MPxPPVIiKvf4kOi84gnJ+UfeM/bck5/s8Us9R9hx3lL
 eiZxsAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

These are needed in SPL to be able to resume from DDR immediately after
booting from IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..8c2b198dede03fd77f16786f8743313a34902e46 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -11,8 +11,28 @@
 		stdout-path = "serial2:115200n8";
 		tick-timer = &main_timer0;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
+&cbass_wakeup {
+	bootph-pre-ram;
 };
 
 &dmsc {
 	bootph-pre-ram;
 };
+
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};

-- 
2.47.2

