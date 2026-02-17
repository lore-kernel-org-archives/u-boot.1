Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC01E909B9
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 14:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28E583C72;
	Tue, 17 Feb 2026 15:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r71ZAIUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999D883C32; Tue, 17 Feb 2026 15:40:06 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B66B83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40974bf7781so3816095fac.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771339201; x=1771944001; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WdKA1vFKSp74ZHvRuqdgiKPoV8UjShj4Ow3hKFRXT1Y=;
 b=r71ZAIUFGIbmuX8I4TO/1HK0a3wblWPVCghLRi3oidTSahUlmXleBo2CvxpWwEkOJJ
 TjFhgJ+xvyCVevFTd07OHbPr4BVpF8ELARi8P+0csKadtgibwvKdmqig3HSz/tQGtHzH
 6okNNafT09FAKieqU41QVDcJ2McBMsyaq1cLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771339201; x=1771944001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdKA1vFKSp74ZHvRuqdgiKPoV8UjShj4Ow3hKFRXT1Y=;
 b=d/KJLJ9aDEr517fcytoSKDjOq5rs2Zg5FrEKGwpHml7akDROP4NtGad6x+eLMMvuas
 4Aw/efRXqRqwbJoM7vKAKiIsF93AVHoZ17e+R2gs5C5+JqhLRfkLtg/7D0LQOYnhEdw2
 JPv1GveZUN3I3e5AIuRQloiYKWwcv5NtaRz9CAwtYhZQV0aIkrSkVMqerfKvQE/LT8Zt
 34K0F29tEi8doVFxzS4ejj5WHrATyEhJ7B6MU34ydlTJ4n/ceZl0+edZ25QRberm2Cku
 FDnR4v7hQ1P01CJBzeotsRRC1juA3Itci63wA6oD+dvUOpytn60lDqgdKSawX8JwVSh9
 lF+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAGTjTJAFGjtG/V72up5WHXvULummhyTuWmphRIsHiPTYmGaILmcnt/a0VrYwhmoDqQHcj31M=@lists.denx.de
X-Gm-Message-State: AOJu0YwMbvVAqP/sk/SjRWONt8K7Pel24LGsr7mXT96ELFOuM0dYKEiw
 VwIC+g49H2g+P+vv1V583dBQSIQj3TJushCsUoJzGZELlNxw2hj5xSmk18+Anqap4nA=
X-Gm-Gg: AZuq6aLGNhtSpITatyJdIg3uodoX+WO+JHtJGYSPARIFOhskraGxq7xaJn/uVtCJ6GU
 GXBakCmEICODiIh+hr/kboI2tVMvQCMcH2TYawfHPRd7fswPsYKxzFtY2QMOzKyFt9pQTulW8K+
 lMSh38jaBi+ikGei/AA2TuXjmQxk4lrHy8tHDlAim1pXxptFPH2CRZxjjZtLz4MbgcKNp277bsl
 w4TqWR1tohsVtmjNMWuoa004RlVTlPFxTdeqznkVsbyR5JUGrI1Q/PX0wrthUE/paohK7fUMEbc
 rIP3Q86vfFYj8IOc8jRnmDTOfM4fmiUKH6ORYOz7QJxBnRKoEXFtY8+r7Z9Gtp4yLu/cVAigz+r
 GWoEudTAL0g/+zHulPYRomTGZSIOTmACY7gemGvK3xFCtoEDUH6/2I6jtYfsGcBb6qyOfHW8KH6
 Jy1vCBBJ9lbH3W8f62Zn3Kk4FfK3lhJr3gqk3i76D0xZOfdLTzYftJX/ASqqJZQ3Lq0apkHwPw0
 PrBysQm1pMY3cagmM1IFomsMaRUkedbvPDf1F7wgIWbeH3FR64=
X-Received: by 2002:a05:6870:8318:b0:3fa:aa5:be04 with SMTP id
 586e51a60fabf-40f08a58572mr7090638fac.20.1771339201106; 
 Tue, 17 Feb 2026 06:40:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaeb42708sm18415381fac.0.2026.02.17.06.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 06:40:00 -0800 (PST)
Date: Tue, 17 Feb 2026 08:39:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Simon Glass <sjg@chromium.org>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Message-ID: <20260217143957.GZ2747538@bill-the-cat>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
 <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
 <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
 <20260216152906.GU2747538@bill-the-cat>
 <aZPuDGK/uUOg11fR@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uyFOV9fZjKlzjFcz"
Content-Disposition: inline
In-Reply-To: <aZPuDGK/uUOg11fR@hu-varada-blr.qualcomm.com>
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


--uyFOV9fZjKlzjFcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 09:56:52AM +0530, Varadarajan Narayanan wrote:
> On Mon, Feb 16, 2026 at 09:29:06AM -0600, Tom Rini wrote:
> > On Mon, Feb 16, 2026 at 11:01:02AM +0530, Varadarajan Narayanan wrote:
> > > On Fri, Feb 13, 2026 at 01:20:10PM -0700, Simon Glass wrote:
> > > [ . . . ]
> > >
> > > > > > > > I haven't been following this, but what sort of args are yo=
u planning to pass?
> > > > > > >
> > > > > > > As of now, an argument to indicate reboot to emergency downlo=
ad mode.
> > > > > >
> > > > > > So how about adding a struct in sysreset.h where you can includ=
e a
> > > > > > flag word and create a single flag for your case? We should be =
able to
> > > > > > handle reset without the cmdline being enabled.
> > > > > >
> > > > > > There are other cases where this would be useful, e.g. an EFI a=
pp
> > > > > > rebooting into setup boot.
> > > > >
> > > > > Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> > > > > option. This was added to avoid bloat code size for platforms tha=
t will
> > > > > not need this. Please see [2]
> > > >
> > > > Sure, but you are adding a new method, so you could make it take a =
new
> > > > struct instead of the string list, still behind your Kconfig option.
> > >
> > > Sure.
> > >
> > > You want 'request_arg' function pointer to take a structure instead of
> > > 'char * const argv[]'. Is this understanding correct?
> > >
> > > If yes, this string list is what was given in the command line. And is
> > > passed to the implementation specific handler.
> > >
> > > 	Command line -> do_reset -> sysreset_walk_arg -> *request_arg
> > >
> > > The implementation specific handler can interpret the argv[] as
> > > applicable to itself. Not sure how to convert/parse this to a struct
> > > that can be used by EFI app. Am I missing something. Please advice.
> >
> > Varada, do you think this suggestion is taking things in a useful
> > direction? It's unclear to me at this point if what Simon suggested is
> > going to provide something meaningfully more clear / useful or not.
>=20
> At this point, for my case, it seems not needed. That is why trying to
> understand his perspective to get better clarity and arrive at a
> consensus.

OK, yes. I think we can set Simon's questions aside for now then as it
seems like he's trying to find a generic solution when we only have one
example, and that's not the right way. We need two or three "doesn't fit
the generic method" examples before we can see how to abstract things
correctly.

--=20
Tom

--uyFOV9fZjKlzjFcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZR9uQAKCRAr4qD1Cr/k
CiXHAP4m9mSqETNf/CcMB2HZenpBi6ja75TyDQLa6l73iWRiwgD+IU5U9bzye6A2
d+itB3CYDlw4DRGgzdV6dOFGwuGhhg0=
=sjo1
-----END PGP SIGNATURE-----

--uyFOV9fZjKlzjFcz--
