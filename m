Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B263C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7612380EEF;
	Tue, 25 Mar 2025 14:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q/UW5+BA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38708192A; Tue, 25 Mar 2025 14:38:48 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A15D0808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so4310887f8f.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742909926; x=1743514726; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=E2QqO9y2RMAE9NxvHwMG1ErcqFep2LSn2Qk/g95LN3o=;
 b=q/UW5+BAqB+h8NTajklgRhDs7ZkdYqJOTVo3qTQ1dD6w/BfFf6qjUirpGcTAdhnjwJ
 iD0Saa6oVyls2twLxN50gLHi91y/QPieHfiMHulDH8276cJHeYdZz2beYx8Vrjdbpwsl
 XIlzmwbabFrakS1VYCxd1HpuWsAv9Htj1OepGHUmVf33kqUXQJiE9fvI7DUfrWuPEniP
 m2PAcuKiQhEkmwMW2kNiXQpzwwBDTzEe/Zu+ne7Ub5y8U4np6SGvjYrYCDu3MxdiuFbX
 4svi6naVf4p+LpJiXYQtDf8eF/875lBrRFqUHjWdEjowFKewI+pmUO9/Z97vzynrLxrm
 QXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742909926; x=1743514726;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=E2QqO9y2RMAE9NxvHwMG1ErcqFep2LSn2Qk/g95LN3o=;
 b=uXBUM/MGaiYiURTqFxa0Fwus5QZXNn3Stw4zSyFxdgDTye7Gm22cPH3ABc7qBn7Dwn
 TLmDdvcIcbLpK2XIGGmpxPa61P4V3ga4naYu/oGVTS/5irj2A3XNvccDsapS1FmZHJUt
 DitlNEwvGijAgjdihoYPEnq6TODnCw3uFAwAwifgT1JSLH51uF1YPUDhRsDPwSIwFcyJ
 ypItYi6zDiwiiaow2L6XIlXx5KdvDfP1+y/bTJekq+Uq8tBzNGr0aYUHO5JWFgc11RrE
 4s3N7op4i4zpcCeU+qX76i0jn6ZOZgpe+zIpzik8UfP60v+FfSjod8IYJx+Z2rb2kJGf
 YRDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhZNuVLCRAe/jCNYqgqKB+kY4aiY2Rib6H1ORHsw0wReaQ279F+qwZKQmsMiWXmuQMTd7ATuI=@lists.denx.de
X-Gm-Message-State: AOJu0YxdiwYofCvxZBaO9f3l98PzoJ3VFKZn5Kdo7e93KpqQhEVJ5vEU
 nRULg779d6HkS6iQyjgCenUzmmwIhECx2ruBlr1wCasYs05HFMgcwQ87OX9R7Vj8sfTysQ3f6fp
 O
X-Gm-Gg: ASbGnctkOJx/oeigwT+I27FOVUvZJ4PdMBlNo6Q/YEM3WpKC0RHqssZA6/HMKOuGqA9
 inGssaXTcniclvoi1SSAIzcaMYj5kRmXFda4nZm/Oztdhv5PAArcbOpGp5d3Y4LKP9NhugtKRYU
 hxMnJnSqZHGf+QYzTkXa4vhFn8GaFCKyTppGAljt0/CTcUpkJPpgxgSBOPD4+G02dB1uRFhNmqi
 V3hEUS3b+yUiYDA2FK8UGS9QbYGGCElkBaSRfDDnN2a4pDwLVn5vR3zKlKQUBaK4id5FyXq8rZa
 O4J+MstAPrZXYwLfpeWijzP2N69i0lGPBfU96gUOcM2TIc+J8M/ezaMSFOAIRIk6ErCwaPLaeIn
 p4C6ywixT961wP08v
X-Google-Smtp-Source: AGHT+IHCuXoqn8qV/Hd7i89oy+f+urgVjR5Ui7tGYsM8amNAD1qCfQ3DhIfvwYZOVVRdVJAuhljvFQ==
X-Received: by 2002:a5d:64af:0:b0:391:2c0c:1247 with SMTP id
 ffacd0b85a97d-3997f8f8c14mr15813721f8f.1.1742909925931; 
 Tue, 25 Mar 2025 06:38:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802?
 ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f99561dsm13984114f8f.12.2025.03.25.06.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 06:38:45 -0700 (PDT)
Message-ID: <10359646-6c8e-4872-8017-29d83e5d0f7e@linaro.org>
Date: Tue, 25 Mar 2025 14:38:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] scsi: de-dup calls to scsi_setup_write_ext()
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
 <20250325-scsi-sync-on-write-v1-2-3575aa1342e0@linaro.org>
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
In-Reply-To: <20250325-scsi-sync-on-write-v1-2-3575aa1342e0@linaro.org>
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
> This gets called with the same parameter in two paths in scsi_write(),
> de-dup them to prepare for additional logic after the write.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/scsi/scsi.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 34ac47c03ab397ca999abf130d84ccbd3be4c419..1aa7fbdbb5278e387de72a3c3e73d19ea0342fff 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -220,25 +220,30 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   		pccb->dma_dir = DMA_TO_DEVICE;
>   		if (blks > max_blks) {
>   			pccb->datalen = block_dev->blksz * max_blks;
>   			smallblks = max_blks;
> -			scsi_setup_write_ext(pccb, start, smallblks);
> -			start += max_blks;
> -			blks -= max_blks;
>   		} else {
>   			pccb->datalen = block_dev->blksz * blks;
>   			smallblks = (unsigned short)blks;
> -			scsi_setup_write_ext(pccb, start, smallblks);
> -			start += blks;
> -			blks = 0;
>   		}
> +
>   		debug("%s: startblk " LBAF ", blccnt %x buffer %lx\n",
>   		      __func__, start, smallblks, buf_addr);
> +		scsi_setup_write_ext(pccb, start, smallblks);
> +
>   		if (scsi_exec(bdev, pccb)) {
>   			scsi_print_error(pccb);
>   			blkcnt -= blks;
>   			break;
>   		}
> +
> +		if (blks > max_blks) {
> +			start += max_blks;
> +			blks -= max_blks;
> +		} else {
> +			start += blks;
> +			blks = 0;
> +		}

Ok this changes the logic and the result of blkcnt on error, before
is accounted the current command in the blkcnt but now it doesn't.

Weird we do not return any errors

>   		buf_addr += pccb->datalen;
>   	} while (blks != 0);
>   	debug("%s: end startblk " LBAF ", blccnt %x buffer %lX\n",
>   	      __func__, start, smallblks, buf_addr);
> 

