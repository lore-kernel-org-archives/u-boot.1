Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D401EC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5388B8783F;
	Tue, 12 Dec 2023 17:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TEC8JnMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A1C98783B; Tue, 12 Dec 2023 17:21:36 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDB0871CE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BEA4FF80F;
 Tue, 12 Dec 2023 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1702398093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=306X9wnm4HWDhBuGesCZC3/mQvsgbS1w6bVwhNlCpcQ=;
 b=TEC8JnMH7+5jgB7oECZo03iXFCjz4fwpwoqBQPsIbyugzW1t6/PepXnlaNepL4/CLq/oP4
 2UzpbI3hhdB5IFEkdL4BgeTtlXVWRU64xHXwiAELfWPntTQtQlaqcGIEy/J/fTgWZ/b8vd
 gXh10ZYuzqcim/dnrU67Doml80kqGVi904MJ0ijwvg7GPaPhUqV54zmfHKeTPkTKYVRdhV
 wKSChkfEuMh1KDZm4YRG1m0kV9dXbKhdT+c+IqeypaaYH+A5tPqP2wCVot/fhKRe0GLYrh
 BxQZc8LTblAdkbn4cFE7EUHbznx2w4ghqaRt4kLOOsfTv9sAhe/REfs1tZz5qw==
Date: Tue, 12 Dec 2023 17:21:30 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, u-boot@lists.denx.de, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH] tqma6: Fix DDR configuration
Message-ID: <20231212172130.2193caea@xps-13>
In-Reply-To: <CAOMZO5AwuiZAohLhRwFQx-UeL5eoxfCgVqVvM77+4eRKbmt6dA@mail.gmail.com>
References: <20231117150044.1792080-1-miquel.raynal@bootlin.com>
 <CAOMZO5AwuiZAohLhRwFQx-UeL5eoxfCgVqVvM77+4eRKbmt6dA@mail.gmail.com>
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

Hi Fabio,

festevam@gmail.com wrote on Tue, 12 Dec 2023 13:11:53 -0300:

> On Fri, Nov 17, 2023 at 1:50=E2=80=AFPM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Initially investigating a Linux network issue causing a lot of drop and
> > poor network performances on a custom system based on a TQMA6A module
> > (based on an iMX6Q), [1st link below].
> >
> > I eventually correlated my observations with a contention at the NIC
> > level when in concurrency with the graphics pipeline. Troubleshooting
> > this in the kernel lead to disabling DMA bursts accesses made by the IPU
> > in order to avoid triggering the QoS at the interconnect level, reducing
> > from 50 to 10% the drop rate on eth0, [2nd link below]. The solution
> > worked on my setup but not on others, which still suffered from
> > abnormally high drop rates even with this "fix".
> >
> > After looking a while into TQ Systems BSP I figured out a number of
> > differences in recent U-Boot out-of-tree patches they had in their
> > repository [3rd link]. Parsing the differences one after the other lead
> > me to this final solution.
> >
> > The reset pad of the DDR controller was apparently misconfigured, Bit
> > 18-19 picturing the "DDR select field". The current value b11 is
> > reserved. The only defined value as of version 6 of the iMX6Q manual was
> > b00 "DDR3 and LPDDR2 mode". In practice no register difference has been
> > spotted after changing this configuration but all issues tracked thus
> > far just vanished. All previous fixes have been proven irrelevant. Just
> > clearing this field solved all our network issues and the drop rate as
> > measured by iperf3 felt back to 0%.
> >
> > Link: https://lore.kernel.org/netdev/20231012193410.3d1812cf@xps-13/
> > Link: https://lists.freedesktop.org/archives/dri-devel/2023-October/428=
251.html
> > Link: https://github.com/tq-systems/u-boot-tqmaxx/commit/15eb6abbefbf69=
16c28467b85485911dad3da6bc
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Applied, thanks.

Thanks a lot. Any chances you would have access to additional
information to explain how the network vs video pipeline
interact without this patch? I am eager to understand.

Cheers,
Miqu=C3=A8l
