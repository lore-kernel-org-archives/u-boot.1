Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E270C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D754E87863;
	Wed, 13 Dec 2023 21:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jK5vrz4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0FCC87863; Wed, 13 Dec 2023 21:59:56 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8446787880
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5d33574f64eso75398877b3.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702501191; x=1703105991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vqJ8gVjWemcyzVS492rVJd1ceiE2PXLW8a6MWv6CQjM=;
 b=jK5vrz4bSoRIG3ubMTT21FBBa8kfUerjEmsxA+cGee3TFuzWKTVWrfC1NAE5xOdjJK
 70eUrOUZJSlTVwGjfdDtfo4VcC95falTApH3I21F3A1GCqWyLJVJuWMMFlpz8Myj/oA1
 RLD7J4eLFmdlrGzj1vOnMgD6w/ma+VhOLpPIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702501191; x=1703105991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqJ8gVjWemcyzVS492rVJd1ceiE2PXLW8a6MWv6CQjM=;
 b=Zla5PJR4CDOCh+ocHEdKtsmj/z1omb6O+lNtxNKD1v2VTiFPaup7Qd87+WjSHsKqvk
 utOgNUGjreOAXLCIw38uAkdC18A0Ok+kQf+dJXtQKxJ+mrRwQgxq0XnDwv8ouvAMcGf2
 6J9REhTnN1zUqJQDqB1KAIFbZf7x8OVclFGZO5OsJLiwPcTa/JTACYR1omSjP3kqe1IR
 c5/etjOaOB7sOcwICKsZc2VBnUr6j4Ug0ZAhBcUJMlpLx7SVyskwuYAmfwdDPOSL+Lgb
 MPgYTHn0sIhjq6jAH0dpvIaO0ciJ05GAeXqRLMcyiPocCSI6vorZOqZKFK5KUMX5tQaa
 EQlA==
X-Gm-Message-State: AOJu0YyN7v+WfJme22qspqTVn1+SlWbarbEHT1rDhjNM3rZRVmvenziq
 P0/Xfx5ji46Ss4KYSRmBmuEnvg==
X-Google-Smtp-Source: AGHT+IEOl+XIlRP875jxC4MIt+kmg9GTQl9wYMouqcczBNlaeYKUsU/2kjSrj8SNw/TL3YgnHHswgw==
X-Received: by 2002:a81:71c1:0:b0:5d7:1940:b37b with SMTP id
 m184-20020a8171c1000000b005d71940b37bmr8554364ywc.71.1702501191242; 
 Wed, 13 Dec 2023 12:59:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 t139-20020a818391000000b005e29920fbaasm995548ywf.47.2023.12.13.12.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 12:59:50 -0800 (PST)
Date: Wed, 13 Dec 2023 15:59:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Message-ID: <20231213205948.GL2513409@bill-the-cat>
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
 <20231209154839.GG2513409@bill-the-cat>
 <CAPnjgZ0TxjEf-CvN_jC-c_7yVMb473YAjy-GH=Zrj6wwb4fqFA@mail.gmail.com>
 <20231213204250.GJ2513409@bill-the-cat>
 <CAPnjgZ0qK5J=Q3xPK6K5BhXi2jpSYBchSR8n7mHEi15ekLn1Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wh8UjYwbFpB3voWh"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0qK5J=Q3xPK6K5BhXi2jpSYBchSR8n7mHEi15ekLn1Hg@mail.gmail.com>
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


--Wh8UjYwbFpB3voWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 01:51:00PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 13 Dec 2023 at 13:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:50:02PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 9 Dec 2023 at 08:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Dec 02, 2023 at 08:33:48AM -0700, Simon Glass wrote:
> > > >
> > > > > The cyclic subsystem is currently enabled either in all build pha=
ses
> > > > > or none. For tools this should not be enabled, but since lib/shc2=
56.c
> > > > > and other files include watchdog.h in the host build, we must make
> > > > > sure that it is not enabled there.
> > > >
> > > > This part is what I see as the Wrong Direction. There's some code we
> > > > really need to share with our user space tools, in order to not
> > > > copy/paste the same code. In turn, this code must be as user-space
> > > > friendly as possible. Maybe even we re-factor things a little more,=
 if
> > > > needed, so that we _just_ have the library functions in common file=
s,
> > > > and u-boot or user space only files have the make use of logic. I d=
on't
> > > > feel bad about tools/ needing:
> > > > void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> > > >                 unsigned char *output, unsigned int chunk_sz)
> > > > {
> > > >         sha256_context ctx;
> > > >         sha256_starts(&ctx);
> > > >         sha256_update(&ctx, input, ilen);
> > > >         sha256_finish(&ctx, output);
> > > > }
> > > >
> > > > (and so on for other algos) as a duplicate bit of code. Much less so
> > > > than I do about adding <linux/kconfig.h> to a direct include list (=
since
> > > > we should never be doing that) so that later on we can if
> > > > (IS_ENABLED(..)) the existing code.
> > >
> > > Bear in mind that we have the CONFIG_TOOLS_... options entirely to
> > > deal with the need for tools to enable features in common code. This
> > > SHA thing is a very small part of the code, compared to common code in
> > > boot/ for example.
> > >
> > > So is this really a win?
> >
> > I don't follow you here, sorry.
>=20
> I mean that we share a lot of code already, code which contains CONFIG
> options. So does it matter avoiding adding one more?

It's adding <linux/kconfig.h> to files, we must not do that. And we
don't need to if we don't have <watchdog.h> (and that in turn,
cyclic.h) included outside of USE_HOSTCC :)

--=20
Tom

--Wh8UjYwbFpB3voWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6G0QACgkQFHw5/5Y0
tyyGyQv+PM7/iW2B74cTfZ7lfcLG2nl6n6FY6oRUkC8trS5SDVhors5UGWTM5xif
jE1XNeDlVYmf/gxKfDj2WwoweaYndj7rjcF0mcAwp6OnF02KB2ZjmKFfzggHH1jo
fE0cljxdcNbREUrk4gZzaFojqnaxotyFSbFssIzVQyhGVynMEh74d3BBzSUA2ZJ4
7nrEcLfK559YZ1ObmXsWcpdxalLC2uz2Pf6WKgmZP5aJgQ4795vjkoF7D7IdARyY
HYSB1Iqu2tpiEb5eT5rNNKgC1v5QmdLJhSTq94F+67j1a0BzqOHg8DDP2au+tCTF
YWa47C/lG0GEvEzS3M0w7Vllw/Tw2F3f7g6ycxh/PC5Ttj3cAtDUEzppgsH59vxC
uIUc7S6LnwkMiodFg4uvwsxVVh7yD1NPoQ/7vJiCaeNImFQdrIAm0qgr82ocn+Fl
P8kSQeR/+LY9GWA+JY5GaerAw3quzQb6W2L9JjxBJSHdyPTkVLS4bMLQG5uc0T5T
JR/HqEe5
=YC7U
-----END PGP SIGNATURE-----

--Wh8UjYwbFpB3voWh--
