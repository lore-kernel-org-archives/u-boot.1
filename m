Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B58E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C11580600;
	Wed,  8 Jan 2025 19:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1rBIyBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC218036B; Wed,  8 Jan 2025 19:25:38 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563D7805F0
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7ba0fa25f07so6041485a.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 10:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736360735; x=1736965535; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aU9a/jbbauoN74iUbFc530sj853usRKnJ6wCWSV1weY=;
 b=k1rBIyBb8xu47l2Jf52A6oU7qyMJVt65mguKFotkrHgtP12shtzKNdjEz3v05CC3Yv
 ktBBU+XEs71gHYZk++LsxNvZtex6dR0IZG7nKUiKL3CpONed7nHrib/X7BIi/JtmV7WZ
 nMtiMu+x3GcvWx/SPPnKZDJc1YMdg5e4UDaDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736360735; x=1736965535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aU9a/jbbauoN74iUbFc530sj853usRKnJ6wCWSV1weY=;
 b=wY7aTYVJ64DPQ2Szyxj+BQ5QvAMySieAvwMgm4SqMmyZVtvtnW3tkyFR2JHloRf+yo
 9wS5bqrqiAYY79cLvG7Bz2LJjwc/NZC7xjhbBwYObydwpH5RCV7QmHvX9UI9QwpLzm2N
 y8hZHJ2BY9LYw4dHPa1LLeb3/qAE/uZ+LTKzY/T4dwJK4Lvgu7NzZhe6lt1f9Kps65GZ
 C+FFsDO8YU10QmA2Loi7m4WT0HQylSqdCMQ3bhcu1WmiXMHmv+NGd+sfSOinxyqQrBGl
 JQRPNTXOpPVg0BEA79ojY3zi9Y3DzzV7kuhy59dtKEfXKQg7Eo/mi6QzEoGawKgBQsXj
 mQWA==
X-Gm-Message-State: AOJu0YzhuFwj+litBRHgVrWHC9I/cNUq2WTwAVAqO4JlzwkTB7oSTdE4
 tJzaFTCxDfgnJsxfAcgmXBA+WF7reip+u5cnvryZs+W896x9IotiziBImvkP5Ck=
X-Gm-Gg: ASbGncvfoLIlwsp+65Pz0Z6f/ItLSawuatOIeidEjoGJKlLmP4x5FguWcpFuO2Nz1rc
 hscqOSLScElC1M7Nf9j+cp00m6Q9Ol1X/cL2hy++Fkn+7DmkYtqruqOUvPuOczMjJidtIORh+KC
 3t9Eyuymd1yUIxa0W54u7OYq+rjh8rC6HKZAXLNcuxWFKrbe1tSIBMhcN8AIUyDMpHKA9ttukdS
 M69C1v8z1wMxDAi0BrP4ozz9aZWRtel+8iUs9b2dn+6uJ4v6Hni3ZQ=
X-Google-Smtp-Source: AGHT+IH8BOzMa/zs3jvN/KqzhsvJJkdVI5oMyV3KAK/DNDoXR8akscg/NVLoJo/j9dh1jT6QNVB7Kw==
X-Received: by 2002:a05:620a:4626:b0:7b6:eab3:cdd6 with SMTP id
 af79cd13be357-7bcd9762276mr531311585a.46.1736360735199; 
 Wed, 08 Jan 2025 10:25:35 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30d319sm1692767385a.55.2025.01.08.10.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:25:33 -0800 (PST)
Date: Wed, 8 Jan 2025 12:25:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 17/33] boot: Update fit_image_get_emb_data to use abuf
Message-ID: <20250108182528.GN3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="skJvvt5ux+2tmCWS"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-18-sjg@chromium.org>
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


--skJvvt5ux+2tmCWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:32:13AM -0700, Simon Glass wrote:

> This function uses separate arguments for data and size. Use the new
> abuf instead, so that they are paired and in one place. In some cases it
> also saves an argument, thus potentially reducing code size.

This is one of the commits that globally increases size in both full
U-Boot and SPL/etc.

Is all of the "abuf" changes just a "tidy up" that increases the code a
bit?

--=20
Tom

--skJvvt5ux+2tmCWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+wxcACgkQFHw5/5Y0
tyxJRwv+IoqTUiyUdP45xzB22gwJFdcFgf5vlBNyoBB8Uos6vmVw2UF2bQbvgpWk
uhzGJh1lvRJmbi3VW4HnrpBz5PtwfXeAYAIAf+gw90sNf7Pno9YpKehyB6PCAL8C
eskOQY/N1GndleMtCGghdv16TyW/uh74bfTPmkc4+i5mw+5n0YZrC+0xdpu+6fi5
1Zv4/TOqm1dC2HxnlU5ok5C7TjoCa3nCzFnZfxqWOuYPefUHSu2VY9IX4CdLZp0R
h01SjRVZFsT4j48Jy9UO9euyzMST508q/oSBsPcdJ+s9hdoIT5bQnxHy+iU9fZdr
APdzPL6CRjpKwIHx38XcZ2Msezi/pq/TaouQ/VsdMRHPK7uLTFiBm1cu5FxU1uKi
wzYIGa5c1qNHxv48aQ2/978sF6BLFbS+IV5zttx3fGJX4I13he7Byfa24fKzukB+
pK6g7btBLCcXVcQYXpcpCzZkFZV8JKdjnA9R2reGO0mnb8jlrpskfVXXYrd001F6
o7lqWC2r
=cBOx
-----END PGP SIGNATURE-----

--skJvvt5ux+2tmCWS--
