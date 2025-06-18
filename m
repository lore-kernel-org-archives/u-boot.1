Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C9C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 18:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281BF82B18;
	Wed, 18 Jun 2025 20:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yL9h/44T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9407682BCD; Wed, 18 Jun 2025 20:30:35 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 790BD82B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 20:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-710ffc7a051so66543237b3.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750271432; x=1750876232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=omw2e8xAtLP93PrFOQeCXO0KXV1aCDR/w5my6Sm0iZ4=;
 b=yL9h/44TXzEkQeDTZ1csGWvcu7YRWg2LmZP/rzTnaOl0AGuVfAGwXM3bIfl+LBBuuK
 /dsw38HHOWPpx1YOTiy0VCQMAcIWgryJIp6UYACtLxMkOy5Dxn/mRnFsdd0x08v0O0s5
 +sbMZsHwG4/l4wPrmAMQ3qq0ZFT1FsvAkW2dcxCM8YRgQK1hULQ0pwolCjCSL+JTOadH
 FqMPYzWDJ6uWn25ks6dMUidyBdf13bfDc6qqa4gVTj87N3prSjem2gflYagHG+tZ/mWL
 i9Flm43w+6a5qyH67OPK5ShKsH3x1dAeQCC/PgCzo5BeJXFeLOcPxqOUW9qdLDUTw9N1
 IHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750271432; x=1750876232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=omw2e8xAtLP93PrFOQeCXO0KXV1aCDR/w5my6Sm0iZ4=;
 b=Gc3xUrE4iM3m6Y2Str4LBBp/HSPZYFujX2x2PsZkev/WirrmtpacjgDaeYAtXeQQXw
 dO6FiE5KoXjF8esg8Rf0WyyDaB3HE9H26ypY/EcCgGI8EtbYwjG++TOcyBfA08zW/Wq4
 ld/yR4GtndY82r1WtFT2m4GooVAURp5RR8gKgInWq/qZmmvq/mn12U4HH5e+7Feh7Cf3
 FlZBFRrVm9H4Tt2eDakR5+Z413oFtVydjAld2K00VFtqOgprQMv96I3Ol1A9RkKXEN0a
 6/iEjHVM7SoJKHGSTo4FVuMLMezDkg2jglPSQ8YaYK8oICJYrX9Aj1oo13z/pV6drU7z
 dHOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRCZsstIwCAiOyHdYA6PyTKCDlG8euzgLhRBo5jemwl6Eo/1oIcfdTvWHzh5IbC4jKzQEKLms=@lists.denx.de
X-Gm-Message-State: AOJu0YxmWE1xHKI46+aZbbg3b5axK0LdBRYLREZUlhKUszYBLim7OtC5
 FpiOZHBZxEPmSm9f1QqwT9rPwyDQlwo73/6IINBJLn4stm2OV1RClbQMhoQqi02Ep+QOOidg25e
 wMP0aPYibtkCg98/R5FLFYRklBDHFdAThUwQEUXdwIyxhrbGRCJUA
X-Gm-Gg: ASbGnctu9oOljacJ4bEtCJ/yPdOh/XGSGK84YHnfkFB5ogKu1FSslwcP9ItX2f2Dz/k
 15g/XTHLqxJRSLG0/p5mdkxJQgGQRpOzXlDxgsEzJChqXjU7p6LCcHWQmFxO39wxxulLZ/3nz1i
 eChUQPRHA2mdrkq+8/GrESAFJL20TawR0PmsG0OZhpi87y
X-Google-Smtp-Source: AGHT+IH6domDGSbFoP4ISr2Qp1avyQobC+dfnhbphq0XvJKqRI59TDhAAn88yPKR3QIXRJR0y9/Ei2OzQXdmgOuR/xk=
X-Received: by 2002:a05:690c:b06:b0:705:750e:37b7 with SMTP id
 00721157ae682-7117546315fmr221031587b3.5.1750271432140; Wed, 18 Jun 2025
 11:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250618080056.1973311-1-javierm@redhat.com>
 <20250618145016.GF6521@bill-the-cat>
 <875xgt3x2y.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <875xgt3x2y.fsf@minerva.mail-host-address-is-not-set>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Jun 2025 21:29:56 +0300
X-Gm-Features: AX0GCFsKKyoZfaMvFhOV8LFV1GDmB7lK5yGIySFB5jHmCTUSvPPDWoncmMEIxt0
Message-ID: <CAC_iWjKnLXYUEiJ-B_vxjCaoMpcPazT4HijAsdtA+PCKfCQXKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, mripard@redhat.com, 
 alexl@redhat.com, mkorpers@redhat.com, eballetb@redhat.com, 
 mskrivan@redhat.com, Alexey Romanov <avromanov@salutedevices.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
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

Javier I reviewed the patches but I probably missed something.

I am getting a compilation error with the selftests applied.
#include <part_efi.h> seems to be missing.

Thanks

/Ilias

On Wed, 18 Jun 2025 at 18:10, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Tom Rini <trini@konsulko.com> writes:
>
> Hello Tom,
>
> > On Wed, Jun 18, 2025 at 10:00:34AM +0200, Javier Martinez Canillas wrote:
>
> [...]
>
> >>     05: efi_selftest: Add basic partition info check to block io test
> >>        aarch64: (for 1/1 boards) all +563.0 rodata +179.0 text +384.0
> >>                 qemu_arm64_lwip: all +563 rodata +179 text +384
> >>                    u-boot: add: 1/0, grow: 1/0 bytes: 384/0 (384)
> >>                      function                                   old     new   delta
> >>                      execute                                  36428   36796    +368
> >>                      partition_info_guid                          -      16     +16
> >>     (no errors to report)
> >
> > Thanks for digging at the size part here. I don't think that amount of
> > growth justifies a new Kconfig option.
> >
>
> On the contrary, thanks for pointing me to your script. It's really awesome.
>
> > --
> > Tom
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>
