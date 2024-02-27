Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEA6C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 07:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A712387C9A;
	Tue, 27 Feb 2024 08:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="HFEaWit9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8rA7IBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5B087F88; Tue, 27 Feb 2024 08:14:01 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3A387C9A
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 08:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 4086A320092C;
 Tue, 27 Feb 2024 02:13:55 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Tue, 27 Feb 2024 02:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1709018034; x=1709104434; bh=pYie5WA+DF
 r9O6cnGq8epO2QnK0laHXEy+hQIxHCt1g=; b=HFEaWit9OGECSLRR/KnMJ0Cw0R
 uaw6XSZZ5v+JTkHg9LCa4iZP/wgAUwIk9wuN3pW0JljBShqrAHC3jwbdakCdQ3Yg
 nURsMtJPz1kpm5DarQ2OWVb3noahbkHZCsYV7LyZfyt2WrHZWjOf0FAiMujUlbW1
 mh4n3D3a5R4DXhWThqPyQGIGQ2nOyTxzgiYX67emJCKcAcEGQUoruPOX1vQUO/dH
 pj2cZE4cnJvT2SpnWT4yJ+ISwOGHIR33KP7dguWqf/rwbm9hyREGFUAItdkaHSGr
 XtDyxgjEU49tz+SW18OW3TTVFm8Fp1pb525S326PjaQW8a+YK30cDH7+DfVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1709018034; x=1709104434; bh=pYie5WA+DFr9O6cnGq8epO2QnK0l
 aHXEy+hQIxHCt1g=; b=h8rA7IBGw+IssyKw1XRnmAFq1xPEL+paMuDwuctmRa96
 SCl0y5nw2Y78fJCjTwOsa8RIdKy28WqI/+JJDBsKHN6PAXPt3kFdIoPC/a6RhC14
 8c+ufKoxFRgJnxnAG/Lg1jH7hjAYBfAUV8y3DJkkHUZi9m+k5DW1un6yYtQGPG1N
 UmM+IR+kcbwI8PeuGU4Vo8hhlGTR92+VVO1uiPP9vj8+uw7mndGNrK/LeL6gv/cZ
 y68cRf4npnqZ3DJ0c/uPU+QMWKJHkSpORtaliTNTi8C9/A0/9GZ4tOVPXypGZGqX
 7DjwENCtB/y09LrUCZPNmNGoOyb2+6i7KN11KbTJQw==
X-ME-Sender: <xms:sovdZbq1ecP6pD3CFeuhbphsisY8xqrY2-5EOKgG8fS6pu6muiWslA>
 <xme:sovdZVqYha8P0xNiYCzQwAitdD68Q_yqzICiFvvI0n9yqzwKD7DgeMCHtcN1zVj9-
 z202FsIj00C3UViCUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgddutdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfgr
 nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepvedvhfdtvddvtdfggffgueetudfhieegveefffeukeehteffkeejheejfefhiedt
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjh
 grnhhnrghurdhnvght
X-ME-Proxy: <xmx:sovdZYMSGzmNKdo97WhytLSk-KCMELSI4nn6C5IYyVd9WV-npDPQoQ>
 <xmx:sovdZe7_z5Kt8clfS1ELSbZXASTdsjZwgmZxfxZ24t0unpj4fkZD7w>
 <xmx:sovdZa6QK_ICTABYTU81oE_1xq-RFqdiuuVXHl9TuvqicCKoBOIwtg>
 <xmx:sovdZV1q43k1O6Wv3RQxQsnA6VN7pmvEzjWjBwL6TOoIl_nXzACkvA>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id ED3F83640072; Tue, 27 Feb 2024 02:13:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
MIME-Version: 1.0
Message-Id: <99e1b526-e791-46a0-8d58-d9bcbf48d3f8@app.fastmail.com>
In-Reply-To: <874jdvj6kx.fsf@bloch.sibelius.xs4all.nl>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-4-814b2e741790@jannau.net>
 <2acb9976-a40e-4977-b7ca-2462e84251ed@denx.de>
 <4c1c6b72-ffe5-4ff3-8d12-9fc0b956643d@app.fastmail.com>
 <85d561a6-54cb-4c1c-bfb0-559163e859c0@denx.de>
 <874jdvj6kx.fsf@bloch.sibelius.xs4all.nl>
Date: Tue, 27 Feb 2024 08:13:33 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Mark Kettenis" <mark.kettenis@xs4all.nl>, "Marek Vasut" <marex@denx.de>
Cc: "Bin Meng" <bmeng.cn@gmail.com>, "Tom Rini" <trini@konsulko.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev,
 "Hector Martin" <marcan@marcan.st>
Subject: Re: [PATCH 4/6] usb: kbd: Ignore Yubikeys
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

Hej,

On Mon, Feb 26, 2024, at 21:47, Mark Kettenis wrote:
>> Date: Sun, 25 Feb 2024 22:57:23 +0100
>> From: Marek Vasut <marex@denx.de>
>> 
>> On 2/25/24 5:07 PM, Janne Grunau wrote:
>> > Hej,
>> > 
>> > On Wed, Feb 21, 2024, at 13:41, Marek Vasut wrote:
>> >> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
>> >>> From: Hector Martin <marcan@marcan.st>
>> >>>
>> >>> We currently only support one USB keyboard device, but some devices
>> >>> emulate keyboards for other purposes. Most commonly, people run into
>> >>> this with Yubikeys, so let's ignore those.
>> >>>
>> >>> Even if we end up supporting multiple keyboards in the future, it's
>> >>> safer to ignore known non-keyboard devices.
>> >>>
>> >>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> >>> ---
>> >>>    common/usb_kbd.c | 19 +++++++++++++++++++
>> >>>    1 file changed, 19 insertions(+)
>> >>>
>> >>> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
>> >>> index 4cbc9acb73..774d3555d9 100644
>> >>> --- a/common/usb_kbd.c
>> >>> +++ b/common/usb_kbd.c
>> >>> @@ -120,6 +120,15 @@ struct usb_kbd_pdata {
>> >>>    
>> >>>    extern int __maybe_unused net_busy_flag;
>> >>>    
>> >>> +/*
>> >>> + * Since we only support one usbkbd device in the iomux,
>> >>> + * ignore common keyboard-emulating devices that aren't
>> >>> + * real keyboards.
>> >>> + */
>> >>> +const uint16_t vid_blocklist[] = {
>> >>> +	0x1050, /* Yubico */
>> >>> +};
>> >>> +
>> >>>    /* The period of time between two calls of usb_kbd_testc(). */
>> >>>    static unsigned long kbd_testc_tms;
>> >>>    
>> >>> @@ -465,6 +474,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>> >>>    	struct usb_endpoint_descriptor *ep;
>> >>>    	struct usb_kbd_pdata *data;
>> >>>    	int epNum;
>> >>> +	int i;
>> >>>    
>> >>>    	if (dev->descriptor.bNumConfigurations != 1)
>> >>>    		return 0;
>> >>> @@ -480,6 +490,15 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>> >>>    	if (iface->desc.bInterfaceProtocol != USB_PROT_HID_KEYBOARD)
>> >>>    		return 0;
>> >>>    
>> >>> +	for (i = 0; i < ARRAY_SIZE(vid_blocklist); i++) {
>> >>> +		if (dev->descriptor.idVendor == vid_blocklist[i]) {
>> >>> +			printf("Ignoring keyboard device 0x%x:0x%x\n",
>> >>> +			       dev->descriptor.idVendor,
>> >>> +			       dev->descriptor.idProduct);
>> >>> +			return 0;
>> >>> +		}
>> >>> +	}
>> >>
>> >> I vaguely recall a discussion about previous version of this, I think
>> >> the suggestion was to make the list of ignored devices configurable via
>> >> environment variable, so users can add to that list from U-Boot shell.
>> >> Would it be possible to make it work this way ?
>> > 
>> > oh, I completely forgot that this patch was already submitted. I briefly looked through asahi tree for related patches and did not check whether this was previously submitted.
>> > I've added environment based blocking as separate patch with blocking either complete vendor IDs or vendor, product ID combinations. A separate patch to simplify authorship tracking and the implementation doesn't share any code.
>> 
>> It would be better to have only one patch which does not hard-code any 
>> USB IDs, and then add those blocked IDs via U-Boot default environment 
>> for this specific machine. We cannot predict what yubico will do in the 
>> future, whether they might make a device that shouldn't be blocked for 
>> example. If they do, the user should be able to unblock their device by 
>> running e.g. '=> setenv usb_blocklist' instead of updating their bootloader.
>> 
>> I think a simple list of blocked VID:PID pairs, maybe with wildcards, 
>> would be nice, i.e. something like 'usb_blocklist=1234:5678,1050:*' to 
>> block device 0x1234:0x5678 and all devices with VID 0x1050 . That should 
>> be easy to parse with strtok()/strtol() or some such and the code should 
>> not be too complex.
>
> I do like the idea of having a configurable list of usb devices to
> ignore.  The U-Boot USB stack is still not perfect and there are still
> USB devices that will prevent us from booting when connected.  The
> list will provide a nice workaround for that issue.

That sounds like we should ignore USB devices in usb_scan_device() and not in the keyboard driver.

> But the yubikeys will cause the same problem on other boards as well.
> So I think it makes sense to put those in a default list.

We could move the list to a CONFIG symbol which has Yubikey's vendor ID as default value now that we do string parsing anyway.

Janne
