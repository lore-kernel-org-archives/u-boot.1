Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB83C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40E5C60A3F;
	Tue, 28 Jul 2026 18:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MXnO3roXcxGp; Tue, 28 Jul 2026 18:51:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B523B608FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264702;
	bh=rWOakFVyAzLDpntO3kMPV5Mr1IcWfCzbf3qQxoAxKF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wdkXLWeMDi1JevqEDT9aBi7wh+09J3bXoTz8+ikAsnNEwFqIFBz5Nklehl+fjXbPf
	 lY1z3m8kSmm1pSLFX9rP1hfg9sD6h8T1P+Ww8Ko9m2aiWGZm6OvZz2wqILWh270b6P
	 hgBjDZtozUo98xY4yaYkfCq0QbQzoc099fx429akZ4bJ7YpHdxO+J2QyqGaifSXObm
	 ndDhi0V7yiJNzjtyUr2xOAHovZkZ1pGiDDRuGnWZyC2PKPH3xaIZsF7V2vY9n6e26G
	 Ha1R6QvGnqY0dqAyFGwUF1yGWyFni3rSHshOWO+DmLs177PDqiZjorg0Cf4vNiwA14
	 rBGh4XqH/e3+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B523B608FB;
	Tue, 28 Jul 2026 18:51:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EC0745B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80B5281316
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5i7br_KZhawA for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:51:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B00A881376
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B00A881376
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B00A881376
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:40 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so133643a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264699; cv=none;
 d=google.com; s=arc-20260327;
 b=Yp3XwOJrRTbtZeH/eBvlbVtQ5+AhUWbGv3WWknNy0LuPuGXK3RB+HIJGC8prxn6ttk
 3cXIXii1ab7Orem90Huhesa3SMFJRro+rL4u9j6L7ZVxr7kym+MBshnWBbKPxtwZVWx1
 NjtCAZzi/mtUTx4Mt906FfKkDPJNZpnSkJwpIoXlrHYNFdxqm6Pc6IvAfeaSKfkUsT2b
 8wr68Zgjh4MSUMInbuWKR8kgIXC6EwmGFZcK0H807GKYk2ZjLscskR4Dp9iQRUNtXhVN
 jTmFgrwyVRpx6d+OUJ1fxReC/kHjQbEN3Z2kKrVEnT0zr1StXQ8B17Wba9PYcCOQGrvU
 qECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rWOakFVyAzLDpntO3kMPV5Mr1IcWfCzbf3qQxoAxKF4=;
 fh=CAgpSjstruWWmQuqkz7+XEa4heionEzgA7WD/L3A7kI=;
 b=EmksWuMHhNlmvaf0Lj6NW6kkzAHX8BeYGfsEOIL2VUzKDIpYd0pRLntD1rJNalRKGq
 c9EC+WcRa9xG4VkNUIcYEMX1JSZqhd8UT3PQHHZBYBgKyqzBMMocZ/aUXjlZ+FzNnBO5
 eUUfUU10xdSUIptS2W9PTcTAR2o5B+rL0zAtDcZUvLVCrvlG5EMdbQtwfyhpuk6D0tDj
 oMV4uFEei0fiPt4AGk5Zh0KKwVgbzmwvdJ4Ml13ljY8mvwnl4tNSA8C0Vlx8N3TnlOwm
 fRd27xBaWHyN8mBdlJAEQ87SHSIQqwpNcaRdMYo5bPKBYxPx3s37Z6RiD0dzstxkiIuC
 J6hA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264699; x=1785869499;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rWOakFVyAzLDpntO3kMPV5Mr1IcWfCzbf3qQxoAxKF4=;
 b=X1T88OFpbzLWm+AkEA+A8niitZwqq3py0z8z7lhOuciwaMjXITl/ODZEzwRJjvLGcx
 x9lFbdsUjhElSpWbi2woy0eZXxmKtOcA5C7U+5O9bEc/DH6m0vOoAEfIXLeyQFEfocTk
 fWV7N/4JSfF7AtK5CQTqVttDskyn977WNrvx5NN2eoGB61B1MQ7rordLYG/sYYu3AJ/X
 2nkDJAaSz2hSO5K7pL6qUTdigQ+3rvNL7kYtRDaAm3i4a77vscyRixLHgZxaC2XnrnpR
 7M3G7qsFEhg4dWhIKvig0TVWkKd468F4k2B9MzsUXvBHdyACV7Pm6tR6PaYRxQ58en6d
 /zzA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rost2aX14gsFXMwHHTinLNJk+Y/aNv6FpvvsvufrbUaJkqYAiHPKMoOIz7y2sn1E3d0CJAIbm4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzGHtRtCRolx/Bwa9T1Xn25S8XEoqQL9z9j9iCeR3XZ4PkX7YK0
 S/WdR9ZopCxRNmj4C5xYjJhY9hg5ot+U/fvpSwBgDvozMRQAyF1FWJSkorNW/xRHmDu2LZXzU89
 jZLGgHrplVLIV4vHQe+vi0rZ8+LMlo7qxzOZgQgRM
X-Gm-Gg: AR+sD13tQfkYzjJGm2cf4diaEcHz9a1JAsHtk1zMoeWWR96jJz7LNiPQN4Q06bj4QA2
 tSEL5PgsARyp9t0ACOqzQooVRq6uPN6c2d0gviKkazb4JG4oA4EnX4XTk2kyGkYKJ1yqn9VLLZ0
 PA9RBiMIAUJLHd2EjDm26qoFwWpxKBK2G8XAb7L7jzZ8M5gRBmLzy3W26tf1FjJxRUMA/Er5dar
 Zyd8AX3YtS3LOuXbEurYvd2GUanNRQZUqjoXp0xGKgbbGJyGiJDFrYFu72y
X-Received: by 2002:a05:6402:5485:b0:69f:4a9e:a872 with SMTP id
 4fb4d7f45d1cf-6a034a79af4mr1966427a12.37.1785264698761; Tue, 28 Jul 2026
 11:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
 <20260726115702.15397-4-bhargavdas100@gmail.com>
In-Reply-To: <20260726115702.15397-4-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:51:26 -0600
X-Gm-Features: AUfX_mxj575RPAxpl1Krc8ZYmZhkc9C7xI4xeMemGHlu4MbLcDPMHNEIJBh-Hgo
Message-ID: <CAFLszThd=3-AbJt4fJ+ekh-0HQCscMYCm=qC4eHN=wtY8z5uuA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] board: raspberrypi: Add Pico 2 support
To: bhargavdas100@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264699; x=1785869499;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rWOakFVyAzLDpntO3kMPV5Mr1IcWfCzbf3qQxoAxKF4=;
 b=MpUfNKqJwKv15qyCfWtU8uQ6XBzZLo8O7AOpyJ8HMJWvPPWUdt6vbhzZD0zkgldmD3
 YLMzWwxp8+riKo4jl70Qa7N1bAeUDl11hH5yD/USqg3hOrGBCtaswDJnIxkDicepEk3H
 sD+C6qnAe34jtCbPR3ap8tVzO2tkpTXxGrXJA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MpUfNKqJ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bhargav,

On 2026-07-26T11:56:45, Bhargav Das <bhargavdas100@gmail.com> wrote:
> board: raspberrypi: Add Pico 2 support
>
> Add board support for the Raspberry Pi Pico 2.
>
> UART1 console is functional as of now.
>
> misc_init_r() sets a fixed value for the "serial#" environment variable.
> This runs after relocation, so a successful env_set() here confirms env
> works post-relocation.
>
> Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
>
> board/raspberrypi/pico2/Kconfig     | 15 +++++++
>  board/raspberrypi/pico2/MAINTAINERS |  9 ++++
>  board/raspberrypi/pico2/Makefile    |  3 ++
>  board/raspberrypi/pico2/pico2.c     | 83 +++++++++++++++++++++++++++++++++++++
>  configs/rpi_pico2_defconfig         | 29 +++++++++++++
>  include/configs/rpi_pico2.h         | 48 +++++++++++++++++++++
>  6 files changed, 187 insertions(+)

> diff --git a/configs/rpi_pico2_defconfig b/configs/rpi_pico2_defconfig
> @@ -0,0 +1,29 @@
> +CONFIG_CMD_TIMER=y
> +CONFIG_OF_CONTROL=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_EMBED=y
> +CONFIG_NO_NET=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_PL01X_SERIAL=y
> +CONFIG_TIMER=y

This enables CONFIG_TIMER (the DM timer framework) and
CONFIG_CMD_TIMER, but there is no timer node in the device tree (patch
2) and no DM timer driver selected here. The armv7m SysTick driver in
arch/arm/cpu/armv7m/systick-timer.c is gated on CONFIG_SYS_ARCH_TIMER,
not CONFIG_TIMER, so it is not built either. Just to check - how does
get_timer() work at runtime? I suspect you want CONFIG_SYS_ARCH_TIMER
for the SysTick, or a proper DM timer with a matching DT node. As it
stands the timer config looks inconsistent.

> diff --git a/include/configs/rpi_pico2.h b/include/configs/rpi_pico2.h
> @@ -0,0 +1,48 @@
> +/*
> + * Serial / Console
> + * RP2350 UART1 is PL011 compatible
> + * GPIO4 = TX, GPIO5 = RX
> + * Clock: XOSC 12MHz
> + */
> +#ifdef CONFIG_PL01X_SERIAL
> +#define CFG_PL011_CLOCK                      12000000
> +#define CFG_SYS_SERIAL0                      RP2350_UART1_BASE
> +#define CFG_PL01x_PORTS                      {(void *)CFG_SYS_SERIAL0}
> +#endif

This is inconsistent with the rest of the series. The early UART runs
CLK_PERI at 150MHz (patch 1 uses IBRD=81/FBRD=24 for that), and the DT
gives clock = <150000000>. Since you use DM_SERIAL with OF_CONTROL,
the pl01x driver reads plat->clock from the DT 'clock' property, so
CFG_PL011_CLOCK is only the fallback and the 12MHz value here is never
used - and the "Clock: XOSC 12MHz" comment is wrong. CFG_SYS_SERIAL0
and CFG_PL01x_PORTS are for the non-DM platdata path, which you do not
use. Please drop these, or at least fix the clock value so it does not
mislead.

> diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
> @@ -0,0 +1,83 @@
> +#ifdef CONFIG_MISC_INIT_R
> +int misc_init_r(void)
> +{
> +     /* Set a default serial number, rpi pico 2 part no */
> +     if (!env_get("serial#"))
> +             env_set("serial#", "SC1631");
> +
> +     return 0;
> +}
> +#endif

misc_init_r() is only called when CONFIG_MISC_INIT_R is set, so the
#ifdef guard is redundant - please drop it. BTW the commit message
says the chip has "a unique chip ID we can use as serial number", but
this writes a fixed string; that reads as a contradiction. Since it is
a placeholder, I would say so in the commit message.

Regards,
Simon
