Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC27CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D8684844;
	Tue, 26 May 2026 09:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DzlKodlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C00683FF5; Tue, 26 May 2026 09:02:25 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E2784849
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so30100695e9.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779778942; x=1780383742; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eDApIkdPpHBiXACSwm9Wqz8FZOZ8N+Imvq68yhjS3mQ=;
 b=DzlKodlADcgfs1vFD+5an/j1n7M6PsFXMKuWBauMFhLO4DBxrZVRoZgv9OZtlyQFUa
 w+TqK9pBBNveP72J15exGeJVTeYh0dkiYvWsjPXDP+/MiiS31aIt17YkjbX9+8tP0m0X
 49arhz/70+NhoutMxKYc3iRVlENIxXTju6AU7+axi0m0HHTT8YEV7DpvE08W0F0ZhEsB
 frmZ2XYsp2AD4JuI8E0H80feF8bEn/vHdt5AlCsdjo/F96JVvq2hAEgpRoQ4qdaDhIhw
 bglqx2M7gOogsDH75exUFaypt6d0gv2do/9MvmrIumJ4qAXAx4Yg/90w1V8Pun/x4Vzp
 AWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778942; x=1780383742;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDApIkdPpHBiXACSwm9Wqz8FZOZ8N+Imvq68yhjS3mQ=;
 b=BVPLf989oGju6wDtnk/tjdaD4QfGNDViPD7MmDDwojgPY9N5kmQjvoIPe5Azf3N1ky
 lZKVOrrUsiwg6BJi9MWJ9/BTmWtPAW9T3Bdy732T7FOQuygUA0v8lGWfN4Pv3GIqc6Vj
 JpFNijj29E+BHMHaDJd2mq72py/TWJNbnTZsnHhAz2Psov/YOakjuEr46b2n/YbJNDp8
 SNaIjXY1MFnDbucXybNIJLtKRrwnyGtpIvG35xHlu242YX2eWerK8xlEx8nwnNetF8Eg
 tPo+AyQZRUYIc5wvRFqTV6tbZejBZqLxrImuiGHE5CYi6V4yL/bAEoipjfTNedgfpci6
 0cig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xCX2NfYceEMSr1mrgbj3yE+baMKKGn7b5dYOq5lMiYLAlJro/g+qIy45uYPJt9kdgi9qj9Mw=@lists.denx.de
X-Gm-Message-State: AOJu0YxHIzBqJkt6OvfPEYdAMd6J4IhPsjOUp9EMGaaO2M58X/aPE8gF
 ebe9tB5g6sMGLhSe7coNBX2NftQYYaNwNVnfZzcw4VD733XRThWzZFG1ihM9ikju2eo=
X-Gm-Gg: Acq92OGQtCSK9btxUDtfUDQFopPsVYKYmk2B170Copw5g3OdOd2hL1hG1snjvvcogG/
 wiM5LP1ojNOkicTb7Dq110x2rO67ta9SM2TvmqJ8HSyHOTuRSYm7lABFKdQulzyiT43u+nvb7TW
 vaGQv7BgwlcnDURsL1GD3uc6CVPgs/TInjkCdnSlTtlKslY7SSSZZ8mrttMR1mV7k2krAsEzYV+
 Hv4uU7srfloJczBRlhb2NGmZwwBr6FwezBiMAV/oxALd8kIEF1eKII7W+NjlBSNWS9/gUBBPtAO
 Xar20HI3uT0rZ04FFRTu4McUpy1BzEcZgDCFs5nkpahLWFQHrYTGyfpu9awCP5sEso/HjlIOSp/
 aFonbfYAbXdGEncwin1z4DTp6oXOI2yuOSnZrAXt4A6qTEviQOlmT1+zkEepXCfjttcOy/rbpFX
 1kvACm5VbYFnInbUPP908vbZJcXbGLk6ETxykI2bEASoIBH2QV0XGY7zbzuaLKEYJ2Zyvag+v7A
 GXoNnM=
X-Received: by 2002:a05:600c:1c21:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-49044ebc29emr287605655e9.21.1779778941651; 
 Tue, 26 May 2026 00:02:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526ca21sm298839925e9.3.2026.05.26.00.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:02:21 -0700 (PDT)
Message-ID: <fb2a5d48-e137-4ba5-b2f4-93a27b74a90a@linaro.org>
Date: Tue, 26 May 2026 09:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] nvme: avoid deleting uncreated queues
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20260524154718.16381-1-prashant.kamble223@gmail.com>
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
In-Reply-To: <20260524154718.16381-1-prashant.kamble223@gmail.com>
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

On 5/24/26 17:47, Prashant Kamble wrote:
> nvme_create_queue() may issue Delete CQ or Delete SQ
> commands even when the corresponding queue creation
> failed.
> 
> Avoid sending delete commands for queues that were never
> successfully created.
> 
> Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
> ---
>   drivers/nvme/nvme.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 9df7824b1c5..980ca919632 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -298,11 +298,6 @@ static int nvme_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
>   	return nvme_submit_admin_cmd(dev, &c, NULL);
>   }
>   
> -static int nvme_delete_sq(struct nvme_dev *dev, u16 sqid)
> -{
> -	return nvme_delete_queue(dev, nvme_admin_delete_sq, sqid);
> -}
> -
>   static int nvme_delete_cq(struct nvme_dev *dev, u16 cqid)
>   {
>   	return nvme_delete_queue(dev, nvme_admin_delete_cq, cqid);
> @@ -563,20 +558,19 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>   	nvmeq->cq_vector = qid - 1;
>   	result = nvme_alloc_cq(dev, qid, nvmeq);
>   	if (result < 0)
> -		goto release_cq;
> +		goto release_ret;
>   
>   	result = nvme_alloc_sq(dev, qid, nvmeq);
>   	if (result < 0)
> -		goto release_sq;
> +		goto release_cq;
>   
>   	nvme_init_queue(nvmeq, qid);
>   
>   	return result;
>   
> - release_sq:
> -	nvme_delete_sq(dev, qid);
>    release_cq:
>   	nvme_delete_cq(dev, qid);
> + release_ret:
>   
>   	return result;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
