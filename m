Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F09C27C79
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 13:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742D8878ED;
	Sun, 16 Jun 2024 15:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NV9NsNc+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="o62aZ2Tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC7F87964; Sun, 16 Jun 2024 15:06:38 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CA4586EB5
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 15:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 1EDAE18000A2;
 Sun, 16 Jun 2024 09:06:33 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Sun, 16 Jun 2024 09:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718543192;
 x=1718629592; bh=VkZ6sXCDxBz8JIJ55OOIUaOVYWeS0VldIl+NGbm8XIc=; b=
 NV9NsNc+epGkhlmUm4JwzlI0RX2gehO/RT3OE13n973gYwgqZWYJKfZuBqa+t4Ak
 fdEFybiWbscxBA3ErB1r7mqjEQ5KaPfYF3bCRhE2amKaPjKWPdt71JlCAPt70yXX
 Y9kIuUEO5Zedki+FqIOs0FjvGqLwqtxlQk5nAOHKLv3wNP/sS0wPvIcu4Uy7jvyd
 yYLkvK8sEdPx/t7LjBhMWzCKNwkmaIXX6VTjYSTzXUzGKN//2DRifcH9EoEbOgK1
 lO+ZVWxR2h7Q7sjE9v6PoeSB4JvTbq2b2wtxC6vURdml6rAjASPOYRuTQVd1iCqP
 jPRo9m/tkSQtAtiNbBPDpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718543192; x=
 1718629592; bh=VkZ6sXCDxBz8JIJ55OOIUaOVYWeS0VldIl+NGbm8XIc=; b=o
 62aZ2Tz7iW2tZoT1O4lagLhNFn/ag5p6VusKxjCXG6yot8ycybkBnkEuz1VA1MR6
 KiVv/xnhkImTnadDRiKPbf66AvjC2umPlDf4G3dr21vGmVAKUKSStSP4JrI4I4KP
 kt8jMk80RtcdRSiBClBROlKE60qrFEFkfR3SL2zAXZbehb8f1kG3jEljGXjE+OqF
 /8Gopf6IBLjads1tyu0g89uMbzjhyIXZ0zAOnAJI6ZEgCUkHV0RCCrrxZqIe4g2A
 lqhotPUBWE5T2oMnyuwHwwi6z1uYsd4Aebx3pMyb0azTi3IVZ+tpW6q5VR2ccbpS
 kZ5wg99KacXExCGZ6sNeg==
X-ME-Sender: <xms:WONuZtc0zue7hZLbQhtymlwrgEUZPMukTczGeHeGYGQkAmNLN2c70w>
 <xme:WONuZrPFb2YJ2wa7ybPe7zwNQGdypl55HKkKLviDJIFzuTCx-g0zL0M_18jL3xJj_
 xmlYU7Q3U5yUKRLrE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedgieduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
 ufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjih
 grgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedu
 jeetleeggefhheeiheeitefhvdffjeeggfegkeeludejffekheefkeelueekkeenucffoh
 hmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:WONuZmhXmntqJaKR3ZQj9rx9QIGPEHCoviH-SeG-8CTEPdtqIQtSzw>
 <xmx:WONuZm8TAlTvzROKLwSjwKkN9Qq86eawhDelNl81V_Pq-r0T-_Ud0w>
 <xmx:WONuZpvE7wqbbB2XOh_64kkArU5_bOQ6E2vwgfK-rbZ2MFb4ZKitqw>
 <xmx:WONuZlGUhDyeR9_-d7xt-L0D0VnmaiWtrkwQf_rb8oqvtxHQ-WYQ6A>
 <xmx:WONuZjKqUcYaumytq2SuLzAebRiJHdYKsqWL9xA2M5dyFkGJ1bmBFQ-V>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6C80F36A0074; Sun, 16 Jun 2024 09:06:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <db487a2b-4e1b-44c8-b132-7547b7db515d@app.fastmail.com>
In-Reply-To: <630db8ca-d954-4fe7-b113-0057d5ba9563@gmx.de>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-7-1407e0b69678@flygoat.com>
 <630db8ca-d954-4fe7-b113-0057d5ba9563@gmx.de>
Date: Sun, 16 Jun 2024 14:06:13 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 07/16] LoongArch: lib: General routines
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8816=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:01=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> On 5/22/24 17:34, Jiaxun Yang wrote:
>> Add some common library routines for the architecture.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   arch/loongarch/lib/Makefile      |  7 ++++
>>   arch/loongarch/lib/asm-offsets.c | 66 +++++++++++++++++++++++++++++=
+++++++
>>   arch/loongarch/lib/boot.c        | 14 ++++++++
>>   arch/loongarch/lib/cache.c       | 73 +++++++++++++++++++++++++++++=
+++++++++++
>>   arch/loongarch/lib/reset.c       | 14 ++++++++
>>   arch/loongarch/lib/setjmp.S      | 52 ++++++++++++++++++++++++++++
>>   6 files changed, 226 insertions(+)
>>
>> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
>> index 3dbed94cc624..3c17b9cd85af 100644
>> --- a/arch/loongarch/lib/Makefile
>> +++ b/arch/loongarch/lib/Makefile
>> @@ -3,3 +3,10 @@
>>   # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
>>   #
>>
>> +obj-$(CONFIG_CMD_GO) +=3D boot.o
>> +obj-y	+=3D cache.o
>> +obj-y	+=3D interrupts.o
>> +ifeq ($(CONFIG_$(SPL_)SYSRESET),)
>> +obj-y	+=3D reset.o
>> +endif
>> +obj-y	+=3D setjmp.o
>> diff --git a/arch/loongarch/lib/asm-offsets.c b/arch/loongarch/lib/as=
m-offsets.c
>> new file mode 100644
>> index 000000000000..e3f4c629b63d
>> --- /dev/null
>> +++ b/arch/loongarch/lib/asm-offsets.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + *
>> + * From arch/x86/lib/asm-offsets.c
>> + *
>> + * This program is used to generate definitions needed by
>> + * assembly language modules.
>> + */
>> +
>> +#include <asm/global_data.h>
>> +#include <asm/ptrace.h>
>> +#include <linux/kbuild.h>
>> +
>> +static void __used output_ptreg_defines(void)
>> +{
>> +	COMMENT("LoongArch pt_regs offsets.");
>> +	OFFSET(PT_R0, pt_regs, regs[0]);
>> +	OFFSET(PT_R1, pt_regs, regs[1]);
>> +	OFFSET(PT_R2, pt_regs, regs[2]);
>> +	OFFSET(PT_R3, pt_regs, regs[3]);
>> +	OFFSET(PT_R4, pt_regs, regs[4]);
>> +	OFFSET(PT_R5, pt_regs, regs[5]);
>> +	OFFSET(PT_R6, pt_regs, regs[6]);
>> +	OFFSET(PT_R7, pt_regs, regs[7]);
>> +	OFFSET(PT_R8, pt_regs, regs[8]);
>> +	OFFSET(PT_R9, pt_regs, regs[9]);
>> +	OFFSET(PT_R10, pt_regs, regs[10]);
>> +	OFFSET(PT_R11, pt_regs, regs[11]);
>> +	OFFSET(PT_R12, pt_regs, regs[12]);
>> +	OFFSET(PT_R13, pt_regs, regs[13]);
>> +	OFFSET(PT_R14, pt_regs, regs[14]);
>> +	OFFSET(PT_R15, pt_regs, regs[15]);
>> +	OFFSET(PT_R16, pt_regs, regs[16]);
>> +	OFFSET(PT_R17, pt_regs, regs[17]);
>> +	OFFSET(PT_R18, pt_regs, regs[18]);
>> +	OFFSET(PT_R19, pt_regs, regs[19]);
>> +	OFFSET(PT_R20, pt_regs, regs[20]);
>> +	OFFSET(PT_R21, pt_regs, regs[21]);
>> +	OFFSET(PT_R22, pt_regs, regs[22]);
>> +	OFFSET(PT_R23, pt_regs, regs[23]);
>> +	OFFSET(PT_R24, pt_regs, regs[24]);
>> +	OFFSET(PT_R25, pt_regs, regs[25]);
>> +	OFFSET(PT_R26, pt_regs, regs[26]);
>> +	OFFSET(PT_R27, pt_regs, regs[27]);
>> +	OFFSET(PT_R28, pt_regs, regs[28]);
>> +	OFFSET(PT_R29, pt_regs, regs[29]);
>> +	OFFSET(PT_R30, pt_regs, regs[30]);
>> +	OFFSET(PT_R31, pt_regs, regs[31]);
>> +	OFFSET(PT_CRMD, pt_regs, csr_crmd);
>> +	OFFSET(PT_PRMD, pt_regs, csr_prmd);
>> +	OFFSET(PT_EUEN, pt_regs, csr_euen);
>> +	OFFSET(PT_ECFG, pt_regs, csr_ecfg);
>> +	OFFSET(PT_ESTAT, pt_regs, csr_estat);
>> +	OFFSET(PT_ERA, pt_regs, csr_era);
>> +	OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
>> +	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
>> +	DEFINE(PT_SIZE, sizeof(struct pt_regs));
>> +	BLANK();
>> +}
>> +
>> +int main(void)
>> +{
>> +	output_ptreg_defines();
>> +	return 0;
>> +}
>> diff --git a/arch/loongarch/lib/boot.c b/arch/loongarch/lib/boot.c
>> new file mode 100644
>> index 000000000000..327be16bb59f
>> --- /dev/null
>> +++ b/arch/loongarch/lib/boot.c
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + */
>> +
>> +#include <asm/u-boot.h>
>> +
>> +unsigned long do_go_exec(ulong (*entry)(int, char * const []),
>> +			 int argc, char *const argv[])
>> +{
>> +	cleanup_before_linux();
>> +
>> +	return entry(argc, argv);
>> +}
>> diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
>> new file mode 100644
>> index 000000000000..54566edef8a3
>> --- /dev/null
>> +++ b/arch/loongarch/lib/cache.c
>> @@ -0,0 +1,73 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + */
>> +
>> +#include <cpu_func.h>
>> +#include <asm/cache.h>
>> +#include <asm/loongarch.h>
>> +
>> +void invalidate_icache_all(void)
>> +{
>> +	asm volatile ("\tibar 0\n"::);
>
> According to
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.h=
tml#_dbar
> this is not invalidating the instruction cache.
>
> After loading an image into memory and before executing it we must
> invalidate the instruction cache to ensure that the newly loaded code =
is
> executed.
>
> I guess you want to use CACOP here.

Yes, I haven't thought about that yet :-(
As this series is only concerning QEMU machine, I left all cache stuff b=
lank.

I'll add it to future TODOs.

Thanks
- Jiaxun

>
>> +}
>> +
>> +__weak void flush_dcache_all(void)
>
> In cmd/cache.c we have another __weak implementation. How is the linke=
:w
> meant to know which one to use?
>
> I guess we need to fix cmd/cache.c. But that is beyond the scope of th=
is
> series.
>
>> +{
>> +	asm volatile ("\tdbar 0\n"::);
>
> CACOP?
>
> Best regards
>
> Heinrich
>

--=20
- Jiaxun
