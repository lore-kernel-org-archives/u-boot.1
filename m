Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18094C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CE4849A3;
	Mon, 29 Jun 2026 14:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F5Ue+SX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E49849EF; Mon, 29 Jun 2026 14:20:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E13984994
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63271417F7;
 Mon, 29 Jun 2026 12:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889A41F000E9;
 Mon, 29 Jun 2026 12:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782735643;
 bh=lJ28U2FeB/PvekXquqNbyWRahTHNw3HBUN/rbX9w6G4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=F5Ue+SX7Yg0d6p99vKvfO+WhUbBrIUUky3+wp4xs+p2rVem1msZU7xrLX/mLNoeeU
 jg4vZTj/wlzkJ4ig74xwcUcKjWbNPCktfC5JKd92z7YWQgQ9XDpvJVGb6ajPhLzkHb
 1qZdgI//taU7pF1M+eKppP408tNHqxXYJYSGV4Or4+Z0hvnlbidfx4cjf5hi3SOzuR
 1K1BAEhDMgVppdMNv+xMBCxvA6HkFFizjHjQzj0fUlctt+75kkk1bYalaNDnKPKXsU
 R4vKUa1j+sXBo03Hhp0cATIVD8hARYwL1wuqreAe/gFaRwZjKsf8eKCAN8o8olpi3n
 bhN/Vwgox5+zw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom
 Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Quentin Schulz
 <quentin.schulz@cherry.de>, Kever Yang <kever.yang@rock-chips.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, George
 Chan <gchan9527@gmail.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Petr =?utf-8?Q?Bene=C5=A1?=
 <petr.benes@ysoft.com>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, Aswin
 Murugan <aswin.murugan@oss.qualcomm.com>, Paul Sajna
 <sajattack@postmarketos.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Varadarajan Narayanan
 <varadarajan.narayanan@oss.qualcomm.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Luca
 Weiss <luca.weiss@fairphone.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH v2 1/3] usb: udc: ci: support USB gadget driver model
In-Reply-To: <20260527-msm8916-usb-v2-1-343e1e32e77b@samcday.com>
References: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
 <20260527-msm8916-usb-v2-1-343e1e32e77b@samcday.com>
Date: Mon, 29 Jun 2026 14:20:40 +0200
Message-ID: <87echpczc7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sam,

Thank you for the patch.
Sorry for the delays in the review for this one.

On Wed, May 27, 2026 at 00:37, Sam Day <me@samcday.com> wrote:

> When CONFIG_DM_USB_GADGET is enabled, a UCLASS_USB_GADGET_GENERIC driver
> will be defined that wraps the ChipIdea UDC operations. The
> (dm_)?usb_gadget_.* symbols will no longer be defined (as these are now
> handled by the UDC uclass).
>
> If CONFIG_DM_USB_GADGET is not enabled, this driver behaves as it
> previously did.
>
> This new driver does not declare any compatibles of its own. It requires
> a glue driver to bind it. The ehci_msm driver will be updated in the
> following commit to do exactly that.
>
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  drivers/usb/gadget/Kconfig  |   1 -
>  drivers/usb/gadget/ci_udc.c | 118 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 97 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 5390878254a..6ba558cc292 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -153,7 +153,6 @@ config USB_GADGET_OS_DESCRIPTORS
>  
>  config CI_UDC
>  	bool "ChipIdea device controller"
> -	depends on !DM_USB_GADGET
>  	select USB_GADGET_DUALSPEED
>  	help
>  	  Say Y here to enable device controller functionality of the
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 4729570c525..42028e11d59 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -10,6 +10,7 @@
>  #include <command.h>
>  #include <config.h>
>  #include <cpu_func.h>
> +#include <dm.h>
>  #include <net.h>
>  #include <malloc.h>
>  #include <wait_bit.h>
> @@ -94,8 +95,17 @@ static struct usb_request *
>  ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
>  static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
>  
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +static int ci_udc_gadget_start(struct usb_gadget *g, struct usb_gadget_driver *driver);
> +static int ci_udc_gadget_stop(struct usb_gadget *g);
> +#endif
> +
>  static const struct usb_gadget_ops ci_udc_ops = {
>  	.pullup = ci_pullup,
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +	.udc_start = ci_udc_gadget_start,
> +	.udc_stop = ci_udc_gadget_stop,
> +#endif
>  };
>  
>  static const struct usb_ep_ops ci_ep_ops = {
> @@ -978,7 +988,7 @@ void udc_irq(void)
>  	}
>  }
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +static int ci_udc_handle_interrupts(struct udevice *dev)
>  {
>  	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
>  	u32 value;
> @@ -1037,7 +1047,7 @@ static int ci_pullup(struct usb_gadget *gadget, int is_on)
>  static int ci_udc_probe(void)
>  {
>  	struct ept_queue_head *head;
> -	int i;
> +	int i, ret;
>  
>  	const int num = 2 * NUM_ENDPOINTS;
>  
> @@ -1046,6 +1056,14 @@ static int ci_udc_probe(void)
>  	const int eplist_raw_sz = num * sizeof(struct ept_queue_head);
>  	const int eplist_sz = roundup(eplist_raw_sz, ARCH_DMA_MINALIGN);
>  
> +	if (IS_ENABLED(CONFIG_DM_USB))
> +		ret = usb_setup_ehci_gadget(&controller.ctrl);
> +	else
> +		ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
> +
> +	if (ret)
> +		return ret;
> +

What happens if later down in ci_udc_probe() we fail to finish the
function sucessfully?
For example, memalign(ILIST_ALIGN, ILIST_SZ) can return -ENOMEM.

Doesn't that leaves us with an usb that's halfway configured?
Shouldn't we add some error handling / do some cleanup in that case?

>  	/* The QH list must be aligned to 4096 bytes. */
>  	controller.epts = memalign(eplist_align, eplist_sz);
>  	if (!controller.epts)
> @@ -1123,6 +1141,73 @@ static int ci_udc_probe(void)
>  	return 0;
>  }
>  
> +static void ci_udc_remove(void)
> +{
> +	if (IS_ENABLED(CONFIG_DM_USB)) {
> +		usb_remove_ehci_gadget(&controller.ctrl);
> +	} else {
> +		usb_lowlevel_stop(0);
> +		controller.ctrl = NULL;
> +	}
> +}
> +
> +static void ci_udc_stop(void)
> +{
> +	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
> +	free(controller.items_mem);
> +	free(controller.epts);

It feels a bit weird to free the endpoint request in stop().
Shouldn't we do this in the remove() function to match the
ci_ep_alloc_request() which is done in ci_udc_probe()?

> +}
> +
> +static int ci_udc_gadget_start(struct usb_gadget *g, struct usb_gadget_driver *driver)
> +{
> +	controller.driver = driver;
> +	return 0;
> +}

Nitpick: could we please move this next to ci_udc_gadget_stop() ?
I know this would force you to write add controller.driver = driver in
usb_gadget_register_driver() but I don't this it's a problem given that
we do something similar in usb_gadget_unregister_driver().

> +
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +static int ci_udc_generic_probe(struct udevice *dev)
> +{
> +	int ret = ci_udc_probe();
> +
> +	if (ret)
> +		return ret;
> +
> +	return usb_add_gadget_udc((struct device *)dev, &controller.gadget);
> +}
> +
> +static int ci_udc_generic_remove(struct udevice *dev)
> +{
> +	usb_del_gadget_udc(&controller.gadget);
> +
> +	ci_udc_remove();
> +
> +	return 0;
> +}
> +
> +static const struct usb_gadget_generic_ops ci_udc_generic_ops = {
> +	.handle_interrupts	= ci_udc_handle_interrupts,
> +};
> +
> +U_BOOT_DRIVER(ci_udc_generic) = {
> +	.name = "ci-udc",
> +	.id = UCLASS_USB_GADGET_GENERIC,
> +	.ops = &ci_udc_generic_ops,
> +	.probe = ci_udc_generic_probe,
> +	.remove = ci_udc_generic_remove,
> +};
> +
> +static int ci_udc_gadget_stop(struct usb_gadget *g)
> +{
> +	/* Avoid calling disconnect() twice; the UDC uclass already did it. */

There is no disconnect in udc-uclass.c? Did you mean "UDC core" here
instead of "UDC uclass" ?

> +	controller.driver = NULL;
> +	udc_disconnect();
> +
> +	ci_udc_stop();
> +
> +	return 0;
> +}
> +
> +#else
>  int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  {
>  	int ret;
> @@ -1132,14 +1217,6 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  	if (!driver->bind || !driver->setup || !driver->disconnect)
>  		return -EINVAL;
>  
> -#if CONFIG_IS_ENABLED(DM_USB)
> -	ret = usb_setup_ehci_gadget(&controller.ctrl);
> -#else
> -	ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
> -#endif
> -	if (ret)
> -		return ret;
> -
>  	ret = ci_udc_probe();
>  	if (ret) {
>  		DBG("udc probe failed, returned %d\n", ret);
> @@ -1151,7 +1228,8 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  		DBG("driver->bind() returned %d\n", ret);
>  		return ret;
>  	}
> -	controller.driver = driver;
> +
> +	ci_udc_gadget_start(&controller.gadget, driver);
>  
>  	return 0;
>  }
> @@ -1163,20 +1241,18 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>  	driver->unbind(&controller.gadget);
>  	controller.driver = NULL;
>  
> -	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
> -	free(controller.items_mem);
> -	free(controller.epts);
> -
> -#if CONFIG_IS_ENABLED(DM_USB)
> -	usb_remove_ehci_gadget(&controller.ctrl);
> -#else
> -	usb_lowlevel_stop(0);
> -	controller.ctrl = NULL;
> -#endif
> +	ci_udc_stop();
> +	ci_udc_remove();
>  
>  	return 0;
>  }
>  
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	return ci_udc_handle_interrupts(dev);
> +}
> +#endif
> +
>  bool dfu_usb_get_reset(void)
>  {
>  	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
>
> -- 
> 2.54.0
