Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6831DCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9E88341A;
	Mon, 11 May 2026 16:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="si07OmaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1888394E; Mon, 11 May 2026 16:58:22 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6FEE81E18
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 16:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so3286033fac.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778511498; x=1779116298; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FmfGvAhOblmmjYPxfKmQjAob14w1LMQdNX+xVzGclIM=;
 b=si07OmaV9rpd/AbzozuALOzwXDCsmM8hfQl9eO+gkEH+rhlaruELTuMOJA004ZCm7A
 IlgKSVn80lZUKEqKOhUs+TNRB8V1WvFEpwn14q7Z4+g2394828mEeVUvivljtmGKj4Tq
 aw9wRIs5UYRpjeKLkMdoUErgeUtT/yZYgCpQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511498; x=1779116298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmfGvAhOblmmjYPxfKmQjAob14w1LMQdNX+xVzGclIM=;
 b=XiiPLA/Mg+AWG/EH8cAq+sIKGCIHeRoZWvtctMYITWg/ei/wdMZNx1DhxZVRi8Zlf0
 jJw+Nu2WB4cr0I5MJInNgDCfI0igMaWb89x5AdAitBy+Cg75VwmDIdMNsdnP9m0yrEWj
 9/bCsOnIUFdLKLJUJLJoEXNUxnNVk4OOgbKULSzHjwKuuzdiBPKPDBd8235zSWGfgY5y
 e4G+0axocQ2VU4lzEYDi8QYcE+KwxU1Qu/ot3fFo/FdK5xEd37AazoKtDY/iHzAB1oVG
 8klXAfECNDj2xp4TNOqnyHfF2QIXY0KjkcuhSsQwa2ME/z0i3+tW5oJq5A9e9v5WY/4K
 uyCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8m8Bnz0qxzacAPtedPMHzFVU+KfLCb27DSavZUj5RRN/9tNZZIl0buByz834soqQpHOZ7Mk7c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9tbAKOKZjWfPWhmX9ubFY9/16LxcbOlzSwrHFTzbeajaCSeUB
 GBzA9iJeFK6LzY/XGJAdaJNZH90+6izQtFxRnMIV//D7OK1HoGkjqJHbJtgmDO3x8Gg=
X-Gm-Gg: Acq92OEF3c29Hg6k9b/2YwBee1Z46h1pAfDh8brQ6to/G2jg0GO11xJvt9AEMNQgCkx
 fatgWmm0BAkGROlsbRZT1pHd1se5aiClLpFjdOUKQatpXhv5gBAsPCjm8/ZDukptr9s9wRMHqdJ
 PrCEro02D2sd8l/AppHS5P3wcBOgCzM9NZlr66b1Q0/3oXGzVogzpWu6ZWWtG0ORR9F2GO/ybvv
 zVw328VyubVDonStOCzZyfVZs7GDyfDKtP8fqdmPVTS8IDfwq19hlXfpG/iHzxPU60E6ezIVR9E
 Aw7xv4LxMeoIynv0hvUSSR0caJsulRjTFki0VNUI0lI3trrjk10JUKdlSUmOYzn7RS6OOrMOrx1
 iff6G96mcPf36aGNHvNxQW8Am0nvZMXIssXSTNj6x/x0FkJy3I8pRP9pnH9YP7zWl7wm72xVvTq
 MhMnf7lGS+F/7iKxpXrkluN34KBHBM0psrE9FUsd1Mn9OcNBYBpGhic1HarCpSMOiaHVyVAqYOm
 dQxbH0IiJl1AHGcr6TUATWBUeYKbe1NRdsIN1vwCqWwI9twx0RmcjhHfHdw0Q==
X-Received: by 2002:a05:6870:5b83:b0:409:5241:8abc with SMTP id
 586e51a60fabf-434f663d2e2mr14717326fac.20.1778511497575; 
 Mon, 11 May 2026 07:58:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435570ad92dsm10151263fac.2.2026.05.11.07.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:58:16 -0700 (PDT)
Date: Mon, 11 May 2026 08:58:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Chintan Vankar <c-vankar@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
Message-ID: <20260511145813.GG1858239@bill-the-cat>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <DIFPE908BASV.3P48QMSO3YZ7I@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ydeMXRyQE+uePpm"
Content-Disposition: inline
In-Reply-To: <DIFPE908BASV.3P48QMSO3YZ7I@ti.com>
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


--5ydeMXRyQE+uePpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 01:57:25PM +0530, Anshul Dalal wrote:
> On Thu May 7, 2026 at 2:57 PM IST, Jens Wiklander wrote:
> > Hi,
> >
> > This is a follow-up to Jerome's patchset [1], addressing previous feedb=
ack
> > regarding the monolithic nature of the driver update.
> >
> > The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven y=
ears
> > ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kern=
el
> > to u-boot"). Since then, not many kernel changes have been ported back =
into
> > U-Boot.
> >
> > This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide=
=20
> > a clear audit trail and maintain bisectability, I have structured the=
=20
> > series as follows:
> >
> > 1. Restore to Baseline: The first commit reverts U-Boot-specific change=
s=20
> >    to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 sta=
te.
> > 2. Milestone Imports: A sequence of 50+ commits follows, each performin=
g=20
> >    a "snapshot" import of the drivers/usb/dwc3 directory for every majo=
r=20
> >    kernel version (v3.19 through v6.16-rc7).=20
> > 3. U-Boot Adaptation: The final commits (based on Jerome's original wor=
k)=20
> >    re-introduce the necessary glue code, XHCI/UDC updates, and build fi=
xes=20
> >    required for U-Boot integration.
> >
> > The final diff is identical to [1]. I decided to stick with that for no=
w to
> > focus on the method of how we import or update the code.
> >
> > Note that this is compile-tested only. The CI pipeline on source.denx.de
> > was used as an OK/NOK indicator [2].=20
> >
> > The previous patchset was tested on xilinx_zynqmp_kria_defconfig and si=
nce
> > this diff is identical to the previous, it should still work on that
> > platform. With the help of a custom build script [3] and with an additi=
onal
> > patch [4], I could boot the Kria KV260 board and make it detect a USB S=
SD
> > plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> > platforms using the DWC3 driver are still OK, but at least there is some
> > hope. If this breaks your platform I'd like to know, and if you can sen=
d a
> > fix it's even better.
> >
> > I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. T=
here
> > were a few conflicts, even when backing out the original U-Boot patches=
 on
> > top of the original v3.19-rc1 import. However, the resulting state still
> > diverged significantly from [1].
> >
> > Instead, I've imported each new kernel in a separate commit. That way i=
t's
> > very clear which kernel patches are included. Since there aren't too ma=
ny
> > patches for each kernel I'm listing the relevant commits in the U-Boot
> > commit message for easier reference. I did this with a script so it's e=
asy
> > to make changes, if the approach is OK but we need to tune it. With this
> > approach it should be easy to tell if a Fixes patch for the kernel might
> > also be needed here.
>=20
> Hi Jens,
>=20
> Thanks for the work though I wasn't able to test out the series since it
> doesn't apply cleanly on master.
>=20
> Could you respin with a rebase?

For something this big and still RFC, perhaps a pointer to a public tree
is OK, until there's some substantive feedback from Marek?

--=20
Tom

--5ydeMXRyQE+uePpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagHugQAKCRAr4qD1Cr/k
CkAKAQCgktuAM6OXibiufnzI9LW8nzOzpvcV6SRRjvjbHJOnTgD8DM9wXKyJeLlo
VvGmAIc0AmRsknj9YxdVjvYSRvlO+AI=
=ZzIh
-----END PGP SIGNATURE-----

--5ydeMXRyQE+uePpm--
