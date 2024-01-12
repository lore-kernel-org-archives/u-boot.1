Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1788EC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 14:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 782C587947;
	Fri, 12 Jan 2024 15:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="xR1vwkA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1261F8269F; Fri, 12 Jan 2024 15:18:51 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9CB887947
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 15:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705069128;
 bh=krvC0GGu0sGrzww6NMcEaY4gMnc4/RAUMikSvAC2DSQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=xR1vwkA1rpre3qO5N6QZXZBqv0H/Dg6DvFxa75PmbAiOgttKecZMkHgrMy6WqgjLV
 QbYGiqmlRlZKRWkgibKrD3JYkuijBwVr4pOIz9QWgqqOIByKF5OsDxO/QKJ28Hr5LL
 yDkccgWTBz8oiYQ1OwEZ19jei/TsBjd4AozbcK+qVIaNTxZuqsD8HlLTDmeesuu4eT
 nQvnCm4EcJdza4GW23fGAuDNrYPTTUWmeRXFdxc1kKFcYKfF/cjfOhXXFIaFkDMDxI
 Wo1qXksitAT/ABixXwBdOzFuF8lzjvriOTxWPWJxGHwfH8ngxkbA6POWUjDTh3gofA
 CGKjlP6NhutuQ==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E95593780624;
 Fri, 12 Jan 2024 14:18:47 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 6BEC49F0AE8F; Fri, 12 Jan 2024 15:18:47 +0100 (CET)
Message-ID: <289be181c4bb9805172cfb6908bbc6f969f79494.camel@collabora.com>
Subject: Re: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
From: Sjoerd Simons <sjoerd@collabora.com>
To: Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Nishanth Menon <nm@ti.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Igor Prusov
 <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,  Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>
Date: Fri, 12 Jan 2024 15:18:47 +0100
In-Reply-To: <1fea7f2d-62af-44f5-bcfd-2a7e3fd33ca6@kernel.org>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-3-sjoerd@collabora.com>
 <5444e6d5-f928-4f46-9af9-2c07c8b49f4f@kernel.org>
 <80d49aa7dd463700d98d5b2d74b7df35b6ed1d88.camel@collabora.com>
 <1fea7f2d-62af-44f5-bcfd-2a7e3fd33ca6@kernel.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
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

On Fri, 2024-01-12 at 14:56 +0200, Roger Quadros wrote:
>=20
>=20
> On 12/01/2024 13:06, Sjoerd Simons wrote:
> > On Fri, 2024-01-12 at 12:39 +0200, Roger Quadros wrote:
> > >=20
> > >=20
> > > On 12/01/2024 10:52, Sjoerd Simons wrote:
> > > > When dr_mode is "otg" the dwc3 is initially configured in _OTG
> > > > mode;
> > > > However in this mode the gadget functionality doesn't work
> > > > without
> > > > further configuration. To resolve that on gadget start switch
> > > > to
> > > > _DEVICE
> > > > mode globally and go back to _OTG on stop again.
> > > >=20
> > > > For this the dwc3_set_mode is renamed to dwc3_core_set_mode to
> > > > avoid a
> > > > conflict with the same function exposed by xhci-dwc3
> > >=20
> > > Aren't they both doing the same thing? I'd rather define them at
> > > one
> > > place
> > > i.e. dwc3/core.c.
> >=20
> > They twiddle the same registers afaict indeed; but the way to get
> > there
> > is rather different. So having just one for both really needs a
> > bigger
> > amount of rework.
> >=20
> > > The driver model design for dwc3 looks really broken in u-boot.
> > >=20
> > > "snps,dwc3" is claimed by xhci-dwc3.c instead of being claimed by
> > > dwc3/core.c.
> > > This is probably because at the time USB host was the more needed
> > > use
> > > case at u-boot.
> > >=20
> > > Ideally dwc3/core.c should claim "snps,dwc3" device and
> > > instantiate
> > > the respective Host/Device/OTG device based on the provided otg
> > > mode.
> > >=20
> > > For Host/Device mode it is straight forwa
> > > dwc3/core.c does dwc3_set_mode() depending on the mode and:
> > > for host mode -> register xhci-usb driver.
> > > for device mode -> register UDC device driver.
> > >=20
> > > For dual-role mode, the solution is not very clear as I don't
> > > think
> > > there is a role switch framework present
> > >=20
> > > To begin with, we could probably restrict it to just device mode
> > > as most platforms were forcing it to device mode in any case as
> > > they
> > > usually have a 2nd USB port that is host only.
> >=20
> > Right we don't have role switching; And if we had we'd have to add
> > support of the Type-C controller on the SK boards which determines
> > the
> > roles for this.
> >=20
> > This one more minimal patch was modelled after the discussion last
> > year
> > around otg mode[0]. And similar to how the cdns3 driver handles it.
> > Essentially letting host/gadget mode be determined by the usage
> > rather
> > then the cables plugged, which is not pretty but works.
> >=20
> > While I agree with you this could all be a lot nicer of u-boot did
> > "proper" OTG/role-switching; I unfortunately don't have the
> > bandwidth
> > to introduce all of that and it seems a shame to block DFU support
> > on
> > it. For reference my previous series just set the peripheral role
> > in
> > the dts which reflects your suggestion of forcing device mode. I'd
> > be
> > wary to do so in the driver because i would hope the OTG handling
> > in
> > dwc3 is there for a reason :)=20
> >=20
> >=20
> > 0: https://lists.denx.de/pipermail/u-boot/2023-August/527709.html
> >=20
> >=20
>=20
> In your current series, how does it work?
> What happens if user starts both host and device controllers?

Testing host functionality on the same port as used for DFU (the only
one that's otg) doesn't seem to work at all, not sure why that is. host
on usb1 (usb-a port, host only) works fine ofcourse.

practically however once the user has used a gadget it's likely they'd
have to reset the host side (or at least do a rescan) though as likely
they'll have also switched around the cable :).

>=20
> e.g.
> > usb start
> > dfu 0

That seems to work fine, modulo usb0 not seeing attached devices, but
that's not a regression introduced by this patch.



--=20
Sjoerd Simons
Collabora Ltd.
