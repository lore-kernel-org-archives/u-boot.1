Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB2E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 21:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E20B48919B;
	Thu,  5 Dec 2024 22:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bcVcTLNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2A78952A; Thu,  5 Dec 2024 22:14:18 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86DE8907B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 22:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so9802345e9.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 13:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733433255; x=1734038055; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uWF2XwhYnF9NFc8RtT3fCpEm4M1OS5EQbwKivMSAuvg=;
 b=bcVcTLNnKKMaWaKqoSl2DBvxgtzp9NrTqBvVDlKaqTwevP1wP7+ntu0VwoJ2H442GE
 F2O7iDqOBjuWjQmeJLhIqaqj07OsImyGW/h3gVaq+vkc29b2P5KBzzf4wfxMba+L0Mbx
 9OxmHihFqHutcpTPWjkQ85x1/YUPVZoKlySUUnYT7Wt50QJle0MN8jAH/T0hB+SriKXp
 IoL5am7xunuhE3ku+ojAe1oojIbILYv1WrxwGvXTQw7DcngVpBrzWulU4zVkbVrFF++2
 SqZqQlBGqylX6VO6ICAsg98TF0IcsJsrVyWz1a/w/zHmVY2kqLkRj1N2A6khjNYGT1QY
 jc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433255; x=1734038055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uWF2XwhYnF9NFc8RtT3fCpEm4M1OS5EQbwKivMSAuvg=;
 b=iMFYi4Q4hHXqM8Y3jWwb6p/0s50sFOZ6KXMuj1UTSTbVrV4fShwEtElrQoHybaqIDW
 aMpVwE53+VL7Wh4y69CMWSyuB1PuxbVn+NhjMx15M0BnyuqAogBXjBcPxaNuEf1q6nHj
 DZ22ozqlB0IMYZOjEJ2UzjsdcBLA1eu1jAw6BC9ooVmc6jCvzsuf3dSCoh+fUIfJYJNZ
 huhGOF+/GUUcXD+OVN+eGRnR2DVKM5kNxvRDX5t8k6Nbzq1sAmWCe4kgH6JIfz6AzxpC
 NowTsTyLKVspM2aURVAW3sduKl/Xf8qtJ75EuYaDMQP1MK/74WY/7ylc2q41kHgzf2WW
 Lt1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2mQZtimtImNVSWZM7ERLLIAnoIW/3ySyJLVqMWsmFY1chzfFLXuKkGi9mBbPI/EqPcjRYgPM=@lists.denx.de
X-Gm-Message-State: AOJu0YyRqo2mGgQ9fvDaoE4zouPCNPxLdnZTF+ldMS3bZxPuOPRWcn3r
 X5hkI0EzovzZs4aosneTza+vgpiYJeJdb7m704srvnSfCJWrwjyzmG9VOQf7rnU=
X-Gm-Gg: ASbGncv5Nf2qjksJCQQBZHlHGfRQLR6jIqzq8J4peKIN57YBydQ30J61BgK53p+gKw0
 sNfw6QQDAYdYjriQX7dMEUmL+MAHubuhlU8puQFfASGI39+puj+0so6iBwWkaDBqA+DNM0l2prK
 WpNsNkzB28+zGfSyWRt7kB63HldgRUQcfVYXNqO5iQ2BtjzO7C07OWxZn1e+LmEP6o5XYqLWNAT
 Q/TT9eacr1tARhrIKL3EbPyHNnVKIPqtn9znFglMWtdBA4Hpljunu2qOR3Gb17VERBFlhGHxKbv
 WwjXQWqJWBZHAVlt8dJjoBYmBn2irw==
X-Google-Smtp-Source: AGHT+IECWzkZi0yuS7Ve8Mt4DNaJLfdRr6oIPkvXfqLBxlL1IPobYKhwekXhK4wre8Wg6ok6NEo/TA==
X-Received: by 2002:a05:600c:3ca3:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-434ddeb6731mr6628815e9.14.1733433255306; 
 Thu, 05 Dec 2024 13:14:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4d66:aea6:b365:82f1?
 ([2a01:e0a:3cb:7bb0:4d66:aea6:b365:82f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d04defb7sm77800045e9.0.2024.12.05.13.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:14:15 -0800 (PST)
Message-ID: <319aa51a-04cb-4d0b-a2f5-ce16a0db4d06@linaro.org>
Date: Thu, 5 Dec 2024 22:14:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: lwip: check if network device is available in
 do_dhcp
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20241205191736.21503-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241205191736.21503-1-heinrich.schuchardt@canonical.com>
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



On 12/5/24 20:17, Heinrich Schuchardt wrote:
> eth_get_dev() returns NULL if no network device is available.
> Not checking the return value leads to a crash when the device
> pointer is dereferenced.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/lwip/dhcp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 9b882cf5b87..e7d9147455c 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -3,6 +3,7 @@
>  
>  #include <command.h>
>  #include <console.h>
> +#include <log.h>
>  #include <dm/device.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> @@ -112,10 +113,17 @@ static int dhcp_loop(struct udevice *udev)
>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>  	int ret;
> +	struct udevice *dev;
>  
>  	eth_set_current();
>  
> -	ret = dhcp_loop(eth_get_dev());
> +	dev = eth_get_dev();
> +	if (!dev) {
> +		log_err("No network device\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = dhcp_loop(dev);
>  	if (ret)
>  		return ret;
>  

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
