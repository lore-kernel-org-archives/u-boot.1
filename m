Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311FCC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 18:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C8D8209C;
	Wed,  7 May 2025 20:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="DlxCYBKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4695C8211F; Wed,  7 May 2025 20:17:33 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F7481FAB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 20:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746641849; x=1746901049;
 bh=mPs04yZ9wIBaGNXP/dcXSa31dRDd8gj4GQaR+v7Wd0s=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=DlxCYBKhjYzUPnG4IlcG7viLvN0v4kFwG2rxIunF8rfgJFiGQ5tjgFoGgDKICTnWh
 venE3miKv3yilqo8ERijX7K0YT9tOsv9NaI4gyi0nEjSUQ6pqBnOMsAkK3X+3lVwE/
 uuGZ65sBSAk/sgO5c1u6VLj57+J74vyPpaKcDgOYHdNR0xpHE6SrADzDup9COxWj8J
 FfNzWwFT9tbjR5/zKeZsg3R7H1UBFdIs1ufEpZSp5KrsJo4nWaV92suqtbV5ELChw7
 vgduP2r16hOLQfzjZWn9aqjPuXMMVTQmdg8MUmQUuzP2SqQDs7E1b+himhqRl3CjYh
 AYVCMwU0b5+OA==
Date: Wed, 07 May 2025 18:17:23 +0000
To: Tom Rini <trini@konsulko.com>
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: cpu: armv7m: add required .type name,
 %function directive
Message-ID: <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
In-Reply-To: <20250507165533.GO5430@bill-the-cat>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: e54de7840eb3a3e2d0a28db74f33d1886b21fba1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Tom!

Thanks for the quick response!

On 5/7/25 18:55, Tom Rini wrote:
> On Wed, May 07, 2025 at 06:07:54AM +0000, Johannes Krottmayer wrote:
>=20
>> Since GNU binutils version 2.44, assembly functions must include
>> the assembler directive .type name, %function. If not a call to
>> these functions fails with the error message 'Unknown destination
>> type (ARM/Thumb)' and the error message 'dangerous relocation:
>> unsupported relocation' at linking.
>>
>> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   arch/arm/cpu/armv7m/start.S | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/cpu/armv7m/start.S b/arch/arm/cpu/armv7m/start.S
>> index 0c07f2140c7..c20f01a0aed 100644
>> --- a/arch/arm/cpu/armv7m/start.S
>> +++ b/arch/arm/cpu/armv7m/start.S
>> @@ -12,5 +12,6 @@ reset:
>>   =09W(b)=09_main
>>  =20
>>   .globl=09c_runtime_cpu_setup
>> +.type c_runtime_cpu_setup, %function
>>   c_runtime_cpu_setup:
>>   =09mov=09pc, lr
>=20
> Thanks for making the patch. There's an argument that this should use
> the ENTRY / ENDPROC macros from <linux/linkage.h> but that also shows
> that we're missing commit 5d4cae5fe2ea ("[ARM] VFP: fix section mismatch
> error") from the kernel. And so I'm fine with making a TODO to clean
> this up later if you don't want to embark on something a bit more
> complicated here.
>=20

No problem for me to creating my simple patch. It's also not a problem
for me to use the required macros (ENTRY, ENDPROC). Use some similar
macros on my own projects too.

I have searched for your mentioned commit from Linux, and it's okay
when I try to add this too in further patches. For the correct
initialization from the floating point unit I must look more
precisely into the U-Boot and Linux source code.

But I have a question according the ENPROC macro:

include/linux/linkage.h (from U-Boot):
#ifndef ENDPROC
#define ENDPROC(name) \
=09.type name STT_FUNC ASM_NL \
=09END(name)
#endif

Especially the macro/define STT_FUNC. I have thought STT_FUNC is
%function, but haven't found these in the current U-Boot master
branch.

Simple search with grep on the shell:
"
jk@workstation:~/Projects/U-Boot/src> grep -R STT_FUNC
include/linux/linkage.h:        .type name STT_FUNC ASM_NL \
include/elf.h:#define STT_FUNC  2               /* function */
jk@workstation:~/Projects/U-Boot/src>
"

Also tried a much more comfortable search with the elixir.bootlin
identifier search. As you can see STT_FUNC is defined only in the
ELF header. 'include/linux/linkage.h' doesn't include the ELF
header. And I don't know if the value 2 for STT_FUNC is an alternative
usage from the .type directive. 'include/linux/linkage.h' includes
'asm/linkage.h'. I'm still a newbie with the U-Boot build process
and I think on build the machine dependent header will included
(arch/arm/include/linkage.h). Correct me if I'm wrong please.
Also there will be elf.h not included.

Maybe the STT_FUNC will defined in build process, but shouldn't
I find this in a specific Makefile with a simple search with grep?

By the I could change STT_FUNC to %function, but I didn't know
(not tried yet) if this has other bad effects.

Thanks in advance!

Kind regards,

Johannes




