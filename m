Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC63C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F48084AE9;
	Wed,  1 Jul 2026 12:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XZ4IzgSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4962D84B76; Wed,  1 Jul 2026 12:51:32 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DB184A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C324E429EA;
 Wed,  1 Jul 2026 10:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46051F00A3D;
 Wed,  1 Jul 2026 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903087;
 bh=w8p/5B8thyu9He/Pe1SzvMo98Bv8OYb1HIYc9js/Klc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=XZ4IzgSJRF6QtFhEQI06pv0SBVvhInzJQpFe2/3O2a06IdL3o78x0DNcjulxTOBgQ
 0ULxvuGd38DglIo8rkXMBVOivbdWwDIP+g3uUqnvY3Rlx9pv+KJtGezxbOg68nZsDy
 77FYe6PlCczwbmWB9sdSo3WDSrRkBJ/x9IZVZIbfXauz4wrBbvuEmIvGk7igcyonEc
 PLspRey3Hm/mgfG9J50xzDRHmXGaFsIDCQUGyJc5uX5ENMdyKxujwLSU/pRj4WYwal
 +oYDE2cCVzEFJ/77uNC5Gqm+WxA1sD+AKFs3sInINEbGWrgvxVbISwaZp/8a1mGEgt
 0En7XdwHPe+FQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, Marek
 Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andre Przywara
 <andre.przywara@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ion Agorria
 <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Jens
 Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v4 00/64]  drivers: usb: dwc3: sync code with Linux v6.16
In-Reply-To: <87zf0c6td8.fsf@kernel.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <8733y48j44.fsf@kernel.org> <87zf0c6td8.fsf@kernel.org>
Date: Wed, 01 Jul 2026 12:51:24 +0200
Message-ID: <87v7az6l03.fsf@kernel.org>
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

Hi Jens,

On Tue, Jun 30, 2026 at 15:38, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> On Tue, Jun 30, 2026 at 11:36, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
>>
>> I've tried this out on the Khadas VIM3 board using
>> khadas-vim3_android_defconfig and usb gadget (with fastboot) seems to
>> misbehave.
>>
>> With the series applied, I see:
>> """
>> U-Boot 2026.07-rc3-00064-g511db6941796 (Jun 30 2026 - 11:20:08 +0200) khadas-vim3
>>
>> Model: Khadas VIM3
>> SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
>> DRAM:  2 GiB (total 3.8 GiB)
>> Core:  408 devices, 37 uclasses, devicetree: separate
>> MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
>> Loading Environment from MMC... MMC Device -1 not found
>> *** Warning - No MMC card found, using default environment
>>
>> In:    usbkbd,serial
>> Out:   vidconsole,serial
>> Err:   vidconsole,serial
>> Net:   eth0: ethernet@ff3f0000
>>
>> Hit any key to stop autoboot: 0
>> => fastboot usb 0
>> failed to start <NULL>: -12
>> g_dnl_register: failed!, error: -12
>> exit not allowed from main input shell.
>> """
>>
>> With v2026.07-rc3, I see:
>> """
>> U-Boot 2026.07-rc3 (Jun 30 2026 - 11:24:04 +0200) khadas-vim3
>>
>> Model: Khadas VIM3
>> SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
>> DRAM:  2 GiB (total 3.8 GiB)
>> Core:  408 devices, 37 uclasses, devicetree: separate
>> MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
>> Loading Environment from MMC... MMC Device -1 not found
>> *** Warning - No MMC card found, using default environment
>>
>> In:    usbkbd,serial
>> Out:   vidconsole,serial
>> Err:   vidconsole,serial
>> Net:   eth0: ethernet@ff3f0000
>>
>> Hit any key to stop autoboot: 0
>> => fastboot usb 0
>> crq->brequest:0x0
>> """
>>
>> The failure code path seems to go through:
>> g_dnl_register("usb_dnl_fastboot");
>>   usb_composite_register(&g_dnl_driver);
>>     usb_gadget_register_driver(&composite_driver);
>>       usb_gadget_probe_driver(driver);
>>         udc_bind_to_driver(udc, driver);
>>           driver->bind(udc->gadget);
>>
>>
>> I don't know why it's happening but I wanted to give some feedback early
>> on.
>> I'll have a closer look.
>
> I spend a bit more time on this.
>
> driver->bind() calls fastboot_bind() which fails to configure the input
> endpoint with the following code:
>
> 	f_fb->in_ep = usb_ep_autoconfig(gadget, &fs_ep_in);
>
> Looking more closely at usb_ep_autoconfig():
> * in v2026.07-rc3 we have an ep_matches() that finds the relevant
>   endpoint
> * with this series, we now have usb_gadget_ep_match_desc() which does
>   not behave the same way.
>
> If i put back the original ep_matches() implementation (from
> v2026.07-rc3) and call that instead of usb_gadget_ep_match_desc() in
> usb_ep_autoconfig_ss(), I can use fastboot again.
>
> I have not studied how different ep_matches() and
> usb_gadget_ep_match_desc() are.

usb_gadget_ep_match_desc() uses the endpoint's capabilities (the cap
member of that struct) to find matching endpoints.
This is significantly different from ep_matches(), which relied on
endpoint names.

Because of this change, I had to add the following diff to
drivers/usb/gadget/dwc2_udc_otg.c:

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 9f037d1e8016..01c9a938bd79 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -741,6 +741,7 @@ static const struct usb_gadget_ops dwc2_udc_ops = {
 #endif
 };
 
 static struct dwc2_udc memory = {
        .usb_address = 0,
        .gadget = {
@@ -755,6 +756,11 @@ static struct dwc2_udc memory = {
                        .name = ep0name,
                        .ops = &dwc2_ep_ops,
                        .maxpacket = EP0_FIFO_SIZE,
+                       .caps = {
+                               .type_control = 1,
+                               .dir_in = 1,
+                               .dir_out = 1,
+                       },
                },
                .dev = &memory,
 
@@ -770,6 +776,10 @@ static struct dwc2_udc memory = {
                        .name = "ep1in-bulk",
                        .ops = &dwc2_ep_ops,
                        .maxpacket = EP_FIFO_SIZE,
+                       .caps = {
+                               .type_bulk = 1,
+                               .dir_in = 1,
+                       },
                },
                .dev = &memory,
 
@@ -785,6 +795,10 @@ static struct dwc2_udc memory = {
                        .name = "ep2out-bulk",
                        .ops = &dwc2_ep_ops,
                        .maxpacket = EP_FIFO_SIZE,
+                       .caps = {
+                               .type_bulk = 1,
+                               .dir_out = 1,
+                       },
                },
                .dev = &memory,
 
@@ -800,6 +814,10 @@ static struct dwc2_udc memory = {
                        .name = "ep3in-int",
                        .ops = &dwc2_ep_ops,
                        .maxpacket = EP_FIFO_SIZE,
+                       .caps = {
+                               .type_int = 1,
+                               .dir_in = 1,
+                       },
                },

This was not sufficient. I also had to update the .maxpacket fields to
.maxpacket_limit as following:

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 01c9a938bd79..4a62cd60cb7d 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -755,7 +755,7 @@ static struct dwc2_udc memory = {
                .ep = {
                        .name = ep0name,
                        .ops = &dwc2_ep_ops,
-                       .maxpacket = EP0_FIFO_SIZE,
+                       .maxpacket_limit = EP0_FIFO_SIZE,
                        .caps = {
                                .type_control = 1,
                                .dir_in = 1,
@@ -775,7 +775,7 @@ static struct dwc2_udc memory = {
                .ep = {
                        .name = "ep1in-bulk",
                        .ops = &dwc2_ep_ops,
-                       .maxpacket = EP_FIFO_SIZE,
+                       .maxpacket_limit = EP_FIFO_SIZE,
                        .caps = {
                                .type_bulk = 1,
                                .dir_in = 1,
@@ -794,7 +794,7 @@ static struct dwc2_udc memory = {
                .ep = {
                        .name = "ep2out-bulk",
                        .ops = &dwc2_ep_ops,
-                       .maxpacket = EP_FIFO_SIZE,
+                       .maxpacket_limit = EP_FIFO_SIZE,
                        .caps = {
                                .type_bulk = 1,
                                .dir_out = 1,
@@ -813,7 +813,7 @@ static struct dwc2_udc memory = {
                .ep = {
                        .name = "ep3in-int",
                        .ops = &dwc2_ep_ops,
-                       .maxpacket = EP_FIFO_SIZE,
+                       .maxpacket_limit = EP_FIFO_SIZE,
                        .caps = {
                                .type_int = 1,
                                .dir_in = 1,

Because this series introduces usb_gadget_ep_match_desc(), we should
make sure that all the in-tree udc drivers have these capabilities set.

In my opinion, we should do this as part of this series, otherwise we
are breaking all the UDC drivers.

Note that all drivers might not require this update, since drivers can
also implement the usb_gadget_ops.match_ep() function instead.

>
>>
>> Thanks,
>> Mattijs
>>
