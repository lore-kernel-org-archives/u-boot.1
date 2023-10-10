Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C130FCD80A9
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 11:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051D686940;
	Tue, 10 Oct 2023 13:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="q0TssRyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B65486940; Tue, 10 Oct 2023 13:27:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C400B86725
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 13:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5f6d=FY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696937211;
 bh=jx72uUy7iVfEiWHwk5SqRw7gFKft8g1C2Xz0+71LSjE=;
 b=q0TssRyZVTxtL+bBWnNEPzHbpn3AOjAIwle3iGnoMxI9v5Quj9INo65POK/ClwT97trwQOPyk
 hKPHAJqPC7hOySJADJoBg5fQS1Y2KLFBqRcto6OJW7Cx7BKstiohajJPnK/+D1wEpMSU7Ly3u9h
 9LSXEy/SYp/te9CS6OuXzHbTBdsbyqlEWEzTelM9XAJGg1c3/3u1E7uDHTf6DjLIEhew9Kbd6PS
 rDA2I/DvyNjOr+cGr6fw9uAacLYDlkBa1D1AMNxn+Ew06uIPQIuoByizw9jjgJQ/RPvoX++cfLE
 wAHKp/nMRqw6gvcRHYoagxk0wF6xvhg+V9aeqjdnliIg==
Message-ID: <2a9eb8a7-461b-807f-f53c-5ef9f7fb7eb9@kwiboo.se>
Date: Tue, 10 Oct 2023 13:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/7] rockchip: dts: rk3568: Resync from kernel-4.19
Content-Language: en-US
To: Elaine Zhang <zhangqing@rock-chips.com>, lukma@denx.de,
 seanga2@gmail.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com
References: <20231010085155.31027-1-zhangqing@rock-chips.com>
 <20231010085155.31027-2-zhangqing@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231010085155.31027-2-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 652534faefcc9c1ffdbed7be
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

Hi Elaine,

On 2023-10-10 10:51, Elaine Zhang wrote:
> Resync from kernel-4.19:
> (a6cf6aca12c0 drivers: rkflash: Ajudst the dll strategy)

bindings should be synced from mainline linux, not vendor kernel.

> 
> Change-Id: I7b7134946b76dbd8963cfaafdc5b56750622855e
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/rk3568-cru.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
> index c1942422a438..251445cf7632 100644
> --- a/include/dt-bindings/clock/rk3568-cru.h
> +++ b/include/dt-bindings/clock/rk3568-cru.h
> @@ -478,6 +478,13 @@
>  #define CPLL_50M		415
>  #define CPLL_25M		416
>  #define CPLL_100M		417
> +#define SCLK_DDRCLK		418

This is the only missing clock that is defined in mainline linux.

> +#define I2S1_MCLKOUT		419
> +#define I2S3_MCLKOUT		420
> +#define I2S1_MCLK_RX_IOE	421
> +#define I2S1_MCLK_TX_IOE	422
> +#define I2S2_MCLK_IOE		423
> +#define I2S3_MCLK_IOE		424

These are missing in mainline linux, please upstream to linux.

Regards,
Jonas

>  
>  #define PCLK_CORE_PVTM		450
>  

