Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA41C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F7784CAB;
	Mon, 13 Jul 2026 22:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lUvoGINZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08ECA84CB1; Mon, 13 Jul 2026 22:56:49 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC76B84A6B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 22:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-697de23bd7dso406807a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 13:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783976205; cv=none;
 d=google.com; s=arc-20260327;
 b=ndzXYWu7zrrmlmoa1jbndwSAC8NLoV6yQSZfMKEuF450y0b/z8igAfyexSt1SU5dGB
 XXABhgjFlNfufL87WBRqMZ5qdm2vc1NVi9/9yLbnKzW+QmsqKZwVd5usZpFCEv9GYU3B
 WFX+5oBWZ/VDAgKJtlqgVEn3JSkzhY2Lj4iZu0yGXj3+UfO4LJ1S0BYiO/StFvYZ5KF8
 t4JLhGDOxYADwoKwKqLr5sO8pchQwunMMVQ+cKZPNkOaN2NLJZ4adsE7yuFwEIwzW90I
 oMwuEd4JOBDcpz2KBhWO1CSzTy1G4wG3WT2bpwNWEnAsFZyxz/Rmv1d/1fZsXUndGBEr
 0fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b3bjU/3Lx7l+23ytREDBEVfj+uIAEYB7UFTFG9KrtSc=;
 fh=RYRoxNOjuHPJgeepkDgPG4TS1YEj8vlj2h5gDMROLMQ=;
 b=dHsHWROzjJzl+6NF5inhlb4sVUnWv1QDbuRVpaYTF3ljp5h15LU49hekQEqQGK6GFH
 jiZBWpDyXZEJnuJSRkr8gUzjuK7fE2Xsz5IrZATVpwtkAKJ8PSYV9tesWKHfPRFhgvfh
 8uUgQwIdsr38KmedCoAVAwXmjOOONGbeJ3ztDC+BTVBeVFY+nuUfV8kcHLQ3DdBOiVLM
 mR4ymzbInjQ2zSrCgNpIMzkVw4RHzaSvtELiKHBo/rp/r001nsV57UIPaJRTmHpBxGkl
 XZ9uc3xCyNArKzbWfFiueeI3IXvqABJnJMQwNwVj/6yrAaYRZZN26tixCASFmVWrfQMj
 fLAw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783976205; x=1784581005; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b3bjU/3Lx7l+23ytREDBEVfj+uIAEYB7UFTFG9KrtSc=;
 b=lUvoGINZB1mF+xDeJLCwd3S6sFGV7G1e1YT9bKDYXFICZagYjlE/uiTkI14VS0k14o
 R8L7fHiMllJlUErSZofGX3wPx4SpRT0vmMKbK7soKcpuDj/IRH1Kd0htHG0Qw65WYhWS
 ztCdmkdV3BSkMQu8eWDhT/7QXTmNui4+Z0/Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976205; x=1784581005;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b3bjU/3Lx7l+23ytREDBEVfj+uIAEYB7UFTFG9KrtSc=;
 b=bSKD4zYhRuC9cFgEPnT9syYRJwYf2Pix7EgXD+1OSO8mJgC2JhNvPD//QJXyM9tDCh
 GKtRWQJhtOWM2NniJ1CVTI38UZfk4U7GP3nWMdi2+GUQ16yryHWDQ5ONQysOUGQ9VrEo
 rCYRzBxMY3U7dJz4ZI8xMPa9thtpCwPh7oq+Wzz9j+KjR9FWX+vZv2FLATyCoPG/4GR+
 gmUrKgK6Q9cNLWVQL0rmaOz6bbXHQnpZGKEQGiBygRykTxkIjlv2INRgXiqMJVP1HToW
 y7FPVXPH2N+clQ3syp2gPXWswB+QFk4wP4X27mHy+ggKtiVSdkpRUbIxpYUEkL99WK9k
 IUOA==
X-Gm-Message-State: AOJu0YwEstGXFb8tICMQwevJ4S/cBQEJsj3znxML9gPsnAIKNXizQMLW
 +SSO19n8OM2FZ00bQoUSt/BkuSLhr8dK5CKEZ3nHtlo25zBtpVQTJfPGWOD7KE5N476D3IIG0/f
 8ahNwja9bfmmsGwRJoZLl33AcrDMN9aAVQd0qtn/svfTWXlc2CFYevQ==
X-Gm-Gg: AfdE7cmO0uaaA5b9W9+zIg14ECfbStE9PqHoFXdPwzfNl8nBYeeB4WFfeffjODuwANA
 KGJrHzPuYWy5S6Q212lg9aOwOhb8A5ligbZtvR/Cyud/Y7ppIPSXkHaGO75nmAMPtiriLNYKJXE
 iJlZytKnyEvhZdf3jBDTdxQAIaEDtFZNXaRLc/sXcl6fAJ7A3pV7vBK4905zKeUzlpV3D6IIw3Z
 m5s5NbK547KqEPyczNc+Ujbf5/tMMrnsgJQpxdXSV9lUrkdePiqn/p6q0R+nfmhYYKbdq2iPjRB
 ZENTbA==
X-Received: by 2002:a05:6402:5247:b0:69c:794d:48ba with SMTP id
 4fb4d7f45d1cf-69c794d4b3bmr3513103a12.0.1783976205230; Mon, 13 Jul 2026
 13:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
 <20260709142901.2054431-3-pranav.sanwal@amd.com>
In-Reply-To: <20260709142901.2054431-3-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 14:56:31 -0600
X-Gm-Features: AUfX_mxfzVXodFZkHWp_DrylNiNn_IP5y9DOv0z8mc0lDFbmfikFgbf1rEisjvs
Message-ID: <CAFLszTgW3nuqxR_CTrpx2oxFMutv=R7+aj594s6WBrp47rNnUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: delay: set gpio_count and validate index
 against it
To: pranav.sanwal@amd.com
Cc: u-boot@lists.denx.de
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

On 2026-07-09T14:28:59, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> gpio: delay: set gpio_count and validate index against it
>
> gpio_delay_probe() never set the uclass's gpio_count for this
> device, leaving it at 0. This left gpio_post_probe()'s claimed/name
> tracking arrays sized for zero entries, and left gpio_delay_xlate()'s
> bounds check validating the requested index against a hardcoded 32
> that has no relation to how many lines this instance actually
> manages (ngpio, from its own 'gpios' property).
>
> Set gpio_count in probe() to the real count, and validate against it
> in xlate(), matching the pattern already used by the generic
> gpio_xlate_offs_flags() default implementation.
>
> Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> drivers/gpio/gpio-delay.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
