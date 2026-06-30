Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876CCC43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 16:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC62F84A26;
	Tue, 30 Jun 2026 18:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zE0n4iiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB4584AA6; Tue, 30 Jun 2026 18:35:22 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF388498C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 18:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493a5d32e8cso29125675e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782837318; x=1783442118; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LuCIWLvmbI7nP60HjrHzXLDPJXQ0ferC1G9GDyLnhTo=;
 b=zE0n4iiIO2v+YHx3UmD5sf/fnAVrKgGxDctZVkg4PH8XJ3jbFQ26NJFym4y6W8kBI2
 f1nizKVu1g7XYRb4jfifLjKe4dTW4EJ30uMyDP2XRwWaxb0SblRlJCmW8Dv/edr4EGy0
 AFtucQwg3arezcVt4KYZsfCUy9Djf+dFgc+VbrSfX7xq3XqVeM+I9vYyANkdNpXFnBP/
 /XdpayMJUDLwHnXpMV/UZeabTj5fMpN71aFqeks6bfzXLs0hHriIOyJrUJ2nNuYq8ShR
 mFNBkihazq+QVqHugSXbfo3gXiQvlfCV1hlA34xwvssCofExYPXDWPfxMWeZDhaS7tej
 x4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782837318; x=1783442118;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LuCIWLvmbI7nP60HjrHzXLDPJXQ0ferC1G9GDyLnhTo=;
 b=I1Gk2ANqvaFfyDe0H09HSlLNDFADePu1iqM8sSipGEdlCYEOOjGLWuOy/iFA4AQsRP
 /igxK75/BSbbttg9fXUrc5ehhJhuh7Bd6dTK54MrGbfzIrA87dV5JcxBm+qsGCmAWuqo
 0LJYIWYv+vKBKj5/1995D6UK5AvabryiRO1Xv9xDqvDurZZiWTwZSj5Z/4LQCeVr0uxQ
 U3V3ITrNKV0RVROhek8pD4JJ+CCg0pglFxaus9E/21KWlhli6STxChQDKq8qcnMCoFM+
 QhNNkgUbaf+6Dk3+HMYAPxaRyt+sLGOU/dL1vYeF43w2PkZ5UD36KZClNfrOpm+u+opm
 pMeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vDCHLxm/V7LY8EKPCS94diNM4K0gt2xlzPJBcahIu6MsM3CCZn3sAyMD5eyqqvyxlM/joID0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/vUDUGU1+4zwXxVPsfP4vqzsasvfr1SARUeN4Al3tGHo+B6/x
 1k2oCOd5ny45MlIvwqmi3nCL5OBdDS1DUCWGwsZKgi2tYzjY/5VR4YKwySuaVCia6o8=
X-Gm-Gg: AfdE7clO8kaxUbbNUky2ufK91eNtmZQQM5qZ4OoO/P4vu1kw0r1wz/TP1IOo3u7coCB
 5oQ8j4kmSYk4LZvW8FGsmw5UIgVzO3A+q6erm2WbA0dSLZGiUI5aW/RTN7w+H3eKDP9OAgYf+kl
 xodZIGFSRgazkSMS50+HTop+yLbrAOhph1X+OIL9IzQcowFoMgrHyeY7K4i5SU3rU/uSU9KpJ87
 uuhNi+yHQCqezh7QrcWTvgr7M4z8MGIaxG14VNRiLLWB0tpSbLaWCiD3WXBqatsmob0Jnw5AmgW
 XEMOoOdzV8AUBJZ5W/HKcieK9++Plaau/HSbBBEn77Xpv20qM4TZr4SWQbiQdMV6GKUfcKAe3hl
 Ceopfuha8UrhrWmXbtTrr0GfhDq/zrYhKmUdSPtrTlbWbENTAXFSRCIaNmPrG/sM4TwKw4PM/FM
 1zp22HAwZ02nx+rwuX726FKRZchxA=
X-Received: by 2002:a05:600c:5487:b0:493:bdd3:4313 with SMTP id
 5b1f17b1804b1-493bdd34339mr17401205e9.8.1782837318554; 
 Tue, 30 Jun 2026 09:35:18 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4dd77bsm5768785e9.10.2026.06.30.09.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 09:35:17 -0700 (PDT)
Message-ID: <ed287e29-7b5c-414b-b4c7-fa9913471bbc@linaro.org>
Date: Tue, 30 Jun 2026 18:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spmi: msm: Fix V5 ownership table offset
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 mateusz.kulikowski@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 me@ziyao.cc, patrice.chotard@foss.st.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260618162718.1984873-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260618162718.1984873-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 6/18/26 18:27, Aswin Murugan wrote:
> The driver reads ownership registers from the wrong address for V5.
> The ownership table is at offset 0x700 from spmi_cnfg base, not 0x0.
> This causes incorrect peripheral ownership detection and potential
> access violations.
> 
> Add the missing 0x700 offset to match the kernel driver [1]
> 
> [1] https://github.com/torvalds/linux/blob/4b99990cdf9560e8a071640baf19f312e6ae02f4/drivers/spmi/spmi-pmic-arb.c#L1737
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/spmi/spmi-msm.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
> index b89dd0b406b..a665850cd65 100644
> --- a/drivers/spmi/spmi-msm.c
> +++ b/drivers/spmi/spmi-msm.c
> @@ -260,11 +260,21 @@ static struct dm_spmi_ops msm_spmi_ops = {
>   static void msm_spmi_channel_map_v5(struct msm_spmi_priv *priv, unsigned int i,
>   				    uint8_t slave_id, uint8_t pid)
>   {
> -	/* Mark channels read-only when from different owner */
> -	uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
> -	uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
> -	bool prev_valid = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_VALID;
> -	uint32_t prev_read_only = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_READ_ONLY;
> +	phys_addr_t owner_addr;
> +	uint32_t cnfg;
> +	uint8_t owner;
> +	bool prev_valid;
> +	uint32_t prev_read_only;
> +
> +	if (priv->arb_ver == V5)
> +		owner_addr = priv->spmi_cnfg + 0x700 + ARB_CHANNEL_OFFSET(i);
> +	else /* V7 */
> +		owner_addr = priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i);
> +
> +	cnfg = readl(owner_addr);
> +	owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
> +	prev_valid = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_VALID;
> +	prev_read_only = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_READ_ONLY;
>   
>   	if (!prev_valid) {
>   		/* First PPID mapping */

