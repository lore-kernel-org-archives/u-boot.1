Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32DBC369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 19:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B4182F51;
	Sat, 12 Apr 2025 21:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="U9pCP1Pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17AAB82D66; Sat, 12 Apr 2025 21:40:08 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9CF82D66
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 21:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1744486799; x=1744745999;
 bh=KZU3lTGnvsCXeI5XiZfGR0LxHULIqwX4Z6phL2EmjMU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=U9pCP1PrjgH9Z0rfeFEvxEtQdAFXERDjgclPjPHnvCPhjC7bem4HWAZPWAxkOwAQW
 HovfBsR+z0Qf7YTuHlsFgfzNqQDw4VbV8KYsRdqOJxUpnaEqt83+rJhBrjz/J1jAd8
 Iyvu/qUMeZUf9rOVx+H2ukw4hjAF8AL6llbYQmV3tMXwZNRQ7IuraJtQcX5XUaF4//
 g5fOVV9yEldTF3QHsWCRZgf3mQXBZx/pOEOWuIFJElrBAtS+nRhLydOYkXy9+3w8lL
 R7UEJ6yPAxFrcTR9U0NatQJZQ4UI89NkzlOjOiEJg3k1/LokP7dnztLnLR5ZLepBbR
 /8cr/Qxd3VDwA==
Date: Sat, 12 Apr 2025 19:39:57 +0000
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 1/3] usb: udc: ci: support USB gadget driver model
Message-ID: <20250412-msm8916-usb-v1-1-2925239caf4b@samcday.com>
In-Reply-To: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: df180afabce704cdb1646d2893c88b13fecba045
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

When CONFIG_DM_USB_GADGET is enabled, a UCLASS_USB_GADGET_GENERIC driver
will be defined that wraps the ChipIdea UDC operations. The
(dm_)?usb_gadget_.* symbols will no longer be defined (as these are now
handled by the UDC uclass).

If CONFIG_DM_USB_GADGET is not enabled, this driver behaves as it
previously did.

This new driver does not declare any compatibles of its own. It requires
a glue driver to bind it. The ehci_msm driver will be updated in the
following commit to do exactly that.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/usb/gadget/ci_udc.c | 84 +++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4bff75da759ded6716641713fbe47f6ba79386dc..179f8540da30c693d11d772aacc=
00cc37f7669c5 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <config.h>
 #include <cpu_func.h>
+#include <dm.h>
 #include <net.h>
 #include <malloc.h>
 #include <wait_bit.h>
@@ -94,8 +95,18 @@ static struct usb_request *
 ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
 static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req=
);
=20
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+static int ci_udc_gadget_start(struct usb_gadget *g,
+=09=09struct usb_gadget_driver *driver);
+static int ci_udc_gadget_stop(struct usb_gadget *g);
+#endif
+
 static const struct usb_gadget_ops ci_udc_ops =3D {
 =09.pullup =3D ci_pullup,
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+=09.udc_start =3D ci_udc_gadget_start,
+=09.udc_stop =3D ci_udc_gadget_stop,
+#endif
 };
=20
 static const struct usb_ep_ops ci_ep_ops =3D {
@@ -927,7 +938,7 @@ void udc_irq(void)
 =09}
 }
=20
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+static int ci_udc_handle_interrupts(struct udevice *dev)
 {
 =09struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
 =09u32 value;
@@ -1072,6 +1083,71 @@ static int ci_udc_probe(void)
 =09return 0;
 }
=20
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+static int ci_udc_generic_probe(struct udevice *dev)
+{
+=09int ret;
+#if CONFIG_IS_ENABLED(DM_USB)
+=09ret =3D usb_setup_ehci_gadget(&controller.ctrl);
+#else
+=09ret =3D usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl=
);
+#endif
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D ci_udc_probe();
+=09if (ret)
+=09=09return ret;
+
+=09return usb_add_gadget_udc((struct device *)dev, &controller.gadget);
+}
+
+static int ci_udc_generic_remove(struct udevice *dev)
+{
+=09usb_del_gadget_udc(&controller.gadget);
+
+=09if (IS_ENABLED(CONFIG_DM_USB)) {
+=09=09usb_remove_ehci_gadget(&controller.ctrl);
+=09} else {
+=09=09usb_lowlevel_stop(0);
+=09=09controller.ctrl =3D NULL;
+=09}
+
+=09return 0;
+}
+
+static const struct usb_gadget_generic_ops ci_udc_generic_ops =3D {
+=09.handle_interrupts=09=3D ci_udc_handle_interrupts,
+};
+
+U_BOOT_DRIVER(ci_udc_generic) =3D {
+=09.name =3D "ci-udc",
+=09.id =3D UCLASS_USB_GADGET_GENERIC,
+=09.ops =3D &ci_udc_generic_ops,
+=09.probe =3D ci_udc_generic_probe,
+=09.remove =3D ci_udc_generic_remove,
+};
+
+static int ci_udc_gadget_start(struct usb_gadget *g,
+=09=09=09=09 struct usb_gadget_driver *driver)
+{
+=09controller.driver =3D driver;
+=09return 0;
+}
+
+static int ci_udc_gadget_stop(struct usb_gadget *g)
+{
+=09controller.driver =3D NULL;
+=09udc_disconnect();
+
+=09ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
+=09free(controller.items_mem);
+=09free(controller.epts);
+
+=09return 0;
+}
+
+#else
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
 =09int ret;
@@ -1126,6 +1202,12 @@ int usb_gadget_unregister_driver(struct usb_gadget_d=
river *driver)
 =09return 0;
 }
=20
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+=09return ci_udc_handle_interrupts(dev);
+}
+#endif
+
 bool dfu_usb_get_reset(void)
 {
 =09struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;

--=20
2.49.0


