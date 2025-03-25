Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2357DC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7570A808AF;
	Tue, 25 Mar 2025 14:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oOc8RB4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C305E80EEF; Tue, 25 Mar 2025 14:33:37 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB30806FC
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so27902105e9.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742909615; x=1743514415; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KOBCGjmaF3X43TBaykevtwFkHhCOkXNA/SM0oyl2ujQ=;
 b=oOc8RB4USpH6zOQ2ug3xGB5WE2qH6sIMjL2G62mahDU/3zVg1yyBY7qJ+n4FbVyN77
 8NuCOTgFNF8gaBq5QZ1CR/n9K2zplYLPm5SgC6aiafxcFmEIkwrypBXAN3XnO5rrP4O3
 +N4EfWT7KHFIn+HwyIY80cP6Jjnz6PlnwNJQ5ajFncy0W6QEoPG+fdXnn4hmPmC8bt1r
 7ZVI6eiYHNCJU1+Z/mfNZxaDredal0I+MaB3EwjMgeNUXCZwcs/uphTCbMseavZqNORC
 AkOUCnKINyQ3Ot8BZMoJQueOyq0VjXptCfxl2Leq3WewRkTZcCOdK6le1U1HU3oB2WAj
 Nl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742909615; x=1743514415;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KOBCGjmaF3X43TBaykevtwFkHhCOkXNA/SM0oyl2ujQ=;
 b=wJcyH8uHsvZmdyKdP3gvYsgpinprrfyFBN4J1O9LE3ncLrq2PEiEyOQQtf5EHFfZy1
 41OXMtkoopVjCNee3SaGokeuaIsuUZXcn9jlqW/SOJAN934VI3ZmKKjFTMhK2DnqvMsy
 eHD+03A0zLR7AZ78VWlgyHBn4tOeXVI1ZdfP2aCAqg+BsG03CNeWeKq+2EgYsSoX1nGQ
 AFqrspENA45N+zNBeJc1gGNur646TUJmESpQdlm7e6tikvtumxy85E1M6KUyyjjXBkJ7
 SlteicRrLpt7oDN0JgL2tcOtGEAiNDWNsqR+AXZRi7F3YK+4UfrXUOskKlmpE2k9/MuR
 UzEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOw4W9LiQV/QL/leJoqR8JjH4f+zAmHFxXk8aQTWQ5pNPzVXPDJ3fNdbiBR9YIDH8NkBVgQmE=@lists.denx.de
X-Gm-Message-State: AOJu0YyIS617f8zfBmtqHTsB65F4jgr0I6RfNx3D5FKz34b0Si6jMd4x
 7MdIG7rcDNibXr5f7VPhG6/T7dJlqVvl/H5v8F7BFaeJRNZIZSZ1kiEFiK+z0MQ=
X-Gm-Gg: ASbGnctHyNyR+kSnrFan4ueLs35rcD+T4dJXZg4Bh5fRwtVnE/zQDjE/oj2bDtIAtx6
 eYcvvbhHUcJiZYYraOtu/UHuGIymT5BgfC/jvjRn0dgDYMso8QPA5B3zI3T3BjEPRyZqyICcWlJ
 ATaVo5tPoA6HVSHNxsldNuCfYuOCXUDJF/wVraTvduTYIbpkFmhw8Pg/mekX2nr3UTeoyN/teAY
 Uc0mr2BwmUpVPZprWRH7Kgh2MZAJfo0oRaZzO2o3uIm3pay/+v8Oz0nvzssPynEAB3iOb/lIZpx
 ZBQ3FhHILKZf0Dwt0z0mIVlDuWDqhRjgQu7ZLN4uCoSHNQb3YT5Ja5SUg2NB1jTpwlVukrLVEjU
 O80UZh3c9yDuo8buO
X-Google-Smtp-Source: AGHT+IHk/OE9v3f41MYTrG/RjLJuX0T4uQWGs6+3IYaxVoiC2cC3my0c9nnEh2BuFcpGqq42JKTuaw==
X-Received: by 2002:a05:600c:1992:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43d50a553f2mr154810045e9.31.1742909614853; 
 Tue, 25 Mar 2025 06:33:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802?
 ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd17cfesm151866405e9.10.2025.03.25.06.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 06:33:34 -0700 (PDT)
Message-ID: <b737a955-36fc-4816-8169-2a27270d9fce@linaro.org>
Date: Tue, 25 Mar 2025 14:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] scsi: sync cache on write
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
 <20250325-scsi-sync-on-write-v1-3-3575aa1342e0@linaro.org>
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
In-Reply-To: <20250325-scsi-sync-on-write-v1-3-3575aa1342e0@linaro.org>
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

On 25/03/2025 14:02, Caleb Connolly wrote:
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
>   drivers/scsi/scsi.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 1aa7fbdbb5278e387de72a3c3e73d19ea0342fff..1b71e580b89b100395ea132a4976366a713cba8a 100644
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
> @@ -235,8 +252,19 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   			blkcnt -= blks;
>   			break;
>   		}
>   
> +		/*
> +		 * Ensure the writes are flushed to disk so we don't lose data
> +		 * on board reset.
> +		 * FIXME: this ought to be in a SCSI shutdown path instead
> +		 */
> +		scsi_setup_sync_cache(pccb, start, smallblks);

Why can't this be done at the end of scsi_write() ?

> +		if (scsi_exec(bdev, pccb)) {
> +			scsi_print_error(pccb);
> +			break;
> +		}
> +
>   		if (blks > max_blks) {
>   			start += max_blks;
>   			blks -= max_blks;
>   		} else {
> 

And perhaps a sync subcommand of the scsi command would be nice to have !

Neil

