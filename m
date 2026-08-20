Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA893C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 19:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15F7880E6A;
	Thu, 20 Aug 2026 19:17:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlXY1OyWvZKj; Thu, 20 Aug 2026 19:17:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787253452;
	bh=EQm5BFAhI0HiMxhsmY03gDedR0azE6LJyh3nCcVFwgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qNELtVut7LFg4rP/SKkIL/O2V0xBSNpady9h0GfXlusF0eC2eYcnBtRZD0uruVjNo
	 5ZM62gneDH+t0xWHYrEQFMN+ZauC5g6sXMHwckYDeNJ/jXC/DT5Yi2lN61BkBxCbcF
	 0j0y1WLAHoc6iZa28aO51gtcs3Rqq4ONH3PVqDrBta2h/emFTWTILd+T4BYZ69kqWB
	 /3gZW3fpz5HrHiwhXlkuu1hBXX2dMYUeL129zYHGnRoefhu94nXpNFBWFAtbVWlWgv
	 ow7zPjp9ygmYiLKrtmFuATmYAkD3M8NzfEUQwQHx+N4a1bxDWaAyXt7u6bwH4qEm7U
	 ps+K/+24dUH/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FCEC80E16;
	Thu, 20 Aug 2026 19:17:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA877279
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 19:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3E7D4081E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 19:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QprgAjBJy6NS for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 19:17:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=howlaECt
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDB324081B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 19:17:29 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6b0fd2ddea2so204674eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787253449; x=1787858249;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EQm5BFAhI0HiMxhsmY03gDedR0azE6LJyh3nCcVFwgk=;
 b=howlaECtI2MPbqe61WxGnm1lMhesVuvSr1KpRWVO0jo01N2i2IhhGE7VUOG8zaC3q4
 rK5Q5V74oLFc9uj77ntJOVSqziX0ONE9Pq3TTHgySaHQWaFyR+xyjb6kPjIAbH0YyH2/
 rFxJolouCSclb1d6vaZCHjnGTPgN4ypU0h1BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253449; x=1787858249;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EQm5BFAhI0HiMxhsmY03gDedR0azE6LJyh3nCcVFwgk=;
 b=KbdVJWkqHG9QMAqpKocKjAZAGFdHthMbSF9H/DwNkySghvlYDz7saLMWMRGzivDybK
 5PllQ+7UP5v0DZmpymL/11inoKYHDGgyck6xn+di7k95D0nr3CHfH1q8jOZ535Qhwk7C
 DxAgvImnwOadlmd2cCgrKzkZXz+3k/Nz0nfRxvCfCTpHHKYFu9DamNFalgEbIyE3OzjV
 b23A3X3sRD+U5slp7LiGqfDASk+UHOiWF7udYbepnnBCCDZxbzAwOlcczRf7ZFQuzkAK
 VJOm+pkvT91qqZzbmnqV9iBC67oWanU0/5O29spJrLLRdJMN+npXNK1wcJfAhl7EKgy8
 eGcw==
X-Gm-Message-State: AOJu0YyIasEyQdKFuk6tjGiOh+AUx4oJzQ9N4r8MRJlsApCuy3dhBX1e
 YUK4guVAwrQ8c+Fiok33N7p8q4jngZ9zUprukc+nkK71RpiCjPjMeohV66Jqp1gd7QwYE9gnnYy
 UAXtoXuBHy5zE
X-Gm-Gg: AR+sD11tehuD1VLBLKpyQr8ptFGDCufBYrE5D/S1kDl2aGROtpFi1h569rFVj3tdcdg
 PIo/XfS2tGrqGhcTHkqZd+62xSU9zT5U4aDMgxD8F7y4K74W5ZzmxFygCRsl0tZA71GXN1g57HI
 uok4oUAafjlp+Bwi6E/K1PGqv/uwX0WAyzTLSqiKdb8IiiJqnZBQcJj5OcDvsT4s9uVTMmFBnVi
 Yp/VgTjjAMLpafQcp4pHmrQRQquvaez0+CID7ipZr27Zb51i/06TOI1dy1aT0fm3bEXV4+984rx
 5yMetg4lRg1hCoxu5yYVedOS8YAqVnDKGxtjTddBsBZko/223sRF4coIC2G9OtcVnjXFSySZMJ1
 vU2quDU2nuwLufnkl2LUih0Wv0b3u5vlkM4cFJEAhAZ+Cw3mI/g5F8sxsw/DBExNvtuvvQIrOKk
 16+sg3x2areLJ6IR1BQREaHGXUawGHISF63B9Ts/1naB5xouftKtTcZljrKn44cPD9P+yzPp8bX
 bu8br1frKus26MasxGJbBwOCQ+boaZR4ssNFDqokuOG/wNolu0JynxIjIacHkpC6mNIQALKM91d
 By88xCj5Bg==
X-Received: by 2002:a05:6820:83c4:20b0:6b1:4b64:13f4 with SMTP id
 006d021491bc7-6b159284d3amr917363eaf.15.1787253448686; 
 Thu, 20 Aug 2026 12:17:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f440023036sm5736001a34.16.2026.08.20.12.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 12:17:27 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:17:25 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: u-boot@lists.u-boot-project.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] rng: Fix build with SPL/TPL
Message-ID: <20260820191725.GK523975@bill-the-cat>
References: <ef549c4de7c2fb98e1e8554b5c7af761cdd15031.1787238864.git.joerg@jo-so.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GjcENoybwCR22dyo"
Content-Disposition: inline
In-Reply-To: <ef549c4de7c2fb98e1e8554b5c7af761cdd15031.1787238864.git.joerg@jo-so.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--GjcENoybwCR22dyo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 05:14:24PM +0200, J=C3=B6rg Sommer wrote:
> The inclusion of the drivers was wrapped by an =E2=80=9Cif not SPL/TPL=E2=
=80=9D, which
> always excluded them from SPL/TPL build.
>=20
> Signed-off-by: J=C3=B6rg Sommer <joerg@jo-so.de>
> Fixes: 591257b05caba725eb57ceb174317ab4c7e460a7 (rng: Introduce SPL_DM_RN=
G)

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--GjcENoybwCR22dyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaodSwQAKCRAr4qD1Cr/k
CrKxAQDQT29O1mO6orXH7KLcF3npGxAp90iHTKCf+vj7G0MecwEArTh8zIb+2EVD
4Vq22m7GiZdMxBta5U6x89SmL0fvVA0=
=PHxm
-----END PGP SIGNATURE-----

--GjcENoybwCR22dyo--
