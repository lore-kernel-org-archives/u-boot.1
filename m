Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E6FC71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E8C86932;
	Sun,  3 Sep 2023 22:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bio79H9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BBE867E2; Sun,  3 Sep 2023 22:49:06 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C428684C
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52c9be5e6f0so928375a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774143; x=1694378943;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aQ/spxaSMEggXIYz8OYteRC3aFv4G+4nlQfhxgjoF8=;
 b=bio79H9o54+ld4KG4j4hcUgcVFzJJdRMBOyD0fqJwZpUQEYU3fSSVL0Ez5vWTPtK3x
 xFr+WguKyZEHRD2zW0ED9T0ycl2XhrnnEctcCtP+kmJmV0BuFx4a7ylFvjmfCKCbDwSF
 4Q6tMor9QimY8+jbZ4Ekt2vE0qL8Um7u6+duI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774143; x=1694378943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aQ/spxaSMEggXIYz8OYteRC3aFv4G+4nlQfhxgjoF8=;
 b=GQFipa18xk1DTL9004q2Xacv3xNDKu5QZDlM6nB28+Xfdb2ZE5/NSrRz33Im86w391
 9tWXzGnGGy1v/J6ew/laUGxieDxCQUD8AWwVdPIOmQZ1D4N9zyPeu5QwlgWnntk2WWu/
 A3nafKkbXX2/ad4YAzx/7/RQggJxVBKQBmpMKNf8JmK+B43JFW8Sy/vxW93CcpEvHnQk
 qBz5nmbLvTbXDn2pMUUNRN7mDTs34Bzfb2gKZURa8RMk30eR+CbJ++RnLnA+tSkUtpqE
 CyYMYAl4YislKzoH5K5MwBR4i/6tSqvf8dLJ5I0zKp78t+VTeQzSINxuc0M1TQaFdqTl
 k86g==
X-Gm-Message-State: AOJu0YyjjXKBZ4Ofjac4ve6vVoeslvn2oa9XaBLrlv1G59e/8fAIR47E
 T+dhX3onULl5rFxoGVOvthlrBwH/nQPmy6h+W0U0+w==
X-Google-Smtp-Source: AGHT+IH1/+0FKlh06kDZ+9TResyYja01BpHYvmn6R2fuHTrTXBxxw8o+Hmm72gW6oTiMjjqgV9Ln6Q==
X-Received: by 2002:a17:906:2201:b0:9a5:cf23:de5a with SMTP id
 s1-20020a170906220100b009a5cf23de5amr4969382ejs.45.1693774143432; 
 Sun, 03 Sep 2023 13:49:03 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:49:03 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 09/10] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on
 stm32f746-disco
Date: Sun,  3 Sep 2023 22:48:48 +0200
Message-Id: <20230903204849.660722-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

commit e4e724099f04072053cf411456e3e9aae48c4af1 Linux upstream.

In the schematics of document UM1907, the power supply for the micro SD
card is the same 3v3 voltage that is used to power other devices on the
board. By generalizing the name of the voltage regulator, it can be
referenced by other nodes in the device tree without creating
misunderstandings.

This patch is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
---

 arch/arm/dts/stm32f746-disco.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/stm32f746-disco.dts b/arch/arm/dts/stm32f746-disco.dts
index 9541f449fd0e..e1564d69f9f6 100644
--- a/arch/arm/dts/stm32f746-disco.dts
+++ b/arch/arm/dts/stm32f746-disco.dts
@@ -44,9 +44,9 @@
 		regulator-always-on;
 	};
 
-	mmc_vcard: mmc_vcard {
+	vcc_3v3: vcc-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vcc_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -82,7 +82,7 @@
 
 &sdio1 {
 	status = "okay";
-	vmmc-supply = <&mmc_vcard>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpioc 13 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default", "opendrain";
 	pinctrl-0 = <&sdio_pins_a>;
-- 
2.34.1

