Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FC2EA71B7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E019839D9;
	Mon, 20 Apr 2026 04:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FS0xQzJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7162183B99; Mon, 20 Apr 2026 04:49:49 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E1283693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so1591147a12.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653386; cv=none;
 d=google.com; s=arc-20240605;
 b=ejPbwETbRWzoVBM/6KOAnvYTKaSLXG2cbvRRdRcRElKFAVYQu7uyUyi/nDvqOBp4la
 Bycqp8Rx+9AzeJIEJpBX4SX/SR+r6XvasyqDLPI6gCxA3BxcuXHZ4LrQ1GtQhhAOzV9U
 UYPNl0uouh2DZvVIkxLG7Qq+AIa8EE49ZJg8cJLyftfx8Wim7nQG5Krw0TwRXbBcapLz
 YNWeprwrQ7NSgz3eqxOnnKoOQstzSDddFviXD4e+aINIQ6mpfOoNZmccjpbUxnvLghLq
 JgklggVwnbRZ2kFkuW5cMHBTHYdR+vSNiGIrPfEka934aVrE5AZMLItTPXhs9S56j0N4
 rCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/5D6raRhEKwZLcrmQVoD9LzZw4kHPgBzy3EoJopOVWU=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=Zd5wbkFSEQuJUTdgSKuszci9dHWytqHimxJXOgDnT8H7Sq0Ob2dbmkQFjlNFjxEk1s
 FhZu1yWjiNAMmQuNpNLMG3UFgMqb5Bc+GGs6j3iuMMIdP/f0HW77N/jOiZpx/5wxSsDu
 JY1x1FEMO+rsrThgGEXMd6k58XXx87OcHpZXTXO/nm+cEouCalEKpGSjYT336jSOypeS
 kCPZYh5suPRXIveH4zDT5IPw7DhhTS6hbOeHrp4EMgfL7m2KlsnKE5lfCJowIlfJJ7zw
 fji/Um6ePuw3Azr58Jd7h/Ltm+ZfFRwtox5IrNRgdO3UU1q8NuZayJ8O13abscjhLweF
 Oj0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653386; x=1777258186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/5D6raRhEKwZLcrmQVoD9LzZw4kHPgBzy3EoJopOVWU=;
 b=FS0xQzJ3Vdn+XJAJHUxgch3OoQTNrVUhyc0xhqX+s0Ky4I+RBGaVr3oeoOu+KureBN
 u9olwDqcdQsCZfJ3znr799N76PrIFMCW8kQ+2o5e0IozI2LkjfBpZCX277kSp0ZLWQWh
 TwlY1fqDYC6x44yc1Kh3AbyVGnAQ7IvrEk9/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653386; x=1777258186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5D6raRhEKwZLcrmQVoD9LzZw4kHPgBzy3EoJopOVWU=;
 b=HOFkEqt6ZABnT4wJtcvZF876oaD+Je8AQM5PtUz98rupXICCOZXoSIVooYrZ8WhU9+
 XNK6VZeRQJo71ShULm82R/Ns/jcO3oPuK7d1d64PKfrAnDDSQQdoCKiEBwsaAXBJXD3/
 m71kj8Vti4jr0jVKFt2Qp0AxOZ/FV4yH2bQBVnAIHoebGY1Huq5MHPwMrHHXkPHjrYNc
 EaRM+ttCxYMX4X6rF/vPTRaW/I7eZFbgNYcyh704nlaF5JjZieLMacrDUioaHRsvxTRb
 HzAXznj3ZCWacbshIvZweh5pYacT/CG9DM4QwLPuFeX1ME45rr80OQFE2Lt8mWMtg8td
 r92g==
X-Gm-Message-State: AOJu0Yz1nFSUMet3bD2nTj+Hej05obI7NT4StX+azKjKQ/w/3poT63Hd
 6MkqHVs7NryAhlJEWBI36iKOqk/ZOHVQkknCzMTejBPSSW03LjTqyx78zQUTq+eNc6zc2+ondbI
 zro1ZpgIG0DdmtCAUJIi4RF9hb6N1J1bPRuEEhiVq
X-Gm-Gg: AeBDiesvJ5DUYNM2j4LOhjOcFpQ9amxuK6wwZzj5FJ3hne4adBk8bdChcNBVbr2okjP
 /STub8v7U96rfRaf2gvs6PZ81pZPQUJAM8Yx//EHw9Mq4zgLYGCJW8HTJfuC8dsFdm7dh2N/Ezk
 6X8BFr6YBm65GMMjiV+cKDKX7+eZwj3bkMQBlX8yAhOB8+RJotFPkXCW8Yzx3wB9HwZ6V9+FVN3
 W5oGRV0UfyWCSsr15NLCdAN6fDutYH2nJmGlGQLZIMrmi2QA0Vpt6Q20dSab4fknukJNLuEmtlx
 kQAvbFljr0AJwH83GNIb
X-Received: by 2002:a05:6a21:e082:b0:3a0:c285:e51f with SMTP id
 adf61e73a8af0-3a0c285f0bbmr4665828637.52.1776653385798; Sun, 19 Apr 2026
 19:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <fa6c603f6665c1da2fd84c027b7417e7bed1b180.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <fa6c603f6665c1da2fd84c027b7417e7bed1b180.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:49:29 +1200
X-Gm-Features: AQROBzCiez5JZbZm4Xp5n7dZ6YEqjXu4gFN68el1IxKIEuHSxuVx0LddVIJAx9k
Message-ID: <CAFLszTg8uKY5gkoHOU_=xjdaDVWvQ-9-dGtUKwTeRciBhtBJ9g@mail.gmail.com>
Subject: Re: [RESEND v4 01/14] configs: sc5xx: Do not store environment in SPI
 flash
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> configs: sc5xx: Do not store environment in SPI flash
>
> Remove config option enabling storage of the environment
> in the SPI flash, to match shift of programming boot media
> to Linux.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> configs/sc573-ezkit_defconfig          | 4 ----
>  configs/sc584-ezkit_defconfig          | 5 -----
>  configs/sc589-ezkit_defconfig          | 5 -----
>  configs/sc589-mini_defconfig           | 5 -----
>  configs/sc594-som-ezkit-spl_defconfig  | 4 ----
>  configs/sc594-som-ezlite-spl_defconfig | 4 ----
>  configs/sc598-som-ezkit-spl_defconfig  | 4 ----
>  configs/sc598-som-ezlite-spl_defconfig | 4 ----
>  8 files changed, 35 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
