Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A150CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED60289095;
	Wed,  9 Oct 2024 03:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WK57ddef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C046589089; Wed,  9 Oct 2024 03:53:24 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A35890D8
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71de9e1f431so3749107b3a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438799; x=1729043599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qBJgAaef3AcjHyJBOXMJHHoblMAnILawWcG+QobPPgo=;
 b=WK57ddefgWJ4gAqdbl4qHNtIAQ2chjGIWR1kxZ8qbg32dBrVQLV0LkwRysSHZb2l61
 NqugCLsf0+pXSORGKPgtbSHFA1rCDxXTnxIGUnL25OJi1Ea4waVZFhkiLrSRM290wTk2
 54SIe44ZXTpzy63MZsGBW5kMgeQD07RCIrufc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438799; x=1729043599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBJgAaef3AcjHyJBOXMJHHoblMAnILawWcG+QobPPgo=;
 b=ic5Wvh4HcEzy4jX44MXaBVsYLQWZsAYJaZ90ES7GaqKRYBdg5fIk8aMjj0fwa6owPx
 raDHJzTsVcpyqRP0pX2nfgqMdLajKj4X8q/2El8prYAwc9m1ozIaMsugtmYZMroHMHyd
 FETiDPKAJjsOT+ECgyGchOf7LpWiuxEegvmz4BeP/mCLcykbZUE69PHtKCeNBgbo/zUk
 yti+hDVm/Zg1oF06WyGu915S9oOCnH7xXA56V6eztZeyHh0vBYHNYbEEDSXA3orwU1+0
 ybIgxLtsqwyH1tIdi/cBdP3FEacWpX43JLQLaOKD19OytUUhmMfmu83s1+tdMvZ+DCYd
 /jEQ==
X-Gm-Message-State: AOJu0YzBFqDyEGZiMM2Z8WxXb84cca3Zs4Y7rWdB2PyLHLl/NTSRYJmF
 KPDjNKro+0LrN1VSVt4BfiPR3WJ9QHupRR2+ZNTsYPqcAfNKobbxHxMEGTK3S0yohoEhPdUYEq9
 7Bjonrhv0ruQyO636I5FR32EHKWU0qOjCZv74
X-Google-Smtp-Source: AGHT+IGvBd70LSdS1ZvuaiF0tC/a5dGp60ykVomz4pJoAcsWD9IAeuk81nIHSKXn+ZPXRg2FzDUmO3wvKx2RclHzAww=
X-Received: by 2002:a05:6a20:9293:b0:1cf:6c64:ee72 with SMTP id
 adf61e73a8af0-1d8a3c4b88bmr1301995637.34.1728438798739; Tue, 08 Oct 2024
 18:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-10-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-10-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:45 -0600
Message-ID: <CAFLszTgqAHU3GeR5uqB5=LS4KTeeOfXYfXa_V9DNchi0TyEdpQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] lib/sha*: include u-boot/schedule.h instead of
 cyclic.h
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
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

On Thu, 3 Oct 2024 at 15:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> These library routines obviously do not make use of the
> cyclic_register() etc. API, but do need to call schedule(). Include
> the proper header.
>
> Eventually, their ifdef logic should be updated to avoid talking about
> CONFIG_WATCHDOG.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  lib/sha1.c   | 2 +-
>  lib/sha256.c | 2 +-
>  lib/sha512.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
