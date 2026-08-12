Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E32C5AD5A
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 02:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0F29810D2;
	Thu, 13 Aug 2026 02:22:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v3vDAHLz_2Sw; Thu, 13 Aug 2026 02:22:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4F0F80CC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786587735;
	bh=49uTPnYEInLaMh9Kyw9/PREOLpYgzHKcbc3uvj4lmrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aR0KXSYBrkwKDnRC66ezzw/997y9ICJjGqP8wgWzZZ6+Jp2KpmgyqdyFbnVp7OuYz
	 7KzueeLwYXE5sG93w7KJDCYqoxwTG7FFUiujtM+L9QpuPnwkUViMeXxb9GNCHRuGC9
	 I/dDQU/oMwSIm1nQ642Vn73kNrQ2P1/j7CwRXBIhN+uo5yxhNTtk7pIuEMEICrhmd8
	 kUmRRtbzrPu43rY0cHjUnUyb2AHx8K7+wAiCOul1mySva74VvfJ5rIDrWKLTnKOPBl
	 khXyeWmjpPOmgqmuCKK1U6NfVvBtyKm/LkcsxNjf6/MbkWIxtDTdAtX9lUN6S9k2+W
	 BspLZEvm2Wc6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4F0F80CC8;
	Thu, 13 Aug 2026 02:22:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D09F1F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 19:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AD2F80EAF
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 19:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-0kcAKk3dIi for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 19:04:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 81EE880EA3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81EE880EA3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81EE880EA3
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 19:04:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA12B84AB5; Wed, 12 Aug 2026 21:04:39 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B7A84ACA
 for <u-boot@lists.denx.de>; Wed, 12 Aug 2026 21:04:33 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c160875e029so18026466b.3
 for <u-boot@lists.denx.de>; Wed, 12 Aug 2026 12:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786561473; x=1787166273;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=49uTPnYEInLaMh9Kyw9/PREOLpYgzHKcbc3uvj4lmrU=;
 b=aZsVeoYK+nA/ig1KZnTG4tQ6/JBLeirwWTJO3qnlJtUz7wwuJj8aWDAoFYVWSrM4F8
 P9CstUskAus83OL9le+dINL2q083H5P931JsOnon1wcwc7UpEnPeTlAJvvlzCHVzYr6v
 PbzwE1b4tGhDLsP77ai4RzGtj7NSGqfWiIJuaJluLIB0okRxBIT1ZXdwTyooClMIG+dA
 yuzghC/GzthDTjGABHocwo0+/XSte5xXvsdTxtPNMhMTG9jpP7Q50fHIloo/1rQzxJtT
 gObeu4BzishtvyIaa/1uWAmPiOwcmklq7zCgE8oZ9s364xuJ1zce5C7uEd4lwIFqiKqz
 f85w==
X-Gm-Message-State: AOJu0Ywktf8T6deByatqI7MIUrS5D/p89g7mzYxFdkLKVEK2c7Jmgzjs
 ufm5ENDSpO2UNdErxbyx9dItDUNR1YRVhPRrtVFSP1FWO9ZAs5MTeT6/+CFbtzKIMK8=
X-Gm-Gg: AR+sD11MUl9MfmfQpl0s0EUTvCIfyuu3fZGT1sc0CTa8fN3KFJUdciZYQYP+BXrYd8t
 7O6hK5qEv0uk/QCl3oa9r0Ee2CDuXtDTLmNbI1uW9EvHerAtmZ/tn/VMEwGMFR86rUcl2y9oj+x
 eU8ooLQSYizfYDPpgrPfMrG5T92dF9N4jYvHNNJPibhk2HCuUTRJU5tQTlF/RnD00OF93TbZeeq
 a4s9Xtyex8WiqXQl8d/xwTIGhspeXnMsmx1RHXyq158zOhWm78oenRuQGXrmmMGM0LD9nkbnwwP
 yZwq5qJ4anf0m0T5OTQzjT9DIRbNN2Gwpnoxj80GWf4J9ezvnE8EqU8iW85lowl3LulO7GfrT8j
 kJ7qJEo24gTGQyTMB15dHCG+jm2rgJZIyHYM8Jtpk/TPY1XfJ8XSuZSi1vhs2GvOXnEcSWNVdn9
 WavI0aipCPJbWLNhBzSx9AWAP0J7Csc4PXpzHoFUiawNRJWOd4RhFIfZ5DVmdpLWYFR96aE/3nG
 mbh2NcLTkDJ1WlKFgGvcA==
X-Received: by 2002:a17:907:97ce:b0:c1f:e0fd:1140 with SMTP id
 a640c23a62f3a-c2108cfa990mr12290066b.0.1786561472785; 
 Wed, 12 Aug 2026 12:04:32 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21083fb640sm7679566b.3.2026.08.12.12.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 12:04:32 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:04:30 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, marex@denx.de, mkorpershoek@kernel.org,
 ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v5 00/75] usb: dwc3: sync code with Linux v6.16
Message-ID: <anzDvgtMh_7Fl9Ig@monster>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <178602223375.3156999.13542339251028864355.b4-review@b4>
 <anmKNYbNQ73Kv3iX@monster> <DKL6AAZWIDW6.QM05DJXDFOTN@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKL6AAZWIDW6.QM05DJXDFOTN@ti.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 13 Aug 2026 02:22:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786561473; x=1787166273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=49uTPnYEInLaMh9Kyw9/PREOLpYgzHKcbc3uvj4lmrU=;
 b=oqqLwznrrc8IuE76PaR4gQgNiqyL7WqKzi/NOxuulkUqsicEPu3z21KNk/bDdX1O7M
 EMmWV0RmDrFkHijY3U6MJL03evriL3Xw+OMhUaVs79WMxoyFk1+Bvnd4mzWz9KNXKWDA
 pD50/+6on8Opa5M4swV8YnlO/xc2ZqZ7dya6YcghWZkhcLKbxFYXTumsbwBHnZJV0pbW
 y6IiEj49cBckXe9mvgtLPcgYezoQ4f/boGZxj7tMQWIg4Wvk6deVhLDF6Dem5LwCdvUw
 kLcVpkKI5yhHQM2XIJkPFFx37YSanIhUteKRY9Mwf5GIQEB9c6SuJYhdMbJGqDp9mwNa
 WWzA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oqqLwznr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anders.roxell@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="oqqLwznr"; 
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

On 2026-08-10 15:26, Anshul Dalal wrote:
> On Mon Aug 10, 2026 at 1:52 PM IST, Anders Roxell wrote:
> > On 2026-08-06 18:47, Anshul Dalal wrote:
> >> On Thu, 16 Jul 2026 15:41:30 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> >> > [...]

[...]

> >
> > And in dwc3_gadget_uboot_handle_interrupt(), same file:
> >
> > -		struct dwc3_event_buffer *evt;
> > -		dwc3_thread_interrupt(0, dwc);
> > +		struct dwc3_event_buffer *evt = dwc->ev_buf;
> > +		dwc3_thread_interrupt(0, evt);
> 
> Thanks for the pointers Anders but I encounter a similar failure even
> with the diff you suggested. I enabled some logging for the SPL by
> defining the DEBUG macro in the following files (dfu.c spl.c spl_ram.c
> dwc3-am62.c composite.c g_dnl.c).

Hi Anshul,

Good news. I found two more bugs on top of the two I already sent you
(the event buffer and allow_connect). With all four the device
enumerates.

> 
> Failure logs:
> 
> 	U-Boot SPL 2026.07-00860-g5a9b7a715be2 (Aug 10 2026 - 15:06:27 +0530)
> 	SYSFW ABI: 4.0 (firmware rev 0x000c '12.1.0--v12.01.00 (Clever Cat)')
> 	Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'V'
> 	SPL initial stack usage: 17104 bytes
> 	SPL malloc() before relocation used 0x64d0 bytes (25 KB)
> 	>>SPL: board_init_r()
> 	spl_init
> 	Trying to boot from DFU
> 	g_dnl_register: g_dnl_driver.name = usb_dnl_dfu
> 	g_dnl_bind: gadget: 0x81c44a98 cdev: 0x81c66bc0
> 	usb_add_config: adding config #1 'usb_dnload'/81c67cc0
> 	g_dnl_do_config: configuration: 0x81c67cc0 composite dev: 0x81c66bc0
> 	adding 'dfu'/81c67d34 to config 'usb_dnload'/81c67cc0
> 	cfg 1/81c67cc0 speeds: high full
> 	usb_add_config: interface 0 = dfu/81c67d34
> 	g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
> 	usb_dnl_dfu: ready
> 
> <CTRL-C> from user
> 
> 	unbind function 'dfu'/81c67d34
> 	g_dnl_unbind: calling usb_gadget_disconnect for controller 'dwc3-gadget'
> 	Legacy image
> 	u_boot_pos = ffffffff
> 	Raw boot image support not enabled, proceeding to other boot methods
> 	Error: -22
> 	SPL: Unsupported Boot Device!
> 	SPL: failed to boot from all boot devices
> 	### ERROR ### Please RESET the board ###
> 
> Succes logs (same debug symbols ontop of main branch):
> 
> 	U-Boot SPL 2026.10-rc1-00209-g0bdd5e5daf95 (Aug 10 2026 - 14:58:28 +0530)
> 	SYSFW ABI: 4.0 (firmware rev 0x000c '12.1.0--v12.01.00 (Clever Cat)')
> 	Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'V'
> 	SPL initial stack usage: 17104 bytes
> 	SPL malloc() before relocation used 0x64d0 bytes (25 KB)
> 	>>SPL: board_init_r()
> 	spl_init
> 	Trying to boot from DFU
> 	g_dnl_register: g_dnl_driver.name = usb_dnl_dfu
> 	g_dnl_bind: gadget: 0x81c44aa4 cdev: 0x81c4af40
> 	usb_add_config: adding config #1 'usb_dnload'/81c4c040
> 	g_dnl_do_config: configuration: 0x81c4c040 composite dev: 0x81c4af40
> 	adding 'dfu'/81c4c0b4 to config 'usb_dnload'/81c4c040
> 	cfg 1/81c4c040 speeds: high full
> 	usb_add_config: interface 0 = dfu/81c4c0b4
> 	g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
> 	usb_dnl_dfu: ready
> 	composite_suspend: suspend
> 	set_config: high speed config #1: usb_dnload
> 	non-core control reqa1.03 v0000 i0000 l6
> 	non-core control req21.01 v0000 i0000 l4096
> ...(repeated)
> 	#non-core control reqa1.03 v0000 i0000 l6
> 	non-core control reqa1.03 v0000 i0000 l6
> 	DOWNLOAD ... OK
> 	Ctrl+C to exit ...
> 
> I'm not that familiar with the DW3 driver, let me know if you need me to
> test with any further changes.
> 
> >
> > evt was used there without being set as well.
> >
> > All of this is in v6 that I plan to send out. I have no AM62p and it is
> > only compile tested, so please try it on your board so we know if it
> > solves your issue before I send out v6.
> 
> I was able to reproduce the issue on beagleplay since it uses the same
> DWC3. You can try it locally if you have that board with you by
> resetting to DFU mode from U-Boot prompt:
> 
> => mw.w 43000030 53; res

I could not use the mw.w 43000030 53; res trick on the BeagleBoard-X15
that I found. But I can run DFU directly, it is the same DWC3 gadget
path you hit.

How I tested on x15:

  env set dfu_alt_info "${dfu_alt_info_ram}"
  dfu 0 ram 0

On the host dfu-util finds it:

  Found DFU: [0451:d022] ... name="kernel"/"fdt"/"ramdisk"

The two new bugs:

3. udc-core never sets dwc->async_callbacks. So the gadget setup() is
   never called and every GET_DESCRIPTOR returns -EINVAL.

4. ep0. The trb and the ep0 buffers are normal cached memory. In u-boot
   dma_alloc_coherent is not coherent, so nothing keeps them in sync with
   the controller dma. The resync dropped the manual flush and invalidate,
   so the controller reads a stale trb and stale buffers.

The patch below is only 3 and 4. Keep the first two you already have,
this goes on top. It is against v5. I built it and tested it on x15,
it works.

Can you test it on BeaglePlay with your reset trick? These fixes will
be part of the coming usb_dwc3_sync_v6 branch.

Cheers,
Anders


diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 0a4f69cbc28a..2ba05fc3f573 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -54,6 +54,9 @@ static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 	else
 		trb->ctrl |= (DWC3_TRB_CTRL_IOC
 				| DWC3_TRB_CTRL_LST);
+
+	dwc3_flush_cache((uintptr_t)buf_dma, len);
+	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
 }
 
 static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
@@ -811,6 +814,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
+	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));
+
 	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
@@ -856,6 +861,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
 	trb = dwc->ep0_trb;
 
+	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb) * 2);
+
 	r = next_request(&ep0->pending_list);
 	if (!r)
 		return;
@@ -873,6 +880,9 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 	transferred = ur->length - length;
+
+	if (ur->buf && !r->direction)
+		dwc3_invalidate_cache((uintptr_t)ur->dma, ur->length);
 	ur->actual += transferred;
 
 	if ((IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 6355931f9ff1..f03ff937dfde 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -941,6 +941,8 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
 		gadget->ops->udc_set_speed(gadget, s);
 }
 
+static inline void usb_gadget_enable_async_callbacks(struct usb_udc *udc);
+
 static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
 {
         int ret;
@@ -960,6 +962,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
                 driver->unbind(udc->gadget);
                 goto err1;
         }
+        usb_gadget_enable_async_callbacks(udc);
         udc->allow_connect = true;
         usb_gadget_connect(udc->gadget);
 
@@ -1156,6 +1159,7 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 			udc->driver->function);
 
 	udc->allow_connect = false;
+	usb_gadget_disable_async_callbacks(udc);
 	usb_gadget_disconnect(udc->gadget);
 	udc->driver->disconnect(udc->gadget);
 	udc->driver->unbind(udc->gadget);
