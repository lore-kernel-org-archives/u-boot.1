Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1A1C83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 16:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8684B857BF;
	Sun,  3 Sep 2023 18:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c10f27uQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D8D86411; Sun,  3 Sep 2023 18:42:52 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB6080B98
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 18:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5733d431209so467642eaf.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693759368; x=1694364168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=esoRcp9/FaqS87yNXfGrfBkbVJPicxdFqwRaqZU6IBA=;
 b=c10f27uQKp1EC9Wr6ZWGFzA2PS3IMKO1ieyvRlSP0AZImlWMI90SbpJXdZWhgw/PtU
 5z2E8xawukKbw8vEfHHWg6M2zkyeqfhHpyrPdZlwGZVG1J5bj/we72/SvcQbudGSjtyn
 dJARC3Oz7qSR+pIxGh3YVBKUNSATToYyk8oJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693759368; x=1694364168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esoRcp9/FaqS87yNXfGrfBkbVJPicxdFqwRaqZU6IBA=;
 b=jbJhxYIMDHl8h9DhHiyleOvKBzBWhQrrk95WIXp/7vfLnz6PfMggNv9li1E2BALdtj
 PjA+kwWJyY0yaeV0S+DtyIPr6yrZg10kpMIphOZYDl6M1mv5KKzss/uDDCNlQIqbJ6/j
 67TEbX4xIi8r5+wJVL3IHKHi2Wq2vJuvY7Dy6yWCaCK2gN8SEBXZ6PfvR9CT5hEhDY0L
 yCPYjxtykDSBEQYVxz5RT+RfsbspJY1a6IIBBkJGDnhwGqf7B88HEvqJ5vHcaNz8Cjcu
 +SuoYO5D+bXyME+wBEPY+dMWSDG4aAU4f/85FhOWBKUdmgsnyhfz4a+mLv78VVs69uui
 1xYw==
X-Gm-Message-State: AOJu0Yz6wf2AeN8GWomNxayWgbomilCVI83zVUcEf/5e/PnmZKC1gJse
 87pK/Ce71q2W14C/FvkOI+3THQ==
X-Google-Smtp-Source: AGHT+IHHJIe6azlPeN3GJOzJlVANVzrSzKtWy8tgohbr3+DByHamiiCo8XkOAV4CHZjHRs71v5xfMw==
X-Received: by 2002:a05:6358:998f:b0:139:cb15:ecd3 with SMTP id
 j15-20020a056358998f00b00139cb15ecd3mr8335030rwb.8.1693759367812; 
 Sun, 03 Sep 2023 09:42:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-e2c8-2093-3a74-c444.res6.spectrum.com.
 [2603:6081:7b00:6400:e2c8:2093:3a74:c444])
 by smtp.gmail.com with ESMTPSA id
 i63-20020a0dc642000000b0058605521e6esm2198598ywd.125.2023.09.03.09.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 09:42:46 -0700 (PDT)
Date: Sun, 3 Sep 2023 12:42:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
Message-ID: <20230903164244.GY3101304@bill-the-cat>
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X7gXUYhG0jBXpH/2"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
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


--X7gXUYhG0jBXpH/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> >
> > > When lmb runs out of space in its internal tables, it gives errors on
> > > every fs load operation. This is horribly confusing, as the poor user
> > > tries different memory regions one at a time.
> > >
> > > Use the updated API to check the error code and print a helpful messa=
ge.
> > > Also, allow the operation to proceed.
> > >
> > > Update the tests accordingly.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > > +     if (ret =3D=3D -E2BIG) {
> > > +             log_warning("Reservation tables exhausted: see CONFIG_L=
MB_USE_MAX_REGIONS\n");
> > > +             return 0;
> > > +     }
> >
> > This isn't the right option.  Everyone has CONFIG_LMB_USE_MAX_REGIONS
> > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> >
> > But it sounds like what you've found and fixed is an underlying problem
> > as to why 16 regions isn't enough in some common cases now?  So we could
>=20
> I don't think I have fixed anything. But I'll send v2 and perhaps it
> will be clearer what is going on here.
>=20
> > possibly avoid the string size growth here and have a comment that also
> > matches up with the help under LMB_MAX_REGIONS?
>=20
> I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
> about 400 bytes. There seems to be a lot of code to save not much
> memory.

What do you mean here?  The alternative is not unlimited ranges but
instead to define the limit of memory regions and limit of reserved
ranges.

--=20
Tom

--X7gXUYhG0jBXpH/2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT0t3sACgkQFHw5/5Y0
tyxToQv/c6lfJ+vzVjPAgvCDWO3wc6CpvtkFr4BkP1FZQUx28yEQFKHP8Ko5r54v
7qY5mtehoDWMg9rMq47mU2RO5/ebOQ6VRDfHQBregUbhOkg0xB3gnm2EF3sMOoBF
DrXaWRPR1jLIuZFSOwt6LgYL1ptYmdnLokh3u/WlIjGMIHUSIgfbjsnJ6wLLy9Vu
pQz9gKAaDjK2dFjhXNd1Q8iF4wfSc4F2ofi2S/U7qaS6BGNcLDijGYsAQhKAGjY8
OGYqJvJaj1QlaI49SEmSjW6uUjjnw0nwAo992Mc4xHl8mcq90jIBALvcRi1vgj5l
BzdHm8G/ByVUGvpsN8ZdTCmv30y8QAJAlJho/nfXf9MgM+itOXwYeo4bPKpsQsnF
Gv6+OJRy86wt1aYx1H0e6yvMyqsozgRjSu0KLOpKQuiCeVXHcWn6iQnf/r9+fwtf
4GPa7KgKkT7cvVg0jWy6SdN2u/m8KpQHN93KbS1F00XDHNWD3W5LjEC/P6+/y+xn
0Dle8+79
=ZOcH
-----END PGP SIGNATURE-----

--X7gXUYhG0jBXpH/2--
