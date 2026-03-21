Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D88FC72AA
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 03:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412A683E48;
	Sun, 22 Mar 2026 04:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QlLIwApM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AED83E48; Sun, 22 Mar 2026 04:43:59 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF56F83E48
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 04:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fdhx76yD3z9stn;
 Sun, 22 Mar 2026 04:43:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774151036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSKi17qE3MT0AlIxQLF6LZEaa2GrHBZAuGCk69vVUqU=;
 b=QlLIwApM2Nr9fRzxRpOip86lt2ayQUrmHPwJ71ukDZtEisSKszhFwZbyI72NNMNC9Wy8bK
 WDHMO5mlKrVOqAZfLYZCcjOTfNiDElBjz91JQmD6C7eKron4HZs+Dt/hid3gXVyB3CneNO
 kGYCwUsqZVKC2sodjVKBOa1E5mDcSV/WYq5vSijRiOn8V1833UtcfhZeHlzTdN/WlwW2/Q
 w9L9s7jhanXOZ/MpFrZW7han0vH2lztuWaMzwSfz6Y2vQtwA/IUf079US5EGUxYaLOTdI8
 xUAzz5bO6NTUSnw0848Fz3yD2p3evjsRZn/vYQ4LTdHwLCAUX+HBRBdQJar1JA==
Message-ID: <5f32e05e-3c26-46bc-8a3f-3f2fff76f433@mailbox.org>
Date: Sat, 21 Mar 2026 19:51:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: Correct dependencies around USB_EMUL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20260320205353.3789127-1-trini@konsulko.com>
 <f6ffc6db-c59d-45c9-964f-7fa56c320047@mailbox.org>
 <20260321170625.GE502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260321170625.GE502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: b7wsp44e3bkhdb1mfn9wtpqf1mnnoahk
X-MBO-RS-ID: 1460d48b5cba26b7f06
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

On 3/21/26 6:06 PM, Tom Rini wrote:
> On Sat, Mar 21, 2026 at 02:24:04AM +0100, Marek Vasut wrote:
>> On 3/20/26 9:53 PM, Tom Rini wrote:
>>> The symbol USB_EMUL is how sandbox has access to USB. It's
>>> implementation however enforces a few other requirements. It must have
>>> SCSI enabled, and in turn that means it must have BLK enabled. Finally,
>>> we should not be using SANDBOX itself as a symbol to decide what to
>>> build or not build here, as SANDBOX is selected for COMPILE_TEST builds
>>> as well and so may not have enabled the sandbox specific USB support.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Marek Vasut <marek.vasut@mailbox.org>
>>> ---
>>>    drivers/usb/emul/Kconfig  | 2 ++
>>>    drivers/usb/host/Makefile | 2 +-
>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/emul/Kconfig b/drivers/usb/emul/Kconfig
>>> index 279f6c6d7404..8ba372453e37 100644
>>> --- a/drivers/usb/emul/Kconfig
>>> +++ b/drivers/usb/emul/Kconfig
>>> @@ -1,7 +1,9 @@
>>>    config USB_EMUL
>>>    	bool "Support for USB device emulation"
>>>    	depends on SANDBOX
>>> +	select BLK
>>
>> The select SCSI and Makefile change I do understand. But why do we also need
>> BLK ? I can't find anything which would interact with BLK in the sandbox USB
>> emulation ?
> 
> Ah woops, I was fixing too many problems at once then and forgot BLK is
> select'd by SCSI now, not depends on, so indeed, it's not required here.
Excellent, then please do a V2 and then all is fine. Thanks !
