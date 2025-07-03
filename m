Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C092DC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 07:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507D982A76;
	Thu,  3 Jul 2025 09:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qAYe0ANI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D6A882CFA; Thu,  3 Jul 2025 09:32:04 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA2281FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 09:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so4974271f8f.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751527922; x=1752132722; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nNH2j4Z7HQ+mEtYQCwSkWPkzO9PPA2uba+JuqvdN8oE=;
 b=qAYe0ANI3oe4Jry9hFJbawJvE48Unh7sYk5vPfIkehrcqLwBl0uXc5w5VnK9UPAxrk
 hHC/3wv8/hn0bfM5RrD4E1UZ9Y+rX0ae3ZL1E2ylyno/BBo7zRexVfYdsAanfal16hvJ
 DNmvWqs7DgbewxaciZ4PqqPPTdlZaSXi0sXsRZuEbDeXhaL9zJ7cKEV4yvcFHZvEdbKv
 8ssMNEcG48nOu6PthqIx4qBFpaGvuWCYW7Yh9sexbZFJD5Bsx3t0dgb+jUh1F9bVqP0A
 /45oz+JJYQLzWBQure9rRloer+ePm+jRBOfNMkhe1H9tIhiokS9NSCDlrn6EHqpBNii5
 ASWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751527922; x=1752132722;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nNH2j4Z7HQ+mEtYQCwSkWPkzO9PPA2uba+JuqvdN8oE=;
 b=f8n+FoZjqZlZ8Vxs2Cl01tKwqkLJnX4yc/a0k1hVnUJ0K+32c2UnMo143V1+Sb1O6w
 EA/W0w6K90JqCzzYp9cXf2+WvMGclre2+O3uaP4xonhMkRA5dVE7zV9H2eA9mmiYomfO
 clt899g1Nvp9+0u/7S6Abyo2F5SLjVMtm1WJnJkgSxaXSjvJhGXPi38Z5+THipM2mncn
 PNE731UhYvGQI8U5yoGMnVWPLybE3WK9sRhvnWi5ku1zeRAThroJKqbjvmCaR2hZD0mA
 HhuUbxFrPxCAwv2NEc+r4UXRRMcMXMdPoDGgxtl+rCwNu3SyyyU1QzmCqNXupYUyNOGC
 02ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOQJ5/X1dRKvloIBZK70qO92t9kjg45guFQH1FIRCZGqRw70O0sjGAVABr66DlufVK+Z83lzQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxvGR5LIbp5YxSbFc+t/0Wv4GjuACX58FaEJV6GwsUjctl0rVvg
 FHpF8ZHMQUwvfGPCbOW1gHk826uTZ55SWUXceqsu41ErC646FDXZa3Rd60oAJxjNwZA=
X-Gm-Gg: ASbGnctPRzWDVPzTF9I2yvbQGj7h122y3t+IqseFM3nT0gY31JaO6ly8ZQmOQGNkGmM
 rylwmnbKW6w+/SQ39kC0NuQxqgBS5IqmOPdjjYwBRbdwLhPrGqQJk48xSTrKBKm9+NIvY5YkMwE
 PHxtJ2onj09H/Dk938k0Q+UPU5y+zo2SXiAKnnZ8ocAzzCJ3dn/s+PUJMFrW3BSPOAOaGFcKObo
 PflHNPO8xHcDCTstXDRbu/sYAK+CnqgitXY9niBqAgo35UuIPNXTSHPDD1kWOh8MZ5cTQdqYtB0
 BhVwuYiT37iPRq13b3c37P3RmTIEn3PkyiqPERMWF3O5rlV+c4P0jw8W4oQ+qSB20UcBQVu/R5Z
 wNHjbgnzWE2Zgm60nSVl/ej8Q5P3rV6y/BdlY0Jk=
X-Google-Smtp-Source: AGHT+IEj4e9rAPZ/gwykFoAp+hRNSYrieBbWTLUbGL5QREVeG3Sb2/dzVzcH9O85WBfrY3GqE+hiCQ==
X-Received: by 2002:a05:6000:2b05:b0:3a4:eef5:ae26 with SMTP id
 ffacd0b85a97d-3b32fd1d359mr1155925f8f.55.1751527921639; 
 Thu, 03 Jul 2025 00:32:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4232:f5b9:37fe:c24f?
 ([2a01:e0a:3d9:2080:4232:f5b9:37fe:c24f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e62211sm18036318f8f.99.2025.07.03.00.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 00:32:01 -0700 (PDT)
Message-ID: <ef1a7413-6ce8-4908-ae01-14e85d9825cc@linaro.org>
Date: Thu, 3 Jul 2025 09:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/4] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, me@samcday.com,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 miquel.raynal@bootlin.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
 <20250702180133.1889709-3-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250702180133.1889709-3-aswin.murugan@oss.qualcomm.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 02/07/2025 20:01, Aswin Murugan wrote:
> Partially reverted commit "soc: qcom: cmd-db: drop unused
> functions" by restoring only the cmd_db_read_slave_id() and
> cmd_db_read_aux_data() functions, which were removed in that
> commit. These functions are required for the RPMH Power Domain
> Driver.

So please move this change _before_ the RPMH Power Domain Driver change.

Neil

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v3:
> - No changes to this patch in v3
> 
> v2:
> - No changes to this patch in v2
> ---
>   drivers/soc/qcom/cmd-db.c | 45 +++++++++++++++++++++++++++++++++++++++
>   include/soc/qcom/cmd-db.h |  2 ++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 67be18e89f4..d0a6047b8a6 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -183,6 +183,51 @@ u32 cmd_db_read_addr(const char *id)
>   }
>   EXPORT_SYMBOL_GPL(cmd_db_read_addr);
>   
> +/**
> + * cmd_db_read_slave_id - Get the slave ID for a given resource address
> + *
> + * @id: Resource id to query the DB for version
> + *
> + * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
> + */
> +enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
> +{
> +	int ret;
> +	const struct entry_header *ent;
> +	u32 addr;
> +
> +	ret = cmd_db_get_header(id, &ent, NULL);
> +	if (ret < 0)
> +		return CMD_DB_HW_INVALID;
> +
> +	addr = le32_to_cpu(ent->addr);
> +	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
> +}
> +
> +/**
> + * cmd_db_read_aux_data() - Query command db for aux data.
> + *
> + *  @id: Resource to retrieve AUX Data on
> + *  @len: size of data buffer returned
> + *
> + *  Return: pointer to data on success, error pointer otherwise
> + */
> +const void *cmd_db_read_aux_data(const char *id, size_t *len)
> +{
> +	int ret;
> +	const struct entry_header *ent;
> +	const struct rsc_hdr *rsc_hdr;
> +
> +	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (len)
> +		*len = le16_to_cpu(ent->len);
> +
> +	return rsc_offset(rsc_hdr, ent);
> +}
> +
>   static int cmd_db_bind(struct udevice *dev)
>   {
>   	void __iomem *base;
> diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
> index 1190f2c22ca..16609ac9d78 100644
> --- a/include/soc/qcom/cmd-db.h
> +++ b/include/soc/qcom/cmd-db.h
> @@ -21,6 +21,8 @@ enum cmd_db_hw_type {
>   
>   #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
>   u32 cmd_db_read_addr(const char *resource_id);
> +enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
> +const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
>   
>   #else
>   static inline u32 cmd_db_read_addr(const char *resource_id)

