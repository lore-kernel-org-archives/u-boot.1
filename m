Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D913CD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8058657F;
	Fri, 18 Oct 2024 17:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e0IM5+rE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6629085B66; Fri, 18 Oct 2024 17:18:00 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4EB8657F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b12a02596aso145563285a.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729264677; x=1729869477; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mT3lkaxXFAMP9emSLLbcOiyubHxyCOgSO0uA21IEQdI=;
 b=e0IM5+rE5x9mwZmqnW3x68nhB+Lql1iIUtFy5qdX74rsIt2REmFvKvyIpYdGGhvBt6
 4DdzaWSDImSi5TCorpXn7JIlnuB7z7Is0uAwDLRvWpF6I15Wz1Fu0Ssk30SW/mJLli9L
 HTAk+Dk4B+WPEOd3xakTuuShPZEudywZNLzp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729264677; x=1729869477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT3lkaxXFAMP9emSLLbcOiyubHxyCOgSO0uA21IEQdI=;
 b=jirMz+wukOOHF1stHoVZzSwLmxyZTc7PFbP1513F6znvbfjRrzqjamg45hWZChHmxa
 LTUYpdM95JlfKFPMta/NSHHMX19i/ZXb5zqApCprSm8zO2AdizRGix1jScK0kMqJSo6l
 VqT4B+TCBpPSegDuz9mgxgDbK4YRoATzkuvwW14J7EKObw9YXbnT/PRllrW97FcYJQNi
 FancyqhyFvJK5zst5A5xIQB0xMfIYInexgiySxbR0zXP34Q4W+bdHk9rUyw4IfJCPBgT
 anHY3kKBWCKf6+XA/pM+Ta8xEUzYxLxBJNIaGIeVuX+IlcbqmklIpk9/oEpZZvmNvylZ
 YpEA==
X-Gm-Message-State: AOJu0YzHCwzB19o3zuzFv0Bj9Yci9LRWsbJlxdu3jpFUgiJFZ9CvotpK
 pLpGpfcA2nbo3rjIj47lFZHb9nytKdAkeOzWH7PzylNvyN/RwqbT7VmoZJgY7Xk=
X-Google-Smtp-Source: AGHT+IEQfE0HZh4LbTR/FJSKRaaPPh1n7Yo+GEzFVjXEAPpe2I9/Kv9fOCtgjt81BMNelf3mydI7YQ==
X-Received: by 2002:a05:620a:19a9:b0:7b1:3b5e:4b50 with SMTP id
 af79cd13be357-7b157b5a727mr340226285a.19.1729264676899; 
 Fri, 18 Oct 2024 08:17:56 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156feff73sm77421085a.124.2024.10.18.08.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 08:17:56 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:17:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 15/34] image: Add a new type for extlinux
Message-ID: <20241018151753.GY4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-16-sjg@chromium.org>
 <20241018031455.GU4959@bill-the-cat>
 <CAFLszTiELZL3ZAm38z9y0yLx+XEU-EUuV5GVfjU=-3WdpkTUDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qxxuTUZR66IRr3tY"
Content-Disposition: inline
In-Reply-To: <CAFLszTiELZL3ZAm38z9y0yLx+XEU-EUuV5GVfjU=-3WdpkTUDA@mail.gmail.com>
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


--qxxuTUZR66IRr3tY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 08:57:02AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 05:23:54PM -0600, Simon Glass wrote:
> >
> > > Add an image type for the extlinux.cfg file, which U-Boot supports
> > > reading.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  boot/image.c    | 1 +
> > >  include/image.h | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/boot/image.c b/boot/image.c
> > > index abac254e026..cf16fb7fbf7 100644
> > > --- a/boot/image.c
> > > +++ b/boot/image.c
> > > @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] =3D {
> > >       {       IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Fl=
at Device Tree ", },
> > >       {       IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image"=
 },
> > >       {       IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
> > > +     {       IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configu=
ration" },
> > >       {       -1,                 "",           "",                  =
 },
> > >  };
> >
> > This whole part of the series feels like we're abusing IH_TYPE_ far past
> > what it's used for. Especially the command line string one. It seems
> > like the main use is to be able to later on print something human
> > friendly. Please try and figure out some other way to do that. Thanks.
>=20
> Yes I had the same thought, particularly with cmdline, as you say.
>=20
> The obvious alternative is to just have a string which communicates
> the type. Then I can use IH_TYPE_INVALID, perhaps, with an extra
> string indicating what it really is.
>=20
> But one advantage of the approach in this patch is that, for bootmeths
> which include a cmdline, it can be identified and added as a file.
> That includes zimage and ChromiumOS, but not EFI. It will allow me to
> get rid of the cmdline in struct bootflow, perhaps.

Yeah, this all sounds like IH_TYPE is the wrong direction to expand.
Where you're grabbing these things from is where you might get a hint as
to what these things are and that's where to take the store the
knowledge for later.

--=20
Tom

--qxxuTUZR66IRr3tY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSfCEACgkQFHw5/5Y0
tywFGwwAuCOzNS+gv5HZGvzKndt24tOm+eH2TEXPbgs/ZcYJb02d8dLbQVMQ198W
OfwtYDTGOutxwBKgd6KD9GFMe1RzLF6+YfdXKgF7Qpkk2HKhl1lyKbDPGKcf73qO
7JIR6vHwYFm78MgJjfff3lpJGXPN2N2S7yaWnf2d8bwfVDsApktbuMo5KgraR85R
nyz7kjH7r5MEv5KMXKG13YffhLvAjw7o+MtymrK8krmtvmadTdRROt7uhuAKdscw
MFk8xibFzSPF9h3wAqpTK6IwQPHl1Sg/R/9kYpJ/2rrgmmXnFOh17/j4zNS1B6NH
nWBxvvNAhx+yYfJjmHZXmUrUl4sTFkyACxiwh46jrqgB/ibmDALHmTSWql1muFmu
A0m9u6AnJgUoMy0UITbI1nfZitRidu+lmxlndLMEjOwKkSZAqfWfxPoRn4RLogA5
fP1JwTaN6fVRSfvp7Tlr8NV9hPm5ZgB5rp2HomiLU2qDgM5uY7dtPHwXMHyaD7xF
y1Dhi+AA
=mHjx
-----END PGP SIGNATURE-----

--qxxuTUZR66IRr3tY--
