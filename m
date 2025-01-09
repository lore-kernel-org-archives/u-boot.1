Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52EFE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 16:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B70058005B;
	Thu,  9 Jan 2025 17:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XrHvn+Gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45C9800C2; Thu,  9 Jan 2025 17:42:38 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934EB8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 17:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6f7d7e128so187587285a.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 08:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736440955; x=1737045755; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QRhzDpG2JcVHa7YguEoY5nlSZ+bKXuo3Avy2V1wG6BI=;
 b=XrHvn+GvtzET+rIUBPrPtsrDHeD9XaHQKw8XegJixB7QO9iSsZZApZdUiP7ZFbfDid
 dHrBhK/owMtnVkHhUX/9fl1UGtqBe5RjS1eDmZEG7YKlVQPuZwwkNlnl2DXTbVzUqDuX
 EyJyjMmOBoJXOSBpvFxggZ6b4V8nSkJrEllHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736440955; x=1737045755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRhzDpG2JcVHa7YguEoY5nlSZ+bKXuo3Avy2V1wG6BI=;
 b=a7ATXEkFqAnO3UUUWhqCOwgmFDJq+8mdCSeg69SKp63VIWVRY9ZmlDsaPDT7g3Ajmy
 OkIblYGBiIGlhfZu0CgT0Aupfn+7GMSP+6//M2Htnsa1s6KPfDGvZyhzTrqJrxaPSOpG
 J/ypOVkghI0MqT5jmbLA5h5FC5Ebkg/xOiNKAk8OXdysBK6Z5LDK+VRIVdEWWgkDRUtH
 nVujbyqD/I4lNAManPx/dZHcU0MNEcClu5fmQGOGpkXfofccAy0TfJjNxv402ApeEA7P
 7XRn0QAiP4W6Z4FHIx8Wibw+rpqkHn/6wO6aj+tNQRYrx28C1Jd9rWBH0Xp2wu0+SvQg
 3jkQ==
X-Gm-Message-State: AOJu0Yyz/BwpZZXUeH8iaDLE9UlddBT3LeTtbJ1MAZqdCkIHlKsBrAd+
 2J+jq2yMO2mGu25zSE7zeUNRQrHdoxI9aRfYlg6z1ajMCk8PMmUmiIaCQZ59UnE=
X-Gm-Gg: ASbGncuohtUAPe0tFGs1Kypiy9yCwfy+akL5fElVeZzyRqOcsZeS3WV72r8TMvcDZbq
 UrfJnt3hgJspQLN78dbdjKAZ+DCIgipoPXwdSsJsDKqKW7zW8NiwEC2TJNWd2p3Z/h871FColRP
 6wJflGCnSRFBqPZnGUqM1/5XVOzeNBABg5guS2fXfupamIsteVwJJeAmXZaEEMf32OKrDVF8brY
 Wb+e9eDRkKZ5Z0nHu4mh15AESTfzoiC+9AbkKX1AJG/1UeFbp1bkbk=
X-Google-Smtp-Source: AGHT+IGjvMjB9LXY/NCdzWgH0UR+cdqRnuGxi6+QeAVb/jtX4OltkyAWwnf00jXqbRVtUnGLGW5H2Q==
X-Received: by 2002:a05:620a:244d:b0:7bc:de68:e932 with SMTP id
 af79cd13be357-7bce1265ce8mr545261885a.23.1736440955383; 
 Thu, 09 Jan 2025 08:42:35 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3248ad6sm83348785a.44.2025.01.09.08.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:42:34 -0800 (PST)
Date: Thu, 9 Jan 2025 10:42:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 03/33] bloblist: Make BLOBLIST_ALLOC the default
Message-ID: <20250109164230.GY3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-4-sjg@chromium.org>
 <20250106214130.GC3476@bill-the-cat>
 <CAFLszTif6J6r48DWca3GSuGwnARuzJdnuhbi9wkr8ws=0S6Cjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YtNYCxJY4dBrdBB5"
Content-Disposition: inline
In-Reply-To: <CAFLszTif6J6r48DWca3GSuGwnARuzJdnuhbi9wkr8ws=0S6Cjw@mail.gmail.com>
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


--YtNYCxJY4dBrdBB5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 08:01:17AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 6 Jan 2025 at 14:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 06, 2025 at 07:31:59AM -0700, Simon Glass wrote:
> >
> > > We want to encourage people to use an allocated bloblist since it is
> > > more flexible than a fixed one. Make this the default, being sure not=
 to
> > > change existing users.
> > >
> > > The unit tests require BLOBLIST_FIXED so add a dependency in the
> > > Makefile to avoid build errors.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > > diff --git a/common/Kconfig b/common/Kconfig
> > > index e8d89bf6eb9..a00387a4609 100644
> > > --- a/common/Kconfig
> > > +++ b/common/Kconfig
> > > @@ -1039,16 +1039,10 @@ if BLOBLIST
> > >
> > >  choice
> > >       prompt "Bloblist location"
> > > +     default BLOBLIST_FIXED if SANDBOX
> > >       help
> > >         Select the location of the bloblist, via various means.
> >
> > This should just be "default BLOBLIST_ALLOC" and sandbox platforms that
> > are using the bloblist can be like the other platforms using a fixed
> > address.
>=20
> We don't need 'default BLOBLIST_ALLOC' as it is now first, so is the
> default. I would like the 'fixed' thing to be later on so that people
> know we want to stop using it.
>=20
> All the sandbox platforms use BLOBLIST_FIXED. I'm not sure what change
> you are wanting me to make to this patch?

I'm wanting you to not re-order the list to change the default and
instead use the default keyword to change the default.

--=20
Tom

--YtNYCxJY4dBrdBB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd//GwACgkQFHw5/5Y0
tywo+wwAolOZKT2aKVsEBEOpZZfqW5mOc8zYa6BDvRtgmpLXRLzaNq3RQspBtem2
y+ibmfeLYIf3ro4WbUrzTeAdRONYdzilyf13IFajA8bclMdp328S8nSiGwWXpdJi
a/v2+JBQRo2vbvOrteyPcE2VeHbbCyk3vo6MzGt9DTHJe1YaVyiVk/9t3tmH1Awq
+fXMedp3hp2rpjl67gk4n0D2XZdCQrhcDufeUngya0Tv3N+ypb9vZSt4Cpvd1ieB
ZJmOsmCfgsqAf24scFRBketkyxwx8DyqcQforMn6f6AUyL0+JITbKLP1vtjEhm4Q
MYz+cAP9XvTYLLSRMAnwafVIOy9/QrzSsS6sno/GC8u7/mnm0LixNIKWOLta6epx
LUwbVZs6N8QBxh/Xzc3bdmy9y9UuQRLZ7Y6Di5VtxXdXKzHLOWtW978DQAW+d9xR
JslgJyfyeZBCek+ELEvumis/smRXFiC9z7qtTz9kLrhhhRZYNC0I0jri9a+zGcZ0
XogLyXJ3
=JDt2
-----END PGP SIGNATURE-----

--YtNYCxJY4dBrdBB5--
