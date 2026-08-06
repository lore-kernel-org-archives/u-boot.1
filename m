Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD7DC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 03:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B208C60886;
	Fri,  7 Aug 2026 03:48:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2HdRB4h6BYX; Fri,  7 Aug 2026 03:48:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE54A60879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786074498;
	bh=+sZBObxljzhMlZxRiNRb5hVaiHmIyVNBp4QWaVRAgkw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WVOFQMOWytVdgzblecYnAKX58VCiPrIr44dootGHYxn6ZF4BNw2Mo3bQgckPYhNy8
	 WyqvE1KliFg2xkHqZ/AWRdpU07zwsxdX6vFZz9QsqQKLB+hh5xwC2HFGXed26+YJ9N
	 6ByC+amSvs2dmYZstRPalZp27e9t9QtC4ouXxBGNj71WpPufVn8dQ2+Z+xevwrMtk/
	 183K8EIwAspPy3tvLS1nx/SL7aNTnfOqahNQtUZ/WPe6DR3RO1EWTaizTYYt8z7aou
	 eQdxf/SQzHAVFAu6SgxzD8bbI4NObER6yxBt2mQSw76AcRLDWXErHLi30PBy/F2HI0
	 c64205tZIU9cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE54A60879;
	Fri,  7 Aug 2026 03:48:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C88F218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2CDE60879
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceEo9HSzgBAW for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 03:48:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3FAF760629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FAF760629
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FAF760629
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 03:48:15 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hGVVM613Fz8v39;
 Fri, 07 Aug 2026 05:48:11 +0200 (CEST)
Message-ID: <67436bcb-45d0-4cd2-b6fd-6b85633532cc@mailbox.org>
Date: Thu, 6 Aug 2026 20:05:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/3] usb: mtu3: add SPL gadget support
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Julien Masson <jmasson@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>
References: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
 <20260806-ccaione-upstream-mtu3-spl-gadget-v6-3-66e133a4bf1a@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-3-66e133a4bf1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oiqxsuoy7qp86gjestipck1bxbyx9fy1
X-MBO-RS-ID: e32e0e3e7847996cb7a
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786074492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sZBObxljzhMlZxRiNRb5hVaiHmIyVNBp4QWaVRAgkw=;
 b=Ef8ViU/l9z4sMaSmaH1xpVv4ku4cN3rP5DpL7aiij7PS3nThSVp34kWlzLQKC8TMIEhaQQ
 gBMcFl3AY8rQhZIo3/XvrAUsQYKp9F1eqXiDBzszmZ73S3dkre0yZzc9/Fhfm8FZS14Uan
 rnitjtyJsylYYhAe7im9aBDqmxzYrPoTx/n8Hgslw0MJ8MXmrfNIvCC60klV6MQCbDTQsl
 PSw3tHB0TUd4NwnkkeEO7Y30OTCOa2UBALVmGavXy2lG7nEIoM7TWpLvi3SdTuWSwKB/94
 tF/rUBN9VGr6IUat0lW3iV6UqWd0SdoQlYI/MaIS8Qk5q9VytTnhENpC3VHGsg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Ef8ViU/l
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/6/26 2:54 PM, Carlo Caione wrote:

[...]

> +++ b/drivers/usb/mtu3/Kconfig
> @@ -42,3 +42,23 @@ config USB_MTU3_DEBUG
>   	  Say Y here to enable debugging messages in the MTU3 Driver.
>   
>   endif
> +
> +config SPL_USB_MTU3
> +	bool "MediaTek USB3 controller support in SPL"
> +	depends on ARCH_MEDIATEK
> +	depends on SPL_DM_USB_GADGET && SPL_USB_GADGET
> +	help
> +	  Enable the MediaTek USB3 controller in SPL. The SPL driver currently
> +	  supports peripheral mode only.
> +
> +if SPL_USB_MTU3
> +
> +config SPL_USB_MTU3_GADGET
> +	bool "Gadget mode in SPL"
> +	default y
> +	select USB_GADGET_DUALSPEED
> +	help
> +	  Enable the MTU3 peripheral controller in SPL so USB gadget
> +	  functions can use it before U-Boot proper starts.

HOST seems to be missing here ?

> +endif
> diff --git a/drivers/usb/mtu3/Makefile b/drivers/usb/mtu3/Makefile
> index 234f3a380a3..d1f0cd24875 100644
> --- a/drivers/usb/mtu3/Makefile
> +++ b/drivers/usb/mtu3/Makefile
> @@ -1,11 +1,11 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -ccflags-$(CONFIG_USB_MTU3_DEBUG)	+= -DDEBUG
> +ccflags-$(CONFIG_$(PHASE_)USB_MTU3_DEBUG)	+= -DDEBUG
>   
> -obj-$(CONFIG_USB_MTU3)	+= mtu3.o
> +obj-$(CONFIG_$(PHASE_)USB_MTU3)	+= mtu3.o
>   
>   mtu3-y	:= mtu3_plat.o
>   
> -obj-$(CONFIG_USB_MTU3_GADGET)	+= mtu3_core.o mtu3_gadget_ep0.o mtu3_gadget.o
> -obj-$(CONFIG_USB_MTU3_GADGET)	+= mtu3_qmu.o
> -obj-$(CONFIG_USB_MTU3_HOST)	+= mtu3_host.o
> +obj-$(CONFIG_$(PHASE_)USB_MTU3_GADGET) += mtu3_core.o mtu3_gadget_ep0.o
> +obj-$(CONFIG_$(PHASE_)USB_MTU3_GADGET) += mtu3_gadget.o mtu3_qmu.o
> +obj-$(CONFIG_$(PHASE_)USB_MTU3_HOST) += mtu3_host.o

[...]
