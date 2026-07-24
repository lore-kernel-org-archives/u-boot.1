Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF52C531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 07:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC39C8112E;
	Fri, 24 Jul 2026 07:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0FOE_Yp2SKl; Fri, 24 Jul 2026 07:46:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE144810C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784879179;
	bh=xxo8RS2P0P1Rbeda6o71q7C8qtB58oteHYmbECC7R2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NEGCms/Dzo1xk2La4ZyCWC0wsqL+29TEUXB8v1Jg3vsxZsqoFTXmrdf/7NppIBAsm
	 gXj5VSyM7YEi3QAuJ8FUjf3dmliyZM15vkku52VX87lPtBP5/9CJu1hIw9okNw+Jlb
	 HVdmIVzdHTqBOgYP6N51huRn2rX6aA9IhdYWXk/bivPIwJv45G1YOPNf3jeicqPYIx
	 UgJWOQmkZOw88jB8cRJmHOWCClfNwd6Fod6yttrsUjQQ4CSVJHok+0DZIm8+sDbXOy
	 mRPrswbT0C+TUsqClGzr+rf8f8/soD4pOYbeB+5QIpB417mnFStGjymlDa9rIqw6Uc
	 KmKu5Naz+LeuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE144810C8;
	Fri, 24 Jul 2026 07:46:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B5C2490
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61480406CF
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:46:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b5rDkOCVmgww for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 07:46:17 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EB482406A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB482406A5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB482406A5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:46:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FBB9803F6; Fri, 24 Jul 2026 09:46:14 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B76800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 09:46:11 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A1FA60A5F;
 Fri, 24 Jul 2026 07:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4413C1F00A3A;
 Fri, 24 Jul 2026 07:46:09 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Quentin Schulz <quentin.schulz@cherry.de>, Kever
 Yang <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>, Balaji
 Selvanathan <balaji.selvanathan@oss.qualcomm.com>, Herve Codina
 <herve.codina@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, Stefan
 Roese <stefan.roese@mailbox.org>, Philip Molloy
 <philip.molloy@analog.com>, Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Bastien Curutchet
 <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH v3 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
In-Reply-To: <20260723-rzn1-usbf-v3-2-34dd7c4ddd99@bootlin.com>
References: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
 <20260723-rzn1-usbf-v3-2-34dd7c4ddd99@bootlin.com>
Date: Fri, 24 Jul 2026 09:46:07 +0200
Message-ID: <8733x896f4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784879170;
 bh=xxo8RS2P0P1Rbeda6o71q7C8qtB58oteHYmbECC7R2E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dM4ek8hwRTlO2QAtbljuQr7vwW7BMKF9EmKrdE/lIYpns8cIF0yo6FrSOPYguEDzR
 wscWgNJ6sA994AGsjGe1kNlxeGvhDf5FdtAF0aQl20Z6StaQYQ7kuHiv4s50Ydsu5r
 nR3dlpl08yVNVU16OHIVUvC5h32l1ijZ+MZC2oupPvB20DCBqS7dDm2/jnANu/b/WM
 kvzLwX6nop6xmH2hChqwvRmi0cqvsrw6oHce1u+Rpy/51NvOdmnT1uQxFsKAppIS2U
 LsyqadVuGDhY9kgEi64/3BYGzEn9f2AGFbTJSsjN9C8FWLdZzOF5Ax9UwsZLUaJ6kx
 l9YK0US7AvLWQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dM4ek8hw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="dM4ek8hw"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Romain,

Thank you for the patch.
I've diffed this against the linux driver, and have some comments below.

On Thu, Jul 23, 2026 at 11:09, Romain Gantois <romain.gantois@bootlin.com> =
wrote:

> From: Herve Codina <herve.codina@bootlin.com>
>
> Add support for the Renesas USBF controller. This is an USB2.0 UDC
> controller available in the RZ/N1 SoC.
>
> This driver was originally written by Herv=C3=A9 Codina for the Linux ker=
nel.
>
> Linux revision this was ported from:
>
> 74851fbb6d64 ("usb: gadget: renesas_usbf: Handle devm_pm_runtime_enable()
> errors")
>
> The following features were removed to reduce the memory footprint of the
> driver, and to avoid including features not relevant to U-Boot:
>
>  - Suspend/resume
>  - Handling of endpoints > 2
>  - Dynamic detection of endpoint DMA capability (DMA capability is
>    predetermined for each endpoint anyway).
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Co-developed-by: Romain Gantois (Schneider Electric) <romain.gantois@boot=
lin.com>
> Signed-off-by: Romain Gantois (Schneider Electric) <romain.gantois@bootli=
n.com>
> Tested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  MAINTAINERS                       |    5 +
>  drivers/usb/gadget/Kconfig        |    9 +
>  drivers/usb/gadget/Makefile       |    1 +
>  drivers/usb/gadget/renesas_usbf.c | 3118 +++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 3133 insertions(+)
>

[...]

> +};
> +
> +#define USBF_SINGLE_BUFFER 0
> +#define USBF_DOUBLE_BUFFER 1
> +#define USBF_EP_INFO(_name, _base_addr, _is_double, _maxpacket_limit)  \
> +	{                                                                     \
> +		.name            =3D _name,                                     \
> +		.base_addr       =3D _base_addr,                                \
> +		.is_double       =3D _is_double,                                \
> +		.maxpacket_limit =3D _maxpacket_limit,                          \
> +	}

When comparing with the linux driver, I've noticed that we dropped the
.caps field here.
This is fine for now, but at some point we will be updating the UDC core
in U-Boot, and capabilities might be required.

See the following for some background:
* https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-2-1352bc238c9b=
@kernel.org/
* https://lore.kernel.org/u-boot/20260629084507.3254232-1-jens.wiklander@li=
naro.org/

To be clear: I don't think you need to put endpoint capabilities back in
the driver right now, but keep this in mind once we merge the UDC core upgr=
ade.

> +
> +/* This table is computed from the recommended values provided in the SOC
> + * datasheet. The buffer type (single/double) and the endpoint type cann=
ot
> + * be changed. The mapping in internal RAM (base_addr and number of word=
s)
> + * for each endpoints depends on the max packet size and the buffer type.
> + */
> +static const struct usbf_ep_info usbf_ep_info[USBF_NUM_ENDPOINTS] =3D {
> +	/* ep0: buf @0x0000 64 bytes, fixed 32 words */
> +	[0] =3D USBF_EP_INFO("ep0-ctrl",
> +			   0x0000, USBF_SINGLE_BUFFER, USBF_EP0_MAX_PCKT_SIZE),
> +	/* ep1: buf @0x0020, 2 buffers 512 bytes -> (512 * 2 / 4) words */
> +	[1] =3D USBF_EP_INFO("ep1-bulk",
> +			   0x0020, USBF_DOUBLE_BUFFER, 512),
> +	/* ep2: buf @0x0120, 2 buffers 512 bytes -> (512 * 2 / 4) words */
> +	[2] =3D USBF_EP_INFO("ep2-bulk",
> +			   0x0120, USBF_DOUBLE_BUFFER, 512),
> +};

[..]

> +
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +}
> +
> +static void usbf_ahb_epc_irq(struct usbf_udc *udc)
> +{
> +	unsigned long flags;
> +	struct usbf_ep *epn;
> +	u32 sysbint, sysben;
> +	void (*ep_action)(struct usbf_ep *epn);
> +	int i;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +
> +	/* Read and ack interrupts */
> +	sysbint =3D usbf_reg_readl(udc, USBF_REG_AHBBINT);
> +	sysben =3D usbf_reg_readl(udc, USBF_REG_AHBBINTEN);
> +	sysbint &=3D sysben;

In the linux driver, we don't read USBF_REG_AHBBINTEN. Can you explain
why this is needed here?

> +	usbf_reg_writel(udc, USBF_REG_AHBBINT, sysbint);
> +
> +	if ((sysbint & USBF_SYS_VBUS_INT) =3D=3D USBF_SYS_VBUS_INT) {
> +		if (usbf_reg_readl(udc, USBF_REG_EPCTR) & USBF_SYS_VBUS_LEVEL) {
> +			g_dnl_clear_detach();

Why do we need to depend on g_dnl_*() ?
This is the only gadget driver that does this. It seems wrong (g_dnl* is
usually called from higher up (in u-boot commands or function drivers)

> +			spin_unlock(&udc->lock);
> +			usb_gadget_set_state(&udc->gadget, USB_STATE_POWERED);
> +			spin_lock(&udc->lock);
> +		} else {
> +			g_dnl_trigger_detach();

The linux driver has some dev_dbg() statements here. Why are they
removed?
If we want to clean up dev_dbg(), why don't we remove the others in this
function as well?

For consistency, I'd prefer for them to stay, please.

> +			spin_unlock(&udc->lock);
> +			usb_gadget_set_state(&udc->gadget,
> +					     USB_STATE_NOTATTACHED);
> +			spin_lock(&udc->lock);
> +		}
> +	}
> +
> +	for (i =3D 1; i < ARRAY_SIZE(udc->ep); i++) {
> +		if (sysbint & USBF_SYS_DMA_ENDINT_EPN(i)) {
> +			epn =3D &udc->ep[i];
> +			dev_dbg(epn->udc->dev,
> +				"ep%u handle DMA complete. action=3D%ps\n",
> +				epn->id, epn->bridge_on_dma_end);
> +			ep_action =3D epn->bridge_on_dma_end;
> +			if (ep_action) {
> +				epn->bridge_on_dma_end =3D NULL;
> +				ep_action(epn);
> +			}
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +}
> +
> +static int usbf_udc_start(struct usb_gadget *gadget,
> +			  struct usb_gadget_driver *driver)
> +{
> +	struct usbf_udc *udc =3D container_of(gadget, struct usbf_udc, gadget);
> +	unsigned long flags;

Missing dev_info() from linux here. Please keep it or justify why it
absolutely needs to be removed.

> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +
> +	/* hook up the driver */
> +	udc->driver =3D driver;
> +
> +	/* Enable VBUS interrupt */
> +	usbf_reg_writel(udc, USBF_REG_AHBBINTEN, USBF_SYS_VBUS_INTEN);
> +
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int usbf_udc_stop(struct usb_gadget *gadget)
> +{
> +	struct usbf_udc *udc =3D container_of(gadget, struct usbf_udc, gadget);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +
> +	/* Disable VBUS interrupt */
> +	usbf_reg_writel(udc, USBF_REG_AHBBINTEN, 0);
> +
> +	udc->driver =3D NULL;
> +
> +	spin_unlock_irqrestore(&udc->lock, flags);

Same here

> +
> +	return 0;
> +}
> +
> +static int usbf_get_frame(struct usb_gadget *gadget)
> +{
> +	struct usbf_udc *udc =3D container_of(gadget, struct usbf_udc, gadget);
> +
> +	return USBF_USB_GET_FRAME(usbf_reg_readl(udc, USBF_REG_USB_ADDRESS));
> +}
> +

[...]

> +
> +static struct usb_gadget_ops usbf_gadget_ops =3D {
> +	.get_frame =3D usbf_get_frame,
> +	.pullup =3D usbf_pullup,
> +	.udc_start =3D usbf_udc_start,
> +	.udc_stop =3D usbf_udc_stop,
> +};
> +
> +static int usbf_epn_check(struct usbf_ep *epn)
> +{
> +	u32 ctrl;

Why can't we keep the same error handling as linux, which contains a
dev_dbg() statement with some information about the endpoint?

> +
> +	ctrl =3D usbf_ep_reg_readl(epn, USBF_REG_EPN_CONTROL);
> +
> +	if ((ctrl & USBF_EPN_MODE_MASK) !=3D USBF_EPN_MODE_BULK) {
> +		dev_err(epn->udc->dev, "ep%u unknown type\n", epn->id);
> +		return -EINVAL;
> +	}
> +
> +	if (!(ctrl & USBF_EPN_BUF_TYPE_DOUBLE)) {
> +		dev_err(epn->udc->dev,
> +			"ep%u buffer mismatch, single expected\n",
> +			epn->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int usbf_probe(struct udevice *dev)
> +{
> +	struct usbf_udc *udc;
> +	struct usbf_ep *ep;
> +	unsigned int i;
> +	int ret;
> +
> +	udc =3D dev_get_priv(dev);
> +	udc->dev =3D dev;
> +	spin_lock_init(&udc->lock);
> +
> +	udc->regs =3D dev_read_addr_ptr(dev);
> +	if (!udc->regs)
> +		return -EINVAL;
> +
> +	/* Resetting the PLL is handled via the clock driver as it has common
> +	 * registers with USB Host
> +	 */
> +	usbf_reg_bitclr(udc, USBF_REG_EPCTR, USBF_SYS_EPC_RST);
> +
> +	/* modify in register gadget process */
> +	udc->gadget.speed =3D USB_SPEED_FULL;
> +	udc->gadget.max_speed =3D USB_SPEED_HIGH;
> +	udc->gadget.is_dualspeed =3D 1;
> +	udc->gadget.ops =3D &usbf_gadget_ops;
> +
> +	udc->gadget.name =3D dev->driver->name;
> +	udc->gadget.ep0 =3D &udc->ep[0].ep;
> +
> +	INIT_LIST_HEAD(&udc->gadget.ep_list);
> +	/* we have a canned request structure to allow sending packets as reply
> +	 * to get_status requests
> +	 */
> +	INIT_LIST_HEAD(&udc->setup_reply.queue);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(udc->ep); i++) {
> +		ep =3D &udc->ep[i];
> +
> +		ep->disabled =3D 1;

Why has the ep->disabled been moved to a an earler place compared with
linux?

In linux it's lower, part with the other assignments.

> +
> +		if (!(usbf_reg_readl(udc, USBF_REG_USBSSCONF) &
> +		      USBF_SYS_EP_AVAILABLE(i))) {
> +			continue;
> +		}
> +
> +		INIT_LIST_HEAD(&ep->queue);
> +
> +		ep->id =3D i;
