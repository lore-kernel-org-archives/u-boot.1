Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF31C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 15:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1DD8825A;
	Thu, 16 May 2024 17:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B0548825A; Thu, 16 May 2024 17:39:05 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED75D8826E
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 17:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1s7dC3-0000YP-QY; Thu, 16 May 2024 17:38:55 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
Date: Thu, 16 May 2024 17:38:54 +0200
Message-ID: <1965769.PYKUYFuaPT@diego>
In-Reply-To: <59c3ee19-f1c5-425d-912d-d418c7a2990b@cherry.de>
References: <20240423-tiger-v2-1-4a3fa0a01b5e@theobroma-systems.com>
 <0c9b591b-71a6-4a76-89b1-46a48f0183cf@rock-chips.com>
 <59c3ee19-f1c5-425d-912d-d418c7a2990b@cherry.de>
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

Am Mittwoch, 8. Mai 2024, 10:34:57 CEST schrieb Quentin Schulz:
> Hi Kever,
> 
> On 5/8/24 4:42 AM, Kever Yang wrote:
> > Hi Quentin,
> > 
> >      Could you please update this patch with OF_UPSTREAM support?
> > 
> 
> No, I cannot yet :/
> 
> Tiger is only available in Linux kernel v6.9-rcX and dts/ in U-Boot is 
> currently at v6.8.

Looks like Tom plans on updating the dts in -next soon'ish [0]
With the patch adapted to the OF_UPSTREAM situation
(dropping rk3588-tiger.dtsi and rk3588-tiger-haikou.dts and dropping
one usbdp node in -uboot.dtsi):

Tested-by: Heiko Stuebner <heiko@sntech.de>



[0] https://lore.kernel.org/all/20240514164236.516595-1-trini@konsulko.com/


