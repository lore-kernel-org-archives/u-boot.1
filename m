Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C1ECD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 13:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3051846A4;
	Mon, 15 Jun 2026 15:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oSta6l/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C73846A4; Mon, 15 Jun 2026 15:26:37 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB1B84105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 15:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6604176b575so2740054d50.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 06:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529994; cv=none;
 d=google.com; s=arc-20240605;
 b=RdPobZvI1PJpmGXGzraK9hs0SKDqZ8OFlt7QOCIi2VXBOJFwkfyv1x0A9PSWbyAQk1
 w1+h5jSoYtjxBHlc8a/cNPcd8Bg5SgF3icueoC+6Ydah6brpEkn3bWYF1FsBqX4kTVxl
 eOhWarT/mgkSmPfx/qCRtcQNX2YgTZR8QtFsoKcDsFmNNRTFLBYST0kcVc3ZQUQMYZ01
 Pw1IjKxY+XMtr9l4oO6USju0O2tPjp2Zub/fHXvpKDK2//ejwpAkwd/Sfnxl18J2Pu90
 XhEB/lIHaqQulGSC9FiTtn/SlSX4nnX0o1LCjV5SONEXv8YBhMXXFMKXTNRU1crPQIJZ
 urLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qgk04P8sYlioNqzYftPbGHI13J8ePilbk6nJCCLJBbc=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=XpOzI6/8KJI7u3TQHijqPRNAybJgR4yj2zWN7FRXRWDUq3XEk8Y8Z5C+5KPcv9Ln8J
 R3DeoekKifKE1kEwZJLuRAwvXE/l6mQOWnruN+XMrkhcs9wBLef1DC6FCBaNmutPCAjn
 R4DHSNRnOF+GbR7PdCjwq08frUB1KPgdmryk8OZbCMlwvxURTgLNIUYwpKiSPOh3tBs/
 GGyAABojVDOtA1c7fVJILRB8pJi84loDtaD4bdddDxXjHl7QsioX1TTzwZZH80TgeyA3
 qEWELVf0YVhHFxGtxDeCIKPVsLxbUgdQiLChDwtRxwszWTJ0wWdqPsd9PG1mjH/55UwB
 VQ2Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781529994; x=1782134794; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qgk04P8sYlioNqzYftPbGHI13J8ePilbk6nJCCLJBbc=;
 b=oSta6l/PDzy0uBKP56FRUPkkXLNAik4PpYc1XuTKcQXhgwU4b7d1IMojSvd/GCeEdI
 SRFgqTQhBhuOC0woJ50dyKQsNk/ZCALbaFL1DhpX5AQGUhB9PYLJDA5RiAaKF3sMaPK8
 P3KLxFULI+8EhR0vYxDFdUnoxk6Uobp60tdXv9hcFIicg1TFQQ1QQZwXtgP5R4FNNXkz
 0rflvgxbLC5mbTECuVaf5wikJdlBivgoVlR6ShZvqhP7UK9MKIaA+QHq/zxJnDLJVwsU
 WVlGOI40iMaY+EOsPCJ1Ovb0v0TMCUMemYOLFHYPjL6PiaI2Y/lTx5YdRZjL51aNz7BI
 tPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529994; x=1782134794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgk04P8sYlioNqzYftPbGHI13J8ePilbk6nJCCLJBbc=;
 b=MTKsKI9T0NxUKLIyBV+ARNgvdyyzdazwKhj6gKPGgBaZXGUvcXiF1qIZY1IVhSw8jA
 lpA1oSwMB0J2dziI5zpDIdvcH+meYjzUzEKKGIKHwaGJNN75s2KycN8nDHRif8NWAXSq
 bCuXFbYRyK35oF4sOK4jMOgmsc7qE78/0ePac32Khh1ETbDCF/7QoKPpQd/twfvemu1n
 DaHuERL52qcUg9/G29ZSE4YTrIsRuar1f6A+6b+vmwOpZDZedW+OLjx4A3Vei8bRKFZ1
 hm7sobVVYL0M8GjmKd57W4gT67uqax3W3tgamjWJSUzD/67HYyqzL1wN3KYcCC0d5xpu
 hIEw==
X-Gm-Message-State: AOJu0YzXiH1AdC4IFKsGPH0YvXKJVjINABIF0ddJBIMcD9r6sVCenHNP
 wbnBUzRugZY9NG7aqaKDXfJFQ+7GWWG+2FJb5U8P+uj/VZcAw5AXi5O/YirHfdytpnsgTlsikjQ
 YzIab0EUrX8lwrWbva/v2DjDmopstXBAoPPuzxxfINQ==
X-Gm-Gg: Acq92OHZamBEAPx5H3ff//52V2MKPJxgELa0iMvJjpJSjRi8FimOl/f/ICzNGkLPONc
 paOBKZIpzIvuun4IYVUaVsIKPpwKNKjLtjokwI+q3nflVySpyQCxMpbg997zYwnYARk8yu+6qpt
 gtE7pkJBFTr+Feorwv2438NEfeDWoNPOm1Y1IgUH9Fp6QH3CShU2ZQvComgc62cqSfjIeLwuuUz
 ZopO0G1+8lIqOF0eDtpj4+qO+Gn+Sh6YJX6ddMc3zdDiY4FFYfZ9LxehUDd8hB66/PBN4nlAUGz
 NlCWhu/Ifiq4Q9YxHlYxgyxdik7FdCOZxiP0AYAOrbKOJAkAO4HxKdYQ06sHVoHfrhKQv+WcI0y
 MJ0BsWePVkQKZNOK+OpY349Q71jXe+AGOqeBblE703q2xWXSyHbYJRNLeW+aDxTJ8n5rMqBZZ1R
 dhyDVM075W2ORXIq/Vy6W6c4ZqnroBTN7f1BeA6n52lgpTmJtf+tr+21euF8oDGjQW/iM9vnxlf
 5HmljYISWRX4ERm7JS/CuViBgRU0Q7JWJLdwjpR2BefjOyOkL2jecnCYWDV5Pzy5wFd1H6aFx8I
 3xKm/qa7EoDAhwS6xwBsAzckSyeOkOi8rxCu82jNDjYEZFVxyuWDc4aD97YA3Eyuo9qX+MMaGFQ
 psec14A==
X-Received: by 2002:a05:690e:4810:b0:65b:123:1b00 with SMTP id
 956f58d0204a3-66277fca69emr8749965d50.26.1781529993833; Mon, 15 Jun 2026
 06:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
In-Reply-To: <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 15 Jun 2026 16:25:56 +0300
X-Gm-Features: AVVi8CcN1R_DHxb09uQbEoQVjJQl4AuQZbYbBHFVjaIwW1hO8nOLWMZrjEmLeRU
Message-ID: <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 15 Jun 2026 at 16:09, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ludwig,
>
> [...]
>
> > >>>
> > >>> I'd like the eventlog to be initialized before calling this (look below).
> > >>
> > >> What if I removed the log parameter from those tcg2_* functions instead?
> > >> The event log belongs to the tpm device IMO, so should be initialized
> > >> with the device.
> > >
> > > Measured boot EventLogs etc are primarily described by the TCG specs &
> > > EFI and we only have a specification for it there. The DT describes on
> > > how to pass it over to linux with sml-base etc.
> > > However, in the EFI case the Eventlog is allocated as ACPI memory. So
> > > you cannot allocate the EventLog a priori, until you figure out what
> > > method you are using to boot. We also have use cases people using it
> > > only for RNG, due to limited memory, so we can't just allocate it on
> > > the device bringup. And lastly... Some first stage bootloaders do not
> > > initialize the TPM & drivers. What they do is prepare an EventLog and
> > > expect U-Boot to replay it once the TPM is up and running. In that
> > > case we obviously need to preserve what we have instead of starting
> > > from scratch.
> >
> > Ack, we are on the same page here.
> >
> > > My main concern is that I *don't* want the EFI and non-EFI code to
> > > deviate. I have some patches that I am playing around for quite some
> > > time and rebased them last week for this reason [1]. If you think
> > > those help your use case or make your life easier feel free to include
> > > them.
> >
> > Good idea and orthogonal to what I am doing I think. This duplication in
> > EFI stressed my brain too but I can't care about EFI right now :-)
>
> It is, but the deviation in EFI is pretty minimal atm.
> - EFI calls tcg2_log_prepare_buffer instead of tcg2_measurement_init()
> -- That's what my patches fix
> - EFI has it's own version of tcg2_measure_event() -- That's easy to
> fix as well,.
>
> >
> > IIUC you are centering the change around calling
> > tcg2_log_prepare_buffer() in efi_init_event_log(). What do you think
> > about aiming for tcg2_measurement_init() as central starting point
> > instead?
> > That would allow to remove even more duplicated code.
> > It should be sufficient to have tcg2_measurement_init() accept an
> > optional pointer to pre-allocated log buffer memory. Attached patch
> > maybe explains the idea better (just as idea, won't compile).
>
> I agree. In fact I mistyped the functions names on my previous
> email.... I really meant tcg2_measurement_init(). The patchset I
> pointed you to already converts tcg2_log_prepare_buffer() to static.

Replying to myself here, but.. In order to do that you do need the
unification patches. tcg2_measurement_init() will need to allocate the
appropriate buffer depending on EFI or not.

Cheers
/Ilias
>
> >
> > >> I am not sure what the intention of the current api is tbh. The event
> > >> log basically documents when and how PCR registers were extended. We
> > >> have to build that log ourselves as the TPM doesn't do it for us. The
> > >> api weirdly allows to have partial local logs even though there's only
> > >> one set of PCR registers.
> > >
> > > Where?
> >
> > The elog parameters of tcg2_log_prepare_buffer() and tcg2_measure_data()
> > are not related to the dev parameter. So it looks like the intention is
> > to be able to call it on the same tpm but with different event logs.
>
> Ah no. The reason was that the non EFI code was retrofitted way later,
> and it was eiaster to just allocate the buffer on the spot. I always
> had the idea of abstracting this even more in the future
>
> Cheers
> /Ilias
> >
> > cu
> > Ludwig
> >
> > --
> > Ludwig Nussel
> > Siemens AG
> > www.siemens.com
