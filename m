Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517FAC83F17
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 17:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00FFB864AA;
	Wed, 30 Aug 2023 19:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="FHhphKz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C14864D7; Wed, 30 Aug 2023 19:53:43 +0200 (CEST)
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E56B803AB
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
Date: Wed, 30 Aug 2023 17:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1693418018; x=1693677218;
 bh=gaG7VuiuzeBoCrlddmGSrxFjPIdkHsg1kk6y2rsdpJ8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FHhphKz1hvI2qBXyszqDvoXPPB4cvftqd74i4Btt93ojsZC+OUHQ8YjLHe+ONSE3z
 fA1j6Eb5XlkKptW57MtE141YMNjrbQyIKE+BbtdQA/13zqL10UzIVJvbkchbpUqUZt
 00QmdfcpBcJAAFXmd8Hjbv/bkWkxEnEbExXYa27Jx+B5ELSLmN641hZmhjHPFE0gQF
 U2hihEGaOIpS30XiFjYAAcO18KFNuZYbdirk77kETCAvbdYWxGvMVvAOyV2DpfJRfh
 ZYmxLTJ+UN3KorQ2MFTlQ3QwI0bvHG9Ffr3fqo11HtGo/Mb/vKd1Xi4+uP754zatX7
 1MVGp03ggC8Xg==
To: sjg@chromium.org
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: christianshewitt@gmail.com, mark.kettenis@xs4all.nl, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org,
 alpernebiyasak@gmail.com, neil.armstrong@linaro.org, da@lessconfused.com
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce
 the image
Message-ID: <CV61D7ULLVZ0.3OCFZ743L1KSE@flaptop>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

> So I wonder how best to move this forward so that we can build things
> using binman and everything works?

It's still not ready yet, but I'm working on porting U-Boot SPL to some
Amlogic SoCs [1]. I'm currently working on Amlogic S905 boards, but
eventually I'll work on Amlogic S905X devices too. And speaking of
signing, Jonas Karlman wrote amlimage, and integrated it into mkimage,=20
and I applied his patch to my tree. There's a few things to be aware of=20
about Amlogic signing and binaries in general, however.

amlimage was intended for use with U-Boot SPL, which obviously has=20
no support for Amlogic's FIP format and as such amlimage will only do as=20
little as possible to get the bootROM to load U-Boot SPL. Most of the=20
packaging format is handled by BL2. The fact that the signing process is
completly different across SoC generations makes it difficult to
implement them all into one single tool (and by which I mean all of it,
not just signing BL2 for the bootROM to run it, that's mostly the same
across SoCs). amlimage has been confirmed to work on GXBB (ODROID-C2 and
the KII Pro set-top box), GXL (librecomputer lepotato), and SM1 (ODROID-C4)=
.

My U-Boot SPL port is still rather incomplete. As of today, it still
can't boot anything from any storage device. The goal eventually is to
be able to load upstream TF-A BL31 and U-Boot+linux.

While Amlogic distributes proprietary BL31 binaries upstream Trusted=20
Firmware-A has a port for some Amlogic SoCs [2], but as far as I know=20
SM1 (which is the SoC generation your ODROID-C4 is using) is still
unsupported. GXBB, GXL, AXG, and G12A are all supported however, but the
overall port still lacks some features the proprietary implementation
has.

As for the SCP firmware (aka. BL30) I'm not aware of any
reverse-engineering efforts for that.

Honestly, in my opinion, including proprietary and poorly-written=20
Amlogic utilities lacking a proper license, into U-Boot looks like a bad id=
ea.

[1]: https://git.vitali64.duckdns.org/misc/u-boot-kii-pro.git/log/?h=3Dwip/=
spl
[2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/=
amlogic

Cheers.

