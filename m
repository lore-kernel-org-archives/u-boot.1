Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FD0C67861
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 20:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0169287FCD;
	Sat,  6 Apr 2024 22:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="LGaHRQnX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="rO3r1/IM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934AA87FE8; Sat,  6 Apr 2024 22:04:41 +0200 (CEST)
Received: from fhigh5-smtp.messagingengine.com
 (fhigh5-smtp.messagingengine.com [103.168.172.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8609B87F3B
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 22:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=janne@jannau.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 3803C11400AB;
 Sat,  6 Apr 2024 16:04:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sat, 06 Apr 2024 16:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1712433877; x=1712520277; bh=4CNQC1EXj4
 5VVWyOy7VWWWAsllryoT2wjwpalUp2rIs=; b=LGaHRQnXsAu6glJIxqpoETzm3E
 Brh8Xwl8ln5SPgYjYMjsDQ4DxOdm2/kcRSB2Ymk/BrdSmPWokgcp0BSWzK8+zukT
 Zog+w3yLA1A+CTxbwRWKrPA4aNJCaNpJzedEySnQDA2kPxq/ZfJOYDOd7nYNKF/v
 BaBeOSkrsSAU3Y16yypG9unUzk/sh3wl7GKoGwiCztvK3w1uMh6MW4fvCW1/9afJ
 YUMm2iFySUDA1MJuIZYkV6dJ2bFssYWFUHdRSp9TG62UMh9Y8+3KB+BbLMd+aWSp
 6lwjVn5TE+0BmwUDd8cbO2GolZLpyBCx48zxobS1mH1uNDYoUtNk1VtnBYVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712433877; x=1712520277; bh=4CNQC1EXj45VVWyOy7VWWWAsllry
 oT2wjwpalUp2rIs=; b=rO3r1/IMJ2AnV/ADxQ69b0Iu1NeFlC4JIDY01s8D/Uq/
 3TXF02IM1o+lJIJViVixWDmA/dDYS5nHNpDNOCZ9ywAJoSPeiE2J2Q2W1jVY4XpL
 p5ZzAXPB9//zT6a8wSDhAQoNXhC5CuYEfC+qcGWYqN6DHg1Ab1YVemYibMY9An1y
 vHM7YkWEN8ABPTZTpsbsEcX+a4DUWQsuqH88sNfxCtagEIPTqlHLJY7rNt1mp9xj
 YDQesS8vjCF9FGTkD8KRD0mBogQTtMbq7dK53uwn/gjaV/7WTu1bqHsblQYZpBnG
 0wNPyW9+vw/Enwb5+BVrv5rkhx5KToirvKrbEdqmqw==
X-ME-Sender: <xms:1KoRZh5kInemU_XPcf58VLgoQFixJmWU73F50IShpVmnoVoeg-I8vg>
 <xme:1KoRZu6wNTeOZtAhbPN2NUvDpQ81l3isVXxCpN_U8172d7Tnv43ugYjAaoZs9gbgB
 elQWLyTcEb9BNxnSp8>
X-ME-Received: <xmr:1KoRZoeBmjX57Q64YTRy6VaaOzj5Rp7xe6cXujLE1RqbBNIMbvykStDFzqcrof51Xwm8gkcMGxFARksL5dXpB2ftATQXWvNkfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegvddgudegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehmtderredttdejnecuhfhrohhmpeflrghn
 nhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnh
 epgfekveetieelgeefkefhueelueegvddtuefhudeuffeigeeutdfgiefffefhkeegnecu
 ffhomhgrihhnpeguvghngidruggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepjhgrnhhnvgesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:1KoRZqLcf2LSv5ldZ6cFCs2WcdyHjHdWnq_OGqZmEbgDMNjkdV0OOA>
 <xmx:1KoRZlJBRu5hgxD_V4ORDXmUizdmT50oxC40QzVTzc8FXoJSjApamQ>
 <xmx:1KoRZjwYGGc7ibkGqbAk4v2jUQ_jvLAxWve4SDXDcX_U4y1cpTzXqA>
 <xmx:1KoRZhLL9Vxvxf4YUfu9VgQtZyBiMFplIEjoY4JQpNlzF80dV3NXaQ>
 <xmx:1aoRZuVprdipdND0rIQ2FfY83iYJWQWI6NxwTmmkkoh2bhrcJG-wRdCJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Apr 2024 16:04:35 -0400 (EDT)
Date: Sat, 6 Apr 2024 22:04:33 +0200
From: Janne Grunau <j@jannau.net>
To: Marek Vasut <marex@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v4 0/6] USB keyboard improvements for asahi / desktop
 systems
Message-ID: <ZhGq0U_pkrYMe4S1@robin>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
 <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de>
 <ZhBLfQfxB_UEwvyY@robin>
 <5467f380-de35-4776-8c32-90b8e08aeda7@denx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qAvU1m4dKXDhn5xe"
Content-Disposition: inline
In-Reply-To: <5467f380-de35-4776-8c32-90b8e08aeda7@denx.de>
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


--qAvU1m4dKXDhn5xe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Apr 06, 2024 at 08:52:17PM +0200, Marek Vasut wrote:
> On 4/5/24 9:05 PM, Janne Grunau wrote:
> > On Fri, Apr 05, 2024 at 04:52:32PM +0200, Marek Vasut wrote:
> >> On 4/4/24 8:25 AM, Janne Grunau via B4 Relay wrote:
> >>> Apple USB Keyboards from 2021 need quirks to be useable. The boot HID
> >>> keyboard protocol is unfortunately not described in the first interface
> >>> descriptor but the second. This needs several changes. The USB keyboard
> >>> driver has to look at all (2) interface descriptors during probing.
> >>> Since I didn't want to rebuild the USB driver probe code the Apple
> >>> keyboards are bound to the keyboard driver via USB vendor and product
> >>> IDs.
> >>> To make the keyboards useable on Apple silicon devices the xhci driver
> >>> needs to initializes rings for the endpoints of the first two interface
> >>> descriptors. If this is causes concerns regarding regressions or memory
> >>> use the USB_MAX_ACTIVE_INTERFACES define could be turned into a CONFIG
> >>> option.
> >>> Even after this changes the keyboards still do not probe successfully
> >>> since they apparently do not behave HID standard compliant. They only
> >>> generate reports on key events. This leads the final check whether the
> >>> keyboard is operational to fail unless the user presses keys during the
> >>> probe. Skip this check for known keyboards.
> >>> Keychron seems to emulate Apple keyboards (some models even "re-use"
> >>> Apple's USB vendor ID) so apply this quirk as well.
> >>>
> >>> Some devices like Yubikeys emulate a keyboard. since u-boot only binds a
> >>> single keyboard block this kind of devices from the USB keyboard driver.
> >>>
> >>> Signed-off-by: Janne Grunau <j@jannau.net>
> >>
> >> I picked the series, but CI indicates build errors, can you have a look ?
> >>
> >> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20215
> > 
> > The issue seems to be that the field dev in struct usb_device exists
> > only for DM_USB. That means we can't use dev_dbg.
> > Either take the following fixup patch or I can resend the series.
> 
> I squashed the extra patch in, but I think the CI still complains:
> 
> Pipeline #20236 ( 
> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20236 ) 
> triggered by Marek Vasut ( https://source.denx.de/marex )
> had 1 failed job.
> 
> Job #812215 ( 
> https://source.denx.de/u-boot/custodians/u-boot-usb/-/jobs/812215/raw )

env_get() missing without CONFIG_ENV_SUPPORT. I'm too accustomed to the
kernel's stub functions. Best option seems to to just #if the
functionality out in this case. See attached fixup patch.

Sorry,

Janne

--qAvU1m4dKXDhn5xe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline;
	filename="0001-fixup-usb-Add-environment-based-device-ignorelist.patch"

From 214ec2aad1ed42d6e1256bbc7eaeff84e17443e0 Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Sat, 6 Apr 2024 21:46:44 +0200
Subject: [PATCH 1/1] fixup! usb: Add environment based device ignorelist

---
 common/usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/usb.c b/common/usb.c
index 8bc85c58b2..52f77431b0 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -1085,6 +1085,7 @@ static int usb_prepare_device(struct usb_device *dev, int addr, bool do_read,
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
 {
 	ulong vid, pid;
@@ -1126,6 +1127,7 @@ static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
 
 	return 0;
 }
+#endif
 
 int usb_select_config(struct usb_device *dev)
 {
@@ -1142,6 +1144,7 @@ int usb_select_config(struct usb_device *dev)
 	le16_to_cpus(&dev->descriptor.idProduct);
 	le16_to_cpus(&dev->descriptor.bcdDevice);
 
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 	/* ignore devices from usb_ignorelist */
 	err = usb_device_is_ignored(dev->descriptor.idVendor,
 				    dev->descriptor.idProduct);
@@ -1162,6 +1165,7 @@ int usb_select_config(struct usb_device *dev)
 	} else if (err < 0) {
 		return err;
 	}
+#endif
 
 	/*
 	 * Kingston DT Ultimate 32GB USB 3.0 seems to be extremely sensitive
-- 
2.44.0


--qAvU1m4dKXDhn5xe--
