Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB37DCD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C80F848EE;
	Mon,  1 Jun 2026 16:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NZ6ywmrp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E15084908; Mon,  1 Jun 2026 16:55:13 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C90848D7
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bec405a6ea5so213247466b.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325711; cv=none;
 d=google.com; s=arc-20240605;
 b=XxNwuRXBy9S1mVK7uMIlpLDNLRmjpuGtXmH9CiEi4HCG9JIaND4u1OYHsdNwLA24Py
 tfvU/TpAoo/hri4WsLqaH5Wg93u63pWJ7YHpCTXwE6iE/HqZVD4YLSrnAtKEbReGLheH
 I99g6fbDbwD1ncu0OBaEAqTildRrkgbDmNsmtlrHUIZW2pQzX5JKgENq5vG1O3sZpgoL
 SnZFfhpFNpIHIM5IKSEnHIYNE1IBqmcNOo8R7iUGgQpF6F+tpc1zKU5y2vcoTKAJbVum
 a/bbTK0yVlKnO5TZkyVOnFIov4UMUPtnvz6U5i/UXFF98HztTfzNmWtCUpEqD29RU5KL
 cgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+IfwI934kWXIwr7o4cwenBvMOZxoHbLnia2hpe7Fxis=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=edmWPh/Hfm6pzdfKvMkNJaUK9ZhwCik6NGoRXCcgNag1hhpwzHvpTIJR7rUIDIOnkf
 QjZQCiiwM5u3+WmTfCwZK8vJB5V0aaZzn3p96fs02PspBxljIagmlwo9VAIuLvtrKLWx
 NQwblSwc+qFaatAuHhaPF7+/wq+do/o6N/httlAuSOucgsY2ba42a6aAoI4jxTDn0uAu
 H8Qh9liN6ikqU/Xeqtivf79vYH+Wby9gx+InE6nnw2SpAgjv0m/UIUlvzZm9WC+i9FBI
 M3HYuu1znDYQhhSWH3BLLcD3CMwRDWtQVgYnkcAbz4omK6tY9B8nRs/JnEXQC6JBc+4U
 UdWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325711; x=1780930511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+IfwI934kWXIwr7o4cwenBvMOZxoHbLnia2hpe7Fxis=;
 b=NZ6ywmrpt35U9ni/sgECCtUePw/PlzQP00xQzQ94IqssekxY2ucumCKT585/s/n023
 iCC0fCgVxJa2DLLAKNtJSmUM0tj2KiYFq1k68mD68zQxqWnHdxheBN93inMTiwz8j17X
 qMB+Er3dUOpSn6UprO7dZ1zcXQR5hm0HkvNVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325711; x=1780930511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IfwI934kWXIwr7o4cwenBvMOZxoHbLnia2hpe7Fxis=;
 b=p4RGavlFVkHVK+VO8lSNolfTxgm9ry99niBF7LCahGjBRjiE8SlRjvoyMj7I3RksC8
 qjHD1iQcjExzpvFlbHjvzwGnaRKTV8liQsZX/PoyaSxkw0OcIsYxCcQtTFhJW3A6i5B0
 T3TyvkEQN7+7UkkTGPKGw2jAR9aw9Cp2qygrAani39QImCDxvgitYzL50h1iAzRtFsRW
 KgWZjFV4DVyDQAZQ87Ewf1baTPEAePWccTZOWVSyWTxKTBSDL/Eg8TBIH0YZ5hWJakN2
 oyFkUZymb+5KcRvlnpa+3jzuqCAoY2tIyVbL7WMm/y8KrbRSkD+4uHTIKw/UczCOxrI7
 TuuQ==
X-Gm-Message-State: AOJu0YzUQFuFRQT0alundwU04NkI0mtA4HIVVnYjQ7+42bGwFYrQ2kep
 jrDJVNQMtMcSlE+JqbvlEBdgnly5x/ePKEBKQmFRg108qqkxjjzQE5iyajCjTM0qQ4JiZ3j9oxl
 RhLgbl0A73+qZkGVTUxQSaR8zGOUc4ChAh0DgGrTiMSW/OyNaF5w=
X-Gm-Gg: Acq92OGeqp8Pd/Irq988QbkMw29f4RYNN3dqnG+O20zoSO/QPLvHFSrRjbwr6RXy1DY
 ETNKXXbt7C3KefV91sn9CaIzD7p7moj83OlDoJlPH74ffLfmL42AeXmmyOCv0fYSBR7adBOcf6P
 RJZoVPlk5BA8kFNQj/m4h1zwGAsLR/DGCvdMGH868cCR54laBi3/+MH/cxu2gOETbwCf3S9PDwy
 JWIK0KnKXCQDZaDTGrmfQTnrXZkyYNa5BtNGdtPrLlRoeGoSw/USuAc6ZLPWxJ0D/O793kCN0Xx
 IG1bQf0nButGxJP4
X-Received: by 2002:a17:907:c006:b0:bea:5ce6:4267 with SMTP id
 a640c23a62f3a-beab71afd63mr619522666b.35.1780325710974; Mon, 01 Jun 2026
 07:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-6-dmukhin@ford.com>
In-Reply-To: <20260529034839.2075806-6-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:54:57 -0600
X-Gm-Features: AVHnY4KwcDaOh8UC1tfEuV7pd9Ci5Iy8j3oc2Qn4jgxzE68nS9fa2BFIcJD0oD0
Message-ID: <CAFLszTiDQaB3nxtfk=F6dZWERkZLKV4rsLbgA79n0wFB0jR7Ng@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] docs: reset: document cold reset option
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> docs: reset: document cold reset option
>
> Update the reset command documentation to cover reset -c and explain
> that the default reset type can be overridden through the relevant
> Kconfig choice.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> doc/usage/cmd/reset.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> @@ -19,6 +19,13 @@ Description
>  Perform reset of the CPU. By default does COLD reset, which resets CPU,
>  DDR and peripherals, on some boards also resets external PMIC.
>
> +The default behavior may be overridden via
> +CONFIG_SYSRESET_CMD_RESET_DEFAULT_{COLD,WARM,POWER,POWER_OFF}.

The two sentences contradict each other - the line above says the
default is always COLD, the new line says it can be anything. Please
rework as 'the default is COLD reset unless overridden by ...'.

> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> @@ -19,6 +19,13 @@ Description
> +-c
> +    Do COLD reset: reset CPU and peripheral/DDR; on some boards also resets
> +    external PMIC.
> +
>  -w
>      Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.

While here, please fix the pre-existing 'Do warm WARM,' typo on -w and
use a consistent form for both entries (e.g. 'Do WARM reset:' / 'Do
COLD reset:'). The new -c text also duplicates the Description
paragraph; a short 'Do COLD reset (same as the default when
CONFIG_SYSRESET_CMD_RESET_DEFAULT_COLD=y)' would avoid the repetition.

> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> @@ -11,7 +11,7 @@ Synopsis
>
>  ::
>
> -    reset [-w]
> +    reset [-c|-w]

While here, -edl is documented further down but missing from the
synopsis. Please list it too so the synopsis matches the option list.

Regards,
Simon
