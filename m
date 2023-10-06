Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE2DE92FD5
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 02:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D428086C7A;
	Fri,  6 Oct 2023 04:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q+T3mmpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E470286D29; Fri,  6 Oct 2023 04:16:23 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE3886C58
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 04:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59f7cc71e2eso20492417b3.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 19:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696558580; x=1697163380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w4ygzgpXvv2i7uIt7HnJAmBmKtoqn+BWCCZRV27bN9I=;
 b=Q+T3mmpEPelpIbf2BgO+wwHOJmtkXyi5YdZWDJvSiQvj8S3x2onlEOml3x/ckFhlBj
 5xpAo3msAc2+hOM6jPmQNP3YLg7rDIK5P5FhPd4eI6D877+CN/ueKFLQ40s/rhMc8sIU
 ixAH9SJeIdlb96lR3MnySRb73PmrBuAtfOZvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696558580; x=1697163380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4ygzgpXvv2i7uIt7HnJAmBmKtoqn+BWCCZRV27bN9I=;
 b=aWc4/pENevnrl9K1sBQCG57BZizWgsKGG3UMkPLsQ7eR9+ycfHj0Rcwpsvi4nIhq/C
 ZMCl74l6CpkFl+QyRnWkGCXgcGoMPrdjZLTEzPqp5CWZac6OJyEA774eTaElF5pONBVd
 a14QvvrllVxqYdSzGOdk8nn5EPj3Q8v3s/VlB1ix1AZsPGjyhUnR3TulZhoC1l2XPn1i
 mpeSIlF74n75sHrcwMTHYGlR24Joe/8qOTPXOTTVVexRqXCgaLIagtSMKMnCw3q3OLz5
 waAL+GPQ97lCzxCO3PU1QwA9PDp/ok6TVrH8D2SSqqTQgLALivmWl0R0rBKDBoMe7GCa
 m5dQ==
X-Gm-Message-State: AOJu0YzRgZq4kovIGpyu5yobqUWXQY7vEvd3rg0rGxkbPX+8N+PiXJE+
 wWNOI3JmLJl9/tRgezWEXB56cA==
X-Google-Smtp-Source: AGHT+IG2Td0SF+LwfDlTI2Yo8+qTvlke/H+jCv+zwENRP4/MwXXh7Quu47iDpAJ8jzir2qPJhyIHvw==
X-Received: by 2002:a0d:d305:0:b0:56c:f32d:1753 with SMTP id
 v5-20020a0dd305000000b0056cf32d1753mr6866963ywd.44.1696558580292; 
 Thu, 05 Oct 2023 19:16:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-385b-0a87-6b23-cb7e.res6.spectrum.com.
 [2603:6081:7b00:6400:385b:a87:6b23:cb7e])
 by smtp.gmail.com with ESMTPSA id
 u68-20020a0deb47000000b005a1ca828930sm926255ywe.107.2023.10.05.19.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 19:16:19 -0700 (PDT)
Date: Thu, 5 Oct 2023 22:16:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Leo <ycliang@andestech.com>,
 Michael Walle <michael@walle.cc>, Michal Suchanek <msuchanek@suse.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Rick Chen <rick@andestech.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 05/25] treewide: Correct use of long help
Message-ID: <20231006021616.GB2227687@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
 <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
 <20231005145350.GQ8465@bill-the-cat>
 <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ykiKeVcwV9TzopKa"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
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


--ykiKeVcwV9TzopKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 07:41:49PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 5 Oct 2023 at 08:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > > > > Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> > > > > Declaration of long help should be bracketed by an #ifdef to avoi=
d an
> > > > > 'unused variable' warning.
> > > > >
> > > > > Fix this treewide.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > [snip]
> > > > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_=
dek.c
> > > > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdt=
p, int flag, int argc,
> > > > >       return blob_encap_dek(src_addr, dst_addr, len);
> > > > >  }
> > > > >
> > > > > -/***************************************************/
> > > > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > > > >  static char dek_blob_help_text[] =3D
> > > > >       "src dst len            - Encapsulate and create blob of da=
ta\n"
> > > > >       "                         $len bits long at address $src an=
d\n"
> > > > >       "                         store the result at address $dst.=
\n";
> > > > > +#endif
> > > > >
> > > > >  U_BOOT_CMD(
> > > > >       dek_blob, 4, 1, do_dek_blob,
> > > >
> > > > This really doesn't read nicely.  I would rather (globally and fix
> > > > existing users) __maybe_unused this instead.  I think there's just =
one
> > > > example today that isn't "foo_help_text".
> > >
> > > Hmm, what do you think about adding a __longhelp symbol to cause the
> > > linker to discard it when not needed?
> >
> > Well, I don't think we need linker list magic when __maybe_unused will
> > just have them be discarded normally.
>=20
> Yes, perhaps things are in a better state than they used to be, but
> there is a linker discard for commands at present.

Yes, but __maybe_unused means we don't get a warning about it, and it's
literally discarded as part of --gc-sections as it done everywhere with
maybe 3 exceptions?

--=20
Tom

--ykiKeVcwV9TzopKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUfbe0ACgkQFHw5/5Y0
tywQjAv/WL8w9u04QtJGJXVvqWma8GUpRkT1byHmueswnnJCnTpSVVoqsg06goUt
zb5jQCx09PpqlIrrpbVuMtsO3M34XUHS6BdfzNkrUSgU918jzWRhza0NVR3An7FC
A+m5gwhPTUK5fESCABApUMHiY1Pry8iLD2c8OuNHAtApHD4nil/Qq7BEvDU4jnaa
TC6Q0is2ytV8LrdgQBPCOarIr1dkGFp5EKPN0zRtdRW2Oy30QNY9b+ftbFFcji1z
PCzSBS7jXa8Bq94ej30FQcKOxHExFDzoNDhk45jqAbYxFydWivbh/kQmJ0qbwdfO
bnq357eUccuHkWhvqAB1NQk5zBTq7g5TMnOQOAkD6mJczrDD2ZgHXh8rCkzoNZU1
MlgBcCwS7nXU/GdPd45HxppfR8m9K2va26G4LrQdRFa3VKqmT2WshJWC0WgA55Bx
OyFKBlLFW3wzS/T+XF6xLHtTbBkcrXKRTeOsWMkxVJ03U2yVqs8+D7wPR23JaBuJ
CqFEy4WP
=4RPY
-----END PGP SIGNATURE-----

--ykiKeVcwV9TzopKa--
