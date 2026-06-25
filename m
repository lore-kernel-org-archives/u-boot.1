Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F776CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4838496E;
	Thu, 25 Jun 2026 16:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bIYANjFd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B009584962; Thu, 25 Jun 2026 16:38:56 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9B484962
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bec450b950dso542780966b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 07:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782398334; cv=none;
 d=google.com; s=arc-20260327;
 b=FCRNJC6XDej+sgXnocIZkjMumKVzRdjFyZxJ8bF2aBQfr6CmfCJAzVEZ3fXQR6mpFL
 9PdpByywqw0dQdk/9ML8pL5CWwpURwvBCrB9LWdYttmM59nDmhWhtSvx166pVl4mpQIh
 dwxU962UEItHy5iMQ87xQ+E4YY13XqSP96cBk59IshBcLABsdQjwfhS3rMqgLZ94TU1J
 CJZEYlUJuKp389fAOg0/DtGC6RPVcZVSoW+9AngSWSTTXTCdNaFNSO5yQVMdGC5FHBNB
 ZtrKd+iMCs0L0RQVbWAM2OKNMZbTsN5nd7yeqCLkq74aWEVN4BfLByZ1UTPoLQKdmmZ3
 wXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IkXNrhypC0poiJnLmVPmW0lauPRRzuTVSRAxsWRvUIo=;
 fh=eIExS0ApvoHXzoHaeZPvhgA2i643iHXhJkaiwQaioTU=;
 b=Tsp5cCl6XgvfpvOCedJ01EG9ESE6JFFIkUnkk7fcoDv13A8tLxBZk4jgN7F1DAYzZ6
 NpV1TBu+y8Dea1cKIclC81sHRkYOnjf7tEFEFaWZOisM8U5k7rQCNYghWpHZzEYiuIBM
 eh2qcIWdWt4lrU2E6TdPjsIk1Jca+pN0mfJ1LLAzASEJNTiwFUUw7sJIRNsgGnvtXKed
 VJKIze6coaR++RgPH8DI5Ryk82zkqWblcAc8vZLO52Na8eX2pKckwFrFx958EfHBT/t1
 ex7u2od8uOpl1/hCHlBPtqKermBr3OTQVRKzO3D/eTACPLMzhP6fkI+j0hmnZ3VGWZg/
 uUfw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782398334; x=1783003134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IkXNrhypC0poiJnLmVPmW0lauPRRzuTVSRAxsWRvUIo=;
 b=bIYANjFdzJVizoRThpHWQXP7N53xESq/wFbREeg5Fc3jexRr2KbBT8OAitDZYxG65u
 Liw2/SL0PrvAdo9+bMmq3kCjqAAFeGA/+dna5Xk0dSgKSWBKhKYMU5gT8xW77PYEQuR6
 a4f63WnLk0KtRrj3BhiPMqvfrkOLIVXzVuNWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398334; x=1783003134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkXNrhypC0poiJnLmVPmW0lauPRRzuTVSRAxsWRvUIo=;
 b=E1Z3uEyuifbJzoih0aWuWAMa5IkkfIhzK5v6Lh+JBYsIkxLgWd6h5TIGGCltW3+1aM
 PIaCJMT75NTpdPu8CN+45pyt8d+EBZRfDAWHvWCmSzXdXHsdJP8sRsvHrQM8eP6zTs4/
 tedwTJzejnhgxfnWfumHog+dBoTQrIDnlon8zqzWNaYqUKTA02MuCpTsUMm7h+io0wwz
 FPrlMV3iV17MEZMvmmPJFBIf2QoklatyphGx78C0F5jCP28eeRAV4Ok3tUPXjYbuTXZv
 2ByOuYn2pmpjIP3NtS4AqMPFLcCx2s7sTbU8fN4zCvVfrYDu5v4bmLUgesFClM1VXlco
 WarQ==
X-Gm-Message-State: AOJu0Yyzhwvyw8Z1p5DR7W0SgAZyQ7qvpUDUhp1PcVtmfYlBZTYWHdYb
 yUK3cZTPKCnPC2JV6aVhJ69a/0166c1aXiCa/DmEy3fv8RyhNvxdu9t/w+dWbZadVyN/ylAumVY
 zPqO5O1cFPWXEqSQuNsSyGAx4XPNlGm16q0sxWn+L
X-Gm-Gg: AfdE7clxDLNtKlstuSFBzmUUO+66cDT7AeoZ3S/Rd4GVHLrm3t3MK4wSrRtabTvXbIN
 Y9IKC6EmUdPsk8VW7++7uFZclHtTqOerwq4Qi4d/xuYfE9dvkPQXpoT9Z++zjgShxoB9qTe8smr
 bWIWSO1keJj3900pYwm/Cwh2ZG3+pNCmtOgjv1vrNlbfvrh4JFZhe4llb62+QBpZ7HN05Ajj2Ij
 +VZWbU/tdPYCcaiLnTer34dSGEEFEgBeE4+5NoCtVWF8jBJ+wcVbcBlSW7f8jjADbZBQ1E5jw==
X-Received: by 2002:a17:907:724f:b0:bed:bb08:ab68 with SMTP id
 a640c23a62f3a-c1205f34503mr214040666b.39.1782398333913; Thu, 25 Jun 2026
 07:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-9-jamie.gibbons@microchip.com>
In-Reply-To: <20260625122325.834568-9-jamie.gibbons@microchip.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 15:38:38 +0100
X-Gm-Features: AVVi8CfCtZI_N3X3j4d28hQoy_soL7rpo5QXmb4q9Rr4NRZDSvQ3u3xYe-Nr-WQ
Message-ID: <CAFLszThdbWpLe7dH0OvYh-QYxPDMw=OYipbwAR-k+EfT78Z0kQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] boot: fdt: downgrade KASLR RNG failure to warning
To: jamie.gibbons@microchip.com
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

Hi Jamie,

On 2026-06-25T12:23:17, Jamie Gibbons <jamie.gibbons@microchip.com> wrote:
> boot: fdt: downgrade KASLR RNG failure to warning
>
> During early boot, dm_rng_read() may fail if the underlying RNG
> is temporarily unavailable. This causes KASLR seeding to fail,
> but does not affect boot correctness.
>
> Currently, fdt_kaslrseed() treats this condition as a hard error
> and logs an error message, even though the system continues to
> boot normally.
>
> Downgrade the failure to a warning and continue booting without
> KASLR, making the behaviour explicit without implying a fatal
> error.
>
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
>
> boot/fdt_support.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> @@ -314,9 +314,16 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
>       err = dm_rng_read(dev, &data, sizeof(data));
> -     if (err) {
> -             dev_err(dev, "dm_rng_read failed: %d\n", err);
> -             return err;
> +     if (err < 0) {
> +             /*
> +             * RNG may be unavailable during early boot.
> +             * KASLR is best-effort in this case; warn and continue.
> +             */

The continuation '*' should be aligned with the '*' of '/*':

checkpatch should catch this.

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> @@ -314,9 +314,16 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
> +     } else if (err != sizeof(data)) {
> +             dev_warn(dev, "KASLR seed unavailable (no entropy), continuing without KASLR\n");
> +             return 0;
>       }

Please drop this branch - see comments on patch 1 about the
dm_rng_read() contract.

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> @@ -314,9 +314,16 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
> -     if (err) {
> -             dev_err(dev, "dm_rng_read failed: %d\n", err);
> -             return err;
> +     if (err < 0) {
> +             /*
> +             * RNG may be unavailable during early boot.
> +             * KASLR is best-effort in this case; warn and continue.
> +             */
> +             dev_warn(dev, "KASLR seed unavailable (RNG error %d), continuing without KASLR\n", err);
> +             return 0;

This is a behavioural change for every platform that uses
fdt_kaslrseed(), not just MPFS - the commit message frames it as
MPFS-specific but the effect is global. cmd/kaslrseed.c does 'if
(fdt_kaslrseed(working_fdt, true) < 0)' to decide CMD_RET_FAILURE, so
the user-invoked kaslrseed command will now silently succeed even when
no seed was written. Please mention the cross-platform impact in the
commit message, and consider whether the explicit command should still
propagate the error (e.g. keep the propagation in the caller, or add a
best_effort flag).

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> @@ -314,9 +314,16 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
> +             dev_warn(dev, "KASLR seed unavailable (RNG error %d), continuing without KASLR\n", err);

Just to check - have you considered log_warning() at a lower
verbosity, or only warning once? Repeated boot messages tend to
attract bug reports.

Regards,
Simon
