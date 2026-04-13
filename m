Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96B7F34C5E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682A5841D7;
	Mon, 13 Apr 2026 16:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TVSOdLUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80916841CD; Mon, 13 Apr 2026 16:58:31 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C3983DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-670c6c6e64dso4902569a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092309; cv=none;
 d=google.com; s=arc-20240605;
 b=gN7aXjnINQWxkqBXI8cLp3e0XoHAFPfC8PDy7YNll4uh+E+hXmtSCejOdviM8h2Y2y
 9ZnqErbowl6yqNprZM6nxCOopVZW6AIuiT71feF3GIxpZvjYg+yZbFo+kZjYxyN2FfkZ
 HrSUGmPVFxeTz4P6M5Rja/UKcxX8kKit31V7kf6fw0dUNEiMTPzEfZNy+VhEo++r/zU2
 Jai+jxuefehKTjq9EPlfRaDtlxca8JmTIZWbBmIeh3YTl0KNOOct+XjhmvB/Ykvln6lb
 bdC2PI5lmSxxZjyhbmeee/YBYSA3lcvUhkxTBRzLkoo58/Gm2r1Q6R941r8+jP0y3b5P
 Dgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RZ16tTS0e+yppMFJvG1dpHn0lvYomP/DFMu6rJPGUV0=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=kAOh25em5sCtKSEWsGN8JZlm7jSdMuBUxyjBbXcxFQjtt/ZRojp62bp1iWazhi3yWs
 eOEAgTmk1xLY6Nr/Z3o136Lc55OIOJwrmuJRcUbqQclK55CTTSGWVC8GPYARlmuYg3zD
 FhsvQ7y6gffZhQcW4rdeR8H3mW8JLT0VONQPul5UGESJNsJBJTpBKGU1Tt26n3px1aAH
 jqvQvYNG0FFVZcKxzOLjofJMnRpnKUZ5yWUtZCGTlV0SyJfEnG69Ss8mua/jqJV/oVwk
 /V2XhRFdRflWIHRYcAU1uHfjz7cP3voW1jLQj2j/UK7/QwlJZMtG1UohXy55y2DXv9N1
 ZmKg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092309; x=1776697109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RZ16tTS0e+yppMFJvG1dpHn0lvYomP/DFMu6rJPGUV0=;
 b=TVSOdLUI4GEgpwMOAtVYclYlPIS0HkwjdwNxvqoNZQYMZ+mOU8MbuL/zObtFpQ9SRq
 DcnYfdZCajLveo3jB8J006sk9HCI1rdiFTY8oguIxagVh84JvizPO+CGZXVzOgiBPP4d
 XdiHq1+qMccsGk1qILsrAk9mEK0PxCe6bEqVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092309; x=1776697109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZ16tTS0e+yppMFJvG1dpHn0lvYomP/DFMu6rJPGUV0=;
 b=RY/dy0SFRzQ0Gh0WRXz5n+iYidjrwovaYoklpHEfpKJzlajDYoGXdO1Bvtwl66xzGu
 cVhDgrjlBGnBC/JZJTwdcE8ssYo4eEMoZwcIr3ojWuC8jVb2Mgzq+Cb8OWF1iMAA/BV6
 HJIlQjUygvX241Y/ZL4oYFpHL+twBy5Qpq54yW1qoYhwmh4WwAPS6VR2qrnli8sGF9Rz
 Fqo3Q7TYWglhNa+WmbWegRCqlzQJkUySJtgVGdwmG38wZIHdGsBVolCU/4AzSdal50gd
 Wd/iw1HG8jzaZIafPKUv5RSJWT0tQcgs5PjyfdEqbPpabdlpal31CGlq/IsETxeQtFFA
 rLXA==
X-Gm-Message-State: AOJu0Yx6EW/rEUDNq3c43L1K12sSIR8oZOgcblHFql5sddWQdrymcevV
 nG6oHTi89yQaNja7DqmOgp1OWe4LSYefd7i5onWYl3YbDB8I9mI/9U3r28tTK6LB0VYhdddB/D7
 KgVDLJHo9MC5CIFe4Gd/zy0rxJ70dUYpKHB7DWxAc
X-Gm-Gg: AeBDiesJZ7dB7WPVKi7ydEu7JoQYItzcVB2iqHClz10kUoGxiUfp9KcACyZbYgEBm6Z
 1BV5/+/mWT1fktdB5VEqLX+PyWhSyFIHr2SAgKkp6ReTIdsmMx3ayyKkhvLjAbvqmkcWwbIwjjg
 tPyxDQX++rLP7z7a+HpoJtVLs1nQNPDEop2OcxLYd7KHPaotIJdg3l197zqmWOZXWQoBzzKhSD8
 DhibB4IWwSbCQmmouUPQ2Uxg68EglDyhGinWOPCblU6r229WoBVGV1u2W3Xz2b44S6A+Bd0UO4X
 ATNVFw==
X-Received: by 2002:a17:907:7b83:b0:b9c:ed9:50c8 with SMTP id
 a640c23a62f3a-b9d72657a0emr826809466b.26.1776092308974; Mon, 13 Apr 2026
 07:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-6-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-6-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:57:22 -0600
X-Gm-Features: AQROBzC2AjJ6t_Agh2ruIcaRZUqrFkRKuNO0jfapQKIkI5NMC6x9Qr_nBfIPm6Q
Message-ID: <CAFLszThJnXwWxWwnzTHbGK0CrJmfqpzSHyJ7XM=0PpynsFHjpQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] lib/string.c: implement strdup() and strndup() in
 terms of memdup_nul()
To: ravi@prevas.dk
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

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> lib/string.c: implement strdup() and strndup() in terms of memdup_nul()
>
> With the addition of memdup_nul(), strdup() and strndup() can be
> implemented as one-liners.
>
> While not required by POSIX or C, do keep the behaviour of gracefully
> accepting a NULL source and simply return NULL.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> lib/string.c | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
