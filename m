Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0224E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4760E89738;
	Fri,  6 Dec 2024 20:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hXM1TFIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA9789376; Fri,  6 Dec 2024 20:18:25 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED4088F0C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so1966101a12.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512701; x=1734117501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JquK5fJPgHmOq/D8FiaOJIQB5aB3ewVidsfvoGCxH5Y=;
 b=hXM1TFIpK9fXwfIgcGci4iPv+97Q8VX98XsqD9wDGwkskbV3SuPFTrmcH9kGOHeGes
 q3biYTSaB2cgSe/lgVlIMvKrdQCK04dnWV3a1AHr5wvNg6dgbRCSg0UcpAJzxnsIeH+M
 uZh6I4Q9S2NH9dd1bNccjuXIzfR0Ollnmzxdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512701; x=1734117501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JquK5fJPgHmOq/D8FiaOJIQB5aB3ewVidsfvoGCxH5Y=;
 b=Sqb7a976+srbA1qhRoeNbEWRbqDfUB3sQ5TpCKHJUFjSLgUqFBg3J4mbKcghKGjm+G
 WePDVX5MsZej5miVCSp9afJruOGVEkEBKpPhMoY69NYzRJBB8IA3HFaF5ANomaYXYj4J
 Qv4UrMpPZfiqsc1f77P5ys6rtoRbokV9WmDPZnkQe8fS1ogK/yNhso+xCRyLyj5wSCSf
 anjCR/E/YEcrI9DDyKHnERj62jhLFyDSDgiq0KfervMxF0tRKrPZm6qbRVugMUHbr+ap
 KV0i06VwpsKaQ266J7GEMn009DszkKCWYZOm0/WJhJIHY/8JqVQQhTD9Cinms1/tPXCW
 f+Ig==
X-Gm-Message-State: AOJu0Yy0LjSEyx2h+ya56HkfUhHDyKDe1zoRoBr4AxFXSfDUug2wIw2H
 TMHEtKyFqUcHPZr0b7hpCKRfkZKojV2a9dN/bVbAhNuuhtzGZouJF6l0FgyJ7SYIp5lNKRaMzA3
 JcZULtdl1CVFQuZ5OblcXVvTIGd55sqIZ7Z60
X-Gm-Gg: ASbGnctaaqgLX76uXV9KhRb11UFG2rsL7akueEM539pzdPgIROHQRf3u0Nl0S8Uzsat
 vbtPTMww2YFPhPfViuU67g4Rezk0oJpkX
X-Google-Smtp-Source: AGHT+IHeXtTrok6ZlxVqZeTAXuzz+rZHmsQxcwk5Y+9oNg2Ntc59wzts73DvIwFl7aOBfRh+x5HTIB/DtHa8gxPejvY=
X-Received: by 2002:a17:90b:2544:b0:2ee:c918:cd42 with SMTP id
 98e67ed59e1d1-2ef6a6c11b1mr4765641a91.22.1733512700850; Fri, 06 Dec 2024
 11:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206131113.2865416-3-sjg@chromium.org>
 <20241206141310.GP2457179@bill-the-cat>
In-Reply-To: <20241206141310.GP2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:18:07 -0700
Message-ID: <CAFLszThS0mDMe=ujRDPFDDrhM_9p=o=v5oBbpsQTAbDNfU5Qpg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fdt: Allow expanding the devicetree during relocation
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

Hi Tom,

On Fri, 6 Dec 2024 at 07:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 06, 2024 at 06:11:12AM -0700, Simon Glass wrote:
>
> [snip]
> > A comment in that function says that we assume there is space after the
> > existing fdt to use for padding, with the padding size set to
> > CONFIG_SYS_FDT_PAD
> >
> > However, there is no guarantee that this space is available. If using
> > the control FDT, then global_data is immediately above it, so expanding
> > the FDT and adding FDT properties will cause U-Boot to fail.
>
> This sounds like a generic issue and should be fixed outside of a "Pi"
> series.

Yes and I know you keep asking for multiple smaller series, but I've
explained that keeping track of all that for months at a time is too
challenging for me.

>
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 41a758e83a6..360611edd01 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -219,6 +219,17 @@ config OF_OMIT_DTB
> >         This is used for boards which normally provide a devicetree via a
> >         runtime mechanism (such as OF_BOARD), to avoid confusion.
> >
> > +config OF_EXPAND
> > +     hex # "Amount to allow the control FDT to expand"
>
> No "# ..." because the help explains what to do here, if needed.

OK

>
> > +     default SYS_FDT_PAD if OF_LIBFDT
> > +     default 0
>
> A "default 0" is almost always wrong.

In this case it is correct, since it means not to add any extra space
for the FDT.

>
> > +     help
> > +       Some boards make use of the control FDT to boot an OS, thus when
> > +       image_setup_libfdt() adds extra things to the end of the FDT, there
> > +       needs to be enough space.
> > +
> > +       Set this to the number of bytes of extra space required for the FDT.
>
> We should just use SYS_FDT_PAD directly and not add a new option.

I thought I read somewhere that fdt_high == -1 should not be used. So
for most boards, this padding is not needed?

Regards,
Simon
