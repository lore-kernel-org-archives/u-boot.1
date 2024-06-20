Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C425C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 10:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766F388527;
	Thu, 20 Jun 2024 12:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4799F8852D; Thu, 20 Jun 2024 12:52:51 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C13E88521
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1sKFPE-0004Do-9U; Thu, 20 Jun 2024 12:52:40 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Subject: Re: [PATCH next 2/2] rockchip: remove support for Theobroma Systems
 RK3368 Lion
Date: Thu, 20 Jun 2024 12:52:38 +0200
Message-ID: <10173419.L8ug28u51p@diego>
In-Reply-To: <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
 <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
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

Am Donnerstag, 20. Juni 2024, 12:24:51 CEST schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> No meaningful changes were made to this SoM since February 2021. Nobody
> from Theobroma has booted anything recent on that product since July
> 2021 at the latest. The product isn't available to buy anymore and
> disappeared from our website.
> 
> This product is therefore unmaintained and it would be disingenuous to
> say the opposite, so drop support for RK3368 Lion.
> 
> If you're a user of Lion, feel free to revert this patch or contact our
> sales/support department.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

I think any meaningful work on rk3368 in general has pretty much stalled
at this point.

Acked-by: Heiko Stuebner <heiko@sntech.de>


