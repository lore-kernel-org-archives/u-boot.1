Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC2DCD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 03:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE0F846CA;
	Sun, 10 May 2026 05:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XCvk5oBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7384F8483C; Sun, 10 May 2026 05:22:05 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B2284679
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 05:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-59e5aa4ca41so3152221e87.2
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 20:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778383319; cv=none;
 d=google.com; s=arc-20240605;
 b=AvA5zME384XaA3VvYiM+pP6cErV4ABDfO/COFLX9aJhHHImYQFf0CD5kqQTeV/Zcat
 JGQOHdErMdJLaiqtbqL/urtrnR2+t2zkT8LR8a4/IXB/JJHUQg+dUmUwd7qcz0YFPQWQ
 mBiltdK9ISNsUoNajZQ3o/2GLvhaBIAMU2xhQYynSQbUnOYAMz3YipaNKU1cyGI5BDYO
 aC2gxTTdjV96GwuoiHn6kB4RrQkHd8Et+CK/Yr/jYN3B8gN0T1GxkRd9Eo8hXFGC9CIe
 Eqe6QkTCVLAZ1sNX9KnYoLtZscPUnhWqWXnxTU0ERGOLyuBfWIiUPAPp0m6mFPF+iCYe
 hY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ElqbdR0L9k5LJ2Gbp6Eh3K1Mi5mC4MGPUB4cxa88noU=;
 fh=Ba4hdmvaL8Iqn+laLAZ6Zwq6KO+OgpTCF9Lsg9Ghi9E=;
 b=T9yOiipnS2S7mEnhRtWJyYVUTzUKnRmulTsMFuZPO/RMP2ttIIgshNuPmxNevpcrxA
 Gk4HLxr6yHIbAUNEJmaT/sHN/TVcCwwJz4+8V6pofv8zCzpue+cMmTaYZe4GrEv78+hu
 q9IasA6OdMLlRdFxP4nEm6GcHRJwh/EA5ojK8lWy2RTrUffklRfQS0fntat7gKnnZjYw
 a0f0vYgrNjFwiN+UUkN1XbmCs8/XeqQ0t7RVQLoFmpMkmrReFL38QuVTuwts7+9Ov52f
 w6LxbVnywcD0J8w7fzpMKZe1WeoMDIIXzMevAYimISzSOuCjPtYRUS1tu2ihopZQbZps
 ALTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778383319; x=1778988119; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElqbdR0L9k5LJ2Gbp6Eh3K1Mi5mC4MGPUB4cxa88noU=;
 b=XCvk5oBlQlWQ8rBmxXdsgl2Ti/Fm/O6rAcYQeCWMuejGthzNUC5kmCuPTYkREA531k
 H3boUHRrl6Hxm66/exeaHmmCVzyqz5lfGc7G1Py5SR2LNLXdf6FKLyea8r7t88sv9gkQ
 rA/02viSqRsgroESMRwYsmxu11hOkUBRkvgeytdxwrO7u37P7WmS1MnjTAimDI60+u7S
 7qnleGLp43fUJmdtnp9TpBxsNzeJfJON7reZHVWlomsYwfSweoVWPHfCgZtAgFIA64SO
 veMLy6vHFZ8y58U5rD4xXOtJPjmO9SNUljN65ja+sKJoEz8UdnrdulPiinwRvzcPvx/A
 ap5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778383319; x=1778988119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ElqbdR0L9k5LJ2Gbp6Eh3K1Mi5mC4MGPUB4cxa88noU=;
 b=khRWgaoPjASst/0oFvyn6FyGtiQFcgVswq0hMi62QXBCVUQtWsSNEsAIwE94ivH+JM
 f/ubVk53eFYlQm2kzwCV2AKlp0J7nZiaHFmSS5G5CtdBrFKJ4LWsogp8VW9ml2JFRyXC
 doyECLAPJWYBJmoi7DbNLzHV5Tb0E+IVihoGGcbQiJclJC3/SE5lAwxxnanpUjrkYbw0
 B6QwYL+1uE/o3KEbJY77igZ+k1ZJGllAEnSeZVfX9BYxKFkz9uO1smMKr3gQIeXQlWEE
 szozCfV1h/QcW+mjrLFzTx6CgB9O/rUoty06r/rvSypqTnkxGyz4WF7dVw7qiiSZjQaF
 8erw==
X-Gm-Message-State: AOJu0Yy2fVzxWSQYWeft0u2ITcpAZtZinyzV+RnXVeCwpEA0NV61jW1y
 ObUd8mYSEpsvu7NC7p8fftabV9iePRyxoM/9TT40FredEEeiWdKVey0DIiozr1Vv3vWKf5rXHV1
 ASYjty7Rrgw3E2nJRw5jEcy1agSXqjfTuNw==
X-Gm-Gg: Acq92OG/48wD1t6lRfMDPkfxBedxRyp4YUX8twKkwwyic60z0+nJpA7zKHJcuGq7+Ts
 gEw/Ln7M2jMzxOGp8G7/dpCsoZMp4C51hOKqPKYooNtbxFU16uVFRb6DIaNoSscg5K5J39dP0v/
 Dtb/wUl4O/p/3yokaOFzjiRig30usiYg6U8BFlGMhLLhqvZmQ+rl8La69i5ip8ZfF702BYRQ5jW
 mDMgTaygfC9eTTfGQ3y9ZMnShL09DOcJU1XjjSKQFUcIRVgEw+IHjaY+VE6Bm8Vz/lztxBUf6VV
 zaA1SsO2NM5be8couc8Z6HMCAeFnWBB0a6mHGshvcnUZkD2IyKC9GTSI5xxDKNjezlmaGotX
X-Received: by 2002:a05:6512:3989:b0:5a8:891f:388 with SMTP id
 2adb3069b0e04-5a8b709d36fmr1054022e87.29.1778383318411; Sat, 09 May 2026
 20:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 10 May 2026 00:21:47 -0300
X-Gm-Features: AVHnY4L2f4b9KLp3p18dKj3fi54mnYqglDoFC24thUY0b3-FwE1P1g0b-UJrvlc
Message-ID: <CAOMZO5CRxM0zpU08ay71CUaWuKs0pK1BjHxeVJOVoPg+5Qms=A@mail.gmail.com>
Subject: Re: [PATCH] led: Fix toggling LED on initial SW blink
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, May 9, 2026 at 10:47=E2=80=AFPM Francois Berder <fberder@outlook.fr=
> wrote:
>
> If the LED is in the ON state, it is briefly set to OFF
> then to ON immediately due to falling-through in the default
> case.
> This commit ensures that no fall-through occurs and thus

Nit: please avoid writing "This commit ensures ...".

Just say "Ensure that no ...."

The imperative mood is recommended in commit messages.
