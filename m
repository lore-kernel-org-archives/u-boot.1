Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D4BC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0623284B42;
	Mon, 13 Jul 2026 15:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ym05ul8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4EE84B43; Mon, 13 Jul 2026 15:08:07 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FD384B3B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso4371302a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783948085; cv=none;
 d=google.com; s=arc-20260327;
 b=dj0d8a0y9vpaSWWpiJH1CKoPQq/XeZM9w3J5BCteo2mn8FQbahmkhPeqgm6xGO3MRZ
 MCN06N6v3YWIQRq4vx5EKEfS1F/vCTA9ZNJFTYU80ZA/HF5O1Topw8gPByoqlHx2fute
 zfIGH0Tfr4k+EXCb7nosraUN/CgXUEeiDdhP13f+bULsv2Va18YnF0Xbw6tsfFhmae/m
 iRMntw4P68NgXGIPk+9BvPYz/xhhh/mgFBiChd8rjsInxf4u4KuIjL52sSebg5of78/g
 RdeB/vtfTXMcS9X/ZwQPQzAEVDUaR4XyCWcuHnG5d9GpuMTr0YSa5sz1YFNXjz/4bqq5
 qWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w9VEs4O3BfcBOAQDavzKhhkYrnCywazO97VMV2SXdJI=;
 fh=joWFw7uQNAewTc9d3BnbzDW7eparBJAilOzfYIz9J54=;
 b=qyW5U0N9Ig84nm7lVR8hGbt2+kUMf+5qET7hcrDydWDBdh7YoGuDq04E6kZ5YWXEXo
 uGUX/WJJh4f83Q9NjnK4tQIoj2YvMKyfRlp29dF4oeZg2M3tnvNOnhm0w1M+I5hOFQji
 xXl7nNr/UZroyD6jiMhd7oEOcihgtBjUROrfrspFhWPchH9piam1qtu/I9c6rabKRprq
 gSkU7xzklq/sYnJFuc4yAEU7IcVaawyjrWJGtrMgx82+6ufrg1kD8D4g860lSEBIQzbO
 +jFoJ3uiCxfu0pOHBLYQ1MHhtX0Ynu6hlqiaUB94t4Ng7Ubmp355FDyWG2QVz1qNlWDM
 TrXA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783948085; x=1784552885; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w9VEs4O3BfcBOAQDavzKhhkYrnCywazO97VMV2SXdJI=;
 b=Ym05ul8KEWrZ+9mYp6/hPkEn3zrPu5l3/goXLqKxpNMXxrvdnp5zjJLEhwztJzKsFx
 Na19AdaRhe28powrm7V4UrrSXGmScIe8KQq7tyuTT8uHzeW1MRJ73Q8CaLZQBNzkloiQ
 BnwazabQWzCKUjgAiL+mCT3/D3ST35oaIno7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948085; x=1784552885;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w9VEs4O3BfcBOAQDavzKhhkYrnCywazO97VMV2SXdJI=;
 b=U+F29dHN1Y9ww69H1SZxr/kBECOynSAqWFxkiQ5b0Fn3xX3ORIo1jEyc+7l4HQ8jTD
 w1Xhd2Y3E3Th4qgSzXVTZQDFaZVSu8XwKCg1rjSLgL4YnRo6IwKtqPFs5Y3OyCIm3omD
 8/QqD7ZXD0pwKtTdKxgfrlgDLJRBZO/7cCvWRJtuYhViN7HdSoEBf7d4V/RnBTjLVUC2
 ZOpUo5Ial/KscArX4ZuM7muC2GGfUy/+0v9gI8PR3IePqAJ/3c3SQ3HInqef2zoImt5S
 k2qTAQIyzfjh54mgYw89CWp1AexCRtqCUgIXhZ5cPm+ZT9AR8AZGiH1rdY62AcNmX+OV
 OeCg==
X-Gm-Message-State: AOJu0YxJm9S/UyVod3+NjwCevlD17h4swDH7FaqocNgOdhFnPmAHvdDW
 Q/XbZpk9WV0Gz54Csd3y0COLJSZaV9vzwB/JIZyV7D/MQb/JWBw4a0+BbS2jum0333Pd9eSG+G7
 cj2SsW7mpPqFrJr4EEC2w7Gv7T/tTKtxV8/hbm6V2
X-Gm-Gg: AfdE7cmgPy0xzK9KiFhj2DI1T4XoozFdyaoFhrHEGUYKYylFBMcZB3P5ttNhcNfLnrD
 Rmu/5abLaTOluDJ0FYQJ44HaNbDjaTNqPC+sCWk8MQojz72L+a44VYJ6szs3857SBnwFOv5fEf0
 frznr/AJl+JBetjXI6YkdBbpTGX0mgFIf345M36BPYW8JlZ6LA7t8y17e4WedgoSVMDF2iE7z8X
 IyV35HZUg4S7JEn7ozpc/PMu1vc1KGuqUSdBVq8wsQ5h+ziQZ/0/HM8wCBi1nkR8op1YZI=
X-Received: by 2002:a05:6402:2808:b0:696:8f45:4ae7 with SMTP id
 4fb4d7f45d1cf-69c5ef9beb1mr4132754a12.13.1783948085166; Mon, 13 Jul 2026
 06:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
 <20260629100104.v4.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
In-Reply-To: <20260629100104.v4.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:07:53 -0600
X-Gm-Features: AUfX_mwe9CYc7KBmx7CQSCi2BeF1XEmH4bYgQobSLjUWIykkaeySPUKrDG7clLo
Message-ID: <CAFLszThb02vyHNBEbdPEgtdvyJwW_io=J9Ag1KaFHDk9Dd=S=Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] tpm: print all PCRs from pcr_read
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

Hi Ludwig,

On 2026-06-29T08:00:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> tpm: print all PCRs from pcr_read
>
> Output is now more similar to the Linux userspace tool 'tpm2_pcrread'.
>
> The old semantics that require specifying one PCR number are
> retained. In addition with no arguments the command now prints
> contents of all PCR registers.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> cmd/tpm-v2.c               | 69 +++++++++++++++++++++++++++++++++-------------
>  test/py/tests/test_tpm2.py |  9 ++----
>  2 files changed, 53 insertions(+), 25 deletions(-)

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -168,25 +170,51 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
> +             if (rc == 0) {
> +                     printf('0x');
> +                     for (int i = 0; i < algo_len; ++i)
> +                             printf('%02X', data[i]);
> +                     printf(" (%u known updates)\n", updates);
> +             } else {
> +                     log_err("PCR #%u read failed: %d\n", index, rc);
> +                     ret = report_return_code(rc);
> +             }

prefer if (!rc) over if (rc == 0), and report_return_code()
double-prints the error on top of log_err(). Please just set ret =
CMD_RET_FAILURE here.

Regards,
Simon
