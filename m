Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A57EC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 13:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2838775F;
	Fri, 22 Dec 2023 14:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JB2Hc5Yi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8CF87861; Fri, 22 Dec 2023 14:56:46 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 448A48784B
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 14:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f85fe5632so10938266d6.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 05:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703253403; x=1703858203; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8V1pJQtrKz3Yj16jx1kP7hGNDG81Ij/mbdhXWLlajaA=;
 b=JB2Hc5Yi+PJ02q/so4bHGB2VCkli9420NnKmJiw3/HEWANhYYIiCRYZcUDcu/SHfrE
 bjzDDdU5pQ+adYJ2GZdUgjwTln7Za0/VdX0IltNLAcEi8KDfs7r2eMSjsh6zQoKdaK7w
 fgbG5fCZ5JjCk0JM4rvo+cFRv7walDzPlejz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703253403; x=1703858203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8V1pJQtrKz3Yj16jx1kP7hGNDG81Ij/mbdhXWLlajaA=;
 b=dLXkgCIhK3lT/yoFwCpfHTZX6TCs/uvurFkVb4WPmWF5lUVuKU27OYKUop/JiDDGox
 f4j/4zTRaBT2v+7jozQF4In6vnf4c1MsOT72pAeP7BoD8m5aCpRnwfRTg4P+jpD05H+j
 /lrS/O7SfG7puVyhfimpqW+zg/YQlr3iIvlObSZcHb5jLdnhbETxFrlbBz4hWDrNej9c
 /eKn2yzg23t2p5UpZRHPu9x6dTCgHqzYT/4CX2UQ640RCyZGrjjc0AjXQUzTsmpKdZFC
 VAnPZUgFIzjEnP7CdClcD5s2SmS6T+E0e4tNdxEpXZmxVsW6SGz3NeIMTN3opOSvrC5n
 sj5Q==
X-Gm-Message-State: AOJu0YzD1oQSAR6E5iFRCU4amdkgF3XQ9MzXZ0wc0CLplEa+KgpTxsjc
 MDCdfQzBD3Xo9qbu7akbl9z+eHCrSgv2jg==
X-Google-Smtp-Source: AGHT+IGspO/jhoamsfFTchr7sY24jRSPl1lFEgtvSWWsV+v6TRKFqy4HRHYTwh3OU4/gxnXlr4X7jw==
X-Received: by 2002:a05:6214:2421:b0:67f:2523:c384 with SMTP id
 gy1-20020a056214242100b0067f2523c384mr2207407qvb.10.1703253402990; 
 Fri, 22 Dec 2023 05:56:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 bt10-20020ad455ca000000b0067f30a6c145sm1394211qvb.38.2023.12.22.05.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:56:42 -0800 (PST)
Date: Fri, 22 Dec 2023 08:56:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH v2 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Message-ID: <20231222135639.GC2513409@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-6-sumit.garg@linaro.org>
 <20231222123504.GA2513409@bill-the-cat>
 <CAFA6WYNo3mNE94tHo0-iogbk49ZSo4WXzRWPME=XPZ7F1H5a8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XgD2i9jo4/iTyhYm"
Content-Disposition: inline
In-Reply-To: <CAFA6WYNo3mNE94tHo0-iogbk49ZSo4WXzRWPME=XPZ7F1H5a8g@mail.gmail.com>
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


--XgD2i9jo4/iTyhYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 07:18:05PM +0530, Sumit Garg wrote:
> On Fri, 22 Dec 2023 at 18:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 11:42:05AM +0530, Sumit Garg wrote:
> >
> > > Encourage SoC/board maintainers to migrate to using devicetree-rebasi=
ng
> > > subtree and maintain a regular sync with Linux kernel devicetree files
> > > and bindings.
> > >
> > > Along with that add documentation regarding how to run DT bindings
> > > schema checks.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  doc/develop/devicetree/control.rst | 108 +++++++++++++++++++++++----=
--
> > >  1 file changed, 86 insertions(+), 22 deletions(-)
> > [snip]
> > > @@ -81,18 +94,21 @@ Failing that, you could write one from scratch yo=
urself!
> > >  Configuration
> > >  -------------
> > >
> > > -Use::
> > > +Traditionally, U-Boot placed copies of devicetree source files from =
Linux
> > > +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via::
> > >
> > > -   #define CONFIG_DEFAULT_DEVICE_TREE        "<name>"
> > > +    #define CONFIG_DEFAULT_DEVICE_TREE       "<name>"
> >
> > Oh, oof. This never got updated for Kconfig rather than config.h. Can
> > you please include re-wording this to be setting <name> when prompted
> > for DEFAULT_DEVICE_TREE by Kconfig? And the rest of the text you're
> > updating as well to match, thanks.
> >
>=20
> Sure but how about changing it to say via board defconfig as
> CONFIG_DEFAULT_DEVICE_TREE=3D"<name>", since AFAIK most people use
> defconfig to configure U-Boot.

Well, do kernel docs tell people to modify defconfigs, or to use the
config menu/etc?

--=20
Tom

--XgD2i9jo4/iTyhYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFlZcACgkQFHw5/5Y0
tywQfwv+P6MKaaRbgzBd0cy4/MZptCmQzlzI72hDVQaDzdaK6+aaxd/IwnM2WjNk
mBVZfAm9R2Vd90Pz6IVtKjT+DFJLt6W0d4dVrQJijluZ8wDJDi4XShovwZpC8o9a
QYsye9RxeixsbXWeGCp/OFIwKl4UcM0QiC8svqMqqQroFNeUiHeYCWuPekHhwFUR
AJn95C03hz5mTpCglwQH6QCrKoBDgj06TpoIk49ypbgu0ACID4Ax+uha3sP2yY20
VbkGMcN2rVS9Mza+55m9uZ8NTzpN40T73v3ZgCdFIgEK94louCoJMN4tqr1ER+pq
DeR8v/oXWlmylv9UVRz+dZnYnn3TIP4WBkkk8+hOyRHn9XJdotGF3sS6wQXVFSLh
OORVKr/RpFtK2rEw5rj2uF/DYkVmg3Jk8BTdHc+Ho2Ohp906SWZFfGa9YU9H1mNi
bn+WhSO4e2QXf6HIFiOlugZG/4Q324wrVX51PsNP5r75G4CNcx4q5B8/LOg0NejJ
tMNBwrXD
=/jnI
-----END PGP SIGNATURE-----

--XgD2i9jo4/iTyhYm--
