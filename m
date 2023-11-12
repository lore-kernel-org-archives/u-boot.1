Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C90C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F018687134;
	Sun, 12 Nov 2023 21:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BFsSb1eI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB7987225; Sun, 12 Nov 2023 21:27:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19DC7870F2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699820852; x=1700425652; i=xypron.glpk@gmx.de;
 bh=aCdN6C9zOggWHius/cOV4SoYgcq69SGaXN/MSUe4TQY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=BFsSb1eILtbskCC/NMfLp6DTWgc21C9VqP6e2vjTv95hlIu4liAanXWKs9IsWXvH
 BCml9YDpY2UtGiZ3FGlifKtgNSfCoVos5+6Vo5TpXHjMDoVLRLBbrR4BzsJOYzdCo
 Y9RoMAzhHIuCcCgSd9C7j9r0fOX0lqaKpey0mCSZshtkGWojvjsHkoXDON5+wzDEq
 c4g2/4Fct0mmQdEuFcrR5BVfDLWQ1hGVREBMyOhzepvsOjR6NhBg9TJnPbC6ZcFOR
 FM/bBiBuc0Klbw2afw1IDypQJ9rdRCmjLkVQga/sNqxWSrRjnOh7ap6UCqdzvEEDJ
 WSRlwPlm3/A/kfIobA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1qyg0v1NeH-005m7s; Sun, 12
 Nov 2023 21:27:32 +0100
Date: Sun, 12 Nov 2023 21:27:30 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
User-Agent: K-9 Mail for Android
In-Reply-To: <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
Message-ID: <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EGJFdaG0acIZ9tGOopnR7HA/r5MsuJO8SZ5AxGuftNc5nLpzoXg
 1/S7XEe6bButR2HYJwW6iiRa1LP4IEB/6EJI5dzNbwuPbBEBOOyKLSlxBQEvda7tPkM4yoS
 SW3jA3iVdfyb1mrasJgxtuHGBDD5g9yfUTXrYUkRSu3BqGn4L4N4fylqgLG/K+m1xWkZZxk
 2L2VMbhKWReYfZlAGdwjg==
UI-OutboundReport: notjunk:1;M01:P0:l8rZwn1/gu0=;ueSmU+WWy7UwanO3PYNZZEj3saT
 TKRH3wxYI/1C+rez4QGn3puu6pqyQr/6C8ZcSQv5I0PEiw0znVpwoIltleAItRY5iBxq58pQB
 7pbfwfARprD8pXOchtBul08EfmIF0HBZrZxOoXPN7WVuhi4NXKWp6Otyyb9AThKfSnTYyKSoH
 ySz0WZAyvqPXGQULDmhy/ylr0cc7R7MWqhiuRe2xaOujjMy/NVoT/Uc4q4gGf3dwzS5dM5MVE
 jGNNZZ3/1m0A28dJSZ6pEvf31EWkIzog5jj9AoT3YMZhfTOporCTM1/vUGdyBOGEzJbp9Q5M/
 xqhu46XwmZURUIet9ET0ko/hFT08O0kiU6ykrM5nIipYGAiiEjHp3b/nkbEA6kBzJemvn+Zri
 nahxo7ncdt9RMWFHjzs6fAkLhb9XBBA8TKBC2YUlclCFCm+D+Lt7z45jlIcn3y65MSy+QeJTW
 ONjdKUhDdwvIlYapN+zzKTYsltJqQEiWUIe9G3VRR5GdudQZvgKGhma8tS7dWdhgFAudlZ7zi
 qlgGyMKE7RQ8yuADBOpYNZqnUke/R0Ytl6xBido+/xF97mRzbahEogAdPLjsaQloT1JblM84M
 NkXZhCerOB/gw383UKF7qlaFzW/B/ThjDY2mzEmWa762f7fK7vbCBh131803hUxy1imfBCPMY
 1PnWsnWjrHbsjM6FeZ6KLke9+oHVFdr6wjiLB5UNLOTsxF7LjOBcQLt2tU+FPcf8d0vGkYrBo
 tcP/LYmc21QYMfTt7OvMnrQRE3k12B3onYmX11xgy4yj4BeaIZ+7dDgirhzexy7dzg+SVmKaM
 z3Ps20YIDdsVwy5LUqBDz4x+OdCmEV+mBlqL7BOkc6DtstVNm/gQYnRDQ4JnNurQHKnWgnLLZ
 eM4oh+s0KctUYiDXxWSWidafLDrAe8AWxTU9ynJdrZK5M1T+P4DGK0VnLqRaDhiuyFxxLnhjy
 E9nv6MuAza73nn6JaG+2g3uEodE=
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



Am 12=2E November 2023 21:02:42 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>When a USB device is unbound, it causes any bootflows attached to it to
>be removed, via a call to bootdev_clear_bootflows() from
>bootdev_pre_unbind()=2E This obviously makes it impossible to boot the
>bootflow=2E
>
>However, when booting a bootflow that relies on USB, usb_stop() is
>called, which unbinds the device=2E For EFI, this happens in
>efi_exit_boot_services() which means that the bootflow disappears
>before it is finished with=2E

After ExitBootServices() no driver of U-Boot can be used as the operating =
system is in charge=2E

Any bootflow inside U-Boot is terminated by definition when reaching ExitB=
ootServices=2E

>
>There is no need to unbind all the USB devices just to quiesce them=2E
>Add a new usb_pause() call which removes them but leaves them bound=2E

As U-Boot must not access any device after ExitBootServices() it is unclea=
r to me what you want to achieve=2E

Best regards

Heinrich

>
>This resolves a hang on x86 when booting a distro from USB=2E This was
>found using a device with 4 bootflows, the last of which was USB=2E
>
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v4:
>- Don't rename the legacy-USB functions
>- Add a bit more detail to the comment
>
>Changes in v2:
>- Add new patch to avoid unbinding devices in use by bootflows
>
> boot/bootm=2Ec                  |  2 +-
> common/usb=2Ec                  |  5 +++++
> drivers/usb/host/usb-uclass=2Ec | 14 ++++++++++++--
> include/usb=2Eh                 | 21 ++++++++++++++++++++-
> 4 files changed, 38 insertions(+), 4 deletions(-)
>
>diff --git a/boot/bootm=2Ec b/boot/bootm=2Ec
>index cb61485c226c=2E=2Ed9c3fa8dad99 100644
>--- a/boot/bootm=2Ec
>+++ b/boot/bootm=2Ec
>@@ -502,7 +502,7 @@ ulong bootm_disable_interrupts(void)
> 	 * updated every 1 ms within the HCCA structure in SDRAM! For more
> 	 * details see the OpenHCI specification=2E
> 	 */
>-	usb_stop();
>+	usb_pause();
> #endif
> 	return iflag;
> }
>diff --git a/common/usb=2Ec b/common/usb=2Ec
>index 836506dcd9e9=2E=2Ea486d1c87d4d 100644
>--- a/common/usb=2Ec
>+++ b/common/usb=2Ec
>@@ -144,6 +144,11 @@ int usb_stop(void)
> 	return 0;
> }
>=20
>+int usb_pause(void)
>+{
>+	return usb_stop();
>+}
>+
> /***********************************************************************=
*******
>  * Detect if a USB device has been plugged or unplugged=2E
>  */
>diff --git a/drivers/usb/host/usb-uclass=2Ec b/drivers/usb/host/usb-uclas=
s=2Ec
>index a1cd0ad2d669=2E=2Ec26c65d7986b 100644
>--- a/drivers/usb/host/usb-uclass=2Ec
>+++ b/drivers/usb/host/usb-uclass=2Ec
>@@ -173,7 +173,7 @@ int usb_get_max_xfer_size(struct usb_device *udev, si=
ze_t *size)
> 	return ops->get_max_xfer_size(bus, size);
> }
>=20
>-int usb_stop(void)
>+static int usb_finish(bool unbind_all)
> {
> 	struct udevice *bus;
> 	struct udevice *rh;
>@@ -195,7 +195,7 @@ int usb_stop(void)
>=20
> 		/* Locate root hub device */
> 		device_find_first_child(bus, &rh);
>-		if (rh) {
>+		if (rh && unbind_all) {
> 			/*
> 			 * All USB devices are children of root hub=2E
> 			 * Unbinding root hub will unbind all of its children=2E
>@@ -222,6 +222,16 @@ int usb_stop(void)
> 	return err;
> }
>=20
>+int usb_stop(void)
>+{
>+	return usb_finish(true);
>+}
>+
>+int usb_pause(void)
>+{
>+	return usb_finish(false);
>+}
>+
> static void usb_scan_bus(struct udevice *bus, bool recurse)
> {
> 	struct usb_bus_priv *priv;
>diff --git a/include/usb=2Eh b/include/usb=2Eh
>index 09e3f0cb309c=2E=2Eb964e2e1f6b2 100644
>--- a/include/usb=2Eh
>+++ b/include/usb=2Eh
>@@ -265,7 +265,26 @@ int usb_kbd_deregister(int force);
>  */
> int usb_init(void);
>=20
>-int usb_stop(void); /* stop the USB Controller */
>+/**
>+ * usb_stop() - stop the USB Controller and unbind all USB controllers/d=
evices
>+ *
>+ * This unbinds all devices on the USB buses=2E
>+ *
>+ * Return: 0 if OK, -ve on error
>+ */
>+int usb_stop(void);
>+
>+/**
>+ * usb_pause() - stop the USB Controller DMA, etc=2E
>+ *
>+ * Note that this does not unbind bus devices, so using usb_init() after=
 this
>+ * call is not permitted=2E This function is only useful just before boo=
ting, to
>+ * ensure that devices are dormant=2E
>+ *
>+ * Return: 0 if OK, -ve on error
>+ */
>+int usb_pause(void);
>+
> int usb_detect_change(void); /* detect if a USB device has been (un)plug=
ged */
>=20
>=20
