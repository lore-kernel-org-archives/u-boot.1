Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF2DFA1FDC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 18:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402FB8431C;
	Wed, 22 Apr 2026 20:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aKBq1hV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA27584370; Wed, 22 Apr 2026 20:56:07 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E5884227
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 20:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso54075495e9.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776884165; x=1777488965;
 darn=lists.denx.de; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wYcK8q2yycgz49Cua1BijVrsiuWegI2T+mesQeg7CNE=;
 b=aKBq1hV7Qj1JoSsBirbFkI2+tGSHSxYFvSrqWBpdcoYFBwC+KN0cBDTUYR1zdzF3J/
 7SFaI+XQZFWQaNOZNIwEZGyRCIYNtJ01jwuTvzpDSzEHaT+Rj4y461VAWR/hmQi5691U
 bvFhX+ng9/Dk6LUr9QM5cC2CQLNiT3Mr8wzTNQNU9DiUxsQwPZpRqxK/L+UJ2kms4W+Y
 CWSrOMe5zEHIPN9ZlYDX5grOSqNlrvoHeanAiaH0o0YkHN838B4K88CO9WtsW32EIlu0
 2tdZ0lYqppvFG0PsEQHqNYw6S9ZVV8n2eewiaGmbijSuvJS+qApr4bHZKuCV9oN3dGks
 OmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776884165; x=1777488965;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYcK8q2yycgz49Cua1BijVrsiuWegI2T+mesQeg7CNE=;
 b=O0XL3orhoE3o15tbaeWs3d2Sg6l5GIvW77bphgFmxP20rxINHX/QIGnpZ1oDuwTUIZ
 I7pZ85bxWdhtJ/ecGzvJo1hU1fj8tWD+N1R4ikxkDEoPGbqSZH5HQTM19BV4MijW8qub
 Ey+db3pax0qo9btb3/KvdBzTuV0EsV3s26fll03Gu+gwmqfwyvLnFO5/2wllV+6uKvuq
 6JyuDtmhPUpdxClrwNSG+j09VNDFYniKqQGp0dbBmFS4ZAJuTnG0TmeIQDRgMdE/E2nD
 34FlpmEGQPx5FBBdC700b2gTsWZ2cFYa6uSZ1i9Q4N9apHDtYElVd83zmq/ms5I6WSdc
 Ufbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YKOYwgonTLkRiH27GxTdPKwfreNpUgS5EZh91SyDQlljuHyrRYsBsSKDSKCR3QmxjgA2O7oE=@lists.denx.de
X-Gm-Message-State: AOJu0YxKwtBTvQArEAObIG1faQHTof97jokUPKXBDJU264G03B5jxQ+d
 n9JQ5k0upL8xUeKOd6AZbllQgaFelHcc1ldMROoY5bfyoILsP4arcSCaNAieOECCnYg=
X-Gm-Gg: AeBDieuYTGoGNDOJn6RGquRfuH5gvvgh0+BdXGwGizcn8gWTqGeBeQCgRhXszyRAjNO
 v4RCqaWmMffB9vSL588psbvjs4mbwV8LNfSxs+5z2XV2e/u8fcgKnI3Ti1CkYuTO4a4xhQGUHRu
 zgAsiS9vxStdBJLNES/CcHtL59QMrjdc6fUm77X1AWS6hBYWchMqaalTV78phh6h9xvHLhXr/EU
 IRiCCdvOk4HXB48jsCe7FTteTLYuZAHnrf5xEtwD78+Ne+HQQUCFB9FyZDEpybvVGw28hK289DR
 Lv4XduqwDu+dAWGcZJe/QoKKGNQ6xKlJFe0T9DSUPg8Hz8AfNAAw4d8jNOlqxs6aLpKLPR93Lqk
 WxWS2ieiQBJrlxbUkbO0qCbQvfoZbhhEmb//Ifr5v/3u7LzgHZZFgzZ5DJi9EwpNvIKjy26p14H
 p1N4xCU7+HbAioxBzNJ1J+ql4NMg==
X-Received: by 2002:a05:600c:5299:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a54514646mr138627045e9.21.1776884164631; 
 Wed, 22 Apr 2026 11:56:04 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891df9e50asm207554365e9.0.2026.04.22.11.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 11:56:03 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6a6266b9cb13efa3d567a9212531188ef2e5d1fac2a622573d2c6c3b69eb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 22 Apr 2026 20:55:55 +0200
Message-Id: <DHZWV3X6T3B5.2WVH8JEVPPH10@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Judith Mendez" <jm@ti.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>, <u-boot@lists.denx.de>, "Marc Murphy"
 <marc.murphy@sancloud.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Kory Maincent" <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, "Simon Glass"
 <sjg@chromium.org>, "Anshul Dalal" <anshuld@ti.com>, "Michael Trimarchi"
 <michael@amarulasolutions.com>, "Patrick Delaunay"
 <patrick.delaunay@foss.st.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Tien Fong Chee" <tien.fong.chee@altera.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Johan Jonker" <jbx6244@gmail.com>, "Brian
 Sune" <briansune@gmail.com>, "Hai Pham" <hai.pham.ud@renesas.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@at.abb.com>, "Emanuele
 Ghidoli" <emanuele.ghidoli@toradex.com>, "Parth Pancholi"
 <parth.pancholi@toradex.com>, =?utf-8?q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>, "Paul Kocialkowski" <contact@paulk.fr>
Subject: Re: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <39c2f5f1-ba0d-45ec-92f8-2e87ddff1aae@ti.com>
 <a02cf44e-c7ad-4abd-a102-59ab1963eb32@ti.com>
In-Reply-To: <a02cf44e-c7ad-4abd-a102-59ab1963eb32@ti.com>
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

--6a6266b9cb13efa3d567a9212531188ef2e5d1fac2a622573d2c6c3b69eb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Judith,

On Thu Apr 16, 2026 at 10:33 PM CEST, Judith Mendez wrote:
> Hi Markus,
>
> On 4/16/26 2:55 PM, Judith Mendez wrote:
>> Hi Markus,
>>=20
>> On 4/15/26 11:02 AM, Markus Schneider-Pargmann (TI) wrote:
>>> The series is split into two logical groups:
>>>
>>> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>>> =C2=A0=C2=A0 with the current u-boot devicetree.
>>> - Patches 4-14: Make upstream devicetree working with uboot. This
>>> =C2=A0=C2=A0 adds tick-timer, adds compatibility of the board code for =
different
>>> =C2=A0=C2=A0 USB probing, makes SPL smaller and updates the defconfig.
>>>
>>> The series has been tested on am335x-evm. Note that I don't have all
>>> other boards built with the am335x_*evm_*defconfig, so tests are
>>> appreciated. buildman reports builds are working.
>>>
>>> Dependencies:
>>> =C2=A0=C2=A0 - net: cpsw: Add cpsw-switch DT binding support
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/r/20260410=
-topic-cpsw-switch-v2026-07-=20
>>> next-v1-0-c914724b13e4@baylibre.com
>>>
>>=20
>> I have been planning to test this series on a couple of AM335 boards,
>> So far :
>>=20
>> - am335 EVM: Pass
>> - am335 SK: Fail (at least SD boot regression)
>>=20
>> Pending to test:
>> - beaglebone black and am335 ice boards.
>>=20
>>=20
>> am335 sk:
>> without of_upstream: https://gist.github.com/jmenti/=20
>> e51e1fc1b25c19f94786ad39a38737b7
>> with of_upstream: https://gist.github.com/jmenti/=20
>> fc17347eff33991a78ce365c42a76a25
>>=20
> BBB boot without of_upstream:=20
> https://gist.github.com/jmenti/b8f7151e7666ca16b9bec7ec5b2efe17
> BBB with of_upstream:=20
> https://gist.github.com/jmenti/c22e017605d3d6c20189eaf3cfce6231

Thank you for testing!

> Seems like MMC enumeration is switched, BBB now boots to emergency shell.
>
> Also forgot to mentioned that there are more failures on AM335 SK
> than just MMC, related to USB and NAND I think.

Yes, the mmc node names are different now and it seems that's how uboot
enumerates the devices. With the next version I have
CONFIG_PHANDLE_CHECK_SEQ set which should use phandles to distinguish
them.

I found an issue with the USB setup which was different from the old
behaviour. The USB drivers were always probed which was only done on
demand before OF_UPSTREAM. I fixed that as well.

Then I noticed in the logs that MMC doesn't properly populate PARTUUID
for the one board because of the mmc numbering change and it boots from
the wrong mmc on the other board booting an old kernel and dropping you
to the emergency shell.

I didn't see NAND issues in the log I think. Can you point me to it
please?

Also I noticed ethernet is not there, probably you are missing the cpsw
series here:
  https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-next-v1-0-c=
914724b13e4@baylibre.com

Best
Markus

--6a6266b9cb13efa3d567a9212531188ef2e5d1fac2a622573d2c6c3b69eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaekZuxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlME
qwEA217dwHD33mJF30e1qnZcxk0Cm87RhLIoK6Zn/UjQScgA/RlENpMeZn3uwl8C
4J5qrrNMtxjoSUkzLLx9s1dOE2UD
=xxVV
-----END PGP SIGNATURE-----

--6a6266b9cb13efa3d567a9212531188ef2e5d1fac2a622573d2c6c3b69eb--
