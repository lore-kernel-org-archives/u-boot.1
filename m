Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8B5E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2575F8964E;
	Wed,  4 Dec 2024 17:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BP82nFWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80669896BA; Wed,  4 Dec 2024 17:27:14 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B91789433
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 17:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-466847440a6so44070201cf.2
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733329631; x=1733934431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VfNQGD+Uad2LzgWDsGZokU42q5Vm3QMWSo28mZV5dgM=;
 b=BP82nFWHvgCU10UJEO/vnJyDeDY+FgDtVtGldOVNnf5IiB8CygMf7lTj13TDvxYPVD
 tg2ZQXTp7mp4T7GJaX8pc9YBxWjUkwrKxXbQ/U6w+YWjQIxlVVkfRmoXucAf4qYPA1+i
 JbGkxONiLl9k6bvIFBgfQT/wW0ERqvhocwANw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733329631; x=1733934431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfNQGD+Uad2LzgWDsGZokU42q5Vm3QMWSo28mZV5dgM=;
 b=Dhg4lrhaOaYsrS79qJwJ628FBf5kL1BykYCekWpnKNKguOQa0E5HAUQg6GVBUHp4Jv
 3mqjGRvamrlUJbIhLqZznwo2vpI08yCFqX7Xf9kmT3LNn1CHtKeU3v7IawQNtME1N3Ct
 +QWTiSaEo4oOuu2qYrSTHYS6LERHb2QmAvt1EKSctCwyxuhHm/d/+c+92eOyLaKkDy7m
 u1yeCBPAXfiWEFlBc+gA0DiVP5pO1RgLmKyUHQTzW8zsrPWjbDVEWahqZT7j7Q0u4sH4
 u6PS+PqPMdTwuWCz5WBg4XRFPH+6QKN/ZtXUjYQB1GaWQ63O6/6drMiMOKcqeGGEZCIq
 pzJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWltcHQS3Wz7EHDBzD2XFvldzDnuo9h1lgm3bhCWJT8fpzHUmGEoaGWX2F1kp2bBpt87I18l8=@lists.denx.de
X-Gm-Message-State: AOJu0YxepbSWxicKKAIAIKJKOMf77TWlbfQZoLz9PX9dVqrgy1/gxgF2
 Ev/Ie+J6Q/Dtn/8EaKcKYnxNWjwZtN4UcH142EejFhuBDYmGdvShAYCo0mxzqi+ydN8XvWVjkiG
 vOIw=
X-Gm-Gg: ASbGnct4tNKTSQK39UGaKLLcs5CmsyKkRorVNAMiAo0pfpj+qgrqpZGRAj2tcq4TaaJ
 p9QZ1eRjsEJwNaTlqhjPEjSbZ+PFZSMbqDsjmsgbr0PsY3IyVSiCchJJl8W1C5zZCopmegfFS0E
 6fpASb1Wh/O5KV2Uo759ZMdt2j7P5eH1SxmyeSSe+PIm5k6PnkhuTZMRO18Po7OC1MAjSqMOTTD
 IMx6w26ktm2hEGKFpP5RX39o8hhcirxlgL1q7gRiXzc2y4dpg==
X-Google-Smtp-Source: AGHT+IFTKMrrzqdEiqvBHlGkSnEPSoDhSyak8mvDJQqs28pXmSgr6Fi8Xm4tRBTAud1A02/gyRDozw==
X-Received: by 2002:a05:622a:1984:b0:466:948e:beec with SMTP id
 d75a77b69052e-4670c38fb9emr122391861cf.39.1733329630875; 
 Wed, 04 Dec 2024 08:27:10 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407c56asm75295301cf.37.2024.12.04.08.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 08:27:10 -0800 (PST)
Date: Wed, 4 Dec 2024 10:27:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7]
 efi_loader: Add support for logging to a buffer)
Message-ID: <20241204162707.GG2457179@bill-the-cat>
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d1jGug9VV/YT3WnS"
Content-Disposition: inline
In-Reply-To: <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
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


--d1jGug9VV/YT3WnS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> >
> > > From my side I'd like to change the conversation a little, to how to
> > > land code, rather than why we should bother. "Code needs to land"
> > > should be the motto. If someone has taken the time to create
> > > something, our bias should be towards getting it in, with sufficient
> > > changes to make it fit the project. There are cases where something is
> > > just a bad idea, or should be done another way, but for people working
> > > on major features or changes, biasing towards not landing the code is
> > > just going to make them go elsewhere.
> >
> > This is the wrong approach I believe. The goal has always been and
> > continues to be to have reviewed (whenever possible, our developer
> > community is small) incremental change over time.
>=20
> Yes, I agree with that, but it isn't what I said.

I don't know how else to interpret "Code needs to land". I'm not sure
what reviewed patches we have that are outstanding, but also not fairly
new. We do have patches outstanding, in general. Much of those fall in
to the categories of:
- Custodian is active, but also very busy (virtually everyone is a
  volunteer so I have a hard time getting forceful with people that have
  a large queue).
- Custodian isn't active / no direct custodian and the code hasn't been
  reviewed by anyone else.

> > Just because something
> > has been posted a number of times does not mean it's ready to be merged.
>=20
> I didn't say that either.

It's an impression you give however when you repost a series less than a
day after last posting, without addressing all of the feedback.

> > Your challenge today is that on patchwork you have over 150 patches
> > covering a wide variety of topics and of which many series have
> > technically-merited feedback that needs to be addressed in a technical
> > manner.
>=20
> By my count I have about 10 series in progress, with a small number of
> patches (< 10?) with pending feedback

I'm not sure about that less than 10 number, in part because it's hard
to keep track of which feedback was applied, and which not. And part
because some of those series are places where I told you I'm unsure
about the core concept but you asked and I'm giving you leeway to show
me the end result.

> that isn't effectively just a
> NAK.

To be clear, "just a NAK" isn't the whole story. Those NAKs come with
technical rationales and requests. But maybe they're just lost in the
volume of emails you have in some cases. I know for example I mentioned
a few times and places that we have tests today for booting the OS, when
you mention that we need to add a test for booting the OS. We need to
expand that test, yes.

> It isn't a particularly large number, if you add up the patches I
> do in each cycle. It is in the nature of development and code review
> that things are often not right the first time, or someone else has
> another perspective, so I cannot see how this can be reduced.

The easy way to reduce it would be to go from 10 series in progress to 1
series in progress, and finish that before picking up series number 2,
and so on. And then in the future, stop when you have more than 2 or 3
in progress at once.

But really, it feels like "Code needs to land" is another way of saying
"Just a NAK should be ignored".

--=20
Tom

--d1jGug9VV/YT3WnS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdQgtcACgkQFHw5/5Y0
tyyoNwv/baESsygJ7z1kRgd13hWq8KmGK3z6qDBvc1ukuQOnOxZmDzhCYdn6J1rN
rnv0fkPAOvlfS71S2IgAKN5VKDVeGd5FJdny48z5u6fOxwXFevIOHMW4dh1RSTMv
+nxnwG7syj5M6v2wy6328Tgnk8HcAtQMGwQ2WXCX5jpXbZy5HY1hylgzTX/yNl+J
7YItvOhSChKmOo+PmIPhD7KLSD5a3QkpVf79pqWzjQkpa3UgAd14DBI/0bJ4hrv+
njfMH9V0e5pPRsT7fIt3yODtFnBwzsBDyOUgwlDnGVSldC91HiWa+sgK5MqPeUbU
Va7a5NCOKdrnBbwVTPzx3+qLwm6qPBS8OtkZYZKP/cuVG3eiaAj8f19FCiUDojj4
wDotg84s7CVGuRhHIlmmtMaDwb96wUaLCn0/zfXcBYFjY4xkzRbyVi4We7LlMf6w
0xOHSsqC/yVJlY6VGFQH2Za2gAV3UKrx34rUsUTe4T2s9a8qygwA8Kqg7vBidGP1
B69YHG2z
=zYsH
-----END PGP SIGNATURE-----

--d1jGug9VV/YT3WnS--
