Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B8CF34C1
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 20:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53BFE88F55;
	Thu,  3 Oct 2024 22:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FE3T0CXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC0B88F57; Thu,  3 Oct 2024 22:46:14 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B3088F44
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 22:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-507904d0800so510797e0c.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727988371; x=1728593171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bckBGdLxqGWfGOjFKCM3L0jfse2R7CVcSHBfTktlm1M=;
 b=FE3T0CXhQPXNCs8jXBWRhmy7ebJQLrJrJIvWpKY0MoyioSwbWGj5yAwBKKvO4oxsK4
 jnzz3dQp28+rw5ugv1whEYcKi53z97jgioBrHwZuy51m7AKdL/t6IWJdFErzo5P+z28l
 rao4BngvFlZDMEGEgL3tCY1DFl3bTsv7OYmqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727988371; x=1728593171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bckBGdLxqGWfGOjFKCM3L0jfse2R7CVcSHBfTktlm1M=;
 b=rFySV2LqnEeZBZp83/pX7f5/OPkXXV1gzWS0cdInwuwT8+XIHatkC75z7EKhJh1bYe
 jJ6Tbx+EkjhD4DfoxMciommPFZbFRVhkbXtqZEpdeXgNATooz5HNAP7LjlaeXz0LA2Vj
 DyioSfezC+ncH6YFOuuDmyNyFWWLxuNRPx7C53Er2AO7D3QBAH6aSAAn0SDRsgIXCZ7s
 m3OXIjudQwt1BBChWa/eGbIiGb/Q5h1tMhaKKj5PbtLWwyAcov60LSGo46rs4dm88cHA
 px2dJfHUzoqr2VJQJy7tBYJdmdnOC72Rl3hXQzJV/IxjdcIYaS4UYuOeedinPuaGkOX6
 iGag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlSZp081OcY63wbX2V1RhJGObyPa6mBsHXv6HZrulmqbe5vedCNm0aUB94/N3xcX7qWrAinWM=@lists.denx.de
X-Gm-Message-State: AOJu0YxrRroZoFnywTRU9TNyaUXEMplCrDTHx8z7crEaoZbzKDDuzDR5
 l+2SyjwKCHtFdSQdXMXwc//AMwt64W6FgQUr2qK9hvfBs+5NFLIBJK+786s25DtEFrGp7F98g+a
 Lg0mac8D7RamD+4b+EsSRYJshGMOywHXSKivL
X-Google-Smtp-Source: AGHT+IGxAgoUrKd8v+TBDhZn/s+1E3a6QYBXF6ZQOg9NGjFQwflF7F2NJdKd5wl4jUyKQJ6XT6XQTSkTg42Rqa7iRrs=
X-Received: by 2002:a05:6122:29c7:b0:50c:857c:f4da with SMTP id
 71dfb90a1353d-50c857d38f1mr584864e0c.5.1727988370919; Thu, 03 Oct 2024
 13:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-15-patrick.rudolph@9elements.com>
 <CAC_iWj+7uvnJp17LiFpc7TZYGdoH9Y_kroWLPGVzC2m5BeTAhA@mail.gmail.com>
 <CAFLszTiKi7+8NmihLqdvuS6fH6Jp2+4PZG6GHK1wNoRnQZx0SA@mail.gmail.com>
 <CAC_iWjJDg+A4Gx5fcHSyyYX_0eEfXKojRJJG99_w3P-jLTGydw@mail.gmail.com>
In-Reply-To: <CAC_iWjJDg+A4Gx5fcHSyyYX_0eEfXKojRJJG99_w3P-jLTGydw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 14:46:00 -0600
Message-ID: <CAFLszThG6kRgJLX4d_WpDYNvXL7EVGuky6A5ZsacK1hTvCkxKg@mail.gmail.com>
Subject: Re: [PATCH v6 14/37] efi_loader: Allocate and write ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 09:59, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 3 Oct 2024 at 16:49, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 2 Oct 2024 at 23:45, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Patrick,
> > >
> > > We've been back and forth on this, but we still disagree on the
> > > allocations etc, but I don't think it's that important to keep the
> > > patch out due to this.
> > >
> > > Can we move the table generation to the ACPI subsystem?
> > > efi_acpi_register() will convert the memory as needed, so I was
> > > wondering why the creation itself can't be done there. If you simply
> > > fill table_start_high/table_end_hi, EFI will install the config tables
> > > properly
> >
> > Yes, that's a good idea. The whole function can just move to
> > lib/acpi/acpi_writer.c perhaps?
>
> I haven't chedk the ACPI stuff to have an opinion. The description on
> that file matches that

Yes.

Patrick, please can you rebase on -next as well?

Regards,
Simon
