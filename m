Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11B3C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E32E84C67;
	Wed, 15 Jul 2026 20:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mVR+eALZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301A484C73; Wed, 15 Jul 2026 20:39:01 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB5F84C42
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so10698806a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140738; cv=none;
 d=google.com; s=arc-20260327;
 b=ABwGndE7UxYtSjyzA3taaGlD+M+cuWHboJB3ecDNyGAv4n0pysDC0WhTW5LCINFrwz
 fpa1oFEGH0RkXmWIqK+VnIpiQBAHV5J7X9rwsg5LnvIEIP2Zs175cGZ9qSduil+JJDdF
 HdeN2kL2Icnh1BEJVZS5uHMfGSWzIXNQTrTnRSGVXhPyqV5mkeVFFwvYUM4eFIrZ6Wji
 fJ67/ff1ezJLsKcMit6j7F7LopXZWmu//xwBQXPJjfuGg2PQVwp/3HiRIaA7fULEl0yJ
 /6WqOAPqtVroOI0MxE7Llj6smq1nSjV/nNx86zkBGz7BZ4ScP0lZes1o47LPCRr0NHZ4
 xluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KWRu15duYszod2VoOo2fTOG0PwNJ5PYG9SJUXodQywI=;
 fh=iJRW8VB93FX08DrH3y1pKDG0/UVKiIyyGubq8HI//Y8=;
 b=Lr+2dqGspBLd0Pek4bfuVtR4AJksN5gKKMSnPQJiPvz65U2osIM+NM/5L7yIuVgExW
 SZFEJG+ukYSWMXWhKvVHQdjbhpyEm1qNOH+vFtpjJvz/U08Bsert6q0lP7cwaI3quNoo
 zWobAPbkxlKsLWxbPDDBdfl+wAFjE0+5Oy3WgPzYpwZHGslw8t3QcK1bUPGgNdwlrEia
 exYioh7gdRhMDPCDTh1za6bWYj9fj3fJJUhoyTZjZ1aovwc+jU2YEwBGNNlA843kjl+0
 VYD8ePDo1XNn4eqiJDfrswtJegmAKZtYEOX7qW6yEJyIepAnEhflLTR/e3J5NlRNcYKa
 CEEw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140738; x=1784745538; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KWRu15duYszod2VoOo2fTOG0PwNJ5PYG9SJUXodQywI=;
 b=mVR+eALZXENlvDmnJL8obLYA3EMqzkuJQ3B8M8nhx557RqQ6nDKzrzxW84fwQ53EF3
 jLOA4F8sGS7QTstIzfTaUe0AgfqhJ8BBQcz5f6OhccPDnR/pGlKEDSgBWKZ8ziUpE1FZ
 0WLenw5849U26e/s6ps1TJxCbF1dwcL3I6Na0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140738; x=1784745538;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KWRu15duYszod2VoOo2fTOG0PwNJ5PYG9SJUXodQywI=;
 b=PnsbODwCJMqfX7nFGPOTFke8gXHQjJct/eixCzkM74rQZnIN7n6AUx7FXs8Q4QGojv
 ypkgPfFup78RXQLsDHuBRICntVXBcla3kzJTs6IDMMdhjATNXa0Rx1kn6p9i+LuFKug5
 QboX+qxfY3gbyV1WrnwPQ4hsrQ9Iai1BIIrEAakeoaqsdVsSHpd+NOdnE8P9SeINIvbC
 AyfbFIB98ZSvr+9fhkxoDjlSUnjaRh6oIiYwkYCrDI2F4N4Rg1opADXi7MDVQedh7sA2
 nKE9iBAXw8OMcYbkkxZ4RjFTJsYoGeDODiyUHiM4bODbP6cEXQzutne9yFbbJmJjqpzV
 POYw==
X-Gm-Message-State: AOJu0YzsGbEZ4TywnnKu2d1gWWhfUSMiuA4Kbhw1JTZ79AbmCb2YGhsU
 DzDpqH1MgMA9FTZ5OxfL6khWk56qqX68DbZB3QPX0EiHoatM/vkHLisH97X1uwfKN/QNLjx1S16
 Ndhv8dpdKmdW6pIpxh3xFNHIzOUmxb0HTbNXzkKSc
X-Gm-Gg: AfdE7cnO0ITf+CIyMyOpkIcibp8OLQeDJX0nRAT/PXo7RfoExhP415WLOyivhkG1gLb
 YumieUp1LdjNNvKr2VMOdkFahjncpLrsBDb9NxvLcg7G97lRsMAKrvSW5Lfj7pcpGnqoGS/zNCs
 7OZznUATrpR36SV/cliBVyG7mi3n6NH9Rm3jNnE8fHC7WGNjAwy8d+ZfAXgxq01vbR4LnRNxCB6
 ESdLvvh0l0+BsjXcfp4Fxo3AtV6KNl4/UuHh79SrDHHYx71yzLiFM6aMoF7EYNghEqEdm0=
X-Received: by 2002:a05:6402:34d0:b0:698:1504:e3db with SMTP id
 4fb4d7f45d1cf-69e199dfa05mr2523456a12.29.1784140738618; Wed, 15 Jul 2026
 11:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
 <20260710-rinta-watchdog-gettime-v1-2-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-2-9a982fb93f49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:38:13 -0600
X-Gm-Features: AUfX_mx-2JcSoEO0RY9Zkv2uMYQ_HgoEWXkUYV1LUP-k64kkRzc2TpMP8ITDSEA
Message-ID: <CAFLszTj4n01d7pU6iphURLH=-H14JASyAaRsmOOJF4kJRGo=aA@mail.gmail.com>
Subject: Re: [PATCH 2/6] cmd: wdt: add gettimeout command
To: juuso.rinta@nokia.com
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
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

Hi Juuso,

On 2026-07-10T04:51:17, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> cmd: wdt: add gettimeout command
>
> Add support for the subcommand wdt gettimeout in the U-Boot shell.
>
> The command queries the selected watchdog device and reports its
> timeout when the driver implements get_timeout operation. This
> exposes the timeout printing added to the watchdog uclass to
> the shell interface.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> cmd/wdt.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

> The command queries the selected watchdog device and reports its
> timeout when the driver implements get_timeout operation. This
> exposes the timeout printing added to the watchdog uclass to
> the shell interface.

The command exposes the wdt_get_timeout() helper, not the timeout
printing (which stays in wdt_start()). Please can you adjust this?

> diff --git a/cmd/wdt.c b/cmd/wdt.c
> @@ -162,6 +186,7 @@ U_BOOT_LONGHELP(wdt,
>       "wdt start <timeout ms> [flags] - start watchdog timer\n"
>       "wdt stop - stop watchdog timer\n"
>       "wdt reset - reset watchdog timer\n"
> +     "wdt gettimeout - get device timeout in ms\n"
>       "wdt expire [flags] - expire watchdog timer immediately\n");

This command is documented in doc/usage/cmd/wdt.rst so please can you
update that too, in both the synopsis and the description, ideally
showing the output in the example section?

> diff --git a/cmd/wdt.c b/cmd/wdt.c
> @@ -131,6 +131,30 @@ static int do_wdt_reset(struct cmd_tbl *cmdtp, int flag, int argc,
> +     ret = wdt_get_timeout(currdev, &timeout_ms);
> +     if (ret == -ENOSYS) {
> +             printf("Getting watchdog timeout not supported.\n");
> +             return CMD_RET_FAILURE;
> +     } else if (ret) {
> +             printf("Getting watchdog timeout failed (%d)\n", ret);
> +             return CMD_RET_FAILURE;
> +     }
> +
> +     printf("Timeout: %llums\n", timeout_ms);

The code looks fine and follows the existing pattern in this file.
Since the sandbox driver supports the operation (patch 5), please can
you add a console test in test/dm/wdt.c using ut_assert_nextline() to
check the 'Timeout: ...' line? Patch 6 only covers wdt_get_timeout()
directly.

Regards,
Simon
