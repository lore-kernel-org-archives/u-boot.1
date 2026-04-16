Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A7CF8D765
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 18:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3678984228;
	Thu, 16 Apr 2026 20:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MVIhZxH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175128423F; Thu, 16 Apr 2026 20:51:35 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DE184223
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 20:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35fb166b0c6so544433a91.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365491; cv=none;
 d=google.com; s=arc-20240605;
 b=L3kYlNTOb8+CLw+vttwNpXLknHTR46xdLhqLEoVuY2brZruzcnVn2XUBcWkWDubbHY
 PXoVoCbGAjV6E/MUmnR5Qdrp5r8/MwYSsHqDhmu+CuFIjVjhu/yx4hAiBzY2wVdWFMWp
 sEnGiT8dm6ptLZHLYGH6fHu9gWwU20+uWi4OuaMp85xpoCFyTX7Z6OjLnsesuHrEWtjO
 cewJgqHfm1ec7GBggvxVYpKyaucqdtFAZ++mcqzzGvdW8ZQiZPPbl/f6SpxcTbbMcKyC
 Wyw0p5pMC89gnFoBCfBJuypsWxTvI6pHvB5EsxVgbvohJ3exvDbmCFbLlDBxwtgRBaPv
 wyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=78kCEmVn4JPYRAoPo2yqphjtySONlr++xa0fR6PjN7c=;
 fh=s9Lt3w64TAkHKFDbt+9kT1Eei+RajGoFuxA1RXbRw0E=;
 b=Uhf9YqW6pWkmKgCIbrzh0roLg66DYkljeRyEXi9kRFxJ3/f0LPpBONTgC7qxmFgeAn
 cgoBtd2XeN2T4KiO2ir1TJ7C2WA9cgp13/wC/379mrcuNay3YSebWgzhG3HqSIKHlQIK
 dqzymjJXcFnSBRKG/s/tZrDloxaYIsZZtUgWFEMFdrNFHLgA2DUoPmct2/iT7dT/jrFb
 hPT5/fOXr4R0xBnGkQ+icvyufBpjuhKJFZVlpm0dmQEsCUbvMnolbxNQXiSCKDfgsPW/
 ZJ4GIzZode5XENrB26r9FQprDOS0OUkZGSUkKnwMYOcqiFRHRw0c6FUpaqQI/v2ZjuEP
 gerw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776365491; x=1776970291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=78kCEmVn4JPYRAoPo2yqphjtySONlr++xa0fR6PjN7c=;
 b=MVIhZxH5XQ6gbSe363xD2+M2Bdwy2NHsby0sTeUy6uUC5yXeWxx2HGlX2pmUVf/MHS
 J6/vHbsyc0QbphjMV89SlIzfoMUP6ofENCHqdmA6tZz+R+qYZQw/ALYZkt7YuGDDd8eN
 /qKHcWIwcy9UkMSzbp4b3maiqv8If+bxjSH+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365491; x=1776970291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78kCEmVn4JPYRAoPo2yqphjtySONlr++xa0fR6PjN7c=;
 b=YjLv0zW/6il+dJMVKqWbk6pkmP4kNJJK62GFw142q3GrmPFctBZrtesuiy7CU/adgg
 yQFRTfroXOkbfDXdG/OSkA2d70Y/rF+CFPKMlXvuMI03QAyntLP7Xj4pFzu/4VvgxgaX
 LfPrB4JV48iqzTrs/TtzcoLGWRj3tF2hlu/XXy7epedVMfwq1+AO/A18x7Rnm6MdQTla
 In0m+Fftf7jwSvTzbSrTiDhA3luRzStj7A2tS81DxouGJ1+WMOOiguoalazw2rYrHbiH
 mFyHmm2ep3d04jiQCBPRTH4/UY8BK3pUdtheKIYMtl8Ry9Du4tUJCK7HrSo38TGNhbKa
 HfGA==
X-Gm-Message-State: AOJu0Yxo465Sc48+NmIIcmhJRGP7EYj2X/ua/dJjjoRTg7gWx+KULV0x
 ialGfY3RVn+M3pW1PzV8ID3vZvAIfJs2mce0EhIVrsKF+Fsc+G88qzLybHX3/c8Yn4JL2Ftq3xT
 WnqawtaaOVZtstnyGIu0ejYM8LJiIvWRhi0wjheLl
X-Gm-Gg: AeBDieuxzgfm/SMVhCU4WxImAMZHMrC2jdQeav4jwBHjcE1ZRGWJOLkdNLLvRdjEcVG
 +xgYQ+5f8SF5yDCtJdIJQYg2rzalrn9HtdLB+Odbem4CrNm+1rS4pQD48IB1+f9kgJEIMoNiLYC
 doKvD5U7OeG+HBtniKu89JymlCZbeocDjEa37RN4uaclqraLm4+U1LeA9kIFtsxBLjjsYm+s21+
 ChM+64Jsy5DddhhSUXilq95OcXlMU/PrguEpy1k202yUDQ2f/e4jUsJ+WpXRODn2s8GDHN6AaiK
 Vm0i6/15CRvHCslAbL4y
X-Received: by 2002:a17:90b:390b:b0:35d:aa02:d776 with SMTP id
 98e67ed59e1d1-3613e212386mr354480a91.2.1776365490788; Thu, 16 Apr 2026
 11:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
 <20260415183250.3031030-4-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260415183250.3031030-4-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 06:51:05 +1200
X-Gm-Features: AQROBzC2NKQq66PN5C2-EwMXMJ9Ve3cfdJ1-1C1T9KGV3PzE1BtuIfu0n_zavFs
Message-ID: <CAFLszTi07U8fH2D0YWc00UgXuYKD=PpX7xdfEmOkSHfRy_QvVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] test: cmd: add unit tests for part command
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Dario,

On 2026-04-15T18:31:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> test: cmd: add unit tests for part command
>
> Add unit tests for the 'part' command, specifically for the 'number',
> 'start', and 'size' subcommands.
>
> These tests establish a baseline for the current partition lookup
> functionality by name. This foundation will be used by subsequent
> patches to extend the command, ensuring consistent behavior as new
> features are introduced.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> test/cmd/Makefile |   1 +
>  test/cmd/part.c   | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 162 insertions(+)

> diff --git a/test/cmd/part.c b/test/cmd/part.c
> @@ -0,0 +1,161 @@
> +#include <dm/test.h>
> +#include <env.h>
> +#include <part.h>
> +#include <test/ut.h>
> +#include <vsprintf.h>

Please include <test/cmd.h> and use CMD_TEST() instead of DM_TEST().
This places the tests in the cmd suite rather than the dm suite. See
test/cmd/hash.c for an example.

> diff --git a/test/cmd/part.c b/test/cmd/part.c
> @@ -0,0 +1,161 @@
> +static int dm_test_cmd_part_number(struct unit_test_state *uts)

With the change to CMD_TEST() please rename the test functions
accordingly, e.g. cmd_test_part_number().

Regards,
Simon
