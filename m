Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CACC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1210940A47;
	Wed, 22 Jul 2026 21:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_pIwRcxshwh; Wed, 22 Jul 2026 21:17:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79440409ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784755025;
	bh=4Rlqr+6pp119aqGKMUv9q8B8JG8FfP76RFAjXku44bI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qWCrRYnDD7+SdkXp+WjRrcetj5frzqMVRLKlAHeJ6HQ8Iq4aHQddXD76aP7NxPJri
	 UnVT7URaBHeBz4TWtnjx/GxFyNwYKuGp3S6H5U6MHYajPPZLonIGvB5uAqvTPIG9qs
	 16MrYiN8pSXSaEsk51FSzKY3ScKpVdrIDu76RQ0KPYoMe5gaDtm4lnFdHNZffr3nua
	 3Ivjf/my8dJ+Jx7Wg3l8O8hGm5qB12IoL1GRI7gOWq6k6b1H3TcgKLhdjnV0sFe4iM
	 N50z+6pwQZN+SPjF29v9D0DRrkkODBH9PLiTaZz15OyvWbBF/p6Fwio+hIZnlLGUYU
	 YvEc4YAtByIqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79440409ED;
	Wed, 22 Jul 2026 21:17:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC51F1B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE81560843
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YdPEEwUEezbd for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:17:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8152E607A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8152E607A3
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8152E607A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:17:00 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so602984a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784755020; x=1785359820;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Rlqr+6pp119aqGKMUv9q8B8JG8FfP76RFAjXku44bI=;
 b=HkBeBhFvOXvAv1P+KvW5tmy8GHDTLqHejQm4MqPg2+jsUEi0KTZCLsUiITQklvjlK6
 7V+rivK5Y7dUp5y/F7NARWWcpQ64uOFYmGsp2fiQTTmbOVbtmI/zAZZzgV8X/uz1uVB/
 E+/5aPM5IwvY40NFXN/GrSU9KNC4cEyyAnS79NuZoZnut9z1yfu+puqqnjf+BOKPYchB
 atVWPHLV5aDliWoVmvoxhenJw/6/Mkf1pEFnchvxbMHRP20u0vkhogyHaZUVXCdTQG1S
 Pmc+7vVC5Rp+ys8KrGHVLUWP8wOd8SArmDsmpNVqX44ajHD00uTN3A9kxppioAy48AGe
 LQJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr33SdDOqJqWpJicIIWwaYtOn6tt3frpf5jZZ7beaRC+IKnUsmtXa79AAGGWR6NTxgL1YuOen4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxCFeCRvUbpwOLtNIGcZiL9SpfPs8DwY4Nyvn+Wl37io3hEIQWq
 Q86ruy8M6idXiJ8RUbZENWu/Ah8mLBLq09K2RWfJHtAvxANecegob+7BM8ZBMh6Qk/I=
X-Gm-Gg: AR+sD11nJptXSoJRlX8vtKfSlNPrb9Vdg0QAvgJZ2GSGgFKxObiQkCqOtfP7T9t8+oP
 an+FqlKmyq1VRjpcQ45EZqK+TKM0aDuYSrZg6KIL7cZnpctnTkagYfaS3b5aBUnfy/NgMSV5jU+
 Hk3BOwoVtnzROdixy06qHF8zsRbEHRtErEnnUIOExPACuOm35kZRv7l8XmUfQ7vgilyuIcRyIrO
 Z5DHa8U3uvTR+o+tNJG3S7M30TX3Kpo6AkBOjSbvbsi+lvIjzhv/fBTBR5KvSUBY3A3ApxXcc0O
 bXdiBcmLoD75GkeqlnQgo81QquE9L7o+2+glbrdEbjNIV8mm5A6bpyBFsMxVIGCLcjslO5vMYxn
 IJ72BdjV/E3YZry3SS/1NfNEnauN4veVI2ucNbeIa8azqdtdtfftYTubZ9LX/7gGBXTa3eHtNx4
 wQ1uhXN0EGgcUVvR2wTHrUh/A9eMyy0vE9Cy3KqSR4/dHvE2Wmag==
X-Received: by 2002:a05:6830:81d7:b0:7e9:b4d0:53af with SMTP id
 46e09a7af769-7ee442ab3efmr300593a34.32.1784755020011; 
 Wed, 22 Jul 2026 14:17:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:50f7:57d3:643:9739?
 ([2600:8803:e7e4:500:50f7:57d3:643:9739])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a0b37desm2117667a34.20.2026.07.22.14.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 14:16:59 -0700 (PDT)
Message-ID: <bf64a61b-8346-4002-ab10-a446ed594d00@baylibre.com>
Date: Wed, 22 Jul 2026 16:16:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] fastboot: factor out the USB session runner
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>,
 Casey Connolly <casey.connolly@linaro.org>, Heiko Schocher <hs@nabladev.com>
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
 <20260722-ccaione-upstream-spl-fastboot-v2-1-2ba3f71c42bc@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260722-ccaione-upstream-spl-fastboot-v2-1-2ba3f71c42bc@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784755020; x=1785359820;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Rlqr+6pp119aqGKMUv9q8B8JG8FfP76RFAjXku44bI=;
 b=YZduB/SASvfHNjF1knp8te/zDr8mz/JPIEhtzpxY32zIyBR9MHtER9Tfw9uYSAJcPW
 l8Jdz4qbZbzfCONjPn77xdBpRBRDKHY3RGMGGB+GuC6qIwtR+v/KGAy9zDzIDTEtlvPb
 nTn/hYhxqQzyUwIVZdTr+OxmMGAebOIA6nJmOtcDjK5/2I8pC6gDPoVQFw2HxFnhqIpW
 kCuVz1C/0sRajQuJiZrNpPzyPdyru3hn9BRtX9qlyXqWcEuDSSE8FvF+YiMQAO+ZtXyY
 IAIA8VlzO7pVamrh4N/+7Xfw+1BOFqU2i5rvDENYZiCbY7RGqF8w/itkKX4LDKyPqTgC
 AQtg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YZduB/SA
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/26 3:43 PM, Carlo Caione wrote:
> The fastboot command currently owns USB gadget setup, protocol
> initialization, the service loop and teardown. This prevents callers
> which do not use the command line from starting USB fastboot without
> duplicating the same session lifecycle.
> 
> Move that lifecycle into fastboot_usb_start() and leave cmd/fastboot.c
> responsible only for argument parsing and transport selection.
> Initialize network sessions in their transport path so their existing
> behavior is preserved.
> 

...

>  static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -167,13 +124,14 @@ NXTARG:
>  		return CMD_RET_USAGE;
>  	}
>  
> -	fastboot_init((void *)buf_addr, buf_size);
> -
>  #if CONFIG_IS_ENABLED(NET_LEGACY)
> -	if (!strcmp(argv[1], "udp"))
> -		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> -	if (!strcmp(argv[1], "tcp"))
> +	if (!strcmp(argv[1], "udp") || !strcmp(argv[1], "tcp")) {
> +		fastboot_init((void *)buf_addr, buf_size);
> +		if (!strcmp(argv[1], "udp"))
> +			return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> +
>  		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
> +	}

Would it be simpler just to move the fastboot_init() call inside of
do_fastboot_udp() and do_fastboot_tcp()?

Duplicating one line of code seems simpler that making nested if statements.

>  #endif
>  	if (!strcmp(argv[1], "usb")) {
>  		argv++;
> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
> index a341af076d1..32e8e072c88 100644
> --- a/drivers/fastboot/Makefile
> +++ b/drivers/fastboot/Makefile
> @@ -3,6 +3,7 @@
>  obj-y += fb_common.o
>  obj-y += fb_getvar.o
>  obj-y += fb_command.o
> +obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
>  obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
>  # MMC reuses block implementation
>  obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
> diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
> new file mode 100644
> index 00000000000..08aba7b5c12
> --- /dev/null
> +++ b/drivers/fastboot/fb_usb.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2008 - 2009 Windriver, <www.windriver.com>
> + * Author: Tom Rix <Tom.Rix@windriver.com>
> + *
> + * (C) Copyright 2014 Linaro, Ltd.
> + * Rob Herring <robh@kernel.org>
> + */
> +
> +#include <console.h>
> +#include <fastboot.h>
> +#include <g_dnl.h>
> +#include <usb.h>
> +#include <u-boot/schedule.h>
> +#include <linux/errno.h>
> +#include <linux/printk.h>
> +
> +int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size)
> +{
> +	struct udevice *udc;
> +	int ret;
> +
> +	ret = udc_device_get_by_index(controller_index, &udc);
> +	if (ret) {
> +		pr_err("USB init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	fastboot_init(buf_addr, buf_size);
> +	g_dnl_clear_detach();
> +
> +	ret = g_dnl_register("usb_dnl_fastboot");
> +	if (ret)
> +		goto err_put;
> +
> +	if (!g_dnl_board_usb_cable_connected()) {
> +		puts("\rUSB cable not detected.\n");
> +		ret = -ENODEV;
> +		goto err_unregister;
> +	}
> +
> +	while (!g_dnl_detach()) {
> +		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> +			if (tstc()) {
> +				getchar();
> +				puts("\rOperation aborted.\n");
> +				break;
> +			}
> +		} else if (ctrlc()) {
> +			break;
> +		}
> +		schedule();
> +		dm_usb_gadget_handle_interrupts(udc);
> +	}
> +
> +	ret = 0;

This ret = 0; looks like dead code. It is already 0 at this point.

> +
> +err_unregister:
> +	g_dnl_unregister();
> +	g_dnl_clear_detach();
> +err_put:
> +	udc_device_put(udc);
> +
> +	return ret;
> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index b106d617749..b7b661b9591 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
>   */
>  void fastboot_init(void *buf_addr, u32 buf_size);
>  
> +/**
> + * fastboot_usb_start() - run a USB fastboot session

If this runs a full session and there is no corresponding fastboot_usb_stop()
perhaps we should call this fastboot_usb_run()?

> + *
> + * @controller_index: USB gadget controller index
> + * @buf_addr: Pointer to download buffer, or NULL for default
> + * @buf_size: Size of download buffer, or zero for default
> + * Return: 0 on success, or a negative error code
> + */
> +int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size);
> +
>  /**
>   * fastboot_boot() - Execute fastboot boot command
>   *
> 

