Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AB4C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 19:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24A8801DE;
	Fri,  7 Feb 2025 20:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KqdSbkMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B26480207; Fri,  7 Feb 2025 20:53:47 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43DE801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 20:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hackpascal@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fa1fb3c445so2416801a91.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 11:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738958023; x=1739562823; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQo8LSORAtuG48m6Yjv7TLWv2a711FFMM0Nvl+SDq5I=;
 b=KqdSbkMHo4rbiHckx1YPDZeWysKThNiIL9oONIgvqvpvcZxhF0Zcss3HCPy0WdKkCP
 OkS69NxABCcmJq1zI4j8/RCVEqAO17YSp8IkSoJh7Q7VDwWyijXvEcZh1/Onv5lG/BhW
 O+6Vf09qF/w8lQ+eqWhLNuA92gsaGiSWs3iUA2Pjd3UN+Q/x0bF9ms98k6LIRm4ndHtV
 kD+aabP2EpGKEAADRTS/s4qbFCxyidAyfqGCSejJkWc69x70Xn/3YPsLGFlduGaVXM3u
 vibNG7OOlETsi4WhPJVR3kWLJkznDUDHuBLjKpk2kgp2YTLJ0I/bRhGQPXNU4X8HXWPa
 i+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738958023; x=1739562823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQo8LSORAtuG48m6Yjv7TLWv2a711FFMM0Nvl+SDq5I=;
 b=YXIqdv1ZUqVFcgaWK+3TdvznJDX40+mN8jWcSoZCYni4wX96vtjIbKwenwMV3Etd0x
 Ov+2/3axb7/MtAVwQv10eAv0e4aWWlXFJqaVNtC2KZ530unWG8JsBiOs0KGH/acHhWig
 2cEq7nvgptdOeE5Pgx7EwO7zIb2S6Ofc5+dGJMHzxjKq4Hx7Mx4J3mxW0U3W9agZ/hkc
 cHgnVDimmy5R02dI/a3FZijGqMCmnwZd8hrQk726pOSOjpwGZTJu/0hwfkgBMHmgazi1
 3tPLYysiyBMyHmcU+rLaO9i8Bf1COtC9WwKVy70a2VXUfOb3k3SJ1x0P6bErCwWCt3tf
 /+pQ==
X-Gm-Message-State: AOJu0Yxfs87ix4wCVXylTHlxwatuE6f6idTnd05BKlJ3owgVNokkWTSq
 kh3EOBqvhde23TjUdS6SVVH+wBk+wgluOJJPfwLZhLQTIuQNAXiNngxNyqAPP36tyAfBBE47Fd3
 ehlzlgvY+oRxvSfELoEuKmT/ff0vkXp/Q
X-Gm-Gg: ASbGncteF3q09Z8TIRDaNTvXlXT2dcreq2vTgUZfC1kYK/xcw04w3mS4bnXXBDhQ6G7
 zTi5N8abQfi6msKH31fDP4t2eV+hgO58X6xmyb7GgAGkoYuxhEbSzhTSd+JOiFlFdXozgW0BymZ
 PD
X-Google-Smtp-Source: AGHT+IFHnDUaQOs0UtrEhfIiEDwApDYy11ewe0t3lh/z+CGKv2ClzrHuOOoaYtHPKSl703INYX1194D2nY322tUv+sY=
X-Received: by 2002:a17:90b:2fce:b0:2f4:465d:5c94 with SMTP id
 98e67ed59e1d1-2fa2406b9f4mr6771012a91.11.1738958023096; Fri, 07 Feb 2025
 11:53:43 -0800 (PST)
MIME-Version: 1.0
References: <c2572b2b-c4ce-4deb-a110-1cdc4614c642@ext.kapsi.fi>
In-Reply-To: <c2572b2b-c4ce-4deb-a110-1cdc4614c642@ext.kapsi.fi>
From: Weijie Gao <hackpascal@gmail.com>
Date: Sat, 8 Feb 2025 03:53:31 +0800
X-Gm-Features: AWEUYZktdXPyDKW6_4D9hXLNQaCovUWmQ8kWd7NyXwXTmch0CtdfldV4yTDinhE
Message-ID: <CAN5eEr1-h-p9mZjqpn+aCduc6A9U1F+8t8biKrODimy3AM-hVg@mail.gmail.com>
Subject: Re: Help needed: How to Specify MTD Partitions on NAND in a Device
 Tree
To: Mauri Sandberg <maukka@ext.kapsi.fi>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mauri,

Here's an example:
https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-mediatek/pa=
tches/105-configs-add-usefull-stuff-to-mt7988-rfb.patch#L316

Weijie

Mauri Sandberg <maukka@ext.kapsi.fi> =E4=BA=8E2025=E5=B9=B42=E6=9C=888=E6=
=97=A5=E5=91=A8=E5=85=AD 03:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello all,
>
> I have a MT7621A basec SoC, which I am trying to update the boot prcess
> for. As it is now, I have v2024.10 based U-boot running and I can
> specify MTD partitions using env variable 'mtdparts' and use them all
> right. But I am looking for a way to specify them in a device tree.
>
> Linux identifies the flash chip as:
> [    1.830000] nand: device found, Manufacturer ID: 0xc8, Chip ID: 0xda
> [    1.840000] nand: ESMT NAND 256MiB 3,3V 8-bit
>
> If someone can give my any pointers it would be much appreciated.
>
> Thanks,
> Mauri
>
>
