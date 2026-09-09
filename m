Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389F8C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD64C80E67;
	Wed,  9 Sep 2026 20:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6mqRBYa-ijhi; Wed,  9 Sep 2026 20:31:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1734F80E59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788985903;
	b=opzNPT+OwMmF9gDg5iOoczdPTxMhV5LymngqFLXlJF1Yu/uv5pjz7nCV/XoWR5j1Xsuk
	 hCoJT7cB0qakhUOfeQhyeCYZ6eH7MIM7uhvk0iKhDXWIId5U5r/B3giEmQLxO5+o/WSVv
	 BQHpHPkJFr4076DtxdikQx1FhrBNkcBJiQNxD0mOHtS8vfBXPx1i1V3m7rtgA2JbsSv7L
	 kFQNMIh9Pmcq56SLzFHg9VVS/eMKghjyU3xBI+WAbuHcOzBizO7Usu99ZOou7p7mYSRGV
	 6QSPxHAUBa9gpJxy6wnJG1GpNecZPcJtTtXqAsrUcHh0lyNdbEqALrRmiuYWPFnQJQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788985903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QFpPOJoGreA3IjqNWvUKLwcs7npTKcIIwN4Z/6aCE/s=;
	b=BWiS51iEGfKnpJ2NDpKS9saUxQxj+rkt6ioLKxDoG+0IBgtFesaZMsB/DeFEpdPx2vjP
	 QRJ3moMIOLWoaVZoo1XjMlD+WH33JM0RwpG9RvHPinSdI6q5Btfh1GW/W7bm4hXmhDEXx
	 ZUlKDKIIsoYS1odEP5sNKBIeFJYS5M+H6ruFMBVEmAX0ztypy04aJP7SF4e6jPL/hNuRg
	 o4ff0PBeFdr5xYMp8NEFLHB3lUU80MlRiWVWaq/IF1IMgrAJ+uK/PLYz+Mu7S1Ua+Ymjj
	 lPAV2ffw5GVK8HlkV60Jr1AnQsegvIF/Or3ErjjcAJhRf1UrjoqEA7k6UHMquWp0YCg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788985903;
	bh=QFpPOJoGreA3IjqNWvUKLwcs7npTKcIIwN4Z/6aCE/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRkw7LUWX1A/0Ya+uFCcizq76a+dBo84qevlDNOpvQX3IKrc/U/iGcAzQd5f4Dxcd
	 PhgRyK/MsFpXlU2bsFzqO0tA4iss9AOvPbAuUwX5zEDUvYPb0HbjdjPOyDJtd2GWaq
	 qWASRNwzXBts1GUNeoELcRABU105VymxdNF0bIq04huBDt2GdVxn58GqAuNsJCF4UO
	 7EgkbQPeCNIksMkBA6YVZDEAvSjfjEa/E2ccHKLSO1BCdtEnZyqxX6rZPN3gDVovVy
	 fgnI9gMyu0fpyID4+i6ig5rwO1NVrDIZvkjassh1BTqM/1zm++tdR8uRq5NesZW3hj
	 abirvDMQHOkdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1734F80E59;
	Wed,  9 Sep 2026 20:31:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0284C43F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D47424025D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THm7JoaaX8n7 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 20:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A7BCF40252
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788985901;
 b=k01YSUliePgNhCSByFBKRlchn9V0JZV7CiCLwtWkct9mzE8JqRqUHjNYjvX3saoER9Gz
 Gwojz2p5CTyjs3x52zGuBkd+kLLqD/y7MN+tROt+pcDZ8xW0ywylMxuAUiJPwK2GK4J9l
 oukOLnu/fo2ixabFtZWlgiRcFwGJyGWWS8OJ+TGrTA2sg7wWFFActps/N6LkCnSDWiFVM
 1gHYRcqO38zq2sKQo4z8iTWJWNkfZaCmsXrMnCzsCjVzGqTVgd7U/GxhcXRLv+VavQpAx
 HAikK3zgl0vjNGSrSIuu5JegW23uSG7Gpi7vhhqPBRX48QFBOp7qdZHrtGGQrFH8/5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788985901;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=QFpPOJoGreA3IjqNWvUKLwcs7npTKcIIwN4Z/6aCE/s=;
 b=UMNrRd312owvaKqLztf9sTaCllw/FieGb3XfCElvclFfzqFt8HFvnsPBlK9xLZFaw9Zz
 4HwowHHj4wYmFmJ67DjCoc/eyX4o0FkKpgu1nzt3N/BrpDiecYGlwRUJT9JNYpZsRXouj
 27oO/YsszHUUXSdgliw0mLIXBoP+K+msSrdyktvrYZeM/qt4FJZjieHrtwWtvqhMgE68V
 4QqBnDZh3ffxPm8xLs3COM2KVGCoKsLvE6GYYtwCdS+VkjhgzdqPhDKyzldo3nfLQ6ZNo
 9CGophR0USNWxy8x5WHhsJV+p8qMXHps67jowwcndzB/izbvQFxOgXXajROzCOyGWlA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ML2PVTAu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ML2PVTAu
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7BCF40252
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:31:39 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so6024798a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788985898; x=1789590698;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QFpPOJoGreA3IjqNWvUKLwcs7npTKcIIwN4Z/6aCE/s=;
 b=ML2PVTAuQWf3vwgsXZMGNil/F2hz1pGYNnYB3YxAwe0WwKdJkw7a85EEiKnF5yA0T6
 1ZyQmc1C4YeCyt2lTxON7kUxS+s0ABTq/UiVsuv/8vTgkE/9ZX1gxmBTZKXU/hBCbpH+
 KT+h+fH606MlQH3EWLhLGCz5DAThmGxKMzwajjpqAdmr2A9d5LQKSJL215TwbTXFpJKB
 g8yuEOKADU+YAolD2i4djwsjr+r3MkLzmVSmDVx7HvGj4IF54b6zOPZrFtLUHoEtBwO2
 cZ017nXvT17vODTjpDTMSZvEFUVIFT6m6VL2YLTasW07jBAMdvkceJg9e4k1uoZ1FM6f
 l3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788985898; x=1789590698;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QFpPOJoGreA3IjqNWvUKLwcs7npTKcIIwN4Z/6aCE/s=;
 b=jCVOKZH26GWCSdkse4gwRfUGfWN04j1NnQ05CwOfXPJfEH4WMwuKsRILbI2Wh80/Jw
 uJCzJ5E+9Hk/g7jF9x3pM+SOqw19mG8y/l58hBAzhEx7r99EUONRkNkqWZ8DOdo4JRMe
 ZPDuL1e7BmUQyz0tfv5vUQrnOilIQOdVE7pFQ+YvcdZqYiFQ+efXim+Tpr2SGEmE5fQf
 vjfuTEd6xzrMuS4gc3AZEj3fx/0s0Jqn9dGoCI9f6/JtLYAsHKT2k+IvFwPDPfSf71Wc
 qJZkiyR3d0Xk86NyYIKUKMTycPxNIPi5atuBTen5V1otWU1o9XFrQPu2L4UW9mFkIQPW
 C04g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+9dIfQcY8bkxEGMRCl/GnKcRggP+++f2Yn8OiPjuFTW+KEktLj3WyTPRMyXlV05CiuspPZJo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mR7FL9sJLp1bY9BYhnyHw+DIjYMtk0D99/01fCeF/d0yztStrk
 UptoL7OUXRE8Hh9DJjuvKJANPb/j0x5Ab7En1c0Et47/YB+fR1Qr3r9qDMe00j5/E4s=
X-Gm-Gg: AYBFou1+zP3rr9g5PjwWbscDloSRt0Wbl6Kz4Caeiut7Vamo07I+52AT8oLrvvXwB5H
 a/lI4R98JuFdh949HgMF3gwgnIAfTkbSDupoeD0H5uibUWMDDIOvztXgQb05kCbJefK12QfYP8x
 b3Vt2xiLGvySP605ElWhNFJNaxc88c3wx3oG3RPDfZQMyGrq9HyFk+0d+41F/cDnJeEhjIDbTU2
 40dGeGZqPdzPijb6vAYwDpELi4pk1+7tf3Vf3ubu1DHXAm3wsOBhqwxmn/fzY5cEx4a0fRiYPki
 /Fxwp2+RuJG3/Orry1LsjJ/MIQar+HO5Q63s9uDV9ttKQzI40Fq8lNbymdesy2v3GF9CPc6ytlg
 FRUnfZBFrSTrjr5vmtLoua36qlfZJsDeZcP4XmfZ6ArA1TZLOQ0N2++3LsD1bpuARfcwtedSVI+
 qJi7Pb90Sh1pCXn32Dsz9oE2jqeVg63kFPK1FQybUYsr4YibbVfqTK06/KMIMQjHY5c+o6fDVV4
 b3mRPqnOjUkHvp93tjA06aKaZz+Za0cpkrBuV9mqe6HaKQKy+hWJMzWgQ==
X-Received: by 2002:a05:6830:63cc:b0:7fc:ae19:17ec with SMTP id
 46e09a7af769-7fcae191b13mr14669024a34.29.1788985898441; 
 Wed, 09 Sep 2026 13:31:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7fe443df0d9sm9129241a34.0.2026.09.09.13.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 13:31:37 -0700 (PDT)
Message-ID: <37ae519a-e6e8-4510-9da5-3da70760cc8e@baylibre.com>
Date: Wed, 9 Sep 2026 15:31:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] fastboot: factor out the USB session runner
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-1-023516e77321@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-1-023516e77321@baylibre.com>
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

On 9/6/26 3:01 PM, Carlo Caione wrote:
> The fastboot command currently owns USB gadget setup, protocol
> initialization, the service loop and teardown. This prevents callers
> which do not use the command line from starting USB fastboot without
> duplicating the same session lifecycle.
> 

...

> diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
> new file mode 100644
> index 00000000000..5c62bf42e72
> --- /dev/null
> +++ b/drivers/fastboot/fb_usb.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2026 BayLibre SAS
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

Could also use stdio.h and linux/usb/gadget.h

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

Technically this can be called by something other than a command now, so
perhaps leave out the 2nd line.

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

The code below runs on success to, so perhaps labels shoudl be out_ rather
than err_.

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

