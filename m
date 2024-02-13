Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA68CC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 22:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBE787DB0;
	Tue, 13 Feb 2024 23:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oHLciPPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDE987DAB; Tue, 13 Feb 2024 23:33:23 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93EB87DB0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 23:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc745927098so4109390276.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707863595; x=1708468395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=beN8ApYo0+qEB8FdinlorFh0bDkc89vxbpvqhet/HPA=;
 b=oHLciPPuC29bwSrn6z9VPyALPcgKL7eiYRuVAlaC0UdlqtnzEn886wbm4HVi/jVSMK
 fz1zO42DsbrtBZajYV8Tlpjg+Jc67Ms5BRTnAoKgQPHqjDBh+GkmtYHX+16KxYfcaTTQ
 y4ZzGkD/Wxg1+J8hI1eEuF98KlVtZXTzh4xXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707863595; x=1708468395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beN8ApYo0+qEB8FdinlorFh0bDkc89vxbpvqhet/HPA=;
 b=GmMHV17DluK5Gp5dKZORGktuQwV+ArHQfS+S9Jtx7hdAH3GI1+4dFC9a/uHH7kLIW9
 FyAENE3396JcZpYTsDpTsD3F+rESIpdQYsxWcA+E0ZCAOl2iMxj52lAMzJtSaMFnSifL
 wQekchdiSS0otY3uhYu0Q4WwZKieNT3zutM/WdgCELjusbrnw06uCW2nsFBVxEwk8f0M
 flFUos66p1BjTJC6PxP/xo77X9kLtZ5zjtD+cZL7CsT11jaQc/XJHDCFDvxBnNfTGocO
 7EwwVbZjy5dx6OzmdANq5+tLtyNB1bD1ZfMOVl11W53kOFK8+nRld0Ord4wlVSWU2bKE
 8yPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGF7HPDuHw19j4H7TrcFfFcj2cNfgVIOIdkqQJ9sRY3I65KucQaPjPAKl5nsqYZ96k/rSNd7n0UBJT+FzRi0uJFkOtmA==
X-Gm-Message-State: AOJu0YxN0Z+si9LMBaf4QUPkdM1Bo0VqJP65lqwbDUDv3dKoWajD+7ST
 T6nGiwuuK/txXOeF45Fu/+BEYDOWPqhVycvorH10g66PoMA6p7Fq1w0UQNhiayo=
X-Google-Smtp-Source: AGHT+IEYsWPxmC8ZXW7LmczLgR8Tw1DMMcUIvAnI4xEELewKi84h+745027dYpyjSnqTTENHIRDEIg==
X-Received: by 2002:a0d:f346:0:b0:604:2c8:e49f with SMTP id
 c67-20020a0df346000000b0060402c8e49fmr762053ywf.50.1707863595618; 
 Tue, 13 Feb 2024 14:33:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUwq53mRIRDm6r67e2wcdRlcY66Gkz7tFpAiGFI8vq0Dv40O/uBfm5DhgQFn73uJv/qpdSgWZX2Ig9GDgCXCR0LHH8N7TRB/Wn/UU2FymWg6EluHc6kAhlv49rbuZIyzRMuMVM=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 v139-20020a814891000000b006077c89b001sm744364ywa.83.2024.02.13.14.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 14:33:14 -0800 (PST)
Date: Tue, 13 Feb 2024 17:33:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] Revert "board: verdin-am62: set cpu core voltage
 depending on speed grade"
Message-ID: <20240213223313.GX3040305@bill-the-cat>
References: <20240213160003.18725-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tJSK+dRt+1iaj5yd"
Content-Disposition: inline
In-Reply-To: <20240213160003.18725-1-francesco@dolcini.it>
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


--tJSK+dRt+1iaj5yd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 05:00:03PM +0100, Francesco Dolcini wrote:

> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> This reverts commit d2099587d661c6ca2309256c0e04c06e26c8d34c.
>=20
> According to TI changing the VDD_CORE while the SoC is running is not
> allowed, the voltage must be set before the AM62 device reset is
> released, revert this change therefore.
>=20
> The correct solution would be to program the PMIC during manufactoring
> according to the speed grade of the SoC.
>=20
> Link: https://e2e.ti.com/support/processors-group/processors/f/processors=
-forum/1318338/am623-booting-from-mmc-failed-after-lowering-vdd_core-to-0-7=
5v/5036508#5036508
> Fixes: d2099587d661 ("board: verdin-am62: set cpu core voltage depending =
on speed grade")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied to u-boot/master, thanks!

--=20
Tom

--tJSK+dRt+1iaj5yd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXL7ikACgkQFHw5/5Y0
tyznQwv/UkKmh95jcH8QQKQKwpdwYwRvs0K2ljz6/Xp24OJ0CDAXdHRv3Z/8otmy
Nqe+D9IfkzSRWJrE14hXkOHTdnszsYrUJxWdJLQQpxJgzrv+iDgNlfRdAJpio+mX
x6hQCSdjonJSzjfDI1ojcRbebuKy3OnQiPsd46RqPI4zWMQWEsZg1VHnwSULFEwj
VJSC/Yacw3QaCsAtfRBpQRAQmD6i0PXrRO9yAEDg5Vmo9d097/01mQt/MWC+LzHf
AkxVSLcfV0iks1A8v2NrPRvkIdzwl6XdbKI4ipwj1hnsJpznYJi1Ot6kS7ly+pdZ
SKLAxPh903KrlcqKQhzMdp1URPf5aYyHuAyJP+BQPxKGMJfCDuspks4u6Y5iKcal
HLka6Iw5fLalI18viCEmV0+y8jEEDSVY5+VJ2OBkRJt5pja9n6sK6nyr6QrfbCKV
fw7q//GzL6gIB3liVZpCJcyoDSL4LHmsGSF34x0Xk6zcn/GypNZfijNhByocb7a8
nTvfLrHM
=yBAl
-----END PGP SIGNATURE-----

--tJSK+dRt+1iaj5yd--
