Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C01FA3748
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB418422F;
	Fri,  2 Jan 2026 15:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qkS3xaof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B26A84241; Fri,  2 Jan 2026 15:36:33 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66819841E6
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4djR8Y3gmGz9tcZ;
 Fri,  2 Jan 2026 15:36:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767364589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OERFb6CKJqukuDfql9DlXUcoFgtbCwR94c+GDjUHqKg=;
 b=qkS3xaof66hT4c8zu1diEVLEO/Yb7zlEqsLrCMnG8h5CaTOafV8gCCUX+DeTA1YZfu75dc
 36T+Q0/inrAt+NzAC3bk01l1egm0QKgi6K3BN7hN/XfnuFPQatwxMjhF/b0uqkPHPr3COR
 CILmH67F5ruxQSb4qLSjD3y7eV2fW3xLQ8J2k9TzxhNKaG9iupdIzN8QgijjJ2IBf+xEMN
 P/higi9yH0gQB0KDwswCk3WHUkdyhpgWXw6LArN5dTljc5WX/E5stnTyyVTNORRxNtgz04
 If4fxs+FirYUzqai+c0EKV4ICiArFRrbeOP5imHVBDYhXr7zpuGhtL9LleHJ4A==
Message-ID: <67fefad5-ce05-486b-81f9-f28798195bc1@mailbox.org>
Date: Fri, 2 Jan 2026 15:36:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] usb_kbd: remove match string
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
References: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
 <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
 <CALeDE9Oue=0L3PRVs7O8suPVDFBXL_i6o0hc50jLQ49HtaX2nQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CALeDE9Oue=0L3PRVs7O8suPVDFBXL_i6o0hc50jLQ49HtaX2nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hj1b7my18yiqntharqmmdy4chw6ctum5
X-MBO-RS-ID: 314b3928e30b2f60cda
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

On 1/2/26 3:22 PM, Peter Robinson wrote:
> On Fri, 2 Jan 2026 at 13:47, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 1/2/26 1:56 PM, Heinrich Schuchardt wrote:
>>> USB keyboards are identified via a USB interface descriptor or via USB
>>> vendor and product IDs but never via the device-tree.
>>>
>>> Remove the device-tree match string.
>> The commit message is wrong, you can actually describe USB devices in
>> DT, see e.g. Linux:
>>
>> arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi:              compatible =
>> "usb424,2514";
>>
>> Documentation/devicetree/bindings/usb/microchip,usb2514.yaml:          -
>> usb424,2514
> 
> I think there's nuance there because I think those USB hubs at times
> can have a GPIO to control power or something like that and hence the
> compat.

I can imagine laptop keyboard can have the same thing, either for power 
regulator or for backlight under keys.

>> However, it seems this particular compatible string is ad-hoc and
>> unused. I wonder if this might break some users like RPi which supply
>> external DT and may depend on this support ?
> 
> I've never seen the USB keyboards described in any of the RPi DTs

OK
