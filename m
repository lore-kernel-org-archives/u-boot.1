Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD67EC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 14:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B1688232;
	Tue, 14 May 2024 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="U98ZDF4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7E788262; Tue, 14 May 2024 16:51:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A7B881F4
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 16:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=71b8=MS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715698265;
 bh=1HJvWSl1slRMeKHlXnoWIjzO4ekg3KE78EtvNsO/bCw=;
 b=U98ZDF4Fmdz2Lhvb4suQoR+AngpM7f0KNh5OQyo7EcgqwMeP/xRdU/Tleg3nwt5gfoEqnQXuI
 AIAnWIn8NhoXz9nZnasW/biFxbOTTaQUYFLkvALwz1O7PTo8fV0i5cl/ZjeOYqTflKX9gUx/sla
 a2dXqn5dxN/y7esreu0t/ibQ2cSHsivqfqDllNjrQnDAC3Q7MgZo2IN4rA47Y91OLJzapyBDEo8
 1/aEwaxwy4lRJCOVfc5yZV+MPfMFxUAPCn8S4zD6+DT9TOR6hBFJXRn7PaGXgNIq2T0VU/Xyed+
 8f4LpRLFcszhXwUQvMnr25QxUxjQNtF3TdGS2hxSlkJg==
Message-ID: <6bbce6d6-35a2-49f6-b9a1-36dbebfdb9e3@kwiboo.se>
Date: Tue, 14 May 2024 16:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] syscon: Probe device first in syscon_get_regmap
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Paul Burton
 <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Sumit Garg
 <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
 <20240513-boston-v1-9-fac96938417e@flygoat.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240513-boston-v1-9-fac96938417e@flygoat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66437a589f1ed1a30c1918f8
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

Hi Jiaxun,

On 2024-05-13 20:13, Jiaxun Yang wrote:
> When bootph-all is enabled for a syscon driver, the device
> may leave unprobed when syscon_get_regmap is called by another
> driver.
> 
> Perform device_probe in syscon_get_regmap, there is no side
> affect as device_probe will return 0 quickly for an activated
> device.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/core/syscon-uclass.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/core/syscon-uclass.c b/drivers/core/syscon-uclass.c
> index f0e69d7216b3..b09f7013194d 100644
> --- a/drivers/core/syscon-uclass.c
> +++ b/drivers/core/syscon-uclass.c
> @@ -32,10 +32,14 @@
>   */
>  struct regmap *syscon_get_regmap(struct udevice *dev)
>  {
> +	int ret;
>  	struct syscon_uc_info *priv;
>  
>  	if (device_get_uclass_id(dev) != UCLASS_SYSCON)
>  		return ERR_PTR(-ENOEXEC);
> +	ret = device_probe(dev);
> +	if (ret)
> +		return ERR_PTR(ret);

Please explain in more details what the issue this is trying to solve.

Typically syscon_get_regmap() is called on a udevice returned from a
uclass_get_device call, and that should trigger a probe for the device
and its parents.

Adding device_probe() here possible just hides an issue that exists
somewhere else. In what instance are you ending up with a call to
this function with a udevice that has not been probed?

Also, please add a new test to test/dm/regmap.c if this solves a real
issue.

Regards,
Jonas

>  	priv = dev_get_uclass_priv(dev);
>  	return priv->regmap;
>  }
> 

