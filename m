Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1698ACCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 20:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBF083AEE;
	Fri, 31 Oct 2025 21:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TjAGsx4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CA283AF6; Fri, 31 Oct 2025 21:17:11 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B3F83AED
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 21:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c67d9577b3so1886991a34.2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761941828; x=1762546628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IRxSOmHjJLBJ6hJbfM9BAJHsch7rvd4YYbuBRx1M+Wk=;
 b=TjAGsx4l3h8RkcqkRTiDv1dJlIgztrr3YlA7dpZ6DULUz6YHalPgdBxrCNG4vddjuo
 dyKVGJuNLQtpXd/ZK1odm6D6YsGnbh4X4whiwu4sQTsSPOBwu3a832caoYgashL68dcD
 aJDdHdX8cJgdEOya/z2y3G9Ufy94OOoYotxB2fYsrFhn/a38OEmbiHzWnXuiqlaPxiEf
 rOGkUtBoEIGPTts06tP9oEcUnHnmg4h+ksp6IDykvAMALHZieZ+/RrZ3s1xbYbyEx2D/
 H0DdSVBOycSFOMDHHsnPWiWYl2hd/7lvTtoPlz6I/7wfRupdXD16wu1XHMfeLVkzhpI6
 vvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761941828; x=1762546628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IRxSOmHjJLBJ6hJbfM9BAJHsch7rvd4YYbuBRx1M+Wk=;
 b=YouTTj//As3cGeh/FHwOV2IIAycxbUMOoVlMmZYGKg+NgsYRgA1HGPqURgi7YeJFFN
 aQxLQhZgq+57HbaGbOvFECbpNiQrCPt8dcEXrWadSJ3X+0oy9ZXecI5IniPSniuUoF9B
 iLfvvYU7q2wKCTF28ZTGVx5tIUIiZ/5idsGIEPYNDRPzB2O/IliaoQsEofB7N4LiJ148
 pZ4AbifowCmZWgUgxFBlGgfVQjw20huwuNfV5wr+f7zq8Kraw+uCGOCeSMObWV7zSE8E
 Xyb0KFT69bbloN9jE6OTjG8HbGR8PdceiT3sxzykN/qR0zY+jqzMKXa/L1fJXh3ZV93w
 c2OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj0a0gIzCRfLVgIBCSgSkklxXEG+Y9vIdOJTA3FrVPlWVKOnpkWXjXoewTQshJC4gJSTKhajI=@lists.denx.de
X-Gm-Message-State: AOJu0YxLuI0RbjrqEmXexKoWyPWHOzhlp73Yv+08VtAhRBbwM7qtxqbE
 UFz76Lt7zYfw1874IYIwsv4eaRjxmTfpUjrtHO8zDu6VU/QGzYMr6h7jI4kbVKD7NPiRov7Dtl1
 jZW3gMZHMrQ/e/EsKJ242vfc1UZ8XYCo=
X-Gm-Gg: ASbGnctxtNnrBp6P8z277qiwAjM/TtZZ8t5BpfsYd6gVFgIxWd0lIZNide8K11lk6qR
 Wv65GsaJXRno3Grgc4PEJDgpub0yEBf9Fwapd+mFRjGQ6iS9YjSU10LoqlT0PI/Jn2HE5GJPdmZ
 rTjXVUxpj0rJcIPUugn3TYIqakVz0f+7WbmUZgtXF5/PpaWf0YmYVZvoCOqt1dl4Aq6IZoOEMJZ
 zAGCBvGq3nq/rMPYFMIj5BY1x9k/rH2FBHJ/2LXHOFfApf8wXnw/lew+DaEpvKW8Fi7E0DLsNlv
 9BQJ6aI=
X-Google-Smtp-Source: AGHT+IFbgGmNSpoWEwPEJ1Aykaehk0c63zqx9NAGlhfMlvlFkE40R6YNAVV2GQWnQcJv5lCKgugVAgAVWEAiFnnfzCo=
X-Received: by 2002:a05:6830:2b06:b0:7c5:3bd4:18f6 with SMTP id
 46e09a7af769-7c696715cb0mr2890298a34.16.1761941828087; Fri, 31 Oct 2025
 13:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
In-Reply-To: <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 04:16:57 +0800
X-Gm-Features: AWmQ_blf3rpwlOrC4bA2JxsP2WFNrS12mtn9GnCODFb2l-PI2lQ2Y06GNYFSQWI
Message-ID: <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> Is your issue specific to a reboot or cold boot?

First got to think in logical flow. As the SD card fail to pass the
detection of valid SD card aka -5 error then it is 100% impossible
to enter U-Boot user control phase, same as kernel nor distro.
Hence, also cannot do 'reset' on U-Boot nor 'sudo reboot' on distro.

So the answer is cold boot.
However, do reboot also have issue? This is not tested yet as
we got to solve the regulator behavior trouble first.

> Try adding something like following to rk3399-nanopi-neo4-u-boot.dtsi
> to add a 2ms delay to ensure the voltage for the vcc3v0_sd regulator is
> stabilized when it is enabled. Or any other timing that is required.
>
> &vcc3v0_sd {
>         startup-delay-us = <2000>;
> };

So far i got to comment this in the dts in order to boot.

&sdmmc {
// vmmc-supply = <&vcc3v0_sd>;
};

> I only have a NanoPi M4B from the nanopi4 family to run tests on.

My board is nanopi neo4. If my reading is correct.
The schematic on your board is mostly same as the neo4 on SD card.

M4B page 19 [1], NEO4 page 18 [2]

Should able to check if issue can be reproduced. The LDO itself could be
slow as this is not digital based LDO, it is old analog control-loop
one I guess.
Meantime, the RK3399 may not have internal ADC or HW to sense the rail sanity.

Brian

[1] https://wiki.friendlyelec.com/wiki/images/1/16/NanoPi-M4B-1909-Schematic.pdf
[2] https://wiki.friendlyelec.com/wiki/images/b/bb/NanoPi_NEO4_2008_SCH.pdf
