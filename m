Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C04E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111F88021D;
	Wed, 18 Dec 2024 20:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="OKJr0DJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD9080291; Wed, 18 Dec 2024 20:25:20 +0100 (CET)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2CD8021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1734549914; x=1735154714; i=sinan@writeme.com;
 bh=tefeAkiVE8dAIGmTGefa6OimbHz3Nn20cjIuaWdXHR0=;
 h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:From:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OKJr0DJlnf0jeQDa/zoH/mDFpwhAFQhkb1nglsdfE/Eii+6v1voq1DjjqoBHBH/c
 MG7zaf8nWE8ZnW6EcSyy/ueTJegWnJyg5L3fsjnR2+hXYmkebktdTDRnwJ3V7Ka91
 N4WEFbwCPYlA6ybGJ2IHqPEd8k41JfLWg6vL/ybCpS2g1oJfF7sv5M7ZUMUQf53Nn
 w6POfuESIUNxExM/gyWIvjN3KymPt0R5iHmiyMSwhSwByGBqEbjvHVO2P043/947m
 cYzYGFcibROhlVKGp5ZH2APvlz1gIPLb/5mMxnDwkukkWpItsCjWBCOL/kA0M2mnn
 9b3mK4DEJUGUaTrrTg==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MTSCX-1sxuVp23IF-00IRxo;
 Wed, 18 Dec 2024 20:25:14 +0100
Message-ID: <6756ea9e-d2e7-4228-8dd2-bf855aaa131e@writeme.com>
Date: Wed, 18 Dec 2024 14:25:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] powerpc: mpc83xx: Use defined constant for SPCR[TBEN]
To: j.ne@posteo.net, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-3-8cd6daae4f93@posteo.net>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <20241215-mpc83xx-misc-v1-3-8cd6daae4f93@posteo.net>
X-Provags-ID: V03:K1:NsFPuGXUe+synXUwDqOylh5NNk355kPqg8qHDDo/iIeYWovRUEv
 fudMFF2Xlgrnb/NBdUZxlQxMVVuySi8A4aBxk6lTYUVToyGuJfeVyCKitMxJgX2fVqanB9Y
 Ea50Mt5dSzhDQuyJ7ZwMVcqblNJSgG+/TUvd//WcWDTWuWPeV6ivK9wRut5lZR6ByZcJvLm
 kR0RJLsNCuwsAr6Nfz13Q==
UI-OutboundReport: notjunk:1;M01:P0:4dG/NpVK13Q=;aE6j4E1/3U4UylYtiWjaU9KN8Ld
 ZdQU/xkjsTCLUC7HLYgWoJopyHeK7a571GKSJ8/MIWBJUTVAF/coXgEGj28yA+a2AZ1qYP24h
 O0XT7GNktgvimZvW5ObsqsRO9m9IpKP2bivuJuetwzW0ODkry5Zs4RbP1daEOXG+UhNFELCUa
 wfJukg2ZnqKW8TJdlPfrXnM559oZjLmYeGE+LOuZruiNxpNJDU+gxD4/XoP2aPHcTELH8LqRS
 QibXCtE3Lx+VIGTTuRMpe/VcuavZERUru/4L81LiLpL4ZHZLtrXgpzBeYVjcjsEUMK0cXcdIR
 qLAfSd0XCNn9q6AuVdvVvY30sXNm17ye4wWqdIVkfblC8lGDhuKMJDRSFAlgjxHaA1jjEqM40
 rMNgXlXjaGsun128EHWwyyOQzDPIy3iN2R7NvGeGOboG9rMXgiy3caFe/T5Tf39I5JHSMnB2b
 5j3o9qodR9Htwsz/nKDla+8VSvkZfuVO1Abn2bxxWgHu+l28Tfqlepu7HRF6VSfIHfHjNGh3b
 zwISQwRs4cehuAvmAQ8SOATXL9UkOfptnWr9bK3wzi7WPewdHhd1sb6eZeZSIbPqB90OeQQxV
 v34zmTQVW8TseCb6RL8IsyDJcKNN/kNqLSVnC93BdiEsRljZD7aoiCWnlsxKDgw/x6CuB9EPB
 5sFpad8GVdrOzTqB/i1D3CpqDlr5MMOKA9lLIioLRZwa/cuklh89vUsxxgmNdBw18V95Aokmb
 NlW2nWmE9j2Wkfigcc3uA4yceU25CS1+Qa1x2jPqpUyUv/O+WfbRf/5wysTEh6t5QCDDEZI3A
 CrZGglEcT+14sdgsxET+6ePE/M4dXwfE250gokaN4JI3AxFl8E/l5GpSYAftlkR1W7oJaFnQ2
 TG4n4a5r4iavIG70teyykrjn6Pswz0O08OWEbe/wwP/kN2jQ4my+ARC1ExcLV73eqhPnWruEy
 jNP//8uuAaUCFaX/3NruNaVzJLQeE8L9fCxvxV56RcA210+TSiJkAK2rHEeI8QlxlY6BYq6P3
 i4KjLLQ0gYKVU5mJTajPnXv7uL3ZiOlbKuhG7BdkhFgzJMNu7QAoRe4y3JAo6IOlw6Q2hJLC7
 Cs+VW3sb6joYixX+9jNKOv8A7cc9Ugahf3c9BVYYIDsDwn5usKMz0TAJjGpfxH0vA21lbwkEY
 =
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



On 2024-12-15 10:18, J. Neusch=C3=A4fer via B4 Relay wrote:
> From: "J. Neusch=C3=A4fer"<j.ne@posteo.net>
>
> To increase readability, use the defined constant instead of specifying
> SPCR[TBEN] as a number.
>
> Signed-off-by: J. Neusch=C3=A4fer<j.ne@posteo.net>
> ---
>   arch/powerpc/cpu/mpc83xx/interrupts.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/cpu/mpc83xx/interrupts.c b/arch/powerpc/cpu/mp=
c83xx/interrupts.c
> index af517213f176cf59cc82b54dbe5247800a6c40e6..bb37a1332c877951e766a889=
1687dae3f05b6ef8 100644
> --- a/arch/powerpc/cpu/mpc83xx/interrupts.c
> +++ b/arch/powerpc/cpu/mpc83xx/interrupts.c
> @@ -12,6 +12,7 @@
>   #include <asm/global_data.h>
>   #include <asm/processor.h>
>   #include <asm/ptrace.h>
> +#include "initreg/initreg.h"
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> @@ -29,7 +30,7 @@ void interrupt_init_cpu (unsigned *decrementer_count)
>
>   	/* Enable e300 time base */
>
> -	immr->sysconf.spcr |=3D 0x00400000;
> +	immr->sysconf.spcr |=3D SPCR_TBEN_MASK;
>   }
>
>   /*
>

Reviewed-by: Sinan Akman <sinan@writeme.com>
