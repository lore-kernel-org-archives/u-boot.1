Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0475CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 486DF843B6;
	Tue, 19 May 2026 11:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tSkHog6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B6B846BD; Tue, 19 May 2026 11:43:13 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE508056B
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so2037656f8f.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779183791; x=1779788591; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=T70H+2M3NRacFUb6rN6rLKmZyjw5uPvZVmQhRpY4HdU=;
 b=tSkHog6iuRdkQcmV5L/oIGxBAdHjaTRM4J2Zttv+hg35+bFnKMAVbJ6hAivaLRbCpl
 papehVE3Sem3FsWJ7F5UGqiwDLKg3Gd+PCtJqQNTBBFMGCH44jrHW24kz8M+UjLE65oy
 H99RqW3107HFWamL17koWVfN6SVYQHgU8T7bbOttY0Q68yluhB4xYobz0/euOyM7mv6U
 zQpezeewG/XMdOWLWVcoop4VcpioJPvtOhNaOIHrJqaBkNWqFnq+Z5rYvLxqOqw9/biN
 YDX1ofZ8bQah90IssgzWD6KRAvmTGS1AZgdP5BMp4sQwPC4WbjFGB/hCPZ+TL66IA0dM
 ruiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779183791; x=1779788591;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T70H+2M3NRacFUb6rN6rLKmZyjw5uPvZVmQhRpY4HdU=;
 b=pR+9Nmi+Oxv9dy71Z4Sj+ysNUD5OcG2rku7x6RWq5xBbJLHaacpjjps+HiDvK3FnZU
 2jO6AP+Qqg8DqrbiWIH7wFdD00vAYs92DEbCmtEifVEJriwR0B8oKStehzWZN0oqfC4I
 OAYC+8jTbM/Nm3oeGeAbdD506vl5OmN5LKD1kdjZ1mFnfLoy8/3sCFEw1yqDEL7p5qdy
 SGoBgyn/n22hKWvid3Tiuhl5GY/NPoUd8e9aIeKtTVkiLD7ATwPpzM8F+e6Ai/K5FX2G
 fIPupWDSeN0EnfQctEffDQjxsDag2/wUNzn7T5YvihQYVBLsgOHvVzvcXDVETyuqN44H
 bJog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Bxmv7RnHdNddZywqYj+sk5vjb40c6OmP2SFBjLfoIs0ILe0i+XnVM/DVeGaxU6uryvx+MTkM=@lists.denx.de
X-Gm-Message-State: AOJu0YyrFyZcxn9IJBg/YukXN9EUqeUZSrSo3N1+vtr1iZE0SLTKCEqr
 BXjoDftoikAxF8x2OMgEy2B2vQdP79nFLUPdg3MliruNaPJyyNMRjtL8TJjnZaCkST45uBUO2J/
 nVQgS
X-Gm-Gg: Acq92OHb74r+L7lv5AgYofiYzboxp6QnzkXsQAXZepzOccUCBkNPxf28r/EH+rnWKei
 EBTUmE6VKrtffY/+18/tjZUXHA955VxGnWX3mtDOKh8QBdcai/qojE9yyF61dED+imcqejfPOrG
 RDdWkugAM7gklyMM6vDnHC0qXmfGAHoZblmTxUMGZ+T5JZI+yFVr9v1Lz6Je8Z4NuMxNP0hVIQ4
 ic1a4A/3X2DIP1kzeWDr16PJog3aUg4sI6Mxois7HLN86tiAQQwDEZphrOPQ9+lnXRdMYlVz3N9
 3eqwG1Hzi7xhj0tjX4R9CFrAaBGvIYdPGQd8kogBnWN3xxL8PxbdiKtumDKIkPavDk8IoOaTCcL
 Yo3yB/lg/L6b5qW2pSsDjao6ETg+WD5Axo6fCnzeB57ui3BITLhoPw7emIffB0FnHLuVUvTWYeK
 cl4thzAoinwq+7AaudE8qYae7d0NdsLerChwxV2GAsR5ISjHbrsTFVdJejULl9QczFvJpwyhaWj
 43iRvwmUTenEhU=
X-Received: by 2002:a5d:5885:0:b0:44e:902f:e341 with SMTP id
 ffacd0b85a97d-45e5c5bfbfcmr32139218f8f.20.1779183790463; 
 Tue, 19 May 2026 02:43:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6449sm44152537f8f.37.2026.05.19.02.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 02:43:10 -0700 (PDT)
Message-ID: <2358e040-5c74-4ccc-a1a2-bac400eb0b41@linaro.org>
Date: Tue, 19 May 2026 11:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Fix PRP list pointer arithmetic for chained
 transfers
To: Prashant Kamble <prashant.kamble223@gmail.com>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20260518022535.17197-1-prashant.kamble223@gmail.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260518022535.17197-1-prashant.kamble223@gmail.com>
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

On 5/18/26 04:25, Prashant Kamble wrote:
> The PRP setup code advances prp_pool using u64 pointer
> arithmetic:
> 
>          prp_pool += page_size;
> 
> This increments the pointer by page_size * sizeof(u64)
> bytes instead of page_size bytes, resulting in invalid
> PRP list addresses when multiple PRP list pages are
> required.
> 
> The issue becomes visible for large transfers, typically
> above 2 MiB when MDTS > 9.
> 
> Fix it by using byte-wise pointer arithmetic when
> advancing to the next PRP list page.
> 
> Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
> ---
>   drivers/nvme/nvme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 2b14437f69c..3ce98de1a5c 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -94,7 +94,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
>   			*(prp_pool + i) = cpu_to_le64((ulong)prp_pool +
>   					page_size);
>   			i = 0;
> -			prp_pool += page_size;
> +			prp_pool = (u64 *)((uintptr_t)prp_pool + page_size);
>   		}
>   		*(prp_pool + i++) = cpu_to_le64(dma_addr);
>   		dma_addr += page_size;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
