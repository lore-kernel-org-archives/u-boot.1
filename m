Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0E2C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 787616066B;
	Fri, 11 Sep 2026 12:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySemO7P6LHf4; Fri, 11 Sep 2026 12:34:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5E6A605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789130093;
	b=JKvZaV0n2Ju0Skhm7UpEcdaTzro0G9Kp6z2DdXM1TyCfRufjdmu59XO0lCCdhkaSTEWG
	 oGF7OdCgjjzrawOhl903MlNDrIUb/u8ZzhL8FA9TxD2GF/+d0T5FrRBITWqX2TydnqiiW
	 tIBqK6rk3kdaj5ydoeEJ8SqWQFwGgl5Nu6osT14rJ9+CgxN41emScpMFJXUP46acjTlCg
	 HjY6b1MfRmCOOjOv6hkxTlieh5s132vVB/m294hRwS7ZLvWvMaH03TGWmW7PBSGABUZch
	 CYSgJTkb+g2dIzNF2Q81rSsSL0RIcHa5sSOuyBpiLtxLgtFI7LqSSIsT7PKazAL7b9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789130093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4cYkZSWhBvYYjk2sKqgmsYfMjbKCfcHrMbFCI1wo+Sw=;
	b=sn/pmfoQtLIvGSesX3UscO6b1n8ti494TaEVBtqMpEQS+54zcABzbBBgrz4+B0E8KcDM
	 7Pt+ieWC7Bgl3oJe52Yew+RflaMfbpziEP9dy38BtTHgT0IojF5JT/rF5VppI/z+twkfn
	 e1gjSeZC8YuJ4+RefcF/rV8jlrHoFLVPcn1rufq4Q5Ny3C91Tor/vkbKO+FgKqTuMm8rK
	 KME79ajgi0xaUJNAtAEaYwPjEtyiMjzEMTrlrcJK210DQ61n66WsJLvGZ78hXVSWUYxco
	 8JMAcpT5S83VX9gLtj4yFrpDqH5A5IdQOgH0zycBTET0zxEIunByATW1x5Stj7AqhZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqUPvDXX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789130093;
	bh=4cYkZSWhBvYYjk2sKqgmsYfMjbKCfcHrMbFCI1wo+Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BDn1xCGz4mH7SoFA+DGpe9Bzdxf530mbLkj5b/kj/c7/3vzec+wQvD0x2TsX4d+p4
	 H2SO40VztU4jAP6g38UqCfg0Khtczjf7uDdLvKF0oAp3+gjq1uvxHKl/sCMLfT67PM
	 gPs4Bkc1t4CJeUWW926VFEVZVcr3c9/p6jHrCUHMtmYIinUrLrGaqa6zd0LR2Hm7aJ
	 ZXHEB8tUYdbAdIPi8dDZBqOez/CmX6HDx6CwwTa1g576RURHk31g03g1RYst3HZPLz
	 stx6DQuGtvcdsH3T7w3ZILl/G8Oc7pT7GkWOrFZ9Bg//O+yUdDHwDEWW1R0BBWEf4V
	 F4ms3eHfNGZdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5E6A605F1;
	Fri, 11 Sep 2026 12:34:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D862701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3384760607
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRA0cAOUbHu3 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 815BC605E4
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789130091;
 b=Mg50W/yFfqsphNRsGKrnmGTb4vWvCZAQL2hnV0rDvY+y0CbYYUFGur95A495X1wLZrTp
 VtJrEqKdDeVedJJuOw3JsI2ev//C4S2UCPAzBhp3zyFWWQ2cC4d9xPNenKwZqMY55wSRf
 UpDd9srONG7tdZAoQBc0fHkr6cYL9lA6i5QrKAGKsPp7T0QeQlQ6Uz8P67vlX/wChOk75
 nnz/XIhSXsscOyw0XWZm5Ynso8Czwk6UGoO3CkisvfVxHfB6O4U7Y/GhkHTb3bX6NeZ4M
 qH3jXfCiWTmVN9cOeg0E0u13fYKtccnoJivufHmI2hZGgNdmOZYpDKSaZElax2oRBdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789130091;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=4cYkZSWhBvYYjk2sKqgmsYfMjbKCfcHrMbFCI1wo+Sw=;
 b=NkkysOG/TGGSZHozK90gAfPBPdx3ZGHG8ICrkAs6T75umdA35qXyrik0i1su78rRtj9V
 Zhh+QeJrLDpfI7jEPRUSX07ksI8+NltKFQPDQdMhjIFXdc3rtyccp6Nz2LisfulxdQdJ9
 ORZLWxZx4sd8yTSZUrbpUSFNdGXfHIxcy11BKehGr7ALPrlrXrZ03OMKekSS/HL3gXSUq
 EVhSdyFfZAB45uNT9AeVJ5K1ex1jbnoQ/YSHx8647/xk2hNFn3yAbCYqO5BnxGudMqk8n
 jh4H+Z7sTGVZF/QOutjJzjNhE21G2dIdX91yE344KMSi6b2ha5dxx751tMmgZcA1uVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PqUPvDXX; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=PqUPvDXX
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 815BC605E4
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:34:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60D81411CC;
 Fri, 11 Sep 2026 12:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D24F1F00893;
 Fri, 11 Sep 2026 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789130090;
 bh=4cYkZSWhBvYYjk2sKqgmsYfMjbKCfcHrMbFCI1wo+Sw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=PqUPvDXXhIylJw8cijnOlnXMwcxBvIIVYfEr77mgvKqk8UNhuVHKYrFW/nK+xLE0T
 yb8FyilJQOMU3yRPQ7GDhasiya+ZaHaptx5uDHpsD2/+oIfs7KfZukXW+mmvVvbZkO
 JPAXJYAiFZVVSo5a9PBUqO6rLnAp0xOxpEdh0PuKVtICzex6igADbMtIhz0shroCLs
 M/GbyqOQt7F4hpg0iYZ5YX3LKOq4AMA2l/Ww90hbiP+4yGKzU7PBRSDniuPIzVa1ck
 AvACUUqU/1C2xpU7v0L7s/7PFcAQpXurQ++3JdnDlRnydIT2oYMrlDLKqrYS8AQKCi
 MWwcpGZLCgBlw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, Carlo Caione
 <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Julien Masson <jmasson@baylibre.com>, Alexey
 Charkov <alchark@gmail.com>, Adrian Freihofer
 <adrian.freihofer@siemens.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Vincent Jardin <vjardin@free.fr>, Peter
 Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 1/5] fastboot: factor out the USB session runner
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-1-023516e77321@baylibre.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-1-023516e77321@baylibre.com>
Date: Fri, 11 Sep 2026 14:34:47 +0200
Message-ID: <xhkdbfqzg3r14.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Carlo,

Thank you for the patch.

compared with v3, v5 introduced some new changes which I don't
understand.

Please see below.

On Sun, Sep 06, 2026 at 22:01, Carlo Caione <ccaione@baylibre.com> wrote:

> The fastboot command currently owns USB gadget setup, protocol
> initialization, the service loop and teardown. This prevents callers
> which do not use the command line from starting USB fastboot without
> duplicating the same session lifecycle.
>
> Move that lifecycle into fastboot_usb_run() and leave cmd/fastboot.c
> responsible only for argument parsing and transport selection.
> Initialize network sessions in their transport path so their existing
> behavior is preserved.
>
> Keep the command-line diagnostics for a missing USB cable. The helper
> returns -ENODEV in that case, which the command maps to its existing
> failure result. Unregister the gadget before releasing the UDC so no
> registered function remains attached to a released controller.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  cmd/fastboot.c            | 53 ++++---------------------------------
>  drivers/fastboot/Makefile |  1 +
>  drivers/fastboot/fb_usb.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/fastboot.h        | 10 +++++++
>  4 files changed, 82 insertions(+), 48 deletions(-)
>

[...]

>  		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
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
> index 00000000000..5c62bf42e72
> --- /dev/null
> +++ b/drivers/fastboot/fb_usb.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Why is this GPL-2.0-or-later? In v3 it was GPL-2.0+ which is what's
present in cmd/fastboot.c

> +/*
> + * Copyright 2026 BayLibre SAS

This was also not present in v3 and does not seem an appropriate
addition to me since we are just copying code around. Why should it have
a new copyright?

> + *
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
> +int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
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
> +		puts("\rUSB cable not detected.\n"
> +		     "Command exit.\n");

This is a function that's not necessarily only called from a command.
Please drop the Command exit. part (that was also not present in v3).

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
> +err_unregister:
> +	g_dnl_unregister();
> +	g_dnl_clear_detach();
> +err_put:
> +	udc_device_put(udc);
> +
> +	return ret;
> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index b106d617749..f02d2559f2b 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
>   */
>  void fastboot_init(void *buf_addr, u32 buf_size);
>  
> +/**
> + * fastboot_usb_run() - run a USB fastboot session
> + *
> + * @controller_index: USB gadget controller index
> + * @buf_addr: Pointer to download buffer, or NULL for default
> + * @buf_size: Size of download buffer, or zero for default
> + * Return: 0 on success, or a negative error code
> + */
> +int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size);
> +
>  /**
>   * fastboot_boot() - Execute fastboot boot command
>   *
>
> -- 
> 2.55.0
