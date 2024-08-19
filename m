Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454D5C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE6F88993;
	Mon, 19 Aug 2024 13:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JbxjgOIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 980BC887D1; Mon, 19 Aug 2024 13:49:50 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2CB87E15
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 13:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so32605405e9.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724068187; x=1724672987; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=m2rhWvZjZuknIlkX1dATmjp7rHgpAihcbWhyHo3ti9g=;
 b=JbxjgOIUbz3KmdOY6z3zmHaM487BCadnAPpJIJXZNU9jUEb71C/s8SDbTq5wQ7TFzm
 ZN8KOegxuTA+QYvop0xy+LnR6ZuJrjGmc8Xf40SThCmhillCFwJcH3OH2uUC1MmHyj1S
 QBoEq8MQ+3G+ibYlLdrc1wWyCgx9ObyQludnizNghfgET8wsstXi7DpH+aOA1c0Tq3sS
 ijhiNhMivK9yz7Xz27CaRs94pt7iyZUJI//aZDXbepAGGDqli208O8zAkZKXYSyyUmOx
 u4OGxPwt0PgzNsI2YBeBGCaHivZxPs7MdHCPR47GVy+l72S6ARBHBd3lCAqIuF+BS02D
 leIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724068187; x=1724672987;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m2rhWvZjZuknIlkX1dATmjp7rHgpAihcbWhyHo3ti9g=;
 b=XDCZqaJCc7Fh2lcts9p69gcmPvjuRzeFi3awpgfDnHhPi3SyHXhbssuatZdXtqHN5t
 NGatUPDIfrTCP079+Y2UZvuNr2URh3hSnjJGeonMm1EC13KPG06ClNXHVDvpMwbEZGbQ
 x0P33SRzHlnRsmLCw8MiiAcK7Bs9XA7TSQCCvcd7Vahgyi9zA3vwB8WXXilU56xY716V
 tJYKF20EGGZmoHlOhBN86yBe49c0UUpo+9nJnFu1U1Cf8IMSm82n9D2oO7nRLo9A7/i/
 oL18cYwu3m7U+Ffyd9/3/P+Jize3ro7kxpdzS8lMuYzbOZ2ubGYqh8Rb7XQg1CcjWX3Q
 zLNg==
X-Gm-Message-State: AOJu0Yy6MdoWuMFfnl8ksQCVcBoZ32BiYVtytm45uh9pKljEGfGrDDxv
 b0Gg6WPwFaJfNn9lIAlY/bhaXs+MF9wPK+JXEge3kNEvrbOkzGbFcQB5f+8KVIjd+EpG5mLbwo4
 u
X-Google-Smtp-Source: AGHT+IFyTnLTK+VmzhHpBZIH7AqTwk8AswCME5flcJUMCocyQhp3NxccXf0G5++FNPtCxkF4PKcLhQ==
X-Received: by 2002:a05:600c:46d2:b0:426:593c:935d with SMTP id
 5b1f17b1804b1-429ed785f7cmr71555785e9.5.1724068186862; 
 Mon, 19 Aug 2024 04:49:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727?
 ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed648f0csm107567455e9.9.2024.08.19.04.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 04:49:46 -0700 (PDT)
Message-ID: <9ef9b68a-d0bd-4e82-bad9-f86b964543d3@linaro.org>
Date: Mon, 19 Aug 2024 13:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/7] iommu: qcom-smmu: add sc7280-smmu-500 compatible
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
 <20240809-b4-rb3gen2-v1-4-7c73fe05b37a@linaro.org>
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
In-Reply-To: <20240809-b4-rb3gen2-v1-4-7c73fe05b37a@linaro.org>
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

On 09/08/2024 02:48, Caleb Connolly wrote:
> This soc doesn't have the generic compatible.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/iommu/qcom-hyp-smmu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index 7b646d840dd4..1b5a09bb7b39 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -380,8 +380,9 @@ static struct iommu_ops qcom_smmu_ops = {
>   };
>   
>   static const struct udevice_id qcom_smmu500_ids[] = {
>   	{ .compatible = "qcom,sdm845-smmu-500" },
> +	{ .compatible = "qcom,sc7280-smmu-500" },
>   	{ .compatible = "qcom,smmu-500", },
>   	{ /* sentinel */ }
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
