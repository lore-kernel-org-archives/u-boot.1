Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA0E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 06:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60768021D;
	Fri, 20 Dec 2024 07:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Ahbbt662";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F0C80243; Fri, 20 Dec 2024 07:30:45 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E7F8021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso1398407a91.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1734676241; x=1735281041; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGOhWp5rVlCHxy7Oxx9jpiZIsorvIpwU4IcVSLkDUKI=;
 b=Ahbbt6624ItVPXMBv3soJBVGJr0ug8VRy+kISaFppXhUt6WAV+mHl2r2XZ+NKZbRcZ
 BruzmLJ+HEgkB07igAwbZgKxEVC7/2dWRjVRk9tT2Rmu+gDyO0cvpf6qT8YZNUWvdhVw
 m3gKVHAuD4ax4mMvV0OMrHvec1H9OBJFNQecrOuZTckVJuT6xqzcsTB3NqEVnB+BEsbY
 JxugRM/fOqqEb8DXYF+5600DzGQKBkJwFOU4xVb5Wv+WDFOY5YwPCz3vXic47uHSkDBw
 W6QFfjglWDtmppjEctuZu68OuJUjmxY8IeNipwRYf6wqvrp6no04petxsLaOTRKwiQYk
 nC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734676241; x=1735281041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGOhWp5rVlCHxy7Oxx9jpiZIsorvIpwU4IcVSLkDUKI=;
 b=FGKH20JQCy7RwB9VDFyGo/TXWmWAH4U245N8EdtilPbPXmBN8y2moxKE/nzBy2Q2UR
 oVxxE/i1aOSjVJzotpwG8gMMb9a+kBGkAkljV1dabliAk/+Du8bo9FicwMIpe0nOGp4l
 p0hXgq1q6pE8LTRR/xJT6msE7V5N1m5khZq3m0hUQV9tPhqErVX2DLmMwJwgZjuFNjRh
 YLyGPHHfJGKkkKLZbrGB8OGIpAV1ONkWbRIowvA5GIhfkiQg4sLqRet1cgylajnb7ur8
 HVvdYp3F+SZATcWcJ2MpTXL4Btq8tPW9Xhbse4jxdwbGVHkxqRSsFbeGQqj7+1DCBQNw
 1GYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqQjSOathBps5VKlREIFtsjKkq7ikDta8cTxQ1Sn0316Qzs8PdiC24jFNMl9mhIZIESCJltak=@lists.denx.de
X-Gm-Message-State: AOJu0YzcC/+TSVc/t4Xvfsf/EEix/KlxEe8Bx56oKjgEkahXmW+4Qgtt
 GgSw14GPQm+whdeHCSlwF5wt7VgeQuayYE+164lWrkjU2X+OhJ+t9K7O56siOywx1aLsL54CDFa
 9phko5u4RD8Isy/7NK55FqflbNT7pF6iWenFZ1g==
X-Gm-Gg: ASbGnctPx14XnySJsRgykCSpZU+2WwCGglB2XA3GirSEIJC9w7zwJaGhLkaS1Yw9FGi
 1dr7fQNp0mPZNHD/HakposyZBiWIT5nQgIlAX
X-Google-Smtp-Source: AGHT+IGX0ZGPjRcweQphypN4mR6Igs+j90zicopqfKAgLwBtBTyv6QOAHoMMcSDh7Pyjqpg0FsP2tp2Y/h0MDbSwmGI=
X-Received: by 2002:a17:90b:270a:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2f452e388cdmr2630862a91.18.1734676241514; Thu, 19 Dec 2024
 22:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Fri, 20 Dec 2024 07:30:30 +0100
Message-ID: <CALNFmy3ca5Z_Dr=1dzK8F4_+YWK4LtzK8Pq9VdNKMKS2kjWStg@mail.gmail.com>
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

On Fri, Dec 20, 2024 at 1:38=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When using the ACPI tables supplied by QEMU, we don't need to build the
> FADT and MADT tables in U-Boot.
>
> This patch avoids a build failure
>
>     make qemu-riscv64_smode_defconfig acpi.config
>
>     riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
>     in function `acpi_write_fadt':
>     lib/acpi/acpi_table.c:265:(.text.acpi_write_fadt+0x15c):
>     undefined reference to `acpi_fill_fadt'
>
>     riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
>     in function `acpi_write_madt':
>     lib/acpi/acpi_table.c:294:(.text.acpi_write_madt+0x52):
>     undefined reference to `acpi_fill_madt'
>
> Fixes: f5f7962091e4 ("acpi: x86: Write FADT in common code")
> Fixes: 4a3fc0f525da ("acpi: x86: Move MADT to common code")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/acpi/acpi_table.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index 150f75027a5..c0ed24984af 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -273,7 +273,9 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struc=
t acpi_writer *entry)
>         return acpi_add_fadt(ctx, fadt);
>  }
>
> +#ifndef CONFIG_QFW_ACPI
>  ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
> +#endif
>
>  int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entr=
y)
>  {
> @@ -308,7 +310,9 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struc=
t acpi_writer *entry)
>         return 0;
>  }
>
> +#ifndef CONFIG_QFW_ACPI
>  ACPI_WRITER(5madt, "MADT", acpi_write_madt, 0);
> +#endif
>
>  void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
>                       int port_type, int port_subtype,
> --
> 2.47.1
>

Anything wrong with the patch series send Nov 14 2024 that addressed
this issue as well?

Reviewed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
