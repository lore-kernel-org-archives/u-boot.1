Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB8CCCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12CF88CC8;
	Wed, 25 Sep 2024 19:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lwpnYraL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034C288C05; Wed, 25 Sep 2024 19:26:40 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A4AE88B13
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4585e250f9dso234881cf.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285190; x=1727889990; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M+Y+lZmP/Z6nioj9z8CrMGx9MdMhutgJ2Z0aPzSlQF0=;
 b=lwpnYraL3becdeKoXItj2zm1TjLVpn77E5tm4q+FoNUpyjbUMOS6rZNxg6OBnJToBH
 g5cEfBGtXf9Vo0s/jeoA4khlRMMg2RYrNp9qx193WXENrlWWI1fTX1J5GvUI2PtOqZHN
 UTeD6lqETzXCfRFgPy30Z43ZzmB44B9I3Ibno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285190; x=1727889990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+Y+lZmP/Z6nioj9z8CrMGx9MdMhutgJ2Z0aPzSlQF0=;
 b=ApSxrHk3G/9JG1wirWjHZiN/4mH3wtGzVuxQ7jpGboT5KCGwwBetcfVZJOaB0Ry1GS
 MzrSOqWbbjYSsVBz4pvPDqNtoR3Sk0+lG8Xquc/LtU+LCXbkfgmoE5PikOxMNWv1pt3R
 9nuPvgrvFNxMZlD9hM7nLOZZ09iO4K8+pzbtFLutT73StYF2XxC8SHTpgo8537r/NEGg
 2fDFpOvAXeqYBfBUqCPQjhrbyvpKG57N3Ficw1cbYTZUMNnmaHSSFMTPuM5FYtAEcB6w
 QJwt3wAO0ZtZn3QImoItwBLV0vmGDB/aO9uZmVYF8IOQFCRZoKNnCq/8dLE92Po/Jw92
 hupQ==
X-Gm-Message-State: AOJu0YzHkyEalbK5mQVqp+Zd1WN1NjrvH9xu/FZZ8kzku3P90nE8NB/V
 gmM++eaSzAAtZmSLoYLWOiBLBCQw7sGuooOOQKBkdHXkaEx0bNJPsd502twp+puPmT8t1uUdhPi
 U3tY=
X-Google-Smtp-Source: AGHT+IFr/L8w8PktwW2QIP6GmATFzgDZgFArQ5ndg0O73wa1kklX09fjpz8UJHCtcLw9O7pDkrA9Ig==
X-Received: by 2002:ac8:7d8a:0:b0:453:1afe:c711 with SMTP id
 d75a77b69052e-45b5def1db8mr44527611cf.28.1727285190003; 
 Wed, 25 Sep 2024 10:26:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b52654ce6sm17780721cf.67.2024.09.25.10.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:26:29 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:26:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH] qemu_arm64_tpl: Add a new board
Message-ID: <20240925172627.GE4252@bill-the-cat>
References: <20240925094745.37922-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="syFB0UWnztF2mBii"
Content-Disposition: inline
In-Reply-To: <20240925094745.37922-1-sjg@chromium.org>
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


--syFB0UWnztF2mBii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:47:40AM +0200, Simon Glass wrote:

> Add this new board, to support testing the relocating SPL loader.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  bin/travis-ci/conf.qemu_arm64_tpl_na | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 bin/travis-ci/conf.qemu_arm64_tpl_na

I assume we're NOT testing all of the normal U-Boot stuff and so that's
why qemu_extra_args is so minimal.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--syFB0UWnztF2mBii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb0R8MACgkQFHw5/5Y0
tywJDAv/SlncyAJZh0UOluutncInDS7/LuG/kTs19CHKB1RAP0vdgHwpx9mapAYq
ng72ty4JAoZRbfW5WwXsGlBe+NYLGLXwgWLJfJG1nCCe8WTI9jxHplDN7MZOXr0q
si+B+iZEdztu2560CI/PA6LQtiEzRRdhmAigbu1po4/F2NNHpreF8VcGy04qics0
b34Ykrmvi+RASwlczHR+O7TzZxths0WZI/MQOiAVo99vr4Mxep62aWsTEHmWkeg6
A95CL9+RNmNK9DCseATmazB89RpwIEorsMPtJ1QQ9WSDfVDH1TJWfkUrKCrOPObx
O7+QgUYaWUkpQX8YCeaxXe6iHtkrM8pOHMNRM+pfSyxss1fcZO7fewyfbDLDklzo
QYA0c8iiINnEGP+ZcH/YrM/oUvJIkNOJ9i6p/BUMlmd4WS8zzG6KBuGIQ95wkNF9
30r6Cd/5dYm5V5UYiraeMkUbl4NzfMRZMvRHfmeuziRvR3epBYIwvTkKNgHmBD5F
y65K84Zo
=caDh
-----END PGP SIGNATURE-----

--syFB0UWnztF2mBii--
