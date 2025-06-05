Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D845C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 17:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B74820B0;
	Thu,  5 Jun 2025 19:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RRZ3yWcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E44826AA; Thu,  5 Jun 2025 19:29:15 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A0881E25
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 19:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so2306729a12.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1749144552; x=1749749352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HqISDjk/QVXlg+zLDFRiAUwMFBnXnyhFljb26KD6R60=;
 b=RRZ3yWcRrX97Fya9O92WJgWr78NOWPte4k2KOajt3ng7AXIe/oxmSW6ndUojlwaSiX
 LFKvjB0ExsP/duUP1BE2nmdd1WIlcKrAe1/7dJo9s6A80/atonap5eFncw6d2EgQadTE
 NkYgHxrt6gJjxw8o0GtWu9glSTI/z5b+cNjGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749144552; x=1749749352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HqISDjk/QVXlg+zLDFRiAUwMFBnXnyhFljb26KD6R60=;
 b=COY1/BgA2NEJeq0ruWeXWMANaNHrvVVDxJ3mzrBHI6BoHU9ctH3K4UOCGSUCt4M8Kp
 MBgvqROaG69mFFEmB8AAJcdBgHQi6JQSxM5xYbOPe8N//OzrYPd7onhQMKFGcR8vKMu/
 GA66QOHXRsPw5laTYLi97qiAuHiD0oaiR3SQ/ASYdHN1jiHwazgpZ+WFkaQ2fCFN5Qk5
 KNA04F1ULDXLJhq9onM4cSqtmAm3jZA/kk3A70+mrL+weqVGW5LeKU4qK/WTonu1K0KR
 KZkvICoUTSp/o1EZK31UqvCVQ8R9/SFDpTE4SXKzXoJ1HzyoVUNdMMFDHcE8Cc778XR/
 9ILw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq8pY3jqU0+DvY3XMo5sxVRIi0UQPvtwr+skfKjJbbHoPNQFosvzPiUhqGbwhLztxPiR9Ylxo=@lists.denx.de
X-Gm-Message-State: AOJu0YyzNJWl+Bc+l7V0FDnAVDyrnjjxapjaU8GpzULIjMReCX+tBShW
 6aWLfMEx/7rx3n4Smvi/sYi28KgMRKoomQGzl2VjPv1iRUtB0wUcIDodFsMbmSN4V01wdhRzlI4
 576euQA3HIcZMoAsTilYOHt6759mSmDddXaqoT0w4
X-Gm-Gg: ASbGnct0p/+9CByLZAGpYf0JGDTvQTrFevHczwSWXmn+SofgR9bDi3vpftWAoTwG7md
 KluYHiD0cJv9WBMDD3b6BXHbcYmNBNc+UsCOyZIOs2eq6bm+XffobwkQLvmFZTMy8Auxz6Pye/f
 9Z7aF9KHfGpEQIK6dx71rrJi3eslS5yoJmeCZIUi3jTzHu
X-Google-Smtp-Source: AGHT+IEBN4eDeeEVlP5S0pTWJQVtRAEJjgP35G34inWmLTY0g7Cs228hmSS/zIOuskO3kLbB4dMESpHioaISbue/mIk=
X-Received: by 2002:a17:907:720d:b0:ad8:88f6:a7d with SMTP id
 a640c23a62f3a-ade1a9ed917mr4921766b.58.1749144552407; Thu, 05 Jun 2025
 10:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250524141348.965322-1-sjg@chromium.org>
 <20250524142603.GG100073@bill-the-cat>
 <CAC_iWjKckRrKSjn=RG3BAdo5zi-h_-bnYBSVWh9Y0BCqREzZCg@mail.gmail.com>
 <CAC_iWjLjQ-fK1ZyXEEN=R+Up_Fxok7TGm50_2XrSkdTFTYbNLg@mail.gmail.com>
In-Reply-To: <CAC_iWjLjQ-fK1ZyXEEN=R+Up_Fxok7TGm50_2XrSkdTFTYbNLg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Jun 2025 11:29:00 -0600
X-Gm-Features: AX0GCFujLoEzqqA-T2A2_H17sDPrG9gqFfoRcAt7F4OSNpRDN4NK3wTfmCfDQQM
Message-ID: <CAFLszTj66OuRpW4FXtgrP91GoimrkpBCXceV7Y33aaASxwwjpQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Export the function to set up the TPM log
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Raymond Mao <raymond.mao@linaro.org>
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

Hi Ilias,

On Sat, 24 May 2025 at 12:24, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Sat, 24 May 2025 at 20:59, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Thanks Tom
> >
> > On Sat, 24 May 2025 at 17:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, May 24, 2025 at 08:13:46AM -0600, Simon Glass wrote:
> > >
> > > > In some cases, we may wish to set up the TPM log under full control of
> > > > a driver in U-Boot. Export the required function to make this possible.
> > > >
> > > > This avoids calling the weak function tcg2_platform_get_log() when the
> > > > caller already knows where the log is.
> >
> > This doesn't make too much sense to me. If the caller knows where the
> > log is, he needs to replay it in hardware.  Which also means you need
> > to check the logs vs the active PCR banks.
> >
> > This has all been abstracted in tcg2_measurement_init().
> > The UEFI subsystem calls tcg2_log_prepare_buffer(), but that's a
> > remnant from when measured boot was only supported in EFI. I was
> > planning to get rid of it and call tcg2_measurement_init() from EFI as
> > well.
> >
> > Is there a reason you can't use that? Is it slowing down the boot time
> > significantly?
> >
>
> Oh and looking at it a bit closer, calling tcg2_log_init() doesn't add
> an EV_S_CRTM_VERSION event which makes the generated eventlog violate
> the spec. So that function should just remain static

My intent here is to have U-Boot setup the TPM and start measurements.

If you look at tcg2_log_prepare_buffer(), it calls the weak function
tcg2_platform_get_log() to try to find a log, then looks for some
devicetree properties. None of that code is useful for my case and it
makes things quite confusing. The event is added by the caller in my
case, but I suppose we could change that with a bit more refactoring.

If it helps, the code which calls into the TPM layer is something like this:

struct tcg2_event_log *elog = &priv->elog;

blob = bloblist_add(BLOBLISTT_TPM_EVLOG, priv->tpm_log_size,
                    ALIGN_LOG2);
if (!blob)
        return log_msg_ret("sps", -ENOSPC);

elog->log = blob;
elog->log_size = priv->tpm_log_size;
ret = tcg2_log_init(tpm, elog);
if (ret)
        return log_msg_ret("spi", ret);

ret = tpm_auto_start(tpm);
if (ret)
        return log_msg_ret("spa", ret);

ret = tcg2_measure_event(tpm, elog, 0, EV_S_CRTM_VERSION,
                         strlen(version_string) + 1, version_string);
if (ret) {
        tcg2_measurement_term(tpm, elog, true);
        return log_msg_ret("spe", ret);
}

[..]

Regards,
Simon
