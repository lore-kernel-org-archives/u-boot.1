Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45158C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF0D381FEE;
	Mon,  2 Jun 2025 18:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="so6/fCWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C0382045; Mon,  2 Jun 2025 18:16:11 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213E981F32
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60657f417c4so2004565eaf.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748880968; x=1749485768; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=77/xjSiSua3+DJ+3hA/AhjjUrFZycuAJdHSaJ44WT1g=;
 b=so6/fCWwhoWrBxlZXHx6nDK+QdziWUCh/Wb/qisBa65pMhZt/tXoIUEB3u7c6gIAfg
 laPpk+yi3nc8z7oi7adHNh16neJoV0DNSKzbbFquFQnB717hU8yNHiI8+VpId/0dXvkU
 hIMcQDfjz18JHjX5JYLLWnsv3WcqI3ngaMU4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880968; x=1749485768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77/xjSiSua3+DJ+3hA/AhjjUrFZycuAJdHSaJ44WT1g=;
 b=dDumvJCKUuVDfpMfa6PG8TB6STcIhkaM6BUnHK/flUDYptwlr1K8rxplgdeE/rLc8C
 fZB7dQRi38fek9dLisKNwEri1twRAlvVlmBpO7u4yxbkFh2IfE1k9YFsDJykRf5rFO9b
 QcoTeWp625WOdQb4G4Nc4mgLYvJiwrxVbJEoBolKgRolvDb4tg2f6h3HKWAwdMZEWT1M
 37VvPBanXnBInsPA4R8YvfiJHxdY6y/yPbgst6jtNBnYdc5v/y3HUinGYucCp2z5FFT2
 3+aRBFCLhDzbEfXcmf/ViWkH/LgshSnXDJGYs8vi6B1/mJypy1aVXSOjC5Xl6dd8W3c6
 9TEA==
X-Gm-Message-State: AOJu0YzqvfuM/VrORESFzB7K6Te/wflpbUUg0c6umd9bAUdXA1deKJKb
 xOcYtaCODipW3iBqNjkPJGhXg/r63gBUZmWtMvimOnKx52MpbK/321mC9LPOG6xfFoI=
X-Gm-Gg: ASbGnctu6gXYCknxrKBRv+hx1Z6VE1uvesBraXm7J3Xh5L6xqakJRM3mmXzuPf8DVRC
 8KHsyekpMXyq5Da42Y7h11v+7XsS2pXoJGgVAY4iYKKIGqGSWQU70+UOM6C+Wu9uWu4TEz17FaJ
 bnHd1hyIouOmhExPJmSWuc0Grg90pjD2hCWyKuCWZMhGR9Mcc5kMtqI4WANjZ6qSEv14AdJYveZ
 aGSOx+rA/0tH5FVlzSxVLrri2N+WTY8GozohNKaIFObOQPOFxpQQS26l50X5pScdO5K8KpAvvS7
 K8j+uhRAQFYRA8k1pgj4+I96yeZdgzYLI4sbV4eVFgbG7N6jsFa2B9WyBXa4JjF1QP3rKmPWlkV
 hxDMULpT+TU7RDPs/s4J7RZbywYUPYHu1Gg==
X-Google-Smtp-Source: AGHT+IFPzU2yhvKj2A9BfTEvvnxc5DRuTlrDuH+zpHGApNS8t4d329jESxMTF33Af+JFhDZitRT9Fw==
X-Received: by 2002:a05:6820:c8c:b0:60b:ca08:a746 with SMTP id
 006d021491bc7-60db9e4d416mr6264501eaf.3.1748880967633; 
 Mon, 02 Jun 2025 09:16:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c1eb71a27sm1459796eaf.31.2025.06.02.09.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:16:07 -0700 (PDT)
Date: Mon, 2 Jun 2025 10:16:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/2] spl: Add size check for u-boot-with-spl.bin
Message-ID: <20250602161604.GA100073@bill-the-cat>
References: <20250527121049.106825-1-pro@denx.de>
 <20250527121049.106825-2-pro@denx.de>
 <20250527134906.GI100073@bill-the-cat> <aD2EflR9DRYG-MY5@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z8zZeMBcAQE3oQeY"
Content-Disposition: inline
In-Reply-To: <aD2EflR9DRYG-MY5@antares>
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


--Z8zZeMBcAQE3oQeY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 01:01:18PM +0200, Philip Oberfichtner wrote:
> Hi Tom,
>=20
> On Tue, May 27, 2025 at 07:49:06AM -0600, Tom Rini wrote:
> > On Tue, May 27, 2025 at 02:10:48PM +0200, Philip Oberfichtner wrote:
> >=20
> > > Introduce another SIZE_CHECK macro for u-boot-with-spl.bin.
> > >=20
> > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > ---
> > >=20
> > > Notes:
> > >     Changes in v2: none
> > >=20
> > >  Makefile           | 7 +++++++
> > >  common/spl/Kconfig | 7 +++++++
> > >  2 files changed, 14 insertions(+)
> >=20
> > So, for u-boot-with-spl.imx we use BOARD_SIZE_CHECK and
> > CONFIG_BOARD_SIZE_LIMIT. I think for consistency it would be better to
> > re-use that option here and expand the help text on
> > CONFIG_BOARD_SIZE_LIMIT to note which build targets make use of it.
>=20
> Thanks for the feedback! I've tried that, but I have the following
> issue:
> 	- 402K for u-boot-nodtb.bin
> 	- 152K for u-boot-lzma.img
> 	- 191K for u-boot-with-spl.bin
>=20
> The end result, u-boot-with-spl.bin, meets the size restriction of 192K.
> Nevertheless, an intermediary (uncompressed) artifact, u-boot-nodtb.bin,
> causes the build to fail.
>=20
>=20
> Instead of introducing a new Kconfig option, it should be fine to reuse=
=20
> CONFIG_SPL_SIZE_LIMIT for u-boot-with-spl.bin. I'm not sure which way is
> better. What do you think?

Ah, OK, I wasn't quite sure and it's unfortunate that the various size
check options are all slightly differently named. Yes, if you can use
SPL_SIZE_LIMIT here to catch the problem, that's the right one.

--=20
Tom

--Z8zZeMBcAQE3oQeY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg9zj0ACgkQFHw5/5Y0
tyyRDgwAkliNOm2equKMzlDB5VKYMENAls+4iM3dR/HgsQJGCqNLpyoDTZriMdmn
BvlnbIxi/NQI6CC0AG7MrJ6AUqfy0YxyNmiAMKSyM4tY9M2FMO6+gkAz9il9jcmS
RMPJ5sI1C0GA1YUiQAm9dco6oxGy2z40mgD0b3Zg71G8VaElcZl4XF6mZH/ED8WT
XKkAvqXOh+UBmoD0O+2nCgL1w6SbZhUMt3+vjQXzt7aIVFLJ6zIm9fsBJ41nY8BK
adWG5e67L7DNJ9MNsEYZrXUSE7x/3+onmtLIrT066jzjLNLtVMBazePe2zKq5M8g
NfB1nfaBQ0NDxj7L0TApdqimQD39tTt+7UubL2oLribJf2wvlKhPad0f/KGekjWZ
N/omp7tWFyemRlkHKdcGA2bS+TTHpURkRNgtc3lkt8n/Hrn9Gr1k/P40MuXTGASx
CiqzYSfzcUPSoFPPP0ohx6e0wDTEAiZKLgCecDSMLgd5/xw8UANw6AIt1sASkMBF
XC8o6L2y
=J04j
-----END PGP SIGNATURE-----

--Z8zZeMBcAQE3oQeY--
