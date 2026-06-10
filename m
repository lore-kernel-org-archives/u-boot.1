Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF58CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 13:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83C7848A1;
	Wed, 10 Jun 2026 15:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0Xiq1KuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA525848D8; Wed, 10 Jun 2026 15:26:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0668489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f906=EH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781097957;
 bh=irOSFb+VaBx0iI2LbGub6+wkmghFWJU432rOeL/QCfA=;
 b=0Xiq1KuMu595NwOGYx5PSqbcye1c518W7c921bRAPGTWY5OdzMph5FOiUOeKx+PAu2UQuvra/
 e/eWZr0RvmDxyeOHcKVU5hXGc3x7oSVKK5kU4OguZ95aQN8QiZMRGfcrXgr6aDmwHi3hk0p0G7T
 Be2xM8YxXojOIo7aaQt8drzx7O2UcelOnUD9kNHNccCkB2x/b8o1TihpLYzE/VLf0DT9gSCafV0
 8GDauR25k5rcZfDc6GhamsYf+iB/TCkOkhuLNnXkC+7B0tJpxiVNbmpseBQ0+o2SH5H6s3FtT63
 nGyxtvNNdoURQoAhRaTv5cZfYJDSNiy3ZoG4BicbunmA==
X-Forward-Email-ID: 6a2965e244d40883ad214708
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d3e58ad8-24b5-4de9-a01b-adfd4825fe75@kwiboo.se>
Date: Wed, 10 Jun 2026 15:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: boot_mode: fix download key detection
To: Tianling Shen <cnsztl@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260610030154.173455-1-cnsztl@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260610030154.173455-1-cnsztl@gmail.com>
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

Hi Tianling,

On 6/10/2026 5:01 AM, Tianling Shen wrote:
> rockchip_dnl_key_pressed() looks for the ADC device by checking
> whether the device name starts with "saradc".
> 
> On RK3328, RK3576, RK3588 etc., the SARADC node is named "adc@...",
> so the device name no longer has the "saradc" prefix. As a result,
> U-Boot fails to find the SARADC device and does not sample the
> download key state.
> 
> Do not rely on the DT node name. Match the bound Rockchip SARADC
> driver instead, which works for both "saradc@..." and "adc@..."
> node names.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm/mach-rockchip/boot_mode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
> index 55e9456668ae..363fad523cbd 100644
> --- a/arch/arm/mach-rockchip/boot_mode.c
> +++ b/arch/arm/mach-rockchip/boot_mode.c
> @@ -51,7 +51,7 @@ __weak int rockchip_dnl_key_pressed(void)
>  
>  	ret = -ENODEV;
>  	uclass_foreach_dev(dev, uc) {
> -		if (!strncmp(dev->name, "saradc", 6)) {
> +		if (!strcmp(dev->driver->name, "rockchip_saradc")) {

The adc channel used below may not fit all boards/SoCs, so this change
may have unintended consequences.

I have previously avoided "fixing"/enable this code path for RK35xx
because the download key selection should really be improved when this
is fixed/expanded to more boards/SoCs.

E.g. maybe add support to declare a recovery button in u-boot,config
node and use UCLASS_BUTTON to check if such button was pressed or
something similar?

Regards,
Jonas

>  			ret = adc_channel_single_shot(dev->name, 1, &val);
>  			break;
>  		}

