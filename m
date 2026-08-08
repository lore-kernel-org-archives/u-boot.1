Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D60C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE98780E3E;
	Sat,  8 Aug 2026 13:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sL9TwmvIP0t0; Sat,  8 Aug 2026 13:51:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07DAD80E32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786197074;
	bh=LvWhrhUUQKrbnof3QU5LzOVpS0ZP8m0joKrUFszmo4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eH9WRK3gFXbV4e4wTOq7llRRIaRRKPhAeyDS/k7wCiRKa/OCsOEdGXfIdY/r4dZC+
	 VpTiPmxDNUMjjeWcR1+w6D01X3SXJc10NYhYdo1pIGmeV566PkUyZq+nZ570dmxYwZ
	 vSqqFcQpjArHOBmNKHSUkU6SVQxuSI32hF90P+1dS7seXfSpsGXhIRePg8/gJh6pUN
	 aBxy3R1DXFona4i4vQejHqzBGKuDpObquVL/STa/69Ob2+YliO9tzgqSHArtIsOllA
	 vCjXjR25l8m8W2NoJuro2TOzDMi8b9cuOwt1pkmbEQgECQSI59Bsv7LNHvaA5tytnR
	 7rlCBVB9PLCOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07DAD80E32;
	Sat,  8 Aug 2026 13:51:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D892296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 342E4400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAwMWpzMiPIi for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:51:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 344CA4004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 344CA4004B
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 344CA4004B
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:51:10 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so451174a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786197069; cv=none;
 d=google.com; s=arc-20260327;
 b=GhrvBbfokRWKxrg+nsJUeCQcDnjRMOEoVSIG4lukFWGe9xGKfpogRIjkFKtr+lqT4e
 RGdVPLMq2yxvKLXDSrHIROQ5bK4FX+g3svqET23SHPozUbVB3ILaz0DR64OBjltOqsfp
 VpUUTh7exRw20EHi1txJKuPARGiQZmz77LRBnLOURLV2gwohL1hiu83q1K1r7HwIkakW
 ggmnES6JNHhkYHPJuSYFa3fJcMkSwfSoQSjG1Vf5hsT9Rbst63dfoBvjDGfXO//fL2Li
 CVfg5I0ktAeVURJ5dX00lHszbxqTiP6thcu2XbbkKSuFwr1GrlT9BvjCuZtY/RWjLOLX
 ABsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LvWhrhUUQKrbnof3QU5LzOVpS0ZP8m0joKrUFszmo4U=;
 fh=2RNv1jI7huSP/SAKXni4muZcjTOV8EN5Wo7MSL9oVJc=;
 b=Xj5mUM6MtBcDfUYzhHoLZCBCqFXuyxvkVhEaqf5vyu82+0rzBu1t7gQqn4vUYwNBBl
 u8hvYOUrcEsI7S8udXR2gcB3OXS61NnCsawDDS1iAUGgRTIpPVNeh+C2izdXwOWrHpmv
 FS2PYXiKtrNd3hiQIFrYuRWboOhcdRnsciUQuvMDf/mcqvYnoZx8z8lPS1UcJguMggEH
 IXIS49EK6QJL4VXA2w/q4xJdsdIeYAB4xEwXIp3c/ilvIV6brRxCgdlB6KJmlAuaXEhP
 JDTEopKBh5M0wgIc8qJ290JLwTEza+jVhdmgGedU0SMPR/Yd1rYYHU7PRuN5aNvUJV1v
 /Y2g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786197069; x=1786801869;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LvWhrhUUQKrbnof3QU5LzOVpS0ZP8m0joKrUFszmo4U=;
 b=pjd21KLn7/rzWos8o/saPmqidxB3cJX4kB0YoNVn9w2qGMfC2KAzbhvKDw/BDpt3Pm
 o87OUn92TSYkqbLNm+RwWMyPP7IjrEIlF5i4X8hdGX94ot4ib8sAwjQwMvGa5pGSAtqD
 hFuIstbYLyngy/3GVHxU81ZHH1WEiRvW5HYvOsPdLwu0GpMQJI6aT3UvLkG4XFCxi911
 oWlMaaGKvkH7LIdpYbNSErF+KdduwWwb5wTLezZ+qtGuYYt1VftwCFmt8zKuIURIWLXM
 vEsK+ReNzqOR1cr8Ij1vzQ8uqfvO+UwF2FRnDNdChCFGtaK8XYkePsrqZ8dk9tUV7gqw
 dZcQ==
X-Gm-Message-State: AOJu0YxKuVqyrqGcT055ISkEFbTxU54TUDimHE+InET+M19UG0H8pSu3
 SfLKwZ3wTjXyybzp0dYN0EefAuFhKO5chCHfyvzATRakjnaJ3C70FbIUKdmBS6RVDBzRFSBuNBg
 yUM5gMwt5sQlDtbWYyaUnVdQS8U5hKOSYfmGrKUkq
X-Gm-Gg: AR+sD13PJbeTpX1wh7u/w06ojMHVRfSED3UUXPoLZLeB4gg/jIoc/CXIT9oWrXKztZ9
 +voJSW6Ci6MAocTKzU1p5Y2hiIyKMA92HJ4tJli9k2k+QjN0SQmtnJvlNK9maJSIDJrDm7ecy1f
 P+I6XfETarEh+YmFfLV0r3C7nCoFGmEZb90VRG8GbSjUKcGO0FswpbmMbRrE2FmEKgqO3WrdCkZ
 IaqC4HN04cfrF3967YQXhQGs7FDPX9kgRU1Z5RxV+xb8xGMf7bD4lQ4rblW+8WJINLUXFkoOIlz
 zqE9IDMspuasFn8K9BW6K6GWOWKQtz0JCM1tcfy7qm4=
X-Received: by 2002:a05:6402:320e:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a1f95b8f45mr1721445a12.1.1786197068954; Sat, 08 Aug 2026
 06:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
In-Reply-To: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 07:50:54 -0600
X-Gm-Features: AUfX_mySoWxihBNQQu7g28xWYN1db1Hl3wTo06DhqZheyAI6UDk4uUqlqMPC80c
Message-ID: <CAFLszTjNxsmzvmAYqDo+jmrvza=PPG3-mKbi2i=Jr8N6ODo7YA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fit: Harden handling of external-data properties
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>,
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786197069; x=1786801869;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LvWhrhUUQKrbnof3QU5LzOVpS0ZP8m0joKrUFszmo4U=;
 b=lrZ13ZcHLadGnMquvjkmGhvS0Gppjb+BCKGYBibZ+4MnQguWoVoSBM3LNSC/J18E6F
 GnUoCluQZuKxS0UyopHu08/IzDaBUqBEApkZ15+/LTGoTeOMvG3seiqhZonSlTWkz9xR
 dwLwN7k8O91g4gAd6swn+ZrjdsO+w6DSJBL4s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lrZ13ZcH
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anton,

On Thu, 6 Aug 2026 at 15:29, Anton Ivanov <anton@binarly.io> wrote:
>
> The data-offset, data-position and data-size FIT properties are 32-bit
> unsigned values, but were read through signed int. Also, they are
> excluded from the configuration signature, so they are attacker
> controlled.
>
> Patch 1 switches the accessors and their callers to u32, removing
> the ad-hoc handling of "negative" values in U-Boot proper. This
> transition was discussed and agreed on in [1].
>
> The SPL loader has its own copy of this logic with the same problems
> and fewer checks. Patch 2 factors out a test helper, patch 3 makes the
> SPL offset/size arithmetic overflow-safe, and patch 4 adds the
> addressable-range and FIT_SIGNATURE_MAX_SIZE bounds check that U-Boot
> proper already performs in fit_image_get_data().
>
> Patches 3 and 4 build on each other and on patch 1, so they are not
> intended to be cherry-picked individually.
>
> [1] https://lore.kernel.org/u-boot/CAPWaX55XWFLcMGRuaUuXXn__MX_UG4J8QTd6rvXZmJ4WSOCy9w@mail.gmail.com/
>
> ---
> Changes in v2:
> - Patch 1: keep the 0xffffffff data-position and data-size test cases
>   instead of dropping them; they are renamed and repointed at the
>   "FIT external data is out of bounds" message they now hit.
> - Patches 3 and 4: no code changes, added SPL code-size figures
> - Link to v1: https://lore.kernel.org/all/20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io/
>
> Patches 1, 2 and 4 carry Reviewed-by: Simon Glass.

I don't see those tags?

>
> ---
> Anton Ivanov (4):
>       image-fit: Use unsigned types for external data properties
>       test: spl: Factor out external-data FIT property checks
>       spl: fit: Harden external-data offset and size arithmetic
>       spl: fit: Bound external data like U-Boot proper
>
>  boot/image-fit.c               |  29 ++++------
>  common/spl/spl_fit.c           | 122 +++++++++++++++++++++++++--------------
>  common/splash_source.c         |   2 +-
>  drivers/fpga/socfpga_arria10.c |   3 +-
>  include/image.h                |   6 +-
>  test/image/spl_load.c          | 128 +++++++++++++++++++++++++++++++++++------
>  test/py/tests/test_vboot.py    |  10 ++--
>  7 files changed, 210 insertions(+), 90 deletions(-)
> ---
> base-commit: 94b349bd902d9e38e1846c157fadd9054c34680a
> change-id: 20260730-b4-fit-ext-data-hardening-1734a9203753
>
> Best regards,
> --
> Anton Ivanov <anton@binarly.io>
>

Regards,
SImon
