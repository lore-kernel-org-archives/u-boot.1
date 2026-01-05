Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90965C79F9C
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 14:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFBD83DC9;
	Mon,  5 Jan 2026 15:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uvOGUU0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22CA83DA7; Mon,  5 Jan 2026 15:30:23 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2345783DA7
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 15:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso60370845e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767623413; x=1768228213; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WVVtGis809Ixn6gg+FPRxqDd1B0K0MzSvuC6hxupkTc=;
 b=uvOGUU0WDGp7j9Yp2sJcgwaTYzf3JT++gRrgANpPXBMVpsPrSrU6s/s74RnkVVYzUB
 MmgI/G3N+eju43Fre8VHNBGIFgtPwwhUJWjT7pnPvtyq2QX/E8VdwJj5cEjW+ziCagFN
 c/irCZTWy1WqqlF8lAh+4seFbsG/0638v+BpzYgZ0Te/rAAl+AvkqywSSCTYXMMtOB1L
 0Q/zKchDmWrB2H5mdSx0DDgOi/CjWrNHpT+1wEubJHHmAa8WjzkpY+u7Nccu4rxZSp3N
 KSMkz1RMliR6yhlwpiYpZI4583Yx9z6Gm/aeezxFxzFtWKzx16cH9A7x/0amgCDF75Rr
 SzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767623413; x=1768228213;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVVtGis809Ixn6gg+FPRxqDd1B0K0MzSvuC6hxupkTc=;
 b=M7j4Gu0vEP0nv08ZB8ez6YqmjtU28mVbQj7GipQhiTuKy3wMQo9Pr6phstIQ8c9gLD
 72WFdMbA/TSYVfzt5h43jt/6iaLab3UkPFVO1DTuEPn7s98iwGIGIL+/JrRcZ/jfDDNT
 54GJmUIyv+rft8Uvya61TQSxW7i4b5LbgBpPkOQsmvCwGjbTeeP5kzarOaUMjyh7jzW9
 ik63nrAwH74uIEhDaPwr+ZguX5CAp/oj8siCvvHeMCaw52Z4pksU3aFjetzZ+wxArMyH
 6pCTCEZDlCMABp5aJf2E5u9ahlIVKejnlD8/iVN6cFFDkKoQ1WMyZqu8gZPCy7UBo/kA
 HHAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcGmroEs004K1dt8B1YCe9YpGgx2QPcrJ8xlCRGZZDMSfQP7N3o8xS/o8wJb+T9GSFHlWKzBI=@lists.denx.de
X-Gm-Message-State: AOJu0YwhZ0mrUrDO4cEgaxV11niqednQ1LAGckwfPRLmCwq8iij7gDzf
 suBMQqtEEyMc9UsIRkISqftmUW9/nHTjesV4+XMwyQAhhllJ5uBPTld5xNUAN2u12x8=
X-Gm-Gg: AY/fxX7qlBA0BUoDzjFfW2F9d3qfkuLgYlgDr3KpAp4D58Ph+hCV6bLNGJLa4BfGwvE
 0PP+va2V8G4qTHnUfEZ/1IMn0+QR6LiqCQdkq1NZwK0pE4NIhxa8NW/JVj3Xij2Y4D8rv1kPk9q
 EJhd7KlJ8OjrmRgO2Mc/6Tb7bWhkyGRUwp5Eai6lP0CfHrewe7YWQtJDlgT7M6xRaaVjbdotbE7
 GiTalDdJOubMLquW+U4HBLqWY4CUyjp0h5yEJhJeIM5qqLaLsub+daj8mXaIzobRmeJX4WBLLAD
 VKU3/Tw7L7MRwAX69aTlnOhx+Dl34MOZYvRFl+C7lVOuase0d973+QfN12EC+lB7w1TCPRewAFO
 SuyrpfN+Ky7JbLLfHolQMVxNz3/sdtep2gLd9na9lM1N1hfk28jb1vsrm02y3G+/+ArAc63xhEt
 6WEU/I208cKcCD0RlC0MUB8+QpmUk0cFYOWT5ly+eSkSJ/oTbCtLpc/Od3wpOAQmY=
X-Google-Smtp-Source: AGHT+IGS4jXg9Mt/v3HWgWvIE5WzmHsylTy+R+/4emkspT0szeLkvsIdM67+VTr/aYlDQYgc9Z5SQQ==
X-Received: by 2002:a05:600c:3b2a:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47d1953bd8bmr643014515e9.1.1767623413011; 
 Mon, 05 Jan 2026 06:30:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d143f6asm164837135e9.6.2026.01.05.06.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 06:30:12 -0800 (PST)
Message-ID: <2605433a-95c1-43cf-87bc-0fc6f58d944a@linaro.org>
Date: Mon, 5 Jan 2026 15:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] scsi: Enable FUA bit and remove per-write SYNC_CACHE
 operations
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, quic_varada@quicinc.com,
 bmeng.cn@gmail.com, andrew.goodbody@linaro.org, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
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

On 1/5/26 06:25, Balaji Selvanathan wrote:
> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
> ensure writes bypass the device's volatile cache and go directly to
> non-volatile storage. This provides write-through behavior without
> requiring explicit cache flushes after each write operation.
> 
> Remove the SYNC_CACHE command that was being issued after every
> scsi_write() call, as it is redundant when FUA is enabled and was
> causing system hangs during large sparse image flashing operations.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/scsi/scsi.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 8fe6b38a8c7..b755616bf3f 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -124,7 +124,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
>   				 lbaint_t blocks)
>   {
>   	pccb->cmd[0] = SCSI_WRITE10;
> -	pccb->cmd[1] = 0;
> +	pccb->cmd[1] = 0x08; /* Set FUA bit to bypass write cache */
>   	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
>   	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
>   	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
> @@ -301,11 +301,6 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   		buf_addr += pccb->datalen;
>   	} while (blks != 0);
>   
> -	/* Flush the SCSI cache so we don't lose data on board reset. */
> -	scsi_setup_sync_cache(pccb, 0, 0);
> -	if (scsi_exec(bdev, pccb))
> -		scsi_print_error(pccb);
> -
>   	debug("%s: end startblk " LBAF ", blccnt " LBAF " buffer %lX\n",
>   	      __func__, start, blocks, buf_addr);
>   	return blkcnt;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
