Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0A5CA600C
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 20:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2751E60873;
	Thu,  8 Oct 2026 20:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WMTSk7fc1_i; Thu,  8 Oct 2026 20:49:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EC0D6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791492561;
	b=HvfVIGZZzXfBcfgZYr4FlrhwhwA6D3ocr+vQMdcfCYuU03J92kMteGNpLP66MK25U9Z7
	 dXrKNbqaanK4I6UdZGE0IOAnYMniCeE2BLRsS3xXdmLRVaNwO2rbWP5WTopX8ipbDwDXi
	 kXDqFJcN9h62uOARMuZebgi0orEo4dVUPk3LAfqlKRyjOkdQYeg/4s5tgpImZG/yZTCYP
	 6Od4O1jmg+/wLhhgLFP1VuXYIbEsEKVRQnWAK0TvpOLNzGH0IlPn9OshLnltfyVEsH4Fa
	 hnQnuofV4uF+9BKYD8ReA6HgawkXxAZDMfegz7gj6kEsCXSLeM/pFJBBr54xd42m2jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791492561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uypCYudePGls+JKjgnrVvjq4O8tCu+2YcBxCLprXt3s=;
	b=JvdqyzyXsedPsWIbywmKKa/gzkej8hNB747S1e/K8Ov+TyOS672pQMQezuypvUpkWL9E
	 od0fzKNV/E2oO5d8HlUUASv0J4ZaNResN//Jyhgx7t50ueH70wQ6rFccEmrKSKX9XiunY
	 G79kte80l27S7y1JiziTvVnyL25KQZeYH3938nFfr9OsgysTSevehlKk6UM3l3IC2voe2
	 c3uCks7sVbTA9YtE4paDw7kt0XEDJSZH89tL/iTIZuoZhaOOXk2f01zI+8Y3Vk07yxD5l
	 z/FK4KwWsWAH1p8CKfDRGrOBGadGBcfckluWa43jtZwJ4HsCqyivAzU/N8km2k2uFZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=UI1g67Gp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791492561;
	bh=uypCYudePGls+JKjgnrVvjq4O8tCu+2YcBxCLprXt3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KG+vOyFoj1R/mfMzeszKu0XarzVodjqLfZqIZeJ0gE/NSNZ/4Rhp+ehgYih8MXRmo
	 tQ7kezovCL3IDMw15I6JpS7qVSgBAgYhdngulUk6I/yFlGvwFYvKRqOBAwt4bQdM8l
	 k0XkmiUfFipLQknZtKIQ81wBBV12Lv6AkLtFcoA/4Jlcnh51OdjUYC96D9aYyXDSaa
	 CGYxRd0oR0xNog6nDaJGk9KJ12GweLqz6xGHWTajjvYCv3ks3bxTnAbFVXk68YBSga
	 0boBpn5YTyZTcCw47N5lUD0C3tZT9cHKVeIoYzsHnmS7MlT9ZIJi8uY/aecT/SbSSO
	 oL8OxvcP8949A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EC0D6084A;
	Thu,  8 Oct 2026 20:49:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 595592E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B1E36084A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id amsA8mwfE3j6 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 20:49:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7B9260727
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791492558;
 b=i5qbMfNbpq9bN2kevSE+jMqpms/IcgezVokUOK2ZIzfvmk2dKAPMABIMKVp135inPXIT
 3Pgm+7gIRGiPvlYE8DbKAsvtNkl8US5Nbni/35l/0ELUWz7gpseUsV1hIdXct5ux89zvu
 IPNAwuXddUJJpGQ23jZ9yHtjcNszqCADSeosgyJYqy4pHrIYQttZhz0ojnEPAN+MV65/6
 FFOcRHdtyVd9DWcn0qVimYf1YQJzGvPhrXPEe1/CX+ONA4WIArM2Ou8ey91qjLEXCzwJS
 gsS6kxYhvxinTskDs9yVOs5FJfwGQ4DoFa7/vBiqrVNHGtS6Ou0c3Op+l0eyaCo+hYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791492558;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=uypCYudePGls+JKjgnrVvjq4O8tCu+2YcBxCLprXt3s=;
 b=bh/e52eTLbsEujAmebG+oAodj3pUZo4PE9rS1YSXooS49Caxr0ub3xWujLpt1e+sYatA
 4u02xrngj+kqPs4qUirp1TOI+IyUVixs7ZMHl1cZsApe3rB3Z1HvC/LN1/IkHZzehlF1a
 5NFE5+gCSsv3nB3TJaK8fTmdm2N2EoHPe9UYutvXpGEydxSlTn2IhPhcFrwVUWu4zofpY
 98QwE4FLoSTtLkwqOh16uZx5MEVrUCNGO7MHr5YCBbV0AKBSwz/b/Rh/r+caKWRkBIRIv
 JjFqVDGsiG3+W7Yyl49C9doYp22wOaGUA3/+xxCZJHaHRmUZ71P6DmaVCU6QBR1df9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=UI1g67Gp; 
 arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=UI1g67Gp
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7B9260727
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:17 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j12Cr0J76zR9h;
 Thu,  8 Oct 2026 22:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791492551;
 bh=uypCYudePGls+JKjgnrVvjq4O8tCu+2YcBxCLprXt3s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UI1g67GpE7OZcHScpeGXD04b/s4XUKjCEeBZIBXxLtWEwWiOdZrXyOv93Y/QEysyw
 8iuYHpa2FTgavOBxEPhBe2Ey4+3GUJxrnJNNa1SfCo8lkbh1bYQr3ip43Mq/zP+EHO
 EEqTAek3eBRjttyh27f4U6EhXdkX2NyT3vaA8DSZITKQmLkUiC69qTB61qWlrvXTb5
 rRGchwI2G+0WtjzyubpedkoBygRAkDiJl1xeUc62QP0hoOddlnjc/iLRAA+CtFIP+/
 1u92DYWPQxy662xqtquOoGfbCOxDdJo6+o4aieGwrOiYfaBw5wIaiGt4kMaozHi9eY
 GTSgaI1gcG/JQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j12Cp3nlZzkpl; Thu,  8 Oct 2026 22:49:10 +0200 (CEST)
Message-ID: <2a1d6192-5d60-40da-9c7b-574117d5b3af@0leil.net>
Date: Thu, 8 Oct 2026 16:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: rockchip: rk3568: Always init clocks in SPL build
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260804002643.2308515-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Jonas,

On 8/4/26 2:26 AM, Jonas Karlman wrote:
> The ACLK_BUS clock is initialized to 150 MHz in SPL on RK3568.
> 
> Ensure clock driver is always probed after bind for SPL builds to
> initialize core PLLs and clocks in SPL phase on RK3568.
> 

You explain what this does but not why? What are the symptoms? Why is 
this the proper way to fix the issue?

Based on Heiko's message, I'm guessing the issue is that we need 
something to setup clocks that are only accessible from the secure world 
and SPL happens to be running in it, but not proper (nor is the kernel). 
Hence why Heiko needs this in order for the "DSI panel to work again" 
(I'm assuming in the kernel hence why any fix in any driver/device tree 
to enable the clock is not gonna help with the issue).

This seems to be a bandaid patch instead of fixing the issue (that is, 
the kernel should enable/control this clock through some mechanisms, 
e.g. by interacting with TF-A through SCMI).

Heiko also said "my DSI panel work again" which implies it worked at 
some point and got broken since, so it'd be nice to know what broke it 
so we can have all the clues necessary to fix the issue in the long 
term. Considering we broke something, I won't resist too much on this 
patch even though based on the above guesses we're fixing a kernel bug 
in U-Boot.

Can you please confirm my guess or clarify?

Cheers,
Quentin

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 9f3e9322161e..5a05f1b4de00 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2934,6 +2934,10 @@ static int rk3568_clk_bind(struct udevice *dev)
>   	struct udevice *sys_child;
>   	struct sysreset_reg *priv;
>   
> +	/* Ensure clocks are initialized after bind in SPL build */
> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
> +		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +
>   	/* The reset driver does not have a device node, so bind it here */
>   	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
>   				 &sys_child);

