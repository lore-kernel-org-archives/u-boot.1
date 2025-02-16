Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE2CC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 16:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F21A8056A;
	Sun, 16 Feb 2025 17:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DJ7/wDQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C0A807E1; Sun, 16 Feb 2025 17:07:51 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2B6801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 17:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220c92c857aso55997315ad.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739722067; x=1740326867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mkGezLmw5AHvAn8Et7JbM5vYfZMnlRbZKQL0hYqoiWk=;
 b=DJ7/wDQHaNL6E3XCFmnt18a+3MzOR9/PXBnnZoEdQsalTKSUq/MAH42E68pfocsnvI
 bHAUdSafl/4Sj5d2GFUrfdPYP36uLFpoZiGY0purRHdQ5WiOS+HwbE7ldTQC7BIdzp2R
 98c+ui1DFNhjQE7S4bDTp6HwmuR8yE870gnyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739722067; x=1740326867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkGezLmw5AHvAn8Et7JbM5vYfZMnlRbZKQL0hYqoiWk=;
 b=uZBs+N0ZK3kOd5uE79QviMGMOxjiVjNmmDp5uDwMEg7JbF1qe3eAyUREKNK2IkezGz
 NwEjzbZtpw4cBF0mSOpbMW5CTpfiXb8CruSricWEw6AanEUEMZwZkZ7C0kbPJvVkHuTr
 Ad9RNFROHjq26obZOlt2zFkqwRDrjW30/JqUsYqOVhqc3l0NmNd2s6CF7dBjOUWR4O/v
 nOn3r93cdeYs6jJtxTw4B9pxS5vvcQHVwBhsBc8uN6toU2lF8x977Yvejfl/nm0CRD50
 reLQhPajU0J2Aa8dveXrNv/DrW2vJDsVm1lpWSlVgMxEIhOdH1oSw1TLrrPF/8mHArR+
 xXBQ==
X-Gm-Message-State: AOJu0YwJIENFnQbrt2XEGYrpOX+tkAHYycaqES15L+d37re4OT8HKLf/
 fxsRtvQbTwJLGyaCcfQ8z57bWYI8Y9EgvdYyyd2MxkHGtplYOvxjleQKTXY/i/o=
X-Gm-Gg: ASbGncsGWdNKxRBKE6IH9fa2HkfvWhwnICqb83nmW7nQxp0KKeFqcep7EJFu5aMmYe+
 ugvubDLfjBXD8z0m6KWjjbUgbw2LVnPOBa1WcweZMpULmwyC9IkCDZGVGZrI2wdHIw12xpy0ECk
 hXUQFD+iGdXalgwTSkX5J//91pH0iZpE5KG/BkEDScnamVOoWAIkD7975e1ntiixWskcrjfVfj+
 bmSvmV+OCAlpYlTVN9+I2QZ73RGlYDGBiS3GbTREOmerOX+PjOhttT0kASz1hnsUVgVBXCKgnci
 9/XUXQJfk4cQjQ==
X-Google-Smtp-Source: AGHT+IH4rmvSnqW5uJ42cueJLdYtskEp9bMKLMzIf6WG0vaPYGFGv8EhS25kaltpSEAUaL+kvMRw1Q==
X-Received: by 2002:a17:902:f684:b0:215:742e:5cff with SMTP id
 d9443c01a7336-2210460aab7mr108935825ad.16.1739722067310; 
 Sun, 16 Feb 2025 08:07:47 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm57656985ad.28.2025.02.16.08.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 08:07:46 -0800 (PST)
Date: Sun, 16 Feb 2025 10:07:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250216160744.GA1233568@bill-the-cat>
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GLxH4b3kalvA5AmA"
Content-Disposition: inline
In-Reply-To: <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
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


--GLxH4b3kalvA5AmA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > This is a global default, so put it under 'default' like the =
tags.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > > Please make v4 include the way you redid the second patch and b=
e on top
> > > > > > of mainline, thanks.
> > > > >
> > > > > That's enough versions for me, so I'll let you do that, if you'd =
like.
> > > > > It probably doesn't affect your tree as not as much is done in
> > > > > parallel.
> > > >
> > > > I am disappointed.
> > >
> > > I'm sorry to disappoint you.
> > >
> > > The background is that I looked at the difference between our trees
> > > and the gitlab files are quite different. My CI runs take about 35
> > > mins and it seems that yours is around 90 mins. I would like to reduce
> > > / remove the delta (for time and patch diff), but I'm not sure how.
> > >
> > > My goal is to get CI runs to below 20 minutes, best case.
> >
> > I'm sure CI could be quicker still with a number of faster runners. But
> > if you can't be bothered to make changes against mainline, what is the
> > point?
>=20
> If you recall, I was working with your tree and had various ideas to
> speed things up, but you didn't like it. So I've had to do it in my
> tree. This is not about more runners (although I might have another
> one soon). It is about running jobs in parallel.

And I wasn't sure more runners in parallel would help (as it would slow
down the fast runner which is what keeps the long jobs from being even
longer) as much as adding more regular runners would (which we've done)
and noted that in the end it's a configuration on the runner side so to
go ahead. And I reviewed and ack'd the patches here which exposed the
issues your path revealed. I just can't apply them because they need to
be rebased (and squashed).

--=20
Tom

--GLxH4b3kalvA5AmA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeyDUQACgkQFHw5/5Y0
tyzLZwv/dRkjtVbuiCbd0O9/F5arBooRmikN0cb8lLU60m6GFy/JuRswed6oSFkz
Gq2c7NFEePMagAOzIHXOQo0EwYkPxMMdpyQBDiw3n37XupekRVZ34JHI2DfRcfaH
gHZ0SxiDhE1T39PeYYXptfW4fvrWLgqqXJDRBcRpCUtDehVWpcaVua7FFo3+1Gj9
P6hT2Hg5E8RBBpY2bgoNOG2sNuPkeVy9+BamfTEDTPi36lemvDBtbhqNINFK3I6V
7wm1HUtsPWx/ozQXDZLfq1u2whWxE06Q/QcxShKd+VudBiUmNRgq9iExCqVXRdCI
Wvjd9VtKgudcY8VX8JCYVQuQ2Zi70RNihf9N+9IYGimWrVVh62RAokaSBOt5T+BE
EuvHEFK3oq1Ti6sy5lxLyFCTORLKQZolW9xiHp4Z29yQ5/uyTAyTslyjF7VsGo1F
f0l5aLgleTnk01WlueQ9f8ko1QkyALAMqiWsYchQ4gxjKwrpl9kgG9IpMTdaA5xu
7ehItAJQ
=xsVI
-----END PGP SIGNATURE-----

--GLxH4b3kalvA5AmA--
