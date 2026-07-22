Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC073C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90B0340510;
	Wed, 22 Jul 2026 08:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qi_4UOWLfqUf; Wed, 22 Jul 2026 08:31:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91A9A40512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784709074;
	bh=4laT1Y6RFfHGE33evMWsLSluu4rjxeHU0QiT8RFSnRw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ljn8eMReNmUDQ/SSq8wZV0e7Recy3O3sI/NKJSXLw6AtuxCgDXDQz7xMr4gI5maOX
	 ZwXgRGA9Y2lCnY1UbKzgsk2AMx+WVAOleZuO4dtMGgcf+8A9mgz0D147ZkjFJp2Amo
	 g0stxNqDnJiusKTM6UjXBwqW9oIK7B7IyLmASZT44+O3u7jU87FyysPs0xNOjcxp+I
	 UXDYLHBoB3uNlVbbrsFwX34xyAp6bLyL4R80oknaw2rcYCcDUq9ypXw5G1yGQ/n3+L
	 B/n8goVJJgBVsGXCoMRlAqtwQCAvjrWtm7TsqyI6w1gJilt/5zlVITAdAUjqoChDWV
	 vxWL4IEumAFaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91A9A40512;
	Wed, 22 Jul 2026 08:31:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43155DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34609607B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umQoA6v0k6ut for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 08:31:12 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C9C36607AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9C36607AC
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9C36607AC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:31:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D5EA8493F; Wed, 22 Jul 2026 10:31:10 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E94803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:31:06 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4956242332dso24238595e9.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784709066; x=1785313866;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4laT1Y6RFfHGE33evMWsLSluu4rjxeHU0QiT8RFSnRw=;
 b=E0u9kEZEDfOCgzlFq9xZAghAxvySqIYbN4+WOPaXUEKWH9lqh4zyTfggDkEGsAGlDt
 JekXrIwHn0uGuAJMpNZA5UlxBWeFf3eE78H81ELS4DFzOzj/UYMo8hR+2/S9Q2M7idf2
 oks8/FWH1eRYBpLBI+ANPiNG50tQR5D99Z/6EoKbZQazVoVi/C4wWjC8SJvJ6i8usYy7
 odZXUqqo+iYIlJzySqKfaVB25NZ4+9Qzn1dOu/iD3rE8rI6lm0J+HaEvrj6enVF04HRc
 f/RR5FB9BGTG1RZCA5oSC3UgspwFUe9VaxxDpvQxmeT6u0E1bQMIqNGAHLWzgLWlfIad
 jXBA==
X-Gm-Message-State: AOJu0YxS9c1WObHJrLXgbjNZu2CL8YKjVjl4vj12YcxpTXFZyL0wVRyT
 /ZnXDvs1qzqys5+sAS1aweXWhNtuouNxQ9CijyPNHVZPLSQXIXYsAIUbokjcBiUqDxU=
X-Gm-Gg: AR+sD10Jj0W3t/uGMKU5FQJLjJO3c6BK8koEFU2rhRSLlgQ9ssTEOh96vZDcrBZtI8o
 ButtqAPTNPhmyGNq2yL6N7jh+lK5a5qFPbpoWjUd9bcOqkgI4cwL+wI+gOcZ+oj3RxzD6StyN5H
 9cl5Qa2fOCI9hDkHqP9BNdTWtuIZ1MNzx+C7/BkKqh/AuKNaQWIRVmj3VnFIYcKcHI24+yBlp/y
 1ImiSVpqyu1rID4isfsmBcFS8T4/NvpcT4yrRKWK3Gp+rRDKezEuqDuerzzALrMUOnJwL2+vAkW
 MqHyRiCLO9ewRgdf47b9hiz+GjXeFzt4n4tl8BDnRel4xvJLXIFIMMr8/2nW9Lxj87fqFAYWuJy
 maVmpMA+dN2WCYo/zGt/O7xZ/bl0FjsHWD5cNdTKE6L9sBWuY5EkCPM7m4Tri51Mj6wMUpkVtC9
 iP8H5JxrGKVhnSC351sHHmMCSHNRUU7XGi4XelBCorJlZCyUVrBTdmHE8Py2xeJWR+Cw==
X-Received: by 2002:a05:600c:4703:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-4954e893f8cmr239345785e9.15.1784709065569; 
 Wed, 22 Jul 2026 01:31:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:51c:217c:79fe:1b0c?
 ([2a01:e0a:106d:1080:51c:217c:79fe:1b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495686a8600sm104984135e9.6.2026.07.22.01.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 01:31:05 -0700 (PDT)
Message-ID: <791913b4-d006-44be-8c94-871617418dbc@linaro.org>
Date: Wed, 22 Jul 2026 10:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] optee: implement the RPMB subsystem interface for
 UFS
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
 <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784709066; x=1785313866; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4laT1Y6RFfHGE33evMWsLSluu4rjxeHU0QiT8RFSnRw=;
 b=qURw49fuGozkijyhjBohlOeJ8CX9RLhwr2n+YgF6Wl+kS8CXKqDcjnL96piP1v6rA1
 iPlngKjdYtxC/em2P16V7d84GZr/xbZoZGMs5UO/8uzBPjarDxDW4FeIiOHoXvobJ1Vj
 LYmgJ6TbToXV/4JuuHsTXngm+F3NmfEZrBRu7ZPWqtSP6vrlf0Af7xzFNhKQZdzK3yZI
 wcXVf2j6Cht1XAeqK24M76PY0U+ogalenNfWz6uDSz0tHQMXo2D1eDR9ojHb6U/TGLNR
 SBUSjr4ixq4OZ750Dh/3PNgn03kzI5J7+jvvG6WADCQ3oZqz0mLkjLERpFl5MydNFbGb
 J7OA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qURw49fu
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="qURw49fu"; 
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

Hi,

On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
> and derives the key from an eMMC-shaped device ID, so it can never
> reproduce the key Linux derives for a UFS device; secure storage on
> UFS-only platforms instead needs the transport-agnostic RPMB subsystem
> interface, through which the normal world describes the real RPMB device
> to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
> and can use RPMB secure storage on UFS, leaving the legacy eMMC path
> untouched.
> 
> This subsystem backend currently supports UFS drives only; eMMC still uses
> the legacy interface. As the legacy interface is dropped in favour of the
> subsystem one, an eMMC backend should be added here so both transports are
> served through a single RPMB path.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/tee/optee/Makefile               |   1 +
>   drivers/tee/optee/optee_msg_supplicant.h |   8 ++
>   drivers/tee/optee/optee_private.h        |  41 ++++++++
>   drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++

Why not rpmb_ufs ?

It's fine to have 2 backend implementations, the emmc is implementing the
legacy optee API, just add a comment in the eMMC file about that.

Neil

>   drivers/tee/optee/supplicant.c           |   9 ++
>   5 files changed, 183 insertions(+)
>   create mode 100644 drivers/tee/optee/rpmb.c
> 
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index 8321cf53a19..7af19834c00 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
>   obj-y += supplicant.o
>   obj-$(CONFIG_DM_I2C) += i2c.o
>   obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> +obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
> diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
> index 963cfd47824..b720d5d7b3f 100644
> --- a/drivers/tee/optee/optee_msg_supplicant.h
> +++ b/drivers/tee/optee/optee_msg_supplicant.h
> @@ -152,6 +152,14 @@
>    */
>   #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
>   
> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
> +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
> +
> +#define OPTEE_RPC_SHM_TYPE_APPL		0
> +
> +#define OPTEE_RPC_RPMB_UFS		1
> +
>   /*
>    * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
>    */
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 1f07a27ee4b..2888257aefe 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -9,6 +9,17 @@
>   #include <tee.h>
>   #include <log.h>
>   
> +#ifdef CONFIG_SUPPORT_UFS_RPMB
> +/**
> + * struct optee_private - OP-TEE driver private data
> + * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
> + * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
> + */
> +struct optee_private {
> +	unsigned int rpmb_next_region;
> +	unsigned int rpmb_cur_region;
> +};
> +#else
>   /**
>    * struct optee_private - OP-TEE driver private data
>    * @rpmb_mmc:		mmc device for the RPMB partition
> @@ -22,6 +33,7 @@ struct optee_private {
>   	int rpmb_dev_id;
>   	int rpmb_original_part;
>   };
> +#endif
>   
>   struct optee_msg_arg;
>   
> @@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_SUPPORT_UFS_RPMB
> +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> +				      struct optee_msg_arg *arg);
> +
> +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> +				     struct optee_msg_arg *arg);
> +
> +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> +				 struct optee_msg_arg *arg);
> +#else
> +static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> +						    struct optee_msg_arg *arg)
> +{
> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> +}
> +
> +static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> +						   struct optee_msg_arg *arg)
> +{
> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> +}
> +
> +static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> +					       struct optee_msg_arg *arg)
> +{
> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> +}
> +#endif
> +
>   #ifdef CONFIG_DM_I2C
>   /**
>    * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> new file mode 100644
> index 00000000000..9c3e0f031ad
> --- /dev/null
> +++ b/drivers/tee/optee/rpmb.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <dm.h>
> +#include <tee.h>
> +#include <ufs.h>
> +
> +#include "optee_msg.h"
> +#include "optee_msg_supplicant.h"
> +#include "optee_private.h"
> +
> +#define UFS_RPMB_CONTROLLER	0

Can this be a config option instead which defaults to 0 ?

> +
> +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> +				      struct optee_msg_arg *arg)
> +{
> +	struct optee_private *priv = dev_get_priv(dev);
> +
> +	if (arg->num_params != 1 ||
> +	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
> +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	priv->rpmb_next_region = 0;
> +	priv->rpmb_cur_region = 0;
> +
> +	arg->params[0].u.value.a = OPTEE_RPC_SHM_TYPE_APPL;
> +	arg->ret = TEE_SUCCESS;
> +}
> +
> +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> +				     struct optee_msg_arg *arg)
> +{
> +	struct optee_private *priv = dev_get_priv(dev);
> +	struct udevice *scsi_dev;
> +	struct tee_shm *cid_shm;
> +	u8 size_mult = 0;
> +	u8 rel_wr = 0;
> +	void *cid_buf;
> +	ulong cid_size;
> +	int ret;
> +
> +	if (arg->num_params != 2 ||
> +	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
> +	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
> +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	cid_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
> +	cid_buf = (u8 *)cid_shm->addr + arg->params[1].u.rmem.offs;
> +	cid_size = arg->params[1].u.rmem.size;
> +	if (cid_size < UFS_RPMB_CID_SIZE) {
> +		arg->ret = TEE_ERROR_SHORT_BUFFER;
> +		return;
> +	}
> +
> +	if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
> +		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> +		return;
> +	}
> +
> +	while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
> +		unsigned int region = priv->rpmb_next_region++;
> +
> +		ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
> +					       &rel_wr, cid_buf);
> +		if (ret < 0) {
> +			arg->ret = TEE_ERROR_GENERIC;
> +			return;
> +		}
> +		if (!ret)
> +			continue;
> +
> +		priv->rpmb_cur_region = region;
> +		arg->params[0].u.value.a = OPTEE_RPC_RPMB_UFS;
> +		arg->params[0].u.value.b = size_mult;
> +		arg->params[0].u.value.c = rel_wr;
> +		arg->params[1].u.rmem.size = UFS_RPMB_CID_SIZE;
> +		arg->ret = TEE_SUCCESS;
> +		return;
> +	}
> +
> +	arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> +}
> +
> +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> +				 struct optee_msg_arg *arg)
> +{
> +	struct optee_private *priv = dev_get_priv(dev);
> +	struct tee_shm *req_shm;
> +	struct tee_shm *rsp_shm;
> +	struct udevice *scsi_dev;
> +	void *req_buf;
> +	void *rsp_buf;
> +	ulong req_size;
> +	ulong rsp_size;
> +
> +	if (arg->num_params != 2 ||
> +	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_RMEM_INPUT ||
> +	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
> +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
> +		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> +		return;
> +	}
> +
> +	req_shm = (struct tee_shm *)(ulong)arg->params[0].u.rmem.shm_ref;
> +	req_buf = (u8 *)req_shm->addr + arg->params[0].u.rmem.offs;
> +	req_size = arg->params[0].u.rmem.size;
> +
> +	rsp_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
> +	rsp_buf = (u8 *)rsp_shm->addr + arg->params[1].u.rmem.offs;
> +	rsp_size = arg->params[1].u.rmem.size;
> +
> +	if (ufs_rpmb_route_frames(scsi_dev, priv->rpmb_cur_region, req_buf,
> +				  req_size, rsp_buf, rsp_size))
> +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> +	else
> +		arg->ret = TEE_SUCCESS;
> +}
> diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
> index 8a426f53ba8..50b780037fb 100644
> --- a/drivers/tee/optee/supplicant.c
> +++ b/drivers/tee/optee/supplicant.c
> @@ -89,6 +89,15 @@ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
>   	case OPTEE_MSG_RPC_CMD_RPMB:
>   		optee_suppl_cmd_rpmb(dev, arg);
>   		break;
> +	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET:
> +		optee_suppl_cmd_rpmb_probe_reset(dev, arg);
> +		break;
> +	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT:
> +		optee_suppl_cmd_rpmb_probe_next(dev, arg);
> +		break;
> +	case OPTEE_MSG_RPC_CMD_RPMB_FRAMES:
> +		optee_suppl_cmd_rpmb_frames(dev, arg);
> +		break;
>   	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
>   		optee_suppl_cmd_i2c_transfer(arg);
>   		break;

Thanks,
Neil
