Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBC9C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47D7240CC1;
	Fri, 14 Aug 2026 22:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RcAfG-GQJiJ; Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3BA140CC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747458;
	bh=Lvtfq+upLC2juJV18p39zK/VnFmKbfkbVhLvv8cpMK4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yWlintQkvxdI8FJLheBm889pvj36UoUjZSW1oK2rXE9v9pcJ0wEKffkYy4jThvRj1
	 LPyxquKGjymyuxYrsix9z7Stg5y7LLmpEIwsH9t5Js4GI8wyWZUZcWh3MHdAtEJv3u
	 rxVK7YKV/PT9AZqYpKcxi18ccOUCI2HlIA2FfACHQH5yOvyvTJRDXfC/sn2vQMDZ95
	 QGrRjB0WcW68Axpqdm9bSDpGM1yqv5yDubEn9hiMZrr48r7LJP/g/45oKYOerx2BBm
	 llIggx6xVYXi7UX3aM9QWwisDR4pAnwfvm2gdGFgLNMvRBoqupwEI5ppI/iZoS0ahC
	 t0AMtJGE4o/Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3BA140CC3;
	Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 56F0C194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C9E760A86
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Bniin9Ur9Zh for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 29842606BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29842606BF
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29842606BF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:15 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hMHMx3LrKz8sxn;
 Sat, 15 Aug 2026 00:44:13 +0200 (CEST)
Message-ID: <4e3a48d8-d971-402f-9542-820f254abc77@mailbox.org>
Date: Sat, 15 Aug 2026 00:21:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mmc: zynq_sdhci: support Renesas RZ/N1
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Michal Simek <michal.simek@amd.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>
References: <20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gb5tjpogk9683ykjneo9wgys634yrs5h
X-MBO-RS-ID: 2460ca6ce6532eef96e
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:30 PM, Ralph Siemsen wrote:

[...]

> +++ b/drivers/mmc/zynq_sdhci.c

[...]

> @@ -1152,13 +1177,13 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   		}
>   	}
>   
> -	ret = clk_get_by_index(dev, 0, &clk);
> +	ret = clk_get_bulk(dev, &clks);
>   	if (ret < 0) {
> -		dev_err(dev, "failed to get clock\n");
> +		dev_err(dev, "failed to get clock(s)\n");


"failed to get clock(s) (%d)\n", ret);

Please fix globally.

>   		return ret;
>   	}
>   
> -	clock = clk_get_rate(&clk);
> +	clock = clk_get_rate(&clks.clks[0]);

Can the clock ever be non-first clock , i.e. do you need to handle 
clock-names DT property somehow ?

>   	if (IS_ERR_VALUE(clock)) {
>   		dev_err(dev, "failed to get rate\n");
>   		return clock;
[...]
