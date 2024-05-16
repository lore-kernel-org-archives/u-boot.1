Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6F4C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 17:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DE98839D;
	Thu, 16 May 2024 19:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438A788353; Thu, 16 May 2024 17:36:18 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597A58826E
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 17:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1s7d9P-0000WQ-Mi; Thu, 16 May 2024 17:36:11 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Apurva Nandan <a-nandan@ti.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Dave Purdy <david.c.purdy@gmail.com>,
 Evgeni Dobrev <evgeni@studio-punkt.com>, Fabio Estevam <festevam@gmail.com>,
 Jason Cooper <u-boot@lakedaemon.net>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Luka Perkov <luka@openwrt.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Michael Walle <michael@walle.cc>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Siddarth Gore <gores@marvell.com>,
 Simon Guinot <simon.guinot@sequanux.org>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Wadim Egorov <w.egorov@phytec.de>,
 Walter Schweizer <swwa@users.sourceforge.net>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
Date: Thu, 16 May 2024 17:36:09 +0200
Message-ID: <8372642.T7Z3S40VBb@diego>
In-Reply-To: <20240514164236.516595-1-trini@konsulko.com>
References: <20240514164236.516595-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailman-Approved-At: Thu, 16 May 2024 19:18:55 +0200
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

Am Dienstag, 14. Mai 2024, 18:42:36 CEST schrieb Tom Rini:

[...]

> git-subtree-dir: dts/upstream
> git-subtree-split: 7e08733c96c84eb323f47e9b248c924e2ac6272a
> ---
> This moves OF_UPSTREAM to be tracking the v6.9 release and is for the
> -next branch. To test these changes yourself locally, either use my
> "WIP/14May2024-next" branch or run:
> ./dts/update-dts-subtree.sh pull v6.9-dts
> yourself locally. I intend to wait a few days to apply this to -next, to
> give people time to test.

On
- rk3588-rock5b
- rk3588-jaguar
- rk3588-tiger (pending patch)

Tested-by: Heiko Stuebner <heiko@sntech.de>


