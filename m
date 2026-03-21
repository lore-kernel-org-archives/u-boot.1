Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7851075269
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 02:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF52684006;
	Sat, 21 Mar 2026 03:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N1ZaFTgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C4483D71; Sat, 21 Mar 2026 03:40:53 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B26884006
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 03:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fd3Zn5B6yz9spj;
 Sat, 21 Mar 2026 03:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774060849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WD2PMntZY3ENb7B6NjgsOIhvBMwOwjPPmdj4mlWqNBA=;
 b=N1ZaFTgpZby3DHPCV2Wo/eh5ZI+AEa31pjgjvCuZwYagEXC7TUdbFGir9fiROOiikonzP2
 YCyJo4pmN+y/DAc+AchkGaIys/7DZKwuvm+bEdOLn2cYroXbsNq2617r4AraA/BUXbrMFb
 40yOvPYE0+eKGrz5GQKQlzfvhyIJLelPowPiS75onOs6/ipJWPkbCDFrp9MDKW4kUHsYoL
 G5JsXvUZ12WjvOS9uP03LVjIYAZXww7q/1N0t1RoVazlcAQhy+ovuGhdoJDCS8mTerhtys
 ejJosaBqrlD0ilDyX0/ahlgrIXUaHZxtgaOUbVqBuQyA/nCobA5/C71mCs4jbw==
Message-ID: <03a11b96-88f4-4ca0-9705-0bfe8409ee6c@mailbox.org>
Date: Sat, 21 Mar 2026 02:53:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
 <20260317134107.GR502704@bill-the-cat>
 <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
 <20260318012649.GG502704@bill-the-cat>
 <bf3bb11e-e891-4703-ad47-04d53e21d7af@mailbox.org>
 <20260319133952.GO502704@bill-the-cat>
 <b48f3f6c-0403-4528-8de6-0b24caa810ef@mailbox.org>
 <20260320135305.GX502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260320135305.GX502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 30496adfef872aa62a9
X-MBO-RS-META: myki86xzchd1rqs1bupamuqgchc8ydqn
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

On 3/20/26 2:53 PM, Tom Rini wrote:

[...]

>> @@ -371,3 +367,11 @@ config SPL_SDP_USB_DEV
>>            so it can be used in compiled environment.
>>
>>   endif # SPL_USB_GADGET
>> +
>> +if USB_GADGET || SPL_USB_GADGET
>> +
>> +# Selected by UDC drivers that support high-speed operation.
>> +config USB_GADGET_DUALSPEED
>> +       bool
>> +
>> +endif
>> "
> 
> You don't need to guard hidden symbols.

We also do not want to expose this Kconfig symbol unless it makes sense 
to expose it ? In fact, if the symbol is not available and someone 
attempts to use it in Kconfig, they would get a warning, which should 
provide a clue that they are doing something wrong ?
