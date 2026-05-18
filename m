Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7114CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B64384119;
	Mon, 18 May 2026 16:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OOo3qwww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA7F8467A; Mon, 18 May 2026 16:38:02 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D7D183EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so10792315e9.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779115079; x=1779719879; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vFZklgma3gSgzOrSNq1w8ddYd0RQCdc1bFZS5f5sews=;
 b=OOo3qwwwSmAy7N3bXFbgQRe2DnjTRASdYtA5XeALYBKDHw3mchlkaFPN3/pVusBLSe
 lURwnYXNk2GoJJsUScs+DK8lRA8gA0mIXkKpfHN3OLt3MzZtGi5KBZvyEBeEU1zp8KyI
 H3tDFGYTwofNrnQr07RF8P28QC3dZyhyJWfUhgJ+3Tbb8a4er0aJkXuU5TpHaDtLIG8+
 44El9ETW77b2JaXBwJWegLWPKx6m4LwG2AnMDImtDC1KbZz7TOc6ODECXyiAxxWNdJXP
 h5jghgm/hH3e3AqAefhjcxfCsiHKdz7/AwJBGb2S9u18hHej/8C0tlsrBDLYd2uz1lYN
 8Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115079; x=1779719879;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFZklgma3gSgzOrSNq1w8ddYd0RQCdc1bFZS5f5sews=;
 b=GsDcZi7FJDtQPtVPiD9LReynzzFcUG4qGlEw/ACEZX3H1DzFsiZ8c+1efclQtW0DA0
 ePjgd1XcXmTH1X6YJhPLmGYVw8CqChp+RPJCfSM/3V0oOSx3vjcmVm7nl797X7SGoRfD
 rXfENxJ9da4PsBiTGF85YuDNLTIjKALp3bO2xgSlRqCpIMHFROdzECeGgiipV05EUt47
 RAg7MjDD2YYEKKAism7PiXsw9U1Iros2ni1RlDP7DSrSa2SFigO/1siy8Fh8+9DhYSCN
 zgOULqdQzYBr9c6QW5h64KYOi8/WD7D6Cgb6SZaGcFGzUQz5LI1BkC0ap87Ut5ojTloZ
 LPAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ90nGSZ83Mx61D4r2bZi8iVJbXcZ5Ln5O5Txit/uIaULBxehe9GSrJd8MRtfJgIIfUq+3suABc=@lists.denx.de
X-Gm-Message-State: AOJu0YyjVSdAnfv+tXwmf7a4JxTcrRqV2kP7RJj3QSayJtNoeQ+16Ao3
 y++xu5kyg982cfnlgq0aT9qmq3uwzgp3QRJJlOxhVHy12jlSIQ2xNBct7KqN0JJXqcI=
X-Gm-Gg: Acq92OHVmUjaSbKqvg8qvBfNQuX8sYb95Df6cCBL9a2uN3+pDAMzyWVR47Id01LUap+
 0Hc8S3EiS/VdW84zpFD5CRNTR9kkit/F3Z4BZ9he/wjLk+KXDTrNx5LAyfnYshcqqT3K3gDR0Zn
 rUYj92Q2UbYZJLbkh/uwnJXsJIR3VQLYYJaTcyPwU4/MSzpq5T320NWIk5QcT8COzbkrqYK/DqJ
 gWW6ko7YGD6Bt8VK2YpQ2wyxTpK8WobIsaE/JZD5powj9thtaR3FmZEihcd0FvtP3wOXDlER4wR
 BpNqhleclst1eTR6sGjNim4iJHIQD/VW97S0t904zaXfAnZl7C+52CTEqIdFQkO9/naTNkpF59Q
 txKDLmf+yEsogkZ3DHx/Md815I3eDhOp3oJHiG4aYPsUsBbpiCRif10N6HRLAibG5riOweVc+58
 xX0UFcxyHj2xcIzpCPb0qH43xr4jjBIbH299pV+nTqTc6wZdkQ6YSZJmBFffjFr6OIdnqVOIsDA
 H1eKSM=
X-Received: by 2002:a05:600c:4fd4:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48fe60ed7b7mr209748865e9.10.1779115079353; 
 Mon, 18 May 2026 07:37:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c516sm282386985e9.13.2026.05.18.07.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:37:58 -0700 (PDT)
Message-ID: <a526cdfb-69cf-4565-b432-54fdcd15ab5a@linaro.org>
Date: Mon, 18 May 2026 16:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 10/15] soc: qcom: smem: stub functions
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-10-c01ec2ff3886@linaro.org>
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
In-Reply-To: <20260504-b4-modernise-smem-v2-10-c01ec2ff3886@linaro.org>
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

On 5/4/26 20:57, Casey Connolly wrote:
> Allow smem to be optional for Qualcomm platforms by providing stub
> functions.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   include/soc/qcom/smem.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
> index 755003807dba..586432412eb8 100644
> --- a/include/soc/qcom/smem.h
> +++ b/include/soc/qcom/smem.h
> @@ -1,16 +1,36 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #ifndef __QCOM_SMEM_H__
>   #define __QCOM_SMEM_H__
>   
> +#include <linux/err.h>
> +#include <stdbool.h>
> +
>   #define QCOM_SMEM_HOST_ANY -1
>   
> +#if defined(CONFIG_QCOM_SMEM)
>   int qcom_smem_init(void);
>   int qcom_socinfo_init(void);
>   
>   bool qcom_smem_is_available(void);
>   int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
>   void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
>   
>   int qcom_smem_get_free_space(unsigned host);
> +#else
> +static int qcom_smem_init(void) { return -ENOSYS; }
> +
> +static bool qcom_smem_is_available(void) { return false; }
> +int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
> +{
> +	return -ENOSYS;
> +}
> +
> +void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
> +int qcom_smem_get_free_space(unsigned host);
> +#endif
>   
>   #endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
