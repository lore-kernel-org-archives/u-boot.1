Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34679C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 07:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3B987683;
	Wed,  1 Nov 2023 08:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dNFOrEU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 495FC8768C; Wed,  1 Nov 2023 08:47:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60502874A1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 08:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4da3=GO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1698824845;
 bh=pahlAj5n0nxNwZmw+C6+k2EVEf2iZ5NaKP7PigccO14=;
 b=dNFOrEU6vtKmV9yOx4SKgTKFuYDixxk3qMm87innZcPmQYUoY5zs6uWkCLSR0yyr2381G2iLh
 4Z68mX3xbZBR2g3MruqgAlqBNRKKdg29YjNTVTdI57OTPcQOi8zyViaiQXmNNEgcme/ACyEdT0j
 chrYmtXiLDCJSWRE4JX4dfp7qjFVdNumzhr5KvoJQd5igOcNPslrSnbOm6nOY/dMTzJ5D4oIn5Q
 jBWh53PdqWfX36RlKt9DOYyqaWeJ1S2Yc2OKe2gbslOzEQdMGB87DKveMa8Us9EzEjVQ+1HKQN+
 UPWl0zGPTr8Psb+BsXjL8EbbAbOMCCYXiOxjl8FusDBQ==
Message-ID: <ea09f0bc-738c-4585-bc2a-eab3cd7e59ec@kwiboo.se>
Date: Wed, 1 Nov 2023 08:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
Content-Language: en-US
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: sjg@chromium.org, patrice.chotard@foss.st.com,
 eugen.hristev@collabora.com, trini@konsulko.com, u-boot@lists.denx.de
References: <CGME20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d@epcas1p2.samsung.com>
 <20231101072316.190541-1-jh80.chung@samsung.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231101072316.190541-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6542028d46d4df917e94c689
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

On 2023-11-01 08:23, Jaehoon Chung wrote:
> If reegulator is already enabled, it will be return to EALREADY.
> But driver that its function is called can notice as error, even though
> it's working fine.
> 
> Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/power/regulator/regulator-uclass.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 3a6ba69f6d5f..fc1c3eb93c9d 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -187,6 +187,10 @@ int regulator_set_enable(struct udevice *dev, bool enable)
>  		}
>  	}
>  
> +	/* Regulator is already enabled */
> +	if (ret == -EALREADY)
> +		return 0;
> +

Use of regulator_set_enable_if_allowed() will cover this error,
and regulator_set_enable() should continue to return this error.

Regards,
Jonas

>  	return ret;
>  }
>  

