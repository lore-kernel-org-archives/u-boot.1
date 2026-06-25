Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D220CCDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6F0848F0;
	Thu, 25 Jun 2026 10:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YkCxJ4i2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE358460E; Thu, 25 Jun 2026 10:52:17 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD53848F0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bec450b950dso414742666b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377535; cv=none;
 d=google.com; s=arc-20260327;
 b=qlKZ8L5/WxELvyrTfvqsCj2Kgo7yizlW2HP47GqqhW6oVU0X+Qo+Z5Sl7h9wqQ1+E/
 VPKpXZtze4dSOv8lw93q3buGnasAA1uPodrbzASAQhuYVePpwWm8s3WYDV2k6pn2VyZt
 P5pKu41kD1npHUMAlyufHh/QBAT5SXgyR0pUCePb5xVLd9zSz+x4wtcMbG7+et1gSuCm
 DM2uf+CX19+od3MbgmdVIGJielmk6qwzdH2Ch1hN6v788GxxRbGCg96gDYODch0WHRwT
 k/KS67m2Eq1MX4YyCLxDax1r7D4UO6HBvBgS6hyp5PqExDcaSL8VuPnoMZwDjie4ieup
 JyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p7//ewUmhR97k/sawBEQAGScv+55lXirxwaO7u+EjU4=;
 fh=D8AFZW4V+z4heQTZ6V+/V/FlKWjpLxanOXRhMk5yVW0=;
 b=Rb3vus7yAGlmppD/yINbs613kK1ohzx6QCRI/H/gE7/6iiOXZTCdIjr3mZaiGoEt5K
 iW1Zua6XjxW18xvlVZWLAJc46fdcpM1uRRVVMHi16t26RCe+m0CdgbvYnYKs+PEknCvW
 UZXINhBDb965IOoQI7Kal+7Lx/HvuXBO85aDxP915lRpVTfvKyD2ud8/U26w8kKnRgan
 BJT8hCPdkyXNjVvdNLhr+WIR4FAnLrqd5y6nPzj9DqthuPjFG+zJcA+uro6HAsodq3kp
 gyKwjU+/WO4Zp0e/pFPNB1PGEFQIXv3sgWFgRmUsVtrHzYdAkoPAciD0z4rBDha8wmou
 pmOA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377535; x=1782982335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p7//ewUmhR97k/sawBEQAGScv+55lXirxwaO7u+EjU4=;
 b=YkCxJ4i21R9JLT1Rr2gA04q8qnwT4o32aVhoZYjnFkAOlrX+GTEAGOyT/ko7iKF267
 JFVl4C4mN5S+q2M+fw2ZJY2A8JnxIJYg27j3sFG4otUbmbEqqdX8fALjVrUTzz05gdSV
 rsFpEcsZtbgUFZlGps6OgNtY5rO/uJffhGghI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377535; x=1782982335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7//ewUmhR97k/sawBEQAGScv+55lXirxwaO7u+EjU4=;
 b=UlaQdRWyQYoyVS2oT0oXKKk4t6obJ9DONyF+KndrxjAW5R4kkNK6qCoV71wmI4iEGD
 N1TK532CAUzZCMtExWVA4kHXxCiezZ9MonZ3Jf6yiwTZ2nOFfHMxsF4xBwcorhb5f9ug
 KRhe0ZUosoLLPpp5NL+CTy0iTabDjxs1yoJ0u7jubMsuZ5N9YxF2eJRNNvx0/Ceo8+iX
 B7MPKZWL4gsMm2kvHKxBZ99Fx2Ad7itSupcAA7v8gZKd+7TI2Feo2d3/0T8VwcD3Onx1
 ROqQGShOhodDbD9nA3I58UokBWUKfoS/859dZOZNN9jhpPalXKyP2M84AZddAZeGojU5
 0qoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Romv7S0+MiVdo3S/dm6JtgYPL0LIyYCIeU8cgYuhzxFLpxsIqpB/o8EGHsf/dcM004csfdcH5c=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4I9jWrdpNOgpKrNoobgAlELMPRc9aaPgz0rrqlN5ySCyJ8cU+
 rtPYkFoNJTZ1fLdICQoGYhKpUEyteyYQCKiXL710kWs2/ZsAZ8svmvQKyOthTWUwVWbieA/GwvH
 uhApMpX7P1kZ3BBXwveIe4J0vmBn5X16lZcAxpT2c
X-Gm-Gg: AfdE7cnJWyqmx99GPIepqWG8IG+q7GuqTLujtGVR4Kkab3rPgqXC1SwhDA+W3aTXSRK
 RdrEQs2bcMvFhu3eRRbg6UJG6zpCPDfu52amK5hps7qdRGirpgzZit1dJdVJL5inERDNfstILjV
 NfG03AjB8l6BFRY+01Qjiqx1H8+RWfcVxTb1OYQ9Qe1DZcy8br4I7DLiLyaxm1IRhpA0NjyhjCI
 KhFvGJOmE2QXyzAnOPtelF+PG3xNQ7xGH/NQywzJFgbP6Ys7G18M7/MezqcHyPbhObmtwoPfg==
X-Received: by 2002:a17:907:7201:b0:c10:18d5:b659 with SMTP id
 a640c23a62f3a-c1205d991c5mr111123166b.2.1782377535214; Thu, 25 Jun 2026
 01:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:52:00 +0100
X-Gm-Features: AVVi8CfuEvvn_vfm6Q5_mgmnlbNZ13A43AQOAFIeH8rgrqQ44iAcho84PG0XkII
Message-ID: <CAFLszTiu0HSZ4JJ7ggMMAk4oe0-h=Xq-Wnw=hqwGr80wBdrGXQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] efi_selftest: add ACPI configuration table test
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_selftest: add ACPI configuration table test
>
> The new unit test checks if ACPI tables are available.
>
> If yes, it checks if the RSDP correctly points to the RSDT or XSDT.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_selftest/Makefile            |   1 +
>  lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
> @@ -0,0 +1,138 @@
> +     if (!checksum_ok(rsdp, 20)) {
> +             efi_st_error("Invalid RSDP checksum\n");
> +             return EFI_ST_FAILURE;
> +     }

Please avoid the magic 20 - how about offsetof(struct acpi_rsdp,
length) or a named constant?

Regards,
Simon
