Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3215FC369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 21:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C84826B2;
	Mon, 14 Apr 2025 23:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="RUdqrl2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212BD8272A; Mon, 14 Apr 2025 23:00:54 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68672826AD
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 23:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4ACCC1F940;
 Mon, 14 Apr 2025 23:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1744664450;
 bh=dZfj5/VFXKyTcSVKHxRD+U1zd+QWTGOSzODdjxD9tZg=; h=From:To:Subject;
 b=RUdqrl2uV1yVnhHHZT8SbtNEcj0dA2IQXkx8IGFbUS3lDeIuisv6t3tYWg/rYz12E
 JfrY9FE8fLvGvD50/29+VFebGgRKNOWEyKs97GJQanxCdqp43Fe+xCQF6zlunPBuwp
 HjWcg5KNipAhLaPm01t+2f95kLutlFFdmCEC8Ko53JWN6YYXhH2W6VGSRLVmCwOO3k
 7ZRZ2thrK0xs+Fl5YXHCbVQwoHnEByB0uuJhMPE2fUuCL/OK0r0EXwQ5bglaXpc2BF
 g+iBL+tBMmW6sVWihvzer57en5cz4DmzDgW0ibTBP7pvNpxGY7PXOzNBazLahvNXcI
 HoNCnD7PGNVnw==
Date: Mon, 14 Apr 2025 23:00:41 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, "Francis, Neha" <n-francis@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
Message-ID: <20250414210041.GA8754@francesco-nb>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable>
 <20250414200635.GC5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414200635.GC5495@bill-the-cat>
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

On Mon, Apr 14, 2025 at 02:06:35PM -0600, Tom Rini wrote:
> On Mon, Apr 14, 2025 at 01:07:27PM -0500, Nishanth Menon wrote:
> > On 23:06-20250414, Francis, Neha wrote:
> > > On 4/3/2025 1:09 PM, Miquel Raynal wrote:
> > > > It is very surprising that such an uclass, specifically designed to
> > > > handle resources that may be shared by different devices, is not keeping
> > > > the count of the number of times a power domain has been
> > > > enabled/disabled to avoid shutting it down unexpectedly or disabling it
> > > > several times.
> > > > 
> > > > Doing this causes troubles on eg. i.MX8MP because disabling power
> > > > domains can be done in recursive loops were the same power domain
> > > > disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> > > > timings to respect and it is easy to produce a race condition that puts
> > > > the power domains in an unstable state, leading to ADB400 errors and
> > > > later crashes in Linux.
> > > > 
> > > > CI tests using power domains are slightly updated to make sure the count
> > > > of on/off calls is even and the results match what we *now* expect.
> > > > 
> > > > As we do not want to break existing users while stile getting
> > > > interesting error codes, the implementation is split between:
> > > > - a low-level helper reporting error codes if the requested transition
> > > >   could not be operated,
> > > > - a higher-level helper ignoring the "non error" codes, like EALREADY and
> > > >   EBUSY.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > 
> > > This commit looks to be breaking K3 platforms boot, please see "Latest Boot
> > > Summary" [0]. Reverting the commit fixes boot.
> > > 
> > > [0] https://lcpd.itg.ti.com/upstream/k3-boot-build/main/build-trends.html
> > 
> > Uggh. This link is a TI internal link. Nutshell, it is broken
> > between:
> > v2025.04-921-gcb7555e93075 : https://source.denx.de/u-boot/u-boot.git
> > and
> > v2025.04-1041-g407d68638fe3 : https://source.denx.de/u-boot/u-boot.git
> > 
> > Neha bisected it down to 197376fbf300e92afa0a1583815d9c9eb52d613a commit
> > which is this patch.
> 
> And assuming it's the same failure I got reported this morning by one of
> my coworkers, we just get:
> U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')

I have not tried reverting that commit yet, but I do have the same
failure.

Francesco

