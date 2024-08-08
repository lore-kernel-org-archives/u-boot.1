Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A78C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB10B881E7;
	Thu,  8 Aug 2024 16:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WOxKoalT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F9988AF9; Thu,  8 Aug 2024 16:52:35 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7205688B09
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d9e13ef8edso789803b6e.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723128748; x=1723733548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+xCZ+7AavoAG8JwXBxoODdn0npKwVXDh/mwC0o+7LPY=;
 b=WOxKoalTzXPIBrIeFaQVqyltPJuIZOeIEAYy8ZrIofkfY3N1xmhLC/k9RdVx7MhHJT
 7p1auSEOAFJu336it1CGGow4uF72xoHAgmnT33YbVYmnEnhCMkCx/14sQcsAvNmiBKUz
 t2Xlcc8Q/hRe8JfoC4ET58Zpy+uqSSNfmA7YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723128748; x=1723733548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xCZ+7AavoAG8JwXBxoODdn0npKwVXDh/mwC0o+7LPY=;
 b=n2n7X2vtIhVfhTfyktzHHYCNlEffOMWchhbYnf2PMApMi9urBnlkQ6GFtshkhwzbVQ
 nmlOB3pH3QK924JArnP6Yk2cgjC7DtcivyL7oHuSWi0emjJCsktiHqTATBSNvbJsXXpy
 55EMLjVog2bMn/611flycyx1j8Y4JdnXxUC+tPBYKDJt1/i5SMHDhYcYezhm4lnn8PgN
 o2+6XAsSLBintNsoYFGe8xmGgyfLXUuCUxgZzAJh1ykxnLzBjo/LxksBXtT6YG5ty3I5
 JkgvM0xht1KyjH2MZ4m3gUnq03jXXoGRHp5n3T+P2A0B9xzfylHPc1YLsm5236U4QRKL
 u+bA==
X-Gm-Message-State: AOJu0Yw0XijaZ20SXnGeYo/6WEApptR7Zge4cPfGh016unUDGdwI0A8W
 R33/2SZ1jOLbwKR0v3Y3UXIgLi42O87IJxndRKIG2AoLpM1jBxSmk95B4/lBEso=
X-Google-Smtp-Source: AGHT+IGemwQcJh2qlWqGxb+t2PjpdrGf9mLPfxazvZE9UYMOsk/62MXmHv9iTywkUuKW1mtmwTC85Q==
X-Received: by 2002:a05:6808:2396:b0:3d9:dabc:7b76 with SMTP id
 5614622812f47-3dc3b426df2mr2306649b6e.23.1723128748480; 
 Thu, 08 Aug 2024 07:52:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db5637109esm4938320b6e.16.2024.08.08.07.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 07:52:28 -0700 (PDT)
Date: Thu, 8 Aug 2024 08:52:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, David Virag <virag.david003@gmail.com>,
 Fedor Ross <fedor.ross@ifm.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20240808145225.GM1626301@bill-the-cat>
References: <8d333c2b-2aef-bd73-4489-f79fa6be84ed@denx.de>
 <20240808135854.GL1626301@bill-the-cat>
 <e17ddd19-6445-b038-88bb-9ff59a11b735@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c926QlzImYLwibSe"
Content-Disposition: inline
In-Reply-To: <e17ddd19-6445-b038-88bb-9ff59a11b735@denx.de>
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


--c926QlzImYLwibSe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 04:06:44PM +0200, Heiko Schocher wrote:
> Hello Tom,
>=20
> On 08.08.24 15:58, Tom Rini wrote:
> > On Thu, Aug 08, 2024 at 10:42:47AM +0200, Heiko Schocher wrote:
> >=20
> > > Hello Tom,
> > >=20
> > > please pull from u-boot-i2c:
> > >=20
> > > The following changes since commit b7d5ce05b1b52136af09cf34541c6a9107=
9a4b86:
> > >=20
> > >    Merge branch 'master' of
> > > https://source.denx.de/u-boot/custodians/u-boot-sunxi (2024-08-06 09:=
36:46
> > > -0600)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfi=
xes-for-v2024-10-rc3
> > >=20
> > > for you to fetch changes up to 3d299c355912e05ba534574ac557ad0c9edd7d=
99:
> > >=20
> > >    board: vining_2000: convert to DM_I2C (2024-08-08 05:45:11 +0200)
> > >=20
> > > ----------------------------------------------------------------
> > > i2c updates for v2024.10-rc3
> > >=20
> > > - i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5
> > >    from David
> > >=20
> > > - imx_lpi2c: cleanups and support read transfers longer than 256 bytes
> > >    from Fedor
> > >=20
> > > - pca954x: Remove pointer to GD
> > >    from Michal
> > >=20
> > > - DM_I2C conversion for some remaining boards
> > >    from Anatolij
> >=20
> > First, I would like this for -next, at this point. Second:
> >=20
> > >        board: sniper: convert to DM_I2C
> >=20
> > As Paul noted, he has (and I've taken it for -next) done a series of
> > patches to cleanup and improve the platform now, including the
> > conversion.
>=20
> Seems I missed that ... sorry!
>=20
> So, should I drop this patch, and rebase to -next?

It looks like everything else was fixes? If there's fixes, make that for
master, and then make the rest for -next, and I'll deal with merge
issues if any after -rc3 and that gets merged to -next. Thanks.

--=20
Tom

--c926QlzImYLwibSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma026YACgkQFHw5/5Y0
tyzRPQwAhWcMHVraW/8MQxGIR2/m8cT1/GCO9EGBCVK0E+lyRXCywPF7ztbT3mIM
lsZAJfyPzN746clqiDuxOLtYzM9jKJJpZoKs2zSr+IDFomUTlvNGbQNiwm5nZoqP
q7HMttab73v8mSk9tZVhCKtvVXAQoAsr3wNRyw8ytH4UK7YObnU5DYrnZnh5nOCv
YCDB8qL+y7yF0bTmXsuqVQrPcqg0t4U0qsJ9SuSWRDJSYRXaO/Cm26YB6Daf2rPe
R2FEqXPpxv12q6hRC/n3N8q59wG4oWcX2lOGDyBtTxR4P8uRjZW6Rk+PkNXxPPno
nJkgYIxviOTL4ZZtBPu3BwCUmc9bsm6tO33l3kkQVzQp+yycf5cO6nzB3cVRgKp/
TUi0sfZRmSiarp4gruMZTAKxPFPZ3WaAznYAhBUQvm3gtGn/9++yNXuqx/LbJu+p
QymcUUXJndw7zKqp7buGgECzWFCMOKTe0pCtdwgsoEAqZXecPNiIW+K5sg2liFbB
RDJM/3QM
=mH0G
-----END PGP SIGNATURE-----

--c926QlzImYLwibSe--
