Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE751112247
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1D484106;
	Thu,  2 Apr 2026 02:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N71wqDUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F007E84011; Thu,  2 Apr 2026 02:14:36 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84A680212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so48866266b.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 17:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775088874; cv=none;
 d=google.com; s=arc-20240605;
 b=akrYyM3O4g+LEH8uU+Q7i7rZ1B0ZcZY/MEYuniS1QGG04GNP2CkQPlwL3118YIn8gL
 sjsS0XEW4qN9W4EckGef4O/HbGFFvt/lbOQmHatRXiED1gBDR8T6K39Kq7lijKvP5bQT
 4Zbj3K1vvswtdxMPz9hIBVe7bYB99AEZb5O3n196nMEBw49k8jpkpzmgkuG8iwUzmq8C
 awRjQOwsM2SY6c3S3CPO7TD7ZayzJVAMIAAbAphD4IYt+jz84lwOokNbIgas3VGuAZj+
 uiK6INMNWc7Z2scA9D3hhFinMzrFaHv7/w9lrROy8JTcb5xiHC+yFA7iPwJWr47O5wN8
 rTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aZee0bICkyFhdp4zukzhxbLJKX0MqgCsqom0/z4hOTs=;
 fh=zFVo0D+oitaL3GoMfL/Shio4UNsBj5Jcymm2+84UAqw=;
 b=EZ7ANZi51bGUElfHfXT4G7itNzUSPb1H8k35dYuOzyjKmAQD++RZ8jhFSl0JeeRW4A
 A5KAG+LaIDa+ByaMoRFn9HQF5X4eky8bH0ZHf7zMVWt4JIQBsPHKINGyAAY984pGbP++
 ya5+QzYt0yrxcce3+Nmw7n+nqy2Uqqsj0P0jBZFmmmZG/EwufYC6w70Q5T+DgFpeVi7K
 SY2QgpSf28ZIprY8T5L2Ptoo7A76g3MVpLmVXD6onJV/k/hY8flnqSP4VneONMo+7rwY
 v2sYgNreKZ4B6HQ9g2c8QqLXxOErGJweZf/oB06SuVZ1ZS2CzbCDWnYYjT1xALtBJG51
 cGdA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775088874; x=1775693674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aZee0bICkyFhdp4zukzhxbLJKX0MqgCsqom0/z4hOTs=;
 b=N71wqDUxViJbrgo/FxiBuFPx18wIECrb3cIdCqAmGWlhnLSX6I3HbW9peA0HQ5Zgp3
 jrAn7hxiUjI5pp60L2KjJETDXmh9UrjIR7Mqmg2nb4cHzgqnfmUu2e3j3PT4aJ92B5RM
 gOHQT0dGbcJGIFjnGcAuQ9KNTGCz8RNEp//ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775088874; x=1775693674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZee0bICkyFhdp4zukzhxbLJKX0MqgCsqom0/z4hOTs=;
 b=W5NdF/lg6sBO1mwtJorQjMDDRo3LsQHDx0R91qm6uwLiOaTY8M3PeFPU+2cMm6xjmb
 sOvE9DVG2Ule3BAbvzksQSk97WlKs/9ajhvZ/OwrLPGVjK7HtaM3+Mq9fCH/DMPqWfeE
 43DUA1mWBrR9zLGLQhiAVNeHH/X8XOg9/H1I9XqWdaWU0CoeLnGc7U7WpRUSzG7IzTJ5
 DidJx29A+19LMmWTYLNUIC+Uii4h9yEhHYv4YDvtV16DJpSDCW3/WZg8ov3FPPweAmoR
 AwZUQwjwe8++oSZ9ngnWYIsKXudtaee5Slhs1Wzv5n7u+odj7yIqTkw4hy/cKfdbNc8y
 nj/g==
X-Gm-Message-State: AOJu0Yw9iej4nlZLiZleOxEmJQzckjMZL50Qbyhc+kRcIS0TJTjNMIRG
 aBmz56LH41FqWZDM9JHrMFMI0osUODZKtr7bp6Nq/Q4/m2v+0lUEnIhCTuO9VivbtFjdZJWhCR2
 YkMORF2ukasMCq3+KeHFk41SSNZrka7rbqeoR0qfX
X-Gm-Gg: ATEYQzw8WzsLOhvRTJSlw2n4cH69ldFEEQxB0/Easd5W85dqp0NmMr6bf3AhdnME8CL
 tswkZjG+lzWo0bQuzliPdhVefQ6dqfIDOtIxBWJ4TTg6IyE2OvQ1/GarjiFI9gKZv1xodhs9off
 yWF/CkqJSx/euucvik5URvKMyqRtICCo08CuEBIJKPKBd6C0OxT2deweCvlr7GiGhagSN4G+sRY
 hR6+YZiplWInwu2kns+fYV1cM5tKmpeLLktDt2tL/ltfktV4XGNwQpBLR4o2aX7f6yKEr6OEtS0
 pyn8vzUhVua7UKQb
X-Received: by 2002:a17:907:d204:b0:b9b:46ec:2f4d with SMTP id
 a640c23a62f3a-b9c13c959c4mr410565266b.41.1775088874391; Wed, 01 Apr 2026
 17:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260401124128.178799-2-gregor.herburger@linutronix.de>
In-Reply-To: <20260401124128.178799-2-gregor.herburger@linutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 20:14:05 -0400
X-Gm-Features: AQROBzB7j3dXBtui7hogZdI6QUwp1g6Cjor0RRSaKu5lwzQiG3lEUe7aq6loJQ0
Message-ID: <CAFLszTgV9SYXbPOGvi6pxt4CPJA-ns07iqP5JLrqVzyPGJY4eg@mail.gmail.com>
Subject: Re: [v2,1/2] console: add console_flush_stdin()
To: gregor.herburger@linutronix.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, David Zang <davidzangcs@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

On 2026-04-01T12:40:44, Gregor Herburger <gregor.herburger@linutronix.de> wrote:
> console: add console_flush_stdin()
> console: add console_flush_stdin()
>
> Add a common helper console_flush_stdin() to drain all pending
> characters from stdin. This consolidates the open-coded
> while (tstc()) getchar() pattern that appeared in multiple places
> across the tree.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> cmd/conitrace.c              |  4 ++--
>  cmd/eficonfig.c              |  6 +++---
>  cmd/eficonfig_sbkey.c        |  4 ++--
>  common/autoboot.c            | 11 +----------
>  common/console.c             | 12 ++++++++++--
>  include/console.h            |  5 +++++
>  lib/efi_loader/efi_console.c |  7 +++----
>  7 files changed, 26 insertions(+), 23 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
