Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB7AC44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 08:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67041846D3;
	Fri, 10 Jul 2026 10:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="L5QgoneA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364DC847AF; Fri, 10 Jul 2026 10:42:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3AD583FF5
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 10:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783672961;
 bh=X+D2AVC84qhjbhN6WBMdjXb6G7M+ocP7Apq3iYJUrPs=;
 b=L5QgoneA5JmXTLnf+T5/BLPKOSvGNk2d54R5GQqbobOa/SC9zrIhGOkYLEW18MhV99ApXPZLd
 eF0cuQ4x8C26fn8sSEsCnVAcZGAr7GgInyWwlD2xgdBLhCjWEZgrABBpAHjXwvRii/0m/5mXbR0
 mZrr3DkOni0jaYMadGu5u+hccu6mViUscPuzn2lAiVytpqtd+FspaVX0Q+G+DnaBn3eQBmIB8aC
 H3i7GAGCpg5KH8QMHWlkTwvOyl6mtmVmWizzchPz8kQ+1N7dFMLuw5/J2q9suOzGa0F5BxpV0JQ
 knTNojo1fTkPvDIMkSA1IpVIth0XOwDCptZdkR1a9GnA==
X-Forward-Email-ID: 6a50b07f99bdaaa2453e7340
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c58f2520-811d-45bb-ad64-c027ad64bbf0@kwiboo.se>
Date: Fri, 10 Jul 2026 10:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix regulator_enable/disable() macros
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, u-boot@lists.denx.de
References: <20260709231658.3517139-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260709231658.3517139-1-jonas@kwiboo.se>
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

Hi,

On 7/10/2026 1:16 AM, Jonas Karlman wrote:
> The commit 076265b75e61 ("compat: regulator: add enable/disable macros")
> added regulator_enable/disable() macros to provide a closer analogue to
> the Linux API.
> 
> These new macros wrap regulator_set_enable() that may return detailed
> error codes and should typically not directly be called by drivers.
> 
> Change the macros to wrap regulator_set_enable_if_allowed() that masks
> error codes consumers typically do not expect to closer match the
> behavior of the Linux API.
> 
> Fixes: 076265b75e61 ("compat: regulator: add enable/disable macros")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  include/power/regulator.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/power/regulator.h b/include/power/regulator.h
> index b8023721a165..ea79e0240b2b 100644
> --- a/include/power/regulator.h
> +++ b/include/power/regulator.h
> @@ -371,9 +371,6 @@ int regulator_get_enable(struct udevice *dev);
>   */
>  int regulator_set_enable(struct udevice *dev, bool enable);
>  
> -#define regulator_enable(dev) regulator_set_enable(dev, true)
> -#define regulator_disable(dev) regulator_set_enable(dev, false)
> -
>  /**
>   * regulator_set_enable_if_allowed: set regulator enable state if allowed by
>   *					regulator
> @@ -385,6 +382,9 @@ int regulator_set_enable(struct udevice *dev, bool enable);
>   */
>  int regulator_set_enable_if_allowed(struct udevice *dev, bool enable);
>  
> +#define regulator_enable(dev) regulator_set_enable_if_allowed(dev, true)
> +#define regulator_disable(dev) regulator_set_enable_if_allowed(dev, false)

I have realized that these macros are still only defined inside the #if
CONFIG_IS_ENABLED(DM_REGULATOR) block.

Will move these macros outside the #if #else blocks in a v2.

Regards,
Jonas

> +
>  /**
>   * regulator_set_suspend_enable: set regulator suspend enable state
>   *

