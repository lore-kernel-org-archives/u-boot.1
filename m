Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A477C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BCB38785C;
	Fri, 10 Nov 2023 17:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OnVjli+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22BA387852; Fri, 10 Nov 2023 17:21:43 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA488784C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-675b844adc7so13195206d6.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633297; x=1700238097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uT/G5rtgvucPoXsUWVfw9PO1XJ8e73ClZqJcfOJjXpE=;
 b=OnVjli+uyiedJVjEyBTML51qfhmItpvThcmjdkfLgpbZqqyTZZg7p80ge15uojH7zJ
 x5p4e0+jEnsoVjNR8JJtv/x9TH8Nu2nafiB5zgK4o0GHaUwPsSHjdeE4KXnm52b2Phgz
 aB6rRGrojbViCqivoXZRt8e7pWzsLQ9SwKBDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633297; x=1700238097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uT/G5rtgvucPoXsUWVfw9PO1XJ8e73ClZqJcfOJjXpE=;
 b=eCT+tkR1Tt7oT36tZV6BACa1O7jrSiqPFeKHleHNaMMpVYu0Qxam5rk/7I17VGm1u/
 jwNBp22GPiwOcrgtW/mWnh1ibH1iZHJX9+8WqPONriu4k69unUCsFCXHCdBvWorVw1LR
 Iz90Ww4fCZQp/z2PNVIbv5Kb/GEAbXI2qvjqBfwyYcx/K64/boWUp10lwrSXBhruvCGC
 wbqzUqIUN08xRuRi+NguYxO5/nps3UKIfHc9OGAwc6TNR/M5GCtYi3Mino/SNgTB98vS
 TU0Zc2h8OgPaKNTqhY7oDJfOOdIPf0imRRB6kupGfzZyNirkD34w5NQ44v1VndOG2mvz
 7ZJw==
X-Gm-Message-State: AOJu0Yxq06IZ4Mahv6a61Tmp34BXsTB80cBKOY5zS9B2kMJuhGMcmUxn
 GXeZcXvpbN1FavsRHv6R8HsdIAjDzPjoQt9pboeKvA==
X-Google-Smtp-Source: AGHT+IGt1CCN+HYDQDWZ6apFvGXBKuvW+7PpiMpQWvOMbXj5+7vTPKy0ukCctsvZXIJWaU/71wmeVw==
X-Received: by 2002:a05:6214:238d:b0:66f:bcb7:fe2 with SMTP id
 fw13-20020a056214238d00b0066fbcb70fe2mr9380716qvb.6.1699633296711; 
 Fri, 10 Nov 2023 08:21:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a05621414ef00b006562b70805bsm2984351qvw.84.2023.11.10.08.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:36 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2] bootstd: Skip over bad device during bootflows scanning
Message-ID: <20231110162134.GX6601@bill-the-cat>
References: <20231102185116.21708-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lMVE/0tk4Q7VtET7"
Content-Disposition: inline
In-Reply-To: <20231102185116.21708-1-mibodhi@gmail.com>
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


--lMVE/0tk4Q7VtET7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 11:51:15AM -0700, Tony Dinh wrote:

> During bootstd scanning for bootdevs, if bootdev_hunt_drv() encounters
> a device not found error (e.g. ENOENT), let it return a successful status
> so that bootstd will continue scanning the next devices, not stopping
> prematurely.
>=20
> Background:
>=20
> During scanning for bootflows, it's possible for bootstd to encounter a
> faulty device controller. Also when the same u-boot is used for another
> variant of the same board, some device controller such as SATA might
> not exist.
>=20
> I've found this issue while converting the Marvell Sheevaplug board to
> use bootstd. This board has 2 variants, the original Sheevaplug has MMC a=
nd
> USB only, but the later variant comes with USB, MMC, and eSATA ports. We
> have been using the same u-boot (starting with CONFIG_IDE and later with =
DM
> CONFIG_SATA) for both variants. This worked well with the old
> envs-scripting booting scheme.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--lMVE/0tk4Q7VtET7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWI4ACgkQFHw5/5Y0
tyx/cQv+K0g1wpwUZgzoQDOIua9bKwhWxHBkQ/npJXlVTuCa8le/0V8qsRHtXnIM
3ASyyGhzbQrJVXI/TbFjjdj+8MK+8x/dCHbtaS+cJ9Clwa/6uJ5NCXmzyaYlM00R
BkQAEGJ5Ek/1XqKOsF2J3wlkfExHbOuCdld8PsM0N4oS1jaieYitrcnbtpx9roPL
m4VpPf6eG6al98HwiSsnLhEIb6vWL66iNedYW74cYu+ixh7+ewbn/WAgYC/YLE2T
NVvrQj0tjvhJhBM6cm6R8e//AxWsj0lFIDMNaR03VANWgzRBwjcWos4MCX0hr2Bc
vYTI2tF/bju46t+2UUq0vzPJLlzy3e2Oth+5jNZHu2iotNk/IW3NdJqo2YS1CYUZ
8PYyUzJeglWK1KLSVfXiksceQLi7eLUbWU/PGPi3xoBFXsJIVXwxFAvGPKZ5a4yj
CaqGitHQZ/B3dO6v+rnVGqybeaktvLnZzffhuQaupk3sXjMrgEdxNiUlO8LAJWi+
EyBOCPkJ
=hsiP
-----END PGP SIGNATURE-----

--lMVE/0tk4Q7VtET7--
