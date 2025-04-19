Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE13C369C9
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 09:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981A882385;
	Sat, 19 Apr 2025 11:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="UoMH54xS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3824982977; Sat, 19 Apr 2025 11:32:13 +0200 (CEST)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B2D81FFC
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 11:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1745055129; x=1745314329;
 bh=b1kRHEvLOOvp92la3i1wRZXiPpx+nnnMZCLJBhxiHVk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=UoMH54xS1eVpHAGqnxELXF8hi5zVsIpATbjT8m6ccR6kWmmgPRPhQMH70NtuqI948
 12uM7gqSesTEecZcekjxofL9rHVe3BQDL1oC9yurZsgJVA31C7EHHMDUHkxHsdYm8D
 XeqI2sh/UXdOHz0tD9dWY3eWn9pr5kFBJ+DNkIDt0fGjwgYx+D9mEi7rOlcokDKfu5
 BBb3ssbtSE1fE8dp8AX8pC8CPVDIcO5sPMC8CaAo3TVpzDhx6Iph0eucpUGhzlepbb
 OBdWNJiFEC6nTmSTdAhK9Eb4nGST2sx2Me9xO9KAPYOL/uqhcUuN8ZpZSgB1+R4uhm
 4g14+yHP0UP0g==
Date: Sat, 19 Apr 2025 09:32:04 +0000
To: Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 1/3] usb: udc: ci: support USB gadget driver model
Message-ID: <D9AIEUQMBE8M.2OVJ76ZRNATCM@samcday.com>
In-Reply-To: <Z__8RKVP37t6Aw1K@linaro.org>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
 <20250412-msm8916-usb-v1-1-2925239caf4b@samcday.com>
 <Z__8RKVP37t6Aw1K@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 922f2599744b5ccc0738cd8af0436b20b2f76e90
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Heya Stephan,

On Wed Apr 16, 2025 at 8:51 PM CEST, Stephan Gerhold wrote:
> On Sat, Apr 12, 2025 at 07:39:57PM +0000, Sam Day wrote:
>> When CONFIG_DM_USB_GADGET is enabled, a UCLASS_USB_GADGET_GENERIC driver
>> will be defined that wraps the ChipIdea UDC operations. The
>> (dm_)?usb_gadget_.* symbols will no longer be defined (as these are now
>> handled by the UDC uclass).
>>
>> If CONFIG_DM_USB_GADGET is not enabled, this driver behaves as it
>> previously did.
>>
>> This new driver does not declare any compatibles of its own. It requires
>> a glue driver to bind it. The ehci_msm driver will be updated in the
>> following commit to do exactly that.
>>
>> Signed-off-by: Sam Day <me@samcday.com>
>
> Thanks a lot for working on this. Seems to work without problems on my
> dragonboard410c. Just some minor nits below to reduce code duplication.

\0/ Thanks for the review and testing!

>
>> ---
>>  drivers/usb/gadget/ci_udc.c | 84 ++++++++++++++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
>> index 4bff75da759ded6716641713fbe47f6ba79386dc..179f8540da30c693d11d772a=
acc00cc37f7669c5 100644
>> --- a/drivers/usb/gadget/ci_udc.c
>> +++ b/drivers/usb/gadget/ci_udc.c
>> @@ -10,6 +10,7 @@
>>  #include <command.h>
>>  #include <config.h>
>>  #include <cpu_func.h>
>> +#include <dm.h>
>>  #include <net.h>
>>  #include <malloc.h>
>>  #include <wait_bit.h>
>> @@ -94,8 +95,18 @@ static struct usb_request *
>>  ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
>>  static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_=
req);
>>
>> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>> +static int ci_udc_gadget_start(struct usb_gadget *g,
>> +=09=09struct usb_gadget_driver *driver);
>> +static int ci_udc_gadget_stop(struct usb_gadget *g);
>> +#endif
>> +
>>  static const struct usb_gadget_ops ci_udc_ops =3D {
>>  =09.pullup =3D ci_pullup,
>> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>> +=09.udc_start =3D ci_udc_gadget_start,
>> +=09.udc_stop =3D ci_udc_gadget_stop,
>> +#endif
>>  };
>>
>>  static const struct usb_ep_ops ci_ep_ops =3D {
>> @@ -927,7 +938,7 @@ void udc_irq(void)
>>  =09}
>>  }
>>
>> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>> +static int ci_udc_handle_interrupts(struct udevice *dev)
>>  {
>>  =09struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>>  =09u32 value;
>> @@ -1072,6 +1083,71 @@ static int ci_udc_probe(void)
>>  =09return 0;
>>  }
>>
>> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>> +static int ci_udc_generic_probe(struct udevice *dev)
>> +{
>> +=09int ret;
>> +#if CONFIG_IS_ENABLED(DM_USB)
>> +=09ret =3D usb_setup_ehci_gadget(&controller.ctrl);
>> +#else
>> +=09ret =3D usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.c=
trl);
>> +#endif
>
> ...
>
>> [...]
>> +static int ci_udc_generic_remove(struct udevice *dev)
>> +{
>> +=09usb_del_gadget_udc(&controller.gadget);
>> +
>> +=09if (IS_ENABLED(CONFIG_DM_USB)) {
>> +=09=09usb_remove_ehci_gadget(&controller.ctrl);
>> +=09} else {
>> +=09=09usb_lowlevel_stop(0);
>> +=09=09controller.ctrl =3D NULL;
>> +=09}
>
> This style is nice for compile testing. But in the probe() function
> above you're still using the #if/#else pre-processor style. Can it use
> if (IS_ENABLED(...)) too?

Ah, I had converted a few of these when checkpatch reprimanded me. Guess
I missed this one - oops!

>
> =09if (IS_ENABLED(CONFIG_DM_USB))
> =09=09ret =3D usb_setup_ehci_gadget(&controller.ctrl);
> =09else
> =09=09ret =3D usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.=
ctrl);
> =09if (ret)
> =09=09return ret;
>
> This seems to compile at least.
>
> If yes, can you make the same cleanup for the old !DM_USB_GADGET case,
> so the two code paths are consistent?

Thanks, I've done this in v2.

>
>> +
>> +=09return 0;
>> +}
>> +
>> +static const struct usb_gadget_generic_ops ci_udc_generic_ops =3D {
>> +=09.handle_interrupts=09=3D ci_udc_handle_interrupts,
>> +};
>> +
>> +U_BOOT_DRIVER(ci_udc_generic) =3D {
>> +=09.name =3D "ci-udc",
>> +=09.id =3D UCLASS_USB_GADGET_GENERIC,
>> +=09.ops =3D &ci_udc_generic_ops,
>> +=09.probe =3D ci_udc_generic_probe,
>> +=09.remove =3D ci_udc_generic_remove,
>> +};
>> +
>> +static int ci_udc_gadget_start(struct usb_gadget *g,
>> +=09=09=09=09 struct usb_gadget_driver *driver)
>> +{
>> +=09controller.driver =3D driver;
>> +=09return 0;
>> +}
>> +
>> +static int ci_udc_gadget_stop(struct usb_gadget *g)
>> +{
>> +=09controller.driver =3D NULL;
>> +=09udc_disconnect();
>> +
>> +=09ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
>> +=09free(controller.items_mem);
>> +=09free(controller.epts);
>> +
>> +=09return 0;
>> +}
>
> I wonder if you could just define the start and stop function outside
> the #if blocks and call them from usb_gadget_unregister_driver()
> and usb_gadget_register_driver(). This would avoid duplicating the code,
> reducing the risk that someone forgets to update one of those when
> making changes.

So, not quite unfortunately. In the case of ci_udc_gadget_stop(), the
controller.driver =3D NULL happening before calling into udc_disconnect()
is important: the generic UDC uclass code has already called
driver->disconnect() and calling it again is a Very Bad Thing to do. So
we can't just delegate usb_gadget_unregister_driver to
ci_udc_gadget_stop outright.

In v2 I've tried to unify the codepaths as much as possible though,
both to avoid duplication and the risks of future patches making
incomplete changes.

>
> The same could be also said for probe()/remove(), i.e. moving the
>
> =09if (IS_ENABLED(CONFIG_DM_USB)) {
> =09=09usb_remove_ehci_gadget(&controller.ctrl);
> =09} else {
> =09=09usb_lowlevel_stop(0);
> =09=09controller.ctrl =3D NULL;
> =09}
>
> block to a separate function and calling that from both variants. Not
> sure if that would also be worth it?

Good call, these ones are less problematic, and I've done that in v2.

Rock on \m/,
-Sam

>
> Thanks,
> Stephan


