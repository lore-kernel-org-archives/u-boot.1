Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06E5C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D23F8007D;
	Tue,  6 May 2025 09:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K4xBrvnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8235E8007D; Tue,  6 May 2025 09:37:17 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A7280050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso45806955e9.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746517033; x=1747121833; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ktrTru5xy6+KUzETCWfEuByZdKIga+HUqMfI3VXzBiY=;
 b=K4xBrvnRB40m+q7Kk1+XSWj1JQH1iyPDGelO5pdI9yCQpgcBFAsTRq73YH7RYDihjE
 eCFfIOsVq1SnffLWjY0AW9auPB6EDx+rvo5K5pf8Mo7zj2peBI8KE1XTWajB1jM6+iXe
 5gmKFkNTK769P0GP3laH9gdgLOtLrnwy82E1plYFG8DGSnZB7Pld0ja9v6spwfcsgltW
 lXn5/oc6jMhrRdbPxKxHSrpJYxrKwqRP7uVzn/6EVIzm0RyJthyfM9gncwUzn9eFS+uq
 6rpXppegGZPUSCqgZgpsK5e8ktOsLwToPKqMO5pNYWeCrPLZIzEn+iKAmruYeBk11f8M
 WCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746517033; x=1747121833;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ktrTru5xy6+KUzETCWfEuByZdKIga+HUqMfI3VXzBiY=;
 b=eTL/4Lgdzii8wGXifwXJGYZ9n8wAd2ey7Nj/VHFbaQa54KdNyJyqaBPgAHM0GrcR9K
 vjdJt3WMCI+gwNXLdOnJTDTdOzN071qs/eg3wk+pIkSQmkb4plgktQbvcBdzolTTp9lN
 EWsGULALjKq/VHBRY14IW63wrh4Y7HnFTu498lt/NkFDF8OpXvDG0401XJaYUJoq0uI7
 Uzw1WDx0+1iL8F8qOc2JzhQ44XOLp8LBVpZ6aDKANWzVaJndU5JID9E9Il+YkgDVu9F0
 regqt84SiRjUZnacu+HfxHfY5KYvOexCmzjkg2J+M0Y45YRWGExLw/KrxBOHxSKKFkPg
 2UEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBKObXjzbW07CZXq3UfVfvYuaYT8ONjRb1V/gsztKI6mXaKWXjmSTtb5YJldOFC/c5FGlmQ0M=@lists.denx.de
X-Gm-Message-State: AOJu0YzGwRUxoP8yfLRqbHHprxQS6ABW/A6n8XRBz8vfGnzfKiFa8/Xp
 SaS/gwpfpuBXNt68ITPxrAOV3MlIcDgkRMJlXj/qtqVkUfIuSfnH+xD8r+d5n5w=
X-Gm-Gg: ASbGncvrmUDBlW3r1M2I92/13UwYD67m72P4IAu7yLHurOi6b9VmFSQ/bJIQS9jEDOd
 f4EYt7R1ciQKd2yH01FUR2yqDCQ23dZPPLRW8u3GBDfB+SlmnWD4tYcUGrmpmqjEfGvFe+hTv7P
 ulwxCfzOrAAUSuz3PrAfccEf6R4V0z1+enk+RuRG5BALbBvKQK4laNVXRsZCG8iUUcIN0X5xWCl
 71aNFFOkyFXKrEUalipw1eHtozP0lLb3cvvm6cYexEuH04Bl8WWBe3Ic0ncAUvQ5mWIFxAlJ7YL
 FVICaW4UtflU9TJYDdYx8+XoMb1i1G2/xdUuY0PcF3QYBhYMNSGULK6qKrQKs4C3jMng4jhYCDM
 FRae6mroca1X8w2gyuQ==
X-Google-Smtp-Source: AGHT+IFnCSaQpDi4ENX+r+NTqKj8iLpi8exHBdHGqNJnw5s5RZQ/qXJuebX6D0CSqEFEuCPe5cRshg==
X-Received: by 2002:a05:600c:1d8d:b0:440:66a4:8d1a with SMTP id
 5b1f17b1804b1-441c48aa302mr87717155e9.7.1746517032809; 
 Tue, 06 May 2025 00:37:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:127a:7a9e:6ba7:152f?
 ([2a01:e0a:3d9:2080:127a:7a9e:6ba7:152f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3bc0sm12937087f8f.35.2025.05.06.00.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 00:37:12 -0700 (PDT)
Message-ID: <ba8d0f85-ba68-4610-9ec9-030af9bb6aa8@linaro.org>
Date: Tue, 6 May 2025 09:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/4] scsi: Implement get_blk() function
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, michael@amarulasolutions.com,
 avromanov@salutedevices.com, sjg@chromium.org, hs@denx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de,
 venkatesh.abbarapu@amd.com, ansuelsmth@gmail.com,
 ilias.apalodimas@linaro.org, mkorpershoek@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250506072415.1970069-1-quic_varada@quicinc.com>
 <20250506072415.1970069-3-quic_varada@quicinc.com>
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
In-Reply-To: <20250506072415.1970069-3-quic_varada@quicinc.com>
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

On 06/05/2025 09:24, Varadarajan Narayanan wrote:
> Add a function to obtain the block device for SCSI.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/scsi/scsi-uclass.c | 30 ++++++++++++++++++++++++++++++
>   include/scsi.h             | 11 +++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> index 1ee8236c05c..aa037c8e353 100644
> --- a/drivers/scsi/scsi-uclass.c
> +++ b/drivers/scsi/scsi-uclass.c
> @@ -10,7 +10,9 @@
>   
>   #define LOG_CATEGORY UCLASS_SCSI
>   
> +#include <blk.h>
>   #include <dm.h>
> +#include <part.h>
>   #include <scsi.h>
>   
>   int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
> @@ -23,6 +25,34 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
>   	return ops->exec(dev, pccb);
>   }
>   
> +int scsi_get_blk(const char *uuid,

Here the parameter is uuid

> +		 struct blk_desc **blk_desc_ptr,
> +		 struct disk_partition *part_info_ptr)
> +{
> +	static int is_scsi_scanned;
> +	struct blk_desc *blk;
> +	int i, ret;
> +
> +	if (!is_scsi_scanned) {
> +		scsi_scan(false /* no verbose */);
> +		is_scsi_scanned = 1;
> +	}
> +
> +	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
> +		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
> +		if (ret)
> +			continue;
> +
> +		ret = part_get_info_by_uuid(blk, uuid, part_info_ptr);
> +		if (ret > 0) {
> +			*blk_desc_ptr = blk;
> +			return 0;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
>   int scsi_bus_reset(struct udevice *dev)
>   {
>   	struct scsi_ops *ops = scsi_get_ops(dev);
> diff --git a/include/scsi.h b/include/scsi.h
> index ab53b47b58f..d6b6e6b665f 100644
> --- a/include/scsi.h
> +++ b/include/scsi.h
> @@ -351,6 +351,17 @@ int scsi_scan(bool verbose);
>    */
>   int scsi_scan_dev(struct udevice *dev, bool verbose);
>   
> +/**
> + * scsi_get_blk() - Provides SCSI partition information.
> + *
> + * @partition_name: Partition name for fetching its info
> + * @blk_desc_ptr:   Provides the blk descriptor
> + * @part_info_ptr:  Provides partition info
> + */
> +int scsi_get_blk(const char *partition_name,
> +		 struct blk_desc **blk_desc_ptr,
> +		 struct disk_partition *part_info_ptr);

And here it's still partition_name, and the name should be scsi_get_blk_by_uuid in this case.

Neil

> +
>   #define SCSI_IDENTIFY					0xC0  /* not used */
>   
>   /* Hardware errors  */

