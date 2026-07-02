Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F7BC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACAA84CD1;
	Thu,  2 Jul 2026 10:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VzHTIfbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295C484CE5; Thu,  2 Jul 2026 10:32:08 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B38846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so2954749a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981126; cv=none;
 d=google.com; s=arc-20260327;
 b=Dvr/uE1qurVrFtz7LSa8O9WmfZsL7oWxS/rD3fpLzymIlaWNXOmHywI1t0GECDlE3l
 ImvU/llj25uTxA4AchOxlLIxtC/2Wb9/xRtn3y2iJ9AbaKpIRJo5ll4BwHFVMPKGt3WN
 HVUhANvFzmIXSqp/fourddJnEUh41Q0sDL3CCMUKNIckkkoJGEzLQEQlRJLI9XX/+cHj
 DGi4UFaH8kl/ZLdP/f00cWwZVqjy3BkVs/+yT8dR5pcZy3EXlpyB0nhas6FhQv8VBJl1
 MIG40xvdvUa62uSWTE2UHQyH9+Ys49SoI7uNya3iE4EoPV8cg0UOKbxXYMdHKCn5PA9O
 ltug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LhzOUmJSLQtvoZ4I4oWUP761Kn/mDBz0UWSNebdo8jE=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=K/8Avk30Hrjsibdvt9+dtsdbCSyXGodjbvMlGB1TzOM/78huuCJY+no45yBcxzaaLx
 CuygeLm5n1zD9jDDE4rtX28KuvN8RgfbRotrL4xJBXs7bE8ktueGOp44rUF42oZPcDio
 rT365jTuh3LRLUxlaEd/JVMG+1fAPqPmNURknW6YcVK3PdsJrVNOtkb1zOtFmPmbu0Fo
 MwL3ooSueKygXtaFoFnysUSzdAsF9GOVqdJ1vpuNvLao1Gis2lqeIxlpGhQrPY/Sg0MC
 Vpedfow4W8FLMREI7yuIVK/wR3ZaIkUCapk0jPnR5rCHh6d+WCybKPopIshxUkk0gzdh
 Zm5w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981126; x=1783585926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LhzOUmJSLQtvoZ4I4oWUP761Kn/mDBz0UWSNebdo8jE=;
 b=VzHTIfbKFPTYTl5Is663ZydeH3XM9vTvvOXDjwvaL1oEi0kpv47F85uvi62UFCV5ht
 vlrclstcIGBrUsUT6iqa1zOjTApHYtBhyepkPRwk3sL/7clYfN+s2uu5ONTdom7Z/8eR
 fx3kUxsbn84Z4UxIk6rhqPiT1NDIiWfHkBsnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981126; x=1783585926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhzOUmJSLQtvoZ4I4oWUP761Kn/mDBz0UWSNebdo8jE=;
 b=EOUQH914fMpkHj4tHoNuACoaR1vgvJN/vaRBO7pDllxGTNxy55/8f3xm2r69A6mDDO
 e3kdsBnvH+Cr1uZ55GxxyZDQSAUBZC7KZVqu30+p/Y0iOpMcwV+pGCKFpL7BPSBwLsLt
 LMwzGmVFSGL7CjGJrLRXDy09a0IfB5N7JLtYdA+Sn9QwHGluSS4DOKdzYxWWS9fsrfyh
 9W7HTXjo1HvZaUgTw5aznyvAVoPJfuMHqLdn9Sky0Qsxwpfo+3haL24VneJFsQ+dn+d6
 A3+oHiv3TEbFfbZKwTBQH/yna8MZtgCOvyMwtBr3aHtC7z86tZ/gvqtORDGQUwbIiH0/
 UAOg==
X-Gm-Message-State: AOJu0YyfmsXyU05YS5CtBzn9EyQDwgMnS+7TRuEZ/959o3X7D3ifWsTN
 xWl6e3pb4lDmXpbYMu6zMlxnKkpiS2k5vJz3it/aMWrtU3w8hXc43la+szkv8c9+RrUNBrqxhPf
 ayOHYQnFvSLE4qDWqFYlEOcmuyhOuJq0ZBcfwEPkLNmFluMXy3n2Iu7uL
X-Gm-Gg: AfdE7ckchxbDy006YThAwm5sXYm/7eZVI+tM2APh/GLlZfdO+8ywqxHCX+m5tcQwam/
 CHdN46BmxTcBtlmMwWkywV7C560zroJlReq+3yNg8aHC/vRGC8a0hIN6gezvsMGL/dJmVBc4wyp
 ia54+QGkm6iYiweUNRmZsWUJgqjS7OEz0ktezk3PLYWT1kzii/Ge1wxI1MoKL0hEIjJieiJzJHN
 yjccZi0cqoJeY6cuIx7DqyiZn5y+e1WnQmwMIAtlh/E1+isGhzALQKd2XaBp9B02gxmib9YWA==
X-Received: by 2002:a05:6402:1cc2:b0:698:3c4c:5fc6 with SMTP id
 4fb4d7f45d1cf-6989f3530aemr2238086a12.22.1782981125720; Thu, 02 Jul 2026
 01:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-9-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-9-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:30:24 +0100
X-Gm-Features: AVVi8CeyJJyyqgWxkXqd2JhxQ9G9TgHwImYR6l14iTL03Tb2wI_DNzpW5wQaO60
Message-ID: <CAFLszTgNgDUY-sKspO9O5JaSg7ERv7g-qO-UV8apunFs4w6ZWA@mail.gmail.com>
Subject: Re: [PATCH 8/8] cmd: config: allow simple filtering of output
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

Hi Rasmus,

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> cmd: config: allow simple filtering of output
>
> When doing development, it can be quite useful to enable
> CONFIG_CMD_CONFIG, so that one can always check whether a config knob
> one has just enabled has actually made it to target.
>
> Because sometimes, one doesn't flash the right binary, or maybe one
> has just done CONFIG_FOO=y in some config fragment, but that had no
> effect because one would also have to do CONFIG_BAR=y.
>
> However, 2400+ lines of text are rather hard to read through. One
> probably uses a terminal emulator with capturing enabled, but
> searching back through the capture file is a little tedious, and one
> easily ends up finding something that doesn't pertain to the most
> recent 'config' command invocation.
>
> So make it possible to limit the output to those lines containing a
> given string. Like the search functionality in menuconfig, make it
> case insensitive, because it is much more convenient to type "config
> pinctrl" than "config PINCTRL".
> [...]
>
> cmd/config.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

> diff --git a/cmd/config.c b/cmd/config.c
> @@ -29,7 +29,23 @@ static int do_config(struct cmd_tbl *cmdtp, int flag, int argc,
> +             while (b < e) {
> +                     n = strchrnul(b, '\n');
> +                     *n = '\0';
> +
> +                     if (strcasestr(b, s)) {
> +                             puts(b);
> +                             puts('\n');
> +                     }
> +                     b = n + 1;
> +             }

The two puts() could be a single printf("%s\n", b). Also please add an
explicit #include <linux/string.h> now that we rely on strchrnul() and
strcasestr() here.

Reviewed-by: Simon Glass <sjg@chromium.org>

In addition to Tom's comment, how about a simple sandbox test?

Regards,
Simon
