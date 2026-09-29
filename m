Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757EDC9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ABAF80EDB;
	Tue, 29 Sep 2026 15:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xQiQ9ai_9j4l; Tue, 29 Sep 2026 15:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5CB0180E0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790694848;
	b=fgTQ69R9dDOupYEuppAzPnCuwqAMFFOTemEgjL4a4o8Rx2Wh36zVuqq0DGqrGE/l3Cnh
	 A5yggNcWGn7P5nB1Z7ew2VCoUs1LsRhI7TXqgTK6SRa9fm5HJ5BYR5Tvk11Jtp3q0eRkk
	 M6duVhydE9+Rwpo4zX6v6xTJGCuoIfSS+x9tyhWg+JmQ0wp5AxZfWSWnIUqu3r8qvQhGz
	 fBash9Xx+PdEUpqf4IMQjQ2GZPgG99AsYK2T84mz26fWMyVlPamN5mUVhSc8efMMht9gq
	 0oLpyBCbYc3o/i0iT0ENsGaVP5Oi/Z7yEEJigpmRvAMxGvH58+E1ESudYTNX1M0qvrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790694848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LFfLUaLWNMMVOcgectjVQ4vXBtUz1GFje9i5mdFc6a8=;
	b=ONQ9IHZsKlz+5w2IM/nwHfeUBsD5lsdmFRXpaS3ASV815fYrAvYYcoFP+N4DOJzzWtrT
	 MbF4t5W3BYPYLM5XwBbteTT0XBQyB8GYl0+rfpBtoO/N2XEnFa3wFV2a/zWRzhtsad+Hl
	 xb2M2/NleBZq7h3op3VEgMtMIyYWqi2wTn8iGmEW1eB8jvvKvJfgDd20KlsFZnLd9ppYh
	 jbQzA2kOwZ0UgxwTY8o7woAOhb+EicAD8lAyCC1AFGfQnYc+72wRlEgX4jPrH2xFTTStG
	 E/4oKG9mINk9WiDIbnxTG2F9Odl4MuGBxfeT05MSp1M3sb7GIV+X/HmQTNJDV7tuY6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790694848;
	bh=LFfLUaLWNMMVOcgectjVQ4vXBtUz1GFje9i5mdFc6a8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rvL+b1W7RVf3E2ZX+BCEUwcGqW/Kt5bLttScEp7JHrQcFYgClKmh5eV7NNrk+7+NF
	 j6dK+pR8RJpBFumY9eskMzkVqwzP6w2kAsb2hrtAZVhKG6al3zVmCf2wchY2gv7vlp
	 AVfFsjOj2yoEqDjdma/f7dMcpI4/jiVkxMrIm/iiVYQXv/lvP9guxJSJcHCtDgNpac
	 U/j37v0nQUUOULzxMyErnZP7GqgtSKbyD/tlmg1zC8HPIPT8ENhO9lYuxKLhJ8ZkHw
	 /R9rQFT/JHZlSTo9hLuXY8wUdQCd3IhHw3syxgHlFALcCboPIAsIbaEJxd4G1us4uV
	 6Ixr0TiERLy+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CB0180E0C;
	Tue, 29 Sep 2026 15:14:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CF0472
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AA5A4032B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbCYJ-jYZe1Z for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 77A3940304
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790694845;
 b=CdCUBUshX92qqg9F9nBKuhCC9wJP8vR91KAbh2jHlolTo4iU5q8TThSkf6P0fdYj7ezs
 y0RMtvPgOURksxIA0h9bdgZLG6td8Qrw8zrfKzoOdoYbHav4bAEUHtxtzjCz3FQm0aQQQ
 bukoN89QitqDG0ib7qVp7F5QAXKvKXBcUak9aWW21uyKjR0uGXHMaj2QDafyuE0BVCibJ
 eLgB44KSh5ANb1srTpnlzqs6B7jnx6uGC5sQhKuFpbsn/WoyhjAMHLVb9l2z9ClppVC8G
 l0KwMofGyqFWFARy18671ypd9cEpqsrsTpy3yVNvU89kKrMlKamZeUDTPdNQY7OSUzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790694845;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=LFfLUaLWNMMVOcgectjVQ4vXBtUz1GFje9i5mdFc6a8=;
 b=Cj70ZhBFNx5PV7YgPqh0zD2PJ5n4rT+ALi7h+Kz97P4vZ8lNvIkOJCQkqROQkPWa5R5o
 puNaHb9EKTXDJ/Pl9gtF+D84hCo6awo5PVjlUayvvPrDbT9EBUqJIpNFtl8b8hZgHKo10
 5scgSLnT0LSuuALdVYeKpahij/acMTTljx7ZFXL+Q8KIh2ImkIAKa3lQ4HVfNLGGT21xx
 EsM/b88XrNVuypnaKvg6NBKD5fvjWkDFpxU4LROK30LDb4fSxS7gbr9TEkxMfb1d7iAaA
 fJmafI5OvLju92hVkadkuJnY44vedWeIU8tyV0ubLYn/Q9EQLpUunAlss1IQTY4GwaQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nlxtGEaU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nlxtGEaU
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77A3940304
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:14:05 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-8167e0d1f90so2717040a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790694844; x=1791299644;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LFfLUaLWNMMVOcgectjVQ4vXBtUz1GFje9i5mdFc6a8=;
 b=nlxtGEaU7LkXVlXXlxb0c4zpAwwZ7kG/hdu/Wq/FRwLorBULeTFsB8Uo0ZFkF1FWS9
 bm5ONR1FD8qP26GAgwyiJfVn3d0lFbjTlRf+crM/viLFGJl6EsAZCR7fb7vlF2r1NUoU
 YJT8Wi4wSGSIAoxa1Ez2oA8EQbCe3Tl0XtuMPVssf2HcX3vq9UpcrTarKv22f26ggmo/
 ZAwp73ygIpoTN8BV/QmA3m3iO7yslf03/ydupysxrTstfU40MrHHGvqeGFAgSDOoOVP1
 chTjaLgRPGeuZVYuZ/AsUuPV7tb5W33cH9XXKWCNTUXVUckQgJlnW6BhVI8VWDTUxnlw
 ya4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694844; x=1791299644;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LFfLUaLWNMMVOcgectjVQ4vXBtUz1GFje9i5mdFc6a8=;
 b=qX7wMK33U6TP8UWQoJEShk1jrbVAkFbN0KFOxZ8+xd52UVqvhl4KUS1RgYeJAZoKNU
 ZuiFOP3KackwEhDc07GBMtb7ebpTObmQG3CFZm/0DKwJKvQiPRjKSqwenaOC/igi35t/
 p0ImQKzA9dcYmum9pCkz3XAHUCqVXiNvnk9KGyR4zRVaAWqxwqBwlpYqbGuwns6w4hb4
 X2lW1VFH18NN8noBLaDjFmyGfVmkZBUF5DrGTnKZ1L6m/hqV4+/xj5aD+alUQ9cZyI5L
 Cko9dQBjq2q/I7C2/1o53f/n7B1KkiSCL3/GupnV6KrflbMeHUMnd2BQ4YFQoYRUEHjk
 6H0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3/bN/wDmqHHcVZ7dp28gC39StBjUpKWR9+XAwH88r5i1yQpYNYxwiQYykYehw0im63qWhc7I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lHrmjL+1Cgb1SMfC7n28JkKesoEocplH2cftwxBewHDq5Aq0O3
 dvu7pu2pCGmYBHl+aNQxaEeWGwxC3XdopZFHar2Ztzc5zcO1B/UZSlARYVNy7VLk94w=
X-Gm-Gg: AYBFou0eiu1xPomL+iVzgfZ8yz4m5SKRgkC9O2WkoU+nQrUEBYvImfp9UfnpPjMXIJo
 Pp83eC188X6qgn97jIzrE9QWcYhr1XgOK/bH7Y4aZmvR44ihufmCP1hmkDHnxdXBCg0eYAI9Hes
 NR31sVrtXKlCRJm2UroXNzaj9/dNbwuaMjExrTFRDBw9Ije4s614fBYdCFSLH1gMTbSZfl+xHDO
 5KGaNRAamBQUXBLhs/OwRAb/VNIwpzQieWLA7gKuGmczRqk1VDB5ogfhIvvfGVxhqowLgtpYvT7
 rn1jKXBP8toOo396TkYfyXwvjS/+lV6SC3G4ogJUE/B5BOY1aerVibUrqZ4ESTehe949ccICqJq
 CyrJaJpRzleNLMEiZX4+lPCqA4ZypfoRRuw6GtpUFOioxXAs9RLzOv/avH1bq3VWXKd3TSu4122
 ZD2mQ802wPim0J0j+1E3HwPlpDu0GaljG91Igu5mp+NcfA3/na+gf/XRwLU61QqnF1Dcpl0IKTE
 Szi3nV7Mh3kY5SaRV1/51DTn5jgNMxVcBsuCXGjNkhnYWc3
X-Received: by 2002:a05:6830:82f7:b0:7f4:bba7:f547 with SMTP id
 46e09a7af769-81781795b3fmr16717991a34.10.1790694843996; 
 Tue, 29 Sep 2026 08:14:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9b16:2a1a:ef3f:3700?
 ([2600:8803:e7e4:500:9b16:2a1a:ef3f:3700])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81fafcd4b67sm62628a34.21.2026.09.29.08.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 08:14:03 -0700 (PDT)
Message-ID: <839740df-5921-4941-9b7c-a852130029ae@baylibre.com>
Date: Tue, 29 Sep 2026 10:14:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: power: pmic: add driver for MediaTek PMICs
 over SPMI
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
 <20260924-mt8196-spmi-v1-2-dd2263403691@collabora.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260924-mt8196-spmi-v1-2-dd2263403691@collabora.com>
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
> This driver acts mostly as an interface between PMIC/regulator devices
> connected to MediaTek SoCs over SPMI, providing read/write functions to
> those devices.
> 
> It has been successfully tested with the MT6373 PMIC but should work
> just as well with other PMICs as long as the corresponding compatible
> string is added to the driver.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  drivers/power/pmic/Kconfig    |  6 +++
>  drivers/power/pmic/Makefile   |  1 +
>  drivers/power/pmic/mtk-spmi.c | 88 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> index 95687d0bdfd..8f35dfdea84 100644
> --- a/drivers/power/pmic/Kconfig
> +++ b/drivers/power/pmic/Kconfig
> @@ -464,6 +464,12 @@ config DM_PMIC_MTK_PWRAP
>  	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
>  	  hardware to connect the PMIC.
>  
> +config DM_PMIC_MTK_SPMI
> +	bool "Enable driver for MediaTek PMIC Support over SPMI"

This won't work without SPMI, so...

	depends on SPMI

> +	help
> +	  Say yes here to add support for controlling MediaTek PMICs using the
> +	  SPMI bus.
> +
>  endif
>  
>  config PMIC_TPS65217
> diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
> index da9b810de90..a6a16b90bc6 100644
> --- a/drivers/power/pmic/Makefile
> +++ b/drivers/power/pmic/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
>  obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
>  obj-$(CONFIG_$(PHASE_)DM_PMIC_CPCAP) += cpcap.o
>  obj-$(CONFIG_DM_PMIC_MTK_PWRAP) += mtk-pwrap.o
> +obj-$(CONFIG_DM_PMIC_MTK_SPMI) += mtk-spmi.o
>  
>  ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
>  obj-$(CONFIG_POWER_LTC3676) += pmic_ltc3676.o
> diff --git a/drivers/power/pmic/mtk-spmi.c b/drivers/power/pmic/mtk-spmi.c
> new file mode 100644
> index 00000000000..39895bf9c0d
> --- /dev/null
> +++ b/drivers/power/pmic/mtk-spmi.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0-or-later

> +/*
> + * MediaTek generic PMIC driver
> + *
> + * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> + * (C) Copyright 2026 Collabora Ltd
> + * Author: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> + */
> +#include <dm.h>
> +#include <power/pmic.h>
> +#include <spmi/spmi.h>
> +
> +#define REG_MASK 0xFFFF
> +
> +struct pmic_mtk_priv {
> +	u32 usid; /* Slave ID on SPMI bus */
> +};
> +
> +static int pmic_mtk_reg_count(struct udevice *dev)
> +{
> +	return 0xFFFF;

Do we know what the actual max defined register is? Making this smaller
makes the register dump command go faster.

> +}
> +
> +static int pmic_mtk_write(struct udevice *dev, uint reg, const u8 *buff, int len)
> +{
> +	struct pmic_mtk_priv *priv = dev_get_priv(dev);
> +
> +	if (len != 1)
> +		return -EINVAL;
> +
> +	return spmi_reg_write(dev->parent, priv->usid, /* pid */ 0, reg & REG_MASK, *buff);

Could make a macro for pid rather than the inline comment.

> +}
> +
> +static int pmic_mtk_read(struct udevice *dev, uint reg, u8 *buff, int len)
> +{
> +	struct pmic_mtk_priv *priv = dev_get_priv(dev);
> +	int val;
> +
> +	if (len != 1)
> +		return -EINVAL;
> +
> +	val = spmi_reg_read(dev->parent, priv->usid, /* pid */ 0, reg & REG_MASK);
> +
> +	if (val < 0)
> +		return val;
> +	*buff = val;
> +	return 0;
> +}
> +
> +static struct dm_pmic_ops pmic_mtk_ops = {
> +	.reg_count = pmic_mtk_reg_count,
> +	.read = pmic_mtk_read,
> +	.write = pmic_mtk_write,
> +};
> +
> +static const struct udevice_id pmic_mtk_ids[] = {
> +	{ .compatible = "mediatek,mt6373" },
> +	{ }
> +};
> +
> +static int pmic_mtk_probe(struct udevice *dev)
> +{
> +	struct pmic_mtk_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	/*
> +	 * dev_read_addr() can't be used here because the reg property actually
> +	 * contains two discrete values, not a single 64-bit address.
> +	 * The address is the first value.
> +	 */
> +	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	debug("usid: %d\n", priv->usid);
> +
> +	return 0;
> +}
> +
> +U_BOOT_DRIVER(pmic_mtk_spmi) = {
> +	.name = "pmic_mtk_spmi",
> +	.id = UCLASS_PMIC,
> +	.of_match = pmic_mtk_ids,
> +	.bind = dm_scan_fdt_dev,
> +	.probe = pmic_mtk_probe,
> +	.ops = &pmic_mtk_ops,
> +	.priv_auto	= sizeof(struct pmic_mtk_priv),

Make this a space like everything else above.

> +};
> 

