Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6B7D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 10:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC60E844DF;
	Fri, 28 Nov 2025 11:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GYFDNxJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18772844E3; Fri, 28 Nov 2025 11:48:53 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDCC844C4
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1E8CB1A1DF7;
 Fri, 28 Nov 2025 10:48:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E912F60706;
 Fri, 28 Nov 2025 10:48:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DFCF103C8F95; Fri, 28 Nov 2025 11:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764326928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=GUzcGO2NQQ1B6VksLoLaT81r2zZMA5wErlNcKDpajII=;
 b=GYFDNxJZtEQBCwj5igI+iIIJH5aim57Op0jJR4F85SSgkGc6uzqk4sPIjIsh9i/5gzn7cb
 7k5lQWTN02rSkfj1SyWdmK2LApe3kP5YxV+MDXf7vv+klnXfxDG/TybkEbWx7w2ni7GfeO
 Ci1Jl8c0/LY9/c18r0nWJJ/QzxysOVoPp87rFZfOMlcMuEPhveQothiZHG5m7FDwR5xrKr
 14KlWixo4CPPueP+4vqB/yD+oNLK+aQ3mx6R06BwTVjJj9HlDef1vWd5WOw8WLwtREDPao
 M7ASs1wJAA4jKJGNbhbGBm/kwmOrGro+NPye3rc1/CplQPcMrUxHNUuKeXJ9wA==
Message-ID: <c2099136-0cfe-4345-a9ca-7c4f5e870dd0@bootlin.com>
Date: Fri, 28 Nov 2025 11:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: blob_dtb: improve error message when SPL is not
 found
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
References: <20250820150654.1398992-1-jeremie.dautheribes@bootlin.com>
 <20250909170357.GA1799865@bill-the-cat>
 <89715907-3d24-483d-943f-a027097962aa@bootlin.com>
 <20251127184059.GX2125796@bill-the-cat>
Content-Language: en-US
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Organization: Bootlin
In-Reply-To: <20251127184059.GX2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 27/11/2025 19:40, Tom Rini wrote:
> On Thu, Nov 27, 2025 at 07:04:06PM +0100, Jérémie Dautheribes wrote:
>> Hi Tom,
>>
>> On 09/09/2025 19:03, Tom Rini wrote:
>>> On Wed, Aug 20, 2025 at 05:06:54PM +0200, Jérémie Dautheribes wrote:
>>>
>>>> When using binman with the '-a spl-dtb=y' flag, if the SPL blob is not
>>>> found, binman throws a cryptic error message:
>>>> binman: 'NoneType' object has no attribute 'startswith'
>>>>
>>>> Let's improve the error message to explicitly state which SPL blob is
>>>> missing.
>>>> This is particularly useful when binman is used as a standalone tool
>>>> outside the U-Boot source tree.
>>>>
>>>> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>>>> ---
>>>>    tools/binman/etype/blob_dtb.py | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/tools/binman/etype/blob_dtb.py b/tools/binman/etype/blob_dtb.py
>>>> index b234323d7cf..772579394d4 100644
>>>> --- a/tools/binman/etype/blob_dtb.py
>>>> +++ b/tools/binman/etype/blob_dtb.py
>>>> @@ -8,6 +8,8 @@
>>>>    from binman.entry import Entry
>>>>    from binman.etype.blob import Entry_blob
>>>>    from dtoc import fdt_util
>>>> +import errno
>>>> +import os
>>>>    import struct
>>>>    # This is imported if needed
>>>> @@ -42,6 +44,9 @@ class Entry_blob_dtb(Entry_blob):
>>>>            """Get the device-tree from the list held by the 'state' module"""
>>>>            self._filename = self.GetDefaultFilename()
>>>>            self._pathname, _ = self.FdtContents(self.GetFdtEtype())
>>>> +        if self._pathname is None:
>>>> +            raise FileNotFoundError(errno.ENOENT,
>>>> +                                    os.strerror(errno.ENOENT), self._filename)
>>>>            return super().ReadBlobContents()
>>>>        def ProcessContents(self):
>>>
>>> Sorry for the delay in review. We also need to update the function
>>> comment so that python coverage remains at 100%.
>>
>> Sorry but I'm really not familiar with python coverage. I had a look to the
>> official documentation and it looks like I need to add a test to cover this
>> specific function. That is what you are requesting?
> 
> So, doc/develop/binman_tests.rst talks a bit about testing of binman and
> python coverage. In this case I believe the issue is that the function
> you're modifying needs to have the comment block annotations updated to
> include the exception it can throw.
> 

Ok I got it, I'll send a V2 including this comment annotation, thanks 
for your help!

Jérémie

