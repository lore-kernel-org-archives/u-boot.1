Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8C2C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB2284A0F;
	Mon, 13 Jul 2026 02:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HxTXRpcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91DD84A29; Mon, 13 Jul 2026 02:18:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E3C82991
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so4699946a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901926; cv=none;
 d=google.com; s=arc-20260327;
 b=nqB8LTyUtb5HEQuQEvmAzzPbRvXaYtlUjYTPwBNK911T90subGj0G6416uir6ax1/T
 dhjS9tvCxLMMLScLd/JWAdDSkYstj95aA9ngJME7IjyJJQ2kiw3YfitJfDt0t2iGEPcc
 OV4Kfe0eK6rETTw8ddOhFmXqXnY0gBIgKiAIw5oeW52jyg747060Re4VxcIfATHQcyP/
 uJeu0K+ecJPkw5AlSWxbRSP6kT935F3fO9AXrXKgl3Jo2jlL9AGm/d2bCFphybqtJ9JC
 D0SQuhFL7UTsoKiye6Lj8hZzILrub01hy5x8qERVWSnZ+gJDNxlnhrlnbIymLPJmW1D3
 6IOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AD0L2LR2IvICOQDu1XdWP/QhlZXqpC8Bi+oMq7jG9PE=;
 fh=jSYivEfN0I8J5riRSZde1XX2HOw0bO79/mvTlpTZjqk=;
 b=NuqMmPDNoxn7R2dCQt15i/QF1wqbo2fIgdlaR0eU3i8IVFIkAQUUcFfEUXbq3CvTBJ
 Vu6DAqBHaWgPko+qyoGMNKP3AgxZrJ4SXIWLpfn9Y2ILzDk9chLRBryjaxm+390SsGZv
 qzVGCuZBDfu1jfK2reZiEKvXbLJ2OSWVr2ILF2GXZwox6zuSvmrrEfaKLdzPE7p+nz09
 J+fROvSlez2pE/y+Z7RelZTHhLUKa+JJxq82VdwuQapWgZnI4lRH77zXTiQHFDf5yDnz
 LHkOOda1LHwXgX+cjs0KpoWOaXSoG1IStqiAhefhuqPM1O17QPgvAbqDfzJr0P4cNEqc
 O8VQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901926; x=1784506726; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AD0L2LR2IvICOQDu1XdWP/QhlZXqpC8Bi+oMq7jG9PE=;
 b=HxTXRpclGsrBrdoFv1NRLUnwSGgR9+9Wvsvw+Xnq9/JJZx0YMRD7nfJPRGp/DzSgq4
 yRnCILM5jAEQ8AF0ifsTvBkOVxZrYoDZBFfQYOj/2Z56VHEaIOLogLFhgJP81dwEsAsD
 qLKTj09OsfQnihhjWWF9vmXm8w29DMKm+HdHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901926; x=1784506726;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AD0L2LR2IvICOQDu1XdWP/QhlZXqpC8Bi+oMq7jG9PE=;
 b=Owlmr9BI8y53FbiJLK630pHAs+d0HurZLK67K2auonjIoxIfimYvskmsSEzqElcqL/
 xRdGJF0PpomWQk2LqwC2i7YobOEGUZDEZHGHkpuqCnfVTA0SOC73UWKUVkAKv/cTSesW
 mHCbJtBHxSrvaGDlJ12bNiiantpJ8WxBFcaIxdlOnQidt36gk+aPGkDKcjeBo3f+mIU7
 CTYhNIlYfUK337Aks8wRya6uixigGXdIQhZ61bMZt72Mg/VFANOaKWfwjTnENjX8CezR
 +bcVDDDicq7uakuOJ/OylorUwdsJH/xCHrAjtMb2/3nHifHlqvep1LVUAfk3E22qfPS4
 oiCA==
X-Gm-Message-State: AOJu0YzWFCGmqzoTmGe2hKbuTXGuBUfmbr/rr8OFDeGkGQE1qWJnpA6y
 oRMgX3unGc0qpZRDiGO7wgp/x0MpDp7GEfuzdgaZpH6teP0dhxrTz3J1Gv/VgnqiA6AIiZq5xcO
 qa6YJSjuazYF+wjFw0vO1SN9OrA5y+GIhDug5Yie3tgm/gVnzRVvyIw==
X-Gm-Gg: AfdE7clqjqeb4syZmmbjv6eKItHbrGmW9sgBjJ1E/nDh/w4g5nsb60HVi+rrIHUU+J7
 W+TpXvryoDSimOEJRt+/D+D6dNpx5iEPNju817P4unUL/CXwNxt6XYYJ3Kzw1J4cn1bUFmYHCAd
 YZ6tGCVmImIUvOo/QRZ0Vug5buEG8MDk/14djWsc15/Wf/le3GGjffZeuxFSOzo765P7v5APc0H
 dh89lBgI/seJ48T3Lw82OJOtPfklpmTRqA1Hj5JbC3N+xuJnGfFhx0LGOMxXL3AF4/L8KySKJZT
 M3Jv9g==
X-Received: by 2002:a05:6402:538c:b0:699:f3b8:1673 with SMTP id
 4fb4d7f45d1cf-69c5f0d4cfamr2893198a12.18.1783901926225; Sun, 12 Jul 2026
 17:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
 <20260708203711.849489-11-rv@rasmusvillemoes.dk>
In-Reply-To: <20260708203711.849489-11-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:18:32 -0600
X-Gm-Features: AUfX_mxNEOq6OV3m7XHUErdUwzkmtcW_n6Ix3CFN3fnKC_bLUMZ7Ax89f4Jyo14
Message-ID: <CAFLszTi=ytF1MTd4Egvo3LZDgrP5KZ5=K4Uz5jUVFcRkOagAgQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] test: add test of 'config' command
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-07-08T20:37:01, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> test: add test of 'config' command
>
> Add some test cases for the 'config' command, including the ability to
> filter the output.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> test/cmd/Makefile |  1 +
>  test/cmd/config.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/test/cmd/config.c b/test/cmd/config.c
> @@ -0,0 +1,28 @@
> +     ut_assertok(run_command('config', 0));
> +     ut_assert_skip_to_line("# Automatically generated file; DO NOT EDIT.");
> +     ut_assert_skip_to_linen("# Compiler:");
> +     ut_assert_skip_to_line('CONFIG_CMD_CONFIG=y');
> +
> +     console_record_reset_enable();

Just to check, is there a reason the first block doesn't finish with
ut_assert_console_end() before the reset? The other invocations round
out with it, and it would be nice to verify we consumed to a known
point rather than discarding whatever was left.

Regards,
Simon
