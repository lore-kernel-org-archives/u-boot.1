Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D355EFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A378460B;
	Mon,  4 May 2026 14:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B+ejsUt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0518460B; Mon,  4 May 2026 14:17:39 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D7B83FEC
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so605886866b.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897057; cv=none;
 d=google.com; s=arc-20240605;
 b=DbWvgs+aW6Bq+rRclDYvPo/gaf4BWWaAkU2rfveaxzm7jCQXqmlIaGONGhqekX83ds
 7Kc9wJh5d4dNgT7h7exExuvL2w3/UAplU1YoFD18neWYMjKRZLMmKRYwUHHwuQDhfa70
 GGBbH+os4QD+cr0MHsrdkVwBJpLvt9Z2RYOBkp8bmxH8aSX2L4XvzhZske0v6E9bDELg
 0ENivAoYnpLDjB1j45CccMlUDY4QVOuJWuw3c2ODsWjvcoraA8A/8YRwebhgFi9CsTq+
 2tLcwKfZ+3c+ODazC1g82EoQzymaR9N1t6IufXeyBO+K9ADBneKBB1LALWJvqFlF6WO/
 Fglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B0R11NFGsv/YHmM/E1D+NgdCTTY1DQFTKJ3KLzAoBOE=;
 fh=jmbcoFG2RPEOJsmPKSiakkV0VWJqP8RiS13G+yktnmU=;
 b=HTZ4b0s2+OpZ2BE9WVPUHAuelKxANEYiHICsBLYdZNvMj71mxZ6mGGKeU00SZ20hX3
 97L4YMNErXYNhosTDuH9efT3NwQ/F+HUAkE58sTvMhCm3NaD2vrVLCIEVuWD8hl1P+mJ
 R2NuQscI8njWUl6ADW7muufIo+z0+PPYdFgeqDHGhPOjb4/bIWeCynUsd8S6h+QpmFCa
 r/T/MuPheFRxkwxyURt4OeB2GBF4cQ3QQvcsprbPfSCByxr3J8fAxFRqVbc/cDchH16T
 qfPgbTmOmgoW4JMUAUqwABDWVcifFWZ7ihrtPjFGRB7QFW5S07TOroQ4AjL7rPGmw+xf
 Kr6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897057; x=1778501857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B0R11NFGsv/YHmM/E1D+NgdCTTY1DQFTKJ3KLzAoBOE=;
 b=B+ejsUt+uLI3JUeFJm9P3milJ0g1aZ7Kmo2ElPFnp29tJykQoSnoE6W0ko/f9dnnNb
 PAc3U3BmP2EhSgzNrLACSfcoCqBSfvqML9p9wCbjGgYg3tjV5jIha/dOlX0GpxS+qAem
 WDBqx0D86XYZTZrch/y3sBE9ZLmSDiU0SRVas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897057; x=1778501857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0R11NFGsv/YHmM/E1D+NgdCTTY1DQFTKJ3KLzAoBOE=;
 b=XNZO0HOqHoFXkdGI3UffJ1ZX0J5qx8XapYdIv/A/eRmdgPZupuydhaTMdRquJdjh13
 H1WVeDklZudLRAdvsau5+duS0Q9Aps0XziFAj26mFYH2BYuQjgBDV5BI56L+oOK21sJ/
 /gBCuCQnjBFV2se88DHHCYfVsbjmCTOFRQScHvVwi4mPATOOB0c9cgnKm5hdSQkPwB7C
 ZeNSlfxNDh/CQl+xUdjIfsxUPsjMm0jeufg4qnghDxwqOeKII5niqYzrV0UJWRVUnzgi
 jvmasO38sRVIFPSR4nEl3jUsfE1daKk+1wjvI61bWRPGfYeYc5bdx3AFR9gpJDy9ko4j
 2Kkg==
X-Gm-Message-State: AOJu0YwK4YFOKexRDRnJI9i+g8ngmYeP0G4DfIMOT73oHPYBjykkamcV
 mQ16DwLWuve99eJ1EmsBoCTg7zCUB70jw+IET8LpwUD3dsDswPZ5Qbpa+ba8LdH9Y1+6MCJZGV+
 yPkDWumZ304G19Aj8uzgBtIQzv8oViWPWB0zcXmdB
X-Gm-Gg: AeBDievLulIGF7ZRJIJf6zZhegLfa7kaBHx1/PfHn+MVHTLYt1iHtgxx1OwX/rUIV6L
 H/30EEY1l0hTkZKtluAadAO+/LZ0JSThene4IJOGBm4pGey1tL07RQh3X/ofsfCmL9BDc430WPd
 +TY1ieuur8G12d0bCUJ40fBqQkPXAB3UGUB90L0x0mW9xC6JXlk7FJqP21aTr/5AsGI9Th863yM
 ILJkKdAqa/MIrZZ22ScQVIfyofP7+eSQa8LQnl+F4p1YzLKgNLO8gOTUEXtx9HU3eGBWdjzhgh4
 iAwgMxMheyxbAnHR
X-Received: by 2002:a17:906:f595:b0:b9c:4fa:9141 with SMTP id
 a640c23a62f3a-bbff8dc777amr502121966b.9.1777897057026; Mon, 04 May 2026
 05:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777551598.git.michal.simek@amd.com>
 <74c8b0830dadc5b7f36c4e2c49a1087a503f7ca1.1777551598.git.michal.simek@amd.com>
In-Reply-To: <74c8b0830dadc5b7f36c4e2c49a1087a503f7ca1.1777551598.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:17:23 -0600
X-Gm-Features: AVHnY4LQUOu8Vb_cvR6fQMFLA8siFi68713qz9SB0WOF3fCzpnORgDy4ZJ2ZPJU
Message-ID: <CAFLszTgWRJgZoLQqqLvLuUR0B_uKje5ffvQt3uZG9sdhPiKNNg@mail.gmail.com>
Subject: Re: [PATCH 1/4] reset: Add reset_reset() and reset_reset_bulk() API
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com
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

Hi Michal,

On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
> reset: Add reset_reset() and reset_reset_bulk() API
>
> Add reset_reset() and reset_reset_bulk() functions to the reset
> controller API. These functions assert and then deassert reset signals
> in a single call, providing a convenient way to pulse/toggle a reset
> line.
>
> This mirrors the Linux kernel's reset_control_reset() and
> reset_control_bulk_reset() APIs. The new functions are useful for
> drivers that need to cycle a reset line during initialization or
> error recovery.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> drivers/reset/reset-uclass.c | 30 ++++++++++++++++++++++++++++++
>  include/reset-uclass.h       | 11 +++++++++++
>  include/reset.h              | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)

> diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
> @@ -225,6 +225,36 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
> +int reset_reset(struct reset_ctl *reset_ctl)
> +{
> +     struct reset_ops *ops = reset_dev_ops(reset_ctl->dev);
> +     int ret;
> +
> +     debug('%s(reset_ctl=%p)\n', __func__, reset_ctl);
> +
> +     if (ops->rst_reset)
> +             return ops->rst_reset(reset_ctl);
> +
> +     ret = reset_assert(reset_ctl);
> +     if (ret < 0)
> +             return ret;
> +
> +     return reset_deassert(reset_ctl);
> +}

Will this provide a long-enough pulse on real hardware?

> diff --git a/include/reset.h b/include/reset.h
> @@ -443,6 +468,16 @@ static inline int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
> +static inline int reset_reset(struct reset_ctl *reset_ctl)
> +{
> +     return 0;
> +}

Just to check - this matches the existing assert/deassert stubs,
silently succeeding with !CONFIG_DM_RESET: is that intended? Should we
return -NOSYS here?

Regards,
Simon
