Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0DC71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE84082A4B;
	Wed, 11 Jun 2025 22:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HRR4j4B1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD1682B0F; Wed, 11 Jun 2025 22:58:55 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1580981FEE
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71101668dedso1808207b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749675532; x=1750280332; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/3LoHW2PNcB3cSfd8oTTdNwXctHWT1J+dWM+YVaNGIo=;
 b=HRR4j4B1IR7hEMa6/gSw0S7589n9PS1oNtF4v/yQe4pXmn/y7++z8AN4FZhj3YLXFn
 BIKG4ZSTz+39trqPf45beZF3rNUdXp6/j6+Pmg1ROm1e1hUJfDjbrLb3/SOQauqqKEpP
 NkEjD/wdca1J6YIamWB1IYRCGjyBLxuDc58l6l2aQY6UfCZYN/9w7LDhxPTgKHyBAAxB
 inANe9+ABQwFj2/+/053dpuReGY63vZslEt8/29Db05Yha3fN4YK5fZce9YYukhqRYUw
 pENx3WPYPebKrR+Qnz4CCXypVR9XTzcinNZShNIjbs2I0o2WG2BLhK4U1+BCnnNF8gZE
 RhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749675532; x=1750280332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3LoHW2PNcB3cSfd8oTTdNwXctHWT1J+dWM+YVaNGIo=;
 b=H05wzTpE/Zrm2Sx2zI4sDjL7pDQZE6DrJex/LKp+isGR3hh+5DuHHauOMhb15fY+c1
 s36oRYL+Yrdy0NZHUIfDDgyJyAGZDXVU0s6CxK8g+IHsNzvmTRQDGhJkHRgwONBra3B6
 qVn0iT6OV6iqA1lD+2pZd7Yuk5qERhZnDB8m6TPBOBWS35cwWRas5jogSrOWmU6/4cxP
 bjZv+F9lim6cSy4TEKA3Lw9dHKgoe0fZTtaFdLFoXz8UW55WGGVXe57BexUjZd2RjNgA
 7vPzzcJXLQIApQ4+WOsinfPiRy6fq6CBoyIijzdYJHqzyEYaPplquI88Bs81A3Q7PrMd
 O6iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPDi4BOKW9ZwA+NnXAAn91M+ZJJ285hxRRssQR2yaiw2Wi4ucGRSoAxWkhBV49uTxxMXg7FjY=@lists.denx.de
X-Gm-Message-State: AOJu0YzQejKnNA1D5UD0wwdriJQaeGE9iaeKQUNUFgwQjEMl6u63ZUC5
 j4fyN/hd9Wvt4UTC66cqbHn50rSwXqdnLVCswlk4vbG2qhEFP6CbaqLnWvNbzZ/Ya4Zd+pmuvuB
 YKll8Bj25CyQjh8ERbWNdaCvT4ufVGmJvNktZrgktDg==
X-Gm-Gg: ASbGncvpMvsUpzs7GhgQcynvwSGmBSSrX0LlluNbgjYI3+J65AQad+W0oFqE5bIxyBn
 JOYSxegfHjdr3B7ld+H2rTXhNtu4849/BNQAGCi33Lt9hEAlhaYRnHRpNKZeDHIWuSaUY+8cuXK
 MNYm2qB2SHUe+avN3nJII32znhfxRqsLZ7d3CFczHOOYlLpq2FfvbcmAA=
X-Google-Smtp-Source: AGHT+IFq2GfDaXVkthAxsNwT/x1yglcHVnDUhadkXdIGKQt4wtdKyi1Uy+Gm3//MDmt6wrQPHCkz2QUmKj3dEnLTBsY=
X-Received: by 2002:a05:690c:688f:b0:6f9:7920:e813 with SMTP id
 00721157ae682-711409f06abmr70094737b3.4.1749675531870; Wed, 11 Jun 2025
 13:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250524141348.965322-1-sjg@chromium.org>
 <20250524142603.GG100073@bill-the-cat>
 <CAC_iWjKckRrKSjn=RG3BAdo5zi-h_-bnYBSVWh9Y0BCqREzZCg@mail.gmail.com>
 <CAC_iWjLjQ-fK1ZyXEEN=R+Up_Fxok7TGm50_2XrSkdTFTYbNLg@mail.gmail.com>
 <CAFLszTj66OuRpW4FXtgrP91GoimrkpBCXceV7Y33aaASxwwjpQ@mail.gmail.com>
In-Reply-To: <CAFLszTj66OuRpW4FXtgrP91GoimrkpBCXceV7Y33aaASxwwjpQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Jun 2025 23:58:16 +0300
X-Gm-Features: AX0GCFv--vxyj-OmT3XNXK5ZRarL0iks8V8vflTDA-s389lTMpcsLehXo0n0CKQ
Message-ID: <CAC_iWjJ7WJNn=68-vnABaJsYiBjeuf=4DnBi=kDBAnE0inAoSQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Export the function to set up the TPM log
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Raymond Mao <raymond.mao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Thu, 5 Jun 2025 at 20:29, Simon Glass <sjg@chromium.org> wrote:

> Hi Ilias,
>
> On Sat, 24 May 2025 at 12:24, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Sat, 24 May 2025 at 20:59, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Thanks Tom
> > >
> > > On Sat, 24 May 2025 at 17:26, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, May 24, 2025 at 08:13:46AM -0600, Simon Glass wrote:
> > > >
> > > > > In some cases, we may wish to set up the TPM log under full
> control of
> > > > > a driver in U-Boot. Export the required function to make this
> possible.
> > > > >
> > > > > This avoids calling the weak function tcg2_platform_get_log() when
> the
> > > > > caller already knows where the log is.
> > >
> > > This doesn't make too much sense to me. If the caller knows where the
> > > log is, he needs to replay it in hardware.  Which also means you need
> > > to check the logs vs the active PCR banks.
> > >
> > > This has all been abstracted in tcg2_measurement_init().
> > > The UEFI subsystem calls tcg2_log_prepare_buffer(), but that's a
> > > remnant from when measured boot was only supported in EFI. I was
> > > planning to get rid of it and call tcg2_measurement_init() from EFI as
> > > well.
> > >
> > > Is there a reason you can't use that? Is it slowing down the boot time
> > > significantly?
> > >
> >
> > Oh and looking at it a bit closer, calling tcg2_log_init() doesn't add
> > an EV_S_CRTM_VERSION event which makes the generated eventlog violate
> > the spec. So that function should just remain static
>
> My intent here is to have U-Boot setup the TPM and start measurements.
>
> If you look at tcg2_log_prepare_buffer(), it calls the weak function
> tcg2_platform_get_log() to try to find a log, then looks for some
> devicetree properties. None of that code is useful for my case and it
> makes things quite confusing.


Why? Whjat's the confusing part. It tried to replay an EventLog and
confiure the hardware correctly, if the PCRs are not exten

The event is added by the caller in my
> case, but I suppose we could change that with a bit more refactoring.
>

Do the PCRs match the eventlog at that point?


> If it helps, the code which calls into the TPM layer is something like
> this:
>
> struct tcg2_event_log *elog = &priv->elog;
>
> blob = bloblist_add(BLOBLISTT_TPM_EVLOG, priv->tpm_log_size,
>                     ALIGN_LOG2);
> if (!blob)
>         return log_msg_ret("sps", -ENOSPC);
>
> elog->log = blob;
> elog->log_size = priv->tpm_log_size;
> ret = tcg2_log_init(tpm, elog);
> if (ret)
>         return log_msg_ret("spi", ret);
>
> ret = tpm_auto_start(tpm);
> if (ret)
>         return log_msg_ret("spa", ret);
>
> ret = tcg2_measure_event(tpm, elog, 0, EV_S_CRTM_VERSION,
>                          strlen(version_string) + 1, version_string);
> if (ret) {
>         tcg2_measurement_term(tpm, elog, true);
>         return log_msg_ret("spe", ret);
> }
>

I really prefer to keep the unified version. Searching and replaying an
EventLog is something that is already working for TF-A.
I don't want to create special cases. tcg2_log_prepare_buffer() seems to
match what you want to do here.

Thanks
/Ilias

>
> [..]
>
> Regards,
> Simon
>
