Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2ADC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D511F4082A;
	Tue, 21 Jul 2026 07:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLylfPcqgkPf; Tue, 21 Jul 2026 07:34:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED08940843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784619295;
	bh=RIJo45NX4a99YXtD5kS/+7dbCfFzsZWjNAFI/silctY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LicJTOzPjGZTJfUDTHh8BoKEtQazFnTy/c2hvH85JNMgOnGHRIOvU3LMUd6zFOrae
	 3byi8mfIMK0HpaPYxMPKbKj5sM/ExD4EtxlZDpmSHBDvOpeFY5Xnq/WUDuHqpXSJp+
	 ZiC666Z+8p2pe9iD0jjuBHSZA4BQesdAGS/Sw9E8rsDgejuAYLf+prkVHge7czRGDT
	 aEnM7i9AfcogC8/qtyIN0X7R2OkxKBrlbwQ+3CS7+rOPyyedTnyr2Z/Wvoo+bgAKLY
	 KrfZ1lwew+2Z63mTK2FLpkK/F1wzsx6/N5q0twMndZzwcfPC4aYIv77R/ah/qRJDXm
	 mAX/Lt3NmV4IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED08940843;
	Tue, 21 Jul 2026 07:34:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A990224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CC2680E50
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYGh0VmYn9nC for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:34:52 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BCBD380E43
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCBD380E43
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCBD380E43
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:34:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC41584659; Tue, 21 Jul 2026 09:34:49 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596DA803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:34:47 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4955484387cso15460095e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784619287; x=1785224087;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RIJo45NX4a99YXtD5kS/+7dbCfFzsZWjNAFI/silctY=;
 b=rhwHQjODv/vApl1taYGyNd2IZo/6kBOPwz342AeyC8bMaMBSuhlfGZcCa44DeEwbmv
 OKsdg/Uw3X+CkQ23LncvRmstA4/s0MjYVLM1Y6XIma2VxNTBGpRQalXqBM+/iI3XlAjo
 PblMY2ZKQ6bQBcl/3MXZWchu8lfOJVwgliqUBFW/ZP5FCE1yGNEx6l8RRn+aH5ETH7bb
 VCuj2BMdzsbAVUv4CP4Dhmlx41vqdRQbCE2wHU1dcSzvx/gA0mpqPSROY4N2lzUWUuv5
 xl2kZDXUnmkrZEwsGqFQUpNP+mfMyYVxUGgNpWFPsNhxdocWZKYWG0/QYtjOvAUl23vN
 GsAQ==
X-Gm-Message-State: AOJu0YxIX4XP3Kok3Awf0+vOm6Fqmp2uHOplYepiLxnXU02uC5qi0sea
 Xj5gFvlNCM44pDvSZEjtu9+jU/ScM5B/o3Z6m64Vf/7GiIlprs4a0eHrkonJQunLlS4=
X-Gm-Gg: AfdE7cmC/BouSSOUpMO2J8WGPtd9lnLxKaFoKdBF8GlFvnpCZaVhxfTZCnBzZKXttI4
 +Otkscsj3g2aFCU7eCwsmUX+X1danq9WxZg6fuFlfWkPmkGtaQgn5tU5MYPH19g+mrCZLWejvH4
 iaNKr+KxYvYIob+Ox6xElPLaRgZ5usTrvR76MeJRatPVdvs6kQ4OgYnwl5qX9Zx2xp84O4MPp2H
 lo2Kd2JDTDd11vJCb6gmA/SB9LoedVfIsvYuqRKluNeq6p2RA5EHLjBNKcnAtHvVt54CeXAj/JT
 M5FaT7J4ckn1sWR4MGnf/3n8ytpwWu6oibMpnuchAKSSro3E2314NEhcx4ws46DFWiiq56r96F9
 WE1uCrpvf9A2toBP4BEPXja+xFexgKt6Okd39N3xZahybzHIUn3fT2yEi0+V9wwWLY+CoqRbDK6
 LOMM/J7b+XoKCGGgznZzA50G3+Ai4MsqqigSDLyQoxALS6iB9GXfS+/FKQ2w==
X-Received: by 2002:a05:600c:524a:b0:495:5a0e:6d8c with SMTP id
 5b1f17b1804b1-4955a0e6fa1mr109794355e9.27.1784619286561; 
 Tue, 21 Jul 2026 00:34:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1?
 ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565473f76sm47927875e9.6.2026.07.21.00.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:34:46 -0700 (PDT)
Message-ID: <95756976-4fd7-4f6d-9ea2-865dc2d4608a@linaro.org>
Date: Tue, 21 Jul 2026 09:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] optee: implement the RPMB subsystem interface for
 UFS
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
 <20260720085202.537019-8-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260720085202.537019-8-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784619287; x=1785224087; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RIJo45NX4a99YXtD5kS/+7dbCfFzsZWjNAFI/silctY=;
 b=C85RdUC2bzN4QTAnEv2DxY+HeX43uqeHgNLYz6YL0uZpUJ1Mfr5i3el9HyXQX6GecP
 VdZ4wSvfECb1WJRb0F+q3mJdgYSCDcCnOcBkVutnk7g+Ze6K/+uOxLwT9taUI4FV+8gH
 nNGFuzOHmcYCK2IaCpuPV4EoMEJKwiILBS2SZoKVczBcrfVfGbv0C2MnMbLBUFLZIyIE
 aSppB9gqjG24HVjjrYIeld8t7c46AL1P45AdBZqXwBjjiwQ3naYqoVyqpTcdye8LeZGG
 Wl+8Yq6aXD9XdVKLqNv0cTQ/wDBeaP4XQIKs9Kw4Fzt/49//EnELos6keskFCJ/0pErD
 4b+g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=C85RdUC2
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="C85RdUC2"; 
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

It's kind of sad eMMC RPMB support is not implemented in the new interface,
how hard would it be to add the support ?

> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/tee/optee/Makefile               |   1 +
>   drivers/tee/optee/optee_msg_supplicant.h |   8 ++
>   drivers/tee/optee/optee_private.h        |  41 ++++++++
>   drivers/tee/optee/rpmb.c                 | 126 +++++++++++++++++++++++
>   drivers/tee/optee/supplicant.c           |   9 ++
>   5 files changed, 185 insertions(+)
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
> index 00000000000..3b3bd0ac12e
> --- /dev/null
> +++ b/drivers/tee/optee/rpmb.c
> @@ -0,0 +1,126 @@
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
> +	scsi_dev = ufs_rpmb_get_scsi_dev(UFS_RPMB_CONTROLLER);
> +	if (!scsi_dev) {
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
> +	scsi_dev = ufs_rpmb_get_scsi_dev(UFS_RPMB_CONTROLLER);
> +	if (!scsi_dev) {
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

