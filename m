Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E6AC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 17:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6A1883291;
	Fri, 18 Apr 2025 19:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BEi6UPWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0428329B; Fri, 18 Apr 2025 19:19:53 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37325832BE
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 19:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so403594966b.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744996791; x=1745601591; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+9tNlgvPyz0xUiYhTmYFES5JC4WQEBJV6/5atuGEppM=;
 b=BEi6UPWFRkvQC0xBsqoHECzO0h0Mlht5hJSVwVpQn3pCN4kmtNf1ohEURmjHWVq15+
 Ui0gB83yQARXJx0L3NrmRWDK3q7Lro+IHVFIGkzpbJ6PWoEuW0VBV/70IzZEnRLwmgZN
 Nz7dgZlQTjsFLUeNYSL1VfrtAH/+spXwZWcnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996791; x=1745601591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+9tNlgvPyz0xUiYhTmYFES5JC4WQEBJV6/5atuGEppM=;
 b=nRlZwa1yfEMzb5DCWYhVWlW1rnjNbovYv0TPdaH5wrMJCz8TEhMTCgA5xlmY7O38Bg
 AFCqFSOFffH1oToKXgJSFIVJqE4HRd019MSg384omAXPqhXY2AORxwuBLx5ERvL/RqBH
 +iYtdl7aC1aMvkodBQHwbwjVCAoRtyQ7ER3Cr0XdTwF7H4ISRj+sxKlAfWf4U/8/Hfeh
 GzQJvk1x7kq8pW2kmOY9+N1GNJg2ioW3lm1xIAqM5FSgd28y1hayd3nUo9CHyxv1hiKv
 Q8fAtWIBx349dkbygkTENDTBmtIj87l+X1VdV26u1cflAWvnDLcZhXvVBAZMaRS4eHOS
 juOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVURjJ2T5qk2OAF2moYWtDvhg2ZnARaugZJGXSSW/1P1zWhFiwPmCpCL8gztKxakhf8OnmSL84=@lists.denx.de
X-Gm-Message-State: AOJu0YweYoo2wrQVOXllz4jFUyxlOYHGqHY0NLdn+mUJ0oLlHg6GRnRg
 IuOKaVDN97H5Y40yqg5ZFshIEevLvJqRrbbPCmN9uFHr23RoQi/drI8BgjvstaonZTj71+GSc1P
 4oAQNhbpEuH/1L/Us6Vg9KfcBp3L3DNli3zc3
X-Gm-Gg: ASbGncuBkArbfQ3JvxwPyA20Dj9ERZqtF3iJhLaWhGiksQ9G8sj19RZV+LOodmTONmv
 DvSOCFnYJjskdgerouR4lcODLMXX64oOU95umULHOvAJ0NX+RbtjNN6KzZ+MI612w1IyP8HCUcg
 SpZp25hRRjoCs/tbxMvAMCr9Q=
X-Google-Smtp-Source: AGHT+IFTMW3Cfdx7s3vc8wjp/iz8Ql1p4j7PZS4Dki7LLqDAJ76ROOH84IBAeKEI/U6gJlpr30DvepRFrTqOqwq1Px0=
X-Received: by 2002:a17:907:3e20:b0:aca:95eb:12e with SMTP id
 a640c23a62f3a-acb7534d862mr233394466b.24.1744996790678; Fri, 18 Apr 2025
 10:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-1-b6b90a765ffe@cherry.de>
In-Reply-To: <20250418-binman-pubkey-dir-v2-1-b6b90a765ffe@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 11:19:38 -0600
X-Gm-Features: ATxdqUGfqR3EOGaB12sk3jJSrQC2yg76AMVbMEnU1LecKnxxXcLe5IZ7L549FX0
Message-ID: <CAFLszTjkEAO9JfMy2XiAwg+w2BTZu5_3dNNU3zUJfd=nZ9kkQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] binman: etype: fit: raise ValueError if
 key-name-hint is a path
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> mkimage doesn't fail if it cannot find the public key but it prints to
> stderr. Considering that btool.run() discards stderr, it means binman
> happily returns an unsigned FIT and doesn't tell you something went
> wrong.
>
> Binman will actually find the file if there's a path in the
> key-name-hint property but the current logic expects key-name-hint to be
> a filename and thus returns the dirname of the found path for the key,
> but with the original key-name-hint appended. This means we can have the
> following:
>
> - key-name-hint = "keys/dev"
> - name = "/home/qschulz/work/upstream/u-boot/keys/"
>
> so we pass /home/qschulz/work/upstream/u-boot/keys/ to the -k option of
> mkimage but the FIT still contains "keys/dev" in key-name-hint which
> means mkimage will try to find the key at
> /home/qschulz/work/upstream/u-boot/keys/keys/, which doesn't exist.
>
> Let's assume paths are simply not supported (it is named key-name-hint
> and not key-path-hint after all) and raise an error if the property
> contains a path so that the build fails and not quietly.
>
> Fixes: 133c000ca334 ("binman: implement signing FIT images during image build")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/etype/fit.py                          |  3 +
>  tools/binman/ftest.py                              | 18 ++++
>  .../test/347_key_name_hint_dir_fit_signature.dts   | 98 ++++++++++++++++++++++
>  3 files changed, 119 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
