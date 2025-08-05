Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCB1C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C1582BCD;
	Tue,  5 Aug 2025 13:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754394703;
	bh=YsFpYdD3YCgC71EXW9TDuwe8nyHsbB7E0W4D8pjJ3Ls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=n8N00hJxjz+KEW7BQBoKsH0FVqgVd8A4qoULXuyotH4lt1S3Slf0nWIJA1qSn02Ny
	 zFr/xAWnTKMYxSK05qoWbwWwJG202jMrVp0ylOh/Q0IPFuhilD/NxPjsW0NNMs6cUZ
	 NYd4j2aRfFsIEeKuxanMInYSesSuD+hmfDXsXl++LrVmIccqG7RZnDtH5w2kA//rae
	 ejfwpP1N7a3+m2NNhWIiv5tM+cWhdnvh6hAG7GrQEFvAOnyhL90Gp3ew0fYA4oFt10
	 Qg0f2tQ0WAvg19AO0VHr2oOLO95udqiHK3prNgg1Tsdg/EJjDgX83iu5RdaAyyXD8b
	 hyPg7Q+cjj2oQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82313835D4; Tue,  5 Aug 2025 13:51:42 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D29801DD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="O6G3dmpE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0A76E1038C126; 
 Tue,  5 Aug 2025 13:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754394696;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YsFpYdD3YCgC71EXW9TDuwe8nyHsbB7E0W4D8pjJ3Ls=;
 b=O6G3dmpEaY9kKoWdeBm4nXbDB01P4pg2+xDGT7Y7xsi4+GCG1S7Q3/BrmsJNOUxJJ9yRY5
 tNdSysOsNR87jLxoVC9sdlhJoUcVM11wNLQhwmybgsm930h1DHwOvI+tkrIziarr5p9WTm
 QZhxVQL2GEJmBj3bWEC3vOgCHBA22Cok2Nmgjgf/bpsKrgQSMh6MafrfZX/GAfNpuy52yN
 ayFg2bZl44qTClYW/ricTzppVhJkuh19wBvLjgJA96Px2c4F6Hz1VeiXegQIeVFSqYWRIb
 RpzvM1LP/eSnWqTrhf53RWJLcrSKJ9j57J+KbiO+jHsPhTvUUNr2I0vbxwGWEQ==
Message-ID: <c067ed87-5500-f16d-2c74-5ecae37470de@denx.de>
Date: Tue, 5 Aug 2025 13:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 10/12] test: cmd: Add simple test for i3c
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <20250728065612.6039-11-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-11-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Dinesh,

On 28.07.25 08:56, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Add simple test to check i3c controller defined in sandbox test DT.
> Basically, this test case will check validity of the i3c controller
> by probing it and perform basic commands of cmd/i3c.c
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   test/cmd/Makefile |  1 +
>   test/cmd/i3c.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
>   create mode 100644 test/cmd/i3c.c

Reviewed-by: Heiko Schocher <hs@denx.de>

some nitpick below:

> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index d8a5e77402d..d1c49e2c97a 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_CMD_PWM) += pwm.o
>   obj-$(CONFIG_CMD_READ) += rw.o
>   obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
>   obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
> +obj-$(CONFIG_CMD_I3C) += i3c.o

Nitpick: please sort alphabetical, thanks!

>   ifdef CONFIG_NET
>   obj-$(CONFIG_CMD_WGET) += wget.o
>   endif
> diff --git a/test/cmd/i3c.c b/test/cmd/i3c.c
> new file mode 100644
> index 00000000000..04baad2a4b2
> --- /dev/null
> +++ b/test/cmd/i3c.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include <dm.h>
> +#include <dm/test.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +/* Basic test for probing i3c controller with invalid name */
> +static int dm_test_i3c_cmd_probe_invalid_master(struct unit_test_state *uts)
> +{
> +	ut_asserteq(1, run_command("i3c any", 0));
> +	ut_assert_nextline("i3c0 (i3c_sandbox)");
> +	ut_assert_nextline("i3c1 (i3c_sandbox)");
> +	ut_assert_nextline("i3c: Host controller not initialized: any");
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_i3c_cmd_probe_invalid_master, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_DM);
> +
> +/* Basic test of the i3c controller for valid name as per test DT */
> +static int dm_test_i3c_cmd_probe_valid_master(struct unit_test_state *uts)
> +{
> +	ut_asserteq(0, run_command("i3c i3c0", 0));
> +	ut_assert_nextline("i3c: Current controller: i3c0");
> +	ut_assert_console_end();
> +
> +	ut_asserteq(0, run_command("i3c current", 0));
> +	ut_assert_nextline("i3c: Current controller: i3c0");
> +	ut_assert_console_end();
> +
> +	ut_asserteq(0, run_command("i3c i3c1", 0));
> +	ut_assert_nextline("i3c: Current controller: i3c1");
> +	ut_assert_console_end();
> +
> +	ut_asserteq(0, run_command("i3c current", 0));
> +	ut_assert_nextline("i3c: Current controller: i3c1");
> +	ut_assert_console_end();
> +
> +	ut_asserteq(0, run_command("i3c list", 0));
> +	ut_assert_nextline("i3c0 (i3c_sandbox)");
> +	ut_assert_nextline("i3c1 (i3c_sandbox)");
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_i3c_cmd_probe_valid_master, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_DM);
> \ No newline at end of file
> 

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
