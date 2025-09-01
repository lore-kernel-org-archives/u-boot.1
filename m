Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3DBCA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 07:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C519783977;
	Mon,  1 Sep 2025 09:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kRkW09eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E08B831B4; Mon,  1 Sep 2025 09:56:36 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFF88397D
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 09:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b84c9775cso8281475e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756713393; x=1757318193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oWIDjCHALa/FgUFQRgDOtTgSQeLOGRDmCxXqWlcZVgw=;
 b=kRkW09eUqtZyxt2aysfDo5FYi0t358WiJnc8hFmiJg+LxFFIoR/GsxMJWAYNz/s8md
 4nMjhdYW33ENR7BexQ7iYB/wxip0lRM7ciwRz3JjDmr0Z2p8QGMZBFO5Q09UXebDeoTI
 QEiOz/ZfjxwLRJANB+7vHgjr8G+NX51Q2O8uaaEZPuX5aI9UhKOkPPzRZP4/CKrNRA1T
 77ftSx3UzAm7VWYgQsnWKDBg0pUzNE11GOQqSmQ4VTgpolTopshwlmzEwFvMTZ6gY4Gf
 FB5RIGRfardmu7bEpqjLtZyDEtXZSmaVEvH+W9S2j0TDDxfxw06g28cRXvmLU/8iSR8z
 2VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756713393; x=1757318193;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oWIDjCHALa/FgUFQRgDOtTgSQeLOGRDmCxXqWlcZVgw=;
 b=HkOGBRmzo89Gv7PkzhhF9o/6HpnVRChzRoeleROigr8m1ashJKvYoBw+PGPIpUkyEk
 LIwrSWj3KoyH9PRlpNiKWXl/feqmUGr1uxhut3E794+JUQ69Y+7AH4FUMPzz91t3Isid
 XxwUasMxMcdYLFgvaZu9MHCnI7WP7/we3QbeRvu0tiEa3p6SAA1xCyTF44ZygYT5Xluv
 lC7mZLgU3Vb9iM5+mZn1D7a4M8f9t0ONQHd+j2y4Rqv0iG2tpMyJDQaVKc0AINy2SgY1
 tgSDEiaRpnemm0OBaJhrBWNA7R2ItmMzRD/vOsyOh0NauU73ZRZlTIKCk1z2MI3yU+hH
 OAXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyNQ6mc65Jv5FlHcCg7Yh3YpJqvE4FYklDB2fTqiuZF5b9m1fwlx/GMjiVS9Y9UkopsI3hLG0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx+8pKKRJaAF3i9RPSzelGoK4iRq4FQ5vkByafn+bzrB2Th4As
 fTLeTRD+Sqg9wx7sIakasEc9npilO9ybZcFkzlKKB8WWo7u1pTlJruIVZKSyJc+U4L8=
X-Gm-Gg: ASbGncsu+VPMKfo0CxaTrim0km7mIx3bJ+8meKr5cmfTjHIacTxTaws9C6GQEL+B0NF
 2SJnZ8H/NJ6MDF/FhOkzd9BRMsHTf6oQ6T9V8gXRZXyCoBqOT/RoIKRG/+LTmHnPfn8tnUfBKjl
 SQjPdCHCDCDLTy6QQ4qIqL5Yn9oGyyZyNxt8JM0xqHp759hQ73Co0y+I2Wtdw2efKlHJ0vrlstW
 /qIyJ9OrOYEz2ZEeD5AgYPX/NyxzuY4CGQiakOM1sWgISqx25DG4CJuOy8H4Wbyg3kigsP1MfjW
 XfM8dr/r7VNBW7KX5sxOO1G8HPX1ieaEHjYr3NDBA9aUzjHR/4tN7/FVlaYF5W4CfHXQhWhNGGc
 jf78KajGZBRQCHlgjielXQ8k5wdfD6IqXpztpOd7BZuJjcEwJh4QoqU8LI3Yrzqg7fkERkZ2t
X-Google-Smtp-Source: AGHT+IHz5Afb1NGLW3O4r+Wj9LE6K8kbgvXrLvcnBAC0j4KRChsxUlS+Q3Dv73PBAMFhZ9/wGOfiWw==
X-Received: by 2002:a05:6000:288e:b0:3d6:5e37:804e with SMTP id
 ffacd0b85a97d-3d65e56084cmr2695337f8f.5.1756713392680; 
 Mon, 01 Sep 2025 00:56:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a?
 ([2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e92a42asm143206255e9.20.2025.09.01.00.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:56:32 -0700 (PDT)
Message-ID: <d0f14af7-3d0a-45c5-b4c3-e921178fcdf7@linaro.org>
Date: Mon, 1 Sep 2025 09:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] ufs: Add support for sending UFS attribute requests
To: Jared McArthur <j-mcarthur@ti.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20250827185056.954640-1-j-mcarthur@ti.com>
 <20250827185056.954640-2-j-mcarthur@ti.com>
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
In-Reply-To: <20250827185056.954640-2-j-mcarthur@ti.com>
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

On 27/08/2025 20:50, Jared McArthur wrote:
> Some UFS attributes must be set before a UFS device is initialized.
> Add ufshcd_query_attr and ufshcd_query_attr_retry to send UFS
> attribute requests.
> 
> Taken from Linux Kernel v6.17 (drivers/ufs/core/ufshcd.c) and ported
> to U-Boot.
> 
> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
> ---
>   drivers/ufs/ufs.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 91f6ad3bfef..9e67dd86232 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1107,6 +1107,101 @@ static int ufshcd_query_flag_retry(struct ufs_hba *hba,
>   	return ret;
>   }
>   
> +/**
> + * ufshcd_query_attr - API function for sending attribute requests
> + * @hba: per-adapter instance
> + * @opcode: attribute opcode
> + * @idn: attribute idn to access
> + * @index: index field
> + * @selector: selector field
> + * @attr_val: the attribute value after the query request completes
> + *
> + * Return: 0 for success, non-zero in case of failure.
> + */
> +int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
> +		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val)
> +{
> +	struct ufs_query_req *request = NULL;
> +	struct ufs_query_res *response = NULL;
> +	int err;
> +
> +	if (!attr_val) {
> +		dev_err(hba->dev,
> +			"%s: attribute value required for opcode 0x%x\n",
> +			__func__, opcode);
> +		return -EINVAL;
> +	}
> +
> +	ufshcd_init_query(hba, &request, &response, opcode, idn, index, selector);
> +
> +	switch (opcode) {
> +	case UPIU_QUERY_OPCODE_WRITE_ATTR:
> +		request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
> +		request->upiu_req.value = cpu_to_be32(*attr_val);
> +		break;
> +	case UPIU_QUERY_OPCODE_READ_ATTR:
> +		request->query_func = UPIU_QUERY_FUNC_STANDARD_READ_REQUEST;
> +		break;
> +	default:
> +		dev_err(hba->dev,
> +			"%s: Expected query attr opcode but got = 0x%.2x\n",
> +			__func__, opcode);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
> +
> +	if (err) {
> +		dev_err(hba->dev,
> +			"%s: opcode 0x%.2x for idn %d failed, index %d, err = %d\n",
> +			__func__, opcode, idn, index, err);
> +		goto out;
> +	}
> +
> +	*attr_val = be32_to_cpu(response->upiu_res.value);
> +
> +out:
> +	return err;
> +}
> +
> +/**
> + * ufshcd_query_attr_retry() - API function for sending query
> + * attribute with retries
> + * @hba: per-adapter instance
> + * @opcode: attribute opcode
> + * @idn: attribute idn to access
> + * @index: index field
> + * @selector: selector field
> + * @attr_val: the attribute value after the query request
> + * completes
> + *
> + * Return: 0 for success, non-zero in case of failure.
> + */
> +int ufshcd_query_attr_retry(struct ufs_hba *hba, enum query_opcode opcode,
> +			    enum attr_idn idn, u8 index, u8 selector,
> +			    u32 *attr_val)
> +{
> +	int ret = 0;
> +	u32 retries;
> +
> +	for (retries = QUERY_REQ_RETRIES; retries > 0; retries--) {
> +		ret = ufshcd_query_attr(hba, opcode, idn, index, selector, attr_val);
> +		if (ret)
> +			dev_dbg(hba->dev,
> +				"%s: failed with error %d, retries %d\n",
> +				__func__, ret, retries);
> +		else
> +			break;
> +	}
> +
> +	if (ret)
> +		dev_err(hba->dev,
> +			"%s: query attribute, idn %d, failed with error %d after %d retries\n",
> +			__func__, idn, ret, QUERY_REQ_RETRIES);
> +	return ret;
> +}
> +
>   static int __ufshcd_query_descriptor(struct ufs_hba *hba,
>   				     enum query_opcode opcode,
>   				     enum desc_idn idn, u8 index, u8 selector,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
