Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3D3C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E21874AD;
	Sun, 12 Nov 2023 21:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y9gHkIhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94DB87026; Sun, 12 Nov 2023 21:03:41 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA94C87479
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7b91faf40so43729247b3.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819417; x=1700424217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NOoP7fGkP5ZfOyT4AvSCMxlLH3j+9ETPdBUeZ1eTtlw=;
 b=Y9gHkIhMcC/9PGUyFgJ4r/nJCNQucU+2QOXluNpFAtcUwKbihPx/VNxDJdhBl4rbyT
 BgeQ39bKVb8KdDhyGmH1K8qgu1hBnTTsgvBc8tvwvTXQPeyfUCdAvhKQsWrHIiA0hthY
 XS1RCE53JL/0XN/u402ZcwXPgUBS+nAeata5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819417; x=1700424217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NOoP7fGkP5ZfOyT4AvSCMxlLH3j+9ETPdBUeZ1eTtlw=;
 b=nBGb52jt58DqLfp6WrIXI5eCpf3rFZlv30HmmZ30Pce51hYzu+PUf8EJRL87ZVg086
 460dN+fInCkOr+RPbGn0yrh5Tm5fdGf0T3eXft3nPUQHLGXkXBnem30tmM4tFbzbiQ11
 kVru2pr8TXal0Bh2MlqmY1XIGG89Hb1mgyc93Kjo20c06YUUvRm4/G3PfxOXXOxo4OxO
 DzZ09QzsceNREx11l+uQFzktzuhFaYimsHGMCWzJXiw70QKxMyFxtbktjiSI0vya7Hn2
 iVYNGYlAYDMZUm+CQp5TLGsw72KUok6pt0tIuanxxyDejO/Euc5XJDcPuSiqh+OyTJUB
 R/BQ==
X-Gm-Message-State: AOJu0YyBrxlo5ki3TD2XKYJNN9OPy/7SRW/Gdmvln5wenH3KEdlxJXXD
 e8WD6JnHx2EnH3sXtxS3Rkm835X6mInMdz7h3x5MLA==
X-Google-Smtp-Source: AGHT+IH/UxO8QImUZPmxvQ5Upqv37cSpVUD9kHXHD42UTXUr3uIBETxnKjxz79cdeP47ArCZDfgzn33f+HbffISAgJ4=
X-Received: by 2002:a0d:c8c7:0:b0:5a7:bbca:8c9e with SMTP id
 k190-20020a0dc8c7000000b005a7bbca8c9emr4116198ywd.7.1699819417038; Sun, 12
 Nov 2023 12:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-2-sjg@chromium.org>
 <781b39ed-9440-47c7-a457-22aff53ae494@canonical.com>
In-Reply-To: <781b39ed-9440-47c7-a457-22aff53ae494@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:24 -0700
Message-ID: <CAPnjgZ0=xAoG6aiM00DGQOUUmT_3GWO_w_RXkdihOwfTsR86cQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] acpi: Use __packed with struct acpi_xsdt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 12 Nov 2023 at 09:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/12/23 16:58, Simon Glass wrote:
> > Since struct acpi_table_header is not a multiple of 64 bits, use the
> > __packed option for struct acpi_xsdt
> >
> > This ensures that the entry[] array starts on the correct boundary.
> >
>
> Typically we keep the original signed-off-by when reposting patches.
>
> Thanks for picking this change up.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> As in your review you suggested to add a unit test I have done so in my v2:
>
> [PATCH v2 1/2] acpi: fix struct acpi_xsdt
> https://patchwork.ozlabs.org/project/uboot/patch/20231112070316.17982-2-heinrich.schuchardt@canonical.com/

Oh yes, this is a duplicate patch to yours...I had it hanging around
for a while. So we can drop it.

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/acpi/acpi_table.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> > index 1f85de091d39..59ab79ed17c2 100644
> > --- a/include/acpi/acpi_table.h
> > +++ b/include/acpi/acpi_table.h
> > @@ -80,7 +80,7 @@ struct acpi_rsdt {
> >   };
> >
> >   /* XSDT (Extended System Description Table) */
> > -struct acpi_xsdt {
> > +struct __packed acpi_xsdt {
> >       struct acpi_table_header header;
> >       u64 entry[MAX_ACPI_TABLES];
> >   };
>

Regards,
Simon
