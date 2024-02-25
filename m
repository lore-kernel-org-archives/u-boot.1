Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41924C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 16:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98A787DEC;
	Sun, 25 Feb 2024 17:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="rUrhTQQH";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="dIXaacT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A8087D74; Sun, 25 Feb 2024 17:07:52 +0100 (CET)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676BB87E06
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 17:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id EB3EF3200A02;
 Sun, 25 Feb 2024 11:07:47 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Sun, 25 Feb 2024 11:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1708877267; x=1708963667; bh=OdegtLHjz4
 PRJTPWkYd1xhplRz7QKuNQCcm0HyxxUlU=; b=rUrhTQQHU+h81IJx4vpj81nwSo
 J7jMZUx3AirModFLkS4vHWGpvITSFSxbwK+RO/HCEH0rt/HDl4EXHb9WXEoNrZwa
 6qJCxHMYfTzdCeYxulHTFpi1RgGtp9cfFxiKGdqNhaDym+nKR4qDauqMtRdEwNNp
 KxIXay5WZ1pFIf3rqiw50BhushsRrqTwm3vyjdR6S48CzUTlfyjCNMLg/n3O7i3Q
 siT/7Q6Yjz22EIGJrmo1z4yC8cGW2NJjdKOtte3jySvySdVagF2DECZOSU47/gLG
 X/NLx6zHL/pPq7fJ71nZUhER0MBxuE2ubWmbTyq5BzMllS1yj155DmJJwLQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708877267; x=1708963667; bh=OdegtLHjz4PRJTPWkYd1xhplRz7Q
 KuNQCcm0HyxxUlU=; b=dIXaacT+aLz8hFHwGHlIMaIyqa2YgEjc90IhM2bPPq6R
 utYz5ydAjAn734jNI6Frr41wN6Zp5rVKW+Q8SpI/+AZmC5e4QjEo4c4Ae1NLI8p4
 Y/foL1Kbpvq6Q1Pgtv8+8sGsIztErskhMy/2LhSNsfk1vqIQ0poHCqE1ZG1sjkzq
 C9c/TS/Ip1+mdIaSChgjKTaT3L1v4nNRK1NcmpkXAN0xDQhpon/FI9ixdVIRRIhD
 VxY3IzUjnUniAPF9PGjgEeyNiLOTIvmcLAebg0Ba4dhP6VIs223Yg8ZNgjzcboS0
 jPNIM3CfiqnDqVcen8dADb+9jihdOwqZIF69sZo5Sw==
X-ME-Sender: <xms:02XbZU3Mr6pkip5kcs_y4jtjLW1tmd7NxRibVe2QJCeTlIn-jLTIrg>
 <xme:02XbZfFGWQMY9LAretnET-_pu8aH4fy4ll_Xs1nOiG4y8HKUUKlnNXs3MsgMGVvR7
 9tH-XFJm2YIq_DaQrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedtgdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflrghn
 nhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrh
 hnpeevvdfhtddvvddtgffggfeuteduhfeigeevfeffueekheetffekjeehjeefhfeitden
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrg
 hnnhgruhdrnhgvth
X-ME-Proxy: <xmx:02XbZc4STP684NXmzRNUj7TrLnFcCkrrNnoM0qSKTGtHYpVJWtp0tQ>
 <xmx:02XbZd2BFN6Y9Gdm2Wo0t7jrPODRdCzOGoFGXnaK5Br_JDgDnsCQ6Q>
 <xmx:02XbZXGdZ5VvCRKWypMTazsPqbrMAJaPe-IRPr_UZmFA8N69rdmRrA>
 <xmx:02XbZfDv1mC8A9Tr0Lc7CN_MO2sKZfTheO-r8h5IwY8unHuHGJ5Ldw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id EF443364006F; Sun, 25 Feb 2024 11:07:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
MIME-Version: 1.0
Message-Id: <4c1c6b72-ffe5-4ff3-8d12-9fc0b956643d@app.fastmail.com>
In-Reply-To: <2acb9976-a40e-4977-b7ca-2462e84251ed@denx.de>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-4-814b2e741790@jannau.net>
 <2acb9976-a40e-4977-b7ca-2462e84251ed@denx.de>
Date: Sun, 25 Feb 2024 17:07:26 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Marek Vasut" <marex@denx.de>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev,
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

On Wed, Feb 21, 2024, at 13:41, Marek Vasut wrote:
> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
>> From: Hector Martin <marcan@marcan.st>
>> 
>> We currently only support one USB keyboard device, but some devices
>> emulate keyboards for other purposes. Most commonly, people run into
>> this with Yubikeys, so let's ignore those.
>> 
>> Even if we end up supporting multiple keyboards in the future, it's
>> safer to ignore known non-keyboard devices.
>> 
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   common/usb_kbd.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>> 
>> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
>> index 4cbc9acb73..774d3555d9 100644
>> --- a/common/usb_kbd.c
>> +++ b/common/usb_kbd.c
>> @@ -120,6 +120,15 @@ struct usb_kbd_pdata {
>>   
>>   extern int __maybe_unused net_busy_flag;
>>   
>> +/*
>> + * Since we only support one usbkbd device in the iomux,
>> + * ignore common keyboard-emulating devices that aren't
>> + * real keyboards.
>> + */
>> +const uint16_t vid_blocklist[] = {
>> +	0x1050, /* Yubico */
>> +};
>> +
>>   /* The period of time between two calls of usb_kbd_testc(). */
>>   static unsigned long kbd_testc_tms;
>>   
>> @@ -465,6 +474,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>>   	struct usb_endpoint_descriptor *ep;
>>   	struct usb_kbd_pdata *data;
>>   	int epNum;
>> +	int i;
>>   
>>   	if (dev->descriptor.bNumConfigurations != 1)
>>   		return 0;
>> @@ -480,6 +490,15 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>>   	if (iface->desc.bInterfaceProtocol != USB_PROT_HID_KEYBOARD)
>>   		return 0;
>>   
>> +	for (i = 0; i < ARRAY_SIZE(vid_blocklist); i++) {
>> +		if (dev->descriptor.idVendor == vid_blocklist[i]) {
>> +			printf("Ignoring keyboard device 0x%x:0x%x\n",
>> +			       dev->descriptor.idVendor,
>> +			       dev->descriptor.idProduct);
>> +			return 0;
>> +		}
>> +	}
>
> I vaguely recall a discussion about previous version of this, I think 
> the suggestion was to make the list of ignored devices configurable via 
> environment variable, so users can add to that list from U-Boot shell. 
> Would it be possible to make it work this way ?

oh, I completely forgot that this patch was already submitted. I briefly looked through asahi tree for related patches and did not check whether this was previously submitted.
I've added environment based blocking as separate patch with blocking either complete vendor IDs or vendor, product ID combinations. A separate patch to simplify authorship tracking and the implementation doesn't share any code.

Janne
