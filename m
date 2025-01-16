Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4BDC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E7B8022B;
	Thu, 16 Jan 2025 15:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="g/O37zmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 651AD8033D; Thu, 16 Jan 2025 15:17:01 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5ACD80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so1420084a91.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1737037017; x=1737641817; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRdAH4GmUSoJaWyO0/b/jONkmadt2ktNOdxHZtV2h94=;
 b=g/O37zmz1JMvIzaXDsVtdP79huhYTiagWaPw5egTD9cYvlthHln5FrdZoC5zm/LhhH
 YyhkFWC1GmnFKUQrUg/+9XWUyaDr7W8YUcZF1PFuqVcr8IUzOlPgE3B6ee6iAA87HA11
 iKyLM3Exa9SRmLkWnP3A310QflQHaHmld1x0rALu55ITT/z3RCL2Vp9PWUHaAxCs1uWf
 u6iWQy0BGijHqU7uYRGolczkN+GMg+PhXcFy9L0k3p34+EpH2eWaL5NHijH1l6aQPkvQ
 B0NbXEdgzIU57q64LExWujL2G4jxVb3g4O86uVe6QxqGzVQfnspAl+IowiFflin1z4j0
 5iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737037017; x=1737641817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRdAH4GmUSoJaWyO0/b/jONkmadt2ktNOdxHZtV2h94=;
 b=NedLkYSs1Lr/y7VwHgDyX1Taaq2oSpgbLWDENYrIK7GPVKM2zPb+aJOHO9PQfAz3q6
 WBFJyhVz73rrXkrxEjgJSR2Vzct1BxtepxesufizNV9R8NbCz4ysSkMzg/JQHFmzfoL3
 VvrMuy9E4nM+/dEPJvJXVHL7mnFN382pEJMSINZi2gmfa7V0qp7ilGGkmJ7q7xr6w193
 lkV4hxbDa92EOxKSepBphHAQtGuyCanFOQ1sJAdCuedNjWt3VaFEDj2IbXU7bX/UktIh
 iStBijCRwCXIgYHixhEDmLH9fZqWgps7dZqaBRvOHeycxVFMHj/UTOQaq7t7i15qFw8k
 YHaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzmPrHgVCuNlP9hGqC6NRJnvZcJYfBeoUf+CTQhJrYyhhgKdzJ0ciHM3rLppx3sipnwHA5/KE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4EYLLYaw/C4i9QfljZ3HN1vwR6vdtDFXU5/M+5/4yyrNklWCG
 svvEIbwzjABUfhf+zLcPFskNLlkalXoOIrfsJ+WBd6fVOKUikccQiYvVPZGc8ngf6rw6q2/4HZi
 QqI6V7W1m15kObPiuOtd8SIbR+pDC9Gu8DVy5Bg==
X-Gm-Gg: ASbGnctYy2/V0gA8e+nHG2DStt75ViieBLtBcVQMN6AOvmE5hXqN/Er0WLhDxR+RFpt
 Wd1iIB0kS48M5oVT/2/TnuYZ5de0Cv4BmZ0T9
X-Google-Smtp-Source: AGHT+IGMhr9FBPIdmTTpPds+hMcUZuy39H+9M0+eQ7zQ08bMhCTFC/oddXDOFmlFJzWiZ+sYusncx8g1jnKr6zobzFU=
X-Received: by 2002:a17:90b:518b:b0:2ee:b2fe:eeee with SMTP id
 98e67ed59e1d1-2f548eba7d0mr50129219a91.15.1737037017257; Thu, 16 Jan 2025
 06:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
 <CALNFmy3ca5Z_Dr=1dzK8F4_+YWK4LtzK8Pq9VdNKMKS2kjWStg@mail.gmail.com>
 <8251256c-d1d6-478c-aa2c-6dcb8f5e4c12@canonical.com>
In-Reply-To: <8251256c-d1d6-478c-aa2c-6dcb8f5e4c12@canonical.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 16 Jan 2025 15:16:46 +0100
X-Gm-Features: AbW1kvYlwfBtjTg1ru0ZshO48q6FdNLj6C1eOc6E1KXP2vQWJnfzinvJucHdrW8
Message-ID: <CALNFmy1BLri30E8Sv_C47JKKQTqN2oWv0dyFdTGuPUXxX4v5RA@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: don't fill FADT, MADT if CONFIG_QFW_ACPI=y
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
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

Hi Heinrich,
here it is https://lists.denx.de/pipermail/u-boot/2024-November/571757.html

I'm fine with either solution.

Regards,
Patrick

On Thu, Jan 16, 2025 at 2:34=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 20.12.24 07:30, Patrick Rudolph wrote:
> > On Fri, Dec 20, 2024 at 1:38=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> When using the ACPI tables supplied by QEMU, we don't need to build th=
e
> >> FADT and MADT tables in U-Boot.
> >>
> >> This patch avoids a build failure
> >>
> >>      make qemu-riscv64_smode_defconfig acpi.config
> >>
> >>      riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
> >>      in function `acpi_write_fadt':
> >>      lib/acpi/acpi_table.c:265:(.text.acpi_write_fadt+0x15c):
> >>      undefined reference to `acpi_fill_fadt'
> >>
> >>      riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
> >>      in function `acpi_write_madt':
> >>      lib/acpi/acpi_table.c:294:(.text.acpi_write_madt+0x52):
> >>      undefined reference to `acpi_fill_madt'
> >>
> >> Fixes: f5f7962091e4 ("acpi: x86: Write FADT in common code")
> >> Fixes: 4a3fc0f525da ("acpi: x86: Move MADT to common code")
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   lib/acpi/acpi_table.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> >> index 150f75027a5..c0ed24984af 100644
> >> --- a/lib/acpi/acpi_table.c
> >> +++ b/lib/acpi/acpi_table.c
> >> @@ -273,7 +273,9 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const st=
ruct acpi_writer *entry)
> >>          return acpi_add_fadt(ctx, fadt);
> >>   }
> >>
> >> +#ifndef CONFIG_QFW_ACPI
> >>   ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
> >> +#endif
> >>
> >>   int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *=
entry)
> >>   {
> >> @@ -308,7 +310,9 @@ int acpi_write_madt(struct acpi_ctx *ctx, const st=
ruct acpi_writer *entry)
> >>          return 0;
> >>   }
> >>
> >> +#ifndef CONFIG_QFW_ACPI
> >>   ACPI_WRITER(5madt, "MADT", acpi_write_madt, 0);
> >> +#endif
> >>
> >>   void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
> >>                        int port_type, int port_subtype,
> >> --
> >> 2.47.1
> >>
> >
> > Anything wrong with the patch series send Nov 14 2024 that addressed
> > this issue as well?
> >
> > Reviewed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> Could you, please, provide a link?
>
> Best regards
>
> Heinrich
>
