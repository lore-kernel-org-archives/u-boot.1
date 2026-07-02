Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3906DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC39084A20;
	Thu,  2 Jul 2026 22:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NoMMavmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5339784A27; Thu,  2 Jul 2026 22:01:55 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C3B84409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-37fdee9276fso2512793a91.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022511; cv=none;
 d=google.com; s=arc-20260327;
 b=qYiSE+SxPCFkHWLZrq/qCTMPvDkUfbmgzoHoaa4oRjVVXZbawC6Eiw+dRudS/a7wdc
 tFdjkhpqpeT9GA/Q+azv86eMKSp/kyN11T9VxPS9Iq5kTeyEZuXMiew/a9MlstbEY8dR
 HKCzevjCny5jsWBMp5nrorXiRqzb+4BAodIeew/QnHo/ss5aG33qQWWHVzJc8V6pRDPq
 tkpj8nAHFsra1pEMHojejsnKCoh4VZu7ussPxCnPrE5hqap8hPHcQIhSdNPIZGjtkLgs
 ONXNjBroFWgSzRKEgJVBR73kJBkh9Xnkj50UPBpsWiynuNYgJXrlPDlN9zhDI6/2R0Le
 Z6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8UlY7Scgzk8z3CVcMZjla3hqpm1OKaRpmn7xS9DA1Cc=;
 fh=zBUTdZhScFRAE2zo8HWawav7Cfbx7CX8X9If+AW8gq4=;
 b=qzFs6yu0plLEjxQYEAlFZqoA3QWu/XGrySYx3Fu+5plAs8EOzxZEbx9bmK0MlJ6EJE
 r6mbtseGgqv2D1xNebQt2+6zfX+OI6SVmUYIn8sUbXeh6CzOVp3g4CNKhLyCZNFz1Bm9
 WUFXcsSD7OFiyykr0UEIL0gUvtPwv3NagsP++2eVz5nNGydx2ILelP1tzY8+fmDama0j
 IQrpfNFger5fgn7nLg8NB/G8eMAp7L+SonLCfj6QDMioB4IE5N9AuyRfO6nf4S5g/ryn
 ///J+/WRs9EJfdQkVjHAxrHWFNr2ypnXGoCtR9AKwMxQYlP++gakrwhDOkdcO3lk1QS+
 r4Gg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022511; x=1783627311; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8UlY7Scgzk8z3CVcMZjla3hqpm1OKaRpmn7xS9DA1Cc=;
 b=NoMMavmPjin+GbV2cwBx9HeMYcC8G77WJUxAUJeg3qh1mLhD0HlRBsH9XSge/NC2nI
 bfBljH9iCsKJWVoQBoOOHAtJguqoUPOdUDbG9Xe8kB7T8T0gyRVYcHv7YeH/QoPEgqcL
 BclixCpDJXeTl3I8e37+fQ2eqFQbj89InsZSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022511; x=1783627311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UlY7Scgzk8z3CVcMZjla3hqpm1OKaRpmn7xS9DA1Cc=;
 b=E8L/hCUOU8so8LbcnKfTBRGKWdDXAg9rGAAdU9inW7F/hmiXFGkGfng8o9Cs5sni8t
 TUvcawYzew5hfx4xkUKdLwiaG0RiVP8o043NIxbLipA8XpKjB0XnkD6EUsGWcrNzgd5P
 iXhzcKs5XBMpVpvnr7Lwf2clK8Z1TEE3uR9ImLNl56XfzogwSVMgca8lwhs4QVKOWQQJ
 XGPAXWBWNG+jD0QQzhM5rG5It5bc3IySRIKL6hXpZQ/c+VmCj5fXEy9C9D37bCUIza6r
 FZLPCIe9MVy8BvlwWN1PL7W2N2Uv56sLYYRTnsWRrt6lQepiFoEax/+TYzJ4XwDJzXq5
 yZtw==
X-Gm-Message-State: AOJu0YzYr1oZwjNAbkHYu4JuqVAKqOC+jUothr8JLv8Db0LeS59pg6m5
 4weqiwfEOxOyJScszTvBWllP4LrsOZeR+k1sAr/9v8OSxyFlBZCfgc/QdYtCd1GAz9OBN5S68N8
 AM3fg9e9GCu3gFxXyWY71iZ6FJyGvaQ3tnlSNskYq
X-Gm-Gg: AfdE7ck4o1f7vree6YrjiqHr0MLXG4BaLsGKdasnhR9J8i5ZvIZqsn06v3ndzAOshMX
 WtTPHFIUlrCS+9yzYRi1rcp8dLD9oetx80GEWCT2IorYjp4OCOHDD/y/9AUpGWQJnK7P8fshyuB
 pLDt9qJIv1YEDZIBwrXivFTR71D6VvmFFdOLLtscU0+EpMLdTIPt+NLN3zD6LdQp7qfdS7ByDQ4
 AzbXpgAkER7t7Zs6u/Kym2pcYHbXEe2tZCJGk/U7ufazGo6TSXz/Y8xS0qPBXfhcCMcMm2QjA==
X-Received: by 2002:a17:90b:4b8d:b0:381:149:cf76 with SMTP id
 98e67ed59e1d1-3810149d35fmr2704587a91.11.1783022511430; Thu, 02 Jul 2026
 13:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-2-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-2-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:01:35 +0100
X-Gm-Features: AVVi8CcemUJn_MJGGmrtTkQfhVXr3uci_3f0xQdPulGvvL0j5sy5I_cC5UyW5G8
Message-ID: <CAFLszTh=rAi5bzkgax9buF=z31GeUBAR+3TzTbZykPbXYSk=PQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] crypto: aes: allow DM AES in SPL
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi James,

On 2026-07-02T01:46:51, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: aes: allow DM AES in SPL
>
> The AES uclass Makefile is already keyed by CONFIG_$(PHASE_)DM_AES,
> but there is no SPL_DM_AES symbol to build it for SPL.
>
> Add the SPL variant so SPL code can use UCLASS_AES providers, for example
> when decrypting FIT images before loading U-Boot proper.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/aes/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)

> diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
> @@ -4,6 +4,13 @@ config DM_AES
> +config SPL_DM_AES
> +     bool "Enable Driver Model for AES crypto operations in SPL"
> +     depends on SPL_DM

This symbol on its own does not build the uclass into SPL, since
drivers/Makefile only descends into crypto/ for SPL builds under
CONFIG_SPL_CRYPTO:

    obj-$(CONFIG_SPL_CRYPTO) += crypto/

Without SPL_CRYPTO, aes-uclass.o is missing and anything using
dm_aes_*() in SPL fails to link. The series only works because the
sun8i-ce driver in patch 7 selects SPL_CRYPTO itself, but the
requirement belongs with this symbol. Please can you add
'select SPL_CRYPTO' (or 'depends on SPL_CRYPTO') here, so SPL_DM_AES
is usable with other drivers too?

Regards,
Simon
