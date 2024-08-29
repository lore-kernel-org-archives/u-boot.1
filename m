Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A3CC83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E28688C37;
	Thu, 29 Aug 2024 17:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q6dm9uuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B3988C40; Thu, 29 Aug 2024 17:20:59 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BA188C35
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-45683037787so4742601cf.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724944856; x=1725549656; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jTkKw/NKgxGn3ltN5o1P1pxhShhvjbw3vnvAWG1LH3Y=;
 b=q6dm9uuXNWP4PGVO1kaN+XCZzL0uRrN+h++NBQOvIALGdDK7GdzeKd+058XFXkHona
 Lu+if5kYyj+gAN+4jgKkd1m8u7FuoTJSF2lEYHwoKUtd8AD4dG43ztj31EZQzrakwznj
 CybTPeMlQ2HTHy5lvQ6feQM0HBmRErnAFDbFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724944856; x=1725549656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTkKw/NKgxGn3ltN5o1P1pxhShhvjbw3vnvAWG1LH3Y=;
 b=npTK0169vxzaV3g+BYzvGzvPX4AMc86XHtwYX+C0IaAUH/TwVXbsLba/SKCkShA2JY
 xABXuVAIPD5IN+Kl7IB4aoV5jyKxb4psDBR8kRRk/romrQhqGbfyP1SE0jZdn14ZZdfP
 aZhuPGBNvKbSiN0AXPhcNbcA51qiVy4TErisJUGH/EnVw4RuKjeDvgu5Aq1W9xD4Otyo
 jBRV3ss6SZaUjwOZuzoY1qpCb8ENh7AC/cR84HAPm9wYRMjvj2q8a7njrd2hm6DCzL+D
 jjjJWbZJRqI3v11OuFOHhWJT/pF7u8HCWyXsjLK/QBCGGzY6KTS3l38yEoPaHa5gyapO
 jRwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO/qpfTxW4OxDkwNYHoyWowGYFBhUpmEfoy3rsxhOHLLFyB09BSEyCN3Pl6foZeHhuE0epHVs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxq4Df9OjOzMTKjtY5m4Eh6NJaibnAKsLNxbCvm4w5EZyMTvL47
 XwuP3e1V+/P1wLJQh0iTDz8ZhWgFuFuqjghKRWsCTFGFIVVvseCmGvERm4NWC/w=
X-Google-Smtp-Source: AGHT+IHxfypQZNZdDw7wEtNbp4p7ZI5lJRO56AoEFdiY+HvT8hmvKzne3JgWgX96pXU3ALfMYMvZqA==
X-Received: by 2002:a05:622a:544e:b0:456:61f0:810d with SMTP id
 d75a77b69052e-4567f4f7e00mr34885241cf.10.1724944856331; 
 Thu, 29 Aug 2024 08:20:56 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806c4cbecsm60163585a.66.2024.08.29.08.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 08:20:55 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:20:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Message-ID: <20240829152052.GE2479150@bill-the-cat>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
 <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
 <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c/mWQP+P3je3kjMY"
Content-Disposition: inline
In-Reply-To: <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
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


--c/mWQP+P3je3kjMY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 09:02:38AM -0600, Simon Glass wrote:
> Hi Neil,
>=20
> On Thu, 29 Aug 2024 at 08:44, <neil.armstrong@linaro.org> wrote:
> >
> > On 29/08/2024 14:17, Simon Glass wrote:
> > > Hi Peter,
> > >
> > > On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.com> w=
rote:
> > >>
> > >> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
> > >>>
> > >>> Hi Peter,
> > >>>
> > >>> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com>=
 wrote:
> > >>>>
> > >>>> Hi Simon,
> > >>>>
> > >>>>> With Labgrid we don't need to specify the various methods, except=
 for
> > >>>>> the console, which simply calls labgrid-client.
> > >>>>>
> > >>>>> This allows supporting any boards in your lab, without adding per=
-board
> > >>>>> configuration to these hooks.
> > >>>>>
> > >>>>> Provide ellesmere files as an example.
> > >>>>
> > >>>> What's ellesmere?
> > >>>
> > >>> It is a lake but also the name of a computer.
> > >>>
> > >>>>
> > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >>>>> ---
> > >>>>>
> > >>>>> Changes in v4:
> > >>>>> - Support pytest fully with dual-build boards like Beagleplay
> > >>>>>
> > >>>>> Changes in v3:
> > >>>>> - Update scripts for latest version of Labgrid integration
> > >>>>> - Add poweroff.none and poweron.none
> > >>>>> - Provide -n flag when querying board info
> > >>>>> - Target the grpc version of Labgrid which is now in -master
> > >>>>> - Update README to cover the changes
> > >>>>>
> > >>>>> Changes in v2:
> > >>>>> - Make use of the common script (only) to set bin_dir
> > >>>>>
> > >>>>>   README.md                    | 50 +++++++++++++++++++++++++++++=
+++++++
> > >>>>
> > >>>> Maybe that should be in a separate labsgrid readme?
> > >>>
> > >>> My hope is that Labgrid becomes the normal way of running these tes=
ts,
> > >>
> > >> Generally I agree with automated testing platforms, I think <insert
> > >> you're preferred platform here> makes sense, there's a bunch like
> > >> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
> > >> bunch more that I'm aware of.
> > >
> > > I am somewhat familiar with LAVA and I believe it can be used to test
> > > U-Boot, although I need to learn how. Looking at a test run [2] for
> > > beaglebone black I see that it is using a recent kernel but the U-Boot
> > > seems to be older.
> > >
> > >>
> > >> Does it make sense, of course at some point in the future post this
> > >> being merged, make sense to look at a general way of making it easier
> > >> to plugin these sort of HW test platforms using this as a basis? I a=
sk
> > >> mostly because putting a bunch of my devices into some sort of
> > >> platform can auto test things and of course everyone has an opinion =
to
> > >> which is the best one :-P
> > >
> > > Yes. I had heard from Tom that Labgrid is the new hotness for now.
> > > Having dug into it I believe it is a good solution, although it can
> > > certainly be improved to handle scale better.
> > >
> > > Anyway, IMO the current test hooks are not a great solution, just
> > > because the configuration is spread all over the place and it relies
> > > on lots of little shell scripts. So I believe that the Labgrid
> > > integration is a closer to where we want to be with others that come
> > > along.
> >
> > I'd say all those scripts are actually here to ease integration with any
> > system, booting U-Boot and Linux are two different beasts.
>=20
> That's fine, go ahead and use the scripts. My point is that Labgrid
> doesn't need them and in fact it makes everything pretty painful if we
> try to use all of them.

I guess I really need to clean-up and post my former co-workers scripts
as I strongly disagree with that statement. The only "painful" part is
the shared pain, regardless of framework, for "put blob $X at location
$Y", which I believe you abstract out in to python?

--=20
Tom

--c/mWQP+P3je3kjMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQkdQACgkQFHw5/5Y0
tyxBwQv/TjZm0ZxoHTHXM1NSfhaz3A9piomdo+YKc3yXc7QQpgb3CGYGIIfiOhY5
CQZNTGlZK0gMkNh42rUK/IvmlvswM2KtYf7ktdE6neaPztmZU1/sO0+AnbQhQF22
KOjC1XAwqmWgRAvwkXy2tqVncA6aQhRhBMtpVwOrDQd+eczIOZOehd1MrR4NPIfg
QXSgjMtusx6QgUl5a8qvr+aui7/EeYlH/W+RoPIkliH3fqLHmGUAtm840wRszgpZ
nhqKWgUoM/5Lxg3nIsdaLMcXwXwfyWPQcfTwH+ZKSJyxUQhITkrN92xmjdfdL6Q/
7/5SCRTOnMy7jmibDOlwecm89anqFeoi6G3o5GoWsetiI1cw21t5P7sMJsh57hlm
uq0OcX24Jto4EFMNxqVEDN74avA1u5hMZjN5694GEUOSm3V3314syf8CLnZwUANd
leA5VrUkQD0TRb7XL7RkBdZmkB3iJyUc8Mgrt6p3J2yVJQRlqJvPs0tP5aruwMSr
+TazVwEY
=mD7i
-----END PGP SIGNATURE-----

--c/mWQP+P3je3kjMY--
