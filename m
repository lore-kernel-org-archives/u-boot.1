Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A16BC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6657880763;
	Fri, 31 Jan 2025 00:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ykOVcCQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7008B8078B; Fri, 31 Jan 2025 00:31:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84651805DA
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738279859;
 bh=Rl8+eWW9t76P4wE1zSgBPkUruJ45sEKrbs0JnAp5MBs=;
 b=ykOVcCQorPMd9ZiQqEke3gKAe4QSSd3h4QA1KWGGAo97ImI/4SsevRniXIybKTZuWobs8hZyv
 CkRLxE8MXwLXmNSmsK2lEQGaGgj6r6FioXztpbwI/l+DYFjSe8+FhiKyymz7kERiEn6+VVfZ+DP
 PAv9ysLp+n78HmCcNwY/VuwEpItY85YPMst6thYZ4C2jKb667T6VvMNiGxnBeainaF/YD50zUaM
 o8jXmF9IHNX1kTgoiVibxoQza3rbTmDqzQx1tjXA+NwBkPivuGawIsrgJMiFMcm1whYeVcDtyTp
 qJBvpFJ25HPNJCGMTqYR36m6DKN9QFjbadCXu4Y05WnQ==
X-Forward-Email-ID: 679c0ba72d70e7e0588407cb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <44fec4b4-c823-47b3-a962-b524e3917423@kwiboo.se>
Date: Fri, 31 Jan 2025 00:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] net: dwc_eth_qos_rockchip: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-20-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241121142731.1202209-20-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Heiko,

On 2024-11-21 15:27, Heiko Stuebner wrote:
> Add rk_gmac_ops and other special handling that is needed for GMAC to
> work on RK3576.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/net/dwc_eth_qos.c          |   4 +
>  drivers/net/dwc_eth_qos_rockchip.c | 141 ++++++++++++++++++++++++++++-
>  2 files changed, 144 insertions(+), 1 deletion(-)

[snip]

The code added in this patch does not seem to match the code added in
mainline Linux kernel.

Feel free to squash "fixup: net: dwc_eth_qos_rockchip: Add support for
RK3576" at [1] to adjust this to closer match the Linux kernel driver,
similar to remaining supported SoCs in this driver.

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3576-2025.04-wip/

Regards,
Jonas
