Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ECDCCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 20:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A3C0838D2;
	Sun, 19 Oct 2025 22:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VXS14Rrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708EB838DD; Sun, 19 Oct 2025 22:28:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4537838CE
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 22:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1760905730;
 bh=PrcfBOemUYeSHKgExzAp3tEPQgW/qITJEhTnK+cRe7Y=;
 b=VXS14RrddizBuKlB8RNlyc/yCc2ZLw9ueGhrwjByTKvhzl62geSjIsYSrri/v2B2tY3YQ22Qp
 oF64VEkbgHlQfhpMFS6+8SuyyRqKZy4E4i8ZYzP7KI+hnOGIUqWVU9T5HChldzA8jzWU22ISWi9
 ak0ZePNFW/rVtL6vWQlqOvd+0i64YJ//TfYT4pYH4miad/GPnqYJ/WWiTHotliDPX8Hsi1oJO+J
 eayp5RUVyv2e7A2YMmUtRFs3ZYE81lDShz/l2Z+7KKg06EKDP9KRCI4l69z+zrogE3LFlvXos1A
 3SsWQzCRvSdu3fiCMfsZ5c+Zg+qwUzSI8BI4bYMth5Og==
X-Forward-Email-ID: 68f549fe05f21c3b47d9e1e5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <aa7d67c4-5abe-4a71-89b1-866fb677d232@kwiboo.se>
Date: Sun, 19 Oct 2025 22:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] clk: rockchip: Remove negative error returns from
 clk_get_rate
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-8-5f80f827407e@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251015-clk_ops-v1-8-5f80f827407e@linaro.org>
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

Hi Andrew,

On 10/15/2025 4:32 PM, Andrew Goodbody wrote:
> clk_get_rate() returns a ulong so do not attempt to pass negative error
> codes through it.

On Rockchip the clk drivers only implement support for a subset of all
clocks supported by the hardware, mostly to save space for TPL/SPL and
not having to implement logic for clocks not really needed by U-Boot.

Because support for all clocks is not implemented the existing working
error handling actually help us catch clock issues on the Rockchip
platform. E.g. when a clk is referenced by assigned-clock-rates in DT we
get an error and can fix the issue, or decide if we can safely ignore
setting the clk rate.

I do not understand why you need to change the way the clk ops work,
just check with IS_ERR_VALUE() inside the clk-uclass or similar if you
really must remove working error handling from the callers.

The current working clk error handling has really helped me time and
time again on Rockchip platform during soc and board bring-up.

This is a NAK for me without first having a proper replacement for all
existing working error handling that is just being left ignored after
this patch/series.

Regards,
Jonas

> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/clk/rockchip/clk_px30.c   | 24 +++++++--------
>  drivers/clk/rockchip/clk_rk3036.c |  2 +-
>  drivers/clk/rockchip/clk_rk3066.c |  8 ++---
>  drivers/clk/rockchip/clk_rk3128.c |  6 ++--
>  drivers/clk/rockchip/clk_rk3188.c |  6 ++--
>  drivers/clk/rockchip/clk_rk322x.c |  4 +--
>  drivers/clk/rockchip/clk_rk3288.c |  6 ++--
>  drivers/clk/rockchip/clk_rk3308.c | 26 ++++++++--------
>  drivers/clk/rockchip/clk_rk3328.c |  6 ++--
>  drivers/clk/rockchip/clk_rk3368.c |  8 ++---
>  drivers/clk/rockchip/clk_rk3399.c | 12 ++++----
>  drivers/clk/rockchip/clk_rk3528.c | 20 ++++++-------
>  drivers/clk/rockchip/clk_rk3568.c | 62 +++++++++++++++++++--------------------
>  drivers/clk/rockchip/clk_rk3576.c | 36 +++++++++++------------
>  drivers/clk/rockchip/clk_rk3588.c | 32 ++++++++++----------
>  drivers/clk/rockchip/clk_rv1108.c |  4 +--
>  drivers/clk/rockchip/clk_rv1126.c | 52 ++++++++++++++++----------------
>  17 files changed, 157 insertions(+), 157 deletions(-)
