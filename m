Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268B1ECD988
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 17:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B041C83A64;
	Thu,  5 Feb 2026 18:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXoQ7j58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B68E83B86; Thu,  5 Feb 2026 17:58:20 +0100 (CET)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B388E83B0B
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 17:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-658078d6655so2117794a12.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 08:58:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770310698; cv=none;
 d=google.com; s=arc-20240605;
 b=XVDmbc5pEnuduN/s34/73wZ4sSW7SD8j9e7dowN0W8bMWR9CqwCMGAwO0GdfoAAppF
 qvaxe5F+/E1MMV6dr+dvJi5QzUVJrmUao63ZbsqT3DvKV5jKY5WYArlQsxDly7A3CCPD
 dM2zE6XiE1UASb5iUYh1osgzCtYnbs51kLRSx72XhXsUxYOlHEyT2rzXv4v4PNvAwdUt
 ZEXEEXJosxw9CBkoufy8JdqmELnGh0f9W4GwPGJXI/RpzCvilTgwtsLHT9zgXu0GcpEF
 H0J+lqTh2rqTMpmYS4h8ulvax/iCi4NKDgyJsksgoqp62KHTyJo9S1J+CZ/m5ZQkJ1xP
 uzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=P5MkrU9ARVMfiCRfVKE58W9/9ZXWAFmofnE0WIOP+5U=;
 fh=VnUzEFF6JCKQskZAp33igu7BgVfVqJZ1XftJjLBwEbs=;
 b=G0Kv5M2uTcwjpRRCWocx/zEUtFDU0KaMFtKJtPTe9CK5BMs0pKd1isVYlKnC+mYV3v
 FGofPEaCXpmJrbrDgvumfUqBtEdM5Vo6Po2iH2OwAgMseCQq6j77pTDGSqiM2qH38f/5
 heYFXI0HRNzlFzgrfGSJ13uIRGsqOhB04253I97Zg4vnpwfYoeWTvvm+f2MDyIDc/i8v
 2PHUFSX8TNFU8NL+ZfOiO0/D0+rUUQNFw+Tf47titQZ0mAyLRnNw30/KzIqlFglgGMir
 YOV8jguyiuf5BCSunZe9zeNBzKnu6UvzWub0efBWW5PpMrLAc5DDh6FLv75eHdJWajM1
 Jh8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770310698; x=1770915498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P5MkrU9ARVMfiCRfVKE58W9/9ZXWAFmofnE0WIOP+5U=;
 b=QXoQ7j58Zapa/ubmxYDgiqLGOquyqPqAu83m3yxvxL799FDo7sMKz0ajQOJ5FSZsn0
 NVWOPz4qDpGiSML/VrN//1nWcrqeTGf+jY3H40bK/qMX4a4ihZZjrEJ72sIy6kcR+qMp
 bIBq7BXSZSjXuwN4XKZIXFijPdabNt0aVnCf0DUwgMqe1g9fUD4ogclzVm7DmaJIuUIK
 pJ4XBw0AS2NuAHwDlvkTcJx2N0rEspKAYmF2uOb3Q+rb4Ia7o5grVhOb36aRNYrRo9c1
 l+W4/OKif9j1P0hdAlUn59+7Nh8ZnFjphRI5dbALF9A3g+79mppLgiOG23MchvGOKEe2
 UJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770310698; x=1770915498;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5MkrU9ARVMfiCRfVKE58W9/9ZXWAFmofnE0WIOP+5U=;
 b=fQgNt/Csu52s24fByM4dUM8IGV5TLuWdtx40HY9lgG8NktOWRgDXgh8qER6wlPo7oh
 PtEA5s0ycPEDKHYqRQ1bU7GkIdQqRO8XLXrPexSpncxEXmczg2Ma8ew54FcWY9lSSjBs
 iZ9j4Ec//JeRTDBrByEbQNenXd7MFJyiuTSRNVAOkF3qk0MEotoQrjVAdxScAKVgkqJ4
 V04iYSSXOLUfJW2GV36N78udYdTm/ls87BtES7V8hZWT3gAaGD6aomvq8nv2VE59z0aY
 bL9RHx/oNbN9oRDH0HLIkm8+kNaYk9DJt4SvNGuiC9BgMgTVM2qyqMFLl7Ohhl6xqfbE
 o2qw==
X-Gm-Message-State: AOJu0YyWblLKl+xRqEDsETF4faoWIAw/c9UAEy+6gCPx3amNUU07pnUH
 xs8psDrpFMuImN+mek3WtQ5BnPqbma3viq0OKXWgpMhfonu//5woFPR6jg+INMsLlQPWqsX/l10
 Vu8dUJPVWGID6pZchtZUQoLe4ZgUF6TnVxB7XWyD/BOq/cBY=
X-Gm-Gg: AZuq6aI/ycVWyJVt9kejUXKwNoZuWRMhnVbUpBDsNq1EFSOPIJh8iwWvumaxd7P5Sji
 ++vQ6P1iUqXkxnazGLNtmeuHEPKUddlXfEcVSGh3qCgm87hkGRtSh9plwLiFk0FHKE6mYSVxHIy
 PaTTAgJahJQnxHr28rxunKk3Aizrnn+bwwQ6rc3Pxcet/WqKUvJMEWvt/xDB7F9n1QgVZ4EctEv
 RoUpOpND6z/WovWLQcBBjDeF9v49zRC6M1s2ioI0OsuIA6P1foUP6Kjgg==
X-Received: by 2002:a05:6402:5256:b0:658:b4b4:5c93 with SMTP id
 4fb4d7f45d1cf-65949ed0b63mr4477676a12.20.1770310697524; Thu, 05 Feb 2026
 08:58:17 -0800 (PST)
MIME-Version: 1.0
From: Caleb Ethridge <jcethrid@gmail.com>
Date: Thu, 5 Feb 2026 11:58:06 -0500
X-Gm-Features: AZwV_QhrrL1wcjkN5XQUi_8PNicnFHjYIqdimsBNhGYFLzIH2q6kmVjtjerUEqY
Message-ID: <CAA=Y9tYS6=KJDyMYK5VAR5JDiv57M+MAv+i-m3cykb=nCtv3qA@mail.gmail.com>
Subject: [PATCH] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
To: u-boot@lists.denx.de
Cc: "caleb.ethridge@analog.com" <caleb.ethridge@analog.com>, trini@konsulko.com,
 linux@analog.com, "malysagreg@gmail.com" <malysagreg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 05 Feb 2026 18:00:00 +0100
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
Date: Tue, 3 Feb 2026 14:45:53 -0500
Subject: [PATCH] arm: dts: sc594: Update sc594 EZKIT GPIO polarities

Updates the polarities for the GPIOs on the sc594
EZKIT, as the current version was still on an old
revision of the hardware. The GPIOs now match the
sc598 EZKIT as expected.

Fixes: be79378 ("board: adi: Add support for SC594")

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
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
