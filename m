Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366E4C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC10A820E8;
	Mon,  5 May 2025 18:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JxHQPOvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971F2820EB; Mon,  5 May 2025 18:23:05 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFE7820E1
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so1113619a34.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746462182; x=1747066982; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jsZ1M/BIwn4wVwL6d6rPowZ7mJevO/bzyMbYGTu9TNE=;
 b=JxHQPOvxvUMOrfn+5YfKjCPH3DkyY7dv0+w3AeHNhaiTr49GEA4q+df/e3wXNt1105
 ZKbpC8gIOpp/atCKf4weXbOWQFTe/2btFDxjIYHjJq4v2MotV2QD6HJBOnVNfwcMEbH7
 kmc216A2CkQfJZrhJymfm1edvY1SUEa1PaDjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746462182; x=1747066982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsZ1M/BIwn4wVwL6d6rPowZ7mJevO/bzyMbYGTu9TNE=;
 b=E8tZv66cTMXgjiwv58TBAHwaNMzRok4IdSkUkVuX+iEBbbxofdZ9EsL0ag5vmoQG6X
 besaNNYZ4BRXeK3D6IiKzxx1mFJ19SyxkHL5lCzoS+MP/SVYU0XRBacSePdHxaCnabfZ
 jk6wqTzwSX7zh7ODxJeDDeXWD/PJ7dkT4qUD9dYHrh/OYeDJE5MJTJCRlQEC4EbmOM2W
 kBmK4EYTwSc+1g+ay4vp9+lMKYNX1kRxiqwWMim7ER9Dz3ywGxu4f/2/U4rFJZV9tOzK
 8GAoxjrowYZrnsuugF7FpWwqo57y65n2fFfqHir/0sTpc51cbbDzhjhwwbqm/PszaUhp
 qBWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbaYFx9m17Q6hQ1cBj7/1Agg7LKRou4m6LRVdtJj9V4L930Th87oc0jUlF7jCCaOBC3riI9pA=@lists.denx.de
X-Gm-Message-State: AOJu0YwqHGkYT+QsvwOqW9Zi+ryZCy6fP37fU0ZeBpH5zRCWK9SXU2XT
 MTCKqylamS0wSodDfd15Uru1ld9k0M2+sOied5Rqn+13/E5heAvJn9n0VqGYuws=
X-Gm-Gg: ASbGncuMKBiA2z4f9uPGm7z2Tg/vp/JEwfuK6mmU4TyjLWV138N806RJYdRkYRPGOC+
 Qh6b/e5P4VLYSFGVsNH0sqTSgjx5PBNi7+iXB4rHSb0p7Rztd2BJjxE0+215IxL3HQvuG979Q7w
 n/1yUwuuPyKWS3v7OCcw8siilPgeH7IBvrtWIsq0EUsvkIA6ZqIvnMTrWqUGIkLX+oShoe5JbPD
 h+01G0Pl3PnDdK0vhT+8xOtlbCZpaAcaQ8YjCoiuJxaLFk7pQKUAqZHbobBTkShDQjnlGA2lrgs
 nUBi389YiMwVirxyoSTKQIlG1LfM4RZCzUZnIqLoIdnTfiG8s4cjYBQGibTtcXyC7vdi8PqmRte
 EDg==
X-Google-Smtp-Source: AGHT+IHy5olvSBjj8+si8+FX5rWtOzVpfUezW6zz/rv8rgwALtbUJq3qW/O/aU2f8k0HTYSxJW8mPQ==
X-Received: by 2002:a05:6870:961a:b0:2d5:4d2d:9515 with SMTP id
 586e51a60fabf-2dae835f64bmr3975648fac.17.1746462181861; 
 Mon, 05 May 2025 09:23:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0ee1978sm2070185fac.15.2025.05.05.09.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 09:23:01 -0700 (PDT)
Date: Mon, 5 May 2025 10:22:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250505162259.GE5430@bill-the-cat>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <0e3e24ac-a4a2-4b44-8c13-d47a655ce7ee@linaro.org>
 <CAFLszThha_WkVyCVxwm1dqvbFaiyxw+khuuyfZKgnoVkHJk-eA@mail.gmail.com>
 <20250505134542.GH1261075@bill-the-cat>
 <CAFLszTjeyMUE4aLnzUdRwWPgUVnPtNj+F1FBsYJuO2CqOTe_EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mLprxouoIbVYIf/I"
Content-Disposition: inline
In-Reply-To: <CAFLszTjeyMUE4aLnzUdRwWPgUVnPtNj+F1FBsYJuO2CqOTe_EA@mail.gmail.com>
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


--mLprxouoIbVYIf/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 05:34:58PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, May 5, 2025, 15:45 Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, May 05, 2025 at 02:58:06PM +0200, Simon Glass wrote:
> > > Hi Neil,
> > >
> > > On Mon, 5 May 2025 at 09:06, <neil.armstrong@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 02/05/2025 04:50, Simon Glass wrote:
> > > > > During a recent discussion with Heinrich we discussed why the hoo=
ks are
> > > > > kept in a separate repo.
> > > > >
> > > > > The amount of code is small, a tenth of the size of the recently =
added
> > > > > lwip, just by way of example. Testing is a critical part of U-Boo=
t and
> > > > > one of the things that distinguishes it from firmware projects th=
at have
> > > > > not kept up in this area. By having the tests somewhere else, we =
are
> > > > > signalling that it is unusual, or difficult, or optional.
> > > > >
> > > > > The hooks mechanism also needs something of an update to take acc=
ount of
> > > > > real boards in 2025. That will be much easier to undertake if the=
 code
> > > > > that test/py talks to is in the same repo.
> > > > >
> > > > > This series brings the hook files in as first-class citizens of U=
-Boot.
> > > >
> > > > So this will definitely remove the ability to have test hooks out o=
f the
> > > > U-boot tree ?
> > >
> > > No, not at all. I think Tom had the same thought, but I'm not sure wh=
ere it
> > > is coming from. You can of course put the hooks wherever you like, si=
nce
> > > you have to specify the path for them anyway.
> > >
> > > >This is a major regression, and I do not want my test hooks
> > > > to be in the main u-boot tree for plenty of reasons, the main reaso=
ns is
> > > > that I need flexibility to handle my lab boards and I can't wait mu=
ltiple
> > > > weeks to have the hooks fixed in the main tree.
> > > >
> > > > This could be enhanced, but I agree with Tom, it's a bad idea to me=
rge
> > > > them in the main tree.
> > >
> > > Are there any other reasons, beside the misunderstanding here?
> >
> > I don't think there's a misunderstanding here. If I follow what you're
> > saying, you want the hooks to primarily exist in the main source tree.
> > Yes, of course someone could maintain them out of tree instead. But
> > that's adding pain to that set of users.
>=20
> People maintain them out-of-tree today. They can simply keep doing so.
> I am not sure what you are getting at here.

Yes. People use the tree, today. Likely pulling in changes and merging
them to their local branch as needed. That's no longer possible if the
repository goes away and instead is in the main U-Boot tree. Or were you
thinking it would be maintained as a mirror of what goes in mainline?

> > And I'm not sure what the
> > benefit is to anyone else to move them in-tree. We're making the project
> > CI path a tiny bit easier (but for what is also a small case) at the
> > expense of all of the other cases.
>=20
> Did you see Heinrich's email?

Yes, and I replied.

> > If we must save two steps in the case of testing new changes for CI, we
> > could add the u-boot-test-hooks repository as another git subtree. This
> > would make it easy to test new CI changes at the expense of making it
> > more costly (a git subtree resync) when we want to update the hooks
> > repository.
>=20
> I don't see how a subtree would help though. It's not as if some other
> project is using it, upstream of U-Boot.

It would solve the problem of "need to test changes in CI easier"
without breaking the regular use case of "separate lab infrastructure
=66rom the project". Perhaps the problem really is that configuring the
hooks also looks for data that's in the hooks repository.

But all of that said, this still feels like a step backwards. You don't
put more projects in a single repository, maintaining and using multiple
repositories is easy now, we aren't stuck in RCCS / CVS land anymore.
Heck, the reason I point out subtree is that is how you manage these
kind of problems. Even more so for parts of the code where it's easier
to say that yes, multiple people can have write access.

--=20
Tom

--mLprxouoIbVYIf/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgY5dgACgkQFHw5/5Y0
tywNrAv/XIgJk4+D9sqYYCIIzgGIEGP+8XQYzYMh35OAqCHulqPJ26f1l+q6d9QR
HXk4EA+M1qPIOHwPUe/1J1wPz6RpdjnISVHpWjeapgOzq6TsChNRXSd4J5TCkrYu
NgfpbbvdCYpOcW+r8JlJybUWRY3b1CiuRlRCnljreNTBKjNJZWtCfC+DR9t1eIL+
v/xsg4lHiyMBcgQ/bqD2s9QG5b7+2GygSPtMu4jwGlbWY2MRmZVCfWDMoqstLCLg
AwAFAB3fH7ee5iUUFe/mZflNXeyJEvFEHCublgbvVkXH1ejw2ZjG61VD2u49CG3K
K3ALllZFkANoEqdh4hxqmKw7Ke3R4NVYXnX9CFmFh2T5tLb3KPfaV4uo6NVwuuvH
LlFiev6mZB5Y7xLnQqSWvRTqECEt+RWQFYTRxA7Z/OnGwEHa1oAX0sqXM0JPyQts
KykCWqAC+35gx3CrPHxYBRZDG9UVWKmRYF/Bddehe5a0wwMpU8s5fsKD9EhvHgQJ
glZ66A31
=yR3w
-----END PGP SIGNATURE-----

--mLprxouoIbVYIf/I--
