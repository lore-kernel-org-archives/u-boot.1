Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F03C4828D
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C70E87BF1;
	Fri,  2 Feb 2024 01:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=janga.la
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=janga-la.20230601.gappssmtp.com header.i=@janga-la.20230601.gappssmtp.com header.b="owsY4f/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159A087D4D; Fri,  2 Feb 2024 00:33:13 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD705865D0
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 00:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=janga.la
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=rich@janga.la
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5112ea89211so1531588e87.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 15:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=janga-la.20230601.gappssmtp.com; s=20230601; t=1706830390; x=1707435190;
 darn=lists.denx.de; 
 h=to:date:message-id:subject:mime-version:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/gVh7D+troVWaCLRomVkR+p4O4r+zUtutXUghKBWC1E=;
 b=owsY4f/R7F0o/g5vuTgIK3WMdJ4Hh2fA1H3XTEuVThMJEVt5IrTamzpvAO2CweqGD9
 Ju6D8Tjol15Bftt+HsHUL5eG2CeGk0Z1NOYfqS7fqpxbmuACtqDpa2MdwsoF6+f0iERm
 HMgcZqXAIBQ6Q6tZSIdnAfKhL/qRuSZAsmu7MrQkbLdhQ8F8ybg3iHEyG60Y1PTKurkC
 TfFWZfRlgoyul9TH/0vlBr03/qFqTNCAbDgjRQGh0qmwY1ljpphZRo+26yLTDAibucaY
 jqL8nLBbw3Wyw1/h7slJRZkHOUM+DpMO4LkN2rJpFgcEmOVnwxYbxdoXHJho4qduVjpn
 osbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706830390; x=1707435190;
 h=to:date:message-id:subject:mime-version:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gVh7D+troVWaCLRomVkR+p4O4r+zUtutXUghKBWC1E=;
 b=H+Jk+M3lfrPzy3X3LELBLPes0Bq8/wHXlnYuUHBuNB5AbC7HajJO97F2pLn/Fb8g40
 FdPsvvUpAKho1awyTgvFuUgqHbBsmDPwtXPGBuho1Y7WwztOEyki8QSCHe9d27+9WWrg
 ExfjYjXgeBiDB2S60ZTA14N6oO73k9RcJD+C+hpJx8cqBeJG4M1I+nxzPtJS5dD780Am
 BYUafSgIdSis3DihRafygM85GjmYhkDAW3FvX3dQfQ+ZQiCfiPKKhiYIQmNxV2XifTsb
 /G5LLZJP+EXHQ09xAJ0PaANBGj7PI6faSZCTCiX3RhW92kQRKGf05ujvKXxTATbpJkeU
 xhNw==
X-Gm-Message-State: AOJu0YyZvy/ycg/e+MzazFG1X5FPDXttqwWaBJ6yetoYudnJlCqybowD
 xSuoXO5OxVhGtaDB5rDRBTMdnzRQTznNFUBh1/dgBn4UfxNHF9UuDw+HiY8al0Wb9g3Xl5GReeP
 +
X-Google-Smtp-Source: AGHT+IFvMuSG8H3aVLZQbZRjcpSxEJRFUo2mxujFiPa2pZcJv5AETsnW7BTW1AxDHOXVhEB+KOPdbg==
X-Received: by 2002:ac2:43b3:0:b0:511:3214:e02e with SMTP id
 t19-20020ac243b3000000b005113214e02emr219854lfl.23.1706830389669; 
 Thu, 01 Feb 2024 15:33:09 -0800 (PST)
Received: from smtpclient.apple (05429bed.skybroadband.com. [5.66.155.237])
 by smtp.gmail.com with ESMTPSA id
 bd26-20020a05600c1f1a00b0040fc5ccf3easm362675wmb.38.2024.02.01.15.33.08
 for <u-boot@lists.denx.de>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Feb 2024 15:33:09 -0800 (PST)
From: Richard Thanki <rich@janga.la>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Help Needed: No UART Output in Mainline U-Boot on MT7620A (ZBT
 WE826-T2)
Message-Id: <F0530B92-2BF9-4752-B1B9-273E80269947@janga.la>
Date: Thu, 1 Feb 2024 23:32:58 +0000
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Mailman-Approved-At: Fri, 02 Feb 2024 01:05:24 +0100
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear U-Boot Community,

I am working on porting mainline U-Boot to a standard MT7620A wireless =
router, specifically the ZBT WE826-T2 =
(https://openwrt.org/toh/zbtlink/we-826). After building and flashing =
the mainline U-Boot, I'm encountering an issue where there is no output =
over UART.

So far, I've tried the default configurations for both MT7620 RFB and =
MT7620-MT7530 RFB targets, with the latter being more of an experimental =
test as my board lacks a gigabit switch. I=E2=80=99m flashing the =
standard `u-boot.bin` image. I=E2=80=99ve tried disabling the 'skip =
low-level configuration' in 'make menuconfig,=E2=80=99 but the issue =
persists. Despite these efforts, the router's behaviour remains =
unchanged, showing the same LED behaviour (one of the led=E2=80=99s =
infrequently but regularly flashing) whether the new U-Boot is flashed =
or the flash chip is entirely erased.

In comparing the Device Trees (DTs) for OpenWrt:
- =
https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/dts/mt7=
620a_zbtlink_zbt-we826.dtsi
- =
https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/dts/mt7=
620a.dtsi

with those in U-Boot=20
- =
https://github.com/u-boot/u-boot/blob/master/arch/mips/dts/mediatek%2Cmt76=
20-rfb.dts
- https://github.com/u-boot/u-boot/blob/master/arch/mips/dts/mt7620.dtsi

both look similar to all important characteristics. I noticed both use =
the uartlite for serial.

I=E2=80=99m using Ubuntu 20.04 to compile using OpenWrt=E2=80=99s =
pre-built toolchain.

Any insights or guidance on this matter would be greatly appreciated, =
especially if someone has experience with UART issues on MT7620A-based =
hardware in mainline U-Boot. Resolving this could pave the way for =
easier ports to similar devices.

Thank you in advance for your support.

Rich=
