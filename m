Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C29FA3724
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 00:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD86A83BB1;
	Fri,  2 Jan 2026 01:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBA183CDC; Fri,  2 Jan 2026 01:40:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 069EF83B91
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 01:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD91497;
 Thu,  1 Jan 2026 16:40:47 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DBA33F694;
 Thu,  1 Jan 2026 16:40:52 -0800 (PST)
Date: Fri, 2 Jan 2026 01:39:34 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Jagan Teki <jagan@amarulasolutions.com>, Tom
 Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Paul
 Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 06/10] gpio: a733: add initial support
Message-ID: <20260102013934.240a8ad4@minigeek.lan>
In-Reply-To: <20251130222004-GYA1814866@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-6-18bdd4376fad@gentoo.org>
 <CAOMZO5BG63ndAg7yTdMtBi7nHQjCGcrS9Sr0M5XfAiBkrC-oAA@mail.gmail.com>
 <20251130222004-GYA1814866@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 1 Dec 2025 06:20:04 +0800
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> Hi Fabio,
>=20
> On 19:09 Sun 30 Nov     , Fabio Estevam wrote:
> > On Sun, Nov 30, 2025 at 6:47=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wro=
te:
> >  =20
> > > +config SUNXI_NEW2_PINCTRL =20
> >=20
> > This name is not very descriptive.
> >=20
> > What about SUNXI_A733_PINCTRL? =20
>=20
> I'm open to this, but want to know Andre's suggestion about this,
>=20
> The idea here I've chose a common one which follow old convention
> and hope to re-use in future generation SoC..

Yeah, NEW2 was more a working title than a proper name, but predicting a
better one is tricky. And also the new layout is only valid for the
first pin controller in this SoC, something we don't know of if it will
stay this way for future generations.

So I say we go with SUNXI_A733_PINCTRL, and use the
CONFIG_MACH_SUN60I_A733 symbol to denote the special arrangement for
the secondary controller.

Cheers,
Andre

