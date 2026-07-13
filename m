Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2C5C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6493784C25;
	Mon, 13 Jul 2026 16:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hKSk8nwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA98D84C2B; Mon, 13 Jul 2026 16:23:48 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAD0584C25
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso3268621a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952626; cv=none;
 d=google.com; s=arc-20260327;
 b=UbOqQ5GskNQzexMf98RULYR4XVG7wJRJ5DnPrPaM9+XoXejSgJn/ESXwiKm7OXVL8M
 m58T54yDxiK9R6sGxxBTjQlwRQDdXAI6ccaZ31mEb0XBT84DqXOsg24ajwelBDPK8Hs/
 FKbN6dU8HQkJ81luPeq4nJ2HdeF1zue3GWcCGTxHiF8S+1odDX0a+wDywQSJqvoNb3ix
 jQNIFyKLSok28KFddlXABHGTciJfOlS2Shbnt+5bsfaJOVQQeYotoBk304QaAd10DsDd
 Qr9gKZ7TVz5HWBtZIiR52dvmFX1MOMiF2wxCrxaB7uk1wkFsh2Au/us2i1RRiCLBHOGq
 mgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XwCULa665YFM0B8s8Ln+jfmmWZ/ABMNDkZwpZBfSvG4=;
 fh=OwajRzg04Rr3msrs0wa3gfAgnPwoZLNN4oN/egFeRU8=;
 b=OOYjuybma82bUTYPl+US7nwIWv8esubhsB2x23l8kQN3l698gujchzzFfJwQBZBYj5
 XK8QZhQPgIzWbDJboS5SRsFs46+BkXgaalXuuWp1ngondg8t/BTmgr5bfItCHd9xusg6
 31Eme01g72ENhYAnCI/KYop6na6DWeIDGoaS06wYVpd2AyMXvpGanJj7CZX/VlJHHaQu
 +XrI81988AP2y22k3rdG3cYTY1hpn/VoLIAJAV2UuTedCImuI+ij1DViSjW2933HaEWJ
 PXkfxOTWeOLTuex2w6t+IGWKCwpcVN98M6udg8hpNCZqKiZqDdAZDp/XiYZalRZWrIr4
 /v7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952626; x=1784557426; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XwCULa665YFM0B8s8Ln+jfmmWZ/ABMNDkZwpZBfSvG4=;
 b=hKSk8nwc1l1nrpSS6XXt83M6e4DA5qOElq1Nkv8jl6B6go7VThn/icncvrBuHJCnrL
 zzX9nc1KOMSmxColm8BPmDPX95Gdcqm9E+D4RcmJxSOCFCykFTkvmEAgYA7Q47edYfEy
 2i+58iJUsmypAxFBpi9+Ti8FQhGc5Cq3v/AR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952626; x=1784557426;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XwCULa665YFM0B8s8Ln+jfmmWZ/ABMNDkZwpZBfSvG4=;
 b=prRu8K6DFFb0eRJn1FpgEFPla/I4zKxQtwKRFn1koyzXa3ZFxt5PJI1T7oai2/jYFI
 zG9WLevhi0yzsFI6ghwjW5gH2STIGFtHRWi745lAWzs3uDMoQ895xpXA7KkrKyAaBAjB
 VvCnxZHncuSkVgxGjg16ws/tG6VNm23WqkWu76kUbLMuasrL+3Ui8khkSmysRVcQeyeu
 95rAm4CyotLGBGZWcXTAf3ObE3NmFzwQudsRyZi5VmVJK2Y48HWPiXCOldNE4gtQOtaW
 D0YIvN+3/hRtAeJ6HbhQOg4UZ7ZwoxvaCc9E9oDBHx1+YND4UrBa2Oo9H5TZo084G/0T
 uteA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpha8Wo7tGpa9Q6wUua7EHNDPez5CC15bSRbJsF9jNfeMp405DyB63mZkKS/k/IN/FEwQN1AOI=@lists.denx.de
X-Gm-Message-State: AOJu0YxEyVCz9XdPC/qXmJM/Oj/VyBn5Gfl6arer224nZCnySBChY1Yj
 zuF9kxhc4pFnXdcw/wfj3pJtlPM0nrDmnDKASP5Z+hHHETfqnwisJtf0aeBiwSmi9TwzdKm/rpY
 SpHgA1+d9kVsoJd/hLVFLbwcW5twKuA1ABUOdy7wp
X-Gm-Gg: AfdE7ckWWeSkMiv6rn9Hsd7A4vqwyDMqpPV1PHdVHysHCSQdLTMeTI6SgunVBnD2zef
 Kx22WBJChDBMMZclp9qDPPmpcpJXLqJnFTkoIB5mwALLSV2TOKmSaIySQGto5ncyAyJEymaYAzw
 58MvSiUvHf0wVXg+ULd9rleBxaNyDsO+dRKaYa8fNbHuAMq8VWNZeMvgdzpKjOY4LhyRYQKtUmU
 K0pIusKHfu+24VghIaopPdpYUAr2ogCImOHE8nIrnZRdly7FFtUmZcPJVfJ4dGaGbU6LeZJVl4a
 V/EQfg==
X-Received: by 2002:a05:6402:5293:b0:698:de64:6aa1 with SMTP id
 4fb4d7f45d1cf-69c5f0b9510mr3913469a12.10.1783952626286; Mon, 13 Jul 2026
 07:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-3-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:23:31 -0600
X-Gm-Features: AUfX_mxzWi_Wthb-pNXZ8TjpGZk3aPq1khixv9Huq8MKqLH40NivNbMHuRW9ulU
Message-ID: <CAFLszTg2noOJxo-_i9kzGhUXTxooHx-Z8ZyaQXLEakEmOvf=Ug@mail.gmail.com>
Subject: Re: [PATCH 02/11] dm: core: Drop redundant CONFIG_TPL_BUILD check
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> dm: core: Drop redundant CONFIG_TPL_BUILD check
>
> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> drivers/core/ofnode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
