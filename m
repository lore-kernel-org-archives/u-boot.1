Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002E7C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9A5A4080D;
	Mon, 17 Aug 2026 13:34:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yzheK5B4gwvf; Mon, 17 Aug 2026 13:34:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E67FB407EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973666;
	bh=+ATV3mHLHM4qmSuxbZJGTWNuEC8o+tvqn6b69uOqHEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kPH+BW6FuTtm/moqJCQZCMwxL5RLs/aTthuSOF/P1CUT3vxNVIUS+e/MoTCXjd8M1
	 UgAj5g6m80qzjujbhsEszHA/tybSPUT+dbrFh6zZckPyn6Jix+LD+uw35vNUGYr29J
	 3zvZjMIRgLqFJcyihzt7wcJXnDDEPWfu9/YinOTC6WnVnYVTjl35aQwb1JyNux+VgE
	 cWOZ2Pk//Qn9212jOL+7Y741bFXv+l4dGPl1DlmwPlngieT5fKOXGvTHBDyC58bVrX
	 9M1wNNe4JciI0FsAbA6rcdiBbuQmwKwWJ9p6e5CVoUwMMleZZAsquTD12ac/8TF3kE
	 lUwFoLUrt9waw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E67FB407EC;
	Mon, 17 Aug 2026 13:34:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 584BA25B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49B054072B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:18:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sykkTLHdkZ5R for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:18:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B26C14070D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B26C14070D
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QhSTebh7
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B26C14070D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:18:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42C7741934;
 Mon, 17 Aug 2026 09:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943321F000E9;
 Mon, 17 Aug 2026 09:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786958295;
 bh=+ATV3mHLHM4qmSuxbZJGTWNuEC8o+tvqn6b69uOqHEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QhSTebh7edfXgcxspYY3YqhHgL8yau3/of7qXZmMT92U9+0LpVGiVsIQMK0A/FdBZ
 zgBR30d3BfN66axoNi5X637MRI5gI/IkW8zzxHTOd3FXf4MFfa4FvtiPJDLazdvW6g
 U33Cf1+4SClUlR3NpYNzQ5qV3YyAp7nNH6ZBps6UtsJnhzVLm1/TLaQZHDUmqjj0Vp
 fcYVktbkrELIMtw3od5RCyW/2JU9RXxeiQn8tJ/d3OFOGug6+e2Tpkp58zxx0ZAHWb
 61VmDp2xky8Tkfr87SQyWd26zx4SYuVkmQccKdsImpziNqIaFJZMPmkaSF7M3qCj94
 FLrdJvW9tLE5A==
Date: Mon, 17 Aug 2026 09:18:12 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, Heiko Schocher <hs@nabladev.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 3/4] i2c: k1: enable both functional and bus clocks
Message-ID: <20260817091812-GKC571540@kernel.org>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
 <DKR3E33H0FCK.1O1KN2YJSZSBB@linux.spacemit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKR3E33H0FCK.1O1KN2YJSZSBB@linux.spacemit.com>
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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

hi Troy,

On 16:56 Mon 17 Aug     , Troy Mitchell wrote:
> > The K1 I2C controller requires both its functional clock and APB bus
> > clock to operate. The device tree provides them as "func" and "bus", but
> > the driver currently acquires and enables only the first clock.
> >
> > Acquire both clocks by name and enable them during probe. Use explicit
> > named lookups instead of the bulk clock API to align with the K1 Linux
> > driver and keep the roles of the two clocks clear if functional clock
> > rate configuration is needed later.
> 
> [...]
> 
> > @@ -487,15 +487,21 @@ static int k1_i2c_probe(struct udevice *bus)
> >  		return ret;
> >  	}
> >
> > -	ret = clk_get_by_index(bus, 0, &priv->clk);
> > +	ret = clk_get_by_name(bus, "func", &clk);
> >  	if (ret)
> >  		return ret;
> >
> > -	ret = clk_enable(&priv->clk);
> > -	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
> > -		debug("%s: failed to enable clock\n", __func__);
> > +	ret = clk_enable(&clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_get_by_name(bus, "bus", &clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_enable(&clk);
> > +	if (ret)
> >  		return ret;
> > -	}
> 
> Once the functional clock has been enabled, failure to acquire or enable
> the bus clock returns without disabling the functional clock.
> 
I'd not worry about this, as in uboot it isn't worth the effort to do the
resouce reclamation, instead I'm more concerned about the error handling..


-- 
Yixun Lan (dlan)
