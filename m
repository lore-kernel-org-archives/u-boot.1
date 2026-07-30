Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAFCC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 12:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B7D140945;
	Thu, 30 Jul 2026 12:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLFwHbTRuyYd; Thu, 30 Jul 2026 12:16:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E2344094D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785413781;
	bh=cawE8fAsZfGQ03UnNRCx8L6r4jNtaiER/r8xZfSQkHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EYQynku5r3BUzfPxdjGVsf2iqj6MhuzVQRPFRnc/eP4V6JcK594hKwjIJN+vMMFT0
	 IA/ubcrIPXHjX2JYW52lFc/CnWS0MvuwNElZLER04q3GebXRoP8/slCVU0Pt+nFhR9
	 PTNECuaJpBvX/OuHGZOHsyYxKSLzeXTc+W1D/hky//sRwFXqsZ40EhBGmtChX5G0Qk
	 5Wh/TD7dvUGRQiCxYPAAoFyeGlCmr96uFCKDSEX07Ic81AmRZ7ZXUVHppB6nnWx5WU
	 0j+LkE1vS8AspkFUMIKl5Elsq50BOSHyqxCb0rRYbdkFr/ro6JJfK/gkbBXpOPBk/U
	 U4BS7RfDYQ7sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E2344094D;
	Thu, 30 Jul 2026 12:16:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B47F42A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80E5F80F7A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kL7HZqSE8kfC for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 12:16:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4B56080F70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B56080F70
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B56080F70
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:16:19 +0000 (UTC)
X-Forward-Email-ID: 6a6b408e7b5fc2d08b60e887
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b258fdf7-16e2-49ae-b016-a54e710c4ae1@kwiboo.se>
Date: Thu, 30 Jul 2026 14:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] clk: rockchip: pll: fix rounding of negative k in
 RK3588 frac PLL
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
 <20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785413778;
 bh=cawE8fAsZfGQ03UnNRCx8L6r4jNtaiER/r8xZfSQkHw=;
 b=MDfsAbsH6dy+jP98BTlQ9v+Uhy70ChDcHqCGpR+EzI+xr7Vjcaz5RLkDYnfS5iOsRrTADhyan
 kdUqKCe5jhHKLbBoO9FxB2lRCBwBivyrlOHym6Y8rpAGHzlGIQsdAv0tV0IIKMwgVpJtJP4x5Iu
 tOLZPuU8LegEoeozNQ4UdVlV1GxzSeo9MTxXVYtDpGYqzwTY9r+JwpMNNpNiVyTlKWAJzCLdbJL
 t/l4G4lBKybIdSPkm2sOFD2ZaD/L6SlXR1Yk+tZZ+FtLXPAB3LR/IclxBe8RmtBsyvkVCUVrJLh
 fnGC7k6YT2eVVxPlCoLavLqh3TO/kLiCwuh2RfD6LfAw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=MDfsAbsH
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

Hi Alexey,

On 7/23/2026 5:04 PM, Alexey Charkov wrote:
> Current code uses magical constants when rounding up the magnitude of
> negative fractional PLL component k. This leads to overshooting the
> requested rate when the calculated fractional part has less than 0.3 in
> its decimal part due to failure to round up the fractional part.
> 
> Use a proper rounding up function to avoid overshooting the requested
> rate and make the calculation more readable.
> 
> Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calculation")
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/clk/rockchip/clk_pll.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
> index d0df3b8fb49d..69d2d182dcb5 100644
> --- a/drivers/clk/rockchip/clk_pll.c
> +++ b/drivers/clk/rockchip/clk_pll.c
> @@ -11,6 +11,7 @@
>  #include <asm/arch-rockchip/hardware.h>
>  #include <div64.h>
>  #include <linux/delay.h>
> +#include <linux/math64.h>
>  
>  static struct rockchip_pll_rate_table rockchip_auto_table;
>  
> @@ -177,7 +178,10 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
>  	k = ffrac * 65536 / fref;
>  	if (k > 32767) {
>  		ffrac = ((m + 1) * fref) - fvco;
> -		k = ((ffrac * 65536 * 10 / fref) + 7) / 10;
> +		/*
> +		 * Round up to avoid overshooting requested rate for negative k
> +		 */
> +		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);

Use of DIV64_U64_ROUND_UP() seem to cause build errors for Rockchip 32-bit
tagets, see CI job at [1].

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/jobs/54629#L4016

Regards,
Jonas

>  		if (k > 32767)
>  			k = 0;
>  		else
> 

