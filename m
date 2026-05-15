Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72538CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CB8846CF;
	Fri, 15 May 2026 20:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NgNqniwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD7684851; Fri, 15 May 2026 20:31:13 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00D5846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bcc2b199c17so7216866b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869871; cv=none;
 d=google.com; s=arc-20240605;
 b=ShfJx76+InjpXwLeYIYNXhJxwC1/anCu2FWTTViw+fyblpwnATXJCcMAaZsYiJGmMx
 Ts9rTM6uuOxs2BHWEbsuZE+Ur0dE/G0GgStrxuI3k/Dg+ZVN81CHkAZNlDCS+pIXNsB5
 98DXKyr2ekN6Hv7SFTlsZfHvFgJVYuoVD7GwLzi4XWMncGAVAfhJthqmlgKdqrgsgaG9
 iAok5zE1lBLnwh52ujvvFwh2lhFYcJGyvBx4rlgxIzukpVaAr9kE4/lD3WIypgreXW4C
 /7EnRYYOtt207eRmeplBCq7hNEHyQUWqwoVvyOkr64tK8+f6wMHI/Lr9YS/8vkbbX4lG
 Onrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PY26JTe2PiajV/WdVaj/auI27E8bqeXmYRKZ6bBhCeg=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=RDbz3WVNANt/dcaW+USdAkA3e0Ia9+ZNqILTXquRJOkoEjSa16qq2lwos3rsTpmSe/
 Q9iXyECiU77ENPKCuyLesodShGRyRcraGaoJnQ1Zfz//aM2Rh+1bLUu79qRF2AC3C2Ky
 sEmV0bXs4CqfQ87JWP8XF7hwatJP1COLasMNrBLWJB1elv9P3/HSRV3Zdg4obL++aG//
 MAGxCX7IfNnpiaPDCLP6zS96Yi8Hq2OQINQ/lX3aadMUUM/RQLSavVDOK0zhhLqB5kqc
 D6tJZV6YmBaSWqvB2Nom//y9n7P+uLkpP+P9IOIwDveSrEbBui21hUiky5qgUrFo9NRR
 5Nww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869871; x=1779474671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PY26JTe2PiajV/WdVaj/auI27E8bqeXmYRKZ6bBhCeg=;
 b=NgNqniwnwy75G9ncoEjAzH0Ert96HiS0XZslo1s2YNSyfCwP7RwJ9jgbIZR2GGcl3A
 Pz1HKwEoqyZsaVHjZuRiVKC2kpNpJbbe7jZjoGuo6L9E2QdlqZ3KBDvdjvYCP5uJNRbF
 m1uUQPxdkQWVy220t7RubQX+QI8TbrW/TybEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869871; x=1779474671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PY26JTe2PiajV/WdVaj/auI27E8bqeXmYRKZ6bBhCeg=;
 b=eN4+N0uGDTKbIBSZ1ijVmIGy/LjaKFjL5eE9fBoP0zbk4ieh6mJ+Gk2O7/yu7X1QyK
 YmAWYcE+/eIAbjBWlIYTNEtpbFuZoFiFCv5QMx0ZGCIBDF35gtHwmMkr24Wpk43Eirn9
 +GqwpoFBBduAv2rkGgiIdfcoYvWN7A/FuW6MeMRLdSHpzbmqE+0k4AY4cl/WRVzg7qgy
 sQbpkgPrVeCfKLORa+tY5h38DwyiLcEpHEXYrfltAcskoTJRd2FKWofvoCK0I0C+TyGX
 locl1kjA8Q/k8lZEHX+KKPLRcKqOB5Ox3R6Uo91hG5Y1TLUVMb+nkdRa1OqvJ1m16v7L
 PbPw==
X-Gm-Message-State: AOJu0Yy3H36vLDrTRZuVOATuC1MAX/9+B9V61MS7WWP3Wem1jh1HF/HK
 stVJ30+rEf/cJQa4z4S9srBJkzdHjtT2pWyZ+JiudfSAj/tc5rqaa3Q6bu7tztdRzsbY25iPsGW
 ETPlWrSJ5k6Apr5iAxSy+nb6u6j48R2JEgvgFUNgd
X-Gm-Gg: Acq92OFUB5ugbQVgsFgn5WkmvPitih3bBbbTi70jUTiLLN7/o4kGDZDyZgK2RWyRICU
 f2cf3tRju5gHzG1gQ2OvlsFhaGvW3BadxxOUlhSxP1d4qIq5V6DKg6toy5rgcnokJUurN77WaUe
 6nZpoE6djwYbnbET2tV2WTscEi+tZcPqbQBVYp9RNhrmid4gXhE2+luhmEOZBXoK8zDxl/rfCUJ
 4Lhy86Lv5yjhsKDtFwBGcoYnbO463GPkJpzrsgKiqn5mTCk7pxGhsIy82Nwi7UfrrqSBKUFdtIR
 A0xUoA==
X-Received: by 2002:a17:907:9802:b0:bd5:2859:ed0a with SMTP id
 a640c23a62f3a-bd52859ed55mr157417866b.42.1778869869511; Fri, 15 May 2026
 11:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-12-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-12-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:30:55 -0600
X-Gm-Features: AVHnY4KAAb1s5Q5FULwgAZh0ghzJ2XOicoY7tZJEaQ-VdqcChIjwPyHn6fvl-LE
Message-ID: <CAFLszTgE_rnVMmjru1GeVb=4rGcQ8kdVS0JWmXT5Ep=sW4ZdUg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] doc: bootefi: note two-phase runtime variables
 selftest
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

Hi Harsimran,

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> doc: bootefi: note two-phase runtime variables selftest
>
> The bootefi documentation did not describe how to run the
> runtime-variable selftest, so users had no guidance on its reboot
> requirements or on which flow applies to their configuration.
>
> Document the runtime-variable selftest flow in bootefi.rst. Describe
> the non-volatile path, note the single-run
> CONFIG_EFI_RT_VOLATILE_STORE=y case, and show how to select the
> runtime-variable selftest with efi_selftest.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> doc/usage/cmd/bootefi.rst | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> @@ -160,6 +160,33 @@ environment variable to match one of the listed identifiers
>  Some of the tests execute the ExitBootServices() UEFI boot service and will not
>  return to the command line but require a board reset.

>
> +When CONFIG_EFI_RT_VOLATILE_STORE is enabled, the test
> +*variables at runtime* completes in a single run and does not require
> +a reboot.

This contradicts the sentence above it. All three tests live in the
EFI_SETUP_BEFORE_BOOTTIME_EXIT phase, so the framework calls
efi_st_exit_boot_services() before executing them and a board reset is
still required to get back to the prompt. What I suspect you mean is
that the volatile path does not need an intermediate reboot between
setup and verify - please reword, e.g. "completes in a single run and
does not require an intermediate reboot to carry state across runs (a
board reset is still needed afterwards, as for any test that calls
ExitBootServices())".

> diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> @@ -160,6 +160,33 @@ environment variable to match one of the listed identifiers
> +When CONFIG_EFI_RT_VOLATILE_STORE is not enabled, the runtime-variable
> +flow is split into *variables at runtime setup* and
> +*variables at runtime verify*. Run the setup test once to create the
> +runtime-accessible variable in non-volatile storage, reboot, then run
> +the verify test to validate, append, and delete that variable.

Worth noting that both halves are on_request tests, so they will not
be picked up by 'bootefi selftest' without naming them explicitly. A
single sentence ("Both phases are on-request tests, so they only run
when selected by efi_selftest.") would make this self-contained.

Regards,
Simon
