Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDAAC27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 16:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB8E878ED;
	Sun, 16 Jun 2024 18:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dfKkZ+Du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1031D87CDA; Sun, 16 Jun 2024 18:00:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B076487837
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 18:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718553622; x=1719158422; i=xypron.glpk@gmx.de;
 bh=gELZdf4bw9TDKS+mkDB5JAaju9OgQK4e37zg2ATMoIA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dfKkZ+DuQUVoZk9qonFQS+tfKKqu7aqBfpnW/39czY8UrzxTZ3CP/54Zh8ntNirc
 x23ebqufWCGsMlXYPYDrC20WuqOS3ERbY0c0yF1jEMaQGFeK0fEcSvD+1bcbAPPS8
 vpA1cEV1tZFA7hPkSVHZ+/0BMPN3xJcYyj8xQvnu8+DDqFLw0Z76nRv/IHSTHDqLj
 dqES//RnMjAE71PA9dJxpAhliKmO3RKVL6e9pRmUkGL02cd7y85YLIeZ4tA6E8Guq
 oRf64bRyVF5kzlLoBFKCBYRg38cHBH7GOiKq63shRW6JXljwrckQv3X7yJ3i6p/Hy
 cH6GLzLnZZfaeZHhfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1seHAL1zG7-012LNJ; Sun, 16
 Jun 2024 18:00:22 +0200
Message-ID: <bed8f4d9-957a-4e18-a9e2-8e52db4a60c8@gmx.de>
Date: Sun, 16 Jun 2024 18:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] LoongArch: lib: General routines
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-7-1407e0b69678@flygoat.com>
 <630db8ca-d954-4fe7-b113-0057d5ba9563@gmx.de>
 <db487a2b-4e1b-44c8-b132-7547b7db515d@app.fastmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <db487a2b-4e1b-44c8-b132-7547b7db515d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZS4R4qg5A3yNeERIeTX4wla78hs3p10D2a6bEYYqBA3WLVLweea
 OLaOK6AWNAA7b5NnPKm1gEI9N5atcWYh7pYn2DoWF2QBEz4dFK4D/3tzQT6vZ6RNkUilpL1
 z9KJR4FO965WOpeRwx/Lj3h6KLWtL5666ERhpj2F6VFPQ9A5K0MpNiOMelt9G08ntdtJJ+H
 3kb6fX/04ax+GEQ8yyNjA==
UI-OutboundReport: notjunk:1;M01:P0:vhvo24STfew=;wBIewssjvaI5xffnW9jt015uP7V
 NRzPsVStQt0dDAEoybts8ikOROVFPz/sDaw0YImh6m62N1p8I6vlmJfaotyjXpYfjqbbOvOY8
 Hr2eIYxbKWy6tzA1eFyJBrJhSeAvBZJqJlqIPSYqnoWG8eiSS/MHWbcgz4N4eGDxPEqLDEQdu
 z8GMU12XgkSCHwhQ5mQKdVdL6gedQsUty3eCk5/igQO4GoZiZMEKiNQxOHYrNL6fKNw0ewtWu
 DwpTuzUIg3uPZjSYTCuDCtc9CJjJgYkKXTnorxhbjK90NqRdK08oV/gkqfm/Mw1ejmlC+L6qS
 HID8PgzHokDL2JaPhnM83+3KkAWd0ev4xQBC/7G56rJNes7S/0Hiyf5nZuWldia4T3SZ7eA2b
 yJWX9IH8g5wwQLNTGaKMemalBWM5jfjKmqLGbwoLG+OV4FlQKZzcR/buwUxm347V1qCU/tID+
 klaVucJBrdJbpiHYp/MMUqvnFpC50E4IahbLMidTCpxChKS77zfvl1j2IHjFkT+Lb4ldmgI8E
 OiRXxgIc66ZoKQmE+j8SpBZtNbDK9ickG04I3CCf9E9QtuVG3u1Ln0N6nP0LXymQtSCCJQGg+
 n7IJ0oTakwLNC6JtcalVyBePqKI2MN+BK4Y4BD7t7VU9ZuvA7ByvusAHPJqRrw0MtmPgZy/mC
 v9/3y/M46lWTulPco7oDW65WJQYYj0LlpvIfpgbccVxGCPND5/aPaIIsnsxZSJNPvbRu7nXro
 B/qR55AVF5dE0cKv5zJlWErKd+90c9Jnxl9kel3itTZfsHzpX08wVt8b63svmKHLVySdAddTN
 qwTXDmgnjNX509HkQJVdbR1Wfj1LQf7PcMcIzoeMyQ+vc=
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

On 6/16/24 15:06, Jiaxun Yang wrote:
>
>
> =E5=9C=A82024=E5=B9=B46=E6=9C=8816=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=8812:01=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
>> On 5/22/24 17:34, Jiaxun Yang wrote:
>>> Add some common library routines for the architecture.
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>>    arch/loongarch/lib/Makefile      |  7 ++++
>>>    arch/loongarch/lib/asm-offsets.c | 66 +++++++++++++++++++++++++++++=
+++++++
>>>    arch/loongarch/lib/boot.c        | 14 ++++++++
>>>    arch/loongarch/lib/cache.c       | 73 +++++++++++++++++++++++++++++=
+++++++++++
>>>    arch/loongarch/lib/reset.c       | 14 ++++++++
>>>    arch/loongarch/lib/setjmp.S      | 52 ++++++++++++++++++++++++++++
>>>    6 files changed, 226 insertions(+)
>>>
>>> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
>>> index 3dbed94cc624..3c17b9cd85af 100644
>>> --- a/arch/loongarch/lib/Makefile
>>> +++ b/arch/loongarch/lib/Makefile
>>> @@ -3,3 +3,10 @@
>>>    # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
>>>    #
>>>
>>> +obj-$(CONFIG_CMD_GO) +=3D boot.o
>>> +obj-y	+=3D cache.o
>>> +obj-y	+=3D interrupts.o
>>> +ifeq ($(CONFIG_$(SPL_)SYSRESET),)
>>> +obj-y	+=3D reset.o
>>> +endif
>>> +obj-y	+=3D setjmp.o
>>> diff --git a/arch/loongarch/lib/asm-offsets.c b/arch/loongarch/lib/asm=
-offsets.c
>>> new file mode 100644
>>> index 000000000000..e3f4c629b63d
>>> --- /dev/null
>>> +++ b/arch/loongarch/lib/asm-offsets.c
>>> @@ -0,0 +1,66 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> + *
>>> + * From arch/x86/lib/asm-offsets.c
>>> + *
>>> + * This program is used to generate definitions needed by
>>> + * assembly language modules.
>>> + */
>>> +
>>> +#include <asm/global_data.h>
>>> +#include <asm/ptrace.h>
>>> +#include <linux/kbuild.h>
>>> +
>>> +static void __used output_ptreg_defines(void)
>>> +{
>>> +	COMMENT("LoongArch pt_regs offsets.");
>>> +	OFFSET(PT_R0, pt_regs, regs[0]);
>>> +	OFFSET(PT_R1, pt_regs, regs[1]);
>>> +	OFFSET(PT_R2, pt_regs, regs[2]);
>>> +	OFFSET(PT_R3, pt_regs, regs[3]);
>>> +	OFFSET(PT_R4, pt_regs, regs[4]);
>>> +	OFFSET(PT_R5, pt_regs, regs[5]);
>>> +	OFFSET(PT_R6, pt_regs, regs[6]);
>>> +	OFFSET(PT_R7, pt_regs, regs[7]);
>>> +	OFFSET(PT_R8, pt_regs, regs[8]);
>>> +	OFFSET(PT_R9, pt_regs, regs[9]);
>>> +	OFFSET(PT_R10, pt_regs, regs[10]);
>>> +	OFFSET(PT_R11, pt_regs, regs[11]);
>>> +	OFFSET(PT_R12, pt_regs, regs[12]);
>>> +	OFFSET(PT_R13, pt_regs, regs[13]);
>>> +	OFFSET(PT_R14, pt_regs, regs[14]);
>>> +	OFFSET(PT_R15, pt_regs, regs[15]);
>>> +	OFFSET(PT_R16, pt_regs, regs[16]);
>>> +	OFFSET(PT_R17, pt_regs, regs[17]);
>>> +	OFFSET(PT_R18, pt_regs, regs[18]);
>>> +	OFFSET(PT_R19, pt_regs, regs[19]);
>>> +	OFFSET(PT_R20, pt_regs, regs[20]);
>>> +	OFFSET(PT_R21, pt_regs, regs[21]);
>>> +	OFFSET(PT_R22, pt_regs, regs[22]);
>>> +	OFFSET(PT_R23, pt_regs, regs[23]);
>>> +	OFFSET(PT_R24, pt_regs, regs[24]);
>>> +	OFFSET(PT_R25, pt_regs, regs[25]);
>>> +	OFFSET(PT_R26, pt_regs, regs[26]);
>>> +	OFFSET(PT_R27, pt_regs, regs[27]);
>>> +	OFFSET(PT_R28, pt_regs, regs[28]);
>>> +	OFFSET(PT_R29, pt_regs, regs[29]);
>>> +	OFFSET(PT_R30, pt_regs, regs[30]);
>>> +	OFFSET(PT_R31, pt_regs, regs[31]);
>>> +	OFFSET(PT_CRMD, pt_regs, csr_crmd);
>>> +	OFFSET(PT_PRMD, pt_regs, csr_prmd);
>>> +	OFFSET(PT_EUEN, pt_regs, csr_euen);
>>> +	OFFSET(PT_ECFG, pt_regs, csr_ecfg);
>>> +	OFFSET(PT_ESTAT, pt_regs, csr_estat);
>>> +	OFFSET(PT_ERA, pt_regs, csr_era);
>>> +	OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
>>> +	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
>>> +	DEFINE(PT_SIZE, sizeof(struct pt_regs));
>>> +	BLANK();
>>> +}
>>> +
>>> +int main(void)
>>> +{
>>> +	output_ptreg_defines();
>>> +	return 0;
>>> +}
>>> diff --git a/arch/loongarch/lib/boot.c b/arch/loongarch/lib/boot.c
>>> new file mode 100644
>>> index 000000000000..327be16bb59f
>>> --- /dev/null
>>> +++ b/arch/loongarch/lib/boot.c
>>> @@ -0,0 +1,14 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> + */
>>> +
>>> +#include <asm/u-boot.h>
>>> +
>>> +unsigned long do_go_exec(ulong (*entry)(int, char * const []),
>>> +			 int argc, char *const argv[])
>>> +{
>>> +	cleanup_before_linux();
>>> +
>>> +	return entry(argc, argv);
>>> +}
>>> diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
>>> new file mode 100644
>>> index 000000000000..54566edef8a3
>>> --- /dev/null
>>> +++ b/arch/loongarch/lib/cache.c
>>> @@ -0,0 +1,73 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> + */
>>> +
>>> +#include <cpu_func.h>
>>> +#include <asm/cache.h>
>>> +#include <asm/loongarch.h>
>>> +
>>> +void invalidate_icache_all(void)
>>> +{
>>> +	asm volatile ("\tibar 0\n"::);
>>
>> According to
>> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.ht=
ml#_dbar
>> this is not invalidating the instruction cache.
>>
>> After loading an image into memory and before executing it we must
>> invalidate the instruction cache to ensure that the newly loaded code i=
s
>> executed.
>>
>> I guess you want to use CACOP here.
>
> Yes, I haven't thought about that yet :-(
> As this series is only concerning QEMU machine, I left all cache stuff b=
lank.
>
> I'll add it to future TODOs.
>
> Thanks
> - Jiaxun

The "LoongArch Reference Manual" is available at:

https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#=
_cacop

What irritates me in
2.1.7.1. Cache Coherency Maintenance of Instruction Cache
is the word *can*:

The Cache coherency maintenance between the instruction Cache and the
data Cache within the processor core *can* be implemented as hardware
maintenance.

Maybe you have to consult the Chinese version.

=E5=A4=84=E7=90=86=E5=99=A8=E6=A0=B8=E5=86=85=E9=83=A8=E6=8C=87=E4=BB=A4 C=
ache =E4=B8=8E=E6=95=B0=E6=8D=AE Cache =E4=B9=8B=E9=97=B4=E7=9A=84=E7=BC=
=93=E5=AD=98=E4=B8=80=E8=87=B4=E6=80=A7=E7=BB=B4=E6=8A=A4=E5=8F=AF=E4=BB=
=A5=E5=AE=9E=E7=8E=B0=E4=B8=BA=E7=A1=AC=E4=BB=B6=E7=BB=B4=E6=8A=A4

The cache consistency maintenance between the instruction cache and data
cache inside the processor core *can* be implemented as hardware
maintenance.

Best regards

Heinrich

>
>>
>>> +}
>>> +
>>> +__weak void flush_dcache_all(void)
>>
>> In cmd/cache.c we have another __weak implementation. How is the linke:=
w
>> meant to know which one to use?
>>
>> I guess we need to fix cmd/cache.c. But that is beyond the scope of thi=
s
>> series.
>>
>>> +{
>>> +	asm volatile ("\tdbar 0\n"::);
>>
>> CACOP?
>>
>> Best regards
>>
>> Heinrich
>>
>

