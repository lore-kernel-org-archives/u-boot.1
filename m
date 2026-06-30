Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457E0C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFF084844;
	Tue, 30 Jun 2026 10:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="F0cG5+8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDFBD848F3; Tue, 30 Jun 2026 10:55:26 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C2384105
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782809718; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m6jLty2ZAGTG1egZ44zpkkbgk45074syxm4rPaY+NPAYPgWfYEGEdVo08FHZLgEiJrSesc/kZ0XSSRdhEfNNbmL9Zqbex1bjp+KamHa6LB4FY1bFCocs2MABoVpeFmxh4fmYn1qtVEGZfGSuvdEGn/w5JtH6TAUJ/W6kWytsZlg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782809718;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5LnpkmnVD09PuPgALULYq6lcVB9bCEevrwuo08EwHNw=; 
 b=L6rLZ055T1L9HOPY7HJKAQYvju6rc6da3pU/8huI14cFA3U9CZlYDkxZbOzyNAvLm5so4UnEBYqiPD5drd7zOfeLiI1k4U0fww+0g74zBIUQhM2fN333pmcgktPrNsTwBYhi3c4ttuEblgVqDSrtVW+hiAFxkeev6ufzqTI11mc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782809718; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=5LnpkmnVD09PuPgALULYq6lcVB9bCEevrwuo08EwHNw=;
 b=F0cG5+8t85R6KKgv+i/WmL3fIC5Qc9qJzSJTIlGH7W/h96HLuAv926OuPai+Ovtt
 3LvnkUdVpMLcJvvjtKcUuZ2xAC52kIT74RrV18Zn5cTXWzRPDPN/GiYzUehXvtDDHpI
 y1Ln2J10+SLZVkc/GfnJCdhAzI/jZZvmYyMt7SoI=
Received: by mx.zohomail.com with SMTPS id 1782809714893436.808916414283;
 Tue, 30 Jun 2026 01:55:14 -0700 (PDT)
Date: Tue, 30 Jun 2026 08:55:03 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 v2 1/8] pinctrl: k1: add IO power domain configuration
 support
Message-ID: <akOEZ6xEt-i5OysY@pie>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
 <20260629-m4-v2-1-cbc91c6b83d8@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-m4-v2-1-cbc91c6b83d8@riscstar.com>
X-ZohoMailClient: External
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

On Mon, Jun 29, 2026 at 11:51:15PM +0800, Eric Chung wrote:
> Dual-voltage GPIO banks default to 3.3V, but when externally supplied
> with 1.8V the internal logic must be explicitly reconfigured to match.
> 
> Add the ability to program IO power domain control registers through the
> APBC block. These registers require unlocking the AIB Secure Access
> Register (ASAR) before every read/write, since configuring a 1.8V domain
> while 3.3V is externally supplied can cause back-powering and pin damage.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> ---
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 84 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
> index 3ebc397213b..5d3236aac94 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c

...

> @@ -34,8 +36,24 @@
>  #define PAD_PULLUP		BIT(14)
>  #define PAD_PULL_EN		BIT(15)
>  
> -#define PIN_POWER_STATE_1V8		1800
> -#define PIN_POWER_STATE_3V3		3300
> +#define IO_PWR_DOMAIN_OFFSET	0x800
> +
> +#define IO_PWR_DOMAIN_GPIO2_Kx  0x0c
> +#define IO_PWR_DOMAIN_MMC_Kx    0x1c
> +
> +#define IO_PWR_DOMAIN_GPIO3_K1  0x10
> +#define IO_PWR_DOMAIN_QSPI_K1   0x20

Why these four offsets aren't sorted?

> +#define IO_PWR_DOMAIN_V18EN	BIT(2)
> +
> +#define APBC_ASFAR		0x50
> +#define APBC_ASSAR		0x54
> +
> +#define APBC_ASFAR_AKEY		0xbaba
> +#define APBC_ASSAR_AKEY		0xeb10
> +
> +#define PIN_POWER_STATE_1V8	1800
> +#define PIN_POWER_STATE_3V3	3300
>  
>  enum spacemit_pin_io_type {
>  	IO_TYPE_NONE = 0,

...

> @@ -485,6 +559,11 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
>  		dev_err(dev, "Fail to allocate memory\n");
>  		return -ENOMEM;
>  	}
> +	priv->regmap = syscon_regmap_lookup_by_phandle(dev, "spacemit,apbc");

So with this patch, the driver depends on syscon symbols, and you should
reflect this in Kconfig.

Regards,
Yao Zi
