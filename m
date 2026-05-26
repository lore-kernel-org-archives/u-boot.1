Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BB4CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5DD846E2;
	Tue, 26 May 2026 16:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mUfvH7mW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9D984843; Tue, 26 May 2026 16:18:20 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E26846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-69d92dbc420so2155406eaf.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779805097; x=1780409897; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gyk3PpCGGtC8jwjcYdi/DgudCELLNmybt52l/TMn8Cw=;
 b=mUfvH7mW5U7T9zjn/uH/VVlVOEoi4GkW03ZgpPFkaaFWDs9ZIxHpDG5KUpZokf1V9r
 t2/B53s82lJdHIIoX5HqnSEg8MG3paJy671yIFjeNRCzFK4HKFnH33EdDienwAdUHeCr
 FZGZduTK29n159Axb9deoCHNOhowm3s1dXdZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805097; x=1780409897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gyk3PpCGGtC8jwjcYdi/DgudCELLNmybt52l/TMn8Cw=;
 b=sMOHiiTdbYdg2z9A7bs7rdWRuVqvQ2beGjVs0DANmhE2cnRAf0XkZuGCBQuaIU3YYI
 tvAFFinn55gqIFia0q/3I6H6/0V4xZNxvO4BUtUUK21xSST6z13C8MiQuVHnDorvrwfq
 V4OKkhZzcWndJKf8DhGtAr1vqB1B8GbiGu7k60q+rrSTIPtXZg7oDRqfMGhD1ZBwXEKy
 xxgrkThwwhOSolUJNUvKqVCdk2j63NlPAq6MNY1ps0o6ze9JXcbhjiDYCxnZqEw/n32H
 qokIOihqhX39EgybiAX9r2HdQ+TYGqmKw7b83MfMzhqdMXQ9ZX2VSFTB5lTkrs/BcPRi
 /YmA==
X-Gm-Message-State: AOJu0YziQ4pTcPplNKiNlsuEfHowH5SnommTVfYCC/l2gtQEXxtovMvK
 o027QMbNmjMSjwUUSd0r6jsJCLNJe7q136dDJUFj5YUT081zWU6bn8PitIo0OngM3zc=
X-Gm-Gg: Acq92OFO7LpgcLOXsJP5ZvOuswV0rQ9LP2bIFhzZx/482lgAAoTGBVuS4304/7STlPU
 qjt9petd5oq2g/NvkmfRMHnzs2/nLGBvBrOiiNU4wdPo7et3jvG4c9IZRTuczmVeQgeytj6zqdT
 2lmX7pIHMMHvaW5CYGQ0UpwMpnY7pP6qNgbx7yCD/4p8mZfMCsE4JGT6BYJ2+wHUPaArxJbruQO
 9TGfDbQg2qaEJx8qstZYTlyDgwL1zUB4h4Pu8mIN047fg19OjJkbZpvdMvz/VSt/fUf/nuZkNMX
 A/e6/Pf/nNjz9RhocqaZSbddrD+Mx+hqXRh9K0U1EPggLewgQvrAk5EciWJA1B8XGpwS0TczaYF
 0Kc+Amgetb/u3yXnXt9FyxqbRpCaw6Nwd2FRn8TRCKzz1VveVCIGBs+sBWBzk4KOetXT5FeIxzN
 zzDOBRRozyKk2xkItzuenu1nC0SrNkx2W7bfnKWh4xz10L/MKAbTN+w2jkS3mCnPMQYVM0uyNAU
 /o1woqeTvZUn3htk1yRofqtoA/kArg2W03V7K96Zx+5Dw==
X-Received: by 2002:a4a:e849:0:b0:69d:6a9e:e925 with SMTP id
 006d021491bc7-69d7ebbe335mr10189536eaf.27.1779805096700; 
 Tue, 26 May 2026 07:18:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d836c6d90sm7242566eaf.3.2026.05.26.07.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:18:14 -0700 (PDT)
Date: Tue, 26 May 2026 08:18:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: AI-assisted review
Message-ID: <20260526141811.GS1858239@bill-the-cat>
References: <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
 <20260518155842.GR1858239@bill-the-cat>
 <CAFLszTj771TqyyvF_MGhNM4tfucQSs6sMOHzXVYDtNKBv_AZxg@mail.gmail.com>
 <73C33414-3094-4A9D-B823-72DDAFA6DEA0@disroot.org>
 <20260525142159.GI1858239@bill-the-cat>
 <1B7720FE-03CB-4CA5-A063-2B4A87B633C5@disroot.org>
 <20260525142718.GJ1858239@bill-the-cat>
 <7418B716-CA18-4745-A95A-D4C61AA903F7@disroot.org>
 <20260525143951.GK1858239@bill-the-cat>
 <a4d2844a-db8d-4fef-b0e4-443e6e4fb550@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8qV/MM0RejfDYNnn"
Content-Disposition: inline
In-Reply-To: <a4d2844a-db8d-4fef-b0e4-443e6e4fb550@kernel.org>
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


--8qV/MM0RejfDYNnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 08:04:54AM +0200, Krzysztof Kozlowski wrote:
> On 25/05/2026 16:39, Tom Rini wrote:
> > On Mon, May 25, 2026 at 03:29:50PM +0100, Josh Law wrote:
> >> On May 25, 2026 3:27:18 PM GMT+01:00, Tom Rini <trini@konsulko.com> wr=
ote:
> >>> On Mon, May 25, 2026 at 03:25:19PM +0100, Josh Law wrote:
> >>>>
> >>>> But most projects do generally ban AI anything.
> >>>>
> >>>> Idk what we could do for u-boot when it comes to a sashiko like
> >>> solution.
> >>>>
> >>>> Maybe we could talk about it?
> >>>
> >>> Proposing a policy for the project about AI (and indeed not just link=
ing
> >>> to other projects which have what I find to be helpful references) is=
 on
> >>> the TODO list for the project leadership committee. We've just been
> >>> busily handling other issues for a while now, unfortunately.
>=20
> For kernel:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/docs/linux.git/commit=
/?h=3Ddocs-next&id=3D48c3876a6a6f78578ccd0fec71ef67fd6a3fd6f5

That's good to know, and we should pick that up too as it is clarifying
for everyone that is acting in good faith.

> >> I could put something into suggestion:
> >>
> >>
> >> So, for patches: you could do assisted bys, and it depends on the
> >> maintainer, etc etc like Linux,
> >>
> >>
> >> And for reviews: that's actually hard to think about, because some
> >> maintainers love using AI review tools because it's useful, others
> >> don't particularly like tools like that, maybe a opt-in "reviewman"?
> >>
> >> But tbh that's up for discussion.
> >=20
> > Thanks for offering, but it's going to be a large / contentious enough
> > issue that we haven't gotten to it yet, unfortunately.
> >=20
>=20
> Before you waste too much time, that person uses vibe coding without any
> control and without any supervision, so that's basically AI slop.
>=20
> Also, in terms of reviewing whatever review they would provide has
> little value. I am sure Josh Law would be happy to give "AI-slop" review
> and get tags for that.

Thanks again for the heads-up there.

--=20
Tom

--8qV/MM0RejfDYNnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahWroAAKCRAr4qD1Cr/k
CqCPAQCt2bcKHM7wgI0qlZMdiTjcdxhog5G1zW+mjl2grsTqqQD+K9vFVB/SLDw4
2MOKhk4uG2D1Rr4otD6GtuVBY1vPlgg=
=Ktu1
-----END PGP SIGNATURE-----

--8qV/MM0RejfDYNnn--
