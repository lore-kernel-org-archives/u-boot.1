Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B98DCD98D4
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C1AF84027;
	Thu, 13 Nov 2025 20:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CUJcIBOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDAB8401B; Thu, 13 Nov 2025 20:34:13 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECF18401F
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-343774bd9b4so1142292a91.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763062450; x=1763667250; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bOVVp7ucszrf1jek582vGtvRpW2gc86uTWxfZGJcEz0=;
 b=CUJcIBOn6IXhx8jiGszkvNC+5yqk/OxYNm1kmLsbOnTLBOUSPpmCFbUiFCXoz+3SRZ
 fYNX/cdsvYbRqEMyXyN95WF+niT++11zo4xrdYLsQlX9b+36cGm42NUe3XpkpUMr8VzK
 eiHO+NXanaVCMLlS+qk/d4baN+/GGCH4/myu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062450; x=1763667250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOVVp7ucszrf1jek582vGtvRpW2gc86uTWxfZGJcEz0=;
 b=wHYkiXvRs1HjjQbFz7fjlqQLI9d+YPm5+ogoSmAZPmBYsvNPBGE+x/lE04ztozMFuX
 6m5pteojpbpBEr+mzPaEypXlXu5imWUy/H0Y41YIP1U0gtIFngklbu9oajnysAs6s/AL
 rMEXABjdzhn7H+5MDgLR/doDYTtlCPQSgfv1Td/G2/g8OWooRXNYQqeFRL0VgxZLLK22
 UkAO/B41hVYDiDkjFJVVe2kt1KWDzS6ppCeFJpxV0ZwaTmCsGsOPzSgII9VBMaVgtHGO
 G2v++abwgLRGQSHvS0R1A/Xpge1nC8ARW7waPQBhGCmd0XYvAjiV7rBv0WzxvRmY/Hwk
 xoWQ==
X-Gm-Message-State: AOJu0Yzj0B9GiQCFlxeGlYBj/FGJFy1OgXgSgeR16i9HFr1giO1Mf4Bx
 DWZvMUFm3kWtONlmg+UBHTXAjjPvAKjiesQ6jnLSo2ds4fEfPdtcEWADaJww7CpNgsSm0xAKQ9Q
 caO+Hn+gvBNSKMoL0F1qFGaQ9/lE3YrHAY3c6jeWg
X-Gm-Gg: ASbGncv7VaBwAen1xjXMRqbYKdhr5PMBHAXFYKInfPkNggDGzdOQGiCE8eIMZIeuF6P
 Z0cFn0kChSFxPsVon7cW2iv/mgOaoHTdBJbpECyDxOigfpHRqaA8HaD/IrQOKL2MGLvxB0JPCI/
 1Yi9kCHSSntkbuJQIgqV1JFzfiLHn9gG+bKyqQnDuoI/29K9xMNLofgnVBB0h0oXogz806LW84o
 63l54mjOHf7ZLqX2gTaw3iIXWwt35RATskwf/EuHudVL199TWKzLQvlfOqMsK/zSZhhzw==
X-Google-Smtp-Source: AGHT+IEDWLUMz100GOcEGbsrPlBAyPY0uWHN52yZP646/Ad00CcBUEB0u5W+CcAyp/hm+AI6eGPTBzyvOYOgx2Yn4CQ=
X-Received: by 2002:a17:90b:28cc:b0:33f:ebc2:643 with SMTP id
 98e67ed59e1d1-343fa527f01mr390705a91.23.1763062450044; Thu, 13 Nov 2025
 11:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113122145.949112-4-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:33:19 -0700
X-Gm-Features: AWmQ_bnCzThkBSRPEE7HBWl7sdrViFFCwV2jW303Ytp_9J7uVrwlLCUUBymMqQY
Message-ID: <CAFLszTgRxLTWjCCbxxme9XtG2E80CrYOesry_86YuagL8uPJ-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value
 unconditionally
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Sam Edwards <cfsworks@gmail.com>,
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

Hi Marek,

On Thu, 13 Nov 2025 at 05:22, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The fdt_offset_ptr() may return NULL pointer, check the return
> value from fdt_offset_ptr() for NULL unconditionally to prevent
> sandbox crashes.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  scripts/dtc/libfdt/fdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
> index 95f644c31f9..d16cc3d4730 100644
> --- a/scripts/dtc/libfdt/fdt.c
> +++ b/scripts/dtc/libfdt/fdt.c
> @@ -168,7 +168,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
>
>         *nextoffset = -FDT_ERR_TRUNCATED;
>         tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> -       if (!can_assume(VALID_DTB) && !tagp)
> +       if (!tagp)
>                 return FDT_END; /* premature end */
>         tag = fdt32_to_cpu(*tagp);
>         offset += FDT_TAGSIZE;
> @@ -186,7 +186,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
>
>         case FDT_PROP:
>                 lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
> -               if (!can_assume(VALID_DTB) && !lenp)
> +               if (!lenp)
>                         return FDT_END; /* premature end */
>
>                 len = fdt32_to_cpu(*lenp);
> --
> 2.51.0
>

The can_assume() is there to be respected and helps to reduce code
size. What problem are you actually seeing?

Regards,
Simon
