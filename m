Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3A2CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 11:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844BA84704;
	Mon, 15 Jun 2026 13:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BlEh6Toq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787478484C; Mon, 15 Jun 2026 13:39:02 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD339846B0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 13:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6605859ed83so771369d50.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 04:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781523538; cv=none;
 d=google.com; s=arc-20240605;
 b=D2dXYQdU6k2k234PC9BqorfJMYQZ+M7peHLn98EDcgCfoOeDtfn6vWZ3ske6pBmjuI
 gGeg4NgzSxyIU3RrlVULheIJ6kOzyxW1v4s6Ax9+aOwMvIOw/7lsiqtQ8q328R5g5jsi
 5mKCsBhoaERT3tCzfPG2ylys4Nft434y1PP+r8ikRr9U1PEFPocjbe8vbZDg9Qsok08Y
 kRtOkHHVpBz5jDLCZ8142AWdkGIVFhHaQkuF7niQxMjQ5+85qgYao5b9p1MNPY+dHXXS
 CEJheI7ODcu2jR1GMsVJPZTp+OmwVlcFNTB01QQmEG3Ov1kEmno9EY2WupRHchPxexz0
 /9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RD4G5sjQ+U8OVaN7Oog6GjTUJ8xc/83YOkzQaF+KVDE=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=fJA64wDAth2OLOiCkbeiXYUWh+xzL9YnKwED7B/Wv8N03n5bxElnURSZjMzk4kbPci
 ptkylaAOyn4mNg3M+mo4vLe0eEpwp5EW2KnhLzzUdr9vROuhmIoUtG9/5NaTrTYWilwN
 Np2xO4FFu0lLeHiHBMsee0z6vQCX1myCEqexfvvcgsNnp/3rROrKDbCgaBz3fr7nCsL9
 RGi3Qh2YeqkgwnwL5/3R4MRJqDrnOYtL7b+sWJeIOdp6jK0dW5eHNoqtcl+koDD2zfYC
 RaGCBiieX8oK8MWChioOKGyHHEG45vdC9wkstga/3PtPHHiuqiCiKKqFdZ85T7GESj3J
 WvWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781523538; x=1782128338; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RD4G5sjQ+U8OVaN7Oog6GjTUJ8xc/83YOkzQaF+KVDE=;
 b=BlEh6Toqh0YO5RxgFZj6AvR9P41UaCMRS6pJGz7GUDS5oWAlYfi6wiE+oW1m7mC+57
 3EFPCDNz3U0toB121jUdl1FoROmrTiM+12BLVJNWIrtjXCIhmSU32u65KES7iTGsfwva
 A3P3RUTWA3jhHVcwTsUMWgS0sQQpkzvyCspXiEAwuBYG8GIOCRFEBc+YgOHaKJndVRXK
 FvpFXubXviK/nsG1KOX1E5j2XUuS7ojoTsQ6P3/+mADlz/I8gtYXTq7tJoZVXR1/ruKw
 mitqM9LarmKg1JYmhX3wyIC2QwaaKPBnmSI1FxohKD/yyY+/zCxZkhC47jVjCrnAeFBN
 PjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781523538; x=1782128338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RD4G5sjQ+U8OVaN7Oog6GjTUJ8xc/83YOkzQaF+KVDE=;
 b=hrHZG62xmZeZ+2YreKOxaq2VIZAgYR3Pis4kn9iQ9dJ2b78Pwa7XsXF9LD3e05fkyX
 SR5lm2Xr59GPZ/E6iIlwLn19xt21xZrW1El+CaG9/FZ1937hj3NGIpjBFPEdmDOjQfUh
 DV8hi9CkWIglYvElJ5CPBTkCpEZs2a+tHPgoalsnVCdwgL1M1Ht0UKA8CZZO4fl//8qE
 cu3WxLvgXYSrpabxqzo5qcLB4aGGy2lfenMkDnuDMBmP8tpfrTlAZaZYo+aFF+K0Hz70
 xtXEOXhWgs6EE3sW7RsqEWRJKK0WNdEtGtHuNDyZcCZU1L2tumEMwsGmlkgCXK2aptxd
 qM3g==
X-Gm-Message-State: AOJu0YzaUGUuQZc90IPAj4vDhpoMiJs+HfQw+JhCjWR27sl7qFcu2yOe
 EtS199271rPiqu+e73IwH/isYOXQBZBQcUvG4bj7+0FNOoKUdBNPDc5ly6vE0d0GqQK0eoTH1Ka
 tOSVqa6R2ajCDaQQKPaer/X0QGOibtegcNVDNcTF8Ag==
X-Gm-Gg: Acq92OGuK7AOxBNgmkgoXpC5BTxIqbjwkl+L0aHzpWUWJkqQGKrDNyfNdgRNSkoCn1/
 ZUjHEOgopNEwvw5tX02CiVEKjRNI5X4TojWyDnaI7V04UBLxg+yqr48ROZYhUUT0rbpyI7yh0bZ
 6N8U8uexhJHZS3ONz81P8h7bMcWD4r4POA3fwH4KnzDJsZgA+yv6GrINa2iIvj/4k85zG9NV2Fj
 QBB90aVFCPPPKEOS+4JaeCD49v0SJGPLq2dMrBjc2Ui8bHZ/oKe6SsCcGCEAugAErEZcdnHgWJ9
 jjg8mByMbvsDsKepq5eVVgfpdakWMIlIunuAGd0MDqNvdKfMrwZeJjKjrisLQI89jc0t18KQiT0
 8/ET38pHwxi0o4KtaoHiRz00cyBEo7zsRQ/1BhlHPgXCM+SkRMCF8RW046u3jLabIsYcwkOfEKb
 E4rSb+kUSRqOxR+cPEIoeT5S/S7wC35+o4FuwZpmEQDXfVr52UFnz5k9F5qaVP+HwCjLM1xxmq+
 /WxBNgoyJNgPld+0+6NqIMUPHuorumanMw3wRPr7kEVf5VAdubw+aqVjU9fb3svQ7nk14ymHs56
 QmugcxZjljJfgB3YViXsuzOYXZR1WhmHZ4fPQBfOHMkivGiMSO33yvtaUAD/MLdSlSJduMLTjnO
 GhrG/kg==
X-Received: by 2002:a53:ac9b:0:b0:65e:57b1:e95d with SMTP id
 956f58d0204a3-6627832cda6mr12172213d50.48.1781523538483; Mon, 15 Jun 2026
 04:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
In-Reply-To: <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 15 Jun 2026 14:38:22 +0300
X-Gm-Features: AVVi8Cde-RyGk8kffyMfH6xcRR3i5_ux8hFFIV_Vd2ChvoH_v8z91wbl4_4ZblE
Message-ID: <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
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

Hi Ludwig,

On Mon, 15 Jun 2026 at 13:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 6/11/26 11:57, Ilias Apalodimas wrote:
> > [...]
> > On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> > [...]
> >>          if (IS_ENABLED(CONFIG_MEASURED_BOOT)) {
> >> -               struct tcg2_event_log elog;
> >>                  struct udevice *dev;
> >>                  void *initrd_buf;
> >>                  void *image_buf;
> >>                  const char *s;
> >>                  u32 rd_len;
> >> -               bool ign;
> >>
> >> -               elog.log_size = 0;
> >> -               ign = IS_ENABLED(CONFIG_MEASURE_IGNORE_LOG);
> >> -               ret = tcg2_measurement_init(&dev, &elog, ign);
> >> -               if (ret)
> >> +               ret = tcg2_measurement_init(&dev, NULL);
> >
> > I'd like the eventlog to be initialized before calling this (look below).
>
> What if I removed the log parameter from those tcg2_* functions instead?
> The event log belongs to the tpm device IMO, so should be initialized
> with the device.

Measured boot EventLogs etc are primarily described by the TCG specs &
EFI and we only have a specification for it there. The DT describes on
how to pass it over to linux with sml-base etc.
However, in the EFI case the Eventlog is allocated as ACPI memory. So
you cannot allocate the EventLog a priori, until you figure out what
method you are using to boot. We also have use cases people using it
only for RNG, due to limited memory, so we can't just allocate it on
the device bringup. And lastly... Some first stage bootloaders do not
initialize the TPM & drivers. What they do is prepare an EventLog and
expect U-Boot to replay it once the TPM is up and running. In that
case we obviously need to preserve what we have instead of starting
from scratch.

My main concern is that I *don't* want the EFI and non-EFI code to
deviate. I have some patches that I am playing around for quite some
time and rebased them last week for this reason [1]. If you think
those help your use case or make your life easier feel free to include
them.

> I am not sure what the intention of the current api is tbh. The event
> log basically documents when and how PCR registers were extended. We
> have to build that log ourselves as the TPM doesn't do it for us. The
> api weirdly allows to have partial local logs even though there's only
> one set of PCR registers.

Where?

>
> >> [...]
> >> index d41228f75a9..2270b038cf5 100644
> >> --- a/lib/tpm_tcg2.c
> >> +++ b/lib/tpm_tcg2.c
> >> @@ -21,6 +21,7 @@
> >>   #include <linux/unaligned/le_byteshift.h>
> >>   #include "tpm-utils.h"
> >>   #include <bloblist.h>
> >> +#include <dm/devres.h>
> >>
> >>   int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
> >>                        u32 *bank_num)
> >> @@ -212,6 +213,9 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
> >>          u32 event_size;
> >>          u8 *log;
> >>
> >> +       if (!elog || !elog->log_size)
> >> +               return 0;
> >> +
> >>          event_size = size + tcg2_event_get_size(digest_list);
> >>          if (elog->log_position + event_size > elog->log_size) {
> >>                  printf("%s: log too large: %u + %u > %u\n", __func__,
> >> @@ -553,6 +557,9 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
> >>          if (rc)
> >>                  return rc;
> >>
> >> +       if (!elog)
> >> +               elog = tcg2_platform_get_dev_log(dev);
> >> +
> >
> > Initializing this here feels wrong. This is a function that just
> > measures and logs data. Why can't we fill in the eventlog address
> > early before calling this? If we do so some of the checks above are
> > also not needed
>
> tcg2_platform_get_dev_log() is just a wrapper to access the private
> property of dev that keeps the event log address.
> How about moving the call into tcg2_log_append_check() instead?

I am ok moving the EventLog pointer as part of the TPM device. But I
think this should be part of tcg2_prepare_log_buffer(). That way it
will propagate to the EFI code easily.


>
> cu
> Ludwig
>

[1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/unify_tcg2

Cheers
/Ilias
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
