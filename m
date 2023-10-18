Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D823BCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 13:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A3F86F34;
	Wed, 18 Oct 2023 15:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JSm5EObG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A16B86B05; Wed, 18 Oct 2023 15:25:42 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C0B86489
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 15:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d9a5adc8cefso7735609276.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697635539; x=1698240339; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g8kuoMZ461ZCDJz2VFe6t1f+5V1XG6YmhWb5ZxLyYZ8=;
 b=JSm5EObGO/Fu9Avyv/tFObnejxViJ3AwH1ivge3NJwpBeGY0D7o/qxh4H5YdQHnw4i
 cuqIgZ1gcs+dXhVMUt30LmDioKjHcFYPFQ/+Qz3kuKRwEvzgpmwUUEIAiNGmq2E9Tg/c
 7YKVE2VyZQHmJPk5ANBkP6NuD2At5/isurPCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635539; x=1698240339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8kuoMZ461ZCDJz2VFe6t1f+5V1XG6YmhWb5ZxLyYZ8=;
 b=N3AMrE5O8sYphJG+/6P9DGv/u4wG88DbyB4cCcKpUYPd4tONV00dk8uetTnVYDZP1h
 SdbLtJ1sfxLDly42LTdudq5LegmD8p20FbFuNZvS+X/S7DIDTJ/Acqp98pjEdvMiEoG/
 CY4hiHMqGltrv5VzHOMFk7aSubN3G0Suq4Vq7mukytwP3mGJG6f4674KuyJSezp2/Vgi
 lL6N1jQV/5csB7kFU11T+tfHRSn1CM2+DdBE3IFDwyiisRs9EsFamjeyPuE2tZ8A1WDj
 FG4GpBrssOT7oao/OiNUqBnKX8ZfOHs9t24eIiccDfni5UIUPsIXZNe3KefNwheIobcX
 QSQA==
X-Gm-Message-State: AOJu0YxgzY/oqwAcx0uSGA40Y/6vnl8x0RQ5C0FtYAoe+f88bpIzv9+8
 WQkQnnv2OOXSpMh87IIIAryT6yYEOKfNpSrm2nC8uA==
X-Google-Smtp-Source: AGHT+IHrdOQoFS+wdDixz6aCH6Hv5Pu6UG1EiIVCotea8QvRH8kHRxb125U2h90YmBzd6M0UofuUKA==
X-Received: by 2002:a25:83d1:0:b0:d9a:b7cd:47f5 with SMTP id
 v17-20020a2583d1000000b00d9ab7cd47f5mr5347787ybm.56.1697635538957; 
 Wed, 18 Oct 2023 06:25:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 z4-20020a25ad84000000b00d815cb9accbsm1294229ybi.32.2023.10.18.06.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:25:38 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:25:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 02/32] bootstd: Correct dependencies on CMDLINE
Message-ID: <20231018132536.GS3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-3-sjg@chromium.org>
 <20231017133224.GS3119521@bill-the-cat>
 <CAPnjgZ1cEr_=EdnBatQ1_LMsC9KD0g5bCJt_qvBkQifV+tb0ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oLDMynLGVZrKBuzs"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1cEr_=EdnBatQ1_LMsC9KD0g5bCJt_qvBkQifV+tb0ag@mail.gmail.com>
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


--oLDMynLGVZrKBuzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 09:30:30PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Oct 2023 at 07:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:27:53PM -0600, Simon Glass wrote:
> >
> > > With recent changes over the last few years in boot/Kconfig it is
> > > no-longer possible to disable CMDLINE. It results in various link
> > > errors because some options which require CMDLINE are enabled
> > > regardless of whether it is available.
> > >
> > > Add the necessary conditions to fix this.
> > >
> > > Note that it would be better to have all commands depend on CMDLINE,
> > > but that is extremely difficult at present, since some functions use
> > > CMD_xxx to enable feature xxx. For example networking and environment
> > > have a number of problems to tease apart.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Since you later rework things to tease apart most, if not all of this,
> > please split out the patches which tease things apart in to their own
> > series so that the rest of this becomes reviewable and also reasonable
> > looking.
>=20
> At this point I fear I have lost track of things, since there is just
> too much going on.

Yes, there is too much going on, which is why I wanted you to split this
up further.  I think we both agree that's a problem with this series.

> Just in this version I have dealt with:
>=20
> - some EFI stuff (which needs tweaking)
> - teasing apart the CLI handling (which apparently doesn't go far enough?)

I don't think it's fair to call out EFI here, it's fairly well behaved
and no worse / oddly using CONFIG symbols than video or networking or
just about everything else is.

> Before this version I already looked at environment (which you say
> doesn't go far enough, and fair enough, but please review the code as
> sent, not what you wish it was).

Well, that's just it.  I did, and I wasn't entirely sure how you were
splitting things was right.  There was more stuff that either didn't
belong or should also have been moved, it wasn't clear.  The split I'm
suggesting there should make it clear.

> Perhaps you could apply whatever seems reasonable and then I can take
> another look? Or suggest some small changes that would allow progress
> to be made.

I guess I'll see what I can make some sense out of, yes.

> But do note that supporting booting without CONFIG_CMDLINE is a large
> effort, the subject of 5-10 series, perhaps more. It is not my
> intention to undertake that in this series, or before this series
> lands

Well, one of my issues here, especially with the idea of cycling back
and cleaning things up later is that I kind of assume you had intended
to do that in some places already, having done the good and important
task of breaking up the old common directory.

> The problem, also, is that without this series, it isn't possible to
> start that work. With this series, one can look at what code is
> missing and find a way to call boot functions (for example) bypassing
> the command line. Once you get it booting you are good. Without this
> series, you don't even know where to look, since calls to the command
> line happen silently.

That's where I disagree.  Step one is working towards being able to
build with CMDLINE disabled, and doing it in small reviewable chunks.
This is one big series that gives you "can build with CMDLINE disabled",
but while I'm usually not a fan of the Linux kernel's strict "break it
down per subsystem", I'd be a lot happier here, and we'd have quicker
progress too I bet, if instead of 1 30 part series we had 5 or 6 smaller
series.

> So I think this series is a big step forward and urge another look, pleas=
e.

That's what I did with v3 yesterday and why I had a bunch of other
feedback.

But, yes, I'll take some parts of v3 and see what I can come up with.

--=20
Tom

--oLDMynLGVZrKBuzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv3McACgkQFHw5/5Y0
tywOPwv+PNzfVRxW1TW24xoNh53bo/fFENDx7EihcUwgR4oGIRnoMvuGnmPeMOjI
4kTKd34yNz1HUYcgKZawzrHr/scFMGhaODyBmda5VoKJ/4CIW5gb7UcT0DMX4omN
ihWJ3KUCoNYBWXNkYkvgq/B82kfTw3C3YNvjXt8nuphpk9L04OeNY1w5dRXbO5tv
VNbkiHIKW/UB8l/j7p5qPGHS9/uYy8Dg5xwlcAifOasvIvd/dPPi08WVQsr98QHD
dUzoKIteZo6pNvuFsQNYgpZ9c9qlZ9xm4c7dNXa4PI+gqNKhPcYo9Lqcbg4FAmYf
c2LtDkUDRql4RbMHntU3XH+pGhGIe0DRHEHK8V8TiKOGQpLDJVvTaz7/CNFBLHbK
jYClPF5fHM1VFBSX8O1ArqNLDg/yArLifo8n4S5OxO66q7QK9rBA5jEnfpcQONv6
jGoCnpJQlU1jxkpFHmB99+ESyd6dmOEpvz5letZO/RTnNcmKMV9iwigodSagU832
hBlJ0CsQ
=slhu
-----END PGP SIGNATURE-----

--oLDMynLGVZrKBuzs--
