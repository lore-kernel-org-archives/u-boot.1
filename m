Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B73C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9BF81E60;
	Sun, 30 Mar 2025 16:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VuB5PxoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EEB81DE3; Sun, 30 Mar 2025 16:45:42 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE59380050
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3feaedb4085so2075851b6e.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743345938; x=1743950738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v6Qolmf8clTdwlb7E/Jmn+KSgPozRsganKlz/A/elzU=;
 b=VuB5PxoT7YGxScxINMKa4qt+oWScXyGYEq1DSyc5Fk/dc+bS6sTSrZQFLNpToq8jVF
 81tZ7a6pKcjfOvU3C29N2tX3EMaVEsXCcmP3yQl3PqkGUoiRpBgOJpl2AyiJ2fAAyjRJ
 pOo7qqd4IewoY4TYwe/WmmTa/hcDNjmNrDEwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743345938; x=1743950738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6Qolmf8clTdwlb7E/Jmn+KSgPozRsganKlz/A/elzU=;
 b=SO7sOZiWPcLHp1HdzKcw16JjCwRgpj0Q9OjeQi1XgOE+D8UI7/J0dGKE3eXC1TY+8n
 frFxRsGbQvV+eBa7kUe9OsTEbSmmtpNXXZR7gRpYiOXZ7XTb5F7A/9pIxLkmrFN8hcii
 G6AYcjjQDnKSZanGVdw70MrQxiExzYFV1fJ1h76iuVMFnhuiDqMMvfu77d9fl6EIdcxV
 zsOAm42DQVHZ5YiAtrivM8QOXaR86QRJCypX02XHIVF4gVgSU2bUuM/AsdUpeTR4UzLg
 EgTfehqCEvAho3IiHhW/Bvkkw4KC+bQrtpw2pMX8zJDSYpLLjIvBj1R7Y//2MEH62+Cp
 qFJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtvtzrs8/sBHm4AKZx58gd+7kPi5kq9JGs9uksTEXcoJ3u/UikbJClyUeyy9mwmc8Ou43EkAI=@lists.denx.de
X-Gm-Message-State: AOJu0YzOUhxJZQGPtTz8Y0X5VpBd2kS/utpeD/3pgBiQF9P+QT0IvOmW
 VdaRnlHyzn4mX9286lOxUinj4obTH1w2fBC/ceexrQC/5CrInJMH2tQlKCAoOa8=
X-Gm-Gg: ASbGncvwmT/0cpDZtMhbjnkRwNq/lgvmHm0Cho0aeIBqgtiyVBivCnjX8EqQsu0qLUa
 1BmaSS6d+jqhp6tSah60HoOCPPtYNrOZGvQEaunyLqW5H+4gW7YxZ5kIs21OM3FP4XFUsbJpUOr
 siXlQyw+9yn4KsSpnxwLvmp857br+DvlLa9yHeSqn1vWpjkcmzzMxgFuaiqPaDYMmS7fwQp3j/T
 H4Qi7J5ZrUbUioRoMmmHZejfuc7s7g+0rKFbbtlS4zBPzKgxdeLjZ+rwVX73xyFh9vZ04xqPovp
 MMb4zrdpdyKtoIipcCWjxd5CegzDL7kqTm/JRml19xt/cBQhXZLERvfj+E+46ID7IUo1xEAvYch
 cAoKp5w==
X-Google-Smtp-Source: AGHT+IEHPfLBJqEaB3VjKpHzkSthadMYUVl84vHed5i4PzL+bfKKmZS2/SpnUhWVZnaKu4w88laypg==
X-Received: by 2002:a05:6808:4493:b0:3f7:e860:b5f3 with SMTP id
 5614622812f47-3ff0f575200mr4733854b6e.22.1743345938441; 
 Sun, 30 Mar 2025 07:45:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05279bb3sm1163708b6e.31.2025.03.30.07.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:45:37 -0700 (PDT)
Date: Sun, 30 Mar 2025 08:45:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
Message-ID: <20250330144535.GP93000@bill-the-cat>
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-7-sjg@chromium.org>
 <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
 <20250319142038.GE2640854@bill-the-cat>
 <CAFLszTg17Q+ovvc2MeHLadsSdK+LJuHsXhf=fFybkbf=zLy36A@mail.gmail.com>
 <20250319153621.GK2640854@bill-the-cat>
 <CAFLszTgTC5bG=tLeHQ8CYCymLND4bykiWQCgBhszcUORhT5LGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YK6A3PhyzumKHmpJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTgTC5bG=tLeHQ8CYCymLND4bykiWQCgBhszcUORhT5LGw@mail.gmail.com>
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


--YK6A3PhyzumKHmpJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 03:43:17AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 16:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:04:00PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 19 Mar 2025 at 15:20, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 01:12:30PM +0100, Heinrich Schuchardt wrote:
> > > > > Am 19. M=E4rz 2025 12:59:08 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
> > > > > >In some cases we want to show a signed value to the user without=
 needing
> > > > > >to use the full printf() implementation. Add a new version of the
> > > > > >simple_itoa() function to handle this.
> > > > >
> > > > > Where will this be used?
> > > > > Why can't printf be used?
> > > > > Why would this fit into this series which is about test improveme=
nts and not about functional changes?
> > > >
> > > > It would be more fair to say that only one patch in this series is =
about
> > > > testing and 5 are adding otherwise unused changes to functions that
> > > > presumably are used in some later as yet to be posted series.
> > >
> > > Sure, would you like me to change the cover letter?
> >
> > No, I'd like to see the test by itself and defer the unused additions
> > until there's something to review it alongside of.
>=20
> So you don't want simple_itoa_signed() or abuf_printf() until you see
> the series which uses it? I'm struggling to square that with your
> request to break things up into smaller chunks, though.

I'm sorry you find this normal requirement difficult.

--=20
Tom

--YK6A3PhyzumKHmpJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfpWQ8ACgkQFHw5/5Y0
tywslwv/WpzELe4hFrfJunuhT51os/WLkQ2VE8nfW+ZStcoajcGa4n4/6yBHiyn1
LTwaAZvX2+6Wb9qVdhNVCLHRiJIS62Es2smoGufQyFqGExuucZeux6CAfM+/OSsc
bXNqeaOy1JAgO3n1QoUaUx+0gzqusXpXd3rFPCy/gynudasEBPbiz5jfnHCk0Y42
/3iyZQ9OfHe6vZig5mVSxjbOYekaJHkKzEkC7tPaultrMBSHzaHyP3Z3EkIc16Mx
qzhPGYOGhWjP5VqWUCx5YqH/PibBgAJWiQ/b1r6ckEB/4P6Y4L6e7n2Or/rx3ljI
7w1f5yof5iX5OUUJZFfefvhKzbI2HtvC9KVJ9HgsIuJ59RinHjjWlOULNVvNadI6
DhEp/o9mSzUzNeSm5Kg5w1UyCZXN6S2V1rj45raAAGIQCXM5EvnZkGegoumw2/ph
NMnv/gC7fqTN6RGxtqdi7MDs0Y+F0pAFMkVRhcORRd1tNu+v8vuzFXc/yKFqYwPa
WEFLOJS3
=6L52
-----END PGP SIGNATURE-----

--YK6A3PhyzumKHmpJ--
