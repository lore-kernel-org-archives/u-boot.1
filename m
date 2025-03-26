Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E5EC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 07:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EF08083E;
	Wed, 26 Mar 2025 08:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kEWCFhpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0801280756; Wed, 26 Mar 2025 08:31:29 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6090E8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 08:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so600407276.0
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 00:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742974284; x=1743579084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O4umWOq6im1Y2+qxehxcV0IsQM1GSWK7dlLe9m/j69Y=;
 b=kEWCFhpu5mGCALTUQtVerIjthZkcWrhh9KZ6pBLXWS9VjIKsVRg0nFSnRxR94I4SLn
 MlNsm3z2H5YZPVnkGjAVcvwWtsWIBAjMvafxjajMTzxMvULl1bnx0mcKsCtcOkokLoeF
 9vdrVAOg40vJImZpoPK0Z4O0zim60emG3DmxxXUrlQOZcb+hOrncSTf9b4OrwNojI9MF
 Sm9ZlZZo8Q0YbrYnlJ7cKUiBQS+fqpfP7T+FqymH2ioqQecvsrU1/WJNYC0LxeOLIqzH
 Ui0oIasYwrjIpEnXqZUEJHKMECfDivWNKoVtPkEd9JnKwf0xuqknN5WfklTQDBEX4foN
 fGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974284; x=1743579084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O4umWOq6im1Y2+qxehxcV0IsQM1GSWK7dlLe9m/j69Y=;
 b=g640K8zIwUJgV/DCsQZvAUPTgnBwUjdeZjoy3UfHZahvNOgiDDWDDSEYPFooYul8te
 i12u8OrOlfW2Qh4X8foRtFjqjruM3rnD9oBqjeCEuBdYFBV4LJiTPqCtEaobcQhkN9jf
 S88H17fT/+QCCvzNRuNGe4BTblJGRIWSHR0/RMyJ/DavEqYtDcWGHNO6RX1ZBBTXBgjc
 OTje6wWZoKVB5P6fBSztqs7g07h1rtTeIg6arQQwOqomQgHa4lB/wi2Loz4Xl7v1zmkn
 6aUMPENks0cdr0L/W3Lvavn3ugdXNoEpriiHROn4A3pWZ2sLKBda1nDb6Qsm4uQydxTZ
 x9vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpY4cqkj+zqmh8NKkzNyJznKSWXGhu5LbFiZsuqkY5rEzmekC/1U0ucnushdDtpJToCWR3exg=@lists.denx.de
X-Gm-Message-State: AOJu0YxZQdyH4Jy232mysDEDim5fJkiVMCkGwF4I8teeJDmX6vw7YCp5
 13m54TT23v38PIS8NLob/GGIqGVHjtAgFu2pu+eE6RdyeYK1hA94UDYzo7bJ02zLNNywzDdzueH
 iBMvam7sEZbv0qsG380lp9eW+aDYpJQ7jfahkpQ==
X-Gm-Gg: ASbGncs5GP33VBGD8VUVy04MPOvzVLkS/k9ImpUUQ7X3xmxwd9HnAdMrEoxZaHEYCmM
 ZGd14nZmKKXNyD0/1VKZOZvq0IiqzjDqMUSTuSZ3mZA9aQRoyvKAQVNJnhDxEaY6ahsWBUPpzOG
 bqbtYW8uXER7AVpXYL5MxjYTFrw4A=
X-Google-Smtp-Source: AGHT+IHVJgZkaETp/+qNZVLo7ywH52raIO8q3AR6adNMJ0Ff+UFQ/+xfq8fnMzIUpVvEXaiIxtceMEmOK5yAonNEZEY=
X-Received: by 2002:a05:6902:114e:b0:e63:41cf:b600 with SMTP id
 3f1490d57ef6-e692ef12233mr4346125276.24.1742974284148; Wed, 26 Mar 2025
 00:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
 <20250321232121.251800-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250321232121.251800-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 09:30:48 +0200
X-Gm-Features: AQ5f1JpNBngBsXZLWnw59JU9JV-6Z6k24Isy0J8DBxH6I-5smFP4l0YqYQ93rx0
Message-ID: <CAC_iWjKzOVQQqKJ5LsUxu9_G9JqYPJpdWh_-Tp4rXCeKZsuBoQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] qemu-sbsa: simplify updating ACPI table header
 checksum
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
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

On Sat, 22 Mar 2025 at 01:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use acpi_update_checksum() to update table header.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  board/emulation/qemu-sbsa/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/board/emulation/qemu-sbsa/acpi.c b/board/emulation/qemu-sbsa/acpi.c
> index ba85e08fc7d..7e4c55cc818 100644
> --- a/board/emulation/qemu-sbsa/acpi.c
> +++ b/board/emulation/qemu-sbsa/acpi.c
> @@ -133,7 +133,7 @@ static int sbsa_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry
>         gtdt->cnt_read_base = 0xffffffffffffffff;
>
>         // FIXME: VirtualPL2Timer
> -       header->checksum = table_compute_checksum(header, header->length);
> +       acpi_update_checksum(header);
>
>         acpi_add_table(ctx, gtdt);
>
> @@ -181,7 +181,7 @@ static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry
>         }
>
>         header->length = ctx->current - ctx->tab_start;
> -       header->checksum = table_compute_checksum(header, header->length);
> +       acpi_update_checksum(header);
>
>         acpi_inc(ctx, header->length);
>         acpi_add_table(ctx, header);
> --
> 2.48.1
>
