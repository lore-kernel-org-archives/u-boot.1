Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED41C44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F11E5407D3;
	Wed, 22 Jul 2026 08:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4o-USnswBXp; Wed, 22 Jul 2026 08:27:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F836407B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708851;
	bh=MBALhtW5wT4xidAFo+a60cCJR1RXDRTfmCjlvrQccHc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V+TjH91YXxsp9xRL5vQS2rQCgYWadhfF8kwJnN1qHloMxBR6I46Tn0AYByzi9FiQ2
	 qXQrYaI4CH4JakLXNtpnL6rxT53ZMXphqoKOC7HWFQrdUXYLX2IEqTVlGoKjWl71/T
	 zug02Tw/bujJpmNVcIT3FPLtIGEDAR+mZlR1gqDBjAyZF3s9iKZW4KDm6nPomAva39
	 IjAup052FFtQQrFvYYyjqs6hGwB48YaHbqeAvmlfD311Uq+8Y03b1lgc2Scil+7UGB
	 pTD2zDHdkFc6aQNWWuSFZXcexRbGqyZDadKeg1ktF2s9GM5zXEYc/1w+HC518BDeba
	 Q3I6BfBXBDXcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F836407B5;
	Wed, 22 Jul 2026 08:27:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 682A09E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:27:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59C4A40257
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIp_S3tOcXo5 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 08:27:29 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 02BCD4020F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02BCD4020F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02BCD4020F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:27:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E35803F6; Wed, 22 Jul 2026 10:27:27 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC62848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:27:24 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so8242057f8f.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784708844; x=1785313644;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MBALhtW5wT4xidAFo+a60cCJR1RXDRTfmCjlvrQccHc=;
 b=HMadMe8f+1hEU8a3txNdpkNktHYYSMvSljjryJBYFVU9+En3gfGduu8WjXHBWJff7k
 tpWdO2OvrFXeo3MTF/5qsLgsjThLDZV5P3oJGLOXI5jzmW8VjoNbQoUyfwRuR+KOdT+4
 IoVoR+UoJFhuCJRSqhJGPekJV18sG9FB0t7Qdiki/4A07G6VYkAgFZOcI6Ohp+8aQkmt
 E100JlnDwV1C5hi5ft7NhZJ1wBNdl2+9XThWcHeG5altSi5U2U8f+IT6wYHAM68L6vJX
 E9pNMtRoH3pg+i52JyU5XdzOHOhYnsNBU1uZ0yv61zL89c0Q2bUUNrC3BigjQSfWViBI
 MByA==
X-Gm-Message-State: AOJu0YyuxNG0S/Hb8AUDTdduqYcqp8KRzAcxGW/Ekg5rEc/7nv9e92JZ
 Tq0iYLbLVorQ961E7rBc9zyzWkBi1j8LDYOvaxb09jBRSUl2FHbyhRq4lw8MJIFwzo8=
X-Gm-Gg: AR+sD13aVtWtHZMuM5Q0BlxPobtgVWqoCFncOx/l99g4OcEQcHTm7ZhzMy4gY4Ptb1l
 hp5BVHv1XfzsOwFGVcuVE8ZFpnF3Lo4wxTkEQBM94C7Ues7asVOgIVf9wh0aL4+FHgYXG6dEd5W
 GNolsdoV7Q2kqyB0lKW+nNwTAi0h5qAUFSgpw2AvA8ja0KXjhN0B0OYiNuglkwioEiv97rGWJj5
 /kXhkTS1+6sTHz1tUMXwUERNyJ/OCE3rR+iELybqer6pc3BXEqAEXC3bdRnktIXvAW9oQkPwP9A
 1oyxZXSmn2xv82fBrZzp4ek5zMOAVmB8X0ovGnoIGPEosI56XNEq2Vx9KNwqW53A/VzLrod9kCp
 34t6vJEJg5kYEUX7MoqERAn6wEti7LqOBGe/toJRdwdS1Xbv5BwOWnCIqx8HAfJIQdO5G30eDhm
 4qxzq1CW1m/qe9pCMmSPicSKIopSH1xvREaCMJXCNn5v2yFbZPY01Y+B4=
X-Received: by 2002:a05:6000:41cb:b0:478:19e7:22a2 with SMTP id
 ffacd0b85a97d-47f622fef89mr24524475f8f.25.1784708844158; 
 Wed, 22 Jul 2026 01:27:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:51c:217c:79fe:1b0c?
 ([2a01:e0a:106d:1080:51c:217c:79fe:1b0c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6d277sm4181274f8f.32.2026.07.22.01.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 01:27:23 -0700 (PDT)
Message-ID: <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org>
Date: Wed, 22 Jul 2026 10:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] optee: rename rpmb.c to rpmb_legacy.c
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 shawn.lin@rock-chips.com, igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com
Cc: u-boot@lists.denx.de
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784708844; x=1785313644; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MBALhtW5wT4xidAFo+a60cCJR1RXDRTfmCjlvrQccHc=;
 b=MVHwA6vV1/Ap/uLLg4mbG/yTesBhMY3glpWLIC3wuSrmsL2qVmIw3js2irQ/tAUMFn
 BrO/Rk71lALW0Ll7qFXEk3ZJsiMt/ZeXgv+5yyCwgsUkU3356wHvwAsLM+3FWhFNpXVu
 lpbjiKyW9ALiL/Qo4EzwnEzBY7nOHI74ves6wLCmsZtiqLKk5lcDfW6XFqzG0ivWDLJR
 oR1kQD1ZqfaFaepAlnZJvL/o3dYQfFAeSu/dsJzVIYdJFuPcr4RXYx+H1rzDdhifNz9b
 B6VzC9w2qd1mndx2MFhpsNzWbk+HCnTDO90bFIVncu0mhuFE5XUSitURezz1WsHcKeZ0
 usJg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MVHwA6vV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="MVHwA6vV"; 
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

On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
> supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
> name is free for the RPMB subsystem interface added next; pure rename plus
> its Makefile object, no functional change.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/tee/optee/Makefile                  | 2 +-
>   drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)
> 
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index 36ac085ef42..8321cf53a19 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -3,4 +3,4 @@
>   obj-$(CONFIG_OPTEE) += core.o
>   obj-y += supplicant.o
>   obj-$(CONFIG_DM_I2C) += i2c.o
> -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
> +obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
> similarity index 100%
> rename from drivers/tee/optee/rpmb.c
> rename to drivers/tee/optee/rpmb_legacy.c

Why not rpmb_emmc ?

Neil
