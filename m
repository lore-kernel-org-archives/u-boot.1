Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4901BECD9B7
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 01:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7DE831AC;
	Fri,  6 Feb 2026 02:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fm9lXhze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 865D68341A; Fri,  6 Feb 2026 02:27:19 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6338883015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 02:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-663170b9472so956374eaf.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 17:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770341236; x=1770946036; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0toXHnaMgdpzK/j53n9UzADHT9TBFp+Qs81/Uws0zSQ=;
 b=Fm9lXhzeY19f6a+wlr699cGje4j60978j9N0FaIA/KhwTIk4844nUcls/aoX5dyv8c
 Fia13RVo0R1m5FcdvNlkg6AKAL1D5MZ3eHyJHyNDWYchZW3sy6QwTdmdIJUIVkowNQ/W
 xGVD1Oa/AZ6takybmKShhpRTU9xmzUUKqzlCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770341236; x=1770946036;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0toXHnaMgdpzK/j53n9UzADHT9TBFp+Qs81/Uws0zSQ=;
 b=ZE9fP8cplofyJwHtxlBo4oL3lQD14RKRF/Zy5Py64nzW0+bD1Td8lX6lwXsoTcE2aa
 abDKsFU+Vcb1fJGLezZm9PgD0Qagsy3FgIuNVtWqzaSXcYLJBb4jzhgAXrvQISOUMq+F
 z5V0B4rgRGXNBlyL11ENDfBiH8kFjnt6/jxevN2qpb9m0hoxtoss6izX6AXI8qP86Ekr
 OK400sXyEA7dqhlcmuICOPYrUsQb2IiW/grzlY6D0stbR844uoOBXBrdLzCXIgkH3QFB
 3qeG0HsmS0wJLEkuzb851hZmOQFJ1WyxvcjpihP98EMVQV3tNJJFp2y+gfflWtClaTZP
 rukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRTp4xmv4cFbHgsWiLjshL8kXQtUhY81cJPjtTU7aZepyqQpwUdie+E+DeSzkP5N6m6CXIUKU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywwjn9kXbFw4mUz0lUzubVk+xQOAtU/qh4rgdNjWU5xnLpjZyvW
 iW8L9Hb5jEcsf5wEdec+hY44/FSDUoullQCiCdyZ7My8OKm/sCY7cocsB5QQwK46ICQ=
X-Gm-Gg: AZuq6aLAsYRo/ulYMhm8Q2hXFH3eXM7GFJqqRqrrWa6JH05uiIv5pa6uQg99tMce76F
 OTNtv2DZF/1qRiU+jRd4+TNfG+l3jAtZYUagpHG/+4CNr7iALBPt6eWyXi6CurPhyJEVOPHeo8T
 wLQGGiUDgpe+bsuVYY1+rbGLw6502FwbVE4mBh6nXOfuA8u9koFoYXU59xITMNCcbb/P6nZK2iV
 5j+CQ2qYAQZmkUtDLtlJZzDq84OxwZ8C8/BtH0kdUXJsaAIgTWgPai2np+i3PC1gCT7Ol3oj7XZ
 PU4LpPJGmgTOVEURDYyUjVpAS0aoWvpw1x/wPqwYMb4dZicXkfuYNKOTQh8XChNl2xnthCEPfH6
 a0ba8LTOYY8g6n3Lk9whAE5D6HJNKTK4R3p8MksFjBQP+vKbdSKvLfH/JkhfXt3tu9t2pId/zhD
 wRxde4/aa+e6PlD176PMo4VfqXw87pxEhyyVOkv4FjZ+iRXtfYIr/CZNMothu5WXEZHfoCm3apj
 5n7Cdxako2e1nps0A0XkllBlL82jaA0SeMD7mQ=
X-Received: by 2002:a05:6820:151f:b0:659:9a49:8ece with SMTP id
 006d021491bc7-66d0d3f51f0mr599256eaf.82.1770341236069; 
 Thu, 05 Feb 2026 17:27:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm415300eaf.16.2026.02.05.17.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 17:27:15 -0800 (PST)
Date: Thu, 5 Feb 2026 19:27:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 11/12] arm: dts: Add U-Boot device tree for i.MX952 EVK
Message-ID: <20260206012711.GN2603314@bill-the-cat>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-11-2103d0222a0b@nxp.com>
 <aYU7EMvw/l6E+Cdt@shlinux89>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0aelywyNWe+ph1p3"
Content-Disposition: inline
In-Reply-To: <aYU7EMvw/l6E+Cdt@shlinux89>
X-Clacks-Overhead: GNU Terry Pratchett
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


--0aelywyNWe+ph1p3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 08:51:28AM +0800, Peng Fan wrote:
> On Thu, Feb 05, 2026 at 09:55:17PM +0800, alice.guo@oss.nxp.com wrote:
> >From: Alice Guo <alice.guo@nxp.com>
> >
> >Add U-Boot specific device tree configuration for i.MX952 EVK board.
> >
> >Signed-off-by: Alice Guo <alice.guo@nxp.com>
[snip]
> >+&usbmisc1 {
> >+	bootph-pre-ram;
> >+};

I forgot earlier, here and elsewhere, upstream this.

--=20
Tom

--0aelywyNWe+ph1p3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYVDbAAKCRAr4qD1Cr/k
CvgdAQDsKNITNhKaaNL13zJi+14cboak+ibH+ANWRjzo47qq9QEAzbUe3G+O6UQc
9hDPQTBlZT1rr18zihGkA6fTZDDXjAI=
=8XYK
-----END PGP SIGNATURE-----

--0aelywyNWe+ph1p3--
