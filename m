Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5A0CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 09:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD818341A;
	Thu, 28 May 2026 11:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DPsn94vK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CF1839A8; Thu, 28 May 2026 11:11:42 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E9680398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 11:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so7699306f8f.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779959498; x=1780564298; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Diq0uaTaDJnp0iANyzE5u7lZclNO5GK9F/Uk36hqNmw=;
 b=DPsn94vKLUVj6E9akASXd40vKvW+4PcKgz/VitmBQVC5ZhBllg3aFGx0RQEtZqeeZ9
 8ua3U7u6bpi1TAP2sw3LGzHTV03doKCB9hwVmAsXe71/AbnEbVpvex/ibyai1xzRHkY1
 vRv69hpY8QuLwCGs6n27ShBPTIfxlhcxy6oyhB6oE/kXSfbDReJOk9Zd1A0patpCYOx/
 ++NOGv9iiU+3FYp57BvVhn4AHjTadKIBFetMGcxoGwGelUWY3YvsRMI0oZ05QL7nZkwy
 1rpjHtyvxWlXu7JnCnFWoXs9OMhoujKKvEe977OQq3MfZ087e40fks79v6hLw1hGsD/h
 IMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779959498; x=1780564298;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Diq0uaTaDJnp0iANyzE5u7lZclNO5GK9F/Uk36hqNmw=;
 b=IC2/zFOyC7poo+Pii4ax5LjEDTpgkytPu+XSstptrcCDcRS9ZrEW07pUtlOR/nWbAH
 5TNC7BRCBBe3MMvD7em4D8RR0lfPkc7PQE5mnbJmwxsM3g1RKSsNq+6rF7IGcC1l5x4t
 3ScW4Ik/hahu0Hp8YvvXCKQa8EQ2o9c5DRoHzdYNzl8gqg3WtQ2ZEIi+3sdM5CCz+3u9
 sAkDTTw+WamztAxqJ8PQ/SmteARqxFltr56ArBhXEDbhayu+eD5v78nC5hrvR8QuhyKs
 TxojXCXj5RmG/iPEjqQB0F7Q+L/JCgE6z1b8ToyiM0g6RR1xnbk3QbUKLmLV0lKUzL3N
 Zz3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AEjK8eduzlLlBAA7GGEcDRfV26Ld0ierXoxHeJ1ToeeDycLNdW8jFWxdoFzE6t37s4mHbf8M=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq4Xjk1/lXrbaRXTaifvZpyZLZ8LMmv5HykzC7y9u+bNowYheM
 0qMVeM5gLafMeHktSZm9f+kk0OSmp8RtGt9rkifWzwFZWME4kzDQxrKgtWdlCPHiEzs=
X-Gm-Gg: Acq92OGteGbRZY7xoL9X+3uCdjcmkLtSha9J6SXBcIIjrAd9yhZFMzSd/YvmVWuwlSn
 NJ06/pZvJb0tTSUGiKgBalXwVlaD2/wDSj+hyeHfIPvKDdxLTvwmC/DT4vdrshvALjsJgn0s7Wd
 xZhGX0al7Wzxm7v5/6e67ZniXcvkf7GZKXMhfjpHn20I7UjWsOXYUde+onnQ/1Oj6YLshrEI7CD
 6UROmAPMyKJBB064qgJY0feUbyEw2aZ6CnyTQgi+Uf6FXM4PL7QUmeaeqys3ogFCQi1S63+Zpkr
 h4XBAOeOOlJLka34HSDhWIoRKA8gbRZ11uBbfCZ311WvFXLZw/Uwz52qVIEoOrCs5r7lA9Vz6mC
 xQHhSEGaDd+eLif+nTacc29kumSchkKb2xmibvqufbQ17dCIAp6nevBCoIXmLhkOgSBsRS+eGc8
 RjqNU/l2vIk68UmTvHjVW1cUHQzX69biuT75kPVsH/6v8=
X-Received: by 2002:a05:6000:2dc3:b0:45e:9366:94c1 with SMTP id
 ffacd0b85a97d-45eb38a9291mr44920884f8f.18.1779959498313; 
 Thu, 28 May 2026 02:11:38 -0700 (PDT)
Received: from [172.20.10.2] ([37.167.60.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2c87sm12162065f8f.17.2026.05.28.02.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 02:11:36 -0700 (PDT)
Message-ID: <d93ac979-23fc-4229-a414-96c9bb2d8fa0@linaro.org>
Date: Thu, 28 May 2026 11:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] drivers: nvme: Log I/O timeouts
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-2-dmukhin@ford.com>
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
In-Reply-To: <20260528012056.1744362-2-dmukhin@ford.com>
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

On 5/28/26 03:20, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Current code silently swallows any timed-out commands scheduled
> to NVMe. Log those to be able to debug any potential problems with
> the NVMe hardware/firmware.
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
>   drivers/nvme/nvme.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 0631b190b978..c3c44e50f19a 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -182,8 +182,10 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
>   		if ((status & 0x01) == phase)
>   			break;
>   		if (timeout_us > 0 && (timer_get_us() - start_time)
> -		    >= timeout_us)
> +		    >= timeout_us) {
> +			pr_warn("nvme: cmd %#x timed out\n", cmd->common.command_id);
>   			return -ETIMEDOUT;
> +		}
>   	}
>   
>   	ops = (struct nvme_ops *)nvmeq->dev->udev->driver->ops;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
