Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFADEE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 08:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9F087015;
	Mon, 21 Aug 2023 10:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="isHOYRnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9464287015; Mon, 21 Aug 2023 10:40:04 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28AE86FAA
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 10:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01A2BE0011;
 Mon, 21 Aug 2023 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1692607201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yFKq+Vv7xR2IutP1CjWq+ZQWpr9L6l97o+Ycmw50Qo=;
 b=isHOYRnA3lOg2lkbwUr+DfHa0qjbFCrGC2g72URU4eznBmR6ZyYQLxGrK+QVg6J9Sb3mVZ
 OQzHw+2XkDZAhWjNtGdTobMeuABYnlXWslsLpGxi8TWMQ6u1iz5k/DaAbIjIyUgly2PRJX
 hHyFsuNSb6TY8BRtXMegKwPselk3NHsPV9AHBjrwWQUlAoBJYAZMM5pZBUKGmxQm2Q2Rx4
 2HhcRWo+cZRFtrpShm5ey264QZs2Jh8atOyxo8OqV55fvDcrTksjvZRAwkSYQV16Hmc83e
 4yO5ERG1tzNDhe3j3+o2lOnJZW0ecJIs8T55GCoKojzSWaKzBPQSQVypUQOTOA==
Date: Mon, 21 Aug 2023 10:39:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev
 <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH 01/17] dm: usb: udc: Factor out plain udevice handler
 functions
Message-ID: <20230821103957.40bc8ad1@xps-13>
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Marek,

marex@denx.de wrote on Sat, 19 Aug 2023 16:23:51 +0200:

> Pull the functionality of UDC uclass that operates on plain udevice
> and does not use this dev_array array into separate functions and
> expose those functions, so that as much code as possible can be
> switched over to these functions and the dev_array can be dropped.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---

Would you mind adding a cover letter to your series? It would be easier
for us to (a) know what is the final purpose of the series and (b) have
a location where to send global feedback.

Indeed, I did not yet investigate, in particular because every time
fastboot is broken I cannot easily test new images without going
through a whole recovery step with another image, but it seems like the
network over USB is no longer working (not 100% sure about that one,
sometimes the network is capricious) and anyway just calling unbind
crashes:

=3D> dm tree
[...]
 misc          0  [ + ]   ti-musb-wrapper       |   |-- usb@47400000
 usb           0  [ + ]   ti-musb-peripheral    |   |   |-- usb@47401000
 ethernet      1  [ + ]   usb_ether             |   |   |   `-- usb_ether
 bootdev       3  [   ]   eth_bootdev           |   |   |       `-- usb_eth=
er.bootdev
 usb           0  [   ]   ti-musb-host          |   |   `-- usb@47401800
=3D> unbind ethernet 1
data abort
pc : [<9ff9a0e6>]          lr : [<9ff9a0e7>]
reloc pc : [<808350e6>]    lr : [<808350e7>]
sp : 9df2f998  ip : 0000001c     fp : 00000003
r10: 9df4d800  r9 : 9df44ea0     r8 : 9ffe4a0c
r7 : 9ff82ad9  r6 : 9df4d800     r5 : 84000000  r4 : 9df4cf48
r3 : 9ff9a0e1  r2 : 00000000     r1 : 00000000  r0 : 00000000
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32 (T)
Code: 9ffd b508 f7ec fe63 (f8d0) 00b0=20
Resetting CPU ...

Thanks,
Miqu=C3=A8l
