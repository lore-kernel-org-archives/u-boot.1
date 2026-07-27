Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C95CC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C535940635;
	Mon, 27 Jul 2026 08:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5YHcPbMYRhA; Mon, 27 Jul 2026 08:35:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2F3040535
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141355;
	bh=kZUyESl9RMOSnWEFOinBxt1ZRBryq6aUGqsWVd0mycA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KKwaCw1bWR1pWYyWIuSC8zDYQR/9G5yF7NzzjXJ9uNROuxXTfTa2M816YFOUDEePr
	 /LC98MF7OFzW/eO5HjWDx5gWF+cnbjuuDwqjPj1b0nn/mS4ZXarC/KatE83LpOWT++
	 oWj3h3goM1AMRr6XYCDDwvd0RI25ea7zQPExNCtfLMobihkvKUUNghxaUpTcVhRSb2
	 gQThNctA0KdW1iya2jiVTmZHicvoPEHz2akPODReqOyyfd9VGEJqFMiKHCh7N1d0W5
	 W9+dPmd8xXDzpan6Me9sZNMagSY1zzYQvARaB1dZCf/LYaGVzZd37v63cB6KJI1Tg3
	 gPqh6iBXiEkaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2F3040535;
	Mon, 27 Jul 2026 08:35:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E87A73B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1DAD80C0B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-EFnZw62soc for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:35:52 +0000 (UTC)
X-Greylist: delayed 903 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 27 Jul 2026 08:35:52 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8F15080C06
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F15080C06
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F15080C06
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785140430; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Mir09H+pjpHboFdxwm37DUoE1hluzlUfBpA7RrCFkzsysJ02IlN94ABVrflpK5wOPJ8kZxFzfo2PzyTj5rkwnEzKrIZG6tv0hLrA/3f7cAR/4uqtjzoo0p7umhWOrUArNq6b1eaMsJxgzLiXUidwfjunQDiltfPmGAyUAdK6ABk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785140430;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kZUyESl9RMOSnWEFOinBxt1ZRBryq6aUGqsWVd0mycA=; 
 b=Y+oPVFl6ILIIkTYD6ESpcrGzfvUOSvKHcXpEwpOE5NLkLG1IQZLD9JPJZoqmMcU8tK16cEwZwUI3aVm5EsP5BqoVKxkKygQNMNprKL0hvnykjn2+qTkUzJS3BLchlVjfg4e9UH4H6nMrJn3wGP2ZTDypuIzOrzGmxPNjKHq6T84=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785140425549662.0457618767566;
 Mon, 27 Jul 2026 01:20:25 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:20:07 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
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
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 03/11] pinctrl: k1: fix pull-up/pull-down configuration
Message-ID: <amcUt7Sv0PjCBrgA@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-3-2f58566d48ca@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-m4-v6-3-2f58566d48ca@riscstar.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.120.97
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785140430; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=kZUyESl9RMOSnWEFOinBxt1ZRBryq6aUGqsWVd0mycA=;
 b=g9S2gTeaBotdwikxSKtoU2m4IyKFHWEsFxGgGcFu+3rZm87wkrguAd/7I2WOqC7R
 rnQYxyf/2qLTnfZoOFFmndPhZSYHcYJKHrKSxx0SsfI3oVzka/aO6QRpwIPhjDuVCBr
 pHmlNijeXPUXjRj8qGQu2H5tLAVnX6p9CQ6BvAsc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=g9S2gTea
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 27, 2026 at 02:59:05PM +0800, Eric Chung wrote:
> Fix pull-up/pull-down configuration to honor the argument parameter:
> when argument is non-zero, enable the requested pull direction;
> when argument is zero, clear all pull bits to disable.

Since this is a bug in a patch that hasn't been merged, please fix it in
place and re-spin the pinctrl/GPIO/SPI-NOR series.

> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v6:
> - Fix pull-up/pull-down configuration.
> ---
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
> index 6ed511879da..454bc307ba3 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
> @@ -425,11 +425,17 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  		break;
>  	case PIN_CONFIG_BIAS_PULL_DOWN:
>  		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
> -		clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
> +		if (argument)
> +			clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
> +		else
> +			clrbits_le32(addr, PAD_PULLDOWN | PAD_PULL_EN);

This could be simplified as

	clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
			      argument ? PAD_PULLDOWN | PAD_PULL_EN : 0);

similar for the pull-up case.

>  		break;
>  	case PIN_CONFIG_BIAS_PULL_UP:
>  		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
> -		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
> +		if (argument)
> +			clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
> +		else
> +			clrbits_le32(addr, PAD_PULLUP | PAD_PULL_EN);
>  		break;
>  	case PIN_CONFIG_DRIVE_STRENGTH:
>  		io_type = IO_TYPE_1V8;
> 
> -- 
> 2.51.0
> 

Best regards,
Yao Zi
