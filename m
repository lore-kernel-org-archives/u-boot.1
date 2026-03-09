Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F16EF371A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 09:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23268839DF;
	Mon,  9 Mar 2026 10:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bKpBMQh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F35C83A8C; Mon,  9 Mar 2026 10:05:28 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414EC83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 10:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso14938365e9.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773047123; x=1773651923;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ewZpSNKQpkoPaKEiT5/IIf36Q/pndUsUr6eLbIAoZSg=;
 b=bKpBMQh0rIeO5ZCqX2xXGqo5Ym9+gAQ/6pfne7J0TdVYZfd/hQstil1C0KFjTJY/Nz
 UD3L4x/lZpWEDYCAe+N0zXxiyqNSrR2YeLQ8easBCuk3UJl6ZFZokxhQ0TeNGmm1HIUa
 mEQnLIXW+9tYKhJD40zAu/hdH2C/KvkbTuP/L1qFIObvGWM+B3Fla4S6jT02v/3vosoC
 wyAD6KGleOyRI5OXJuJOh0VA5dhNd6MVwQKfH0msn87SmeyJKuWI17waYckx2M2qlw3/
 pwWksXnZuiZgb0IalTiq0AizXIIrkYlitPs2Od/5XOmvjg/kRLVVh+xT0z6mBLVV0KTs
 Agsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773047123; x=1773651923;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewZpSNKQpkoPaKEiT5/IIf36Q/pndUsUr6eLbIAoZSg=;
 b=Ym6ESm1TmbcNc4YRFUwgBmXS8yDU1SUzL3S/KpAn1jY/Q0ZvXH6F/OKjUVnHFrENk+
 Hxp4QDphOm3GIr3H63bPxa50TfJnc8ac9ldUnd49A/xMkokAnfV8GnppSgFfr4LE7zN4
 csvCdWOtZ6s46IPJXLL6XhWTrQh8H+mubeegME9goCGehE0BqGH2bFM6RpEROEGmL1ne
 ZQ5V34KaqxCfXAvYL9pPmuzjVM16BIBud17+HFm8TaHoUaIDk4eWfinVjbwl1r+c/gi1
 pzFHcIkkoKAt2jELRU7b5wABms2/CRkMo78vSrPWNAh7SlEw/QajgKTzJxr0OcXAL1vp
 QnPQ==
X-Gm-Message-State: AOJu0Yxe6Hnn2tiNLsYP7J39gHTwZ00A1D9MBD8nvLVlVXJEgTVXVd1q
 vthhvMBYsiVSpcheK/4nAJ+QFhlqlwbbC5JVpHGFVzbqejWbiCSQW29SogxbLmENodw=
X-Gm-Gg: ATEYQzwfMeNoGtpiZbMPjdqBOFhm/gHzwdvUTsDjNh8umYaFh5pkw/nVAJ2YceTczXT
 RjJ0wx7koIW1dJaNnmgtoT3onrdlYcoogqY2OmnOVJKRul1Y7ggFS5h/gACTU4Kxf2YFNz1weKJ
 OnQE6dtV6ZKcT/htMIyv3XxHPuZJrBzckvFv30V1qNspLdr+D2qzXLIA9F9BHHCc09Wf2Ewyr2f
 77eZ/g2RGLFnIvD2Klf/J5v8sKcRdV4gyCWV090ZFtdhUqrbFY8mcpcVNKLza5HVHnmK6Y97Txy
 /Y/z7vU/0dK0NwskqhKtNFmTYlzqo2eqdH6uQrdCyVy9TcfCAsL+88OMcB8VE3UHix9s37PaD2x
 49U9clal5hd/Nu+vPaxlb4BOI/N1aQpn+GwfZdU6pnUlHnqpHtuppZqU5S5bx9k8tSGchoirA4y
 OOHl+1nf3alNgg+AU=
X-Received: by 2002:a05:600c:4591:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-48526978664mr167709435e9.34.1773047122406; 
 Mon, 09 Mar 2026 02:05:22 -0700 (PDT)
Received: from localhost ([195.52.25.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48534fa65a6sm75865005e9.2.2026.03.09.02.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 02:05:21 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c3fe5a942fb8099bdb8f7abdc87e4fbdc88c22f16a732d95df923f963b8d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 09 Mar 2026 10:05:10 +0100
Message-Id: <DGY4QTSVH7B9.21Y389AGHLKPM@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>,
 "Rasmus Villemoes" <ravi@prevas.dk>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 00/10] arm: am335x: Switch to upstream devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
 <20260306151106.GL1388590@bill-the-cat>
In-Reply-To: <20260306151106.GL1388590@bill-the-cat>
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

--c3fe5a942fb8099bdb8f7abdc87e4fbdc88c22f16a732d95df923f963b8d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tom,

On Fri Mar 6, 2026 at 4:11 PM CET, Tom Rini wrote:
> On Tue, Jan 27, 2026 at 05:48:14PM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>
>> The series is split into two logical groups:
>>=20
>> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>>   with the current u-boot devicetree.
>> - Patches 4-10: Make upstream devicetree working with uboot. This
>>   adds tick-timer, adds compatibility of the board code for different
>>   USB probing and updates the defconfig.
>>=20
>> The series has been tested on am335x-evm. Note that I don't have all
>> other boards built with the am335x_*evm_*defconfig, so tests are
>> appreciated. buildman reports builds are working.
>
> Bad news, good news. Bad news is that this fails on Beaglebone Black:
> https://source.denx.de/u-boot/u-boot/-/jobs/1392729

Indeed, bad news and good news, thank you! I will fix it this week!

Best
Markus

--c3fe5a942fb8099bdb8f7abdc87e4fbdc88c22f16a732d95df923f963b8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaa6NRxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMQ
XwD/aFmDPmM4ui0lTgJihD6W79SIW1a3fOkUWNt2+xVkUWQBAKAx3iavtTnyFQuV
l+k/izS6oNpBLvAXMVp6qwSD9cEL
=9uKv
-----END PGP SIGNATURE-----

--c3fe5a942fb8099bdb8f7abdc87e4fbdc88c22f16a732d95df923f963b8d--
