Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33426FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A6484236;
	Tue, 17 Mar 2026 02:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LWfBEfnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB04840CF; Tue, 17 Mar 2026 02:24:35 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D3283DB6
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-466ec4c6846so1559357b6e.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710671; x=1774315471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=J6vhZ9j/rEnA/cu2HM8CNHXZ99cd9ZsMD8QZoyPkjwg=;
 b=LWfBEfnSZvEBoNqAAy46zMv79t6m3eD1Pd/PQp5/wKuQcyIwYyVXVZqk9NmWtk4lDR
 pN3x7DtQkvk8aZqGI2QMcGbzYK13wXhc8ji8kG6CfcEkthk0h1ZwPtAQe1TDwIrOyf0S
 +VvKh3C9fCdRsPBKRaeNb+faPCaRLcwHZt3wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710671; x=1774315471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J6vhZ9j/rEnA/cu2HM8CNHXZ99cd9ZsMD8QZoyPkjwg=;
 b=aR77/+bFelxykJXUWMps6xKvmfd8obE5PTRjtiewvBDIVqBmCnxGYc66rdyLy3y7X4
 Zn9uv8YSYfbdB5VKrDHD5sJmWkEETYUZCIXeAYG4DZ8AvfYSfX8yeoQrvUU0uc1M3Rsr
 4NieNCq454d2shKITnWINiiRBSb+8yIIf4Y7FDOZo0pw5ZljzI4S8BNhK35w5rP1w/Ui
 WxdoDfscaht9BOgZsUMSEoTY9+swTvR6QaS/65FkAH9nZeKBIXF5y+zuXz85UOBbn+Z4
 ebkWDuet5oYwsMG38hqOhBSKFP+k9K/p0Bg4zUnltuxgs73eOepRyVk15j0XR16LOlY2
 M3lw==
X-Gm-Message-State: AOJu0YxLyl/K89Hmh1Pq2dNbtA0dMb9E2Qd4ptYnnvAbdsybflEM+GSV
 Q7qdUIjklk9ldCLrWuS5j30EYvHl6qIEgGlSJoQflT8k7L1x1Fm1sDMH93MI6+OAXwFH86idjkP
 Z9HLcU9g=
X-Gm-Gg: ATEYQzwWZsTiZf0oQ+oY6r1KcDbl9/3rgUCLeKu8B8jJrkpPt1J3VBLKiBO2PsqGxZZ
 /OWJtExgEPACYFTxogdh7AXYkZ8xv4PPljqJ/Z2yQpx61m1D2kU0PQHhD89MDgTqyFaL5YAFwYr
 G/PS1pJFC5L8vVnmxQ0I4xBbEALC8K0r8WsH/FbeOSMekBj8Tnmw56998+y2iTn0sW3CEE4r+hk
 q2qH3rraGf6fHUUMOxLKDwgJfLvHAFk060nOdSIBFjQry/sSHDO7iIGdSZ6sSefc8lmIXjSNaf/
 ljY+R3ksO904NP8bi2FFq4E6KJSVPatCJrFPnFHqOfO9QNat2TFU8J2SPvNlebi5mw6grH3xUQO
 Oh3ln2G4zRpPUvr65Y6xHNLuPetBRXHNAmlgi/LtW5uhQ4MSd60x4p2iJu18LYnYn++HKaI2HTC
 cdye/76G3eZWSsQXyQbt6yLmylIgoc60EjGtFshWdGl2Z5TAyLwH00JJvZaY4SyjqH+1qY/7jCc
 kbfGzyqsHU469ao0JV7M6vBuvVSEOYmXqVmVxUFShJOvO5AA2gB7+P54jwp5g==
X-Received: by 2002:a05:6808:1452:b0:463:9a77:a552 with SMTP id
 5614622812f47-467574292bbmr7887141b6e.45.1773710671422; 
 Mon, 16 Mar 2026 18:24:31 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6ae0e3sm18904571fac.16.2026.03.16.18.24.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] boot: Update dependencies for some UPL options
Date: Mon, 16 Mar 2026 19:24:29 -0600
Message-ID: <20260317012429.4162492-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issue around SPL_UPL. This
depends on SPL_LIBGENERIC_SUPPORT indirectly. In turn, SPL_UPL_OUT needs
to next depend on SPL_UPL.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index afbd0e735163..bfed452d77e3 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -991,6 +991,7 @@ if SPL
 
 config SPL_UPL
 	bool "Write a UPL handoff in SPL"
+	depends on SPL_LIBGENERIC_SUPPORT
 	imply SPL_UPL_OUT
 	help
 	  This tells SPL to write a UPL handoff and pass it to the next phase
@@ -1008,6 +1009,7 @@ config SPL_UPL_WRITE
 
 config SPL_UPL_OUT
 	bool "upl - Support writing a Universal Payload handoff in SPL"
+	depends on SPL_UPL
 	select SPL_UPL_WRITE
 	help
 	  Provides support for encoding a UPL-format payload and passing it to
-- 
2.43.0

