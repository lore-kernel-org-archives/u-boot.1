Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D19FC531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 05:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C6156071B;
	Fri, 24 Jul 2026 05:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ir5DOLFmAF1c; Fri, 24 Jul 2026 05:15:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DC8260AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784870145;
	bh=0X8+rdtrEEzu0jVthV4qV07Wab6AWe+Y6rt1ZVVT8IM=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uxvJT1MKdqRBi8fzqlSedBejuKmE1Q26bLrboIsOYvaOS9Kjk4+3Ih4/w6Bonzu6J
	 xNB0PxW/cI956sJ8cvm8I57n10+M3QHWODc64uy9WEtxU1H6WJKcIu09un9upHUmwK
	 VUY/aDhJ/PJs1Rzf9mK2SEYVQON8i9auz2ZrVOxZoudEB5yRE1CRiGvHWfnzMFMlws
	 SNrmTJDntMENq6v3SjvT836B/HsC+hn7HohudgmUHh0wBfgomD5WY1GxNJggLloj1B
	 cfswqK1P7MBzEFF/Y6TaIJcd/Oqyf+k0OJ1FDB2uNJ6mmHXCIRTT4tdJJ2CXwjc2qM
	 Dt+cNQKFxaFOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DC8260AA9;
	Fri, 24 Jul 2026 05:15:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AFF3707
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CC0F40A8B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AEkbbVc7hCdp for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 05:15:43 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=romain.gantois@bootlin.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E6FED40A90
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6FED40A90
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6FED40A90
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:15:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49112803F6; Fri, 24 Jul 2026 07:15:39 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA56A800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 07:15:36 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 736891A11D7;
 Fri, 24 Jul 2026 05:15:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2887A60393;
 Fri, 24 Jul 2026 05:15:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D85D011C1187F; 
 Fri, 24 Jul 2026 07:15:24 +0200 (CEST)
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH v3 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
Date: Fri, 24 Jul 2026 07:15:24 +0200
Message-ID: <31ghNLzIQOah4QfwbFFCUw@bootlin.com>
In-Reply-To: <32d38204-8f6e-4a56-923e-b73b08eec87b@mailbox.org>
References: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
 <20260723-rzn1-usbf-v3-2-34dd7c4ddd99@bootlin.com>
 <32d38204-8f6e-4a56-923e-b73b08eec87b@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3CpWNK45Rg2uFzJSg1mt2Q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784870134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=0X8+rdtrEEzu0jVthV4qV07Wab6AWe+Y6rt1ZVVT8IM=;
 b=O3z4ryaHApwYjH18MnvR/0m347JzzIVxFgHgAWGGt4JSmlW3qS9m2MCoHfKmQ2awVq/SYl
 tvy+qNEPBkSEVfEm2wgrEm5V0h6vi6qFx0sjaR26YlP/bVKXvv2dMb19WZWG3QwpnwmGIu
 aSekRDh0iMwLVvUBAm+oBdEEbEghLniQ+qQLF+r+TuR7hXwepD02EaOt50lh5fBhIB3V/O
 eEpSvA/cjdL8IhMpESGIfIrp9pFn4T3B5qFNmtN8YqBI/C3ZDB8lNGM0VrOPNUVHM3zxfn
 E3JPwJyh9wHGLKOSQ1qS+vdgdcx7URgggqcWo7dHBmjz7xyb5NrlCYJslkj4DQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=O3z4ryaH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=romain.gantois@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="O3z4ryaH"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Romain Gantois via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Romain Gantois <romain.gantois@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

--nextPart3CpWNK45Rg2uFzJSg1mt2Q
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Date: Fri, 24 Jul 2026 07:15:24 +0200
Message-ID: <31ghNLzIQOah4QfwbFFCUw@bootlin.com>
In-Reply-To: <32d38204-8f6e-4a56-923e-b73b08eec87b@mailbox.org>
MIME-Version: 1.0

Hi Marek,

On Thursday, 23 July 2026 21:53:08 CEST Marek Vasut wrote:
> On 7/23/26 11:09 AM, Romain Gantois wrote:
> > From: Herve Codina <herve.codina@bootlin.com>
> >=20
> > Add support for the Renesas USBF controller. This is an USB2.0 UDC
> > controller available in the RZ/N1 SoC.
> >=20
> > This driver was originally written by Herv=C3=A9 Codina for the Linux k=
ernel.
> >=20
> > Linux revision this was ported from:
> >=20
> > 74851fbb6d64 ("usb: gadget: renesas_usbf: Handle devm_pm_runtime_enable=
()
> > errors")
> >=20
> > The following features were removed to reduce the memory footprint of t=
he
> >=20
> > driver, and to avoid including features not relevant to U-Boot:
> >   - Suspend/resume
> >   - Handling of endpoints > 2
>=20
> The code seems to handle 3 endpoints ?
>=20

Yes, I'm talking in terms of USB endpoint numbers here, so endpoints 0-2 ar=
e=20
handled.

> > +/* Only handle the first three endpoints for now. This is sufficient to
> > + * expose classic bootloader gadgets such as Fastboot or DFU.
> > + */
> > +#define USBF_NUM_ENDPOINTS	3
>=20
> But why not handle the additional endpoints ?
>=20

Because I didn't see a major use case for them in U-Boot, and removing thei=
r=20
handling allowed a reduction in code and program volume which seems relevan=
t=20
for U-Boot.

> Also, can you test whether 'ums 0 mmc 0.1,0.2,0' works to expose eMMC HW
> BOOT partitions and HW USER partition as three separate UMS devices over
> the same USB connection ?

Sure, I'll give it a try.

Thanks,

=2D-=20
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart3CpWNK45Rg2uFzJSg1mt2Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETFOGm0tqZfYwVxBymGofZEoxB4MFAmpi9OwACgkQmGofZEox
B4MdqA//YLLEAT1o1vuZT0yFWUM5GNY+lQ0oOEAtLQ1xuBFLYeBbR96F/CpvP/zL
E7QlAImvmAl9ZUypMyAL6hgP3uzEWps99ruRR3VJjnN09PW/1spiMzJLQZVlsLXT
vhGMupRz0tZBpU1cCqHrogcrhAHI50dtkEt73GabNb5cyXikX2un7LESXivx0vQ+
5JlBmplYKilPzC8T7kNyBWV6so7DY4FhPQKaxhQPFs73ogJErRwH+i2iFYRzc2ln
ov5DdiaUwrDCwil2cJ7ttcOw8OVZc03GCa2CcLHU+MzYU0beaz3ARiyXT6zqvHG+
FXS4+awYPDjzjSGM3wqAZm+grxSDekBF2xn1ykOirbj1rQVuusesuIYrBs03P/d+
CCZrPtOqJK5Kk60DPKy83yr3zkRE4Hcgw3Sd6He7rU+l2xyxDEyN5f3wDf2vdeYp
gjpWt5ak2JA7qCxaVh6JOqO9iEuZbvExi3UFwzCDtI9lN6ZJVG0jJJlYDfj5q3+t
skP4UZ+0NFrjDgdrL+CE8ldnXB29VNuo1JFMQp6JtQ+QFKWIAWYcSejAIKlRXQZb
VA0rjG4FXtsm6ZzeG/oHW53XEcxXF0PqCrt2vzbRE+F1JrfatHU2BwNYugUT+vmL
h8bjD645QcMHnnsb9nUreV4kUtl+Rza8WbUt629MwmDYyoDRhvM=
=jEp9
-----END PGP SIGNATURE-----

--nextPart3CpWNK45Rg2uFzJSg1mt2Q--



