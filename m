Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5195CCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E25B84A79;
	Thu,  7 May 2026 17:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fucz4Izm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D6D84B44; Thu,  7 May 2026 17:32:12 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5669E84B49
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bc356898256so171593366b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167927; cv=none;
 d=google.com; s=arc-20240605;
 b=WKyDVHkLmFcZ0zMl3gufE+UCvu6Ah5URAnYuJnMx+oWsGz5ZYsK8HIpEY7QIrU/WKe
 OzB9Rz3pPmlBrHDVEhlXHKDK8RGi/6yToBEed92/gSmztIoLOorfg1/341Ll5SZcWBoz
 L0G92HBRmydRy4FQVldw8eFTngOK20bMUeLjCalm/qTUv+U7Me680htHV1IvrtbsqEi1
 N02X12vdeiqfZQg8lj+cVNsI8SB7h4FCGteJqOVPPBxZVva40+LdnKhXewkWOUXHCDC5
 L1VEXcccYKs07vjg1atEP1+crofqZWKVPEbmqHFIIgGkZZTRdArOu2G+r2nY2DQt07Lv
 a67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y8tFLl3KLKZIsW/JbMMLZ0B09j3Ttxvn4RsxwKyKXOo=;
 fh=BTFB4szhANUdeKdGhUtFNOkjp2T4RwfYw5Yk7MO0OCE=;
 b=Kz41tzaIpoJIeNXK+NeCH/uBjtfn0vZUo0PsjD77wf6qirBFnOBp416rG1lfwhgqaK
 1dgosdzabr/n78TynPNT9dzj5zkMnw2rw1NW8PFWynDJJ2F9Jd9BonlFXNqU28qmKemj
 vlQw40T0nXpde5/UX5Fqd9U5Vg9nkqx1a0FnDq6EfhlGrYvrEyWwFKWBFKCpFDjvre/P
 xhaAdfd67k/fAAYdjS4xUiubZj6Ovhd+Xwe85dWpyg/a/aVE1GqSu+iQN3mZNJgrN90F
 81WXxEQoYv0zN6HTgn0sMgXKJY51g3uP7reDcO1SM2ZcR4/HUsI8V19RDmXQmgY5x8TR
 R0tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167927; x=1778772727; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8tFLl3KLKZIsW/JbMMLZ0B09j3Ttxvn4RsxwKyKXOo=;
 b=fucz4IzmqHXXGlPSgejihM0ToJ9VeLMMkMjLM5WD1YmvUT7CNP3HMM6HO/AE+P6x2n
 qPQLiVA2UNBrfN9e2zSOzhqDZ0ITkLbc4fEFh6rcqm6z4hYS6mpp4oAGZQm29P4lN0KV
 1d6nbmzAnnkdmkFRCLtWINDBFMYGw6CFT+ZrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167927; x=1778772727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8tFLl3KLKZIsW/JbMMLZ0B09j3Ttxvn4RsxwKyKXOo=;
 b=DryDdyTMLB1yrsEbdW1BKL0T+RVRZMptCnehoVuU7dDJUGx5DB5awFcQ4P5gYgSFXK
 TKb9IGFmlTfPLg8X235b6ue+rdD/lEIvazdHfd1/eoXJ2bJCXSdg2hOM3DTcsjI2H1ee
 FyG6+gSFSUgBqNkVmT6DHDdNETe3isaIjyRBneyZ3pRt1LUpXtStGHP3UqsOtT85w/gn
 9l2ArFJ0DMKnKmx0e0YNdC6bsAeqBWiewUwRmXA5ggletT/feFaPyofx75c3pEbd/on+
 4Rlk9D05tWuORBpyTY0Xm60ZlebZDPyIAuozJJatSPtsu5ATkIWPIbiDZgwhAkFAqZwz
 vSSQ==
X-Gm-Message-State: AOJu0YwAJ0UmEPvYk0ThE7S66cTmITxvCKCqlUTpJP4rpx9EWEK5WpW/
 hX8Kce3oR40ExQVUBTiIAGydCoMUsRvdtOksFlv4GMOwJrBe1xUlt+Lj5vDNZPDkGhMm+lzVwEl
 9hsQv92v3i8hqk0dB1ghgbQK4zlg3/e2/e4CLyGoi
X-Gm-Gg: AeBDiesK/1dtdG+FIJTZ93swiAfvJYxG/zmd8Drj7Kt/gQTU//p357/xuTpsLn7BysG
 hYOsDLaqNh05PWup0CBThfR3wCI60vqNOGPy1NcoHhNoTi8OmTwyG5HQ9UysDbT+i8VGzj1rg6y
 si5BF4iof5upEB4lt06iDh/5fozJOz9aNa882XwUC/MhIDHlXsu+JaAiVM5CMzF8h7tQ1/vBZKK
 y6BZ2qF6XgHE8OKBGCFJM5/65V8Q5mjL2TeZcEfU9PYd89KwCb0/BD07ChuVW8LrcdQjWNTG9qC
 VyBrijBhgFVvJN2q
X-Received: by 2002:a17:907:709:b0:bb7:beb9:b6d5 with SMTP id
 a640c23a62f3a-bc56da16349mr561732466b.39.1778167926370; Thu, 07 May 2026
 08:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <CAFLszThcmzcAewzvjN_4kY4FR6rGknHmWUF4GNha__4h2uCqAA@mail.gmail.com>
 <95621f94-8398-4f60-912a-1c23fe79bca9@siemens.com>
In-Reply-To: <95621f94-8398-4f60-912a-1c23fe79bca9@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:31:51 -0600
X-Gm-Features: AVHnY4ImozpXbe5wAHvVOns5bgrtGqH1qudlqjt9_nkPN9Wc7BiCeR8Om8oo5_I
Message-ID: <CAFLszThMMfmHC75uqNWUsb51eTzr37Zau10Tr7ktYrD99reY_w@mail.gmail.com>
Subject: Re: [v2,0/4] Improve FIT signature handling
To: Ludwig Nussel <ludwig.nussel@siemens.com>
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

Hi Ludwig,

On Tue, 5 May 2026 at 06:39, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/4/26 14:27, Simon Glass wrote:
> > Hi Ludwig,
> >
> > On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >
> >> (optionally) enforce signatures so we can't accidentally boot
> >> unsigned fit images.
> >
> > Thanks for tackling this - fail-open signature verification has bitten
> > people before, so making it opt-out is a good direction! A few
> > series-level points:
> >
> > test/py/tests/test_vboot.py exercises FIT signing end-to-end; please
> > extend it to cover FIT_SIGNATURE_REQUIRED in both the success and
> > fail-closed paths (no keys in the control DT, unsigned config).
> > fit_all_configurations_verify() added in patch 4 should also get a
> > test, ideally driven through iminfo so the command path is covered
> > too. I wonder if we should enable the option for just one of sandbox /
> > sandbox_flattree?
>
>
> Thanks for the review!
> I haven't touched tests at all so far, might take me a while to get into.

OK, let me know if you need help.

You might find this WIP tool helpful for running C and Python tests:
https://github.com/sjg20/uman

Regards,
Simon
