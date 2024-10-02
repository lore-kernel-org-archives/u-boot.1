Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B45CF6D38
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 15:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F08890EB;
	Wed,  2 Oct 2024 17:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="np+QNZ9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 739FC89117; Wed,  2 Oct 2024 17:26:50 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52367890AC
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 17:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e06853e579so3862722b6e.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727882807; x=1728487607; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=01kbNGZ14C6ENkmIV4QP3erw1/hX1NRrtvsqgYxKNc4=;
 b=np+QNZ9poeCICth8jXNMpsUdfwJdyxW18eJ0WzovbtVrh1X1FgCT6pPv7d3Bn0C/5x
 SF3hXmP2IA+LuY3FwUQpZpnUd0xtVnsbNixVBwt8LXEvecmKoIZyCMe5/xqouPJHtfXT
 cWI1XRdt4CCxt7ie4SnwDAX1HL0LKtxsJIxnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727882807; x=1728487607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01kbNGZ14C6ENkmIV4QP3erw1/hX1NRrtvsqgYxKNc4=;
 b=T/yxutS798msf4JphB/kSNsOvqSykqBlstDUgTd4gt5Lgxx90cayn5U0cZASHd5Sq6
 4CF8gx4IWyFoIsAWIVyB1JKh96C5rbJe6RIA8AvGf6Mxr2Wz0nReEsmSW0b/XWSfDLch
 4Pakw55+V9clNxXmFzaO8V3wbYGGbM2cOhOWYHuc9ROQcZeakAypCIIa83FJnVDhmonR
 Iw0sZ5pZ6dPIWKWoAOhft+azeBGEanUudUV54mbrRSYDJDSXpFVfYSnV+IIm3vC74Wmy
 Lu3RyLSddzIlzLUaW/pJHUHFIEIZwgpAJtWoWDTmRFcEATxKZZmxvl4CWRsd+7Y4CFQ8
 bodA==
X-Gm-Message-State: AOJu0YwxujRitiu6VrecTn7s09Wuy8ZFu6YQb15p3rEm0Kgq0iadldZo
 ++mnYF7FlQ5izgNoZwephwQRO7VhEi8QYAF7LufWIl5M3qWjIgTwQ/K9GAekpV2UJJmX0kM7RuD
 6T2g=
X-Google-Smtp-Source: AGHT+IHM7DQYJG+jH71hzEqHQJ/D4UWnJiMsHfeJakd52hXJwDAlLABcD8I3wigFnZUboOBaht9sJw==
X-Received: by 2002:a05:6808:1587:b0:3e0:74b1:d658 with SMTP id
 5614622812f47-3e3b4182c0dmr2872578b6e.40.1727882803220; 
 Wed, 02 Oct 2024 08:26:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f33b809sm56923701cf.65.2024.10.02.08.26.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 08:26:42 -0700 (PDT)
Date: Wed, 2 Oct 2024 09:26:39 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 20e0f0897ea2..3347eecf3408
Message-ID: <20241002152639.GO4737@bill-the-cat>
References: <20241001192509.152745-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MDAHXHkPn7AzboOJ"
Content-Disposition: inline
In-Reply-To: <20241001192509.152745-1-trini@konsulko.com>
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


--MDAHXHkPn7AzboOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 01:25:09PM -0600, Tom Rini wrote:
> 3347eecf3408 Merge tag 'v6.11-dts-raw'
> [snip]
> git-subtree-dir: dts/upstream
> git-subtree-split: 3347eecf3408998fa7136c8789322cc99646ceab
> ---
> [snip]
>  1503 files changed, 78440 insertions(+), 20166 deletions(-)
>=20
> I have massively editing this down because the relevant information here
> is that we are merging to v6.11-dts from the devicetree-rebasing tree.

And, applied to u-boot/next now.

--=20
Tom

--MDAHXHkPn7AzboOJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb9ZiwACgkQFHw5/5Y0
tyzfhQv+PQlSXblBxWmO7yYr3Eo/yZ1Of17v95uwc4uNiuwf2M7ODQznqKNuCOoS
cHghOrDIh37cUPoSMvCBkKQj0O4blY5sWm2KzNzCYcN3MTJw/NsM2DzG6bRR3kVY
Gyri4kevgUYQeW/T3IhS3cIedBrVGswWNAYh7H+DRoeo6CE7w5y1IreCccl2HnHR
eN3Ne+59EGEF1rdlYpHofwxThy1H2g327teh4mIAJOxpDGp05sOv46kY83Nti8Cv
sok2xBT2YMkhDSme8jYD5G4NSwAnAojXLRWSDds2ZlATwDkO8WOilYQF1Rtn1bQH
ZfMGl9L+ZsaiaE2OT3qCEWW4WRDoOD4CK9oeuVAkOE3ynQAphcvGu7kzf10ET5hl
FWgbbR13TAAoZcb5rneY6Wo0EdkLlyDtUY12v/OOEoEvhLRdAV3XaO2ra5IzrSNM
wr0xr+uB+bTcmpxYXF6Pjl2p3LzfkOsEgdYYdHxQPN4W7U1LHl5t1rgiZIXgRMxs
nUSerKl1
=Gm/Y
-----END PGP SIGNATURE-----

--MDAHXHkPn7AzboOJ--
