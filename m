Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DFFC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4448181100;
	Fri, 28 Feb 2025 14:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jE8iZCeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889DE8110C; Fri, 28 Feb 2025 14:05:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BDF810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740747899; x=1741352699; i=xypron.glpk@gmx.de;
 bh=LXuVZqvaPjI8cD7qRycD+E9JU0t0BD806Rp/MxUwYQU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jE8iZCeI6hoqNYriMFXfb7tzLtIK9/E0kzufacpFeJ0bhKqpa+ULMePdROjujFpD
 bn+HoyRJow7QF8sNfz3RriEm+doZ6tH9isWoTHIh/reSZQ2hMretkzTDrre14Uxcb
 EqTOzjzK3T3rsW1FrMQ6jXHlffg6fzZp3RTTqgmr5kwkuKfbjJ5AkA9Fw+jbbSbDO
 eb4fB6djm4qN8iP0q31uIAsERoTJx/CdtEa01HP/o4x6W2Q6eM1G/ma9piJPiyL1E
 61RykdFbx6W5VXpW6XC9a3vch45unGbZ/mc867EySiyJix3n+87sS+bxVya6TNc09
 RdoEcvCBAqjOA0MrFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1t8O0W2GeB-014Xgx; Fri, 28
 Feb 2025 14:04:59 +0100
Message-ID: <7a3a4ed0-7622-4a6c-bbc6-f60dd9cd134a@gmx.de>
Date: Fri, 28 Feb 2025 14:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] test: lib: add initjmp() test
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>, u-boot@lists.denx.de
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <6eb03993def0d868874fa3fca05e1d08ddc6afd6.1740499185.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <6eb03993def0d868874fa3fca05e1d08ddc6afd6.1740499185.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/NQl0PDniRjGlhtqEjHRgrcQFFivSu6ZpuAeyQIXi6UY+ORMoeF
 nSXzJa2mc0v6QGqSi1yaN4zg9/8kaITZof3V0BwwE+GmuJj649lWcE5K1j/jj7pgqPS+RkW
 w07C4U1i552stSYky2g9LLaEnQpTBaQVP6INbF+MMIh7RtHC4SFisELyj6jvH/8f3AR4zSK
 To4jS/YTQwhRg4diDc2HQ==
UI-OutboundReport: notjunk:1;M01:P0:GAZ62Cg3AOE=;kX9IPgNqh0mj1SKFYTTwg0b458U
 XQ0XS5RxF727GwC119Hr/Y5ic0YF8SmrSrvE2NWMcftKLt9FbVuryHJNq8Py5PPPbf/lW1dl4
 v/R6zBMHWf4ydykzQ9IhklwwWgelC1RdxgdiRwC4fR/SykrFdDnIIHcKcRaTrkhB3RM2NPIkP
 V15QguXAlPoAN6ZVPgq+WmsMaJ9DU4haph5vYdqer8iQrHPIXXfZFy38IO8yrOyNfpdfrrUbw
 45BfQdnlAyuW6c7O7RzfuZTqw+KErudejxv9XPN3eB/QeqtPl1e3uCjCR1oevOaj32y0R/nCK
 CButt+PYtkfDgWLf13TnFFkY2HlO9ROgLtl7s8WdjNCMYZt3bpy2T3CUQ0ZoCHRxXFHoWpS+N
 daIM6HhxR9H5oxIYZXgrK39Tf929ZKrd9BrV9Gcbe3QvHrTtATvZMP+J1kbiL4OvYeEbkOtxe
 KVT8m3EZE+Z1Gt2i2btixw580N9tjn0CadL71FyTUXdFUY1gS+VvgpiqUxcoluFlhXA73ZMHX
 jy35/rEmVCytNZ/Da7S/aLh7AWlw21FIYnQjrKAyjpu2VrGZszEMPHIS7WwOGC0DtZwPEe8oT
 liOz3avUExLeBInk2ygUiprJf4Nxvd8A1uZvUjsG4l3iUX+7adWyb1F+GqtlUYDGwLx4PwJSh
 zjwiLL0pI8IzqOXfBUU71U05rB79hWFcULZTapd13QgyhBArB5XFX9c7MiJUeiLaS5YKFkImu
 FMiFsN6ZFTkD8nUNLOjy6o3iItzgIShXgaIbMZuU6S/m+gkpZ120nQ8CPVOjGYt4TAZgpDWLe
 41hZ3FSw5eCZ2erh7IFyI3QfQprYk8GRJKlfcsyRN8975RYdNXjDXJ9CsjoElaDQgeWtqlVd2
 Y+w1l6qfUwn1BJnVhvXF7K2FaN0Y9yiGg0xm93Rm2VaeuL3tI11KJQA2KJfuJSxwyhFLLBbZq
 3fNkHg5awlNZpak0iGhDNPDrNgJ7Hr9y++QHA6dmlnHdDjnjR63k/wY4Qdj2mt0GZV8y/j/3W
 prP+DVbp+rOb4XIl8rZambK69JGYdtMjL/W43xpGLr2ym/r72tZcG4KAazSKGs3+P+CQQGL/g
 S4oCvCitKupmeOF6zAKha3HrVrF7bwwk83peGZSMObmLr/RyBYrJztT2mKZTPDyD40MtdoqDP
 A2UvyZcZwFftjuCRv+6BYDJJFWG/P5AX39MECXtlCWm2rh3CNev+Ve2cfICB/DTJ4bxwjU9Wm
 vSXC68j/H2U2YTxvKEMFYdku2ld4i9nYb222rYPjr7DzNgMswyFthoKASkkX1AuOBp1skKALK
 oZrBWWavQlDll3L9GyhLsYzK1MazlPKdzLXOxRz+VJ6uqAlLY8Hu15LONt2BouEc4gRJspO3B
 xXw2HmsJ4w4Afhn0lw92nr170facY0bg9TgbhyLEQS3Qh+jUR1gomeeS3Y
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

On 25.02.25 17:34, Jerome Forissier wrote:
> Test the initjmp() function when HAVE_INITJMP is set.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   test/lib/Makefile  |  1 +
>   test/lib/initjmp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 73 insertions(+)
>   create mode 100644 test/lib/initjmp.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index 0e4cb8e3dfd..bf04685dae1 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -14,6 +14,7 @@ obj-y +=3D hexdump.o
>   obj-$(CONFIG_SANDBOX) +=3D kconfig.o
>   obj-y +=3D lmb.o
>   obj-$(CONFIG_HAVE_SETJMP) +=3D longjmp.o
> +obj-$(CONFIG_HAVE_INITJMP) +=3D initjmp.o
>   obj-$(CONFIG_CONSOLE_RECORD) +=3D test_print.o
>   obj-$(CONFIG_SSCANF) +=3D sscanf.o
>   obj-$(CONFIG_$(PHASE_)STRTO) +=3D str.o
> diff --git a/test/lib/initjmp.c b/test/lib/initjmp.c
> new file mode 100644
> index 00000000000..52bbda8cc60
> --- /dev/null
> +++ b/test/lib/initjmp.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0-or-later

Best regards

Heinrich

> +/*
> + * Copyright 2025 Linaro Limited
> + *
> + * Unit test for initjmp()
> + */
> +
> +#include <compiler.h>
> +#include <asm/setjmp.h>
> +#include <stdbool.h>
> +#include <test/lib.h>
> +#include <test/ut.h>
> +#include <vsprintf.h>
> +
> +static bool ep_entered;
> +static jmp_buf return_buf;
> +
> +static void __noreturn entrypoint(void)
> +{
> +	ep_entered =3D true;
> +
> +	/* Jump back to the main routine */
> +	longjmp(return_buf, 1);
> +
> +	/* Not reached */
> +	panic("longjmp failed\n");
> +}
> +
> +static int lib_initjmp(struct unit_test_state *uts)
> +{
> +	int ret;
> +	void *stack;
> +	jmp_buf buf;
> +	int stack_sz =3D 1024;
> +
> +	ep_entered =3D false;
> +
> +	stack =3D malloc(stack_sz);
> +	ut_assertnonnull(stack);
> +
> +	ut_assert(!ep_entered);
> +
> +	/*
> +	 * Prepare return_buf so that entrypoint may jump back just after the
> +	 * if()
> +	 */
> +	if (!setjmp(return_buf)) {
> +		/* return_buf initialized, entrypoint not yet called */
> +
> +		/*
> +		 * Prepare another jump buffer to jump into entrypoint with the
> +		 * given stack
> +		 */
> +		ret =3D initjmp(buf, entrypoint, stack + stack_sz);
> +		ut_assertok(ret);
> +
> +		/* Jump into entrypoint */
> +		longjmp(buf, 1);
> +		/*
> +		 * Not reached since entrypoint is expected to branch after
> +		 * the if()
> +		 */
> +		ut_assert(false);
> +	}
> +
> +	ut_assert(ep_entered);
> +
> +	free(stack);
> +
> +	return 0;
> +}
> +LIB_TEST(lib_initjmp, 0);

