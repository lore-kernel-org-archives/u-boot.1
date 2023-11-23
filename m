Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9757C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 17:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6EE28760B;
	Thu, 23 Nov 2023 18:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="S5Nu0Ec/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516E386784; Thu, 23 Nov 2023 14:44:05 +0100 (CET)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB1C86784
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1700747042; x=1732283042;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3s9CyxSWZTLYQYZIUbEKLEM1eoZ7k3bS//HCZnHB2kQ=;
 b=S5Nu0Ec/nbZaXIOmFTZbmDc3TFt9z8enQxsYWj2AcBf5CEBtIzqZgDzr
 miBlHzF7Gi0POU+nfT0Q6Wlg0fgxkpOPvqASBRu30YT1cU7oSbOdr7MPX
 wBNdoBPfiwNt/Vzn69xtejHcG1qVDIEG/kVCAuQ7+K+7uVVop2f/bQHlh
 OqAF6pQoQt+DXlI0RrG8U6yNZ8x2AMKbA6cUg96XS10tn9/OvvPziy+5q
 5DMiQLA5wYdv5OyB/vumUNuKob9753FSJuoJ8HfcLOmRQRCUt9MqiqaQb
 h/eLZfPyBXa9TjaJG2NJnHEFvjPrSFbfAjU7hYeIngoiJKHyQHpG+GuOH w==;
X-IronPort-AV: E=Sophos;i="6.04,221,1695679200"; d="scan'208";a="34143766"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 23 Nov 2023 14:44:01 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C4607280075;
 Thu, 23 Nov 2023 14:44:01 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, thomas.petazzoni@bootlin.com,
 u-boot@ew.tq-group.com
Subject: Re: [PATCH] tqma6: Fix DDR configuration
Date: Thu, 23 Nov 2023 14:44:01 +0100
Message-ID: <12328531.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231123141233.3f37c1b7@xps-13>
References: <mailman.3902.1700255720.703.u-boot@lists.denx.de>
 <b7f6a997414bd7b37e75dc29c14c6708fad8164c.camel@ew.tq-group.com>
 <20231123141233.3f37c1b7@xps-13>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Mailman-Approved-At: Thu, 23 Nov 2023 18:04:09 +0100
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

Hi Miquel,

Am Donnerstag, 23. November 2023, 14:12:33 CET schrieb Miquel Raynal:
> Hi Markus,
>=20
> Markus.Niebel@ew.tq-group.com wrote on Thu, 23 Nov 2023 14:04:43 +0100:
> > Hello Miquel,
> >=20
> > > Initially investigating a Linux network issue causing a lot of drop a=
nd
> > > poor network performances on a custom system based on a TQMA6A module
> > > (based on an iMX6Q), [1st link below].
> > >=20
> > > I eventually correlated my observations with a contention at the NIC
> > > level when in concurrency with the graphics pipeline. Troubleshooting
> > > this in the kernel lead to disabling DMA bursts accesses made by the =
IPU
> > > in order to avoid triggering the QoS at the interconnect level, reduc=
ing
> > > from 50 to 10% the drop rate on eth0, [2nd link below]. The solution
> > > worked on my setup but not on others, which still suffered from
> > > abnormally high drop rates even with this "fix".
> > >=20
> > > After looking a while into TQ Systems BSP I figured out a number of
> > > differences in recent U-Boot out-of-tree patches they had in their
> > > repository [3rd link]. Parsing the differences one after the other le=
ad
> > > me to this final solution.
> > >=20
> > > The reset pad of the DDR controller was apparently misconfigured, Bit
> > > 18-19 picturing the "DDR select field". The current value b11 is
> > > reserved. The only defined value as of version 6 of the iMX6Q manual =
was
> > > b00 "DDR3 and LPDDR2 mode". In practice no register difference has be=
en
> > > spotted after changing this configuration but all issues tracked thus
> > > far just vanished. All previous fixes have been proven irrelevant. Ju=
st
> > > clearing this field solved all our network issues and the drop rate as
> > > measured by iperf3 felt back to 0%.
> > >=20
> > > Link:
> > > https://lore.kernel.org/netdev/20231012193410.3d1812cf@xps-13/
> > >=20
> > > Link:
> > > https://lists.freedesktop.org/archives/dri-devel/2023-October/428251.=
htm
> > > l
> > >=20
> > > Link:
> > > https://github.com/tq-systems/u-boot-tqmaxx/commit/15eb6abbefbf6916c2=
846
> > > 7b85485911dad3da6bc
> > >=20
> > > Signed-off-by: Miquel Raynal <
> > > miquel.raynal@bootlin.com
> > >=20
> > > ---
> > >=20
> > >  board/tq/tqma6/tqma6q.cfg | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
> > > index a49489aed3f..a345c4de93d 100644
> > > --- a/board/tq/tqma6/tqma6q.cfg
> > > +++ b/board/tq/tqma6/tqma6q.cfg
> > > @@ -36,7 +36,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
> > >=20
> > >  DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
> > >  DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
> > >  DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
> > >=20
> > > -DATA 4, MX6_IOM_DRAM_RESET, 0x000C3030
> > > +DATA 4, MX6_IOM_DRAM_RESET, 0x00003030
> >=20
> > Thank you for pointing this out. Originally this error came from an
> > older/ancient reference manual. Sorry that we missed to bring this
> > upstream. We will send the changes for DCD data in the next days.
>=20
> No problem, I'm glad this can now be solved. By any chance, could you
> point to the relevant location of the manual (ddr or imx6 ?) explaining
> what this is actually about? Because I failed to bring any real
> explanation to my observations so far.

It's a bit hidden but the comment above that list indicates these settings =
are=20
iomuxc configurations. In this case the register=20
IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET. See i.MX6Q RM Rev.6 05/2020 section=20
36.4.347.
Your patch configures the field "DDR Select Field" from reserved3 to=20
DDR3_LPDDR2. It seems this field has to be set to 0 in every case.

Thanks again and best regards,
Alexander


> Thanks,
> Miqu=E8l


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


