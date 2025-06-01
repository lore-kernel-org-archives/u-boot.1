Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D940C54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 21:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C75B8296B;
	Sun,  1 Jun 2025 23:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="B8LOraZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F48382991; Sun,  1 Jun 2025 23:07:24 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C348294C
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 23:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4DD813F885
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1748812041;
 bh=Zp3J4cEA2akR7oY2x9sCAx5oChEODU0ln2cWp2tQj/I=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=B8LOraZ7TweKFsnFEHGmbDZ0/eobpYa+Y6VI6OdzB8L1J1OKrPrnPJgyvEI41IfPQ
 aPNjQpU82wLue6FpZ6AxUmsBz/5+mfFB+ell0ApzdRD4FTWKBvYhwNAWp/33glT4o8
 nCrXRxDNYsBANjBWnryu871dgMVG6k8luCLJ2BGRO4FgJ7PhVD6xs3mmQBV2dDdW/Q
 v6EjQ9Q2jjYO8xoDnV36bcuA9wZU/bWrncZaXAa2ZrJbGJGy3Apjq5j8IU436h2FCc
 b/bX1f4zbgo9VyZg+hGA6NkTmAq9fLDfZvp3S9m77o1R1g0I9ZYCY+KyS9NmXfs+5R
 XWlpgvXeAd9Rw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d8cee684so9748925e9.1
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 14:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748812040; x=1749416840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zp3J4cEA2akR7oY2x9sCAx5oChEODU0ln2cWp2tQj/I=;
 b=wnU/ffdKflVwXGL8ION0fGojfJMya/k/np5fI+Jk9KLgijKSwg7PinyRVACjLETiEk
 n48gUeXnCnUAgXQGh9NgY0fgT9uMzj3KJAZaAKEueoTF2eaFGYYruw7l4WY2bFPwtUim
 1MXSSQmxIg3ATBhfznph91IGweOHmXBzoaHQZyv+QQZj9oJScdRe3gCEvy7SPl77gdm5
 f08AyRk6WI4vH0cdYFHTkbQ1/UAlQmnk7gWM88F1g8HLLe7EemPHJXYwyL9qyK2DzDkw
 8+i38spaVS6IzHigdaIw6kCLO0IOpfzoQPU49auuLH0NvuVN9zy0JQXrPzyqS2CD1WvV
 RdEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjngdrJFlnknQRH+xQvYYQWNqhsxz5QbRW+v+lXMUOtn0It+xtjXehoaCn5h3G6rbZ7llAa+Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp+tMg1oKF59bXJfhjAHqj6nsoGiC8oIkVNaucL1NFPG9JSQxi
 UzEfOVNOkA0Nu00BOJcjWPo1rtiIuEfmzAOnf3pkskd5uri75totUTVgx2On+nNQXsphMMasrHA
 eshvCLOn808p152yRtj3rc2xRJyEZZJruED52XHRIb9qVq97Bp5cEtdlO4E+dj5Hm9OWtJKs=
X-Gm-Gg: ASbGnctA0SDz7LV6pxhalfLf0V+uxR7L+SXyB+in+fX2TGlbgulEZdiFMP2ITZn2NVR
 nhm0wC6FAMfpucrXG+M0XXUo8ifa9tBtcoJ203rMNZcsGYsr3sDAVn0a43Ly3DoYPxG05eN9SAD
 Phnd7hjb+4GOLe5FaYzp3fOrhoHDpRbv8slTUbShhRUcbLtAnNzuDkF2pOZetOsgI2n6xMmR4/L
 mm877inE9YsZ8bSWeRABUeWGtCYG3X8k6gQIAcAMF/kzyy5O7SlK/wfe7xIeIabXvcVwXzsvWWx
 2w/6fm1ZUBOvMR0PnFJTOgZR/qjRsBeQFjTyGvk8k45oxidQwhavL/3/KdWeRS9+ntEWs+yRxhB
 foougeRaC
X-Received: by 2002:a05:6000:2485:b0:3a4:e1f5:41f4 with SMTP id
 ffacd0b85a97d-3a4eeda2f6amr12610760f8f.17.1748812040296; 
 Sun, 01 Jun 2025 14:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3jR57uN5KGvc3xjUoCTrDiFqdpcU/eS5hgmyO/xMpL91pyJVuTCjFfEPQHMguBBDWtAzx+A==
X-Received: by 2002:a05:6000:2485:b0:3a4:e1f5:41f4 with SMTP id
 ffacd0b85a97d-3a4eeda2f6amr12610749f8f.17.1748812039858; 
 Sun, 01 Jun 2025 14:07:19 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f67sm12379627f8f.47.2025.06.01.14.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 14:07:18 -0700 (PDT)
Message-ID: <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
Date: Sun, 1 Jun 2025 23:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Anatolij Gustschin <agust@denx.de>
References: <20250530153826.1057407-1-tharvey@gateworks.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250530153826.1057407-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/30/25 17:38, Tim Harvey wrote:
> Call schedule() in net_lwip_rx() to service U-Boot tasks and
> actions during packet rx.
> 
> As a cleanup also move sys_check_timeouts() here and remove it from the
> functions that call net_lwip_rx().
> 
> This resolves the issue of an active watchdog resetting the board on
> long network activities.
> 
> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2:
>   - remove duplication of sys_check_timeouts() from functions that call
>     net_lwip_rx()
> ---
>   net/lwip/dhcp.c     | 1 -
>   net/lwip/dns.c      | 1 -
>   net/lwip/net-lwip.c | 7 +++++++
>   net/lwip/ping.c     | 1 -
>   net/lwip/tftp.c     | 1 -
>   net/lwip/wget.c     | 1 -
>   6 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 92bd7067a7fb..b79b746db390 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
>   	/* Wait for DHCP to complete */
>   	do {
>   		net_lwip_rx(udev, netif);
> -		sys_check_timeouts();
>   		bound = dhcp_supplied_address(netif);
>   		if (bound)
>   			break;
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 19172ac959ac..738f8bf3196b 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>   			net_lwip_rx(udev, netif);
>   			if (dns_cb_arg.done)
>   				break;
> -			sys_check_timeouts();
>   			if (ctrlc()) {
>   				printf("\nAbort\n");
>   				break;
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index f05c4cd3f64f..e8d4cc542ed8 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -13,8 +13,10 @@
>   #include <lwip/etharp.h>
>   #include <lwip/init.h>
>   #include <lwip/prot/etharp.h>
> +#include <lwip/timeouts.h>
>   #include <net.h>
>   #include <timer.h>
> +#include <u-boot/schedule.h>
>   
>   /* xx:xx:xx:xx:xx:xx\0 */
>   #define MAC_ADDR_STRLEN 18
> @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>   	int len;
>   	int i;
>   
> +	/* lwIP timers */
> +	sys_check_timeouts();
> +	/* Other tasks and actions */
> +	schedule(

Some scheduled tasks have a long duration, specifically video_sync_all() 
called via video_idle(). This change will lead to lost packages.


@Tom, Simon

The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule() 
instead of WATCHDOG_RESET()"). This added schedule() calls to EFI 
networking. Package losses can expected if schedule() takes more than 1 
µs. This is much shorter than the time needed for synchronizing a 1 MiB 
frame buffer. The cyclic framework was explicitly meant for short 
duration function calls, not for long duration tasks like syncing the 
video frame buffer.


I think we should remove video_idle() from the cyclic framework. 
video_sync_all() should only be triggered if there is video output.

Best regards

Heinrich

> +
>   	if (!eth_is_active(udev))
>   		return -EINVAL;
>   
> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
> index d8042ceecf99..1390b914f7d8 100644
> --- a/net/lwip/ping.c
> +++ b/net/lwip/ping.c
> @@ -136,7 +136,6 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
>   	ping_send(&ctx);
>   
>   	do {
> -		sys_check_timeouts();
>   		net_lwip_rx(udev, netif);
>   		if (ctx.alive)
>   			break;
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index fae701bad2eb..7495dc077ba5 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -200,7 +200,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>   	sys_timeout(NO_RSP_TIMEOUT_MS, no_response, &ctx);
>   	while (!ctx.done) {
>   		net_lwip_rx(udev, netif);
> -		sys_check_timeouts();
>   		if (ctrlc()) {
>   			printf("\nAbort\n");
>   			ctx.done = ABORTED;
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index ea1113e18b11..fcaf684e61da 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -525,7 +525,6 @@ int wget_do_request(ulong dst_addr, char *uri)
>   
>   	while (!ctx.done) {
>   		net_lwip_rx(udev, netif);
> -		sys_check_timeouts();
>   		if (ctrlc())
>   			break;
>   	}

