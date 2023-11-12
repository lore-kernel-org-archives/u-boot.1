Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B24C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 23:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C8C86F7E;
	Mon, 13 Nov 2023 00:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YYnBfoia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E1F86C83; Mon, 13 Nov 2023 00:30:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BD086823
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 00:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699831807; x=1700436607; i=xypron.glpk@gmx.de;
 bh=NE6bP4ibsKXgw0SDOdY9EtBPVuVreajK9FfC0TXWK7I=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=YYnBfoiaUUl+vnEuNUSWyc23IQf/kp+nzhXq8PLs4Yiejfy+KzXNkjtKcheqk96c
 Fwqh4+6tiDROQmuprw5gOT8dmJC9276vPW8ffQoa33pFJTa6Rrsx3D9Nbt6GVrwX8
 /dCxWwNoTKii70xqHtTO9xkY6yWNmXNgJaCtKhdVuE7GvtcxAF1K/SKZDY8JQqxut
 /7aPNH8S2V86qhmBrNLgexntF1dCEnIlj2hD+OFu04kbUfKYqiquuBvclLY8QbqSz
 zlvKyosEstHVWjkcDN8LXdKlmU419UPU6nwDJ/NdWmAb+fvsIk5d2dMzshXhn3cXZ
 QeErKjDd1a35uvQ0Xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1rERNL0dAa-00CAN1; Mon, 13
 Nov 2023 00:30:07 +0100
Date: Mon, 13 Nov 2023 00:30:03 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
 <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
Message-ID: <43EF5E14-0AE3-456A-B9D4-67B8F4405555@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1vGeUdWZNZBgsBmB0AdT344V4L2GWEoc2Rp01KfKJ5R0UogTD/M
 YMSY3IeJC1mWBTmQ1ntrgZt6okkFSHgFWDQCSawHPtqgu2ch9ylT38jbXUIPPBCyzPy0Ncm
 3zw0RVmQp4HtwOsdJ0ejl+4ZMtyf776DSAAd8BU1b9rTXxFKHfWgLySwlrSROTe6+2WVOM9
 OFBaE4F+t7hH7FiRQMdJg==
UI-OutboundReport: notjunk:1;M01:P0:J/aUucCVDpo=;7wXTzA1m2o5bSC1n2iMzdXbYMGI
 zo2RfEA+RKDePRl5O6tTaDvGDkY6fCSMfgZT+JmNKd/lIukPllkdNlHV8dzy0dxCpH/NoNZjn
 eLNUpZHgZ/AwRmzjhlE3fz7sMXoROKpFbvc0jBo0p/9WBMXskStwklA+lQazRV+/tIyhZ59rt
 Xg4lz8/LEpZNq7GDy/mc+EV04vZuFOliq6PPBoM4+qKMATp9F0sEs82xJJDLUOIG5jPErFT+y
 PDQ92txu+WrPIYxGmPa1AXZFzh+6CD20nFuBd+Oy8/tIV95loqh7f3Z98QZ2XYTG+uTtOrVtY
 9UH37WwoiZuiQ88xhomjNiZl/6lcat8Baj4ymAY96iyTTLzuNO7EpZzhNqx0j/udt1l/nhQBJ
 0RYb4XI2hoz0JwRxvZj/xc+S8+VYTTP8XYSKld+3Gqkl8DzhlmLBPaR5ljjEtywi2/gIU7HcO
 VgsLKsUAPWiPDeBLiGo6BvdTX++j578130F+Ak1HaoVN0sovgx6h32Z2BdItb4BunlHKdYQjB
 G0EFvCzv74JIOGQ3ftr9ujJGrD7dkSCvzW5dK24qdPXOpztUkqHp7+mE3Ep7MWZHJTZY9fJYX
 Ba76pdQ88jhcrWYJJK+7keOerR/rULsD2JOYd48jcNKe40Wi05DaHxcyhJFZOlC++pp2VWPWy
 WRA5Msg2R+Es7BPe1Mysfih5f/KEo9uLJWzWWkIq7sbqmtqQZpP53mP0WYsH6fGZu317Inqol
 UwFHC8ds1f/neCr+WpjaGVWPJUjSpxNEgmvHeJ3ZWWvEAQvGw9RnzVZQui9Nh5woYdxoemOXD
 H/Fkq2J6grqNnPHJ/nnFuIwjaiZXLlkJAKFYjLkc/bPbqB8bgsaP2RZEpsELFojtqhugF7w6G
 EK1rFIrhZ+NNnPRRlc/gFneIxM9qoyktoYlXfqKMEQDWK0X9qjE6ch8aq46tj8vLw9kRCxIKj
 G/QAthPKTgCZlEzBc++i5MC2gsg=
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



Am 12=2E November 2023 22:20:50 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>>
>>
>> Am 12=2E November 2023 21:02:42 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >When a USB device is unbound, it causes any bootflows attached to it t=
o
>> >be removed, via a call to bootdev_clear_bootflows() from
>> >bootdev_pre_unbind()=2E This obviously makes it impossible to boot the
>> >bootflow=2E
>> >
>> >However, when booting a bootflow that relies on USB, usb_stop() is
>> >called, which unbinds the device=2E For EFI, this happens in
>> >efi_exit_boot_services() which means that the bootflow disappears
>> >before it is finished with=2E
>>
>> After ExitBootServices() no driver of U-Boot can be used as the operati=
ng system is in charge=2E
>>
>> Any bootflow inside U-Boot is terminated by definition when reaching Ex=
itBootServices=2E
>>
>> >
>> >There is no need to unbind all the USB devices just to quiesce them=2E
>> >Add a new usb_pause() call which removes them but leaves them bound=2E
>>
>> As U-Boot must not access any device after ExitBootServices() it is unc=
lear to me what you want to achieve=2E
>
>I can't remember exactly what is needed from the bootflow, but
>something is=2E Perhaps the kernel, or the cmdline, or fdt? It would
>have been better if I had mentioned this explicitly,  But then this
>patch has been sitting around for ages=2E=2E=2E
>
>In any case, the intent of exit-boot-services is not to free all the
>memory used, since some of it may have been used to hold data that the
>app continues to use=2E

The EFI application reads the memory map and receives an ID which it passe=
s to ExitBootServiced() after this point any memory not marked as EFI runti=
me can be used by the EFI app=2E This includes the memory that harbors the =
U-Boot USB drivers=2E Therefore no drivers can be used here=2E

Starting the EFI app via StartImage() must  terminate any running U-Boot "=
boot flow"=2E

After ExitBootServices() the EFI application cannot return to U-Boot excep=
t for SetVirtualAdressMspsetting which relocates the EFI runtime=2E

Bootflows and U-Boot drivers have no meaning after ExitBootServices()=2E



>
>Also there is U-Boot code between when the devices are unbound and
>when U-Boot actually exits back to the app=2E
>
>This hang was 100% repeatable on brya (an x86 Chromebook) and it took
>quite a while to find=2E

We need a better understanding of the problem that you experience to find =
an adequate solution=2E Why does removing all devices lead to hanging the s=
ystem?

Best regards

Heinrich

>
>Regards,
>Simon
>
>
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> >This resolves a hang on x86 when booting a distro from USB=2E This was
>> >found using a device with 4 bootflows, the last of which was USB=2E
>> >
>> >
>> >Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> >---
>> >
>> >Changes in v4:
>> >- Don't rename the legacy-USB functions
>> >- Add a bit more detail to the comment
>> >
>> >Changes in v2:
>> >- Add new patch to avoid unbinding devices in use by bootflows
>> >
>> > boot/bootm=2Ec                  |  2 +-
>> > common/usb=2Ec                  |  5 +++++
>> > drivers/usb/host/usb-uclass=2Ec | 14 ++++++++++++--
>> > include/usb=2Eh                 | 21 ++++++++++++++++++++-
>> > 4 files changed, 38 insertions(+), 4 deletions(-)
>> >
>> >diff --git a/boot/bootm=2Ec b/boot/bootm=2Ec
>> >index cb61485c226c=2E=2Ed9c3fa8dad99 100644
>> >--- a/boot/bootm=2Ec
>> >+++ b/boot/bootm=2Ec
>> >@@ -502,7 +502,7 @@ ulong bootm_disable_interrupts(void)
>> >        * updated every 1 ms within the HCCA structure in SDRAM! For m=
ore
>> >        * details see the OpenHCI specification=2E
>> >        */
>> >-      usb_stop();
>> >+      usb_pause();
>> > #endif
>> >       return iflag;
>> > }
>> >diff --git a/common/usb=2Ec b/common/usb=2Ec
>> >index 836506dcd9e9=2E=2Ea486d1c87d4d 100644
>> >--- a/common/usb=2Ec
>> >+++ b/common/usb=2Ec
>> >@@ -144,6 +144,11 @@ int usb_stop(void)
>> >       return 0;
>> > }
>> >
>> >+int usb_pause(void)
>> >+{
>> >+      return usb_stop();
>> >+}
>> >+
>> > /********************************************************************=
**********
>> >  * Detect if a USB device has been plugged or unplugged=2E
>> >  */
>> >diff --git a/drivers/usb/host/usb-uclass=2Ec b/drivers/usb/host/usb-uc=
lass=2Ec
>> >index a1cd0ad2d669=2E=2Ec26c65d7986b 100644
>> >--- a/drivers/usb/host/usb-uclass=2Ec
>> >+++ b/drivers/usb/host/usb-uclass=2Ec
>> >@@ -173,7 +173,7 @@ int usb_get_max_xfer_size(struct usb_device *udev,=
 size_t *size)
>> >       return ops->get_max_xfer_size(bus, size);
>> > }
>> >
>> >-int usb_stop(void)
>> >+static int usb_finish(bool unbind_all)
>> > {
>> >       struct udevice *bus;
>> >       struct udevice *rh;
>> >@@ -195,7 +195,7 @@ int usb_stop(void)
>> >
>> >               /* Locate root hub device */
>> >               device_find_first_child(bus, &rh);
>> >-              if (rh) {
>> >+              if (rh && unbind_all) {
>> >                       /*
>> >                        * All USB devices are children of root hub=2E
>> >                        * Unbinding root hub will unbind all of its ch=
ildren=2E
>> >@@ -222,6 +222,16 @@ int usb_stop(void)
>> >       return err;
>> > }
>> >
>> >+int usb_stop(void)
>> >+{
>> >+      return usb_finish(true);
>> >+}
>> >+
>> >+int usb_pause(void)
>> >+{
>> >+      return usb_finish(false);
>> >+}
>> >+
>> > static void usb_scan_bus(struct udevice *bus, bool recurse)
>> > {
>> >       struct usb_bus_priv *priv;
>> >diff --git a/include/usb=2Eh b/include/usb=2Eh
>> >index 09e3f0cb309c=2E=2Eb964e2e1f6b2 100644
>> >--- a/include/usb=2Eh
>> >+++ b/include/usb=2Eh
>> >@@ -265,7 +265,26 @@ int usb_kbd_deregister(int force);
>> >  */
>> > int usb_init(void);
>> >
>> >-int usb_stop(void); /* stop the USB Controller */
>> >+/**
>> >+ * usb_stop() - stop the USB Controller and unbind all USB controller=
s/devices
>> >+ *
>> >+ * This unbinds all devices on the USB buses=2E
>> >+ *
>> >+ * Return: 0 if OK, -ve on error
>> >+ */
>> >+int usb_stop(void);
>> >+
>> >+/**
>> >+ * usb_pause() - stop the USB Controller DMA, etc=2E
>> >+ *
>> >+ * Note that this does not unbind bus devices, so using usb_init() af=
ter this
>> >+ * call is not permitted=2E This function is only useful just before =
booting, to
>> >+ * ensure that devices are dormant=2E
>> >+ *
>> >+ * Return: 0 if OK, -ve on error
>> >+ */
>> >+int usb_pause(void);
>> >+
>> > int usb_detect_change(void); /* detect if a USB device has been (un)p=
lugged */
>> >
>> >
