Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF67DC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43457809D0;
	Wed, 26 Mar 2025 13:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="klglq8KX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E86180BAA; Wed, 26 Mar 2025 13:30:56 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C9E8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso72073775e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742992254; x=1743597054; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TTQiGsTyV7W7ehBq1vhURrYqZbjNFD6ikuxHpgCqDsM=;
 b=klglq8KXm1sRVr1TTac3yVufA/daNiyVhxzRtiZ35Sm7/kvDW7Kkn8JVFX42BveW3T
 CVh1dqtZxehoEAJDuzEhprqVkJ7BJ1d7XKakwDDVvfAzqh+wt/whSfKWCRwENrMKaRwd
 9oa/25lxAtP38s1nbFutT3ge0VyW7BH/7xmYA7dMneTokR3oQOq741J/ObtwZ8rUFVuM
 uQnlVu7hnCWgvaYpGwWwNa/lqrQ2xZ5HByVwYhENRWEqqaFbzZoMK7pWZl9cC+g8sz53
 Mytr3vmw/W4lAHp7yhdFxohX6PFI5U1bOPx2fZOe8g6/memtiN6qIJ2Zsl2eZZb46/7Q
 yL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742992254; x=1743597054;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TTQiGsTyV7W7ehBq1vhURrYqZbjNFD6ikuxHpgCqDsM=;
 b=ntdMggYmYoAePOJiGWFkyMut2RfqMKjDH6Y5mXiTcP6jfknvqxG5an9aq/D9d9DW8+
 RBQJFCw5WjgGJJL6ajziTcFUFZVtR0XF+Fjer7VGMVTQHLuLWCooYlv7DEaYWMoykMib
 oCQNtacTm2jffu6UmYxzrMxtzUb7PqVcN+nZe+pkNHyFhKMxZwrsrgf/rODJwlfE3I3V
 JzR3mRlaEkDLrllnoHQX3QtlpbCPfF6pCw5EuncJTQVtLVqkzwiITpeuA4t060wwygNa
 TtbiUNkULWKsfrrDgdU+ztk2qsrK+MM/W80oNuo91He9D2WALgRebQkNm2Za1aL/Mp2X
 bGIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV430ZCdPyzx00G3Nt/UnkCzSLIKKdqheHPVjAIzYTYya/I2Ab8FD9wPbNATHWZ34rgerHjpGY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3YWTrHGFXenA1lBxv2QjtDR6fUxZnszVmpjp0EZWuNA+qS1m+
 Bx8i4znm9vpMDMal4IJjyQGfbNGoGlj2nfS5F0s/I19fDEVTpGQ83/RqfOfL5LQ=
X-Gm-Gg: ASbGncsgHWui4gO1+R6I4WRVqAHjL685RCC6fMfo1myYUCPuEP66YUVuUE/x7G3FqZM
 YD+w4tIr2TGbP/LvQfrlgl/6Xj2syw39gMnR6PXWRb4O1xJ41Gz/JquAz/2bcRpqAjpPNo+EzdY
 QsF6iU4Vh1BqBYnkP1z5KA7fDT3XIjD4AZm5I9rvGqBtZ3EOyy6vSJphc39UBGf25z9bWTMf0Df
 aZknQRugpEPJIjvO1EZ5zTjdzuQjYoyLj7LWl/3QFOa2BtiGFDfMG++KYzPeI7rvO5R/54QF0bW
 fJPizkBM72B/Iv1q7raSSmWg4Qks9SAo80ONSGsUP5TqyJ+vzlFYIu//6nNCAc7vXrFNvlHVJ2b
 UX5eWvfzlHn7BAEU+gzx6uFG9cR7gIRaG
X-Google-Smtp-Source: AGHT+IEVN8XFC/0/tEaXUY7nHs9MjzUElUSIjFh9hDpfCZaw2ACX+by51WPd5nUp4wfrRhVIHxozfQ==
X-Received: by 2002:a05:6000:18a5:b0:39a:c80b:8288 with SMTP id
 ffacd0b85a97d-39ac80b8580mr7059574f8f.33.1742992253570; 
 Wed, 26 Mar 2025 05:30:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a11f:a03e:c86d:c567?
 ([2a01:e0a:3d9:2080:a11f:a03e:c86d:c567])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efeb1csm564655e9.19.2025.03.26.05.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 05:30:53 -0700 (PDT)
Message-ID: <e2db8638-96d2-4b16-8fc0-315c3f5463ad@linaro.org>
Date: Wed, 26 Mar 2025 13:30:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/3] scsi: sync cache on write
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
 <20250326-scsi-sync-on-write-v2-2-12ab05bd464b@linaro.org>
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
In-Reply-To: <20250326-scsi-sync-on-write-v2-2-12ab05bd464b@linaro.org>
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
> We don't have a mechanism to safely shutdown block devices prior to a
> baord reset or driver removal. Prevent data loss by synchronizing the
> SCSI cache after every write.
> 
> In particular this solves the issue of capsule updates looping on some
> devices because the board resets immediately after deleting the capsule
> file and this write wouldn't be flushed in time.
> 
> This may impact NAND wear, but should be negligible given the usecases
> for disk write in U-Boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/scsi/scsi.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 34ac47c03ab397ca999abf130d84ccbd3be4c419..3e556540cae46734d3b13a72cf279905134336f3 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -77,8 +77,25 @@ static void scsi_setup_inquiry(struct scsi_cmd *pccb)
>   	pccb->cmdlen = 6;
>   	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>   }
>   
> +static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t start,
> +				  unsigned short blocks)
> +{
> +	pccb->cmd[0] = SCSI_SYNC_CACHE;
> +	pccb->cmd[1] = 0;
> +	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
> +	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
> +	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
> +	pccb->cmd[5] = (unsigned char)start & 0xff;
> +	pccb->cmd[6] = 0;
> +	pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
> +	pccb->cmd[8] = (unsigned char)blocks & 0xff;
> +	pccb->cmd[9] = 0;
> +	pccb->cmdlen = 10;
> +	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
> +}
> +
>   static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
>   				unsigned short blocks)
>   {
>   	pccb->cmd[0] = SCSI_READ10;
> @@ -239,8 +256,14 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   			break;
>   		}
>   		buf_addr += pccb->datalen;
>   	} while (blks != 0);
> +
> +	/* Flush the SCSI cache so we don't lose data on board reset. */
> +	scsi_setup_sync_cache(pccb, 0, 0);
> +	if (scsi_exec(bdev, pccb))
> +		scsi_print_error(pccb);
> +
>   	debug("%s: end startblk " LBAF ", blccnt %x buffer %lX\n",
>   	      __func__, start, smallblks, buf_addr);
>   	return blkcnt;
>   }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
