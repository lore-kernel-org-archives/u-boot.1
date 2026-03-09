Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED38F417EB
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC48783F9A;
	Mon,  9 Mar 2026 15:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QaCaniOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C2183F9A; Mon,  9 Mar 2026 15:39:30 +0100 (CET)
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com
 [101.71.155.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923E883F6D
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e8275;
 Mon, 9 Mar 2026 22:39:24 +0800 (GMT+08:00)
Message-ID: <e7ba6e8b-05ab-40c8-87c7-13d0779c2a4b@rock-chips.com>
Date: Mon, 9 Mar 2026 22:39:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] rockchip: otp: Add support for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260131233843.3419737-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd309dbe903afkunm1eb2f22716bc5d9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkhMVkMdGhodGkNKQkNOSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=QaCaniOYW7xGFLVOllbw9F71aK8jBdhC9eDbix3OIO6ORJ/RmL0MeaesGTDQGSRSqz4V6GuFrzbh3CEQvncJ49RUwPWMkC8V+Jc5/wQGIjJHt71pWHOekFcVZav4qDfdlsTTS9ZdrlsKAOUB3dwheChanM25QORjgAyxavFpIAM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=8eZfEmY4omTRcts8JKH9nba8cJ/+EotuN70pf/TkP/s=;
 h=date:mime-version:subject:message-id:from;
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


On 2026/2/1 07:38, Jonas Karlman wrote:
> Add support for the OTP controller in RK3506. The OTPC is similar to the
> OTPC in RK3568 and can use the same ops for reading OTP data.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   drivers/misc/rockchip-otp.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
> index 46820425a84d..64b6238981b8 100644
> --- a/drivers/misc/rockchip-otp.c
> +++ b/drivers/misc/rockchip-otp.c
> @@ -390,6 +390,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
>   		.compatible = "rockchip,rk3308-otp",
>   		.data = (ulong)&px30_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3506-otp",
> +		.data = (ulong)&rk3568_data,
> +	},
>   	{
>   		.compatible = "rockchip,rk3528-otp",
>   		.data = (ulong)&rk3568_data,
