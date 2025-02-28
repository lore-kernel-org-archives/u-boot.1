Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45340C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9924C81113;
	Fri, 28 Feb 2025 13:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JyzCPPTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACE081120; Fri, 28 Feb 2025 13:39:25 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0385B81100
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6fb9dae0125so18426717b3.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740746362; x=1741351162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=37Au5Y3vlV99sxDJCFVMynv6u/aXL+WKjhEs/TUCnIM=;
 b=JyzCPPTTyzgNzxDvFpVf5ebIONUGaF6BkO6Gdm/4Z5cmBJEJ+hf06l/2mlQccXfHAw
 +rb9uMWJwI2v2TWiWQdSPAVzcRsHxZ/rSr82xaBC5ybd+amw4dxIDaX+fBuEcolw5JRe
 CrQWb6Luzu3h6PgtH9kCbdSaoCrLNH+PtssmqrRhPzrPUUl3i9AytG4a+I9G586RNhrZ
 bFm9ggkANExc7mNAI+VeET8J8/qmsTmn+h7tsAOZxGMz+21oiK3pP55pJmvieLPODoe5
 2Wfk5b+vD5gqbnwzMJk4fMYpy9888rjrp9LBONpMgPoDLoFEYr5KJFabr7zefTkXI+Ac
 KbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740746362; x=1741351162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37Au5Y3vlV99sxDJCFVMynv6u/aXL+WKjhEs/TUCnIM=;
 b=nWbokgdY+BcvS2Sf+wRl15LZ96rXM8TEP90ZlkbSunydGQwIpYs0vpwl8gIJ1lFJaw
 38xOFlDZPxv8zfxnpStDwzYDFfVsNV+35Vq7V4d1pagBVZlORvGbe97h3gnDLjMIzT8w
 PkIg4GCelqTP+x+j5f4xtOirFyRzml/FhnE6R6Uw0r1dyleqwvS+iNjMRKsnyTZwnarV
 b5y+qIm0kVl3qBa0p0R5EMdTivPykJa53Lq/pJyNO14ml21qnEpVoPao2/LEEd3eMbfM
 4W7FZjGFj6SUULvgl4TS4A6I+etQ1InFQoReLCV5ZtGIaCvlfw8j/3xIb91eHAqDrx+T
 19ig==
X-Gm-Message-State: AOJu0YxLjb+JUwf9Dv8Dm3Eeix25Q2ILiyhSctYN/OmAA12ejxFX6hj0
 30586PUdymqCBErG0vLWDYDNAJeSPagbm3Y0VyKEnA5KAIVGnpPnisSx3wCDD+oL9jUBGAeq95D
 RbQ16JAYz2PUPHFM2uJtBUQPyROiNlNXnlrZ3uQ==
X-Gm-Gg: ASbGncv/k9Ytp5qOuhbqNvus3WlRXTkTMhgCXO6ALEQLLn2AfxRNO32tpLmEMvljimn
 ag2oZLuxqwmWTNv5D2SQhjCBVRfaa4RI2XF7kbF4E/UcjXWU1sqMuHwWCvSBI3YzwmBa+7Qzdum
 oVJDdbvoMUslJN3G+742oM1/q/abo00ElTGC0BXNk=
X-Google-Smtp-Source: AGHT+IElNVqSoIKPhfvGWlHtnM0ij9+tOxdbHmgdE+D/etW1rANe/qlCa4uNqmQeXCvajB6HEPSJO+bwwjlHiuPf1iQ=
X-Received: by 2002:a05:690c:6009:b0:6f5:3e17:7ea5 with SMTP id
 00721157ae682-6fd4a02fef9mr42508967b3.7.1740746361846; Fri, 28 Feb 2025
 04:39:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <6eb03993def0d868874fa3fca05e1d08ddc6afd6.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <6eb03993def0d868874fa3fca05e1d08ddc6afd6.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 14:38:45 +0200
X-Gm-Features: AQ5f1JrRDc8IIQFPJw3ikdk6hqKg7a6TEtebsiEv1pepz5M3WdVNv8PNCo7jisg
Message-ID: <CAC_iWjKYxReDawvp3oT9y_rQzYcjiaO15B2BwFzx9gT6kty7QQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] test: lib: add initjmp() test
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Test the initjmp() function when HAVE_INITJMP is set.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/lib/Makefile  |  1 +
>  test/lib/initjmp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 test/lib/initjmp.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index 0e4cb8e3dfd..bf04685dae1 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -14,6 +14,7 @@ obj-y += hexdump.o
>  obj-$(CONFIG_SANDBOX) += kconfig.o
>  obj-y += lmb.o
>  obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
> +obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
>  obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
>  obj-$(CONFIG_SSCANF) += sscanf.o
>  obj-$(CONFIG_$(PHASE_)STRTO) += str.o
> diff --git a/test/lib/initjmp.c b/test/lib/initjmp.c
> new file mode 100644
> index 00000000000..52bbda8cc60
> --- /dev/null
> +++ b/test/lib/initjmp.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+
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
> +       ep_entered = true;
> +
> +       /* Jump back to the main routine */
> +       longjmp(return_buf, 1);
> +
> +       /* Not reached */
> +       panic("longjmp failed\n");
> +}
> +
> +static int lib_initjmp(struct unit_test_state *uts)
> +{
> +       int ret;
> +       void *stack;
> +       jmp_buf buf;
> +       int stack_sz = 1024;
> +
> +       ep_entered = false;
> +
> +       stack = malloc(stack_sz);
> +       ut_assertnonnull(stack);
> +
> +       ut_assert(!ep_entered);
> +
> +       /*
> +        * Prepare return_buf so that entrypoint may jump back just after the
> +        * if()
> +        */
> +       if (!setjmp(return_buf)) {
> +               /* return_buf initialized, entrypoint not yet called */
> +
> +               /*
> +                * Prepare another jump buffer to jump into entrypoint with the
> +                * given stack
> +                */
> +               ret = initjmp(buf, entrypoint, stack + stack_sz);
> +               ut_assertok(ret);
> +
> +               /* Jump into entrypoint */
> +               longjmp(buf, 1);
> +               /*
> +                * Not reached since entrypoint is expected to branch after
> +                * the if()
> +                */
> +               ut_assert(false);
> +       }
> +
> +       ut_assert(ep_entered);
> +
> +       free(stack);
> +
> +       return 0;
> +}
> +LIB_TEST(lib_initjmp, 0);
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
