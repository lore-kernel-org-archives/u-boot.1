Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85C7C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 19:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A6B8883B1;
	Tue, 21 May 2024 21:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985B9883CF; Tue, 21 May 2024 21:16:20 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F8E883AF
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 21:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875abf.versanet.de ([83.135.90.191] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1s9Uy3-0003aZ-Iz; Tue, 21 May 2024 21:16:11 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Subject: Re: [PATCH 00/10] rockchip: px30: migrate to common bss and stack
 addresses + UART fixes for evb-px30
Date: Tue, 21 May 2024 21:16:10 +0200
Message-ID: <2191709.Mh6RI2rZIc@diego>
In-Reply-To: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Dienstag, 21. Mai 2024, 19:39:53 CEST schrieb Quentin Schulz:
> PX30 Ringneck ran out of memory in the allocation pool of U-Boot proper
> pre-reloc. Something needed to be done. Jonas did migrate a few SoCs
> already to this common bss+stack addresses so it made sense to follow
> the same route for one additional SoC: PX30.
> 
> While at it, also fix a few issues related to UART on the PX30 Mini EVB
> I could test.
> 
> Boot (to U-Boot CLI) tested on PX30 Ringneck and PX30 Mini-EVB.
> 
> Thanks to Jonas for hinting where to look at.

u-boot 2024.07-rc3 with this series on an Odroid Go2

Tested-by: Heiko Stuebner <heiko@sntech.de>

Device boots and boots into a Debian image sucessfully.


Heiko


