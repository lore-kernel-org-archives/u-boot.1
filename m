Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4903DC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 15:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C21809A5;
	Fri, 28 Feb 2025 16:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0zfRwz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A1580FF2; Fri, 28 Feb 2025 16:27:11 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2FA8807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 16:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so23880145e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 07:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740756427; x=1741361227; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zBpUShJBlT6hEocvveHoA/ZYdj20KzSgLjZwftOeVPg=;
 b=d0zfRwz6Inhz0gjtOAya8qRpHnQxqYNPDwirOK8jbltS24/JaOuEoNtquHsVYioby6
 lLM8kef6RC/1TQzhpEjQ6a9z/+thGLJmEAWKOJjP+D69170E6NWhi4w4B0Ywcbe3xxom
 RrY4RWQYQnZphhG3nvgmndZRevRcIzdADlB1GGg+R5MCDnOls9+Cr6gfnue4f8DdF3HF
 EVVCoR3lIf1tcWxSBs/p4bsYreJJI5q1DUAy3nXyKa1DW0IYFUGKR2SDmnk16+U/VrXx
 YS68VXW7GYh/yXVKVgJAmEItbMcsJvZb3RDD8SnSfDdiElfeTMPDuhow2UAaxw+w9n/3
 /5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740756427; x=1741361227;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zBpUShJBlT6hEocvveHoA/ZYdj20KzSgLjZwftOeVPg=;
 b=NvCLdFyz8oSGOpkHq8kcpYZXpc5RgUkJlbPAMKiXCL+5Yp3TEmwOb23D0TKeMJJsw6
 8j2Bva7D7c8/UWjVNUivet7aaIrry23r+GPieBAoFNB/w88TFoEf2cnICtOLZbzn0xGB
 oenGTw2wZv7Sj5nHSHOt4t0xB350MrlOzRfNyNsXbMwNYAF2q4ChGM4SmKzgZJ+9rc9t
 RjVnAKIlILzYl0D1bBHFgb7cbxSlFeikLj+9wfGagGaiicnYQVsz81VwQTooVmG9Q3vz
 yhoPwC7Dg/SFdmLJ4ArDoRDEEGdFDkO199prj7KCCRnWleVTGjSsIHXeHJk+FlQRvZ0h
 C3Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+NvXHYx1d1THL/VEBXFr/GemgtbfI0Y/gRsjiBqHyKrqTjdxIKV5DlThkJleECH0f04RSAQw=@lists.denx.de
X-Gm-Message-State: AOJu0YyKv5Z4WSoegt1t33NoEZYv9jRmWW9U3x+SJLPIDMKa04+N7lUN
 MNKXxteuG+Y/1ifQH/nPndVoCoGZQ+NnNJK2zwBOGBdDgUqjiGAigA8iWzabflk=
X-Gm-Gg: ASbGncsCdhvavK3G4xRtsrEWv+AUn92sEMH87FBOPrD+2URi2h+NHHjiMPWZXvmealc
 XTy1esh9gFndSYETxZ4tER/X1ZAPTOeiJ3YgnWvjX/UKD7LSycLB7togGkpmIRtcXkqimZyqfIB
 VGH7eDgJ676YZUdP+hEyK5SutGhCglitnpHl/Zu9WYkRkNfCiVB9t0422Xrm9BOLHhUZ0W9L6Bv
 CaOHydTdIz8rKgOhN63BXqlnu+RQ2lZwHG+vu9Bb+2/IEfnF3uRlxzNu7OgpX9xEo/VXP3GCVgJ
 lhuJ+BgYkg99cUuZ+sAQp8IFNELYI1C/pbdmNg3OsVNA6PvtiTtybm3v0Iy5FnK9cASZu7eDhhO
 JKj0=
X-Google-Smtp-Source: AGHT+IESEGXh3wiqZvhYY0vpcpiZIP6cwq1QdJrlPq/hgRuRMhEMln096vTkRXNJ9FkPeq+Yr/TBwg==
X-Received: by 2002:a5d:64a6:0:b0:38e:d026:820 with SMTP id
 ffacd0b85a97d-390ec7cd2e8mr4838030f8f.16.1740756427103; 
 Fri, 28 Feb 2025 07:27:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fb45:6b45:b4fc:66e4?
 ([2a01:e0a:982:cbb0:fb45:6b45:b4fc:66e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d773sm5486233f8f.81.2025.02.28.07.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 07:27:06 -0800 (PST)
Message-ID: <e2a0da0e-6246-42c7-85c9-84a2097cf09d@linaro.org>
Date: Fri, 28 Feb 2025 16:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pci: dw_common: Set INCREASE_REGION_SIZE flag based on
 limit address
To: Tom Rini <trini@konsulko.com>
Cc: caleb.connolly@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-v1-1-33088c62600c@linaro.org>
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
In-Reply-To: <20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-v1-1-33088c62600c@linaro.org>
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

Hi,

On 06/02/2025 09:49, Neil Armstrong wrote:
> Set the INCREASE_REGION_SIZE for the outbound iATU entry if it
> causes the 4GB range overflow in order to activate the extended
> limit address by means of an additional iATU CSR (upper limit
> address register).
> 
> This is required to make PCIe host controller work on Qualcomm SoCs,
> namely the SM8550 and SM8650.
> 
> Based on the Linux commit 777e7c3ab7303 that can be found at [1].
> 
> [1] https://lore.kernel.org/all/20220624143428.8334-5-Sergey.Semin@baikalelectronics.ru/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/pci/pcie_dw_common.c | 8 ++++++--
>   drivers/pci/pcie_dw_common.h | 2 ++
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
> index 78961271a8eef8e4b6991675ee9de2bb1968b8da..5322f6bdaee450470d7f706bb4b4097a368ec455 100644
> --- a/drivers/pci/pcie_dw_common.c
> +++ b/drivers/pci/pcie_dw_common.c
> @@ -78,8 +78,12 @@ int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index,
>   				 lower_32_bits(pci_addr));
>   	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>   				 upper_32_bits(pci_addr));
> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> -				 type);
> +	if (upper_32_bits(cpu_addr + size - 1) > upper_32_bits(cpu_addr))
> +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> +					 type | PCIE_ATU_INCREASE_REGION_SIZE);
> +	else
> +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> +					 type);
>   	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>   				 PCIE_ATU_ENABLE);
>   
> diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
> index 8cb99a12ea1a5fd3687f980cc1ff99839d06dbc2..748945f95975e8251cdb92a670e8d5bc575d2847 100644
> --- a/drivers/pci/pcie_dw_common.h
> +++ b/drivers/pci/pcie_dw_common.h
> @@ -46,6 +46,8 @@
>   #define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
>   #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>   
> +#define PCIE_ATU_INCREASE_REGION_SIZE    BIT(13)
> +
>   /* Register address builder */
>   #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	((region) << 9)
>   
> 
> ---
> base-commit: b3c09eb36529fbb277bec17b35e638f42cb33683
> change-id: 20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-878465356c54
> 
> Best regards,

Gentle ping, this change is required to make PCIe enumerate
on some the Qualcomm SoCs.

Thanks,
Neil

