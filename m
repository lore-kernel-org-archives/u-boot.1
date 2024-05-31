Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58997C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 21:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E235088804;
	Fri, 31 May 2024 23:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="SM8192Vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A681882CD; Fri, 31 May 2024 23:55:24 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF3CA8880B
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 23:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717192521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/18gLwrIgcvQzjhKr51ct/faBKAw6IBSPTj7tSKnQb8=;
 b=SM8192Vg3LMks9Ipg8aguugArh5DAb0Y0lYwr+kig9cfTkTzS8vR5e8MERKY84rRa61bZk
 H1K1ZTR/M1xfXW5Z5o34xua5kDVj6TzdcsWw6diE+5EgKiG+MEp05HurJqL4dzF8Hx1QAB
 UIiZkL3FAk5twZ4uwAoA8Xzi1amZ+BtYW9R9FPM0LWBQCjjNfQlvZHYrr/hdZNIG+XGml6
 /yrBoN5Mc09/G2135TPnbCM7soz7deGeTB8xkfne7XL+43q15oCLbxMb01zJmPRqkKPhg6
 lrczMMCSbOc6NSJTwpDFBvW4ET/YlbwqMjwNsE0OKo0O3xSho2KHkDo+kj4mTw==
Date: Fri, 31 May 2024 23:55:21 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Kever
 Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, Jonas
 Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, Anand
 Moon <anand@edgeble.ai>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC v2 22/23] sysreset: rockchip: use fst reset for ARM64
 SOC
In-Reply-To: <20240531141837.13189-23-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-23-linux.amoon@gmail.com>
Message-ID: <7f5f6b4870ef298939d389a1a82c6b09@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Anand,

On 2024-05-31 16:18, Anand Moon wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> Rockchip ARM64 SOC will change cpu entry, only fst reset can reset it.
> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  drivers/sysreset/sysreset_rockchip.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/sysreset/sysreset_rockchip.c
> b/drivers/sysreset/sysreset_rockchip.c
> index f353f9b4c7..17aa191349 100644
> --- a/drivers/sysreset/sysreset_rockchip.c
> +++ b/drivers/sysreset/sysreset_rockchip.c
> @@ -22,7 +22,12 @@ int rockchip_sysreset_request(struct udevice *dev,
> enum sysreset_t type)
> 
>  	switch (type) {
>  	case SYSRESET_WARM:
> +#ifdef CONFIG_ARM64
> +		/* Rockchip 64bit SOC need fst reset for cpu reset entry */

s/Rockchip 64bit SOC need fst reset for cpu reset entry
  /Rockchip 64-bit SoCs need FST reset for CPU reset entry/

> +		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
> +#else
>  		writel(0xeca8, cru_base + offset->glb_srst_snd_value);
> +#endif
>  		break;
>  	case SYSRESET_COLD:
>  		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
