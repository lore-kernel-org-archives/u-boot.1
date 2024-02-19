Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D57C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 19:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9791887DB7;
	Mon, 19 Feb 2024 20:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="bG1Q8k+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499A187F1B; Mon, 19 Feb 2024 20:01:36 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D166087DF9
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 20:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1708369277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/C14HBfG/78yFDjA5nXhTVdtCObsyegURQSfPne3Iw=;
 b=bG1Q8k+BMheIjsNbzAASjDSayc6kPpoZgypoiBa2JySuihiKBkG8ZsCIXdghINxBtODILl
 3Pbhn/QjotAd3362EgxWPrNWTN0KlFuUMkuMHaE4i2+cxDDtHIxzzUuY9SriF9Ihume4Zx
 LGCshWVSXrkVBWzmC9ydaao17c13dkPW41dZlaWijbzYLUrHgBKNcOAwSAnSOtsVOV6qSq
 L/PDKhaWoOyvy8vLYCEku253kYhYw/IgkKaZ+m7rHUEJ9NLOYhdHRqhpjIMje/NsrKtuXQ
 GjB0ewNeQPeHgjGJeETsgQ2s3IIod/JegBx4OfU4lLzOlRfpQqWrOEFCyA86fQ==
Date: Mon, 19 Feb 2024 20:01:16 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marex@denx.de>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 andre.przywara@arm.com, Hector Martin <marcan@marcan.st>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
In-Reply-To: <053161b6-3eee-4c48-b163-70b22bd116bc@denx.de>
References: <20240214095403.53051-1-i@shantur.com>
 <053161b6-3eee-4c48-b163-70b22bd116bc@denx.de>
Message-ID: <f2f0d000655830f7a6662b9538953099@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-19 19:24, Marek Vasut wrote:
> On 2/14/24 10:54, Shantur Rathore wrote:
>> Additional testing of the changes introduced in commit 33e06dcbe57a 
>> "common:
>> usb-hub: Reset hub port before scanning") revealed that some USB 2.0 
>> and 3.0
>> flash drives didn't work in U-Boot on some Allwinner SoCs that support 
>> USB
>> 2.0 interfaces only.  More precisely, some of the tested USB 2.0 and 
>> 3.0
>> flash drives failed to be detected and work on an OrangePi Zero 3, 
>> based on
>> the Allwinner H616 SoC that supports USB 2.0 only, while the same USB 
>> flash
>> drives worked just fine on a Pine64 H64, based on the Allwinner H6 SoC 
>> that
>> supports both USB 2.0 and USB 3.0 interfaces.
>> 
>> The USB ID of the above-mentioned USB 3.0 flash drive that failed to 
>> work is
>> 1f75:0917 (Innostor Technology Corporation IS917 Mass storage), it is 
>> 32 GB
>> in size and sold under the PNY brand.  The mentioned USB 2.0 drive is 
>> some
>> inexpensive no-name drive with an invalid USB ID.
>> 
>> Resetting USB 3.0 hubs only, which this patch introduces to the USB 
>> hub
>> resets, has been tested to work as expected, resolving the identified 
>> issues
>> on the Allwinner H616, while not introducing any new issues on other 
>> tested
>> Allwinner SoCs.  Thus, let's fix it that way.
>> 
>> According to the USB 3.0 specification, resetting a USB 3.0 port is 
>> required
>> when an attached USB device transitions between different states, such 
>> as
>> when it resumes from suspend.  Though, the Linux kernel performs 
>> additional
>> USB 3.0 port resets upon initial USB device attachment, as visible in 
>> commit
>> 07194ab7be63 ("USB: Reset USB 3.0 devices on (re)discovery") in the 
>> kernel
>> source, to ensure proper state of the USB 3.0 hub port and proper USB 
>> mode
>> negotiation during the initial USB device attachment and enumeration.
>> 
>> These additional types of USB port resets don't exist for USB 2.0 
>> hubs,
>> according the USB 2.0 specification.  The resets seem to be added to 
>> the USB
>> 3.0 specification as part of the port and device mode negotiation.
>> 
>> The Linux kernel resets USB 3.0 (i.e. SuperSpeed) hubs only, as 
>> visible in
>> commit 10d674a82e55 ("USB: When hot reset for USB3 fails, try warm 
>> reset.")
>> in the kernel source.  The check for SuperSpeed hubs is performed in a 
>> way
>> that also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as 
>> well,
>> which hopefully makes it future proof.
>> 
>> Fixes: commit 33e06dcbe57a ("common: usb-hub: Reset hub port before 
>> scanning")

Oh, I just noticed that "commit" somehow ended up here by mistake.
Please remove it before applying.

>> Link:
>> https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.com/T/#u
>> Link:
>> https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.manchester.arm.com/T/#u
>> 
>> Signed-off-by: Shantur Rathore <i@shantur.com>
>> Helped-by: Dragan Simic <dsimic@manjaro.org>
>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
