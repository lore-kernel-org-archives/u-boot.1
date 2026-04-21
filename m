Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582A8F94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5F484319;
	Wed, 22 Apr 2026 00:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MP+mclpo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0AEE842FD; Wed, 22 Apr 2026 00:49:20 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044B483936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-671ae79e617so6108523a12.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811756; cv=none;
 d=google.com; s=arc-20240605;
 b=b1ADRY9u6gCmtU+0EG1T7stMrartnDYbAiG3YOk8cPvSVAuILLHS2exctR+Dli8lz5
 BBldRgYArN/sWlD23XUjc+G/EL+QFzEAzDzngvyMYaQwKZsEeW5eYmUv9F7j3kTWFyLX
 cf0Ty5/42wynThcZZPllcVWSemx4Fw6clhrYtpMaOkPGeNoiZo45+D+acOVH5UqsCQ+R
 Lo0nX3+ilWJBJhNfZn7j+pdNlLpFTCu1OizX3ij9fNiE8+jZ/w0IjPdAP9LUbetpJtzv
 AQSkudA/LdirG1QjQxOE9Xsz4awqTx1K2hlsXxfzjysNsvLEuZ+Ktofq1zqlpZn8xSkp
 w+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZRzqj+F/kgAqg7nO+HAZlpjlh1bPqWJsT4cDg4AY8Xg=;
 fh=pbCOP8hPpdi+r37R4azvlvc0fZkZayccZKdYXQY2i9k=;
 b=RZAB2t7mA8Jyeudwc9XKvHUZbPNV+XXTK1enGX9B/ye/1fjPm26dbheFrUGWuP/xeE
 WbMi38LwkV6fkgbakI8WsxxZ7pxluNpjmtqRR5mSEh6XZvSbNa/y13Ild7aGjuOQ5Gpi
 w49xprcf8cBMbQCKQMWUqA0dWFOht8+AwY9DXf0i548f22ZMeAt86PeGX59eAUeKr/zr
 5sXBL4GmjXIOnx/m2iaOtns7UQwa1v3kYEiF7GpZgTky0ua4Yohi0Mq3qsiBsRGzxL+o
 xx3SaJLkJC12Vrav9EOQ1EsM+nMqUuhcbWWDLRSDYFwtLB1VIQI/XTWwRhnUeWOglRaw
 AYFg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811756; x=1777416556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRzqj+F/kgAqg7nO+HAZlpjlh1bPqWJsT4cDg4AY8Xg=;
 b=MP+mclpo/0eALYv27xXZgWOPkMyWQae6gS/3gxbVtkEjfpj4sufeOqMEeCxwcTTsJU
 ukUJny/bEexZbwGpRWChipO4Yih7jqHk7QJfE12uHjmbnr/puMJRLBuKI9xqwLC2xoG2
 k4Qr4uIiHfcr20jg0dBCgyEH0sXyagtGHXVK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811756; x=1777416556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRzqj+F/kgAqg7nO+HAZlpjlh1bPqWJsT4cDg4AY8Xg=;
 b=Wk1AhYS9A0xECMvG7nRBj23sb0MnV7+CqZUes9BeDGw9dGagW9oPX/Xlw3d/qW6gOr
 QrmSeFHCWYxvzWNQ8gO77Gt6KlAFwCMI29EZ3ttw+Juh+ywd+Ov69RBDB4g8hqf8FNss
 hyfAezE5AUTpGNLvjMm7tBvaPskwVzzDEYQEWFLTB4gLr08J65ZwDyIk42xe0GV1dkyB
 MCYNfUsThwyUVANDVhi8+xCqTBfp397EAZ2EDjj5lRzG3uBK0D0skyx+5IPY+Zox+Daw
 xFoTtDf0VeJVnMhXbB34j20vBADafXog6q8Yj9tO+Jgl4Dk8Y2nXaXY1mEiVG8o1bsqE
 D/Lw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JAbm5Js20zxXdGAXQR9r/se21LDX13/anTtLdEpxfjIj9cNIPG7MzY4wY9YnDhihrSMh4b58=@lists.denx.de
X-Gm-Message-State: AOJu0YyF4RnK7vcJ9EK9xcmjPxItVNA6VuSIpVP5Vc3XmMhejuwmoOni
 bjSIFwS/trJek5q7GOs27GJvLmSyWyXxlhugyiEe8SbH5/1BOV+WbY0/9sNNWMYgtp0HPfI2vFX
 z3InMTwzEkF0jWxzqJrHf7djeUWfOCbLcJj8JUwyA
X-Gm-Gg: AeBDiesLkZGFyApLDQ7hGNf/ZqBZ/xz9NPCuehnvR+08CZ8nPVOdCusnt9LJo++tykr
 pi4j/vhjq+hrTfT+tB9c4C/qeqTB1EuiDFq1C6Jvra7l+l0clT9xSZVh9Rj2gxmJCXOAqhYwRU5
 9FiQEsOvemv5eNwUIeUybHXp+uCcN2GaPDI4Iy0Sz5yrB8jQUQozbGMw8l6uc/NoNGXwofriSlW
 Gy/SNn98/p27w8CGrtwwtv5Y7ssHa2vQCAx9SjBp4iyo0PiRZlOSQW+YKbusXgyJ+kboKvYNQhz
 TBOgtF5MpZdGs/AZKInKE8I+tDqXAh8=
X-Received: by 2002:a17:907:d20:b0:ba4:bb78:b79a with SMTP id
 a640c23a62f3a-ba4bb78b9a9mr840491366b.44.1776811756196; Tue, 21 Apr 2026
 15:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
 <20260420220804.71564-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220804.71564-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:49:01 +1200
X-Gm-Features: AQROBzC518i2L42JTQDjVKS2h3Vo41n_uNYAGBU5beXE8i3vWP3TflR09gejMDk
Message-ID: <CAFLszTgLk_hpFqzbnBA2pt_nUWqJKr5Xj=L47QUSKQNRaPzX9A@mail.gmail.com>
Subject: Re: [PATCH 2/4] cmd/acpi: add optional index parameter to acpi dump
To: heinrich.schuchardt@canonical.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-04-20T22:08:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> cmd/acpi: add optional index parameter to acpi dump
>
> Add an optional index parameter defaulting to the acpi dump
> sub-command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> cmd/acpi.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

> diff --git a/cmd/acpi.c b/cmd/acpi.c
> @@ -12,6 +12,7 @@
> +#include <limits.h>

This include seems to be unused?

> diff --git a/cmd/acpi.c b/cmd/acpi.c
> @@ -183,9 +184,11 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> +     char *endp;
> +     ulong idx = 0;

endp is set but never checked. Please either check that the entire
argument was parsed, or use hextoul(argv[2], NULL) and drop endp

Regards,
Simon
