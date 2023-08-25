Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8850C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 17:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA69863EF;
	Fri, 25 Aug 2023 19:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l5C2Y8MT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAE38647A; Fri, 25 Aug 2023 19:24:39 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0796C863E5
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d7815003420so1186580276.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692984275; x=1693589075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UETN5ywZJzgvYCmFFuioQNL+u/C1ghVvx0K1d4TWQ8w=;
 b=l5C2Y8MT4o9PDX4vWt+tLSh+CoWRTIvB27MpGv5ohfoUxlWvLCCowIvCr5g7O37ll1
 GXk1ftdZZqw7jY9C+sQem9RpPHG0guq3iZvVBw29EokPv8eXxe2s2zZW5uuQ4h3MEZZs
 Hj4vSWeADTEmTf6MrbVLXfheGwX5ZDQaVL5ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692984275; x=1693589075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UETN5ywZJzgvYCmFFuioQNL+u/C1ghVvx0K1d4TWQ8w=;
 b=JIqOp3l6Cw29tOrCb5V2LTnLviDoMPOrbxT3Bl4sBrijvusH+jStgWoaiTHXrdZ2Ip
 9j9N6ZOLfo4GdCFwZhAID6ftGrQXCPLsR9SjU6GyRps24kKpqceKHFXxk73DwjrFTNG1
 HARLx0cdjzvjpjP+8F5/1oLs2pvIs5rudE05RwdtybeYvYQDBU/l4VENiX7BX0U/RpUz
 hcYvcxW3IkhmQ87voRi2Xy9TDyijFQrN7ZkAq6/mGlZDmzPIucAOIRKLEo29T62gu5Tb
 5n5ZDIniwa8ZpWDNDjBNmh9QCUbo1p39lgWt5YrncnZhP0g/7/RCaiFfIvlUbr9fGgsb
 17+A==
X-Gm-Message-State: AOJu0YyifR/fOy6e9IruP86BQ+4NmD5vcAkvQ4ptL0O5lIiBbOrfbWuA
 +JImJv4dRgALDQ/gmMT5DyqogYovtoevqaEVXTZ8uw==
X-Google-Smtp-Source: AGHT+IH8QkcJOLDEGIznRRlLu/0D0ws3Np2iZJ+EhsAGTXaidtdgHkxB3nLNN0H7yUGdTORebdUuzA==
X-Received: by 2002:a25:32d1:0:b0:d0a:da40:638e with SMTP id
 y200-20020a2532d1000000b00d0ada40638emr19682888yby.12.1692984274746; 
 Fri, 25 Aug 2023 10:24:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a25ac0e000000b00d71855984b5sm476507ybi.18.2023.08.25.10.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 10:24:34 -0700 (PDT)
Date: Fri, 25 Aug 2023 13:24:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20230825172432.GM3953269@bill-the-cat>
References: <20230825085740.8172-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3hWHMCmhezum4hrO"
Content-Disposition: inline
In-Reply-To: <20230825085740.8172-1-marex@denx.de>
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


--3hWHMCmhezum4hrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 10:57:40AM +0200, Marek Vasut wrote:

> The following changes since commit 291055efee4e1ae4ad0b62393256514a4e76cb=
1e:
>=20
>   Merge tag 'doc-2023-10-rc4' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2023-08-23 11:03:46 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to e3380e1c1a88af454c1a41b6b63a8822e57f9a45:
>=20
>   phy: phy-imx8mq-usb: clean up clock code (2023-08-25 02:36:19 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3hWHMCmhezum4hrO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTo49AACgkQFHw5/5Y0
tyySTQv/fRVpyl5/SNdwd38RqGH7fqm+qB8tJZeQtbM8fhBbXyrdtvr5OAr0kwJ1
jrvF3CkcSya3AOKvM1cQg/Z1LvsJjaWwONgFtJemJ8YLGwkBuvzpaw6tONy9nS/f
qEk4w91/ZPG5FpzeV5bSC6un0f+M9JWfaeTZsdC76W2jpNcfSJhx4C6T7R+Epm8c
S7JdJfmL0jpYt2T2cmbbZRmtegXQ+ciOfNpeOehsaAHgsGwO6o9Aitf5ZkaUoGGk
hDbketuAWxmGxpNsu7wIB3MQJJEJG8F/2WlPjLLtdy7w6NZCH/nBJK+tGrN8DW7w
Jehh7VVYrJLZ0p4YS2EsCxl2Froh+B15giZuhlpbtifzrR+oYAGzy0Toq2xUrXjQ
5+fAdVg9Bf98fT+s9u/U7o2VaEa5V+DREM7g4Hr3HhEPKHFXC7LJBitTVhS/uqz8
IwogpAYIQQhnm9C9gprkbu7zjfEj+/sVJC3p5AWFG0cHjv5ZQTFyv1VZJLv4Rlsy
KiLn9aX0
=+ZH+
-----END PGP SIGNATURE-----

--3hWHMCmhezum4hrO--
