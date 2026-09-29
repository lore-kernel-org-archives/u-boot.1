Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D36CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6007C80E15;
	Tue, 29 Sep 2026 15:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fBiMJOYZyGp; Tue, 29 Sep 2026 15:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4A4D680DF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790694839;
	b=DfanMmUX5MjAqYw5UAbocL1falsPQA1wC3uUWZy+6AYd0xXxiGem9qqGQTtUAQANSa7U
	 akkjGkdyy1AfUGFNbebqhaCdBM+n9yVlwfjtEJ1TlkC0/4JF1obPuQi5seSl1EQ05jDGV
	 mOolPbvSFY0G/nahN/rvCBjwMHAQLmpMs96Sefc3AaGw8j/w+BVTUOiO4vRCizOb059il
	 zofFTpXp4nktZYb3jWpz/BymdJc+eufPzIWnBgQzRCyOCTtfkrlfjnTD6uRUPnCCSJXFb
	 ve3thLL+vVpJg8CtLjFxjYyzfky6PikEK28alN6REtq/HsHodcNQHb4WosRVIMhmI/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790694839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B3Pb4+cw1XX13gvKMBdlX6HW9o970CPxg2gO2aIk9gg=;
	b=pLIYn0tM6k/CQJ9jql8cBVVGNqptqvJisqwIoCd+vvB5ynL+WZ9knpiNTzgXgTzaSo+8
	 u3kFDuJXuPt9FC6NjYqWhIyDjwsbU75i+M0Edr811Hn/A+2vuYA8mtOYfPvTiKV/S9R7X
	 OdXVdPAqFuESsMIsvM9v+unaz1tJmJDDfYEaO2t0HKPWcY3yQH52zzV0QMbsKP/ueOsQw
	 RCvdi6pIPIscChojFXddmV55BN9p+KuZKsvRaIW0PG6ra209irePnVu8VUQIXvwWytR/E
	 X/ZsfuVCwTJfh7gZyfNxAs1GHIzRjZIT9EZ4Xf57SiLqSj6CG9V/VN2kNrSB06JdOkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790694839;
	bh=B3Pb4+cw1XX13gvKMBdlX6HW9o970CPxg2gO2aIk9gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NQgvUttmtvpAV2dRXz9EtNtj6OHQhzsZvGIPn7E57WC3qpPPfz00T7KMzzy7CUSUK
	 fNTCILB/kc8sILq8J7wBsW+LqTs8LXittp1x/9kyPus1mxS/MYn9wGh+PdEJMxJ+Je
	 EuvisrRqeVZtzzErJtYDc+igisdAZoNNCMEzkFLsp12frnmqeIH8wy7jdqdywvjbNp
	 782YOOVpihpVdGfi0ZkgtI8LUmNhl3KKtIVbKbO7P2YnntcCvGK9bO7f2Ag4YFR1+R
	 cnlwb8ahnCsByN6s1h7BDQcQ6wOWlybddsQnkO9tIJrT5+u5hrnieLRuGP3Tfs/8AB
	 HsGrYwZPoN+lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A4D680DF4;
	Tue, 29 Sep 2026 15:13:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE31932A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D47A94032B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ViznYb_M4DLg for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6671140304
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790694837;
 b=g4g3UygIk4TGmrnpgdGY8HyB1Ie9msFbFPgXqalH33SFiw95Gp/umZ6SfbmV1l+JlulJ
 8dDw+5q8pCkvruCr80qK7Bc6cQWUqvrN1B8pXULoXOSJEMMoYfqVR9vK13ZvRu4XJEWgW
 +OMfjXRLpFqCOISRLDsU1txjCVCVoA4GKGrIFK/QF4IiJldgjB/PNB66rINeu5xUOhrJU
 RJITLN/DYR0d0u5KgBsth3rosMQu7NtT1Xdu/WyOrdg8p+HUH27ObaRRhmkYX4r5EKlrP
 4AwLcKc3ySL51L484QesqX9PKlznk1G8crQm2jAsgAPlGkfuX16wdJ7ebWMU/fCEJ6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790694837;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=B3Pb4+cw1XX13gvKMBdlX6HW9o970CPxg2gO2aIk9gg=;
 b=DqB9ElFl8PXE5rsvCgGABQW0+M5KH9vNMxORBCqvsxBt7T7vkm2xZnDaUO7JxTiKEzf/
 JlI5yM0nASG1DEFDcua7jJaODTEJ/FO0pXIMSOZ3qXB+Gg57OvkI/KnLTakwO1Bh1Kg0n
 cnnuddBb8iKa35Vm/y9IlJsmV4t54oaA8oTi/wMi2yQPTXcDunDJAOsXiAekWvMDi6nJ6
 kZWuNM9XO1gaECOWfbfSjSwsX5PpleMtRBOZ9+XzaB+pBpqa+3Z4mNqTcG6y96639uPJV
 4T00N1WNq2isZhkQs6alXgTqxF9HCYRDVAefxKUK/Pvia6LufBttjF5Fvmc3Yw68THA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="J1ctPZH/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=J1ctPZH/
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6671140304
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:13:54 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81eab67b951so552021a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790694833; x=1791299633;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B3Pb4+cw1XX13gvKMBdlX6HW9o970CPxg2gO2aIk9gg=;
 b=J1ctPZH/+3p8dgm5D17qS0X4hAzjqutokBYmX2rHBAJ9cFSb24j7/ZGBzejgrU2oiq
 qCgoT6Buur3FcMbuCweAIS3hko6OLBT0tlF1ijsPMnfD+x4NvmJ9wQa8a4tHljsoRqVS
 RxxwxwheFRttxpQo4vAzUnrn4YYjj7M1kVno/Knvbi4zvMHV67hJQoygtPoJmw7nYyHB
 0ObEmGYWTpc1DaqVrM3lfq+6lwMqpD2ujp5iL80Vi4QyVPtJjS5wxbMr1jaM2/QFupyS
 Pb2c+otRuga3O46Znb8TSfP6O/DWVf1mBp/QIgPT4B80/Fc3jwYLSvZW/ReppGPd4OZR
 1gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694833; x=1791299633;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B3Pb4+cw1XX13gvKMBdlX6HW9o970CPxg2gO2aIk9gg=;
 b=xSSaKg9MVbucU6djJCA2cyGsU9S4GfBqW9Vh/XSPPDJaJw5DGkeuQP44BK4CyqpJfr
 TkPddy34pjZcXGsdt03jOMmVzQ28n/BJKYMO9aKoWh0gBxpc6nZ5VuleWckZbL7ZOqwV
 9qXpe/U1bXiE8vuVDEht8q6sY5CbFS2Z5INQk1wM4rDR1j0xfLydBumNGshOYP0bFiX8
 UjCkOJDieQ/dGJN1LVt0p2zX9vrtmSsX5YwWf7vWu0yOp+qw22yKD4cDrdWzxrhuF4h9
 99HDGjFpumsuy7DeFqRKUjeWeguJHnGDnr6CUDVy2rvQXIYpLNq63pJGbxc1qjACpezj
 iUJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByWWNYIFFtcLsUJf94Pm0mwMomx5vEo/6SvorCkbOPu4M+CqQoXznGQDqlDNe0N3TYTeRyVghs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nZWhs9UV1WNyKmKULkwlxgtGEdHC4nwxuS5HPS03qPEpyGXmKj
 iQdBxmGrdln/1YsYR1Bspx2K2Eexzy690Sok7zfNEaAEc4GuZQ/jiJ1G0KxHjWBGzpc=
X-Gm-Gg: AYBFou3O5AEixti7rhgN3GWpd2af/FgCCyu94z70PYvQBjN+O4RIY203DaBX7aJjDHU
 2vicVJ7EwF8cMI0X4biHHnRfp6ufu0ioS5OSZimcR+wnkDU9nn/Ck4x1OmMp1Yq4425L152+Evk
 WbiSHaAaSA7J/Uour0uSlerxhDwZ8Jxj8ZuJKHSaJ2OAWtqw7MIuibKnUiBmYIJAujZJcUe2piD
 i8q7oLiF6C8ifQO3r+2br4upUfdTyCuwFUmWrv9S9rpnKYgZD9S72CGXkHhogteQCMJLGqShGYg
 eP33Ero7GVEJv1XI3rSN1Z/j3M4/GVx06rWGn2TIeyQwKOwK3mi3HYZTDCvqfbhoicDzjxd6XsL
 C20M4tz2TiaEBCp+k+dv3Q0ZhxfPudoB5/ayPIifZ+7MUbkFVk8wvr+udy/AVMpA7qDgoDJYBik
 i8UCERL42cETswiNJ76fxWP9YGZWUkjbZWXwNMwdC5Kht4yMvINsr9CeRwH0jSDYx3OXrTNUlA8
 azz1LvxZC4HwxOf0NeE2imNXa9HqC9dscgMpeixwXMOiclHRrI5eoTXOJI=
X-Received: by 2002:a05:6820:1c8d:b0:6d8:6b04:cf39 with SMTP id
 006d021491bc7-6d86b04d181mr6529300eaf.51.1790694833352; 
 Tue, 29 Sep 2026 08:13:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9b16:2a1a:ef3f:3700?
 ([2600:8803:e7e4:500:9b16:2a1a:ef3f:3700])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dc4483b07asm116255eaf.3.2026.09.29.08.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 08:13:52 -0700 (PDT)
Message-ID: <a27b71eb-c80d-489d-b1c9-55d73dd0f658@baylibre.com>
Date: Tue, 29 Sep 2026 10:13:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers: spmi: add new driver for MediaTek's SPMI PMIF
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>,
 Joy Zou <joy.zou@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Guodong Xu <guodong@riscstar.com>
References: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
 <20260924-mt8196-spmi-v1-1-dd2263403691@collabora.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260924-mt8196-spmi-v1-1-dd2263403691@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/24/26 11:02 AM, Arnaud Ferraris wrote:
> This driver (ported from the Linux kernel) implements 1-byte wide read
> and write operations for the SPMI-PMIF bus found on MediaTek SoCs. It
> currently supports MT8195 and MT8196.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  drivers/spmi/Kconfig         |   7 +
>  drivers/spmi/Makefile        |   1 +
>  drivers/spmi/spmi-mtk-pmif.c | 462 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 470 insertions(+)
> 
> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> index f8972371150..cab82e83c24 100644
> --- a/drivers/spmi/Kconfig
> +++ b/drivers/spmi/Kconfig
> @@ -27,6 +27,13 @@ config SPL_SPMI_MSM
>  	  Support SPMI bus implementation found on Qualcomm Snapdragon SoCs
>  	  in SPL.
>  
> +config SPMI_MTK_PMIF
> +	bool "Support MediaTek SPMI-PMIF bus"
> +	depends on SPMI
> +	help
> +	  Support SPMI bus implementation found on MediaTek SoCs. This
> +	  driver currently support the MT8195 and MT8196 SoCs.
> +
>  config SPMI_SANDBOX
>  	bool "Support for Sandbox SPMI bus"
>  	depends on SPMI
> diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
> index 8cb93c820e0..016a8e6b734 100644
> --- a/drivers/spmi/Makefile
> +++ b/drivers/spmi/Makefile
> @@ -4,4 +4,5 @@
>  
>  obj-$(CONFIG_$(PHASE_)SPMI)  += spmi-uclass.o
>  obj-$(CONFIG_$(PHASE_)SPMI_MSM) += spmi-msm.o
> +obj-$(CONFIG_SPMI_MTK_PMIF) += spmi-mtk-pmif.o
>  obj-$(CONFIG_SPMI_SANDBOX) += spmi-sandbox.o
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> new file mode 100644
> index 00000000000..0bc8309b447
> --- /dev/null
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -0,0 +1,462 @@
> +// SPDX-License-Identifier: GPL-2.0

GPL-2.0 is deprecated. Prefer GPL-2.0-only or GPL-2.0-or-later.

> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + * Copyright (c) 2025-2026 Collabora Ltd
> + * Authors: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + *          Arnaud Ferraris <arnaud.ferraris@collabora.com>
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <malloc.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <asm/io.h>
> +#include <asm/processor.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <linux/time.h>
> +#include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/devres.h>
> +#include <inttypes.h>
> +#include <spmi/spmi.h>

Are we actually using all of these headers?


> +static int pmif_spmi_read(struct udevice *dev, int sid, int pid, int reg)
> +{
> +	struct pmif_bus *pbus = dev_get_priv(dev);
> +	struct pmif *arb = pbus->arb;
> +	struct ch_reg *inf_reg;
> +	int ret, data;
> +	u32 cmd;
> +
> +	/* Check for argument validation. */
> +	if (sid & ~0xf) {
> +		dev_err(dev, "exceed the max slv id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Wait for Software Interface FSM state to be IDLE. */
> +	inf_reg = &arb->chan;
> +	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
> +				       data, GET_SWINF(data) == SWINF_IDLE,
> +				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +	if (ret < 0) {
> +		/* set channel ready if the data has transferred */
> +		if (pmif_is_fsm_vldclr(arb, pbus))
> +			pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
> +		dev_err(dev, "failed to wait for SWINF_IDLE\n");
> +		return ret;
> +	}
> +
> +	/* Send the command. */
> +	cmd = (PMIF_CMD_EXT_REG_LONG << 30) | (sid << 24) | reg;
> +	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
> +
> +	/*
> +	 * Wait for Software Interface FSM state to be WFVLDCLR,
> +	 * read the data and clear the valid flag.
> +	 */
> +	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
> +				       data, GET_SWINF(data) == SWINF_WFVLDCLR,
> +				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to wait for SWINF_WFVLDCLR\n");
> +		return ret;
> +	}
> +
> +	data = (int)pmif_readl(arb, pbus, inf_reg->rdata);

This cast looks potentially dangerous. If bit 31 is set, it will be treated
as an error. Should we be doing && 0xff instead since we are dealing with
only 8-bit values here.

> +	pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
> +
> +	return data;
> +}
> +

...

> +static int mtk_spmi_probe(struct udevice *dev)
> +{
> +	struct pmif_bus *pbus = dev_get_priv(dev);
> +	int ret;
> +
> +	if (!pbus) {
> +		dev_info(dev, "Not probing a non-bus spmi device\n");
> +		return 0;
> +	}
> +
> +	pbus->base = devfdt_remap_addr_name(dev, "pmif");

This returns NULL on error, not negative error code.

> +	if (IS_ERR(pbus->base))
> +		return PTR_ERR(pbus->base);
> +
> +	pbus->spmimst_base = devfdt_remap_addr_name(dev, "spmimst");
> +	if (IS_ERR(pbus->spmimst_base))
> +		return PTR_ERR(pbus->spmimst_base);
> +
> +	ret = clk_get_bulk(dev, &pbus->clks);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get clocks\n");
> +		return ret;
> +	}
> +
> +	ret = clk_enable_bulk(&pbus->clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clocks\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id mtk_spmi_match_table[] = {
> +	{
> +		.compatible = "mediatek,mt8195-spmi",
> +		.data = (unsigned long)&mt8195_pmif_arb,
> +	}, {
> +		.compatible = "mediatek,mt8196-spmi",
> +		.data = (unsigned long)&mt8196_pmif_arb,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +
> +static int mtk_spmi_bind(struct udevice *dev)
> +{
> +	struct pmif_data *drv_data = (struct pmif_data *)dev_get_driver_data(dev);
> +	ofnode child, node = dev_ofnode(dev);
> +	int ret = 0;
> +
> +	if (!drv_data) {
> +		dev_err(dev, "Cannot get drv_data\n");
> +		return -EINVAL;
> +	}
> +

This could use some comments to explain how it is supposed to work. It looks
like we are using the same driver to also bind child nodes? That seems a bit
strange/confusing. And the MT8195 parent node (only node) is named "spmi",
so this looks broken since it would match that and try to use the Soc node
as the arbitrator. I would probably go as far as making 3 different driver
structs each with their own bind function. One for the MT8196 arbitrator
that registers new devices for each spmi instance. One for the MT8196 child
devices and one for MT8195 which is just a single node (no arbitrator).

> +	if (ofnode_name_eq(node, "spmi")) {
> +		struct pmif_bus *bus = devm_kzalloc(dev, sizeof(struct pmif_bus), GFP_KERNEL);
> +
> +		if (!bus)
> +			return -ENOMEM;
> +		bus->arb = dev_get_plat(dev->parent);
> +		dev_set_priv(dev, bus);
> +	} else {
> +		struct pmif *arb;
> +		u32 chan_offset;
> +
> +		arb = devm_kzalloc(dev, sizeof(struct pmif), GFP_KERNEL);
> +		if (!arb)
> +			return -ENOMEM;
> +		dev_set_plat(dev, arb);
> +
> +		arb->data = drv_data;
> +		chan_offset = PMIF_CHAN_OFFSET * arb->data->soc_chan;
> +		arb->chan.ch_sta = PMIF_SWINF_0_STA + chan_offset;
> +		arb->chan.wdata = PMIF_SWINF_0_WDATA_31_0 + chan_offset;
> +		arb->chan.rdata = PMIF_SWINF_0_RDATA_31_0 + chan_offset;
> +		arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
> +		arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
> +
> +		if (arb->data->num_spmi_buses) {
> +			ofnode_for_each_subnode(child, node) {
> +				if (!ofnode_name_eq(child, "spmi"))
> +					continue;
> +
> +				/* Bind the subnode to this driver */
> +				ret = device_bind_with_driver_data(dev, dev->driver,
> +								   ofnode_get_name(child),
> +								   dev->driver_data,
> +								   child,
> +								   NULL);
> +				if (ret == -ENODEV)
> +					printf("Driver '%s' refuses to bind\n",
> +					       dev->driver->name);
> +
> +				if (ret)
> +					printf("Error binding driver '%s': %d\n",
> +					       dev->driver->name, ret);> +			}
> +		} else {
> +			struct pmif_bus *bus = devm_kzalloc(dev,
> +							    sizeof(struct pmif_bus),
> +							    GFP_KERNEL);
> +
> +			if (!bus)
> +				return -ENOMEM;
> +			bus->arb = arb;
> +			dev_set_priv(dev, bus);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
