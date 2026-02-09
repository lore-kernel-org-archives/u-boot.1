Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A20FE81BD7
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 15:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404BD8388D;
	Mon,  9 Feb 2026 16:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ksby3D/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D46839A5; Mon,  9 Feb 2026 16:04:16 +0100 (CET)
Received: from mail-yx1-xb142.google.com (mail-yx1-xb142.google.com
 [IPv6:2607:f8b0:4864:20::b142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792B38341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 16:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-yx1-xb142.google.com with SMTP id
 956f58d0204a3-649d4c77a32so3935127d50.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 07:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770649448; cv=none;
 d=google.com; s=arc-20240605;
 b=QebnXxM8GWlNquN8OV23XAk0FOaTJRMyo36KMzirirbFVbjk12hfOfwY2jCzH/uw5K
 XOQsJHc2wJ9Kr5UqZWnMfjIxNatrrc8CtkFqxynGsqPD6fcTTgKmlsxtw66qdEeJz7Sa
 a8QE0CSqwlJt01RAOtD0o44FpviAc4AkZ0LrdXwO6A9ihhct4pT9nx04KulXGebXkXT0
 cITerh/TjJsT6pNNPH/V10T3CXXRP5aq9htK4m2v6KpXwcNr88yTe3cQn3zXA//VAc2D
 3xY0Mh+OZEcRl72ucgPAZT3RKlqFdmueofQBAgFBW7HQIShQpAr3fKShRY1Yeo15tuEL
 YlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=GD1DZwIfzm4m0wUrcQWTsBpXIRpsXqpJacoWnAQpTH4=;
 fh=vrCOCchtemwOqCgP/SWMtdnwckWloAK4b0xV9dwuFA8=;
 b=RDmesKZTmR3XYlihSkFs0jLm2IsUla/TCCV/PgfmsMkz5o9fQX0mOyVQiBeGvWHeLJ
 6vvONeQYOv1sQDlRq85EurpqJcpVPEIfQbl/pVgmzYAX9E6gL2NxvI1Ara2cXOPILbZ8
 ZewdFBxEggOR0bhKtjIC6dFfyuLThlf9W2wxWrY10EtjnqjYj8t8a4+HUec0Wiys7gsu
 01F75HwqyTU78wOJGriocLuly9FjavhpZb7c+I2qOOfrlNvyCCATFCy+2x+5b3Anut64
 LTb7MKe7nhTRrHnVqY7YC1zpGIwmew/d30Qa7rkUlEltC9iRmkCGZoU2z6+A5Kmae0as
 DX8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770649448; x=1771254248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GD1DZwIfzm4m0wUrcQWTsBpXIRpsXqpJacoWnAQpTH4=;
 b=Ksby3D/cZ93IfJWatHdRFhR/T75TBXNYV1u7cTJP6fkPbWwQOsRlMuZ19Q/B9bgJJM
 T4YrSKuUR9R0DLXay5t4W+EesHGBFu4zUjaJvBw1X3shD4lSRWPnL3++eVTtxXhrQgDp
 zKXJmF2Mk3k4TVDYnsJZgk4Y70+ULDOfMKcE+MBrWTTSmIfQaKvvccTIFZUQl0I2HoXa
 jD9ZmoCkG3sNmaUMApO3Esett9C3DRt7AT7vS4VUIotYIb7p71ChQbURiPm1i1oaAbym
 grTvi8c5yrwPHNDMCqEpb88WC5jVqKzZAkFYGV/92w/rJDVzJB8vcP15e6eFEWZ8y4wW
 crAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770649448; x=1771254248;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GD1DZwIfzm4m0wUrcQWTsBpXIRpsXqpJacoWnAQpTH4=;
 b=g/j2Ei6yoFoXGcv/GLjK69dl6VSsPwIOQ0PW58FwbTrulTLcbu5jMjKDHSunILWyEl
 wTBJ5cqivkQmE4rPrlgdaRZ0UVJzAK5L4EEcWNRzNlNtU2oKJWVXyxcmWqqqq15KJIEn
 klzhnuFGawp82J5VTamTZq2FgnvnxOxBvJ74tahfxFGxXQ/P5c67myHWXYNQYcV9Txkp
 b/t8czTz4inhfRmNTkkvz6TRj+lEERAPY+w2Rj+EqSSv0+2908C9cSzdok+u1bSunjnz
 WcTrAzN4NS9Qlok5czfaATs7RKVG4WaGH8Wf9m/KuRRtle1aeffBNORIkjoz6lIKDbZ7
 vkhQ==
X-Gm-Message-State: AOJu0YzjUtSwZpRljJxA/XBcKiZ71X4J2TJ2kjGiz6OR00gLEkHfAmtC
 SSUjT+FbCqoYW4ncFHj25UWC8pvmgtewT0KCpiMckttUMLlqn36aCcS/+FUlW+Z4lYNBhet1p8E
 UDBVsm5NCbH3jaavMp6KhgAUbC+C9veTkv5vyTfQ=
X-Gm-Gg: AZuq6aL2mmoKkcpFiPmiBgfTvrMLkY3gZCccUa+RvFA7eQLSEyilj91m+1sNUuWqpP+
 FqfE3HysxvcDhPm6BmkXAKh84WqqxU623x3bIYdEqyld7oLsJZECAeLddsXN1x6iAj0dVrqQZVQ
 CQc1bVxv1fUYadU2tu9Sp47XgTEQxV8bWUr1xuq5n+i5xhoi7zcbGMwQCKl1WmaRPhmab73GYn0
 cJloYbIbQdmL7t71l8wakuGXmoQwwuXX/RL8dzgbIICOg6a3dYUtv0uUiKA/b/pfp3z8te0ryO5
 fecQzDI=
X-Received: by 2002:a05:690e:5ca:b0:649:44b0:e612 with SMTP id
 956f58d0204a3-649f217aae5mr7056413d50.73.1770649447873; Mon, 09 Feb 2026
 07:04:07 -0800 (PST)
MIME-Version: 1.0
From: Caleb Ethridge <jcethrid@gmail.com>
Date: Mon, 9 Feb 2026 10:03:57 -0500
X-Gm-Features: AZwV_Qi8XOJm98XOv8wRoGNOCeFJOVj8c5APdKYYwgkhi1Eh_MeeY2OgYIs6e4k
Message-ID: <CAA=Y9tY1pJV5O=23YSgM-1TnRQNpg9zrPJsSn6YaL_uAPxUo=A@mail.gmail.com>
Subject: [PATCH v2] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 Greg Malysa <malysagreg@gmail.com>, 
 "caleb.ethridge@analog.com" <caleb.ethridge@analog.com>,
 "linux@analog.com" <linux@analog.com>, 
 Philip Molloy <philip@philipmolloy.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 09 Feb 2026 16:12:46 +0100
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

From: Caleb Ethridge <caleb.ethridge@analog.com>
Date: Mon, 9 Feb 2026 10:00:10 -0500
Subject: [PATCH v2] arm: dts: sc594: Update sc594 EZKIT GPIO polarities

Updates the polarities for the GPIOs on the sc594
EZKIT carrier board for the newest revision, Rev D.
The new carrier board revision has different polarities
for some GPIOs. This patch updates the sc594 entries
to match the sc598 entries that were updated in a previous
commit, as both SOMs can utilize the EZKIT.

Note that these updates are for the EZKIT carrier
board used by both sc598 and sc594 SOMs, not the SOMs themselves.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
Changes in v2:
- Updated commit message with more detail according to reviewer feedback
---
 arch/arm/dts/sc594-som-ezkit.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index eeca6d17504..11154e65ed6 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -22,7 +22,7 @@

  eeprom {
  gpio-hog;
- gpios = <0 GPIO_ACTIVE_HIGH>;
+ gpios = <0 GPIO_ACTIVE_LOW>;
  output-low;
  line-name = "eeprom-en";
  bootph-pre-ram;
@@ -30,7 +30,7 @@

  pushbutton {
  gpio-hog;
- gpios = <1 GPIO_ACTIVE_HIGH>;
+ gpios = <1 GPIO_ACTIVE_LOW>;
  output-low;
  line-name = "pushbutton-en";
  bootph-pre-ram;
@@ -70,7 +70,7 @@

  octal {
  gpio-hog;
- gpios = <8 GPIO_ACTIVE_HIGH>;
+ gpios = <8 GPIO_ACTIVE_LOW>;
  output-low;
  line-name = "octal-spi-cs-en";
  bootph-pre-ram;
-- 
2.34.1
