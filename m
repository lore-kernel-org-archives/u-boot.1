Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AF4C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73D0A407DB;
	Tue, 21 Jul 2026 07:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_3TjZE0S1al; Tue, 21 Jul 2026 07:53:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1B0D40843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784620437;
	bh=/5eO0ORDUPm2lwIgB0NvGw0IuMuoY8u73UsEl23BJDM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oHck4W8JjmKcD2sAMmVEihlFlC3suqQNGoKiw4MOuEEpNfEHg1j5y0CBuFbVN3giE
	 2Jn1fkkbpXU8QMTc/2UpGASbb2V8FH22Sg39yxSMhSg5pkoB8P53EM41dlIViZmqN0
	 +aDEAQq5J90buCO2yqIFXCDQfMDH69D4E+T+P+unNTd3tsk3OQJg/HEKKvI6yf+aRs
	 6K/nEaZuDLgxUCOYMEmn+i9zKLzNjgFQTqdtFTaw8FbowDJsQZDdrG66DHkVwV01+z
	 DLEi+zJXlSv7t3v3WC2+f2jzRIuUNNFfOlYKypDVsnz0Mzn/EMfTvjcv40EtTjhvkw
	 tGPrlRtF41MtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1B0D40843;
	Tue, 21 Jul 2026 07:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 258AE1093
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B9CA402F0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M7SWc6NPjgTr for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:53:55 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF91B402ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF91B402ED
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF91B402ED
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:53:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C948849EB; Tue, 21 Jul 2026 09:53:53 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20309844F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:53:51 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso26113465e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620430; x=1785225230;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/5eO0ORDUPm2lwIgB0NvGw0IuMuoY8u73UsEl23BJDM=;
 b=EYDsHs36PmnPPSAPZ2ZXMv4m+qhjq0A0o1wE0DPt+YH02qSWoujchPnlCZGD0V0pTw
 UtVu1V/9IzOVAz6dvONzBufdZFF1hTfTkFv8q3PrGn8ImzqtHCm1cz0Hptm+Me3fiH6S
 j6DgE+0FMmBCiveGIKGlZoXC9MoyLb5wFLEL863TVt5+F1B+35+UWu5AZk0DTdMnV4Op
 zWfQMTxRkx1/gxmG/0vumWEDHTKV02bOBlntw1/vchyrMzhYb1YOD3r9bzQmAniPQY/Z
 Sx64eKImqTR4PIElbBnvu9K5xufwuLJ3nCqzUc8cuQwvEUHgkQ4FgmtTXYEhFYlIRBfP
 2GxA==
X-Gm-Message-State: AOJu0YzK0FcKCCYO6/eM3gPilZ49p+8IEkK0V8DlCN5bMblxgYZyS3pu
 G75p4LHMslyMHFBqICmddjxDNPBh5iR9t03wUKY1hRLMntA8EqWloMthFmzIzGV+qU4=
X-Gm-Gg: AfdE7clr2SW2JIZNtQ598IU1jq7kdYghpY6Bbz3Sjr+shFbcTY35TNaSpax8qH0oEY/
 h0SP1iyGWfuoqfw0E2TXjlVAZm0cKUeVM8vNSAqk/UwktYSQmUUAGkoTH5qRuG6ck+bMInX7Fl7
 /sP+JI1zZC0XzxMPJ51r8eyyIXPPaaz13gosmBUgC28aFYk73VjL4dwEHsWgznk8PIh979TmKO5
 qzdRdzSlJnZcszNUk4g21t+5L8b8Ebg47R0REq1varAFq/Ow9TNGGycZmtbgSf2+zpjG1ZHNEMc
 HeI/Tmnky2tnvnvWwZ7ZCQelay5NldCa70gObeBPFEvTgIvxfm3RatkG4bN0zF4H3Jn4JIcU5CW
 YACSkOkjLJaB9nghm2YrFTu7gLt/YMc38URjSTjMOiGm7Jww0lHgnXG7/F2trF+8fOdghUZcVDg
 elgdwanOafPT6sYm/svOPfcGHiG3JXiqaU0d7mKzJMyq6PBwGr+B2VP5uoX2WWokGTqJD3
X-Received: by 2002:a05:600c:19cf:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-4954aa1a116mr203979165e9.18.1784620430436; 
 Tue, 21 Jul 2026 00:53:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1?
 ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563e60fd9sm52314465e9.0.2026.07.21.00.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:53:50 -0700 (PDT)
Message-ID: <ca997b48-7473-4057-a358-b3e4d3dfda71@linaro.org>
Date: Tue, 21 Jul 2026 09:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] ufs: rpmb: bounce unaligned frames through a
 DMA-aligned buffer
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-6-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260720085202.537019-6-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784620430; x=1785225230; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/5eO0ORDUPm2lwIgB0NvGw0IuMuoY8u73UsEl23BJDM=;
 b=kIT7kobU68d9+m1o5JunZZWVBEPaRXdqjq6TBEXmdfu12JfOV5zJLGd9ESXCjL7e6V
 zkdVyep2Nf4Vc4r73ocY0cZN3bsZIkFYbexz7nSnuEOjTyU/q1bGgIotTMfCG4pGBuCS
 Irkn10yMIsROT2AJOrOrwJBDhj5nP0cXO5xpMqF8cpW+3i3X9fk9C8uxmrrhV2Z5eQ8v
 LtAFveg7vFjl5UVowahJ3S0RGMGCOZN6Xiqs42spGMIh+cXvarNWoNGXSNXE75fqG7DY
 hNjnnww5USXe3twstXNpjQMNBJQk+XldBxiDPeqSNDZ7m8NWjePs2NyPQW3HttN1I2kr
 DRHA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kIT7kobU
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="kIT7kobU"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Neil Armstrong \(Linaro\) via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> The UFS controller requires DMA buffers aligned to ARCH_DMA_MINALIGN,
> but the RPMB supplicant may hand the transport an unaligned frame (for
> example the status-result frame built on the stack). DMAing from an
> unaligned address corrupts the frame and OP-TEE reports the RPMB device
> as failed.

Same as previous, I don't see why it's not part of patch 2, and the change is fine.

Thanks,
Neil

> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/ufs-rpmb.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> index 1434161682b..6a02803edd9 100644
> --- a/drivers/ufs/ufs-rpmb.c
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -2,10 +2,12 @@
>   #include <dm.h>
>   #include <hexdump.h>
>   #include <log.h>
> +#include <malloc.h>
>   #include <scsi.h>
>   #include <ufs.h>
>   #include <vsprintf.h>
>   #include <u-boot/blake2.h>
> +#include <asm/cache.h>
>   #include <asm/unaligned.h>
>   #include <linux/errno.h>
>   #include <linux/string.h>
> @@ -36,9 +38,21 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
>   	struct scsi_cmd pccb;
>   	u32 len = nframes * RPMB_FRAME_SIZE;
>   	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
> +	void *dma_buf = buf;
> +	void *bounce = NULL;
>   	int retries;
>   	int ret = 0;
>   
> +	if (!IS_ALIGNED((uintptr_t)buf, ARCH_DMA_MINALIGN)) {
> +		bounce = memalign(ARCH_DMA_MINALIGN,
> +				  ALIGN(len, ARCH_DMA_MINALIGN));
> +		if (!bounce)
> +			return -ENOMEM;
> +		dma_buf = bounce;
> +		if (dir == DMA_TO_DEVICE)
> +			memcpy(bounce, buf, len);
> +	}
> +
>   	memset(&pccb, 0, sizeof(pccb));
>   	pccb.lun = UFS_UPIU_RPMB_WLUN;
>   	pccb.cmd[0] = opcode;
> @@ -54,7 +68,7 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
>   	pccb.cmd[10] = 0;
>   	pccb.cmd[11] = 0;
>   	pccb.cmdlen = 12;
> -	pccb.pdata = buf;
> +	pccb.pdata = dma_buf;
>   	pccb.datalen = len;
>   	pccb.dma_dir = dir;
>   
> @@ -64,6 +78,12 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
>   			break;
>   	}
>   
> +	if (bounce) {
> +		if (!ret && dir == DMA_FROM_DEVICE)
> +			memcpy(buf, bounce, len);
> +		free(bounce);
> +	}
> +
>   	return ret;
>   }
>   

