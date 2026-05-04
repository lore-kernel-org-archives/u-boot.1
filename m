Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88721FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C024A8465C;
	Mon,  4 May 2026 14:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dPrJvHCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3FA08465C; Mon,  4 May 2026 14:15:32 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6F78394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso4500652a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896930; cv=none;
 d=google.com; s=arc-20240605;
 b=CqzcxdYQaZyj6TyC6z1UXfGKJTtlDiCKQGxdDNA5V2hc4ct5/3c5TkOzdnrPistie2
 PThfOOdMOqj76i4JiMLul92LfQ+lnEaSZa7SSBpc+jwTVzVkBl6LYKrQiuVA/MZ6MHSp
 O7LVK5N7C1osB0Sa1Uhm5wzgFXmkbnKT2fghT6av8TOc+dCnVs1EIX0HKqBIZaAggA95
 ONSpinZzFgLsXZ9U+bmti37f9i0k7tKSTXFE+NgfqFnBFcsH0dDWCWkwE82rer9HRIm9
 vdi/Gd2JhOfvvr7j+7NA6jRvNcGUb0IIGNLQvLUVWoRs0wWKHNogw4AH6Vnfbfk0905z
 x4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KpxFgc7zManRCkoduSqx8SaZfaL9VEakirreT4Rj1K4=;
 fh=jmbcoFG2RPEOJsmPKSiakkV0VWJqP8RiS13G+yktnmU=;
 b=JL07PM3lN/eZ3gWBp04IAy1InIDNDv5Ikn1t1gsyxEGkIlvGJlS0teVY0M+VcE1A9x
 pLKtmZ5BnDI4RgvWACeb7pQpcaIsI+qheC4OBhNJSltBz8PMztkhCanFlhtDZ+H/4DE1
 bjxh1wxUOaQ8eofgMsSQ1thfmbOcJh+jHOPf4L6r3QMR4FrLww3em4P8wd5Uwq0ZbE/5
 hyvfvFgYph05A22grujHVVM8mZlwYwzRp2ozFsbXeGsTZaB28tV6JXdguuOS/s+lZVGb
 cMJrZ5lxyeBfnSUBgHscdn+ItiRjTvAwC+jJiOP9Sadc3oA375T7yFLJbXtnCjHL/uWn
 Hfjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896930; x=1778501730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KpxFgc7zManRCkoduSqx8SaZfaL9VEakirreT4Rj1K4=;
 b=dPrJvHClFb7Sjv+xG8KruhQkmcHW4hi2zkKMPRkMWag59VE7bujKNGLZt0oNX6Usjg
 x4oyWdx/JxGIJVdsPDINA8nBYbtTgx32SNXltFoYOxeZuu+7s5r1HcuSWox54FJL02ER
 AFZlbQgcLdOgjAcytp0Yl5Bmvxlb1VhZyx4vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896930; x=1778501730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpxFgc7zManRCkoduSqx8SaZfaL9VEakirreT4Rj1K4=;
 b=mgri0mZw2bTPu/kEHbVaU1Mpz/kT6aoLWGPUI2VpGKG9gC75gsMtUwOJcvmbMZWrFf
 UmVfjpzIsCbwYVBQ0uFhrwTfWMykLkHnRS8ZoWVKxmFM6bvZ0ZEZZwFWoPrI8hHXsqWw
 /WTiGxqAZToONIgi6F+jMjFIwCRSfRmT5fRi12hzy/K2hK5JLToMRL6ywS2Io+O3cEX9
 IsuhVQKz77XVKjX12XOGRnXgSmWqLbMbhS6Oy4QpRUPeJlJ2FwnAeqxNwJu0dQcJbJbL
 DjbdBQGii3Kny4q5fqPq63l6m43/PfHLrw3VYbqEPaXDwOnVwIem3ZXBdy8saPBRZZqh
 33Vg==
X-Gm-Message-State: AOJu0YwN8/bDVGy25w77y9RlrEppftCbQmoAomH24eIrIfjryKNJqczv
 RcHeIp1XFWUe09qREbPVrGG6Eq4mnSxRgHIbsbZ967oxwahss3dNtvI4+enlkhADTa1Kuyjbi0v
 uHoO++wkleTPewRMCZWveDl9TZv+yYEVt9skCtT2fzybsLewCpSU=
X-Gm-Gg: AeBDieulYQyAhee8MRBiIY4tjbAHA+RwrKOboqy6+a8DOgmuUg5t8ogALdaklXl2MpR
 nSPINZV41AdHNQHdykKnaZQ3fUKv5ZYWyOVZMLaBNAlD/Yt3PKNlP4Ml8UnpfhSjx+5vwb9Qklp
 hNeZBmMTETQ65u+0ZzLLCMHum+6LfLvi/5nHOfCITtdB8oW6yW2mwrd6YJMirwa8Jj3iHaUecXl
 NeMedCmn8Dzr5FT5xMH4e45EHKypeJbMRSEm84VrXU25aByIKlOFfK6Rm0nNE+2b71rtraMg36L
 nQ5s33Q0KB6LNgjb
X-Received: by 2002:a17:907:84d:b0:baa:2d37:cbf9 with SMTP id
 a640c23a62f3a-bbffa73b06fmr471594666b.1.1777896930266; Mon, 04 May 2026
 05:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777551598.git.michal.simek@amd.com>
 <9dde7ae68776d22d37c06646210c30c3a5874e17.1777551598.git.michal.simek@amd.com>
In-Reply-To: <9dde7ae68776d22d37c06646210c30c3a5874e17.1777551598.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:15:16 -0600
X-Gm-Features: AVHnY4LvDRXgU-YPwFs3it1R2M_muQbOeWE3Bo0idAlLZtzOHWvgDXD9-WEUB_k
Message-ID: <CAFLszTj2cVtH+RV1qiyD36eJY+dZGba9zm1sLko8mE+tbi4tBg@mail.gmail.com>
Subject: Re: [PATCH 4/4] reset: zynqmp: Implement rst_reset using
 PM_RESET_ACTION_PULSE
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com
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

On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
> reset: zynqmp: Implement rst_reset using PM_RESET_ACTION_PULSE
>
> Implement the rst_reset operation in the ZynqMP reset driver to use
> PM_RESET_ACTION_PULSE. This allows the reset controller to perform
> a reset pulse in a single firmware call instead of separate assert
> and deassert calls.
>
> This matches the Linux kernel implementation of zynqmp_reset_reset().
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> drivers/reset/reset-zynqmp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
