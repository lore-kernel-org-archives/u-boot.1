Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6061C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABF080BAA;
	Wed, 26 Mar 2025 13:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WOqYpY8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D0981B4B; Wed, 26 Mar 2025 13:33:12 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE238083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso31045305e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742992390; x=1743597190; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NCAcxStaRQO5gueC9/NHoUWZmohkEoFVw9sy5T49T/A=;
 b=WOqYpY8A6XW3ItVqvunYA3wmHcUesJLuTDV/CEMvO9X9So0JomuppFNZwttPb2zB8t
 Ubsty4HgMT1AJpdzWAyIafnd3z+ZSAJUgeOcdBxZcnaq6JwLVHsqYbvAyn2b/vsMQWu9
 TUj+Bae/397giH2uLZWRTQCzwezAxFXolFwkL071Fb15Bz7G0RPewpRnMrFqS62yWnNA
 68pdgHqmIxBp81aYpEMgIDc/MVvMQX0tZml+gx2NZB7z1GXIr4UIyv/0RXmzZWLKv7Ju
 TGJuEIPa7wTzm8zOM1q472FA3jQMjx8OViPwg7mbPGQ/iha3AKUEwuh8Cfrl4BcKk3yy
 lhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742992390; x=1743597190;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NCAcxStaRQO5gueC9/NHoUWZmohkEoFVw9sy5T49T/A=;
 b=eHA9Albk8CQV9TQ/CzlTWTW6E4i5eeSFpP7avwekxyEb4/yg3SpmmvEOC00VHUSCay
 W3CXoXjWW83DYOIoNZ0G5d/pVL/VkJwnkvtYQNLtakkhJO6odkF2ljknjMCYWX+NBmdR
 dVVlBotk7TFcaVCGJTtyLXU5AVNGpjOgBREV6wHw4Yxo/zFlVivwHXZ2FaCpfakXQIeM
 n306bcTgO8kyBwP10zjICtwGCOZKk62tX6TYEB8eeX0l7gSeV4encz3SfHC7oTzHEOqt
 3Q6eNkNJR2cEGqybY+G/JqIGxvqlS3Dopa1Th0DYsYZqMCA6Q89iwDfzlpgGholxH82U
 gZuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIgHT5L+BC3wFA4S3SNMAF1qF+UOUoTwfciw+xK26QCOs3O/nXoEn5XL+3TJxiFopaRWyL0CM=@lists.denx.de
X-Gm-Message-State: AOJu0YwDfU0FXLJUO6PnbZrEtRB2AuLp7J7lPvOdpY4kbutfEvKr2t06
 kS2XBK/8L7qlcRdMBcigap1/mk9/DFr69MvwlbUvT51pezZvm2aB2cz6Z7vMhxj1IWhMucRjoB/
 e
X-Gm-Gg: ASbGnctPnNd5I7BbrrL9zaNCc7ooVKfGWpnizGSA548QM5SUaxXd8jmr+tYb30Gs5Wu
 9umHUy9nEAGFV5IVVIihKAUeujvvI7cRD0YNB9OHb3omBdCwMHNBtDceM7XVnaXwGRtpOVLQMIj
 yeHFeVAZFfoZo4qXRbmxJJxNTt5Q6ymTqm1yzbyTHs/0jzusZH48+v3AA1X8eEugD4QylsRVMPF
 VA0nrVBC+sMU2ektYy1d1T3wTOx0s8oqK6bHUK7bgnohxGFLzgx394U3EM+0t/BswhxObs+p7we
 dfxD/Im+frE8X9IQEIodXAs013axCo4lIrehhIKuLaLqMrpImIitBfi5d5dnmPR9rureZgAVOPT
 YcumFCEBhxYgMSTZJeGKkag==
X-Google-Smtp-Source: AGHT+IFsldOO84JpDixMplu96YB4WGIpyxz2z+lkpS6tz8UsyRlvACjY9e/5ql1EYbhymJRGiuKQmg==
X-Received: by 2002:a05:600c:3547:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43d7894c000mr30346925e9.10.1742992390036; 
 Wed, 26 Mar 2025 05:33:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a11f:a03e:c86d:c567?
 ([2a01:e0a:3d9:2080:a11f:a03e:c86d:c567])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dedd03sm739275e9.3.2025.03.26.05.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 05:33:09 -0700 (PDT)
Message-ID: <ffde5a2b-9b36-4cf0-ad0a-ede384112463@linaro.org>
Date: Wed, 26 Mar 2025 13:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/3] ata: ahci: implement SCSI_SYNC_CACHE
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
 <20250326-scsi-sync-on-write-v2-3-12ab05bd464b@linaro.org>
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
In-Reply-To: <20250326-scsi-sync-on-write-v2-3-12ab05bd464b@linaro.org>
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
> The SCSI layer now issues a SYNC_CACHE command after every write to
> ensure there is no data loss due to a board reset after write.
> 
> Implement support for this command and remove the same logic from the
> ATA write path to be consistent with other SCSI backends.
> 
> Ranges are not supported and the whole cache will be flushed in all
> cases.
> 
> This was done per iteration in ata_scsiop_read_write(), but it's not
> clear why this was the case, calling it once for the entire write ought
> to achieve the same result.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/ata/ahci.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 8058d5ff1c37f92914f250fa9cc78498a3f27331..deb91efd6d2666016f375feabb16ebc8f68fb697 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -735,19 +735,8 @@ static int ata_scsiop_read_write(struct ahci_uc_priv *uc_priv,
>   			debug("scsi_ahci: SCSI %s10 command failure.\n",
>   			      is_write ? "WRITE" : "READ");
>   			return -EIO;
>   		}
> -
> -		/* If this transaction is a write, do a following flush.
> -		 * Writes in u-boot are so rare, and the logic to know when is
> -		 * the last write and do a flush only there is sufficiently
> -		 * difficult. Just do a flush after every write. This incurs,
> -		 * usually, one extra flush when the rare writes do happen.
> -		 */
> -		if (is_write) {
> -			if (-EIO == ata_io_flush(uc_priv, pccb->target))
> -				return -EIO;
> -		}
>   		user_buffer += transfer_size;
>   		user_buffer_size -= transfer_size;
>   		blocks -= now_blocks;
>   		lba += now_blocks;
> @@ -845,8 +834,11 @@ static int ahci_scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
>   		break;
>   	case SCSI_INQUIRY:
>   		ret = ata_scsiop_inquiry(uc_priv, pccb);
>   		break;
> +	case SCSI_SYNC_CACHE:
> +		ret = ata_io_flush(uc_priv, pccb->target);
> +		break;
>   	default:
>   		printf("Unsupport SCSI command 0x%02x\n", pccb->cmd[0]);
>   		return -ENOTSUPP;
>   	}
> 

Good catch, much simpler to move it in the scsi layer !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Can someone test on a SATA enabled device ?

I can have a test run on the Odroid-HC4 with a PCIe-SATA controller.

Thanks,
Neil
