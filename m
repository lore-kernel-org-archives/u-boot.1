Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B94ED26D85
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B470E84390;
	Fri,  9 Jan 2026 19:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BwpOh02w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 426298436C; Fri,  9 Jan 2026 17:57:08 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CCD84206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 17:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45358572a11so2712000b6e.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767977825; x=1768582625; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=su5NtuOSUnTfrG2Y7vIlhTQbXQiudZHp/5ydSZd0hOY=;
 b=BwpOh02wLiTZYh3thG3ISkj5Sa4iCvs4/tze8b9hvhfilNf8yfDkEG8pKw5X5iJjY9
 NmLEEo9BfUQhDIEg29lNWiiHkvnETLKXFzo9oPEE/7v5CYBGuZ8JR7ejq13u/GVC7Wxl
 ZQSDYtYm0NF1GsH3N9g59FjtihwyYT0Xkll3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977825; x=1768582625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su5NtuOSUnTfrG2Y7vIlhTQbXQiudZHp/5ydSZd0hOY=;
 b=JI/JU06jSG8ijakZrRCTA/Unl5gwGaURsa2FqoehkR9pDIldJ8V3rhFQRisLicWv1h
 gYhaBs1Z+qWGjgq7yVLYARuvXbt3hWEbRakxhhPmC0hWKrrOXxMOSiCx/mat7gCGQhZC
 Qf5U+L0CRhzVG4K74VTNQidSjqqbyuMt68ZeLi/AgjV0MEWMXYSTxwT1Bdo7//L+j6zJ
 kOYAL3wgD9i3euGRMMsyO/GXveMN0bvDA2CSjkcNMQ+tgAQ4hzwp42QgmoQHL4pJ3Hzw
 3siCDG7fw/wMf/6NASfBjZFaqudobLLBO7hg5i8wsAAFYFC/DgeNKU6tKHWBdIEuUWVJ
 XEbQ==
X-Gm-Message-State: AOJu0YzrWf1aL4JYvbfTZn0zYug+3K4+k1qYq7OGK8VT2wMNAhDhnub9
 9zoBEmA1CzQ0Zfx2zWv66SeG9eTyoQXX/pVRhf8JiNAeNT2tUWoQPzAogKIak/Mg+zI=
X-Gm-Gg: AY/fxX414bEuXyLxhJemaEsTRsxkPLPlkZuGHoqvIdgDIMpzyiuoGhlkb5CotS9FX4K
 xxlRP6tPUShJKjgyYcjc7dYsKTz77wjUtHxZeL9Ojxpt1ypgTaWgDoRqSNvfB1TUc5h+dYItEYv
 qikn9Pg2Sz0zK3i34hV9bYclBS3sV0r7GWLEH2ykjPRFItt40IdSq2b7+tKCVzcfW+N+ZyiWJWF
 c1YsGVTH+sd6PxE2kDtEIy38jYO+vqwG572nYZjSoF3+nvzdNoKyWHvcRBE9NwSlTK6B9odKSIP
 RQcn8d457jY+7vJYkZs/EuD6CG0N14VJw4eAtNRq54vQPfWlXuwmJpYRNUoPabKDvhJrETX/ERs
 uSkeLYTEVm1M/0esrBzPKK7eglkVUnCBiapencUIFRSDjekECCb3/Yz3CIYVnWRfmAFcGxRcMXA
 0UTVvzNOGr34nMAELHGegg6ZWA8mgDr8mjUBNSJXb9lOmZ2UtWo2HBwitmmVI/sLKDeb+xgKC7Q
 cQOQ1VVTbMec+jMLrHIO9aBw5Pdu+mm0zOKr28=
X-Google-Smtp-Source: AGHT+IEw8dZEsNYFe0IQgYD6ZwcIc3iScPQzMHIDEcMIwAszoKBC4fxzB6NvbonFaDM73t0mLnbCCw==
X-Received: by 2002:a05:6808:2744:b0:450:b249:718c with SMTP id
 5614622812f47-45a6be7e989mr3771993b6e.31.1767977824711; 
 Fri, 09 Jan 2026 08:57:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a8c6b3fdfsm996860b6e.17.2026.01.09.08.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 08:57:03 -0800 (PST)
Date: Fri, 9 Jan 2026 10:57:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Rick Chen <rick@andestech.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: Re: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
Message-ID: <20260109165700.GD3416603@bill-the-cat>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107010416.GM3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QOrltk0cxJDYCMgL"
Content-Disposition: inline
In-Reply-To: <20260107010416.GM3416603@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 09 Jan 2026 19:36:35 +0100
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


--QOrltk0cxJDYCMgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 07:04:16PM -0600, Tom Rini wrote:
> On Tue, Jan 06, 2026 at 05:31:17PM -0700, Simon Glass wrote:
>=20
> > Each arch does something slightly different before booting the OS. Some
> > archs even do different things depending on the CPU type.
>=20
> Not that you should v2 anything right now, but, all of your patches are
> doubly signed off, which is wrong. And, since you're no longer at
> Google, for stats purposes, where should your contributions go (and
> would you like any previous pages re-generated) ? Thanks.

Following up on this part, as I need to at least update gitdm, thanks.

--=20
Tom

--QOrltk0cxJDYCMgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWEzWAAKCRAr4qD1Cr/k
CiU4AP9io1Mba4pQRNZB0QGCiSQmp/xKZyRa+yGAyjqmfCgXlgEAo6tNj4SIadjR
kXSpgg+GO3kloqzAF6v4uVe/gFUUwwI=
=KxxO
-----END PGP SIGNATURE-----

--QOrltk0cxJDYCMgL--
