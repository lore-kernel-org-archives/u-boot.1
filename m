Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97E606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XSWSbcjl;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OjYdU1Zp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91374605AC;
	Mon, 16 Nov 2026 09:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUMSmfuLE5NO; Mon, 16 Nov 2026 09:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5FB260657
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794822677;
	b=shbl0HosB1KpbxaIn/M7NtdwucBuTgljAQlbmY2vMqwg/lsskzogDD11N+xCh1kTfEOw
	 cL/paOKyCpJlsqP5wTFXgD9vfSS0Ln/CL4UHuVpOwDNztf4lUumnkAM2/WcNpgiFbL4lL
	 kQmuRDjUCoS0D4L++5R3iakrZb99mf+xnmVwvYCWOzE1mvgTXvV68oX45b1EQ+Pz5I/eg
	 dzrF1g4/r1QR4PM3pq1c7VQclpmZD9rMFLyJem2gJRO8wL4JRS2bOAsSy+W/rTJv2hV0S
	 lwxS05lLLuM8awPciTbx/XA1kLK7GsbSwlB8/AO4mtxNJYfnew7X3fhwOEcl5rhsXCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794822677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=NA4QIHY4BEo9fXXpw/Q0mEVwP4lXAd57iMoKpmGmtUA=;
	b=V33sXKq4CwFlzEf0DnbTxLqmlcYDYnRqAfAJ/5+YY/alzPfKkRfoAdtSywr4g/MDqDqb
	 0bI9mDXMd3nhS8uMhgnIq4sRWYx8yFM34XeYPqmH8hbKrF2nJlMlhtl+CQk5q/bM0nohR
	 +4RlxFWIalZp+sfHCkVkbaZhtO0TdoiiFGATWORX9mBw6GQVPpvjJNYw1v4atGLa1Mz7K
	 ec++SNAk+KThV02lHOaOzHysPOam5SxqIq/4ickDqKbNorck87BUdErSkFO878vDP/Hhk
	 R/a8oTyyNC4yO1IuxIfr6cIp47ydkl6pwV0/lyHLXFyme7YxRGHYqEyXr4g8vnFHRrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794822677;
	bh=NA4QIHY4BEo9fXXpw/Q0mEVwP4lXAd57iMoKpmGmtUA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XSWSbcjluzbnMRhnTKUSNkOz1otxFi/5VWKbqijtX/x0EqLMpVacEvS8SEZxd+x0l
	 Vy0O7/Ya4Q/vzWG5YOG9kb3p74U7XVeFOmWvtm3UbijUCWs8yrsx0rthgDio8DX0Ty
	 zH06ERdlWu9CyxJzGxXfozIsDHJZqs6rFFT710rSWm3LNPbnDKyi7LI4W6sbwtX1e8
	 ep2r/bbNPZO38mHPBuo8rwrT7o8K3Phn7Iv1inbjMhGfKfg4vODOWB+Uk+h7eVtz+s
	 9Zc2u9/pHQce4B4suVv2grBh7YHMhaJX6igGuJSdnFCNe1DiQzhOebppy5mNSFpY94
	 YrnmWAC8WkEPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5FB260657;
	Mon, 16 Nov 2026 09:51:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A4952FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47EEB4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id noqq-tF8YHCw for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 09:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 27BB840012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OjYdU1Zp
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27BB840012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:51:13 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so8780665e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794822671; x=1795427471;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NA4QIHY4BEo9fXXpw/Q0mEVwP4lXAd57iMoKpmGmtUA=;
 b=OjYdU1ZpsVMBAKoxJkNbUCKG9mpYT2F7iXGurH2EgNaL1G8vWCrXoS8cpvvhKaHT/J
 dc1e6Ay9zPgLnh8/hTOwkoVbMQHdYcr0GLR/7km2JZwm5IipcMEHNIxwX7nsprJrybg4
 L2gpICjvGKOonVaCZq5C/pWitI8GxIP3KA6LMnjOrus6BDeZhrS3g6lmBjP6yyOuumR9
 uAjX3kOzBY9WEQUWm+E4uSl22KW9iHSjuBz5eoQYP90wUj3GeKkzLO/9heFrslOwsKCp
 5DVQncbCL30z37dyZAGxVO/t+suJZEJnpGe+ntFSpXuUJzYcfTQnIm3DnBKtyg1WHvE6
 u4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794822671; x=1795427471;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NA4QIHY4BEo9fXXpw/Q0mEVwP4lXAd57iMoKpmGmtUA=;
 b=fZHA5SqInHguqQKXAD5BjkZHiNhDOpdQG5al8LZpSIK2t8lmRzdImNVriPTKiBoX5L
 MT1EgIBMtxNxVwfAPMwgnJR6VUFGmmiWHFSFD59rB/5A5HB0UFBksM1mOz7WJO2ce85E
 tD5Kq0S6IJyuTLsGQcpwmg2zqvbIyqMWK+mhZwyK8jr/35mmEFtXw+lxIH3F1K90GAaQ
 BXBN4Gth/ELXjmMASOSzNA9PXF302Hl8U9lNaR85A/y8XPyH9mEoKt42HcRVL2AMmUme
 am1ysV1FMCQdJC/FB7pXh9TUkpEEkim1zL8YPfclb2gJZ1HKunUhC49+BgmKTE0Jqs9y
 O3dw==
X-Forwarded-Encrypted: i=1;
 AL+hErFSLbGKHucX3HSdt6AJbFbaREFGOYfZcZATnjTiXWVh8MSfy1OMv2qONsrIMBfWQj+9VZDoWFs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/2nMTQ6cANf6Q+NbCJjSZ0AIpo/N0MKne9S/NjnXnNOgt8st2L
 +kPNGRz6MaCEXneVW0BMAhe4V5Iz20kc/WjURHQRmhinyBfGW5WNnbrzF9rbQrpW87w=
X-Gm-Gg: AYBFou2Pje9xFypHo8e7c9ZljRqMawulOcaCBAP6uhg9aCoQLFR9s0c297mdG+KsIUW
 Z2g89G5zWTChCvPizJNGLUQ3/KgFZAdR3lIjshWolkdXgA70GsbqJnnKQJQJyM1zQ8FYAD/1Bm1
 sfBlpiYpABhMc5iVDZLxWnlQkyz+0uxWyfz8mUpvA+fLLIo2iKLfjRFT7V9JTNSZcwoywNwGUgx
 Kr9ll0+YKUd9lfZG1PLwXjoSVySH4EB8s1LBOtpv0LmbMMfAhQ3r9s659HgxvO/pmE62joSg7S4
 bfhSYEsEoiOObUz3tEnlYz6yR3WtgwIXRDt7G7oWJ32U/mANbXcOQZG1TxWsqK/cIN4Fqrho7Ir
 stPOmtVpYSKFISc0xg/pqeJn5kq5mm7/JfSrXzvr9UhGCtJpMOV0ipVKd2ckFC+rSBW8zHSC5tE
 PB9cEmCqjWX508J6kkDfPkdRhwBmuPpOLo8cz7ewYg0g9rwi0b0l1p93kdmmRkwAvvofbCOAvL/
 iXYSxjcBGgPiY9L2aVgkCF+/o6eoih8Kfnm/ti9JqbRIXO7plnmGP7kYDGtQhO99+lTxLQ4X2ej
 TyCyRYCuhEY1ACNXcA6MvQFjjq4YXawNlyTT5QxD68c1dR2JJeYe01Z8qo5V7/V9wEDD+9U4tj+
 YImLDx7LE2w==
X-Received: by 2002:a05:600c:3e10:b0:4bb:6651:9eda with SMTP id
 5b1f17b1804b1-4bb6651a042mr112033685e9.14.1794822671190; 
 Mon, 16 Nov 2026 01:51:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:575d:8fcf:e30d:5aed?
 ([2a01:e0a:106d:1080:575d:8fcf:e30d:5aed])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e1esm251322515e9.3.2026.11.16.01.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 01:51:10 -0800 (PST)
Message-ID: <d5639f3b-74ba-4e52-b77f-3844ef5e37af@linaro.org>
Date: Mon, 16 Nov 2026 10:51:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] nvme: Wait for commands in seconds, not tenths of
 seconds
To: Alexey Charkov <alchark@flipper.net>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org, Zhikang Zhang <zhikang.zhang@nxp.com>,
 Wenbin Song <wenbin.song@nxp.com>
Cc: Tom Rini <trini@konsulko.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>, Torsten Duwe <duwe@suse.de>
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
 <20261113-nvme-fixes-v1-1-a181c72f40e7@flipper.net>
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
In-Reply-To: <20261113-nvme-fixes-v1-1-a181c72f40e7@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 13:00, Alexey Charkov wrote:
> ADMIN_TIMEOUT and IO_TIMEOUT match the admin and I/O command timeouts of
> the Linux driver, 60 and 30 seconds, but nvme_submit_sync_cmd() scales
> them by 100000us, so commands time out after 6 and 3 seconds instead.
> 
> That is too short for some drives. A Kingston NV-series disk on a Rock 5B
> takes 3.1-3.2s to complete its first read after power-on, so the GPT probe
> of LBA 0 times out, and the disk is never seen as GPT and offers nothing
> to boot from.
> 
> Scale the timeouts by USEC_PER_SEC, so they are the seconds their values
> intend.
> 
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/nvme/nvme.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index c815a9671374..2063c73f9d85 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -15,6 +15,7 @@
>   #include <time.h>
>   #include <dm/device-internal.h>
>   #include <linux/compat.h>
> +#include <linux/time.h>
>   #include "nvme.h"
>   
>   #define NVME_Q_DEPTH		2
> @@ -23,8 +24,8 @@
>   #define NVME_CQ_SIZE(depth)	(depth * sizeof(struct nvme_completion))
>   #define NVME_CQ_ALLOCATION	ALIGN(NVME_CQ_SIZE(NVME_Q_DEPTH), \
>   				      ARCH_DMA_MINALIGN)
> -#define ADMIN_TIMEOUT		60
> -#define IO_TIMEOUT		30
> +#define ADMIN_TIMEOUT		60	/* seconds */
> +#define IO_TIMEOUT		30	/* seconds */
>   #define MAX_PRP_POOL		512
>   
>   /**
> @@ -191,7 +192,7 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
>   	u16 phase = nvmeq->cq_phase;
>   	u16 status;
>   	ulong start_time;
> -	ulong timeout_us = timeout * 100000;
> +	ulong timeout_us = timeout * USEC_PER_SEC;
>   
>   	cmd->common.command_id = nvme_get_cmd_id();
>   	nvme_submit_cmd(nvmeq, cmd);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
