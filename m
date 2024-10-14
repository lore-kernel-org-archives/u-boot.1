Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C4ED1812D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 16:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44AF89018;
	Mon, 14 Oct 2024 18:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NpVPxE62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9195E89160; Mon, 14 Oct 2024 18:13:34 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4185088DE5
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d6a2aa748so1034765f8f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728922412; x=1729527212; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=SZ0dGYBoOLXtXbXL9z1KX2BdvDzcGjBNE1aKDGtXfY8=;
 b=NpVPxE62ByvuBSqdH0HPnfkvSSQpeIvEZ/qCdUMr52GVBFsqDurSDUWgCD6902w49f
 JybvuDArbow+tkxGCPhxm+fvVbqeaWtz/Ot9bMR0rA4PBgWIl65wKPXSv8nAZ0xkv4cu
 AhWbhFaeAdW05hLUE+xjYBcVySx50AEjlINwi6cOrcKQ0FZmMYRt3rv1gfkyqJbeQd1Q
 Fuuol5QE0NCFpZiA1ayZazJtkuVNadz6Kqaotprw7XHxvOumP1KNRgKUhrubtKODQAlr
 Pqzs19o+Kr05r+qDxTvBoR/Rq18FQ46DfblHlriR8q9NGvVfTolhSsZwLInU5d8qSpB6
 BeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728922412; x=1729527212;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SZ0dGYBoOLXtXbXL9z1KX2BdvDzcGjBNE1aKDGtXfY8=;
 b=sXWdsTrsNFkmdEJs5Vg8nx3NRkvfApMzfV3RAJhqU3HUGwoV43O2OBhJ8E1scs0qQV
 uH2wx+R1MClWGNHeYIqm4Mu9G9tkcC09AB9E4Qcoi7uV1gduuw5j187NYleKPzCwt6na
 3mxb0YEK7pjiStdwH0T72TLxqRoYYBVCdeA4UxzIeR7dQu4hHrVju5hgLQXy4RJ2x6hx
 dkDwPpio+yfrSUsLi6fUR4iCFNyK8+oEhjwtEvMEdy31RxiL+PUfknONtcs3rDnCqwYA
 TFI3IGPBaTTj8Vd41fKuE4sKU3YKLo0gq0NP72qS4S1XpZIjwB3AJARfl2r/WIXX7hRi
 iG3Q==
X-Gm-Message-State: AOJu0YzG3N6sjV9aQJbWX/XNTTc3w6kfrri+pGmDsAjcQY35NOxtuXNg
 B1mmHKKLBneVkMe8+kh7XmWDgm0QjjQ9yXYE7MEe+hpssQHkYqbeqE0xuGGA+1I=
X-Google-Smtp-Source: AGHT+IG+/5ARgtWaefmbuLqdjDFuAJyX4+LvtfOCY/JTnwxXsb2EwY5WmGrpd2ww2Ji+YvcLS5pUUQ==
X-Received: by 2002:a05:6000:4388:b0:37d:614e:2bc8 with SMTP id
 ffacd0b85a97d-37d614e2cd5mr5678673f8f.35.1728922411597; 
 Mon, 14 Oct 2024 09:13:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bf3:bb7:467:a56f?
 ([2a01:e0a:982:cbb0:6bf3:bb7:467:a56f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b79f69dsm11701737f8f.81.2024.10.14.09.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 09:13:30 -0700 (PDT)
Message-ID: <92452319-cc05-4b7c-b9ed-ecf325fd5719@linaro.org>
Date: Mon, 14 Oct 2024 18:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] scsi: fix disk capacity too small by one sector
To: Julius Lehmann <lehmanju@devpi.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de>
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
In-Reply-To: <20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de>
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

On 14/10/2024 18:06, Julius Lehmann wrote:
> SCSI READ CAPACITY reports the address of the last
> block and the block size. The total number of blocks
> is thus last block address plus one.
> 
> ---
> This patch fixes the disk size reported by scsi. Up until now, the reported disk size is too small by one sector. Read/Write operations on other sectors have not been affected. Trying to partition scsi backed storage via ums has resulted in "storage too small" errors.
> 
> doc: https://linux.die.net/man/8/sg_readcap
> 
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>   drivers/scsi/scsi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 51cacf3479236be6c6ea3e7d15b87e03f10e7f3a..bcdeda95ed1514119057cc67974fec465cf5672c 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -309,6 +309,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
>   			 ((unsigned long)pccb->pdata[5] << 16) |
>   			 ((unsigned long)pccb->pdata[6] << 8)  |
>   			 ((unsigned long)pccb->pdata[7]);
> +		*capacity += 1;
>   		return 0;
>   	}
>   
> @@ -332,6 +333,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
>   		    ((uint64_t)pccb->pdata[5] << 16) |
>   		    ((uint64_t)pccb->pdata[6] << 8)  |
>   		    ((uint64_t)pccb->pdata[7]);
> +	*capacity += 1;
>   
>   	*blksz = ((uint64_t)pccb->pdata[8]  << 56) |
>   		 ((uint64_t)pccb->pdata[9]  << 48) |
> 
> ---
> base-commit: 29e5dbc55c64c6450f066c55a5bc48bd1717aa1b
> change-id: 20241014-fix-scsi-disksize-d73a017cadf4
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>

Indeed the reported size were quite strange:
- Capacity: 19.9 MB = 0.0 GB (5119 x 4096)
+ Capacity: 20.0 MB = 0.0 GB (5120 x 4096)

Thanks for finding that!

As reported on irc, it's pretty well explained in the sg_readcap man page:
"""
The SCSI READ CAPACITY command (both 10 and 16 byte cdbs) actually yield the
block address of the last block and the block size. The number of blocks is
thus one plus the block address of the last block (as blocks are counted origin
zero (i.e. starting at block zero)). This is the source of many "off by one" errors.
"""

Thanks,
Neil

