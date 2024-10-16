Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C0ED20698
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 03:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA54588CAE;
	Wed, 16 Oct 2024 05:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lr2sAZzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5801C88C4A; Wed, 16 Oct 2024 05:47:42 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295A582BA7
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 05:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46089a6849bso5650811cf.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729050459; x=1729655259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nB/zYEi2Se04bve5qeLEO3+myAYF9ZsD2VCqN4ugIdc=;
 b=Lr2sAZzsK7uPinCd21psHYL7j8dPglkZMMk6rsEkw1lhHz0kIMVLm2XP9rmA4LLlDk
 pv1/zleY60+ExFxXIgSIJa8QZ1IdOaT/BZ7kBQVzXCjJUvwFBkuel66guOmuxANlDGOf
 5ZtmzrX89OKXqJ+YEACW1LlDci3qTov2I566w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729050459; x=1729655259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nB/zYEi2Se04bve5qeLEO3+myAYF9ZsD2VCqN4ugIdc=;
 b=AYpd24gswNkT1fd0IsRWcp32jIPMs0+kdoCEHsKI/Z5wKUxmAj/WZ+r+yHsbeX3amS
 QBQZzsdjuw/mEShiLfymNnwq6wWMNwG24IQq0aND8iKg78pzde7QAy/mYhRGg3tf/qv3
 dD4kqwlrwto/v9TGzTr+4VuGZ3Tm/QT8ko+vszf4Izm78EPMvLZKU8pBcDf9BmbAD8rO
 +KI0AbXll7CDP7QRp6UDOYieXLOwTVSTuPCyMR2WkqoOCNtOf1z1ljBrwSls7UfXBxtX
 XtLYFSFR9M0TsXUONpun/RbkJV7qAguDqZ9XY11bM2EX3DWMSsL+L8wTKCsmWk8mIRlI
 M0WA==
X-Gm-Message-State: AOJu0Yx6ZFiKoxsETCx8CgYjApM4F5rvE+52dIJEVXuTC+ua8tWMFCfL
 Tu4+COK8aFm85BuueH/w+WX7F773UBE4w8TiyIqrhODmcye5L52oe5BhA0+ZNe8HDog8p7yIL35
 ImRE=
X-Google-Smtp-Source: AGHT+IExanHid0ob+UfHZ26tUmHCPbM2ypoE6jy54bUoAWhMNy8oZ8e4W2GAjlwCziQBVEshrDdlPQ==
X-Received: by 2002:ac8:59d3:0:b0:458:1651:b235 with SMTP id
 d75a77b69052e-4604bbb8a3amr225035691cf.20.1729050458858; 
 Tue, 15 Oct 2024 20:47:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607e58a948sm12040751cf.46.2024.10.15.20.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 20:47:37 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:47:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] Revert "Makefile: Drop SPL_FIT_GENERATOR /
 SPL_FIT_SOURCE support" changes
Message-ID: <20241016034735.GE6412@bill-the-cat>
References: <20241016034235.89354-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sz47NBqvAjJGPxXn"
Content-Disposition: inline
In-Reply-To: <20241016034235.89354-1-trini@konsulko.com>
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


--Sz47NBqvAjJGPxXn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 09:42:35PM -0600, Tom Rini wrote:

> :hile we had hoped to be able to remove these options finally, it was
> missed that zynq still requires these currently.
>=20
> This reverts commit 5b9261fb0b1ed087387f2036d279fd3f4bb20a61 and
> commit 099b6df556c95f5d06864612e9199eab7ba50ed3.
>=20
> Reported-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Sz47NBqvAjJGPxXn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcPN1cACgkQFHw5/5Y0
tyzetAwAkFHmUtEkxyQjwewFR5Hpn6RorKI6Uftx0+5VocJ/KX+9muUrLhY2BXvz
9cGDkaFfmky9NGExXYUzFJ76GCTdGqh8ltXmGoSiA2e/a140JMDUasDKtJpDpeEg
th3dw+qqfNuxNvRzQNZhMPt5fl9OaU4u48i0IhaM0mFewOuyweJlIMTxcusBnFHa
WRXpGguVsm/opmhGU/ywiPNB2bm9+5YGzrRjzjJAVYBBHbSZEPyiGd8ooW/A9FBp
k/poIbw2/IPd7VEO+qE+9seQhsTW0DJtxoGkDQahQOPZcyARTnRmQoqlDBpF66Ck
PjAS0JQMJGJwvjDmkZagKt7lnjRFRKhFZ3jJZLp3kqzVKBUcHa2eE5Yk4RNGP212
MKLdqA0ZFgo58i2F11LlUa7FnlWgXVNIJuBJH35LDQr5dJ/4eeI72l1iB1hB9Wk7
JahK5pLb4la/rWjifkAekniaQwPGhUBziknOOZXJZj9WUmXkMXCKNiMsuqreGP88
y61C1iDt
=0+U2
-----END PGP SIGNATURE-----

--Sz47NBqvAjJGPxXn--
