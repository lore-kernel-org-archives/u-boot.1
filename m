Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BBDC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 08:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB394820B7;
	Mon, 28 Apr 2025 10:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="cV4gE4qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F8382145; Mon, 28 Apr 2025 10:35:57 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B98180EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1F5501481683; Mon, 28 Apr 2025 10:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1745829354; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=AmKNU11Cg2gO2r109Cw+JoRj0RynO0Z6jJw4qCr4CWU=;
 b=cV4gE4qe4xAipOFrFyVqf0WeNShCmaI8hbcx/GXjewu3uljcWGnPdM7HZ8WLlwkc11qy9Y
 UCjTYNpVGXDIOnsMY/hkEQRfvYSUAVdIkY37Nwi8YNuu6DQAVR9shY4WxJnb/h9hCHDcZt
 1hoDpBh1E/6gBPW5XXmOQn1XNfJR6zAdLd0zPKmmKZRNS8TNcHe0YM7Hniey4pigvepq3/
 NoVRHusU71G2HblKamnl1CpJmrOfZ+xgXJ9nn8pySNtvcdqD08Y02XeulBicpSQMriMELj
 CyxuwA7xecG4lSve1aWFgjMHcjXkaFbdTGP9ywktOKgLyjMwZog7bQEZQJ9/RQ==
Date: Mon, 28 Apr 2025 10:35:46 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250428-appendix-repurpose-062e531ca9af@thorsis.com>
Mail-Followup-To: Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
 <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
 <20250425143752.GU5495@bill-the-cat>
 <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hei hei,

some references, see below.

Am Fri, Apr 25, 2025 at 09:03:17AM -0600 schrieb Simon Glass:
> Hi Tom,
> 
> On Fri, 25 Apr 2025 at 08:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 25, 2025 at 08:35:52AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> > > > > Hi Martin,
> > > > >

[…]

> > > > >
> > > > > Can't you change it, since you are introducing new support here?
> > > > >
> > > > > If not, then you could perhaps set the env variables to lowercase when
> > > > > you find uppercase variables? I suppose that would require updating
> > > > > the client to do the same thing too?
> > > > >
> > > > > It would be very confusing for a user to have upper-case variables for
> > > > > some things.
> > > >
> > > > Simon, this is an unreasonable request. This is how RAUC has been
> > > > working and deployed for years and years. It would be a nightmare trying
> > > > to handle migration of existing deployments for an aesthetic change.
> > >
> > > Yes, I figured. Perhaps it could support lower case in future? This is
> > > the first I have seen on RAUC in U-Boot, although I do see this file
> > > which has both lower and upper case:
> > >
> > > include/env/phytec/rauc.env
> >
> > I don't think there's any need to complicate RAUC support here (nor
> > in the future Mender nor swupdate nor any other long standing OTA
> > mechanism that might be more easily integrated via bootstd than
> > environment patching).
> 
> Let's see what the author says. I assume that U-Boot has its own code
> in RAUC so it might not be too bad.

It has:

https://github.com/rauc/rauc/blob/master/src/bootloaders/uboot.c

These env variable are names are hardcoded:

BOOT_ORDER
BOOT_A_LEFT
BOOT_B_LEFT

I played with RAUC and U-Boot back in 2021/2022, and if I remember
correctly these variable names did not change since initial support
for U-Boot in RAUC.  That probably was back in 2016 and done by Jan
Lübbe: https://github.com/rauc/rauc/pull/45

(I used a custom boot script based on the example coming with RAUC and
hooked that into distroboot for my usecase back then.)

In retrospect it might have been better from RAUC side to hook into
the bootcount feature of U-Boot, which was already present at the
time?  But now it's like Tom said: these env variables are the
interface for years.  It would require at least coordination with RAUC
devs if there should be used any other interface.

Adding Jan in Cc, maybe he wants to add some context from RAUC side.

Greets
Alex

