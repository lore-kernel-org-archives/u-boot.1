Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613B8C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 19:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE098812F;
	Fri,  5 Apr 2024 21:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="F0DondE1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="sBVAL2Fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B8187DF3; Fri,  5 Apr 2024 21:05:42 +0200 (CEST)
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com
 [103.168.172.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FDC884B8
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 21:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=janne@jannau.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id B5C6E1380073;
 Fri,  5 Apr 2024 15:05:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 05 Apr 2024 15:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1712343936; x=1712430336; bh=j+g3mhmYqs
 xyXMEcsuyZxmVG1iSCSsV/w7wrzW6e59k=; b=F0DondE1m0DRvPPS4RfK2nGtcu
 Y5SLO/im6fiICQhdvkisneEfS1bz64D7cBso4eoWtS5litaTH8B4XtZKXDoNNSfe
 7l7m0TPyBKrjsAyS7gOfV2Z0suKRgJ6gsiKj4AJdLP8M7gpWK7mMGWpOzGk3Yd3M
 k7c0Zm5lDy22lZ/Yzb9VmYdCs/k0c5kugqleOicpN9L4mqj8dRpYP/6teccF1ZFG
 YDFuNhUtE40DYyzxf51f6AccoWzliBSUoq9L+MNolTkBCyyfNDfs986vikYX12jT
 IyXV2xrzZYxI4FeQAxcUXswK5z87gDEDK7BhrEX2XPOSJFITTGMQdY7cY+8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712343936; x=1712430336; bh=j+g3mhmYqsxyXMEcsuyZxmVG1iSC
 SsV/w7wrzW6e59k=; b=sBVAL2Fh0xeEvQSKTckRjxIe7oj9S4A99svCyafuZ5Uf
 DQL4qGELwAVSEgEnZgK24sum0myZDRzM4lLPOG6baqMtZfjmw/ErOq4ezy1Bz+rR
 cNSsXlnHlgajEM0tBMCljtEo0gU4Yn3hjEGmwPmN4E/b9WEYDeXVmpz4r3wIDARP
 19TWqWrbnNj+IBoMSRKDktRKfnuhPoFlG5lIyic5BTKj1KhD8Jl5Vf9TOqd+yhW2
 SI+OYZi7ohbh5qFqVvWzYOS9W9Il6Gufl1/FUpwfTCjSFEItTK4xhiEkrR9c4HeK
 ihx5wGcXODm+ByW1bbgrf0tBpIdzCMHOtB4K9qvqkg==
X-ME-Sender: <xms:gEsQZrKiGbqf_sBLlddkKk07_feHxQD7PykBHYgF5yg3TH3fTOPnaA>
 <xme:gEsQZvJNJOXSdzrnJ-d4ESdyOMckZT7AuQ3Jt9VhGTXRt9y-CqJaEZCibpQ9k9Kfz
 7CqoZaJj_3OM9hjQ2I>
X-ME-Received: <xmr:gEsQZjv09NyYSF7aOxZfCb_Km0b2JNkfZvzzd3awCE5ZA4mtdUeuYM6-tzYus_PkXzQC8abBOsiIhoJIVOn4ee4euZZUpEIVtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgudefhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehmtderredttdejnecuhfhrohhmpeflrghn
 nhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnh
 epgfekveetieelgeefkefhueelueegvddtuefhudeuffeigeeutdfgiefffefhkeegnecu
 ffhomhgrihhnpeguvghngidruggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepjhgrnhhnvgesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:gEsQZkZrAL3ZERmMw6iO4JyGKDGwXtnerqKWKBURrsW241JbG-C3_g>
 <xmx:gEsQZiZVWq7RW07jw53hFyKORRNmyGrcMjpr1GhaaZLSec0F4W2eyg>
 <xmx:gEsQZoAB5VjuSUSYADfxVY6GpzDceX_N0I6E6NXGBMmxjGRPEzSZEg>
 <xmx:gEsQZgY1eG02GzFrMHPGl9Ip8qd-oLroGfRXrKx9T4vK-8l6JIEOeQ>
 <xmx:gEsQZonpvvbU7XWx2ETdujDBKy4Q2i-zN0w3b7OCvr1tBiCyyQVSavbJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 15:05:35 -0400 (EDT)
Date: Fri, 5 Apr 2024 21:05:33 +0200
From: Janne Grunau <j@jannau.net>
To: Marek Vasut <marex@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v4 0/6] USB keyboard improvements for asahi / desktop
 systems
Message-ID: <ZhBLfQfxB_UEwvyY@robin>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
 <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qEwtrBI5m2hdEo53"
Content-Disposition: inline
In-Reply-To: <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de>
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


--qEwtrBI5m2hdEo53
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Apr 05, 2024 at 04:52:32PM +0200, Marek Vasut wrote:
> On 4/4/24 8:25 AM, Janne Grunau via B4 Relay wrote:
> > Apple USB Keyboards from 2021 need quirks to be useable. The boot HID
> > keyboard protocol is unfortunately not described in the first interface
> > descriptor but the second. This needs several changes. The USB keyboard
> > driver has to look at all (2) interface descriptors during probing.
> > Since I didn't want to rebuild the USB driver probe code the Apple
> > keyboards are bound to the keyboard driver via USB vendor and product
> > IDs.
> > To make the keyboards useable on Apple silicon devices the xhci driver
> > needs to initializes rings for the endpoints of the first two interface
> > descriptors. If this is causes concerns regarding regressions or memory
> > use the USB_MAX_ACTIVE_INTERFACES define could be turned into a CONFIG
> > option.
> > Even after this changes the keyboards still do not probe successfully
> > since they apparently do not behave HID standard compliant. They only
> > generate reports on key events. This leads the final check whether the
> > keyboard is operational to fail unless the user presses keys during the
> > probe. Skip this check for known keyboards.
> > Keychron seems to emulate Apple keyboards (some models even "re-use"
> > Apple's USB vendor ID) so apply this quirk as well.
> > 
> > Some devices like Yubikeys emulate a keyboard. since u-boot only binds a
> > single keyboard block this kind of devices from the USB keyboard driver.
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> 
> I picked the series, but CI indicates build errors, can you have a look ?
> 
> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20215

The issue seems to be that the field dev in struct usb_device exists
only for DM_USB. That means we can't use dev_dbg.
Either take the following fixup patch or I can resend the series.

Thanks

Janne

--qEwtrBI5m2hdEo53
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline;
	filename="0001-fixup-usb-Add-environment-based-device-ignorelist.patch"

From 57d54303eb2b60e92bd478e4250a9cc63cfc277e Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Fri, 5 Apr 2024 21:00:44 +0200
Subject: [PATCH 1/1] fixup! usb: Add environment based device ignorelist

---
 common/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/usb.c b/common/usb.c
index 44db07742e..8bc85c58b2 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -1146,7 +1146,7 @@ int usb_select_config(struct usb_device *dev)
 	err = usb_device_is_ignored(dev->descriptor.idVendor,
 				    dev->descriptor.idProduct);
 	if (err == -ENODEV) {
-		dev_dbg(dev->dev, "Ignoring USB device 0x%x:0x%x\n",
+		debug("Ignoring USB device 0x%x:0x%x\n",
 			dev->descriptor.idVendor, dev->descriptor.idProduct);
 		return err;
 	} else if (err == -EINVAL) {
-- 
2.44.0


--qEwtrBI5m2hdEo53--
