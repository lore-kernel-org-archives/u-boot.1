Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C63AC3A59D
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 00:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F96187ED0;
	Sat,  6 Apr 2024 02:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NsARqG3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F7288163; Sat,  6 Apr 2024 02:43:13 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B4E87E1D
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 02:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6e89c87a72eso1886961a34.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 17:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712364190; x=1712968990; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cxu+OPqOlld9ArVKI4MLf7oFafltOxWGc9RBvrwDHCg=;
 b=NsARqG3+QgKVo/PJVS3RMsne3tPLawbf8Z/QCV/uu25gAGPCarDTg6UPTjk9NVeHzJ
 AjrM5fLX1b6AA3S5yySmo8j3B7h3uns9BmuR9MP7JWR1jzqmbLxI8uqtUqNmtGAJMVM/
 hqJXrs7xAVrxYCxVMT4Kbu5mMuDFlrzxkKvWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712364190; x=1712968990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cxu+OPqOlld9ArVKI4MLf7oFafltOxWGc9RBvrwDHCg=;
 b=rkbzQeChCiMiZ/VV9dnLSULupzTZ/aku0by4CTGRdtbcFo+Xp/tAHOJsF7+m7L2ndi
 AEK3mNdzKwS+6EY8rgjiz3WnWrqr/BqPLkhBV4RF1aJa3xzv41Ct2C7qcn0/Dnogqwf+
 K+U2F/UXIMikt4MCOblCLl2jsJ+IQIqKb8J49qMwsn7HurTPet4FajibZhKuDBYoZA/U
 +ixiQ8kdXJzWH33e4morrXE/geKKIO0RmP763Jhski4ppgw76K8ZlgZeCWkqmXVtJQT4
 RWY7ng4jIxdZzlHC6vEQ4cDV/rorBTqbk+p6AvXvKrd+jAtagw6ykh3g+LZ8KPIFJWo6
 8TdQ==
X-Gm-Message-State: AOJu0YyMeOqD4Cfx37KfACYq/fiscHkETo2d7IMEan6XzH6cpWRnKE+8
 dJVbj1M/nlJX6XywhLP89naNddNBBfYttqhC3qovATrblRjy8u2ttuKhlf8fLfxby1wItIqtmrg
 uRf4=
X-Google-Smtp-Source: AGHT+IFwWdi9QYNZh6r4oUSu5Hmke0Jss7Ffsd+S1tn6pKTC1JFEuQ8tzK2T1UUjrHrSVbNZMn4gPw==
X-Received: by 2002:a9d:4d93:0:b0:6e9:da83:7c89 with SMTP id
 u19-20020a9d4d93000000b006e9da837c89mr3020671otk.31.1712364190496; 
 Fri, 05 Apr 2024 17:43:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 pi34-20020a05620a37a200b0078bdce0acecsm1068251qkn.80.2024.04.05.17.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 17:43:10 -0700 (PDT)
Date: Fri, 5 Apr 2024 20:42:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20240406004237.GB114971@bill-the-cat>
References: <5f2e055c-bc20-471d-8b98-90807f1dba0c@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U5p1l6EPPk2Ac4gR"
Content-Disposition: inline
In-Reply-To: <5f2e055c-bc20-471d-8b98-90807f1dba0c@denx.de>
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


--U5p1l6EPPk2Ac4gR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 02:08:15PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the first batch of mostly Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--U5p1l6EPPk2Ac4gR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYQmn0ACgkQFHw5/5Y0
tyzkvAv+PpS7By2NSQ+wKfIDJxy8/HJcCy4ot+dxpOaPKY/OjzE0gEjKTnLOScG+
tj4poHtmlel6TDRKciHr9VBeVhnu5KwSzPOfkxAMRbbAAaqf4HcJjVxih+3jyNgO
80z8I1yq5QDFZspASee/FKUbgxxAq93x9dZvIHBkWmujjt+b0py0t/aTQU7+XGch
tRO1MNrNJ2UlJNRackM2+wyVjgTFY23Bd/te3cn9jKVJ79SO418eoUSAn1JNOCOl
DVo5Jh1r0kEJc9lVfgJfTJcq4Z9kgJjCQJTS1zLdtrzi/rgdWkZ2PHPc9o0TwNd6
fh4aiUiUsBjZa21Kg0gCtwMkHMKLwZ4TXknGASw/p+OkT8tPh+Y4mn4mTnfdj9X+
YoC/k0Weu4tTBpvx4fTHRuPrM1laesw/r+046Otj9u8apWj2+Jd+V8GYaavG0JN4
RX5vevNNQuY/y4Euwh/9P6LU6MQuZw51byf5P4DpvfoLQm2ba44OYMDJUOGpjfec
I//HOs2u
=oH82
-----END PGP SIGNATURE-----

--U5p1l6EPPk2Ac4gR--
