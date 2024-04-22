Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F382C07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273B688376;
	Mon, 22 Apr 2024 10:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CkQDcIe/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A1288374; Mon, 22 Apr 2024 10:46:02 +0200 (CEST)
Received: from mail-m155100.qiye.163.com (mail-m155100.qiye.163.com
 [101.71.155.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604918717A
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CkQDcIe/6E7jvGb9pe1m7T7w2ZDiOV+bm2uT6EIuccNMUk7X3oBRfB0+YNmhg0bOmqMImssJxJHuJ4K9+RDzUTt1hFyf8jHb2POTrY5szUNTGNlinJuoPoKaJUJzb6PKZmePrmFRIDCgtfkvAC9+S6vTkUY+DIyCZDI37UR/QUg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=J0677vjdnBh8tQXnj5z/0HHrLNL/9YfLyfVq2mj7fu4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 86B239002A1;
 Mon, 22 Apr 2024 16:45:53 +0800 (CST)
Message-ID: <63464021-44d6-4c13-8234-dd5627eecb6e@rock-chips.com>
Date: Mon, 22 Apr 2024 16:45:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] clk: rockchip: rk3308: Add dummy support for
 USB480M clock
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlLT1ZDTE1DT0pDHR5JSEtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04fbade103a9kunm86b239002a1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kwg6Qyo6MzNLPjodKxIpNh46
 PjdPCy9VSlVKTEpITExOTk5PT01OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUNCNwY+
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


On 2024/4/9 02:14, Jonas Karlman wrote:
> Add dummy support for setting parent of USB480M clock.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   drivers/clk/rockchip/clk_rk3308.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
> index 7515fc8bb244..c46b58e31626 100644
> --- a/drivers/clk/rockchip/clk_rk3308.c
> +++ b/drivers/clk/rockchip/clk_rk3308.c
> @@ -1085,6 +1085,8 @@ static ulong rk3308_clk_set_rate(struct clk *clk, ulong rate)
>   	case SCLK_RTC32K:
>   		ret = rk3308_rtc32k_set_clk(priv, clk->id, rate);
>   		break;
> +	case USB480M:
> +		return 0;
>   	default:
>   		return -ENOENT;
>   	}
> @@ -1117,6 +1119,8 @@ static int __maybe_unused rk3308_clk_set_parent(struct clk *clk, struct clk *par
>   	switch (clk->id) {
>   	case SCLK_MAC:
>   		return rk3308_mac_set_parent(clk, parent);
> +	case USB480M:
> +		return 0;
>   	default:
>   		break;
>   	}
