Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB76EE4996
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 23:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D93986923;
	Mon, 21 Aug 2023 01:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GBfTxS5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B258683C; Mon, 21 Aug 2023 01:35:43 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15C386A0F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 01:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so19239975ad.2
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692574536; x=1693179336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTjawZhXdGRDgT0w4oz4Lhc1NZU3j9BrndxU33RMYqw=;
 b=GBfTxS5h6Q8JmmGoVbpMZ26FiKiZlEZwiXGy0ZANEjTu+ld0VMVFFvraAcQh/W8R1r
 aJaGTfN+99MDEp9Sbe3XppthW0r2F7K8eI7lrgrb9+QR0YuSOb+iXg85ap1qfXr4tVdg
 c69PIiDP6EWz2Fvt77KxKgWplZ0wVnpZNVIVaB5z4SsCgx0oJCV8afJA3daqIc4ZJQ5Z
 1I+MFLWm5tOUcpK++jJWbm9U877gayavlGtOmz+5j4kdv3n8W6u1KV7QnoSDMe7AHDTJ
 /if0cllcMhEndiABN2Q5LJ1GZLyGVlEkzRGQ5id+YcZzmsHgdQB4vUHIwJp3vVEzK6E0
 r6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692574536; x=1693179336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTjawZhXdGRDgT0w4oz4Lhc1NZU3j9BrndxU33RMYqw=;
 b=OcmETNV9piEKkaL/A96UwU4AktLE6k13pO/Zp/TomNmFCHg1ro7Lsxh8Z2NPBS40w+
 1EXsSvvJdYqQw9AP2Ma/FSoP6YMnDR2F3p6Jd9W5U1jJXH07ghIQ26Ct+2bXCXF83W7M
 yZ7DyTAo4haNG+3BIrESP9J3mOU0TyNi9x67wJ4TVBBPU++mZs/JcaG8TsMukkY49gp4
 AbRjneeUqRBkKz/ICoSjTNbZOiMvuvuwFy13HjTuYjgdvxTXlp3Fri9vshXEeRDB6ykf
 0NvUqhtIvJjAPGnLB0Aplmx8sqMUMGwO7ajh1oDziH83FYBL7g8JPDQpvLv1PRrRU5Pe
 eUAg==
X-Gm-Message-State: AOJu0YwJ/jcq171oG/hlQ08l2uWqBrdv4TwqJ0iwVIu1SpvJP21Ntwcg
 ZT5M3vw/cEWvgNwP3fvUxl3l3LBmsY01lA==
X-Google-Smtp-Source: AGHT+IHUTfoQAJKGDauI7rJiu4quKnWiguUQ+PvX3nVRQKc3VQkkqhQjL/u9TXfro8Qn7maftQV/ew==
X-Received: by 2002:a17:903:2446:b0:1b8:e41:f43f with SMTP id
 l6-20020a170903244600b001b80e41f43fmr7594576pls.27.1692574536612; 
 Sun, 20 Aug 2023 16:35:36 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:a119:6030:1ae3:c940])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001bde440e693sm5650082plb.44.2023.08.20.16.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 16:35:36 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] ARM64: dts: marvell: cn9310-crb: Remove duplicate pinctrl
Date: Mon, 21 Aug 2023 11:31:05 +1200
Message-ID: <20230820233113.575818-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820233113.575818-1-judge.packham@gmail.com>
References: <20230820233113.575818-1-judge.packham@gmail.com>
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

The cn9130.dtsi defines a pinctrl node for SPI1 (until recently it was
mislabeled as spi0). Use this instead of having a duplicate definition
with a different label.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/dts/cn9130-crb.dtsi | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/dts/cn9130-crb.dtsi b/arch/arm/dts/cn9130-crb.dtsi
index b229725184a9..7dd36cae282b 100644
--- a/arch/arm/dts/cn9130-crb.dtsi
+++ b/arch/arm/dts/cn9130-crb.dtsi
@@ -125,11 +125,6 @@
 		marvell,function = <0>;
 	};
 
-	cp0_spi1_pins_crb: cp0-spi-pins-crb {
-		marvell,pins = < 13 14 15 16 >;
-		marvell,function = <3>;
-	};
-
 	cp0_smi_pins_crb: cp0-smi-pins-crb {
 		marvell,pins = < 40 41 >;
 		marvell,function = <8>;
@@ -170,7 +165,7 @@
 
 &cp0_spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_spi1_pins_crb>;
+	pinctrl-0 = <&cp0_spi1_pins>;
 	reg = <0x700680 0x50>,		/* control */
 	      <0x2000000 0x1000000>,	/* CS0 */
 	      <0 0xffffffff>,		/* CS1 */
-- 
2.41.0

