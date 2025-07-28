Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59683C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 10:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D9EC82EB8;
	Mon, 28 Jul 2025 12:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="M08EqT6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E69C82F00; Mon, 28 Jul 2025 12:29:32 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBFF82E52
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 12:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 815241F83F;
 Mon, 28 Jul 2025 12:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1753698568;
 bh=kU+7OeAchmRzCvfsoVOCr9RXtJc3N+6n6IKHJ8meoGw=; h=From:To:Subject;
 b=M08EqT6i7rufwf3Q/+6Nl7UzZllTL9y5SpOcE9FRmJ8tO2VUOCTbhhkDD67THXcko
 2FsT/rg4GIvcB5GiUgpgtblBItm3psjGUmn6soXv6rHGeIfJF5rRIRisr6JCiEuLBR
 6j2uS6nRFyu2+VYzrAY76HTluHlQqN/Zm0PeS6kY2fhx6JA02uljDm836akPjjiN7U
 UIKp1XATKwWQWOHsY9UQeH7TatxDWWF4O38QhQ3+6qqBlvYqNhgm43LThX2+j7bauj
 Akl1TS1J2UuK8p6MABPHCG68m+DcF84AnNrcMM0ei9tRAEDMIS86U5CTXPYQ1J0dgK
 7fld7URkJJvag==
Date: Mon, 28 Jul 2025 12:29:23 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
Message-ID: <20250728102923.GA32387@francesco-nb>
References: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
 <20250724033822.GE18395@nxa18884-linux.ap.freescale.net>
 <kn34dabjpqywranhgrtpy77bmuviluhzgf2pgtdguqvgwk7e3d@3zud5czxsewc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kn34dabjpqywranhgrtpy77bmuviluhzgf2pgtdguqvgwk7e3d@3zud5czxsewc>
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

Hello Fabio,

On Thu, Jul 24, 2025 at 08:28:22AM -0300, João Paulo Gonçalves wrote:
> > If boot from USB, this means env_loc will be override here.
> > 
> > NXP boards always use RAM env when booting from USB.
> In that case, this seems like an ARCH configuration and the ARCH should
> imply the necessary kconfig. Currently, every i.MX9 board needs to
> enable CONFIG_ENV_IS_NOWHERE or the boot hangs when booting from USB.

You worked on a similar topic, for imx8m, some time ago, commit
d175982c207b ("imx8mn/8mp: Allow booting via USB"). What's your opinion
here? How should we fix this?

Francesco


