Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125B41099B3C
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 02:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFAB783FE9;
	Sat, 21 Mar 2026 03:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d9gS+ix8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6798483FA4; Sat, 21 Mar 2026 03:40:48 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C80E83F00
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 03:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fd3Zh6Dvtz9slL;
 Sat, 21 Mar 2026 03:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774060844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4asuB9Oopa7vk71l3vcG0poD3r/Kpgy9s5p4lcd0V/Y=;
 b=d9gS+ix8S+9o26z5jyVncyeQSLSPU31YAVUI5YswSTAsq1DJQPDc7K7YuD/EhCQ0NJZCH9
 XkOcschieoP2+0ZaYkjxWDUW/eXRi2tq/6Gj7Vaq8q7MkHjP7HRGK8gRlgdXZi5ZQn+Quv
 qL1Nw4bq6w2EwXd0s3TjdXjQonDQbEVhAuGuXOat8mThrlX1O4vDi2M3gpbJktaQ60aCWU
 U1VrWyo1QMMx2FgAB06fbaQQchTLPGytrWoEwJmhkoMcqaFkAPOeUpWP8ujyp8wkA6ptuJ
 F27SaKirTqUqk5WC4Iht6p1QmjPyZkI7tgr6FLg06exu/2TJZ3SZRDg/aWhGRQ==
Message-ID: <f6ffc6db-c59d-45c9-964f-7fa56c320047@mailbox.org>
Date: Sat, 21 Mar 2026 02:24:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: Correct dependencies around USB_EMUL
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260320205353.3789127-1-trini@konsulko.com>
Content-Language: en-US
Cc: Simon Glass <sjg@chromium.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260320205353.3789127-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5ac2e04c01f4899eb5a
X-MBO-RS-META: fczkhm3pfx6wg64qpzcmma3pyxhemhi7
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/20/26 9:53 PM, Tom Rini wrote:
> The symbol USB_EMUL is how sandbox has access to USB. It's
> implementation however enforces a few other requirements. It must have
> SCSI enabled, and in turn that means it must have BLK enabled. Finally,
> we should not be using SANDBOX itself as a symbol to decide what to
> build or not build here, as SANDBOX is selected for COMPILE_TEST builds
> as well and so may not have enabled the sandbox specific USB support.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> ---
>   drivers/usb/emul/Kconfig  | 2 ++
>   drivers/usb/host/Makefile | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/emul/Kconfig b/drivers/usb/emul/Kconfig
> index 279f6c6d7404..8ba372453e37 100644
> --- a/drivers/usb/emul/Kconfig
> +++ b/drivers/usb/emul/Kconfig
> @@ -1,7 +1,9 @@
>   config USB_EMUL
>   	bool "Support for USB device emulation"
>   	depends on SANDBOX
> +	select BLK

The select SCSI and Makefile change I do understand. But why do we also 
need BLK ? I can't find anything which would interact with BLK in the 
sandbox USB emulation ?

>   	select DM_USB
> +	select SCSI
>   	select USB_HOST
>   	help
>   	  Since sandbox does not have access to a real USB bus, it is possible
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index ef4ce62a680c..9cac53f07c7a 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -5,7 +5,7 @@
>   
>   ifdef CONFIG_$(PHASE_)DM_USB
>   obj-y += usb-uclass.o
> -obj-$(CONFIG_SANDBOX) += usb-sandbox.o
> +obj-$(CONFIG_USB_EMUL) += usb-sandbox.o
>   endif
>   
>   ifdef CONFIG_$(PHASE_)USB_STORAGE
