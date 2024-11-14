Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780E9D65C70
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D5589614;
	Thu, 14 Nov 2024 12:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D/XQGufP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070C889574; Thu, 14 Nov 2024 12:05:24 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D6C89618
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so4458941fa.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731582321; x=1732187121; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fgq3d3bBYAfyUWPHqpHV5I0Ycd6zp9RbeJnfrs4O+uM=;
 b=D/XQGufPjC+BcCrnbbu8KgESc0DeeRmEleDw0GWDtWAf53rlLlBDYO0jD/M3pQbqbg
 RQm57dlvto3rHl/aWOE2hcTxR5YnTMbJJrMwHVP8VDpgFSNh2g6vpJwa3+LkbdLI9Z7j
 A1NPMVycUXsbYJGoewApIXfd60PLlEdy7iwGcnDSFecilbejygXFolhjWcQaacS578Vf
 DYSavabuzEPNJ57H84RJ/gLXXpRhEuGYynU9qRssejxogujRh9dXp+o7NGHBDdqaSW4o
 SZF4ApnQX1rkm8SoQBA3SwPgwUlqyy7PplADowkJJWHb8Mo2R+gqjP/81IIS7AdAX4vy
 Fu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731582321; x=1732187121;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fgq3d3bBYAfyUWPHqpHV5I0Ycd6zp9RbeJnfrs4O+uM=;
 b=kozxGWcejPvsQNhP/6gtnY8HE7Z6AQXqPQOJrHAsnlcZHWh9IG61ae+QWPWQI25uPo
 7a0+WEsUN604r2aMrh0PCDNCBGnxmMDO7konXDCtJqtmVbj1OhbTM8S5MER5es/UheyF
 jlmKrHsSRDNzbj0cU2LQvLOthD0YSwTd1VY3Em4PRvZoJphEMHfIwqan3fYKeOhJPw2y
 jo0tE1xtp2tXUAPrW3pQOuz4+AlPMu3bpOZHQNOSM8eSDDuls43uxFwTvjOBm+QchMzv
 OrusKdal/b8Lo694eBoHH9s5DtH/0Wk5qh1Z+5Qf6cPuMw6shvh0i4FmE65XSggmgAhh
 awiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKJTwY+vubNLjzU4gbY/QEm1HRvGuNQVVgPMgFIU2ZYx/iRK5biV7P59iGL1LVPhjolrQuY4I=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5TfE5vWeKIeATfW5eQH+iaOO5rPtT1ScdXMsql4lxDZj2ap8V
 aMRICxOj0s4OiIh6LtSEwXPrEvlipR2bSGeB6zET6WS5mso7D/7FWOY56wnS6oA=
X-Google-Smtp-Source: AGHT+IEhIfRZdP4tVLUfbKJQ0PCSBljId800bhWeGIHB2uBdSVFu4xTyGs5umd9SR7H+4qpRonl0MA==
X-Received: by 2002:a05:651c:247:b0:2fb:65c8:b4ca with SMTP id
 38308e7fff4ca-2ff23daf148mr104370611fa.40.1731582321257; 
 Thu, 14 Nov 2024 03:05:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a62a:6bba:b737:406e?
 ([2a01:e0a:982:cbb0:a62a:6bba:b737:406e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80821sm16372585e9.23.2024.11.14.03.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 03:05:20 -0800 (PST)
Message-ID: <4577b23d-0bb5-4a5a-b1df-8e244f755df7@linaro.org>
Date: Thu, 14 Nov 2024 12:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] iommu: qcom-smmu: allow SID 0
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241113050214.1845595-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20241113050214.1845595-1-caleb.connolly@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 13/11/2024 06:00, Caleb Connolly wrote:
> It turns out this is a very real stream ID. Who woulda thought?
> 
> Drop the 0 check on the SID, there's no reason for it to be there in the first
> place.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/iommu/qcom-hyp-smmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index 1b5a09bb7b39..7e07487ad384 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -133,9 +133,9 @@ static int get_stream_id(struct udevice *dev)
>   	struct ofnode_phandle_args args;
>   	int count = ofnode_parse_phandle_with_args(node, "iommus",
>   						   "#iommu-cells", 0, 0, &args);
>   
> -	if (count < 0 || args.args[0] == 0) {
> +	if (count < 0) {
>   		printf("Error: %s: iommus property not found or wrong number of cells\n",
>   		       __func__);
>   		return -EINVAL;
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
