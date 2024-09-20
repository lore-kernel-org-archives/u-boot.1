Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882E2CF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C9888753;
	Fri, 20 Sep 2024 18:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qvE3BZpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237AA886DF; Fri, 20 Sep 2024 18:40:40 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74CD88753
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c351809a80so16069416d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726850437; x=1727455237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dnnctiwqqXDPeQ8zJReiDlLRDAPSsftaz1KByqmLAak=;
 b=qvE3BZpZGOsRAHgTyMQcUWEvv3Hioz/BIJj2SqKHCp48QvuE5+VevG/Ax5HqUQknj6
 /HuztMhA3ECMZ7Qj+IYEiwPCw9LnzxH9LyX9BrbDvsm7YLxvdOAUrbSF5elDXd5QA1AC
 GBRmboKB5o9FtfNq6ROJckJY51IOHCLv3QDsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726850437; x=1727455237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnnctiwqqXDPeQ8zJReiDlLRDAPSsftaz1KByqmLAak=;
 b=DZpWnkRyvaSpwVFNKhW+45YKedAYpk7fmR9jeVVEj3n/ZBsg+C0g7bQ0XcFnd+y0g9
 AbmiRxL32lSBBKjT0d/hkOX4GNkz88NFfMWx6lVS480D1utcd8kyCcKH3iEQMs2ePIeX
 M5ByeXKwU1nWU/LHBvHTY7MDosU9kOFnERbQUznNLWid0umdC+V7RmCIDiBamsz85230
 +IU614uVlH/ttDhY6ywXh+najGe+xLMCl/A2KJlSWrVTi3TWFMQzP9U+AfFsftRaTlsF
 kiJezHtIdRAyJEvXAPnCn3SFVARr41ylwRiEcABGxcJfZqKbq2OReJc9jylPwov5ZXvQ
 BH0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOsGBt/a2O3TwzrYVlhqv3+X7MU5xzEwqIr+bCS7UEd67NXxGm3f3q4bN4R03g9XqON9PBXY8=@lists.denx.de
X-Gm-Message-State: AOJu0YxWSUh/m6L9YStphdEL39RDq3SiC8G3GvYinosWPOMQoZQBcMen
 +SBL2iSGzAwEAbJ6tp39KkH7nR4kM6cBe8lTv1sSk2l67u2KA+RDnWy8rW1MRr4=
X-Google-Smtp-Source: AGHT+IG2faSYlpfmtFhfcJE4LgT2ZyP6AcOjdagRDY3d7gKyPy5keJiNBt1atDmIrCbxXPXGgTz2+w==
X-Received: by 2002:a0c:fac3:0:b0:6c7:c658:5f40 with SMTP id
 6a1803df08f44-6c7c658610bmr15154966d6.14.1726850436565; 
 Fri, 20 Sep 2024 09:40:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e586d1bsm19550796d6.136.2024.09.20.09.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 09:40:35 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:40:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
Message-ID: <20240920164031.GH4252@bill-the-cat>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
 <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
 <20240830004936.GP2479150@bill-the-cat>
 <CAFLszTjjni839jghOpforB-4+MnqRh7JXw575VtP_UO-SzfnKg@mail.gmail.com>
 <20240830014622.GQ2479150@bill-the-cat>
 <CAFLszThE7mrnOyGCzPcC01soCvoT++SgvUp4WpHiJZH4CXhWQw@mail.gmail.com>
 <20240920150136.GD4252@bill-the-cat>
 <CAFLszTjQAH-87Gv_VoXVRE77+foCm=Aq9WBev0PzTfM=Kyw99Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6JxS7F8OBjRbOrYB"
Content-Disposition: inline
In-Reply-To: <CAFLszTjQAH-87Gv_VoXVRE77+foCm=Aq9WBev0PzTfM=Kyw99Q@mail.gmail.com>
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


--6JxS7F8OBjRbOrYB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 06:04:05PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Sept 2024 at 17:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 20, 2024 at 09:25:53AM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 30 Aug 2024 at 03:46, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 29, 2024 at 07:06:32PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 29 Aug 2024 at 18:49, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 28, 2024 at 04:16:55PM -0600, Simon Glass wrote:
> > > > > > > Hi Peter,
> > > > > > >
> > > > > > > On Wed, 28 Aug 2024 at 03:59, Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > > This includes various patches towards implementing the VB=
E abrec
> > > > > > > >
> > > > > > > > What is abrec?
> > > > > > >
> > > > > > > It's a VBE method which supports A, B and recovery images and=
 permits
> > > > > > > updating from SPL onwards. The idea is that you can safely up=
date
> > > > > > > without bricking a device.
> > > > > > >
> > > > > > > >
> > > > > > > > > bootmeth in U-Boot.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Simon Glass (18):
> > > > > > > > >   sandbox: Add missing header file
> > > > > > > > >   bootstd: Add stub for bootdev_setup_for_sibling_blk()
> > > > > > > > >   gzip: Correct function comment for gunzip()
> > > > > > > >
> > > > > > > > Is this from upstream gzip code somewher?
> > > > > > >
> > > > > > > I'm not sure, actually.
> > > > > > >
> > > > > > > >
> > > > > > > > >   fdtdec: Support separate BSS for all XPL builds
> > > > > > >
> > > > > > > Needed so that VPL can use DDT
> > > > > > >
> > > > > > > > >   tiny-printf: Correct return values
> > > > > > >
> > > > > > > I can't remember, sorry.
> > > > > > >
> > > > > > > > >   tpl: Support numbered aliases in device tree
> > > > > > >
> > > > > > > The MMC needs to be accessed using its sequence number
> > > > > > >
> > > > > > > > >   ram: Support driver model in TPL
> > > > > > >
> > > > > > > That should say VPL...but again I'm not quite sure
> > > > > > >
> > > > > > > > >   serial: Support debug UART in TPL
> > > > > > >
> > > > > > > This allows debugging of the jump from TPL to VPL
> > > > > > >
> > > > > > > > >   armv8: Support not having separate BSS
> > > > > > >
> > > > > > > VPL doesn't want a separate BSS since SDRAM isn't available t=
hat early
> > > > > > >
> > > > > > > > >   arm: cache: Drop a stale comment
> > > > > > >
> > > > > > > Just something I noticed
> > > > > > >
> > > > > > > > >   arm: Fix up a stale comment in sections.c
> > > > > > >
> > > > > > > Another thing I noticed
> > > > > > >
> > > > > > > > >   mmc: Support driver model in TPL
> > > > > > >
> > > > > > > TPL needs to read VPL from MMC
> > > > > > >
> > > > > > > > >   mmc: Add more debugging for SPL
> > > > > > > > >   mmc: Log the error when init fails
> > > > > > > > >   mmc: rockchip: Log some error returns
> > > > > > > > >   mmc: rockchip: Allow clocks to be missing
> > > > > > >
> > > > > > > These all help with debugging reading of VPL from the correct=
 MMC device
> > > > > > >
> > > > > > > > >   rockchip: mmc: Fix a missing colon
> > > > > > >
> > > > > > > Just something I noticed
> > > > > > >
> > > > > > > > >   rockchip: Provided SPL control over efuse presence
> > > > > > >
> > > > > > > We don't want this driver in TPL or VPL
> > > > > > >
> > > > > > > >
> > > > > > > > I'm not sure what most of these patches have to do with VBE?
> > > > > > >
> > > > > > > Basically there are a lot of little tweaks needed.
> > > > > >
> > > > > > Well, I think this gets back to some common feedback. You have =
a lot of
> > > > > > little bugfixes, which is good, but they get sprinkled in to th=
e next
> > > > > > big series you post, which is bad and hard to review. And that =
leads to
> > > > > > fixes not getting merged / reviewed timely because nominally si=
mple fix
> > > > > > A is in part 3 of a series to introduce something larger and to=
 which
> > > > > > there is feedback to work through.
> > > > >
> > > > > I actually thought I was splitting them up quite nicely. What do =
you suggest?
> > > >
> > > > I would refer back to your own comments about what some of the patc=
hes
> > > > do and say that "Just something I noticed" should be a one off, and
> > > > little fixes for this-and-that should be a 1-2 part series and so o=
n.
> > >
> > > I really don't have a great workflow for keeping track of more than
> > > 6-8 pending series and even that is sometimes a struggle. For testing
> > > I need everything applied so I have every series in a sequence applied
> > > locally.
> > >
> > > I will have a think about what can be done. I wonder how others do it?
> >
> > I believe the answer is multiple branches and merging them as needed. Or
> > what I do is make each subsequent series a branch off the previous one
> > (and set the upstream appropriately) and then rebase as needed.
>=20
> OK. That is my current workflow, but it can get out of hand,
> particularly something like VBE abrec where over 100 patches in 6
> -or-so different series are needed. I suppose that is why I keep
> putting over doing the final two series...

That should make re-branching things easier? Get your whole set of
things in roughly good order then you can:
git branch vN-fixes-foo commit-hash1
git branch vM-fixes-bar commit-hash2
=2E..
git branch -u vN-fixes-foo commit-hash1 vM-fixes-bar commit-hash2
=2E..

And there's your series broken up and re-branched so you can have
however many branches you need to split everything up in to something
reviewable and mergeable in parts. Taking one of your branches that has
everything and rebasing that on a new upstream commit that has some
branches but not all merged should get things correct and drop the now
upstream parts.

--=20
Tom

--6JxS7F8OBjRbOrYB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbtpX8ACgkQFHw5/5Y0
tyyubQv+NxP0SzmTXkon9h7jSwV0ro5PKZ/WcC/ydyOVHQx23O0WqGT2XdW0QGzn
T+wTf77evz7imADAqLVu2cfN4z+t17UiO4LnahY9nfEBAZ2/YF6nOUWQ7n56ZM1o
lrxlYwuOx517Y+bnYKGrqwOlPUvJy1We/D2uu6lYK0oq8NrOFwgsSQ3HTmM/7vg3
GQUshE2zAkoVKK3eoCUda0EkPIDZH+PFJkY8xSTjwnqtG/gUmC4oEFJwyT/v0BhA
mD7MNJSpXhNGo37VuAJc0osKuzTJnHYI3LAB7FUADPxaoASkssKrZUD7ZrKAOD7T
9HghXs0uJF8aqg2pDo7TqeSw12pzNo8rKVnNoET+ZcCBKyZza0BqBWRTuMFMRU3G
kydHNqKOomy4uFTXWf3J5PxiRxkRs18M4QBUxXF+JoQpfsFHjvQok4WWy8DMOhc/
jbZhLyY7HAbCpFWr8CvT66avMWhMHvUS7xVBHzygEbw2qhY+butJSyuCgWUzGG6d
zwi46SkB
=LSLU
-----END PGP SIGNATURE-----

--6JxS7F8OBjRbOrYB--
