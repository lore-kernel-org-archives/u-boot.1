Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0CBC5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 16:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B572D60AC2;
	Fri, 21 Aug 2026 16:54:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FV9n7KTrAGln; Fri, 21 Aug 2026 16:54:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787331264;
	bh=G10yJynuG/TONieejz4v6VkohSemcMDls86qRpsUN+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gc8mhBAcmz6VXN5l4RXaGU+MKeEB3Qruol0HsnHZKy/I5GvirSXwW99Qrjr8I33aD
	 QVv5F2OA1LjUBnRlM51vbqbjL7iP0kgQXt5rwkORSeJkguZ+TUuz9Qp+nmyME/Bvzx
	 Ab0mqyJLlS7OK+oeq32PJM4p/1jnldOKKL5DY9cSqKplIhFtN/9RuqsE/sjYWXJpBZ
	 oCHD/vjhuiBeYtNqh9DftiZsXK0ed5etlggpxTzjVxZ1p66KJeyVI7LvoBgHF2m3js
	 H1XSBMIpe14aV28kGEruF/mu6ipkzLoyFfGd3ThPgWyrC++rT5XIlym2sLdp/GxG8r
	 NI82YiIt4kDJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B09F60A8A;
	Fri, 21 Aug 2026 16:54:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24599263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D9EF80C33
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRifSE85nHjl for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 16:54:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cQiAwSWz
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C81D809C4
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:54:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 883B540A6D;
 Fri, 21 Aug 2026 16:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DAB1F00A3A;
 Fri, 21 Aug 2026 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787331261;
 bh=G10yJynuG/TONieejz4v6VkohSemcMDls86qRpsUN+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cQiAwSWzczeVKGhwWoEB/0pteGrGj1qfi947xkbcVPa8fx6l1iMefju7iYZgOHg1H
 TSahmXG4BFYkv95OjQuTsPdon41s3Uyhsf7Y8iKl6sxhg4l0AcOJ1fujdkgWJ4grmt
 8uSdevEvZBcvqvzz4fyUNWFBmGVE6/15yT/S4o8j8RplnppougbJMgHR1kkUm7k/eY
 6ymP9mwlFdG3Lu17gOqsW/UV+BP1YYVkqVi28K9olN360JAO5Ffbuomc8hp9OdaMLz
 IdNbvKiWGd83CQT3FSdKJtSc0V3nFkyzDuIQHbUmAg8SP5m0C8PFE65iIoyKtCWWKj
 hwWMKcP+tqwCA==
Date: Fri, 21 Aug 2026 16:54:18 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
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
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yixun Lan <dlan@kenrel.org>
Subject: Re: [PATCH v9 02/19] pinctrl: k1: fix pull-up/pull-down configuration
Message-ID: <20260821165418-GKB579897@kernel.org>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
 <20260819-m4-v9-2-6e66016392b9@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819-m4-v9-2-6e66016392b9@riscstar.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Eirc,

On 11:54 Wed 19 Aug     , Eric Chung wrote:
> Fix pull-up/pull-down configuration to honor the argument parameter:
> when argument is non-zero, enable the requested pull direction;
> when argument is zero, clear all pull bits to disable.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
..
> Reviewed-by: Yixun Lan <dlan@kenrel.org>
No, I never gave R-B to this patch, and below you still not addressed
my previous concern

Also, I suggest to use tool "b4 trailers" to collect tags instead of
 doing it manually which easily lead to problem..
> 
> ---
> v9:
> - Rebase since drop patch "fix drive strength configuration".
> v7:
> - Simplify pull-up/pull-down configuration by using a single
>   clrsetbits_le32() call.
> v6:
> - Fix pull-up/pull-down configuration.
> ---
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
> index a6a22eacac7b..9ca4ef7c771e 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c

..
>  	case PIN_CONFIG_BIAS_PULL_UP:
> -		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
> -		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
> +		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
> +				argument ? PAD_PULLUP | PAD_PULL_EN : 0);
No, this is still same problem as previous version, please take
a look at the DT documentation from upstream linux kernel

Documentation/devicetree/bindings/pinctrl/spacemit,k1-pinctrl.yaml

1) to disable bias
          bias-disable: true

2) to set as pull down
          bias-pull-down: true

3) to set normal pull up or strong pull up
          bias-pull-up:
              0: normal bias pull up
              1: strong bias pull up

-- 
Yixun Lan (dlan)
