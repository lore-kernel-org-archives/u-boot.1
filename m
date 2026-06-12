Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42448CD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB81D8484A;
	Fri, 12 Jun 2026 20:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X0ngtmmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92E58484C; Fri, 12 Jun 2026 20:22:29 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA90B8063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68ced97b6eeso2055178a12.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288547; cv=none;
 d=google.com; s=arc-20240605;
 b=JhgrnX4+fnaWr/Y36DVIIHm9be1w7qQ3rbW7Z3hnErga+6C4zJ+Hm8SnJeSw1otv1t
 Wb9SUikKMubl6LBQ0ki0eWBTqkp+a6KVSw2nvPqth5YjrED7H4SX2FwTZL+xqOoNGXwG
 32Wr9c+Y/nNWLRw6kMkxfq36nkXMNR7LKc318DIQ7KhYhAiqLyrH2r7k2Nzu+NOCVbie
 +0wEejIthjD9Po16h0VC83Db7W5qre5v0OffMGcwk6Y/1FhdLF1NoWNv78y6PexEBC/9
 8rhY8oGq1w2NNuRvHxT0Ig1YvrCh4PPYgbuDg9PJ6BBOYSqZyi09W2m7AR44cYOYWxsm
 hK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UNyKbRK2osQ3AHVKIfn2lUsrPs8R04DZDQ0Z3QxLTMg=;
 fh=6PhCOatK0Oj37AWZL82RSrOpp5XlsPmLnZiVK5rZ92k=;
 b=ADYTi3DPEpn9peBaso4fTNiS/fl3X7OK+d3/Dc9CU5YCHkelUJSoyr6RTEH8LJCigI
 MYXXwPLINoHh9WyCzS6IdnxWdquUCF1ZlCMLA+YbuIXGh2arH1lHX6ax9CCGeiWKsdQI
 WjTHHfA5w/SPQ2/KlbJXR/cCFjehyw1M6tBouAz1QTWPB+elReYJfuEMMK8zoc9UPzJY
 4XuBtlc+UUcuOclJ9cDLQd41qas3nVAQfTlIR8ZoOSW2+OzuHLHMB8sJBaRaSClJlICj
 dLLe5zJ8OBKBl/7m7nZogVxHtytirjnHp5jhiDXwv6m0nZbeKDvKEHamhXZUpvtjmOML
 UekA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288547; x=1781893347; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UNyKbRK2osQ3AHVKIfn2lUsrPs8R04DZDQ0Z3QxLTMg=;
 b=X0ngtmmEuY/tVPqP31CqDa3EwZ+6Qd8btb2J62EM2vqpH1HrHo/4IR54TMw0C7n5sm
 d6qzPQJdKZy9eXEKhdmGsppop0wdP0R7I3vqHPGUw/vFecSStD3LBL/NVLVQSsvbc28K
 lvSZe4dj6MvyS6oAOQJfSiIwICo7C6PQYXR0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288547; x=1781893347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNyKbRK2osQ3AHVKIfn2lUsrPs8R04DZDQ0Z3QxLTMg=;
 b=HqpfHdXUt3nFHHXDH8CeRzF2owmG6+JOgrZkZJpnwej/HCPrlm4C8Aec9xfPsr82PV
 0SRUNPawA5WwuxLGKVpOZ858fdDeUyspjfVT6tMVlTIHFceq54WEN9++1D1sWD2caxFu
 93PsF3cBHwYwG2qF5TwgN1XxQqN/eUpLF+V4EAlGm138D+d31gXlWYGLq47PCoLB4Nu9
 OnwRlx2Uc9g9taheoa+nBIZ1RvNP6iD9OQNcqIdvm8VF9R0LgddJwY4CP8IFiAeLAPKF
 VoU1sZvDHG754Aj4mUxhOwQy91kVKJ4MXTBKtwuUNa4nWa5KQVpgD8XUFG41pGzAmqAt
 NMCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+24BfLeJfoa8SbP2GeV3rdDtTsefjUJ2IvphHrLsx9j+dMLuZodbHMKQsk+7XSEn0l+95VkRY=@lists.denx.de
X-Gm-Message-State: AOJu0YyKvF5XiqjToR44Ocazs1cf8QLD+WrHc0UG8oVcpWsXTH54ilz0
 m+uW/LPOjuw2AE8EL7EraKkhmmnb44kQfsdkREJLvoILh/Cc2x1eBSilfuSF0zXSHY4G09x1IgP
 LpG7pBLz+zJIyo4c3gfVjKlYX4JcnFK2eQDuS7vNB
X-Gm-Gg: Acq92OFFXzX+4bSwe7HRDoH0MhChXnG0ijQ3R+qs3SXleNJdFTeOkLr58slyFmHZE4r
 wPl7dzlCOdmvg9peCQ77GP8hTlmgXBcVq2zJEYnptCchMw9WGmQhMrVCgPQz023MaTna9hyEoPU
 m4ZKpTvhcw1r6tvANDu2yLFgAsb7FjdfLl5aIoiILB73JLhJghk6c5raMzfZsXqgMdXqw74z6zP
 kXWabaSQL5ivr5e0nySY7WwMbwXdnCLjRNP2+9pk73Uc7YiDeYuoZgaZUehCkRFia4OxaiH9gUL
 pCbIgw==
X-Received: by 2002:a05:6402:40c9:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-69378a2f837mr2062346a12.23.1781288547304; Fri, 12 Jun 2026
 11:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260601-simplefb-rot-fix-v1-1-eb65d41ffffd@samcday.com>
In-Reply-To: <20260601-simplefb-rot-fix-v1-1-eb65d41ffffd@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:22:15 -0600
X-Gm-Features: AVVi8CcnxQVVZoySjNdMfnNzgZl0Fx-agU9Sc6vAEcqFtrkWqoEEeCX8gZ4js8k
Message-ID: <CAFLszTjWevUgefjQtsQ_2v0a8OATFZFvjdD-GsyXyxSQeWvjdA@mail.gmail.com>
Subject: Re: [PATCH] video: simplefb: fix rot prop handling
To: me@samcday.com
Cc: Rob Clark <robdclark@gmail.com>, u-boot@lists.denx.de, 
 Casey Connolly <casey.connolly@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
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

On 2026-06-01T06:05:33, Sam Day <me@samcday.com> wrote:
> video: simplefb: fix rot prop handling
>
> If the simplefb node lacks a rot property (which would be most of them
> nowadays - it's not actually a valid prop according to kernel's
> simple-framebuffer schema), then the rot local is left uninitialized.
> This causes video_post_probe to fail to locate the vidconsoleN device
> later.
>
> Strangely enough, simplefb has been working fine on arm64 targets. It
> wasn't until I tried simplefb on my arm32 device (samsung-expressltexx)
> that this issue manifested. AFAICT, ARM64 doesn't have something like
> -ftrivial-auto-var-init=zero enabled, so I suspect this has just been
> working entirely by coincidence until now. Computers are fun.
>
> Fixes: 91e9687b49e7 ("video: simplefb: modernise DT parsing")
> Signed-off-by: Sam Day <me@samcday.com>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>
> drivers/video/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
