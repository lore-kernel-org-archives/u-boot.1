Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADF7C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657C183348;
	Tue,  8 Apr 2025 05:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JO3lWekq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C04833C0; Tue,  8 Apr 2025 05:24:08 +0200 (CEST)
Received: from mail-m32116.qiye.163.com (mail-m32116.qiye.163.com
 [220.197.32.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5781833CA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208bdc;
 Tue, 8 Apr 2025 11:23:59 +0800 (GMT+08:00)
Message-ID: <d6d8722e-661e-4fd1-9044-e991ab9a1d7d@rock-chips.com>
Date: Tue, 8 Apr 2025 11:23:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/30] rockchip: otp: Add support for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-24-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-24-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIaHVYYTUlKHhhOH0wZHx1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136d1b3a03afkunm110208bdc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6Lhw6HTJDSEJCL0gjOBA6
 EQ8aCxZVSlVKTE9PS0NJTU9KSUtJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTElJNwY+
DKIM-Signature: a=rsa-sha256;
 b=JO3lWekqTt4hMZmx/e3KGBhePl9zWQGnx3WDOgmB8sl1clc5SHkVy0oe+iprxXcftJqE0TZvchb7QKvQluMZIOuWGAQc8rImWWHHAvwZCSbYbtEOrXN+bkgNEwlotWskuf2rVQag1+L7sLu3DLFWgusb/FZtZZmps7VoaUpcYik=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=n28U0P2GJyymGn/f1tP0I6sWm858/0iwenNUqNHRtv0=;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> Add support for the OTP controller in RK3528. The OTPC is similar to the
> OTPC in RK3568 and can use the same ops for reading OTP data.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   drivers/misc/rockchip-otp.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
> index 2123c31038fc..b5597de39aca 100644
> --- a/drivers/misc/rockchip-otp.c
> +++ b/drivers/misc/rockchip-otp.c
> @@ -383,6 +383,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
>   		.compatible = "rockchip,rk3308-otp",
>   		.data = (ulong)&px30_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3528-otp",
> +		.data = (ulong)&rk3568_data,
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-otp",
>   		.data = (ulong)&rk3568_data,
