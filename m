Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E93CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40A084940;
	Wed, 27 May 2026 03:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="iCxA3IRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7F984855; Wed, 27 May 2026 02:37:54 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2A3846A5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 02:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1779842271; x=1780101471;
 bh=uH2IetQiQs6KznapXx8lb/l/Q/pSZfoMGRAzpvCgSMQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=iCxA3IRnQm0JX5S6AomucSgVCGSa/q29FcvDuoWzdJHL3wotP3I9P5Ej7LWg52WIJ
 GKxvOEsFMV416OuqnocHOJ60iruRMNVz7kYP5VFVfCz3hZNh53yhlQ6wqBMTPIKK7G
 UQhUafLCkl/Nvt/DX7DlDstl/RKVhS5I2hbXfzPJkFCFSEyu1taNyRGQGl/5mzfyN+
 KVEl6TW/ow7GQa0S1E4bERQXCKNr6KDZH+6FQkGVSTU/xsBa+SPDAbSTuyw+3v8oDF
 yFYZkw0StArrIyrJWEJLplhcoU8UO4r2jj/wM1d0D/X36aGKXW0xPSVSrbTVSUrhfZ
 uR9XGfZm+nNyA==
Date: Wed, 27 May 2026 00:37:46 +0000
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 =?utf-8?Q?Petr_Bene=C5=A1?= <petr.benes@ysoft.com>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Paul Sajna <sajattack@postmarketos.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Sam Day <me@samcday.com>
Subject: [PATCH v2 1/3] usb: udc: ci: support USB gadget driver model
Message-ID: <20260527-msm8916-usb-v2-1-343e1e32e77b@samcday.com>
In-Reply-To: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
References: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 8c5d72fc7fb6f954ca3738934698207dc3784a2a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 27 May 2026 03:18:29 +0200
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
 drivers/usb/gadget/Kconfig  |   1 -
 drivers/usb/gadget/ci_udc.c | 118 ++++++++++++++++++++++++++++++++++++----=
----
 2 files changed, 97 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 5390878254a..6ba558cc292 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -153,7 +153,6 @@ config USB_GADGET_OS_DESCRIPTORS
=20
 config CI_UDC
 =09bool "ChipIdea device controller"
-=09depends on !DM_USB_GADGET
 =09select USB_GADGET_DUALSPEED
 =09help
 =09  Say Y here to enable device controller functionality of the
diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4729570c525..42028e11d59 100644
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
@@ -94,8 +95,17 @@ static struct usb_request *
 ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
 static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req=
);
=20
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+static int ci_udc_gadget_start(struct usb_gadget *g, struct usb_gadget_dri=
ver *driver);
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
@@ -978,7 +988,7 @@ void udc_irq(void)
 =09}
 }
=20
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+static int ci_udc_handle_interrupts(struct udevice *dev)
 {
 =09struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
 =09u32 value;
@@ -1037,7 +1047,7 @@ static int ci_pullup(struct usb_gadget *gadget, int i=
s_on)
 static int ci_udc_probe(void)
 {
 =09struct ept_queue_head *head;
-=09int i;
+=09int i, ret;
=20
 =09const int num =3D 2 * NUM_ENDPOINTS;
=20
@@ -1046,6 +1056,14 @@ static int ci_udc_probe(void)
 =09const int eplist_raw_sz =3D num * sizeof(struct ept_queue_head);
 =09const int eplist_sz =3D roundup(eplist_raw_sz, ARCH_DMA_MINALIGN);
=20
+=09if (IS_ENABLED(CONFIG_DM_USB))
+=09=09ret =3D usb_setup_ehci_gadget(&controller.ctrl);
+=09else
+=09=09ret =3D usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.c=
trl);
+
+=09if (ret)
+=09=09return ret;
+
 =09/* The QH list must be aligned to 4096 bytes. */
 =09controller.epts =3D memalign(eplist_align, eplist_sz);
 =09if (!controller.epts)
@@ -1123,6 +1141,73 @@ static int ci_udc_probe(void)
 =09return 0;
 }
=20
+static void ci_udc_remove(void)
+{
+=09if (IS_ENABLED(CONFIG_DM_USB)) {
+=09=09usb_remove_ehci_gadget(&controller.ctrl);
+=09} else {
+=09=09usb_lowlevel_stop(0);
+=09=09controller.ctrl =3D NULL;
+=09}
+}
+
+static void ci_udc_stop(void)
+{
+=09ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
+=09free(controller.items_mem);
+=09free(controller.epts);
+}
+
+static int ci_udc_gadget_start(struct usb_gadget *g, struct usb_gadget_dri=
ver *driver)
+{
+=09controller.driver =3D driver;
+=09return 0;
+}
+
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+static int ci_udc_generic_probe(struct udevice *dev)
+{
+=09int ret =3D ci_udc_probe();
+
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
+=09ci_udc_remove();
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
+static int ci_udc_gadget_stop(struct usb_gadget *g)
+{
+=09/* Avoid calling disconnect() twice; the UDC uclass already did it. */
+=09controller.driver =3D NULL;
+=09udc_disconnect();
+
+=09ci_udc_stop();
+
+=09return 0;
+}
+
+#else
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
 =09int ret;
@@ -1132,14 +1217,6 @@ int usb_gadget_register_driver(struct usb_gadget_dri=
ver *driver)
 =09if (!driver->bind || !driver->setup || !driver->disconnect)
 =09=09return -EINVAL;
=20
-#if CONFIG_IS_ENABLED(DM_USB)
-=09ret =3D usb_setup_ehci_gadget(&controller.ctrl);
-#else
-=09ret =3D usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl=
);
-#endif
-=09if (ret)
-=09=09return ret;
-
 =09ret =3D ci_udc_probe();
 =09if (ret) {
 =09=09DBG("udc probe failed, returned %d\n", ret);
@@ -1151,7 +1228,8 @@ int usb_gadget_register_driver(struct usb_gadget_driv=
er *driver)
 =09=09DBG("driver->bind() returned %d\n", ret);
 =09=09return ret;
 =09}
-=09controller.driver =3D driver;
+
+=09ci_udc_gadget_start(&controller.gadget, driver);
=20
 =09return 0;
 }
@@ -1163,20 +1241,18 @@ int usb_gadget_unregister_driver(struct usb_gadget_=
driver *driver)
 =09driver->unbind(&controller.gadget);
 =09controller.driver =3D NULL;
=20
-=09ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
-=09free(controller.items_mem);
-=09free(controller.epts);
-
-#if CONFIG_IS_ENABLED(DM_USB)
-=09usb_remove_ehci_gadget(&controller.ctrl);
-#else
-=09usb_lowlevel_stop(0);
-=09controller.ctrl =3D NULL;
-#endif
+=09ci_udc_stop();
+=09ci_udc_remove();
=20
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
2.54.0


