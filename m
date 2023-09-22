Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D387CCD4844
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 16:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288F58646A;
	Fri, 22 Sep 2023 18:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W/LJ8OOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D90584003; Fri, 22 Sep 2023 18:13:17 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF24586538
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 18:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59b5484fbe6so28635107b3.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695399193; x=1696003993; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=deV4Jc0ATLbvQTFb/oGJ3URSPKbrNWD/TY0r6kVgwIw=;
 b=W/LJ8OOwqyRCt810W9qfCdAEBJh9CY5eYtF/Nk1ba6aJPo8PP9dj8hp3YWy/pMANMD
 ydOavFnWhCMMufrvYlf0OXznsYoxm6Qdh8tGkf2feWMS99XXlUqed4e3l3Llj8L3IyA5
 6q7yBgreirTnb830C851XprR3DSfpMfNdlNhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695399193; x=1696003993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deV4Jc0ATLbvQTFb/oGJ3URSPKbrNWD/TY0r6kVgwIw=;
 b=j7W8P8ygveKyTj/iydLKVaAu5VL+r7TyKz/YouToXZo+lTP0npMPbs0phx/ONMCIFt
 dwxcDRarvgyNHkVSR6q9oZQeODDj99Px1W+ESNOH5tWZCdO8tNC8TH3ek4q1JiCAkTqA
 cuQkiIfc3f1Q/v9HEZLbH5edEwk+rXAnWsGxYITSOYyGzrpw46XrOg5QB+2retpDkuN5
 ibIFg4UkcoGdnOGkxFBRKmFi1EKfLzbl0qP3ivPI+z8QN/lBEMwl+xuADmRZUL7ncd7h
 yZDkzhibNpAAbiRVWEsVr+PoldJHs8fFitVdlLHMTM0PEsZbL7uuToJ7AghUrDB/L6so
 b9lA==
X-Gm-Message-State: AOJu0YzNpUQCO6Ui+0emNbUYtjHegdtz5to7CSro92zgk5m+5pHtRlMm
 Zic25YdCq+9XuRqLjqPnoQdNeg==
X-Google-Smtp-Source: AGHT+IGVgRVEPIY+GH6wZICOtt89shhkF9Y3cEuGxUZa/R4sZUv8ggD/O01d5atiBhi2ZnCsSiZ4fw==
X-Received: by 2002:a81:8ac6:0:b0:599:da80:e1e4 with SMTP id
 a189-20020a818ac6000000b00599da80e1e4mr186629ywg.30.1695399189027; 
 Fri, 22 Sep 2023 09:13:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b22c-a20b-ddfe-6409.res6.spectrum.com.
 [2603:6081:7b00:6400:b22c:a20b:ddfe:6409])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a0df643000000b0059bdac3fd08sm966737ywf.48.2023.09.22.09.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 09:13:08 -0700 (PDT)
Date: Fri, 22 Sep 2023 12:13:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Goldschmidt <goldsimon@gmx.de>
Cc: Simon Glass <sjg@google.com>, Maxim Uvarov <maxim.uvarov@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
Message-ID: <20230922161306.GB305624@bill-the-cat>
References: <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
 <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
 <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
 <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
 <CALeDE9MBUd2_8TZ87PJXx_jF0D6zqGV9FY2vQCSkxG4P2GJ-JQ@mail.gmail.com>
 <20230913131423.GI305624@bill-the-cat>
 <CAD8XO3aq9+KDOUXKtURaL8UwX96RLqqwAhDz=U2924BfUdz9+g@mail.gmail.com>
 <CAPnjgZ0frgZ=i7ED71ifpvWAtv0PG9DbwbKQ3Hzf6PHkfgnraQ@mail.gmail.com>
 <0b714a3e-b46d-b954-e99f-a372d7124780@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wBAHwtNQePxseusr"
Content-Disposition: inline
In-Reply-To: <0b714a3e-b46d-b954-e99f-a372d7124780@gmx.de>
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


--wBAHwtNQePxseusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 12:56:58PM +0200, Simon Goldschmidt wrote:
>=20
>=20
> On 21.09.2023 18:29, Simon Glass wrote:
> > Hi,
> >=20
> > On Wed, 13 Sept 2023 at 07:35, Maxim Uvarov <maxim.uvarov@linaro.org> w=
rote:
> > >=20
> > >=20
> > >=20
> > > On Wed, 13 Sept 2023 at 19:14, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Wed, Sep 13, 2023 at 11:06:13AM +0100, Peter Robinson wrote:
> > > > > > > > Then if for development you need  to pull he history of lwi=
p, you can do it with:
> > > > > > > > git pull -s subtree lwip  master --allow-unrelated-histories
> > > > > > > > (but I think nobody will need this.)
> > > > > > > >=20
> > > > > > > > New update of the lwip net/lwip/lwip-external dir will be d=
one with:
> > > > > > > > git pull -s subtree lwip  master --allow-unrelated-historie=
s --squash
> > > > > > > > Squash commit also has to be git format-patch friendly.
> > > > > > > >=20
> > > > > > > > If you are ok with that proposal I will send v9 with the fi=
rst patch created with steps above.
> > > > > > >=20
> > > > > > > We've gone through this before.  The whole purpose of this is=
 not
> > > > > > > having to maintain patches.
> > > > > > > Simon, instead of "I had problems in the past", can you elabo=
rate a bit more?
> > > > > > >=20
> > > > > > > Tom said he is fine with subtrees instead of submodules and I=
 know for
> > > > > > > a fact EDK2 doesn't have too many issues with submodules.
> > > > > > > Their documentation is pretty clear on building and requires
> > > > > > >=20
> > > > > > > git clone https://github.com/tianocore/edk2.git
> > > > > > > cd edk2
> > > > > > > git submodule update --init
> > > > > > >=20
> > > > > > > Perhaps the situation has improved since you had issues?
> >=20
> > Nope.
> >=20
> > > > > >=20
> > > > > > While I don't really care how you solve this technically, I'd *=
strongly*
> > > > > > be interested for U-Boot to use *unmodified* lwIP sources where=
 an
> > > > > > explicit reference to an lwIP commit is used. I'd rather integr=
ate
> > > > > > bugfixes for U-Boot into lwIP than having the sources drift apa=
rt.
> > > > >=20
> > > > > Strongly agree here, we want to use upstream and all the combined
> > > > > development and reviews etc rather than forking off and ending up=
 with
> > > > > yet another slightly different IP stack. The whole advantage of
> > > > > adopting LWIP is the advantage of combined security, features and=
 bugs
> > > > > from a wide range of projects :-)
> > > >=20
> > > > Yes, this is what I want as well, and why I'm perhaps more agreeable
> > > > with the approaches where it's a lot harder for us to start forking
> > > > things unintentionally.  I gather submodule rather than subtree wou=
ld be
> > > > better for that case?
> > > >=20
> > > > --
> > > > Tom
> > >=20
> > >=20
> > > Yes, submodule will be a much better solution for us. And I also don'=
t think that today
> > > there are any issues with submodules. It works well of OE, RPM and DE=
B builds,
> > > distributions should not have problems with it.
> >=20
> > My particular experience is with coreboot. Some problems I have:
> >=20
> > 1. Updating the modules doesn't work and I need to reset, try the
> > --init thing, fetch things manually, etc. etc.
> > 2. In ChromiumOS coreboot we can't use submodules internally since
> > each package has its own build script. E.g. we need to build coreboot
> > separately from its blobs, fsp, external libraries, etc. At least
> > there we can do this, but if U-Boot adopts a submodule for a core
> > feature, this is going to create no end of problems.
> > 3. It makes it impossible to patch lwip for any fix we need for a relea=
se
> > 4. We still have to 'fast forward' to a new commit every now and then,
> > which really is no easier than doing a merge commit for the changes
> > since the last sync, is it?
> >=20
> > Really, we need a maintainer for the lwip piece, if we are to adopt
> > it. Using submodules is not a substitute for that.
>=20
> As an lwIP maintainer, I cannot step up as a maintainer of lwIP in
> U-Boot, however, I can assure you I will do my best to work with you on
> integrating fixes into upstream lwIP if required.
>=20
> Without wanting to promote using submodules: all other examples of lwIP
> being copied into another repository have practically never resulted in
> bugfixes being sent back to us (ok, that's not 100% true, but we do get
> them only once in a while) and being like that, those projects are
> facing problems upgrading our stack in turn. I wouldn't want to be a
> maintainer of such code, either.

So, ideally once we've integrated lwip, I'd be having us track the
stable tags, rather than top of tree. Is this what you'd recommend,
first of all?  And second, assuming we can take STABLE_2_2_0 once it's
released how often do you envision updates?  I ask since maybe things do
move slow enough that if I make some of my local every-time test scripts
stop and confirm it's OK to have some changes to net/ (or where ever...)
I can make sure we don't diverge and then like the calendar entries I do
have to remind me to check with a resync to X I could do that for lwip.

--=20
Tom

--wBAHwtNQePxseusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUNvQ4ACgkQFHw5/5Y0
tyxOyAwAupDma8LtG2FRyHGrfPrU/iCq9cSgH0eu0XDmwP3WRVsIAES4bNIvfX9u
iKevzfMiTzg27ZM2WyJmV+3+i//pqbFSkl5+IrDpjnBROUSMSdmeCsBLzpafZUv7
u93WPxqaHjCMyCqW+qEWTT4mIwG7Tmm6aevt75sJ+QUouTnit6fUMqdafkv69Xmy
WcmhdGE/SHmN9KQ3QXXTx8BWWUQoaKxQ5xBzc8IY1MT6otrli0AHusXW6QmOU7fZ
9SUe0E/rZY5ny4cGEWTSR9uUbaRc12PgH/2J1Gr+nrddprmoLNoQWFLqCKjPpnrO
iDbBd2zP1kqz4uAVrZDUgwusXSTtlRzNBWAfz99a1ajLlqZGz2qKq5t14WtjcU04
H7//2bJ6gR4pALoGpZz96nefM1jU/rL5Gdx2W0cF/vZtq8LMgwh3/5/zYIIqMET7
02NLOjRr9HhItFNvpFYllC/6+alBFhHJ8YzXYiLBy/2yX2qhzfuKozE6K2tXyl1Y
E/Bp5m0h
=IRSk
-----END PGP SIGNATURE-----

--wBAHwtNQePxseusr--
