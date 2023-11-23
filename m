Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F304DC61DF7
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B60C87600;
	Thu, 23 Nov 2023 14:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JZ7+fD3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C4987499; Thu, 23 Nov 2023 14:12:38 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73CB87654
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EE3C1C0002;
 Thu, 23 Nov 2023 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1700745155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDiYAyihz6+ICKf+I5+bIqYux5lZok3a5Dp1gOHjfWE=;
 b=JZ7+fD3Dk0gVgj6uSkX5rY+QDVmUdK1Ub/0+RPDvnZSSby3PjOzL9SlYcn+hjMjZVNrTZ3
 S3FnN0wpl0KcXvx0xHqmNN9+eeFx1WagFZap2YNtu4+TTuTHhxdGtiOeTyiUOf78sz4LD9
 35ByLQb1CFQhN0CBxJmsx6iVQAVUqQAG9b8A2/g5tiOjxYlbQQfQ2nRpNnDxcyONT30VcJ
 bYh40aTQTUtwibngQW+FY8RqFkY8gYH3UbTTwDRzouSttuTH1cCvZ2T6RkhBEhfdVnbcIi
 xO2J1pz+twzRfoW0YRAuuY0LUQz7H0H6w0eJS4QmsrHJ1EwdfqEC7B4afS/gHw==
Date: Thu, 23 Nov 2023 14:12:33 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 thomas.petazzoni@bootlin.com, alexander.stein@ew.tq-group.com,
 u-boot@ew.tq-group.com
Subject: Re: [PATCH] tqma6: Fix DDR configuration
Message-ID: <20231123141233.3f37c1b7@xps-13>
In-Reply-To: <b7f6a997414bd7b37e75dc29c14c6708fad8164c.camel@ew.tq-group.com>
References: <mailman.3902.1700255720.703.u-boot@lists.denx.de>
 <b7f6a997414bd7b37e75dc29c14c6708fad8164c.camel@ew.tq-group.com>
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

Hi Markus,

Markus.Niebel@ew.tq-group.com wrote on Thu, 23 Nov 2023 14:04:43 +0100:

> Hello Miquel,
>=20
> > Initially investigating a Linux network issue causing a lot of drop and
> > poor network performances on a custom system based on a TQMA6A module
> > (based on an iMX6Q), [1st link below].
> >=20
> > I eventually correlated my observations with a contention at the NIC
> > level when in concurrency with the graphics pipeline. Troubleshooting
> > this in the kernel lead to disabling DMA bursts accesses made by the IPU
> > in order to avoid triggering the QoS at the interconnect level, reducing
> > from 50 to 10% the drop rate on eth0, [2nd link below]. The solution
> > worked on my setup but not on others, which still suffered from
> > abnormally high drop rates even with this "fix".
> >=20
> > After looking a while into TQ Systems BSP I figured out a number of
> > differences in recent U-Boot out-of-tree patches they had in their
> > repository [3rd link]. Parsing the differences one after the other lead
> > me to this final solution.
> >=20
> > The reset pad of the DDR controller was apparently misconfigured, Bit
> > 18-19 picturing the "DDR select field". The current value b11 is
> > reserved. The only defined value as of version 6 of the iMX6Q manual was
> > b00 "DDR3 and LPDDR2 mode". In practice no register difference has been
> > spotted after changing this configuration but all issues tracked thus
> > far just vanished. All previous fixes have been proven irrelevant. Just
> > clearing this field solved all our network issues and the drop rate as
> > measured by iperf3 felt back to 0%.
> >=20
> > Link:=20
> > https://lore.kernel.org/netdev/20231012193410.3d1812cf@xps-13/
> >=20
> > Link:=20
> > https://lists.freedesktop.org/archives/dri-devel/2023-October/428251.ht=
ml
> >=20
> > Link:=20
> > https://github.com/tq-systems/u-boot-tqmaxx/commit/15eb6abbefbf6916c284=
67b85485911dad3da6bc
> >=20
> > Signed-off-by: Miquel Raynal <
> > miquel.raynal@bootlin.com =20
> > > =20
> > ---
> >  board/tq/tqma6/tqma6q.cfg | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
> > index a49489aed3f..a345c4de93d 100644
> > --- a/board/tq/tqma6/tqma6q.cfg
> > +++ b/board/tq/tqma6/tqma6q.cfg
> > @@ -36,7 +36,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
> >  DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
> >  DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
> >  DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
> > -DATA 4, MX6_IOM_DRAM_RESET, 0x000C3030
> > +DATA 4, MX6_IOM_DRAM_RESET, 0x00003030 =20
>=20
> Thank you for pointing this out. Originally this error came from an
> older/ancient reference manual. Sorry that we missed to bring this
> upstream. We will send the changes for DCD data in the next days.

No problem, I'm glad this can now be solved. By any chance, could you
point to the relevant location of the manual (ddr or imx6 ?) explaining
what this is actually about? Because I failed to bring any real
explanation to my observations so far.

Thanks,
Miqu=C3=A8l
