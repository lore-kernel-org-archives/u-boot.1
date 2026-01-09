Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A4D232E8
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 08:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F48E84121;
	Fri,  9 Jan 2026 09:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EQI+YzCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ED9841A2; Fri,  9 Jan 2026 09:07:34 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A479E84113
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 09:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1983356f8f.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 00:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767946052; x=1768550852; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=f7xAQfi1HWvWctA+pERvvYqjXEgACNoqdMqQWP63Upc=;
 b=EQI+YzCg6Rb+hjy2ssQkd/5p2sA71Z4uulwsc9QT3atl6p1+dDuE+fhKoCCJJFevdQ
 ppSt5LUb+sykZW2KqWgIxC3R2ASYeaRKHF95jgvdJsXOZ+q/X08+g/9WHTzzLAvLMoTe
 MxbttiTz26ClO5PKJtCz00sUQ0UZlJq2uk3i2sj6EEVdsFcN83lFW1k92T6l2XpSzCHA
 fvpFw0VKFnPOnfn5ZI7SYIdUo9CyTjpVbj+vINIV1S9gvfRBrS9MRt7FmKvUpUooIlWE
 IiPyskWnbmP8JW570TauiujMttZNmdIefI1Z17S35Sw83xOCMDOYH6NsPuNar1chXqqN
 MVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767946052; x=1768550852;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7xAQfi1HWvWctA+pERvvYqjXEgACNoqdMqQWP63Upc=;
 b=S5QQwRqzCYuwi4KO+uicxTR8Ely1Nnkj5qgRYGvCEpQ3lEdR7JV02a1ATAWFh9OkG5
 zxBKtt3E4EYwOAxLNFJvyk6HpXwS6yi1cOvsej+aBlEgypkHEpopFH7LMEWIT3M/O7d/
 1FjxrqfuEzi4sYID7kzDL/kaDnQ3+yLHr41cxFm/WrqN9VkkVDlw0yzHfiCjr3Q2U6HY
 eSPktkjTiz3YCHw6aD7yHKRePPfZxE42vr0+P1IhR1b/sh9xjdOfU+xxKxdYc5pnOQJm
 75zWHHdpkfk2IcfNbe5/1wMWoPIRBFiNAoeSvNhJjjcd6lXBC71HzRrP5eamTB/rI0rE
 qM0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC5OaQnbToYp922IPpqPii2CFVfG7qlXUXZNsL2SmfKiLeWQPnDUMOe2c2gR2CFg2zjd3ZzSc=@lists.denx.de
X-Gm-Message-State: AOJu0YwdF58gR+NVMUP3S3ryG/S8MGkEqyZ6NwKGsBp5zs+PQaknHMgT
 xfJGGMgp4FNlT57z4DG9PMsEd1zUKQn5JNui1TNsfjj+gygmLeVqEVYlSdJuLbymtXc=
X-Gm-Gg: AY/fxX6Tal3/dKDMtNOIzHuUvy8Ro16qXX+3rajghbBAoav7OSLqPkbcYskC3w7e3d2
 WGfr5A+pU65/wnv+wFi5VCtVzRBjAkvRPU2xnbEN4afWgZ5EgnOjQtYVz98hmw0RkraSoTrexsS
 9gcYggdcAYh7TOc4EcKztAkh0vmo1JwbpB9poKF3NRaoYPFuAfGEgFViz0xUH3ioaBeisuhBMyX
 mfk+ANz8NY024qEiJCEorR8bUFbCJdGXmbBBQRqFPAHKwVwOF7DddNvOTAeNH+3W+De7dQPoYix
 aue5xQUbsYjgCrH8Pr5HQlKomUTSHOYG633aVzgpHBeT/jQgg5ZmeWH1+nGzRExxgMAyWfo+QN8
 0jFbABbrmFFg9qFn3V/nmkGBwEts1siwvrRZ/obmi8dV4usViI57jYbm/4++g8fzVnZ7XZ5oqdG
 bAHaxy2LMTfznB2Uz9ZAmH4OJnsKOZrJmC7ULn21aMiOoEICLZ574OaH/5QBXSygc=
X-Google-Smtp-Source: AGHT+IH+LFO6y/JXPmkTSWrht7QaNmnRDblOr1F24Hql/Dfr9WHOeKXliVfbN4p+30lN7/QbQJ2HWA==
X-Received: by 2002:a5d:55c2:0:b0:431:8f8:7f1e with SMTP id
 ffacd0b85a97d-432c37a6bcdmr8780620f8f.48.1767946051890; 
 Fri, 09 Jan 2026 00:07:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dd78f5a8sm752204f8f.27.2026.01.09.00.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:07:31 -0800 (PST)
Message-ID: <06dead17-123b-471b-96d5-6bbd786f14a1@linaro.org>
Date: Fri, 9 Jan 2026 09:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] soc/qcom: rpmh: document rsc registers
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
 <20260108-rpmh-regulator-fixes-v1-2-d1b5b300b665@linaro.org>
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
In-Reply-To: <20260108-rpmh-regulator-fixes-v1-2-d1b5b300b665@linaro.org>
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

On 1/8/26 21:28, Casey Connolly wrote:
> Add some comments explaining a few of the RSC registers
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/soc/qcom/rpmh-rsc.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index bc0c3dd005ac..f51ef0b4af9c 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -35,17 +35,33 @@
>   
>   enum {
>   	RSC_DRV_TCS_OFFSET,
>   	RSC_DRV_CMD_OFFSET,
> +/* DRV HW Solver Configuration Information Register */
>   	DRV_SOLVER_CONFIG,
> +/* DRV TCS Configuration Information Register */
>   	DRV_PRNT_CHLD_CONFIG,
> +/* Offsets for common TCS Registers, one bit per TCS */
>   	RSC_DRV_IRQ_ENABLE,
>   	RSC_DRV_IRQ_STATUS,
> -	RSC_DRV_IRQ_CLEAR,
> -	RSC_DRV_CMD_WAIT_FOR_CMPL,
> +	RSC_DRV_IRQ_CLEAR,	/* w/o; write 1 to clear */
> +/*
> + * Offsets for per TCS Registers.
> + *
> + * TCSes start at 0x10 from tcs_base and are stored one after another.
> + * Multiply tcs_id by RSC_DRV_TCS_OFFSET to find a given TCS and add one
> + * of the below to find a register.
> + */
> +	RSC_DRV_CMD_WAIT_FOR_CMPL,	/* 1 bit per command */
>   	RSC_DRV_CONTROL,
> -	RSC_DRV_STATUS,
> -	RSC_DRV_CMD_ENABLE,
> +	RSC_DRV_STATUS,	/* zero if tcs is busy */
> +	RSC_DRV_CMD_ENABLE,	/* 1 bit per command */
> +/*
> + * Offsets for per command in a TCS.
> + *
> + * Commands (up to 16) start at 0x30 in a TCS; multiply command index
> + * by RSC_DRV_CMD_OFFSET and add one of the below to find a register.
> + */
>   	RSC_DRV_CMD_MSGID,
>   	RSC_DRV_CMD_ADDR,
>   	RSC_DRV_CMD_DATA,
>   	RSC_DRV_CMD_STATUS,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
