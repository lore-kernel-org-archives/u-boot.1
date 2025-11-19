Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF0FCF6497
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 00:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C3983EA6;
	Thu, 20 Nov 2025 01:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DgksP4D2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="isaEKfIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 374BB83FD3; Thu, 20 Nov 2025 01:20:04 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA65183E40
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 01:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dBfB84bLrz9tQP;
 Thu, 20 Nov 2025 01:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763598000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhL7gGANAxQipw/ycGBoZjrpqO63mUKNFgftYoa5EZI=;
 b=DgksP4D2dBuX6bEH0jlxQnnFMQyOeOnD6qyAzaBgnWBr+oN2aPe/J3Jdec9W4u9jrxljuT
 +coTPriyA87h6I0mOUsYPISCFsGnUIeAkqXmjIeWqlwg2BOkEEQF3bV2coHc9VJksSEqVZ
 wolXMWVjC/QxXH6lKOGo/F2wj1wksppOe4xZE7sSSSCb6PIaNPH8kBQjIn6Ypd7cRWvoZb
 J3hXnR60Awe80PjesnAhYtIH3O3qbYqRFG+JQi5/zLCBCShazdnHnUcE/g5lODPMEjJJ6I
 gp5Q5FmRxAMrxKOJG4Pk7tmhyKxBmYKmvXXhgWg35gT6gj/3MYXBPX2SF7MGIA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=isaEKfIg;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <b3c9a624-6574-4be9-a88c-be7acc863d3c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763597998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhL7gGANAxQipw/ycGBoZjrpqO63mUKNFgftYoa5EZI=;
 b=isaEKfIgYiHvrxQlI3trwRMRHHZ++7gFVqwyRuVp0Vf09Six5MXQT2MYOaGaSwxR+5Unoa
 D5gHa8yoeXRgxWSZsf+vfjpAJC2yJVxRAEo6tF3ajr0mAYkGJ+P6cc2PWpVEuIuI3dl3lF
 ItNAKX73vT9z0HsMFrkwVNoy/TlFaAVkpazY3aelFyLQ46DsXvjTTy4ob1Xwz/lX1S0NwX
 dYlPA4RG1Nkax5rmBkh2u8uE9mYEqY9sfokIujbxuK9K7+tJX9/I4kFODTawDCiMZfuJUz
 n43PHUaOXc4Lx23rOhpOynhI4Pup9mVBNOGyKLmO53j6XusEJvMqXj914XO1ww==
Date: Wed, 19 Nov 2025 22:29:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
 <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
 <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
 <c5300029-9bab-4a06-b426-ccc443d0928c@mailbox.org>
 <CAFLszTiV2jTWcWU+27QxX82Ap9YnhZNTK1sXrFvF_e53ydc5_g@mail.gmail.com>
 <706283a7-2ba9-4b8c-8cb4-3db42759acc9@mailbox.org>
 <CAFLszTh5MaFqC-pP5z4j8jLs4qmUR-jhS5wYob2kkVTFDQB0Vg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTh5MaFqC-pP5z4j8jLs4qmUR-jhS5wYob2kkVTFDQB0Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ddad93b352849e22122
X-MBO-RS-META: 86im4cpgu4hj6sf61iziphrsx68sro6s
X-Rspamd-Queue-Id: 4dBfB84bLrz9tQP
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

On 11/18/25 4:47 AM, Simon Glass wrote:

Hello Simon,

>>>> 2294         } else if (load_op != FIT_LOAD_IGNORED && image_type ==
>>>> IH_TYPE_FLATDT &&
>>>> 2295                    ((uintptr_t)buf & 7)) {
>>>> 2296                 loadbuf = memalign(8, len);
>>>> 2297                 load = map_to_sysmem(loadbuf);
>>>> 2298                 memcpy(loadbuf, buf, len);
>>>>
>>>> ...
>>>>
>>>> 2309         /* verify that image data is a proper FDT blob */
>>>> 2310         if (load_op != FIT_LOAD_IGNORED && image_type ==
>>>> IH_TYPE_FLATDT &&
>>>> 2311             fdt_check_header(loadbuf)) { <----------------- this
>>>> 2312                 puts("Subimage data is not a FDT\n");
>>>> 2313                 return -ENOEXEC;
>>>> 2314         }
>>>>
>>>>> Perhaps we should deprecate FITs with internal data, too?
>>>> We cannot break compatibility and stop supporting old fitImage, so this
>>>> is irrelevant here.
>>>
>>> OK, so please create a function which can detect an FDT header without
>>> it being aligned, like the other code you wrote. Then it will be safe
>>> to call that here, even if unaligned.
>> But we actually do want to detect unaligned broken FDT header and either
>> fix it up or stop processing, we don't want to perpetuate handling of
>> broken FDTs and pretend that is OK, it shouldn't be I think. Hence this
>> fixup.
> 
> The decision as to whether something is an FDT is made a lot earlier
> than the actual processing of it. For the former there is no need to
> allocate and copy. For the latter we need to.

The test whether the FDT is valid cannot be done earlier, this place is 
literally the first place when the FDT is decompressed/loaded to the 
target location.

> Anyway, you are doing the patches, so do what you think is best. But
> please create a function for this, rather than lots of little
> hand-crafted checks around the place.
I am confused, function for what exactly ?
