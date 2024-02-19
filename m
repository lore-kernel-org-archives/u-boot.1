Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68616C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8387287F25;
	Mon, 19 Feb 2024 14:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kTobJpEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2937E86D38; Mon, 19 Feb 2024 13:34:23 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527C587F37
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 13:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5101cd91017so5498728e87.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 04:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708346051; x=1708950851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1dt7SV/dovRzj1+iVTaLQQ4RbPxx4rut02WR83+Npsc=;
 b=kTobJpErx7jWFskciN5ZQycq37s0j/On7nzTsP/JfwZs6SaEPmJ7g5T9xD2eRQ++q+
 BwDTlt/IzG85QfUSelQWKwr62CchHlNaHk7qhZa8181a/H5S2A3Aco78hehjEH3Muu20
 4VzhSmZ+hSlPm3ppqCHE8L1tGheHQ7D5eJsC9T+kLrBa9/V5/9QvTyHgUrUJmC+5hNSe
 7ogOZzlhGiCy9GQRBADUA4wuFTbgsYHiNQvWRVs0FgsNZsIw3x+NnpussI77sbKLVFld
 v8oMWe9WLJbQ35sOxywwITNbbxKRqMuuiyDfF+uVATlR15tkNs2nP5scL5UtMp11R0xA
 Wqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708346051; x=1708950851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dt7SV/dovRzj1+iVTaLQQ4RbPxx4rut02WR83+Npsc=;
 b=k2+0Ci19nOt+HB0qapPniIlEHIduR2fLVpsKihL8UBrGG5dVolrXldwbUoljxY1ACh
 ii0CGM6jE+jhnGvkW0osRmVS6Z2FJviyJAPWxGiDtibJg+pyK1u5fWh2jF70C+jFPtbE
 AKDVHFcqm0vf1EYIzKKwJi/WxL7DFRAbvp4dremCRWZuLm4YP8q+uib2l2oKRiDAFjCa
 5/o5B9+pu29itKqd/cVwtHlqdeT7ERf4MKkFNgey/KEIzf2GTgNpVihxDREpkBbLYBFg
 lg+MfIu347PKJwfWJp/PAxipMrUkj1oshXOHISw8oqIkl0+5GoQqgFsCRDtIFBe3xyUj
 yrqw==
X-Gm-Message-State: AOJu0Yzlh4R5fm0DR0G0oJaNfAHXPldGfU4pDphEsXmc9iKRRSnLklCr
 wY5GXoHajN090/nwiFEuKRykOUaMdL6CpoQd96PAfotaTbMNSjle
X-Google-Smtp-Source: AGHT+IHnyT6tv/8IgV7xwdHP8KtBsoinW+V+5Mqlqil3/oqL1W2+bc4Vg0ezPkAto2Lez+N53TqkyA==
X-Received: by 2002:a19:7407:0:b0:512:9e56:7fe7 with SMTP id
 v7-20020a197407000000b005129e567fe7mr3960307lfe.16.1708346051275; 
 Mon, 19 Feb 2024 04:34:11 -0800 (PST)
Received: from vitor-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 m23-20020a1709062ad700b00a3de8866819sm2909435eje.76.2024.02.19.04.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 04:34:10 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: marcel.ziswiler@toradex.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Vitor Soares <vitor.soares@toradex.com>
Subject: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to 1000MHz
Date: Mon, 19 Feb 2024 12:34:08 +0000
Message-Id: <20240219123408.22054-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Feb 2024 14:53:09 +0100
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

From: Vitor Soares <vitor.soares@toradex.com>

The same U-Boot binary is compatible with multiple Verdin AM62 board
variants. However, some of the SoC models can only operate at a maximum
speed of 1 GHz.

Previously, the boards with lower-speed grades were running at
overclocked speeds, leading to kernel complaints about unsupported
configurations.

To resolve this issue, the operating speed has been decreased to the
maximum allowable value across all Verdin AM62 board variants. As a
result, there is a regression in overall boot time, increasing by around
200 milliseconds for the faster SoC variant.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm/dts/k3-am625-verdin-r5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
index 305d199678..6b03e7405a 100644
--- a/arch/arm/dts/k3-am625-verdin-r5.dts
+++ b/arch/arm/dts/k3-am625-verdin-r5.dts
@@ -23,7 +23,7 @@
 		 */
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
 		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
-		assigned-clock-rates = <200000000>, <1200000000>, <25000000>;
+		assigned-clock-rates = <200000000>, <1000000000>, <25000000>;
 		clocks = <&k3_clks 61 0>;
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-- 
2.34.1

