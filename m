Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44810C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB52F81219;
	Thu, 27 Feb 2025 17:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OdsCIGYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE907810F5; Thu, 27 Feb 2025 17:26:05 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C4F81219
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fcf3a69c3cso1812117a91.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673562; x=1741278362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fc5nQcxg0FEId/eSwsFxpbR3Q3nCPpCx4P8U5rBXxiY=;
 b=OdsCIGYoBdQ2WiyXkX6w9Uu+eQOjMjyV2xhonkJT7zHLmHwlemngq0CMuCjYYShhYu
 VZL2qerPwoMQmRKE/2LbB7MgiG6mE1b3aWy2zjO3kxGuMXb3drpzla38fdsAR5RHEJA0
 0TKuM5NGbLhwrFQRKwVVz5HgZIKqIoSxefJ9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673562; x=1741278362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fc5nQcxg0FEId/eSwsFxpbR3Q3nCPpCx4P8U5rBXxiY=;
 b=dRNUAw2bweUY06G7oB62dZ0YwgtAYbjJpLf+4AqKu05PXucbdEh185u8tKWqUIdDq+
 s6HDEs53bq9xjOUJe9DNMYBQ62Zqk0lhgKLZ238nYCtlNoPJ/zpbrHxcPKUm/riLdXop
 VvppMiGuXZt2axBUAc+VIfh726FUWYOekg3sR6hqAWC2my2Okv3irw0bjgBoLgOwZ/+5
 e/dTSkXSvOYkYIyfddgwiLuidwMN3bU42y7kMyuzl3qpdwOBTofoeu2/ncH7coI6bQmr
 SJ/3rG0GJG9irMcnEVms22MY61nWJxPVqj7dIT4FImdVRo0uBylUFz8kxry20Vni+OYS
 d3VA==
X-Gm-Message-State: AOJu0Yx1V/iNuQJ9Q5X5HEFL3CAgBEUUJ/fWTLADLeeCqycAK92x1Rdc
 4V8fLx6Sh5sS4XVFiS1KPVmja0/MNkzd2fsrPXd+OzI9/8Hz6k2FvZwLYfYoITpBj9fOXiPi1p5
 2QJ4C0CpOysbvcZXXzJfdEDBye29owRA1RPfs
X-Gm-Gg: ASbGncu+so5t09Hqa3g36lwO6ltyGoaFbSgs0/83TGvCFrnVSori6PgsEeHfP/DYeND
 pnu3FVcsUzUoUGsfhAUO1h1lW9wd0/NZoHpVxa+B2HNujAjkks99mWdK3DwQ/GcSbn16P05YIDQ
 +J81cZ+HPx
X-Google-Smtp-Source: AGHT+IFzLXUT8CsL19JRn784Hx0L1QNDkmd3Y47ZZmiBDkMutCkYxJ7nePLfEQMy/T+SCozhUXuFWFtvNVqiWwuvu+c=
X-Received: by 2002:a17:90b:4d0d:b0:2f2:a664:df19 with SMTP id
 98e67ed59e1d1-2fe7e2e0719mr13684983a91.7.1740673561962; Thu, 27 Feb 2025
 08:26:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <2f17fd7ec21b59218d5bf88f045c13db08f906ca.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <2f17fd7ec21b59218d5bf88f045c13db08f906ca.1740499185.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:25:40 -0700
X-Gm-Features: AQ5f1JrkcdHCUgdZUDCKimTAmdH2ufMmjFjFV7p5zRusk7W4icxXuiheFaWwn3A
Message-ID: <CAFLszTi_p4PFNkSFk+yMLaQoSUe6pVXvGiD2UX08Ka2j0jyS1Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] test: dm: add test for spawn and wait commands
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Jerome,

On Tue, 25 Feb 2025 at 09:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Test the spawn and wait commands.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/cmd/Makefile |  1 +
>  test/cmd/spawn.c  | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 test/cmd/spawn.c
>
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index d8a5e77402d..cf47f04851c 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_CMD_WGET) += wget.o
>  endif
>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
>  endif
> +obj-$(CONFIG_CMD_SPAWN) += spawn.o
> diff --git a/test/cmd/spawn.c b/test/cmd/spawn.c
> new file mode 100644
> index 00000000000..5e0770858c0
> --- /dev/null
> +++ b/test/cmd/spawn.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Tests for spawn and wait commands
> + *
> + * Copyright 2025, Linaro Ltd.
> + */
> +
> +#include <command.h>
> +#include <dm.h>
> +#include <dm/test.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +static int dm_test_cmd_spawn(struct unit_test_state *uts)
> +{
> +       ut_assertok(run_command("wait; spawn sleep 2; setenv j ${job_id}; "
> +                               "spawn setenv spawned true; "
> +                               "setenv jj ${job_id}; wait; "
> +                               "echo ${j} ${jj} ${spawned}", 0));
> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +       ut_asserteq_ptr(uts->actual_str,
> +                       strstr(uts->actual_str, "1 2 true"));
> +
> +       ut_assertok(run_command("spawn true; wait; setenv t $?; spawn false; "
> +                               "wait; setenv f $?; wait; echo $t $f $?", 0));
> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +       ut_asserteq_ptr(uts->actual_str,
> +                       strstr(uts->actual_str, "0 1 0"));
> +       ut_assert_console_end();
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_cmd_spawn, UTF_CONSOLE);
> --
> 2.43.0
>

This doesn't look like a DM test as it doesn't use devices. Could it
be a CMD test?

Regards,
Simon
