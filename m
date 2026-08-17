Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F6CC5DF6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 04:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCFBC606ED;
	Mon, 17 Aug 2026 04:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EX-aGmfislY4; Mon, 17 Aug 2026 04:01:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59011606D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786939292;
	bh=HTs1hLy2K1TrTtd5uA+QaPqD94y3wZLQHsMH3ABIC9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOcnsIDYk4FXpX2cfjdYjRytQmhGzKVk2kgnS/1QBcxXphGAzlyGVZIwmYjpc0rSP
	 cwiQPy0dGrkb13UEC95jSCJUg9s6TlKYaCJreFdb4UNEQt7+FQn91gH8nuxWVV7dX7
	 rgH5BDgr9c2upMJ6KVDSyTGVCBUx+1E86b4wYd/1adsZ0DBm/iWkpCB4eR1iN0/6s1
	 2lDZMtVuJVzC1mFSw3p4+hqETzW2pSkpatzKcUMkIjfuV/Xue5sGbLkgCWnh+7CsjI
	 jIuqoIznGBV6rnFXHrba1othd9SJS/Ngt+cr15XkCrROKhlhAS/n8U7rI4rPkAdd6B
	 zCWD9yJXPRAIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59011606D6;
	Mon, 17 Aug 2026 04:01:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A8B54194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 01:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C0FD40128
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 01:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qjO6h3P_dgb for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 01:39:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DAA0440120
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAA0440120
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=E77Fa/J5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAA0440120
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 01:39:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20510417AE;
 Mon, 17 Aug 2026 01:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C81F000E9;
 Mon, 17 Aug 2026 01:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786930744;
 bh=HTs1hLy2K1TrTtd5uA+QaPqD94y3wZLQHsMH3ABIC9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=E77Fa/J5Tcb5lia/zuLMlmYpxYB9myvKFieh3YYb5UflZIAaRBv0sy6zWf8aVSDNl
 Z8kxDQMe7oOI7jZu7y62X2ZXhpxONoZO06fCMr7bv6vl8GDHmIdcqYBsx99N58/jxw
 i5khJ/hOP2utWzi7Oimfrs7OJ8O6CNv2NlL1rUkbxGNULHfpX8/Plg8oISp9r5lZZz
 5ypRqtfdmtpN67vKuGlIvxB5SVVK1eW9ak7Wx9yBjfRZkIuMawURneyVT7ztGhC4lX
 y136ASlsmaZ1r6sM/GC06hN4ZdyOIxFFBlUVUrNxDlINJDyT2+fuuuRqCNQQxDVkLl
 8G106uV0ys0pw==
Date: Mon, 17 Aug 2026 01:39:01 +0000
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
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v8 03/11] pinctrl: k1: fix pull-up/pull-down configuration
Message-ID: <20260817013901-GKA566872@kernel.org>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
 <20260802-m4-v8-3-e916643205f3@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802-m4-v8-3-e916643205f3@riscstar.com>
X-Mailman-Approved-At: Mon, 17 Aug 2026 04:01:30 +0000
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

Hi Eric,

On 00:40 Sun 02 Aug     , Eric Chung wrote:
> Fix pull-up/pull-down configuration to honor the argument parameter:
> when argument is non-zero, enable the requested pull direction;
> when argument is zero, clear all pull bits to disable.

No, This will be problem .. see my comment below

> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
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
> index 6ed511879daf..4e65fad1e8c5 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
> @@ -409,7 +409,6 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  	struct spacemit_pinctrl_data *data;
>  	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
>  	void __iomem *addr;
> -	u32 mask;
>  	unsigned int io_type;
>  	u8 ds;
>  	bool found;
> @@ -424,12 +423,12 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  		clrbits_le32(addr, PAD_PULLUP | PAD_PULLDOWN | PAD_PULL_EN);
>  		break;
>  	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
> -		clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
> +		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
> +				argument ? PAD_PULLDOWN | PAD_PULL_EN : 0);
>  		break;
..
>  	case PIN_CONFIG_BIAS_PULL_UP:
> -		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
> -		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
> +		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
> +				argument ? PAD_PULLUP | PAD_PULL_EN : 0);
In kernel side, the argument for pull up settings has documentated as
 0 - normal pull up
 1 - strong pull up
well, you can still use bias-disable property to disable bias settings if needed

I'd suggest to have this aligned with kernel DT files, which would more easily
for us to reuse upstream dts files

>  		break;
>  	case PIN_CONFIG_DRIVE_STRENGTH:
>  		io_type = IO_TYPE_1V8;
> 
> -- 
> 2.51.0
> 

-- 
Yixun Lan (dlan)
