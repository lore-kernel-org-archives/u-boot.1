Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F24DCD37AB
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 18:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BBC588BBE;
	Tue,  3 Sep 2024 20:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OuUbae1/";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="eGYDMAA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D63887EB; Tue,  3 Sep 2024 20:21:36 +0200 (CEST)
Received: from a7-47.smtp-out.eu-west-1.amazonses.com
 (a7-47.smtp-out.eu-west-1.amazonses.com [54.240.7.47])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6006288B59
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 20:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020191b91ed9f8-91d9bf06-f542-486b-a927-7298c41db575-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725387692;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=t3zv2+3KXGyel8ss2XrgnTw2HTKuxYxgcEL/sbwS+yM=;
 b=OuUbae1/q1xX5v7Y2QZusxnrqWxFa8d9xIPM414bGvVrusnnhqijNVJcqItMn4yx
 IdtCi7mOol4JI2B8L9+bTaBZep1raVSTDSFPDu48Hjju+6zOYil8aQ69Cuieh16o7I+
 uYkFf/jZJK57xEG/1euwL9mqsnoEUhOerOoIOLNvYNjVuhDP5gWRX5qT7KnbIrrbVQ2
 9ZUWFnfV5PfyIUWmZ2WV7E7tnrgUF67chjfhzrhW5e2F6sK02FIZNYsSZ+uHQYkVGTU
 hxAc81Ez61tpOA8azmW1uX9N33+lnsWBmU9P1kmQvSjZ2xxMrjVGc25D9UTMjY+c6cw
 99tsnuJoqg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725387692;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
 bh=t3zv2+3KXGyel8ss2XrgnTw2HTKuxYxgcEL/sbwS+yM=;
 b=eGYDMAA/IfQIE45Ytyd6wPiHu22Eys72g5tI1eOXjp8NeN7iDkxhwnG3pBpwEqZr
 BCDYiIJu0+gQnRY/B3H5M5ZnhfE117ij9mAMYIpGZL+LVeNj3gDUvJLBMinXOegAC8U
 FajIGiE62EpGv7NyBQhfI/nhxqjDQmBtnLdWknqQ=
Date: Tue, 3 Sep 2024 18:21:32 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?B?U8O2cmVu?= Moch <smoch@web.de>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 0/6] FUSB302 USB-C controller support
Message-ID: <01020191b91ed9f8-91d9bf06-f542-486b-a927-7298c41db575-000000@eu-west-1.amazonses.com>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
 <420b6d01-d081-4a6a-a9b7-219d8806099a@web.de>
 <8489a7f6-32ab-4908-818e-ee1119aa0bad@web.de>
 <ac68f59d-7b75-4d08-90e1-ac9a62d9c55c@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n6m3fsjllkqif7fj"
Content-Disposition: inline
In-Reply-To: <ac68f59d-7b75-4d08-90e1-ac9a62d9c55c@web.de>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.03-54.240.7.47
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


--n6m3fsjllkqif7fj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 03, 2024 at 03:42:51PM GMT, S=F6ren Moch wrote:
> On 03.09.24 13:00, Soeren Moch wrote:
> > Hi Sebastian,
> >=20
> > On 31.08.24 15:36, Soeren Moch wrote:
> > [...]
> > > Unfortunately I see the same problem as in v3: boot loop when powering
> > > the board from my notebook (ThinkPad X1 Nano running Ubuntu 24.04.1
> > > LTS),
> > > see boot log below.
> > >=20
> > > Patch version v2 is still running totally fine in the exact same setup
> > > (patch series on top of u-boot 2024.07, same board, same cabling).
> > >=20
> > > Unfortunately I currently have no access to the miniPC (Zotac ZBOX
> > > CI620)
> > > I used as additional test platform before.
> > >=20
> > > The boot log is unfortunately not very helpful. If you provide an
> > > additional
> > > patch enabling more debug output, I'm happy to retest with that (v2
> > > and/or v4).
> >=20
> > Here additional debug messages for the not working case (LOG_DEBUG
> > enabled):
> >=20
> > U-Boot 2024.07-00006-g65a73892d9-dirty (Sep 03 2024 - 12:22:42 +0200)
> >=20
> > Model: Radxa ROCK 5 Model B
> > DRAM:=A0 8 GiB
> > fusb302 usb-typec@22: set pd RX off
> > fusb302 usb-typec@22: vconn is already off
> > fusb302 usb-typec@22: TCPM: set polarity =3D 0
> > fusb302 usb-typec@22: pd header : sink, device
> > fusb302 usb-typec@22: TCPM: state change INVALID_STATE -> SNK_UNATTACHED
> > fusb302 usb-typec@22: TCPM: Start toggling
> > fusb302 usb-typec@22: TCPM: state change SNK_UNATTACHED -> TOGGLING
> > fusb302 usb-typec@22: get cc1 =3D open, cc2 =3D open
> > fusb302 usb-typec@22: TCPM: CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING,
> > polarity 0, disconnected]
> > fusb302 usb-typec@22: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
> > fusb302 usb-typec@22: IRQ: VBUS_OK, vbus=3DOn
> > fusb302 usb-typec@22: IRQ: 0x01, a: 0x40, b: 0x00, status0: 0x82
> > fusb302 usb-typec@22: IRQ: TOGDONE
> > fusb302 usb-typec@22: get cc1 =3D rp-1.5, cc2 =3D open
> > fusb302 usb-typec@22: TCPM: CC1: 0 -> 4, CC2: 0 -> 0 [state TOGGLING,
> > polarity 0, connected]
> > fusb302 usb-typec@22: TCPM: state change TOGGLING -> SNK_ATTACH_WAIT
> > fusb302 usb-typec@22: TCPM: pending state change SNK_ATTACH_WAIT ->
> > SNK_DEBOUNCED @ 200 ms [rev1]
> > fusb302 usb-typec@22: detected cc1=3Drp-1.5, cc2=3Dopen
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0xc2
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0xd1
> > fusb302 usb-typec@22: cc1: rp-1.5 -> rp-def
> > fusb302 usb-typec@22: get cc1 =3D rp-def, cc2 =3D open
> > fusb302 usb-typec@22: TCPM: CC1: 4 -> 3, CC2: 0 -> 0 [state
> > SNK_ATTACH_WAIT, polarity 0, connected]
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: cc1: rp-def -> rp-1.5
> > fusb302 usb-typec@22: get cc1 =3D rp-1.5, cc2 =3D open
> > fusb302 usb-typec@22: TCPM: CC1: 3 -> 4, CC2: 0 -> 0 [state
> > SNK_ATTACH_WAIT, polarity 0, connected]
> > fusb302 usb-typec@22: TCPM: state change SNK_ATTACH_WAIT ->
> > SNK_DEBOUNCED [delayed 200 ms]
> > fusb302 usb-typec@22: TCPM: state change SNK_DEBOUNCED -> SNK_ATTACHED
> > fusb302 usb-typec@22: TCPM: set polarity =3D 0
> > fusb302 usb-typec@22: pd header : sink, device
> > fusb302 usb-typec@22: TCPM: state change SNK_ATTACHED -> SNK_STARTUP
> > fusb302 usb-typec@22: TCPM: state change SNK_STARTUP -> SNK_DISCOVERY
> > fusb302 usb-typec@22: TCPM: set vbus =3D 0 charge =3D 1
> > fusb302 usb-typec@22: TCPM: state change SNK_DISCOVERY ->
> > SNK_WAIT_CAPABILITIES
> > fusb302 usb-typec@22: set pd RX on
> > fusb302 usb-typec@22: TCPM: pending state change SNK_WAIT_CAPABILITIES
> > -> SOFT_RESET_SEND @ 310 ms [rev3]
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: PD sent good CRC
> > fusb302 usb-typec@22: Received PD message (header=3D0x17a1 len=3D4)
> > fusb302 usb-typec@22: TCPM: PD RX, header: 0x17a1 [1]
> > fusb302 usb-typec@22: TCPM: state change SNK_WAIT_CAPABILITIES ->
> > SNK_NEGOTIATE_CAPABILITIES
> > fusb302 usb-typec@22: TCPM: cc=3D0 cc1=3D4 cc2=3D0 vbus=3D0 vconn=3Dsin=
k polarity=3D0
> > fusb302 usb-typec@22: TCPM: PD TX, header: 0x1082
> > fusb302 usb-typec@22: Send PD message (header=3D0x1082 len=3D4)
> > fusb302 usb-typec@22: IRQ: 0x41, a: 0x04, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: PD tx success
> > fusb302 usb-typec@22: Received PD message (header=3D0x161 len=3D0)
> > fusb302 usb-typec@22: TCPM: PD TX complete, status: 0
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: PD sent good CRC
> > fusb302 usb-typec@22: Received PD message (header=3D0x9a3 len=3D0)
> > fusb302 usb-typec@22: TCPM: PD RX, header: 0x9a3 [1]
> > fusb302 usb-typec@22: TCPM: state change SNK_NEGOTIATE_CAPABILITIES ->
> > SNK_TRANSITION_SINK
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: PD sent good CRC
> > fusb302 usb-typec@22: Received PD message (header=3D0xba6 len=3D0)
> > fusb302 usb-typec@22: TCPM: PD RX, header: 0xba6 [1]
> > fusb302 usb-typec@22: TCPM: state change SNK_TRANSITION_SINK -> SNK_REA=
DY
> > fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: PD sent good CRC
> > fusb302 usb-typec@22: Received PD message (header=3D0x1daf len=3D4)
> > fusb302 usb-typec@22: TCPM: PD RX, header: 0x1daf [1]
> > fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: 0x41, a: 0x00, b: 0x01, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: PD sent good CRC
> > fusb302 usb-typec@22: Received PD message (header=3D0x1faf len=3D4)
> > fusb302 usb-typec@22: TCPM: PD RX, header: 0x1faf [1]
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x93
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x93
> > fusb302 usb-typec@22: cc1: rp-1.5 -> rp-3.0
> > fusb302 usb-typec@22: get cc1 =3D rp-3.0, cc2 =3D open
> > fusb302 usb-typec@22: TCPM: CC1: 4 -> 5, CC2: 0 -> 0 [state SNK_READY,
> > polarity 0, connected]
> > fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: cc1: rp-3.0 -> rp-1.5
> > fusb302 usb-typec@22: get cc1 =3D rp-1.5, cc2 =3D open
> > fusb302 usb-typec@22: TCPM: CC1: 5 -> 4, CC2: 0 -> 0 [state SNK_READY,
> > polarity 0, connected]
> > fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
> > fusb302 usb-typec@22: IRQ: PD sent good CRC
> > fusb302 usb-typec@22: Received PD message (header=3D0x11af len=3D4)
> > fusb302 usb-typec@22: TCPM: PD RX, header: 0x11af [1]
> > fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x93
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x93
> > fusb302 usb-typec@22: cc1: rp-1.5 -> rp-3.0
> > fusb302 usb-typec@22: get cc1 =3D rp-3.0, cc2 =3D open
> > fusb302 usb-typec@22: TCPM: CC1: 4 -> 5, CC2: 0 -> 0 [state SNK_READY,
> > polarity 0, connected]
> > fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
> > fusb302 usb-typec@22: TCPM: state change SNK_READY ->
> > SNK_WAIT_CAPABILITIES
> > fusb302 usb-typec@22: set pd RX on
> > fusb302 usb-typec@22: TCPM: pending state change SNK_WAIT_CAPABILITIES
> > -> HARD_RESET_SEND @ 310 ms [rev3]
> > fusb302 usb-typec@22: TCPM: state change SNK_WAIT_CAPABILITIES ->
> > HARD_RESET_SEND [delayed 310 ms]
> > fusb302 usb-typec@22: TCPM: PD TX, type: 0x5
> > fusb302 usb-typec@22: IRQ: 0x41, a: 0x08, b: 0x00, status0: 0x93
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x93
> > fusb302 usb-typec@22: IRQ: PD hardreset sent
> > fusb302 usb-typec@22: TCPM: PD TX complete, status: 0
> > fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x83
> > fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
> > fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x83
> > <Reset>
> >=20
> We already reached SNK_READY state, so everything should be fine and
> finished.
> But additional communication seams to cause a HARD_RESET sent by us, lead=
ing
> to a boot loop.
>=20
> Seems to me we are not prepared for communication with port partners capa=
ble
> of source and sink power roles. Just a guess, though.

I found two regressions in the code introduced in PATCHv3. After
fixing them I got the Ravpower Powerbank working again. I will send
PATCHv5 directly after this mail. By quickly going through your log,
I think you also run into the polarity issue.

-- Sebastian

--n6m3fsjllkqif7fj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbXU6MACgkQ2O7X88g7
+pogoA//dG9qh5dkzOR0/9p9E5rqXIFm+mJixBzcqFfrOA4ji9dwnQYyvn1uvMOu
K0q4o2N5x8Ky7wXEt0CqC949f9f2mi4DHIFntvUAzxUZHN+vLOoQUmR3qbt/6jVh
WEUqEA6BS/HQVKtf7c/YGaMMD0ntUhavJhap2xcSEPxbKEOxg1GgId2yUOAincMQ
dlB3NhJoEM6axgacS7nbWZI4z25hwGvA36QRiEdC/42Zs7B001+SG52IqwIkO8Wy
fWRGFfndtbMB/EACAmzXd9QN/zQ3zGwiq/rWtiPtHUij792EDv15zDiKh0cFMHfn
LLCW+C/qKG4an4EbtJpEoc031uoQOWQoiVCe8jZD1I/xyUnJpRyh1WtiRTx5Lo00
MnBMZQw6/D8UcFLtRNS9jezgfqNzo6Wbl3BIzM2PKVR1Rmg13d38mtJVelGdHQp3
JaMtfBZMIOo1DLHDy8HADulw5yeK6v1aHsOtDCbDg/tJQFjRdU4wqWMkwHYkw5gL
L9gyNkpB7P77yOth+lmS/ZY3FgTWC8/jHrMCjmV+6USL2FLE6fOB3aq8Ufj29NPg
KfBowMxWBioAWaKIXcKkLtwbc7C5tbCVst3vTeUwturDmiRifQcv7POKDF2NNGTm
1+prblGRqNzgwe1VFA4K/+TFcfEoBufuTxfNyusV0GeAk1k3C6Y=
=mdSP
-----END PGP SIGNATURE-----

--n6m3fsjllkqif7fj--
