Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7A21093172
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 03:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E9F83F2E;
	Fri, 20 Mar 2026 04:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Stk9Tp5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F6383E36; Fri, 20 Mar 2026 04:59:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE5683D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 04:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fcTMV22NRz9tk3;
 Fri, 20 Mar 2026 04:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773979142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYwh/vRf+jmCohfUesHpvX2kA3MufPwBRxmEFmiGsLk=;
 b=Stk9Tp5tYSyWwUTm5SVU87FjyqVv9aMU/mchG9UjsbSGwxqpotRjcVwOuBkFMNcelXLSLO
 /ZrlTCKHXqGdEHXd4EFQ1+3fi92lMloeBP04HhwJBfwQWto3hid5VvGW/Tn8tYCuaFwFpd
 USjjhs6KwrTXW22N4VUZHsP8Gioy+WDylT/QPx91nChQlh9dlrnAe0CvQBN13TBcyZOTY2
 jfGTfitKqZLXQrcZdv6gG9cB2sd3DQs7Xbqqrj4raL+ToFU2rnWEwM5ENit+jUsWp7jYfZ
 GHD9QXrcs0+7KEYaHEBjMmQCkE4Seca09BuiCD/AwI3eBsxTbmtP0DmTmNFHTA==
Message-ID: <b48f3f6c-0403-4528-8de6-0b24caa810ef@mailbox.org>
Date: Thu, 19 Mar 2026 18:57:21 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260319133952.GO502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7d72d1e1c9eb7973e07
X-MBO-RS-META: peiiwcbsr77wwqdoea7nzr18s8mp8e7i
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

On 3/19/26 2:39 PM, Tom Rini wrote:
> On Thu, Mar 19, 2026 at 01:50:56AM +0100, Marek Vasut wrote:
>> On 3/18/26 2:26 AM, Tom Rini wrote:
>>> On Tue, Mar 17, 2026 at 08:42:06PM +0100, Marek Vasut wrote:
>>>> On 3/17/26 2:41 PM, Tom Rini wrote:
>>>>> On Tue, Mar 17, 2026 at 03:34:36AM +0100, Marek Vasut wrote:
>>>>>> On 3/17/26 2:24 AM, Tom Rini wrote:
>>>>>>> As exposed by "make randconfig", we have an issue around
>>>>>>> USB_GADGET_DUALSPEED. It is possible to select this symbol (via
>>>>>>> SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency. As
>>>>>>> this is a hidden symbol, move it up within the menu.
>>>>>> What is the issue this is fixing ?
>>>>>
>>>>> Valid configs causing the kconfig part of the build system to note
>>>>> unmet dependencies.
>>>> Lemme rephrase, is this actually a fix, or is this some readability/ordering
>>>> improvement patch ?
>>>
>>> Yes, it's a fix because randconfig finds problems that users may stumble
>>> on to while trying to make a valid config for a platform.
>>
>> Is the commit message telling me, that "config USB_GADGET_DUALSPEED" is
>> moved outside of the "if USB_GADGET" block ?
>>
>> Because if this is something else, and the symbols are simply reordered,
>> that I do not understand how this could be fixing anything.
> 
> I'm unclear what else you need to know to take this bugfix. The symbol
> is not placed correctly, leading to possibly unmet dependency errors.

Why do you think the symbol is placed incorrectly ?

What this change does, is it moves "config USB_GADGET_DUALSPEED" outside 
of the "if USB_GADGET" block in drivers/usb/gadget/Kconfig , which the 
commit message should clearly spell out.

However , I believe that is not the correct fix. The 
USB_GADGET_DUALSPEED has to be available only if USB_GADGET or 
SPL_USB_GADGET is selected, the former is already satisfied, the later 
is not and the SPL_USB_CDNS3_GADGET triggers a problem here. I think 
this is the correct fix:

"
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index ebb306852a6..87d17780c45 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -178,10 +178,6 @@ config SDP_LOADADDR
         hex "Default load address at SDP_WRITE and SDP_JUMP"
         default 0x0

-# Selected by UDC drivers that support high-speed operation.
-config USB_GADGET_DUALSPEED
-       bool
-
  config USB_GADGET_DOWNLOAD
         bool "Enable USB download gadget"
         help
@@ -371,3 +367,11 @@ config SPL_SDP_USB_DEV
           so it can be used in compiled environment.

  endif # SPL_USB_GADGET
+
+if USB_GADGET || SPL_USB_GADGET
+
+# Selected by UDC drivers that support high-speed operation.
+config USB_GADGET_DUALSPEED
+       bool
+
+endif
"

> Yes, the error is discovered by randconfig which makes it harder to
> describe how exactly to reproduce it (but I believe it does), but that
> doesn't make it any less valid.
This part is not relevant.
