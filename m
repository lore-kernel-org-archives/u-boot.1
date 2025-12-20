Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E24E668B4
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 13:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB521803F5;
	Sat, 20 Dec 2025 14:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="OFIFjIDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA54D808AF; Sat, 20 Dec 2025 14:52:26 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8E180325
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 14:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so309394566b.1
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1766238744; x=1766843544; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dKw7yjAfQSKxU15g+l2ecy1Vf6TmcWpNfI3SzR7KBc=;
 b=OFIFjIDa/MAgB/bJjmX9Yuy3ug0NWugLqX5kI/eMltqp9ZGRbZ0JOSjx5muK5CrWhR
 xa7WbohJKp7n5hHtpL9PsbrK/8M7+SR1SIxXpShhXCeIGbNNa2bGeUsVVCv/bmoHw5IY
 LFWIGpztJwu8cnCz1BAheQkCE2B7SdLxTovGs1CD9waj/NAswQexXycU6mDjnQEGMboX
 2oLivLYS0/lAcIIhHho91bYGLntRPV4Alk1qcnbuuJuRSsAwoakOTmtIBcCdh9/fmwdl
 iADJnV2O3roK9V11Sk4MqfK1ZkElosK/r3GWqhaTdgTOAOlMfuLdRcfUHnl5vgQ/k96i
 Kl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766238744; x=1766843544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5dKw7yjAfQSKxU15g+l2ecy1Vf6TmcWpNfI3SzR7KBc=;
 b=wSqszGxmYhnQ6qsfIaccn8HtiJ4nOaWunz4qZNRSITatuc0eeb9SMzYKAAYDc/Y/n9
 G0hKkeypgZ4CU3CMhL6GCVY9Fz5D/9fgGJdjvZ1u2u3vCienreM/yfD9kbe7Bo5V5Be8
 ZjwyZaDtRN5kUP+p9AVwc2tosCfv12mL6/B4JxxT2HG9HnSnY6XsMJ5y8V8GjdK+B8Xm
 kzC9YIqiB+GKXvyP1exl7Igg2VQbsAM/B8xmyWUguC54ZydInMcZxhd1htvJuRyXwTby
 xolFd/+vzg57GpU1SymjIfOPSzlWIbUMTLGZouuQB8AS0tUd5GA1G9f39wcbLvV9IkLO
 fTrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4ob8U58+IGbiIJHE95GATFWwYWf5LoJy9r92Tk2sKFquaCfYEe99FJ+hoi4GkpS86z8TKdCk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1cmTUKoIsiNBQLvE6b+g9wFq/W308Js7skJgWPGlz9KUE+BED
 CbUasbxrKEHOxyr27Z2YH0XbH8kixKWW64YhCpFKjYn+wiOsrqpLNQbsuQqouHeGiK7B3BV3T61
 ayYnUBhcPVOxPCXz5ZtKNMcyXWwW92Wd7ix5YuemQbfhVv93+fm2hg9k=
X-Gm-Gg: AY/fxX7daAiuUp25KBVp3ERJyQeZyYNHDsJpWDqs2woIVwvSrQNjKI6ekxCHPhCnUMc
 S+XFBPUd1OHzXk5aMxtmd9oc8sQsWU3hrE2knD1h3dtIEWeI5JsfjvQUCxaJPv4sgIr7LJ2cWXy
 +EuSB8h7PyJBm0gHM38QBT7QY16U+pwjUSdayX0bKgpzK7la6jRWQpN06YMTx19dx2Ac8GDH6Da
 qaeDjef64OEaRWO/oeBTfcqmQNPHgQwqcHb31cCOKc3XpvKGHSLv+Vh4q9vfLBZav+HIbtAi/AL
 qg8Q
X-Google-Smtp-Source: AGHT+IFVkLLs3wAoHf5PjmYZfGRYr09fNaBYr/qLkcRQcCLkkHKJ79kBfF1jo4uCTjqss/eOHQppO/OcvvlD3/GMToA=
X-Received: by 2002:a17:907:96a7:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b8036f11019mr559524466b.1.1766238743972; Sat, 20 Dec 2025
 05:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
 <20251217072558.2949569-2-patrick.rudolph@9elements.com>
 <CAC_iWjKceKOGbZFVuYSTVvJkmW2yA8Aa9O7xECL05FRXrywSow@mail.gmail.com>
 <ecd34bbd-0b19-4c25-8095-61a2de226261@gmx.de>
In-Reply-To: <ecd34bbd-0b19-4c25-8095-61a2de226261@gmx.de>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Sat, 20 Dec 2025 14:52:13 +0100
X-Gm-Features: AQt7F2qMPPGQoUXrWMJPcLit6EQ4vtM8XiUV_10DW1OI6buKhL5OcuYeyWXg-Fk
Message-ID: <CALNFmy3X7FNWQmTtsNh7=2WSzOszK90my_h6LraT=7z=qRU6VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: Fix kernel panic when FTRACE is enabled
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Dec 19, 2025 at 9:44=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 12/17/25 11:39, Ilias Apalodimas wrote:
> > Thanks Patrick,
> >
> > On Wed, 17 Dec 2025 at 09:26, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> >>
> >> When FTRACE is enabled the EFI runtime will call the tracing functions
> >> that are not marked as __efi_runtime and cause a kernel panic since
> >> the functions have been previously unmapped by the kernel.
> >>
> >> Resolve this issue by adding the 'notrace' attribute to '__efi_runtime=
'
> >> attribute and thus disable tracing the EFI runtime. If required this
> >> can be worked out latter.
>
> What is the point of actually booting with a U-Boot binary with FTRACE
> enabled? All your trace data will be lost.
>
> Wouldn't it be preferable to error out at ExitBootServices() and
> retrieve the trace?
>
> The current implementation of FTRACE looks flawed. The trace buffer
> should be allocated from LMB so that it cannot overwrite images or EFI da=
ta.
>
Hi Heinrich,
I'm not that familiar with the tracing yet. My expectation was that
the trace buffer is marked as reserved
and could be retrieved from /dev/mem, however that's not the case.
I updated the CONFIG_BOOTCOMMAND to write the trace file to disk
before it runs "bootflow scan"
as described in the documentation. I can then retrieve the trace data
from disk. That works for me.

Regards,
Patrick Rudolph

> Best regards
>
> Heinrich
>
> >>
> >
> > So I agree with this. Fixing is just a matter of moving the missing
> > functions to the runtime section, but I don;t think it's worth it,
> > unless someone *really* wants to instrument runtime calls.
> > OTOH runtime calls in the OS are rare and very limited
> >
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> >
> >> TEST=3DCan boot a UEFI compatible linux OS on qemu-q35 when U-Boot was
> >>       built with FTRACE=3D1.
> >>
> >> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >> ---
> >>   include/efi_loader.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >> index 3e70ac07055..7a13c390cbe 100644
> >> --- a/include/efi_loader.h
> >> +++ b/include/efi_loader.h
> >> @@ -66,7 +66,7 @@ struct bootflow;
> >>    *
> >>    *   static __efi_runtime compute_my_table(void);
> >>    */
> >> -#define __efi_runtime __section(".text.efi_runtime")
> >> +#define __efi_runtime __section(".text.efi_runtime") notrace
> >>
> >>   /*
> >>    * Call this with mmio_ptr as the _pointer_ to a pointer to an MMIO =
region
> >> --
> >> 2.52.0
> >>
>
