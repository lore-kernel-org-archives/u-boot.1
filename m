Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D14DC10DC1
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 07:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E748779D;
	Mon,  4 Dec 2023 08:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701675028;
	bh=ZYVMRE5Z9b3EBD8KfEWdvG5KUcJlFP05VkJ5BFQZFDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LePx9D4JdCEM1+ZNkknECzGzLs8EoNKXlSD8tL3et5JymN1aeK+JpxYuZzOKPQkuw
	 6C5TH5RHacvt/cSXThhfG1evSRUPJKssNjQkeJ5hwS/8yQXwj7I4LeRdoGQUFrIu7n
	 SfsBOYM+HjCI9TAFFRgL06p5ZUEoCL74CYwpbSOUMInlDx9AP2SZzPYQd2ZrScFhQC
	 BRR473FSaIKXMvfvmwQz0daGpCv6edxHnQ59dVUfTh98BvYg0IYEDjIhg6Qa8VO8Gc
	 r6h86/YDy0gwMyavfNrwd15GOEVnJ/cIvil6EOFOiLAwtqaQ3MlqsV5tFHr02wP+rz
	 60yrDIHY+JPAw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51438759E; Mon,  4 Dec 2023 08:30:26 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7472C87748
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 08:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SkFgd74d3z9sNv;
 Mon,  4 Dec 2023 08:30:21 +0100 (CET)
Message-ID: <5e4ad52c-247d-4f89-a03b-045ddf05da03@denx.de>
Date: Mon, 4 Dec 2023 08:30:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] cyclic: Disable in SPL builds
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Nikhil M Jain <n-jain1@ti.com>
References: <20231119144700.631322-1-sjg@chromium.org>
 <20231119144700.631322-2-sjg@chromium.org>
 <20231119155909.GC2513409@bill-the-cat>
 <CAPnjgZ0LDXcstrAgx8nb53Cw1=1Y8Zait-e884A5i8H5CY6hnQ@mail.gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CAPnjgZ0LDXcstrAgx8nb53Cw1=1Y8Zait-e884A5i8H5CY6hnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 11/19/23 19:23, Simon Glass wrote:
> Hi Tom,
> 
> On Sun, 19 Nov 2023 at 08:59, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sun, Nov 19, 2023 at 07:46:39AM -0700, Simon Glass wrote:
>>
>>> The cyclic subsystem is currently enabled in all build phases or none.
>>> So far it doesn't have any purpose within SPL builds, so adjust the
>>> rules to prevent it being built in that case.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>   common/Makefile  | 2 +-
>>>   include/cyclic.h | 6 ++++--
>>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/common/Makefile b/common/Makefile
>>> index 1495436d5d45..27443863bf9b 100644
>>> --- a/common/Makefile
>>> +++ b/common/Makefile
>>> @@ -77,7 +77,7 @@ obj-$(CONFIG_CROS_EC) += cros_ec.o
>>>   obj-y += dlmalloc.o
>>>   obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
>>>
>>> -obj-$(CONFIG_CYCLIC) += cyclic.o
>>> +obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
>>>   obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
>>>
>>>   obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
>>
>> This is fine, but I suspect we're missing SPL_CYCLIC as a symbol and
>> SPL_WDT should be select'ing that, same as "WDT".
> 
> Ooops I had assumed that it wasn't used in SPL but of course watchdog
> is completely migrated to it now...I will add a symbol.
> 
> BTW the watchdog Kconfig seems a little confusiing. There is only one
> board using WATCHDOG without WDT and only 3 using HW_WATCHDOG
> 
> Setfan, I wonder if some more clean-up could be done?

I fully agree that the watchdog Kconfig options are confusing. Perhaps
I can find some time in the Holidays to try to clean this up and finally
get rid of this HW_WATCHDOG stuff completely.

Thanks,
Stefan

>>
>>> diff --git a/include/cyclic.h b/include/cyclic.h
>>> index 44ad3cb6b803..d3b368dd90df 100644
>>> --- a/include/cyclic.h
>>> +++ b/include/cyclic.h
>>> @@ -11,6 +11,7 @@
>>>   #ifndef __cyclic_h
>>>   #define __cyclic_h
>>>
>>> +#include <linux/kconfig.h>
>>>   #include <linux/list.h>
>>>   #include <asm/types.h>
>>
>> Is this really needed? What's blowing up since we should have -include
>> .../linux/kconfig.h cover this.
> 
> It is the CONFIG_IS_ENABLED() when building. We have kconfig.h in a
> few other places (used by tools) too.
> 
> In file included from include/watchdog.h:13,
>                   from tools/../lib/sha1.c:25,
>                   from tools/generated/lib/sha1.c:1:
> include/cyclic.h:47:22: error: missing binary operator before token "("
>     47 | #if CONFIG_IS_ENABLED(CYCLIC)
>        |                      ^
> 
> Regards,
> Simon

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
