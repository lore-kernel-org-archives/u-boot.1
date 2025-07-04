Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCE9C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 15:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC0A82CFA;
	Fri,  4 Jul 2025 17:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="aY9iOJkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD8C8206E; Fri,  4 Jul 2025 17:05:10 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE5C803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 17:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=analog@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751641506; x=1751900706;
 bh=VZu++WlM+TLN1JEZvOjtC0zGgrp650djQxyQ/EG4qEI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aY9iOJkLDOJti3dloyS0pVLpAzCeotxWmLSfrdgWW+eCIsnSYuyCDtbwHHDKQ3QUL
 k2TadBVVm8v0jTRI9iYZrnAinh70fQHTA10FeBg1LygkONW7ZXGAX7nKWk5VtV2gDE
 s92U1IpR6deZtdt0caw/qHpadp0HMHJ+hTmmDPZIDCDiNntMxAjrfDHeaV1j2hTELM
 f45z45Eo/uOoidEoZj7GyfSx1qA/iFyPxQi1OeKABSx3BedohOpDuLd0FmfZNvYbIE
 Uqu0oG8OwiLlwPNeOaMarOWyWACs2mpHOjJPEOO/SkHei3ABntPDcjHlX8J9ov+1Oa
 LHwmJ+EWzbk4g==
Date: Fri, 04 Jul 2025 15:04:59 +0000
To: Greg Malysa <malysagreg@gmail.com>, u-boot@lists.denx.de
From: Philip Molloy <analog@philipmolloy.com>
Cc: adsp-linux@analog.com, Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH 08/10] board: adi: Add support for SC598
Message-ID: <ec9cf50848f43349e73acbbe34ddcfcb1448d406.camel@philipmolloy.com>
Feedback-ID: 149422483:user:proton
X-Pm-Message-ID: 947ee5eb857f365f937cb2d2668fea869aea5a20
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 04 Jul 2025 17:56:42 +0200
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

On Mon, 2025-06-02 at 15:44 -0400, Greg Malysa wrote:
> > =C2=A0&clk {
> > =C2=A0 compatible =3D "adi,sc598-clocks";
> > =C2=A0 reg =3D <0x3108d000 0x1000>,
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x3108e000 0x1000>,
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x3108f000 0x1000>,
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x310a9000 0x1000>;
> > + <0x3108e000 0x1000>,
> > + <0x3108f000 0x1000>,
> > + <0x310a9000 0x1000>;

Could it be that everything is indented with 4 space tabs rather than 8?

> > + gpio_expander1: mcp23018@20 {
> > + compatible =3D "microchip,mcp23018";

It looks like this corresponds to Rev D of the SOM. There is a Rev E of the=
 SOM with a adi,adp5588 like on the ezlite and a 1Gb SPI flash. I imagine R=
ev D is no longer being manufactured, but I'm waiting to hear back internal=
ly at ADI. Changes for Rev E can be made in another series, but it might be=
 nice to add a `Link: <...>` to the schematics in the commit message so it =
is clear which revision this corresponds to.

> > + uart0 {
> > + gpio-hog;
> > + gpios =3D <5 GPIO_ACTIVE_HIGH>;

It looks like the PI3C3125 bus switch has active LOW enables. That would ex=
plain why `output-low` and GPIO_ACTIVE_HIGH result in a functional UART.

> > + output-low;
> > + line-name =3D "~uart0-en";

I couldn't find any other examples of ~ being used as a prefix for `line-na=
me` in U-Boot or in the Kernel.

> > + bootph-pre-ram;

Unfortunately, SPL doesn't currently configure the GPIO expander before usi=
ng the UART so there is no output until U-Boot proper is booted. I did a li=
ttle JTAG debugging and neither the GPIO expander was probed, nor the ADI I=
2C driver.

By probing before the bus switch I could see the following getting output:

U-Boot SPL 2025.07-rc4 (Jul 04 2025 - 13:31:08 +0200)
ADI Boot Mode: 0x0 (JTAG/BOOTROM)

Unfortunately, the ADI UART driver does not support DEBUG_UART. I also trie=
d adding devicetree entries for uart2 (which is routed to the carrier board=
) without luck.

Ideally, this would be documented somewhere, otherwise anyone booting SPL o=
ver JTAG may think something is wrong.
