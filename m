Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2134E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02ED8984B;
	Sat, 23 Nov 2024 03:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BFGKiokm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5A6891E8; Sat, 23 Nov 2024 03:42:42 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5822A893D7
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4608e389407so30948511cf.2
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329759; x=1732934559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tvLMLujgIHAGqgaDyOO60Vv2lpsfl3ORp9+rBZAxNl0=;
 b=BFGKiokmA3HUyGVMwo30oEnOzofYurmtPfh42aSnCvyTULj8iCKkmC+NCuQVRJ8NX3
 RD3yOsRO2MuKG+eyUkc6MAMdKm5UpWaj36CJ0Ajj58txn1HC1/XDhdRh4fkgxFFIilVp
 x95+J4KUHqQU/WN2lCe/S5n8a1s12i/pwkDYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329759; x=1732934559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvLMLujgIHAGqgaDyOO60Vv2lpsfl3ORp9+rBZAxNl0=;
 b=SUrXNT5JC8gVyqYTiVzc78BQiP7eJBYhAAqSUvO+YcceA5MF2lVIKqxQbJdXSImPX5
 /KND18WBq20DhVCcOMoRylDgKIDCM+VZcwJwI1+Ar2es8shlVxF4iZR2LmGzvkHFYa4Z
 uXZT90uRr9kCTeOcSzs9RJwUG26PYybttfYKEAM5i4ADl71F+k/iKoSKSxUaPC2bZSpd
 UQ9yZ1E4QBsnRrKuUm63D0ZFhFApf99zn769l3sFxFUfBBpzXD4PCWOj5xGRoPUexZJF
 kfSX3gneJYq8FpQkzCdU5RA6nz7MTymZm8d/gg3zc8dNAJsRppD8CghLzr3s3W45oULO
 SRLA==
X-Gm-Message-State: AOJu0Yx2b0oz4Uoc2OM0hZaHokslajt9u6+6qzFWJbAyrnHglpBcEPCB
 K1O/5HPIzZHqPJSpoqvmx2+HkSSQNATZwxXBFROeHsEbXcBOiWUL4QVIJE3C+qRqUdjniyXKf5z
 u
X-Gm-Gg: ASbGncuaVTyiNJRPbjUU4j+5wgXxUNGP6RIjVRdXKn76yLP9gvoclcP65EEw83vejjf
 dxqbNGAktSoT6ltEz09036OMylp3r28VOJDrxzz+494+T4nhDbrCj1KX/Dn0VmBVWgIca8lNC8a
 8Vt6j9zF/w8wcYbecDVZfW7RyZrNsoJCi4uf8K7PubSyr4zO629O1pcrX84pQUfuV9lbftPz3FW
 t7NTnnGEUU9cFsZzp1FFkdGgt7YnBqhxcrHDmNUqdRp5/b8cg==
X-Google-Smtp-Source: AGHT+IFS8F0nG4t6f78RxfqHWrsl6asFfAtPf3qWhRjO0ZDCPEUy6mG//0FkSHOQjE6h5wPuQnhOVg==
X-Received: by 2002:a05:622a:510e:b0:460:8d16:e8cc with SMTP id
 d75a77b69052e-4653d57baafmr68474031cf.16.1732329759264; 
 Fri, 22 Nov 2024 18:42:39 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c3ed111sm19290471cf.20.2024.11.22.18.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:42:38 -0800 (PST)
Date: Fri, 22 Nov 2024 20:42:35 -0600
From: Tom Rini <trini@konsulko.com>
To: ben.horgan@arm.com
Cc: u-boot@lists.denx.de, leo.yan@arm.com
Subject: Re: [PATCH] board: armltd: Make myself maintainer for total compute
Message-ID: <20241123024235.GW3600562@bill-the-cat>
References: <20241119172558.438470-1-ben.horgan@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8+04xlMJKymw+LvF"
Content-Disposition: inline
In-Reply-To: <20241119172558.438470-1-ben.horgan@arm.com>
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


--8+04xlMJKymw+LvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 05:25:58PM +0000, ben.horgan@arm.com wrote:

> From: Ben Horgan <ben.horgan@arm.com>
>=20
> The previous maintainer is no longer involved in total compute.
>=20
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Applied to u-boot/master, thanks!

--=20
Tom

--8+04xlMJKymw+LvF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQRsACgkQFHw5/5Y0
tyxmxwv+M0MEw9r7FFkmI5PGwy3zLq29PgDO7mWqlpEuPJcqY9lAqDjU2MwTjlM0
OyjjHllSQQkinbVpoO0wJYy5MOY83wikxts5JMad/0BOTEjUDTQiC1FeFC7OZxNI
eLC4B1zenVXJlRf7X6LqnYeoX+Y+sua4odeqhekA2099MS2ZCxVhTbNH9AEW6dOs
jWs0GRnhL0Ql4xTdRHSrBPUysmSduIFAgm4jWSnvCsE6dIqq6MxoiDor8e0ZE5Z6
StOuG3yPHZjnCUzJBGAw1DhiJbpIK+hr86dDzhusS8xOR6yY8yvshjr/zL4uBVhN
08W9v0TNd66L4nNBBbvuatlXchaLFDuDyWeKgGFra+IFl1QylgA08PBoU+dmhyEJ
q3/rbgSE3Wsq8Zbxc90RtZvdjUm41m/aZ3kMJXMdgWe4qJBYxT2rw72eExOX2HNh
7u1u0M51IEStiBoGh2pIUhJQsqdkh5xb9yd82tMyuFKgiJxzghjy/IH6RuXGcKJx
HpRKUPRq
=HmSl
-----END PGP SIGNATURE-----

--8+04xlMJKymw+LvF--
