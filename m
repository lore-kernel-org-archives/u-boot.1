Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A81C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B99A880756;
	Wed, 26 Mar 2025 13:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i62BtqDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E4980BAA; Wed, 26 Mar 2025 13:30:07 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5613806FC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso46143465e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742992205; x=1743597005; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RgcqIR0WeuEVxP7MeEmCQqu4rgJGHiZd0IpFWbpeMMg=;
 b=i62BtqDbjW91wiiGEidwmYT3WOSA2Lvg0gZGa56MSPRq8wljxbnxuNhSf0b8N6Ned5
 CZAcRCgreyoP6sjizVuVRj28To65jePRq/cTGD726IcIXidDrT/Tv7pRTItSmrbZF0xm
 hwyqpnazKS2pvaTVF2VQCxAM5MuLI3DzKk8sG71YxKx/EjJPtdCCpK9EdPTJ4hgFpbSR
 njtV8YBFNCdOmFccU6b85CI+qpPFps46nQXfwhpe0wSrWVyoI2W+W+O015pcUy51MYO1
 utPCfL/dw1at9hZczR3dJpOKn1/xtBCqEO/QvveR92K+yT5FllHsraV27kSolecYBxkQ
 2icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742992205; x=1743597005;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RgcqIR0WeuEVxP7MeEmCQqu4rgJGHiZd0IpFWbpeMMg=;
 b=GOoixdF3l9i1E7NcOLjeGN6DmcTOGcEb6YKkbzTD76BMQzpyWp6OLhz8Mdx170Hyx8
 C2+mkNNQceIj5lCDPC+bgsgGaNPh73Y0SGRCp8gOiXbAZIaRiQGcOXIHDARnPtdB3TzY
 jY1pxbzZvb2CbCuW8UXxa4DaZqXfFWH7SGFz/62lBuCPLWgQAEIlZm3+SSxpv5Sb6G/O
 JRMs6ucvGqjyF1RYIa5A12HZp/qU8H6d2nrZtIdigFkw+VCrebvVQTK32qMsfDoXMEQD
 MZG3wuCvXCl2//r17IzdAXVbXimvXLdoz5KzMfy5Op2zQ2Vl6fnJFzJfzsTL9hyRomXb
 eCAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWNcpNpUadntXXyzLhPXtct+cWYIrDsZxORqarlsUIwqSmA1ZmRuafSRUnBMq+Js/sT3Yri2Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yze5SL82S68OhWNxHV9FzB5f+UE4FmA4XzaRVkx/TJcTuvx/YaW
 l6/e0esijQ19euJrNfbjneYZIb4BN7USCMPsfifasGo3laIIxDrpdqSJPacTD54=
X-Gm-Gg: ASbGncuG4oeNYWsvW69rFeCl+fy9W9CEfHa/V9HScz0R1LCAEza10eENZG60XPfqXRu
 1ncY+yulEFjsSfzGDp7bz63K5x9PWTpko1GyM5914XU6+r51D7S4wlUJrpFg9/t2ySkBq1SSfHG
 K8CGHw9QMu+D4yZ3OOAFk1hZh2YvupY9DN32AKttIEQrMNQpcwWXUbo5BDHGhHAwBewK8Z14eiZ
 o/OZHd+pbKridVKRlejKPbBJ8+f0e6TkevQ/HXPz7YOa9y4gjC60MzEqS3Q5C5GjXEuO0Qg6Wbu
 VcLibTyZf0xxi74H252WhMaPpsbX12sp2jLbSPL+sdnY0zYPkP8L89jVdRnQ7zZ54ZVNHbFmVi/
 XcHEImdA90GEHf3LLwRXplrBxNL+dqjMW
X-Google-Smtp-Source: AGHT+IH4v9Y5qjeQQeyiJ3Vmd5hEgPQBOvwKi2xWxCKBQDdA7k/4ioz5RFCoMnq/fyOShUXby5JGRA==
X-Received: by 2002:a05:600c:3b9c:b0:43d:934:ea97 with SMTP id
 5b1f17b1804b1-43d50a4ada0mr134185905e9.27.1742992205004; 
 Wed, 26 Mar 2025 05:30:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a11f:a03e:c86d:c567?
 ([2a01:e0a:3d9:2080:a11f:a03e:c86d:c567])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82f7af5csm461595e9.33.2025.03.26.05.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 05:30:04 -0700 (PDT)
Message-ID: <fe295ba3-a6b3-4318-ae3b-1f4c0ca398e6@linaro.org>
Date: Wed, 26 Mar 2025 13:30:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/3] scsi: fix typo in setup_read_ext()
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
 <20250326-scsi-sync-on-write-v2-1-12ab05bd464b@linaro.org>
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
In-Reply-To: <20250326-scsi-sync-on-write-v2-1-12ab05bd464b@linaro.org>
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

On 26/03/2025 13:24, Caleb Connolly wrote:
> This clears the 6th byte of cmd twice rather than setting the 9th byte
> to 0. Fix it.
> 
> The only other command that sets the 9th byte is the 64-bit read, so
> this likely never caused issues in practise.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/scsi/scsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index cd0b84c062252118d250b9305728e03f61736600..34ac47c03ab397ca999abf130d84ccbd3be4c419 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -89,9 +89,9 @@ static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
>   	pccb->cmd[5] = (unsigned char)start & 0xff;
>   	pccb->cmd[6] = 0;
>   	pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
>   	pccb->cmd[8] = (unsigned char)blocks & 0xff;
> -	pccb->cmd[6] = 0;
> +	pccb->cmd[9] = 0;
>   	pccb->cmdlen = 10;
>   	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>   	debug("scsi_setup_read_ext: cmd: %02X %02X startblk %02X%02X%02X%02X blccnt %02X%02X\n",
>   	      pccb->cmd[0], pccb->cmd[1],
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
