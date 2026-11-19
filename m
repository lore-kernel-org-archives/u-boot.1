Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD4606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fID82JdB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJzc3mCG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 146B4407DA;
	Thu, 19 Nov 2026 15:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fVyVunjETkJf; Thu, 19 Nov 2026 15:25:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 27FF7405B8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101900;
	b=CjEK4B5keFLrnmGMfDCsAbgpPh3RClS7ry7itB+tloJXyl0kGeWJHk0MXBg77SXlYMav
	 GivZA5IiiKs9npjbQOPqIK9Wfyi79uwprtv3f9nAqISobsMNDf+W31bZA+n7xFsCHBday
	 eY21jcWx8FCqvmJnu9NXiA16zPzMvkt7VFfVpaud2kDk4NtxZYH4orJ8cfFMmHVlDSlbq
	 MRJ/ip8h6FcqXRGIi3ok0NypOT793a74nf/pOKfHMaTCv3eQzvHUjoADoG99awvP6Vvw9
	 QNhviTYbYT4H2N6s2nWC+GbE+04HKozpdm6IM4N536VNzo/hvFDhoYqhjNz1bmY3doQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dSi2T8YtKSWEpButYhSqWbZYM5ClJYT3uxASy0p/UKI=;
	b=RtvTO0Y/TE/xLbX0WdpbONbSMRP+9InYiau1YzJmdWZw6vzgPBlPjMOVcP1zOX8x3heK
	 1xwh3jBjMLqaxd8+cxDNddo6UuwztRKTY9/0hd60halcs0ZuR0tklMuuvzLF3x2S5nW41
	 /SrFd2JA+vThEkhRel2Bzk2YQn6s+x2lsjVPZuL9mnCZYtlhIqEjoa+25IYr3lt1FIA9z
	 FUgrAYcffBiFYfhRekLyMGaeL/qgaLRPkgxwNwHArc1qj0nAht3Gs3ALr98PY5rFvX8YH
	 uK5GJFo3aWofMv3qTr4bN67Vy3jHOdrwflxfJ0pj0K2FkQOr/PWsuLW/noQVjHku5RA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101900;
	bh=dSi2T8YtKSWEpButYhSqWbZYM5ClJYT3uxASy0p/UKI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fID82JdBda2q20JVA0yqBiBQiKPISRT//n9EM043VtisEjvP5MA6yM3dVln9Zkqww
	 xPGxHmjv0rBfqDq5ndheFmpzBJKoEM/2fqZGeUgZtXYZr7JwJKlsGHS1lhmUb8VrHq
	 zk9LaXObaWZvHBBuk21R4FMSl7LyFNSrVEo6udWDPrJ0w7Nl7fiaHr09JYc1L4+qH6
	 47kpaud+gq+RcF+pVBBrmdhsNeB95XwTBqLWk18bp6MpvZ/E9+jBHKl3GdR3SgAOok
	 Ko0f0QhVf6AabEogS3JNybByPb7F/4/vfS8m2o/A3wwEQVPJP9lHHR/S9TDf8FEIlm
	 jB9s7qWLI3/GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27FF7405B8;
	Thu, 19 Nov 2026 15:25:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB0E72FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACDE760686
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swOBFtKwzE68 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1768C60ADF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=aJzc3mCG
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1768C60ADF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:24:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA27F417E1;
 Thu, 19 Nov 2026 15:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E9D1F000C4;
 Thu, 19 Nov 2026 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795101895;
 bh=dSi2T8YtKSWEpButYhSqWbZYM5ClJYT3uxASy0p/UKI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=aJzc3mCGNhmx+AOaryOMlvoXHfnD8hCyHDfVwkmKciRk+rmQE7fQoPcQDp8Vkaz3m
 1I3uUP0BlmSL/9eM7zwZdPqnCwmJtf9EFFXy/SQ7jsOq4r7l1HiFrRCWAtmpiP6c7N
 i2UIdqcCF9IdMBmoLFfyEP7XnNBk2OBFEX51ZWAuCi7py56ofPZ8oPBLxuVR+Uw8ih
 k7YHeavz2WXxapXV+imbX+nBE6MPD3MEIc6rGKAtZK32VfNznTYnrPcUtAB9F/AFCO
 1imUjyuK//dCkgq9e2WgY8MFg6wCUPSv+TKV6cHQJS1nnQCe08XN0vQpMmQu903NmC
 mSdmp04dX4seA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/14] usb: gadget: add a Qualcomm Firehose function
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Johan Jonker <jbx6244@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261106-firehose-v1-v1-1-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
 <20261106-firehose-v1-v1-1-e7591c12fc65@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:46 +0100
Message-Id: <179510188627.516692.9868947695040583618.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=23200;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=AkcVIsD3/K/f5WPPVXvSJt+s6OjH8rGGkXiaNsaIK2Q=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/xTEkafCZkI7adHW4+K56CjLuBtiFjw7zVCZ7
 28Uq7P9QluJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav8UxAAKCRAZDR20Zk4Z
 NZzKCADpGLraKYupBWj03Coo6Sn5kP/Hxbi9k0yyfBT/x+Y+YLI+T2duU5dW48an9T0on72awXD
 VSoBzrsiWIrKx4yHy9TQmodnAiyPcIuxEV/6AqhQS1W6QaPw+McuX53ue36eSM6hP01tonQ8BYe
 /fWLtvhHvt8TPg2iFZbByts2hhnQ+tJriZ1xSktTP0VbtJWWwOCYF/pLyzO6kUR7GyxoXkQPAEs
 /QBamoMKAWYTTN+ryWIZU6XOL2WMK+qy1HGZWAURk3YwvktIl97ILRWd1OLnRGcRht3zRGYzh3V
 +WGenOmqoaoRcr57oBwBopPzi6G5mGKQXsMXCQy3AmdmdF14
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

> Add a USB function speaking Qualcomm's Firehose flashing protocol, as
> used by qdl [1] in EDL mode: one XML command per bulk transfer, answered
> with <log/> and <response/> documents.
> 
> The XML parser accepts only the subset Firehose uses. This introduces
> only support for configure, power (reset) and nop cmd.
> 
> [1] https://github.com/linux-msm/qdl
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/usb/gadget/Kconfig          |   9 +
>  drivers/usb/gadget/Makefile         |   1 +
>  drivers/usb/gadget/f_firehose.c     | 611 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/firehose_parse.c | 110 +++++++
>  include/firehose.h                  |  67 ++++
>  5 files changed, 798 insertions(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index e42d5a436964..2e515f7d30e6 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -198,6 +198,15 @@ config USB_FUNCTION_MASS_STORAGE
>  	  Enable mass storage protocol support in U-Boot. It allows exporting
>  	  the eMMC/SD card content to HOST PC so it can be mounted.
>  
> +config USB_FUNCTION_FIREHOSE
> +	bool "Enable USB Qualcomm Firehose gadget"
> +	depends on BLK

Should we limit this to depend on ARCH_QUALCOMM or sandbox?
It does not seem relevant for other architectures, right?

> +	help
> +	  Enable a server for Qualcomm's Firehose flashing protocol, so that
> +	  host tools such as qdl can program a block device with the
> +	  rawprogram/patch XML files used for flashing over Emergency
> +	  Download (EDL) mode. The board picks the USB IDs.
> +
>  config USB_FUNCTION_ROCKUSB
>  	bool "Enable USB rockusb gadget"
>  	depends on ARCH_ROCKCHIP
> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
> index 9dd3abe2a5c7..ec64971e9f5c 100644
> --- a/drivers/usb/gadget/Makefile
> +++ b/drivers/usb/gadget/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_DFU_OVER_USB) += f_dfu.o
>  obj-$(CONFIG_USB_FUNCTION_MASS_STORAGE) += f_mass_storage.o
>  obj-$(CONFIG_USB_FUNCTION_SDP) += f_sdp.o
>  obj-$(CONFIG_USB_FUNCTION_ROCKUSB) += f_rockusb.o
> +obj-$(CONFIG_USB_FUNCTION_FIREHOSE) += f_firehose.o firehose_parse.o
>  obj-$(CONFIG_USB_FUNCTION_ACM)	+= f_acm.o
>  endif
>  endif
> diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
> new file mode 100644
> index 000000000000..460216a2bf81
> --- /dev/null
> +++ b/drivers/usb/gadget/f_firehose.c
> @@ -0,0 +1,611 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm Firehose flash programmer protocol over USB, as spoken by
> + * qdl (https://github.com/linux-msm/qdl)
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <blk.h>
> +#include <command.h>
> +#include <console.h>
> +#include <env.h>
> +#include <firehose.h>
> +#include <g_dnl.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <dm/device.h>
> +#include <linux/sizes.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/composite.h>
> +#include <linux/usb/gadget.h>
> +
> +#define FH_XML_SIZE		4096
> +/* Raw data transfer size, what qdl uses by default */
> +#define FH_PAYLOAD		SZ_1M
> +
> +#define FH_XML_HEADER		"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<data>\n"
> +#define FH_XML_FOOTER		"\n</data>"
> +
> +/* The handler has sent its final response itself */
> +#define FH_RESPONDED		1
> +
> +struct f_firehose {
> +	struct usb_function func;
> +	struct usb_ep *in_ep, *out_ep;
> +	struct usb_request *in_req, *out_req;
> +	unsigned int maxpacket;

Why saving this? maxpacket can be retrieved from usb_ep using
usb_endpoint_maxp()

> +	bool online;

What's online for and why it's needed?
Looking at other gadgets, such as UMS and fastboot, we don't have
similar logic in set_alt().

> +	bool in_busy;
> +	bool out_busy;

Why do we need to track if the in/out enpoints are busy?

> +	int xfer_err;
> +	bool reset;
> +
> +	struct udevice *udc;
> +	struct blk_desc *desc;
> +	void *buf;

Where is buf used? I only see it allocated in firehose_run().

> +	char rx_xml[FH_XML_SIZE + 1] __aligned(ARCH_DMA_MINALIGN);

I don't understand why rx_xml has size + 1 and tx_xml does not.

> +	char tx_xml[FH_XML_SIZE] __aligned(ARCH_DMA_MINALIGN);
> +};
> +
> +static struct f_firehose *firehose_func;
> +
> +static inline struct f_firehose *func_to_firehose(struct usb_function *f)
> +{
> +	return container_of(f, struct f_firehose, func);
> +}
> +
> +static struct usb_endpoint_descriptor fs_ep_in = {
> +	.bLength		= USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType	= USB_DT_ENDPOINT,
> +	.bEndpointAddress	= USB_DIR_IN,
> +	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize		= cpu_to_le16(64),
> +};
> +
> +static struct usb_endpoint_descriptor fs_ep_out = {
> +	.bLength		= USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType	= USB_DT_ENDPOINT,
> +	.bEndpointAddress	= USB_DIR_OUT,
> +	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize		= cpu_to_le16(64),
> +};
> +
> +static struct usb_endpoint_descriptor hs_ep_in = {
> +	.bLength		= USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType	= USB_DT_ENDPOINT,
> +	.bEndpointAddress	= USB_DIR_IN,
> +	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize		= cpu_to_le16(512),
> +};
> +
> +static struct usb_endpoint_descriptor hs_ep_out = {
> +	.bLength		= USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType	= USB_DT_ENDPOINT,
> +	.bEndpointAddress	= USB_DIR_OUT,
> +	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize		= cpu_to_le16(512),
> +};
> +
> +static struct usb_endpoint_descriptor ss_ep_in = {
> +	.bLength		= USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType	= USB_DT_ENDPOINT,
> +	.bEndpointAddress	= USB_DIR_IN,
> +	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize		= cpu_to_le16(1024),
> +};
> +
> +static struct usb_endpoint_descriptor ss_ep_out = {
> +	.bLength		= USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType	= USB_DT_ENDPOINT,
> +	.bEndpointAddress	= USB_DIR_OUT,
> +	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize		= cpu_to_le16(1024),
> +};
> +
> +static struct usb_ss_ep_comp_descriptor ss_ep_comp = {
> +	.bLength		= sizeof(ss_ep_comp),
> +	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
> +};
> +
> +static struct usb_interface_descriptor interface_desc = {
> +	.bLength		= USB_DT_INTERFACE_SIZE,
> +	.bDescriptorType	= USB_DT_INTERFACE,
> +	.bNumEndpoints		= 2,
> +	.bInterfaceClass	= USB_CLASS_VENDOR_SPEC,
> +	.bInterfaceSubClass	= 0xff,
> +	.bInterfaceProtocol	= 0xff,
> +};
> +
> +static struct usb_descriptor_header *fh_fs_function[] = {
> +	(struct usb_descriptor_header *)&interface_desc,
> +	(struct usb_descriptor_header *)&fs_ep_in,
> +	(struct usb_descriptor_header *)&fs_ep_out,
> +	NULL,
> +};
> +
> +static struct usb_descriptor_header *fh_hs_function[] = {
> +	(struct usb_descriptor_header *)&interface_desc,
> +	(struct usb_descriptor_header *)&hs_ep_in,
> +	(struct usb_descriptor_header *)&hs_ep_out,
> +	NULL,
> +};
> +
> +static struct usb_descriptor_header *fh_ss_function[] = {
> +	(struct usb_descriptor_header *)&interface_desc,
> +	(struct usb_descriptor_header *)&ss_ep_in,
> +	(struct usb_descriptor_header *)&ss_ep_comp,
> +	(struct usb_descriptor_header *)&ss_ep_out,
> +	(struct usb_descriptor_header *)&ss_ep_comp,
> +	NULL,
> +};
> +
> +static struct usb_string fh_string_defs[] = {
> +	[0].s = "Firehose",
> +	{ }
> +};
> +
> +static struct usb_gadget_strings stringtab_fh = {
> +	.language	= 0x0409,	/* en-us */
> +	.strings	= fh_string_defs,
> +};
> +
> +static struct usb_gadget_strings *fh_strings[] = {
> +	&stringtab_fh,
> +	NULL,
> +};
> +
> +static struct usb_endpoint_descriptor *
> +fh_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
> +	   struct usb_endpoint_descriptor *hs,
> +	   struct usb_endpoint_descriptor *ss)
> +{
> +	if (gadget_is_superspeed(g) && g->speed >= USB_SPEED_SUPER)
> +		return ss;
> +	if (gadget_is_dualspeed(g) && g->speed == USB_SPEED_HIGH)
> +		return hs;
> +	return fs;
> +}
> +
> +static void fh_in_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_firehose *fh = req->context;
> +
> +	fh->in_busy = false;
> +}
> +
> +static void fh_out_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_firehose *fh = req->context;
> +
> +	fh->out_busy = false;
> +}
> +
> +static int fh_bind(struct usb_configuration *c, struct usb_function *f)
> +{
> +	struct usb_gadget *gadget = c->cdev->gadget;
> +	struct f_firehose *fh = func_to_firehose(f);
> +	const char *s;

Can this be named serial? It's only used for the serial number.

> +	int id;
> +
> +	id = usb_interface_id(c, f);
> +	if (id < 0)
> +		return id;
> +	interface_desc.bInterfaceNumber = id;
> +
> +	id = usb_string_id(c->cdev);
> +	if (id < 0)
> +		return id;
> +	fh_string_defs[0].id = id;
> +	interface_desc.iInterface = id;
> +
> +	fh->in_ep = usb_ep_autoconfig(gadget, &fs_ep_in);
> +	if (!fh->in_ep)
> +		return -ENODEV;
> +	fh->in_ep->driver_data = c->cdev;
> +
> +	fh->out_ep = usb_ep_autoconfig(gadget, &fs_ep_out);
> +	if (!fh->out_ep)
> +		return -ENODEV;
> +	fh->out_ep->driver_data = c->cdev;
> +
> +	f->descriptors = fh_fs_function;
> +
> +	if (gadget_is_dualspeed(gadget)) {
> +		hs_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
> +		hs_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
> +		f->hs_descriptors = fh_hs_function;
> +	}
> +
> +	if (gadget_is_superspeed(gadget)) {
> +		ss_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
> +		ss_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
> +		f->ss_descriptors = fh_ss_function;
> +	}
> +
> +	fh->in_req = usb_ep_alloc_request(fh->in_ep, 0);
> +	fh->out_req = usb_ep_alloc_request(fh->out_ep, 0);
> +	if (!fh->in_req || !fh->out_req)

If out_req could not be allocated, we are leaking in_req here.

> +		return -ENOMEM;
> +	fh->in_req->complete = fh_in_complete;
> +	fh->in_req->context = fh;
> +	fh->out_req->complete = fh_out_complete;
> +	fh->out_req->context = fh;
> +
> +	s = env_get("serial#");
> +	if (s)
> +		g_dnl_set_serialnumber((char *)s);
> +
> +	return 0;
> +}
> +
> +static void fh_unbind(struct usb_configuration *c, struct usb_function *f)
> +{
> +	struct f_firehose *fh = func_to_firehose(f);
> +
> +	if (fh->in_req)
> +		usb_ep_free_request(fh->in_ep, fh->in_req);
> +	if (fh->out_req)
> +		usb_ep_free_request(fh->out_ep, fh->out_req);
> +	fh->in_req = NULL;
> +	fh->out_req = NULL;
> +}
> +
> +static void fh_disable(struct usb_function *f)
> +{
> +	struct f_firehose *fh = func_to_firehose(f);
> +
> +	fh->online = false;
> +	usb_ep_disable(fh->out_ep);
> +	usb_ep_disable(fh->in_ep);
> +}

Disable should be after set_alt, to match the order in fh_add()

> +
> +static int fh_set_alt(struct usb_function *f, unsigned int interface,
> +		      unsigned int alt)
> +{
> +	struct usb_gadget *gadget = f->config->cdev->gadget;
> +	struct f_firehose *fh = func_to_firehose(f);
> +	const struct usb_endpoint_descriptor *d;
> +	int ret;
> +
> +	if (fh->online)
> +		fh_disable(f);

Why do we do this? It seems weird to disable the gadget when we call
set_alt().

> +
> +	d = fh_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
> +	ret = usb_ep_enable(fh->out_ep, d);
> +	if (ret)
> +		return ret;
> +
> +	d = fh_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
> +	ret = usb_ep_enable(fh->in_ep, d);
> +	if (ret) {
> +		usb_ep_disable(fh->out_ep);
> +		return ret;
> +	}
> +
> +	fh->maxpacket = usb_endpoint_maxp(d);
> +	fh->in_busy = false;
> +	fh->out_busy = false;
> +	fh->online = true;
> +
> +	return 0;
> +}
> +
> +static int fh_add(struct usb_configuration *c)
> +{
> +	struct f_firehose *fh = firehose_func;
> +
> +	memset(&fh->func, 0, sizeof(fh->func));
> +	fh->func.name = "f_firehose";
> +	fh->func.bind = fh_bind;
> +	fh->func.unbind = fh_unbind;
> +	fh->func.set_alt = fh_set_alt;
> +	fh->func.disable = fh_disable;
> +	fh->func.strings = fh_strings;
> +
> +	return usb_add_function(c, &fh->func);
> +}
> +
> +DECLARE_GADGET_BIND_CALLBACK(usb_dnl_firehose, fh_add);
> +
> +static int fh_wait(struct f_firehose *fh, bool *busy, struct usb_request *req)
> +{
> +	int ret;
> +
> +	while (*busy) {
> +		if (ctrlc()) {
> +			fh->xfer_err = -EINTR;
> +			return -EINTR;
> +		}
> +		if (!fh->online) {
> +			fh->xfer_err = -ESHUTDOWN;
> +			return -ESHUTDOWN;
> +		}
> +		dm_usb_gadget_handle_interrupts(fh->udc);
> +	}
> +
> +	/* Report a failed request only once */
> +	ret = req->status;
> +	req->status = 0;
> +	if (ret)
> +		fh->xfer_err = ret;
> +
> +	return ret;
> +}

This and all the functions below seem to be more protocol than gadget
driver so to speak. Fastboot has fb_command and such for this.

Have we considered splitting this out to a different file, to separate
pure gadget function driver versus protocol/session handling?

Or maybe at least to a different commit, to make it a bit easier to
review.

> +
> +static int fh_tx_flush(struct f_firehose *fh)
> +{
> +	return fh_wait(fh, &fh->in_busy, fh->in_req);
> +}
> +
> +static int fh_tx_queue(struct f_firehose *fh, void *buf, size_t len)
> +{
> +	int ret;
> +
> +	ret = fh_tx_flush(fh);
> +	if (ret)
> +		return ret;
> +
> +	fh->in_req->buf = buf;
> +	fh->in_req->length = len;
> +	fh->in_busy = true;
> +	ret = usb_ep_queue(fh->in_ep, fh->in_req, 0);
> +	if (ret) {
> +		fh->in_busy = false;
> +		fh->xfer_err = ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * The host follows every write that is a multiple of maxpacket with a ZLP,
> + * which can complete the next request on its own: requeue it.
> + *
> + * Return: number of bytes received or negative error code
> + */
> +static int fh_rx(struct f_firehose *fh, void *buf, size_t len)
> +{
> +	int ret;
> +
> +	fh->out_req->buf = buf;
> +	fh->out_req->length = roundup(len, fh->maxpacket);
> +	do {
> +		fh->out_busy = true;
> +		ret = usb_ep_queue(fh->out_ep, fh->out_req, 0);
> +		if (ret) {
> +			fh->out_busy = false;
> +			fh->xfer_err = ret;
> +			return ret;
> +		}
> +		ret = fh_wait(fh, &fh->out_busy, fh->out_req);
> +		if (ret)
> +			return ret;
> +	} while (!fh->out_req->actual);
> +
> +	return fh->out_req->actual;
> +}
> +
> +static int __printf(2, 3) fh_send_xml(struct f_firehose *fh,
> +				      const char *fmt, ...)
> +{
> +	size_t hlen = strlen(FH_XML_HEADER);
> +	size_t flen = strlen(FH_XML_FOOTER);
> +	char *p = fh->tx_xml;
> +	va_list args;
> +	size_t len;
> +	int ret;
> +
> +	ret = fh_tx_flush(fh);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(p, FH_XML_HEADER, hlen);
> +	va_start(args, fmt);
> +	len = vscnprintf(p + hlen, FH_XML_SIZE - hlen - flen - 1, fmt, args);
> +	va_end(args);
> +	memcpy(p + hlen + len, FH_XML_FOOTER, flen);
> +	len += hlen + flen;
> +
> +	/* Avoid a ZLP, the host would merge this with the next document */
> +	if (!(len % fh->maxpacket))
> +		p[len++] = '\n';
> +
> +	return fh_tx_queue(fh, p, len);
> +}
> +
> +static int fh_respond(struct f_firehose *fh, bool ack, bool rawmode)
> +{
> +	return fh_send_xml(fh, "<response value=\"%s\" rawmode=\"%s\" />",
> +			   ack ? "ACK" : "NAK", rawmode ? "true" : "false");
> +}
> +
> +/* Messages are fixed strings and numbers, no XML escaping needed */
> +static int __printf(3, 4) fh_log(struct f_firehose *fh, bool err,
> +				 const char *fmt, ...)
> +{
> +	char msg[256];
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vscnprintf(msg, sizeof(msg), fmt, args);
> +	va_end(args);
> +
> +	if (err)
> +		log_err("firehose: %s\n", msg);
> +
> +	return fh_send_xml(fh, "<log value=\"%s%s\" />", err ? "ERROR: " : "",
> +			   msg);
> +}
> +
> +static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
> +{
> +	const char *memory = firehose_attr(cmd, "MemoryName");
> +	const char *name;
> +	int ret;
> +
> +	switch (fh->desc->uclass_id) {
> +	case UCLASS_MMC:
> +		name = "eMMC";
> +		break;
> +	case UCLASS_SCSI:
> +		name = "UFS";
> +		break;
> +	case UCLASS_NVME:
> +		name = "NVMe";
> +		break;
> +	default:
> +		name = blk_get_uclass_name(fh->desc->uclass_id);
> +		break;
> +	}
> +
> +	/* qdl gives up on a NAK without the payload attributes */
> +	if (memory && strcasecmp(memory, name)) {
> +		fh_log(fh, true, "MemoryName does not match the device (%s)",
> +		       name);
> +		return -EINVAL;
> +	}
> +
> +	/* A host that asked for another size adopts the supported one */
> +	ret = fh_send_xml(fh,
> +			  "<response value=\"ACK\" MinVersionSupported=\"1\" "
> +			  "Version=\"1\" MemoryName=\"%s\" TargetName=\"U-Boot\" "
> +			  "MaxPayloadSizeToTargetInBytes=\"%u\" "
> +			  "MaxPayloadSizeToTargetInBytesSupported=\"%u\" "
> +			  "MaxPayloadSizeFromTargetInBytes=\"%u\" "
> +			  "MaxXMLSizeInBytes=\"%u\" />",
> +			  name, FH_PAYLOAD, FH_PAYLOAD, FH_PAYLOAD, FH_XML_SIZE);
> +
> +	return ret ?: FH_RESPONDED;
> +}
> +
> +static int fh_power(struct f_firehose *fh, struct firehose_cmd *cmd)
> +{
> +	const char *value = firehose_attr(cmd, "value");
> +
> +	if (!value || strcasecmp(value, "reset")) {
> +		fh_log(fh, true, "only power reset is supported");
> +		return -EINVAL;
> +	}
> +
> +	fh->reset = true;
> +
> +	return 0;
> +}
> +
> +static int fh_nop(struct f_firehose *fh, struct firehose_cmd *cmd)
> +{
> +	return 0;
> +}
> +
> +static const struct {
> +	const char *tag;
> +	int (*handle)(struct f_firehose *fh, struct firehose_cmd *cmd);
> +} fh_handlers[] = {
> +	{ "configure", fh_configure },
> +	{ "power", fh_power },
> +	{ "nop", fh_nop },
> +};
> +
> +static int fh_handle(struct f_firehose *fh, char *xml)
> +{
> +	struct firehose_cmd cmd;
> +	int i, ret;
> +
> +	/* Also qdl's Sahara probe: the reply tells it to skip Sahara */
> +	if (firehose_parse(xml, &cmd)) {
> +		fh_log(fh, false, "ERROR: malformed XML command");
> +		return fh_respond(fh, false, false);
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(fh_handlers); i++)
> +		if (!strcasecmp(cmd.tag, fh_handlers[i].tag))
> +			break;
> +
> +	if (i == ARRAY_SIZE(fh_handlers)) {
> +		fh_log(fh, true, "unsupported command %s", cmd.tag);
> +		return fh_respond(fh, false, false);
> +	}
> +
> +	ret = fh_handlers[i].handle(fh, &cmd);
> +	if (fh->xfer_err)
> +		return fh->xfer_err;
> +	if (ret == FH_RESPONDED)
> +		return 0;
> +
> +	return fh_respond(fh, !ret, false);
> +}
> +
> +static int fh_session(struct f_firehose *fh)
> +{
> +	int ret;
> +
> +	while (!fh->online) {
> +		if (ctrlc())
> +			return -EINTR;
> +		dm_usb_gadget_handle_interrupts(fh->udc);
> +	}
> +
> +	fh->xfer_err = 0;
> +
> +	/* An XML first message tells the host to skip Sahara */
> +	ret = fh_log(fh, false, "U-Boot Firehose, %llu sectors of %lu bytes",
> +		     (u64)fh->desc->lba, fh->desc->blksz);
> +
> +	while (!ret && !fh->reset) {
> +		ret = fh_rx(fh, fh->rx_xml, FH_XML_SIZE);
> +		if (ret < 0)
> +			break;
> +		fh->rx_xml[ret] = '\0';
> +		fh->xfer_err = 0;
> +		ret = fh_handle(fh, fh->rx_xml);
> +	}
> +
> +	return ret ?: fh_tx_flush(fh);
> +}
> +
> +int firehose_run(struct udevice *udc, struct blk_desc *desc)
> +{
> +	struct f_firehose *fh;
> +	int ret;
> +
> +	if (FH_PAYLOAD % desc->blksz)
> +		return -EINVAL;
> +
> +	fh = memalign(ARCH_DMA_MINALIGN, sizeof(*fh));
> +	if (!fh)
> +		return -ENOMEM;
> +	memset(fh, 0, sizeof(*fh));
> +	fh->udc = udc;
> +	fh->desc = desc;
> +	fh->buf = memalign(ARCH_DMA_MINALIGN, FH_PAYLOAD);
> +	if (!fh->buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	firehose_func = fh;
> +	g_dnl_clear_detach();
> +	ret = g_dnl_register("usb_dnl_firehose");
> +	if (ret)
> +		goto out;
> +
> +	do {
> +		ret = fh_session(fh);
> +	} while (ret != -EINTR && !fh->reset);
> +
> +	g_dnl_unregister();
> +	g_dnl_clear_detach();
> +
> +	if (fh->reset)
> +		do_reset(NULL, 0, 0, NULL);
> +
> +	ret = ret == -EINTR ? 0 : ret;
> +out:
> +	firehose_func = NULL;
> +	free(fh->buf);
> +	free(fh);
> +
> +	return ret;
> +}
> diff --git a/drivers/usb/gadget/firehose_parse.c b/drivers/usb/gadget/firehose_parse.c
> new file mode 100644
> index 000000000000..89e47659fb23
> --- /dev/null
> +++ b/drivers/usb/gadget/firehose_parse.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm Firehose command parser
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <firehose.h>
> +#include <linux/ctype.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +
> +static char *fh_skip_ws(char *p)
> +{
> +	while (*p == ' ' || *p == '\t' || *p == '\r' || *p == '\n')
> +		p++;
> +	return p;
> +}
> +
> +static char *fh_parse_name(char *p)
> +{
> +	if (!isalpha(*p) && *p != '_')
> +		return NULL;
> +	while (isalnum(*p) || *p == '_' || *p == '-' || *p == '.' || *p == ':')
> +		p++;
> +	return p;
> +}
> +
> +/*
> + * XML subset, parsed in place: an optional declaration and one
> + * self-closing element inside <data>, values without entities:
> + *   <?xml version="1.0" ?><data><program A="v" B='w' /></data>
> + */
> +int firehose_parse(char *p, struct firehose_cmd *cmd)
> +{
> +	char *end;
> +
> +	memset(cmd, 0, sizeof(*cmd));
> +
> +	p = fh_skip_ws(p);
> +	if (!strncmp(p, "<?xml", 5)) {
> +		p = strstr(p, "?>");
> +		if (!p)
> +			return -EINVAL;
> +		p = fh_skip_ws(p + 2);
> +	}
> +	if (strncmp(p, "<data>", 6))
> +		return -EINVAL;
> +	p = fh_skip_ws(p + 6);
> +	if (*p++ != '<')
> +		return -EINVAL;
> +	end = fh_parse_name(p);
> +	if (!end)
> +		return -EINVAL;
> +	cmd->tag = p;
> +
> +	for (;;) {
> +		struct firehose_attr *attr;
> +		char quote;
> +
> +		p = fh_skip_ws(end);
> +		if (*p == '/') {
> +			*end = '\0';
> +			break;
> +		}
> +		if (p == end || cmd->num_attrs == FIREHOSE_MAX_ATTRS)
> +			return -EINVAL;
> +		*end = '\0';
> +
> +		attr = &cmd->attr[cmd->num_attrs++];
> +		end = fh_parse_name(p);
> +		if (!end)
> +			return -EINVAL;
> +		attr->name = p;
> +		p = fh_skip_ws(end);
> +		if (*p != '=')
> +			return -EINVAL;
> +		*end = '\0';
> +
> +		p = fh_skip_ws(p + 1);
> +		quote = *p;
> +		if (quote != '"' && quote != '\'')
> +			return -EINVAL;
> +		attr->value = ++p;
> +		end = strchr(p, quote);
> +		if (!end || strcspn(p, "<&") < end - p)
> +			return -EINVAL;
> +		*end++ = '\0';
> +	}
> +
> +	if (p[1] != '>')
> +		return -EINVAL;
> +	p = fh_skip_ws(p + 2);
> +	if (strncmp(p, "</data>", 7))
> +		return -EINVAL;
> +
> +	return 0;
> +}

This seems quite brittle/difficult to get right. Should we add unit
tests with various examples of valid/invalid firehose XML to validate
the parser logic?

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
