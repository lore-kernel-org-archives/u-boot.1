Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11044C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 12:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0DB88804F;
	Tue,  5 Mar 2024 13:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p6b/guTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A585C88047; Tue,  5 Mar 2024 13:42:59 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C42188041
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 13:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6905d51fdfbso29326466d6.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 04:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709642576; x=1710247376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wk69115rxQ7gj5iSGgTkNwUAZw6Ry8B22GrBL+mokpY=;
 b=p6b/guTU3Z5rvgqZJhuZbwwfjt+IOL9EHOcGHnpdHo+2vWaoga+YizZVsWEEw8ufsr
 csB4Fcc8eK2JY5zuc+AmKx2Z16PqE/Z6rCWz8JbsHipAxffAkR0TW7rJTB5FzTYuof1E
 OfUxDD5GVaSLNxA9jE3pTVTYcCmnDBp415Juo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709642576; x=1710247376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wk69115rxQ7gj5iSGgTkNwUAZw6Ry8B22GrBL+mokpY=;
 b=Ql4luUWcf0ogMahtKGDzICX3ETQyn3ISQj7RJMVhGxd5T1vZ4ap5+6I81y1fCeHO4t
 W5o57tIXMF9sr2vEZZkkfPtckSSn0c2/iI9VEPTewJapG01bcAmgntouAhfvc22+iu5o
 t6w8zsXt6Z/0jRqXW5JWzw80YX8btLW8szqBed6L6tbuaBIwy8nXg0a/rdb26c8zeNAs
 NFzhFjHxQPPmOq1HuYh22kwI5UQq7Fs52oqU3B98XGCOv2HVhAHhIP7WZGA0CSB8Fv67
 tDR9Mf3eWUA1xZRYT1cOSI+25GsxKANH9e7BKBQIE8leO16xhVyVRenz4DafLaQnBG54
 nkoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrY3l2tyu6b3V6RWBzFObT1M1Q9afUdh4itSuV2zUFrWZyTM7gUetGrrReiT2pMJwlejI3qpLWVkVML916qcsXEOaYWg==
X-Gm-Message-State: AOJu0YzkGmIbesvVAe44+AP4krnpjA4y4Md3VrqBRuMUK/5ZBgDzhB/d
 UdDjm0p/AGURDX0dm9Bh2aO45pKWoN0P2+bhKNp3lhr/qrChPh9+n2u21UBiXbE=
X-Google-Smtp-Source: AGHT+IFLNemNWxb6qjPWkXHj6fl0HhKSexUpwLRPqamXkhTxAKI2ZSemBXE9u8kgXTgwrXjDU6fpLg==
X-Received: by 2002:a05:6214:1255:b0:68f:5d7f:6a8d with SMTP id
 r21-20020a056214125500b0068f5d7f6a8dmr3197673qvv.3.1709642575818; 
 Tue, 05 Mar 2024 04:42:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 ol14-20020a0562143d0e00b0068ffdb8fb59sm6208452qvb.112.2024.03.05.04.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:42:53 -0800 (PST)
Date: Tue, 5 Mar 2024 07:42:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com, uboot-snps-arc@synopsys.com
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a
 specific vendor
Message-ID: <20240305124250.GZ1523872@bill-the-cat>
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
 <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KtIN09n0sxjAgv0F"
Content-Disposition: inline
In-Reply-To: <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 05 Mar 2024 13:43:38 +0100
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


--KtIN09n0sxjAgv0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 06:05:52PM +0530, Sumit Garg wrote:
> Hi Caleb,
>=20
> On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> w=
rote:
> >
> > This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> > all the devicetree files for a given vendor to be compiled. This is
> > useful for Qualcomm in particular as most boards are supported by a
> > single U-Boot build just provided with a different DT.
> >
> > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
> >  dts/Kconfig          | 24 ++++++++++++++++++++++++
> >  scripts/Makefile.dts | 17 ++++++++++++++++-
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index b9b6367154ef..67d9dc489856 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -100,8 +100,32 @@ config OF_UPSTREAM
> >           However, newer boards whose devicetree source files haven't l=
anded in
> >           the dts/upstream subtree, they can override this option to ha=
ve the
> >           DT build from existing U-Boot tree location instead.
> >
> > +config OF_UPSTREAM_BUILD_VENDOR
> > +       bool "Build all devicetree files for a particular vendor"
> > +       depends on OF_UPSTREAM
> > +       help
> > +         Enable building all devicetree files for a particular vendor.=
 This
>=20
> Do we really want to build all the DTBs even if many of those aren't
> supported by U-Boot at all? I would have rather added Makefile targets
> for boards which really supports a single defconfig eg.
> qcom_defconfig.

Yes, I think this target is useful as it addresses some of Simon's
earlier concerns with the feature.

--=20
Tom

--KtIN09n0sxjAgv0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXnE0cACgkQFHw5/5Y0
tyxtGQv/Wod2EBmX5FhenEgBCfdTBzSxdGJ5+X+907CEYEwKHQ2EKUD/rLyaYBWh
YoLu0e5mas2+3PSBBWdmvapYqusnc6vXxr53UYOSXkMzWuL1FeMvirhrelb1jdfC
S3bB3gnPMXZukz8q6DpsjfOpeAJiWPtYmSYJPZBq7aXgWusAFIb1aGEww+Zp2R+4
AZqwEuT0g4IBCJvjVg/B+QcaH8LivpTGBATr0kTMvRHRKuuu6qD0VqOKgiUVqQnW
Ls4aIfSm9ul0rUBEgkeatEVprJVO5wXxye6l1DXLCtsURyBmKpP9trV/ZLnzTDZN
sakhwNI+y1A36CFSM8EVFUcXqulgFD/OV0prY4nYZswhezgT/MOg4lWisSa1xJ/d
c2h1BWzsYIgNULElLCiStIZwpHI4hD09XL4T5whAEYYmX3NK4pK9gSq4M/JXhRCH
aJrCz952CoPnp/t3S8LJyW34GwdbOo1XfxlUPnoLv2EGMIAZKzEl5tX3wAyu3xNn
6Hcdp7my
=UZMy
-----END PGP SIGNATURE-----

--KtIN09n0sxjAgv0F--
