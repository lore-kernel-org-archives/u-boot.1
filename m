Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD62C3601B
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D580820B0;
	Wed,  2 Apr 2025 21:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lsl+OCYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA938206E; Wed,  2 Apr 2025 21:23:05 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5391381F66
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so20483366b.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621779; x=1744226579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O4Q/mBkp/zByKNlY6hwmGMG/aOlqmbz/JBNEho5LNjs=;
 b=lsl+OCYn8s0f4vgT+1n+TVi9gfBC1z5r4hOo5d4aw/iIibGAnBgBqF/lTrDrljVNXV
 Mmf8MZ52Ar+1KyJR1t48oroUuJ8Go3AOTAWKsdQP6e2sPjSHtjMOdelDmGnZsZg4iSlW
 6EOc9oWo+3HxRnBoPpbHhRSuCCyK80nqY6Ndc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621779; x=1744226579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O4Q/mBkp/zByKNlY6hwmGMG/aOlqmbz/JBNEho5LNjs=;
 b=FlScmMEZBcii98uG/9lDXhvX94MZYK0JfemqE6DL6KZCxrXFdxcpUk60nd+CtRWKvF
 9tEPGI6ZnVRCfbnRiKD3JqfkYzUZqV7gWNa1Bue4Kpf2vXkVNVgseDvaeRB4YitTlD+9
 DgbQe1W6x3sW78AHYt8NN3c+r7AbBzj8DoTqEiAZL9rdaLULmVshF4oPKV7MZNUlaA5K
 PKE8tEWNDqNSWGrK2rNoJEdEI1peGYYL2R/onidfNp7GZQGVOonmlMPMW1kKZpNLyjBI
 AhuRO7EYLtQ2h8WjJuFKYKwcfZVM8V0S4KEu6bqG+UBHuxVb8pmzTA59fYznGdw6Zv0N
 GQcw==
X-Gm-Message-State: AOJu0YywOAcILyDrCdeAqRc7horH3Ccpr5Y/XlkRchg8v+IL3U5N34wO
 cQmQc4FNnH4TUTj2ZpVxKkiawdceLywMGPjP6jb0Y+xFKFkKNHLGwfg85O59ikX0Zuq+FfHlV6F
 HFhFkThW875qkGFCeGFsIRTxEV3yiritSjCDg
X-Gm-Gg: ASbGncuq6hb1vhu/G+TBmdFK8IxXynXmF2L3zezTj9SfHfHzbRzcxHPg364SnCqrmKi
 n5gsaJj1QZ485PG3D7G3gObvvlSGdkPF4aa9ZvMCmgCR6Zpz6tLnUrOkjjxqqxqxNcvnu1el66i
 Ecc5wizuZK9UasdqMk6D7VvnAXJyaQ
X-Google-Smtp-Source: AGHT+IGYcrOsl+LGd0jy9uM2n9EkKs4X8eahCpxaEf0VHVvFl6IYQdVv64IPWxkcHCckQptiMr3kewnwGN2paeDSqQE=
X-Received: by 2002:a17:907:3d91:b0:ac7:970d:4341 with SMTP id
 a640c23a62f3a-ac7a16c32acmr324101266b.19.1743621778503; Wed, 02 Apr 2025
 12:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-41-sjg@chromium.org>
 <20250402142858.GT5495@bill-the-cat>
In-Reply-To: <20250402142858.GT5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:22:44 +1300
X-Gm-Features: AQ5f1Jp2VjST78XL5JLn25NyENsdSVX28kmcDRGED2QS_Vxm9DV7ulMSa1cZjZA
Message-ID: <CAFLszTiCgq6XqK7mVY9YWD6bjod3bWPtp_s2k7_WVgn8gVf5QQ@mail.gmail.com>
Subject: Re: [PATCH v5 40/46] boot: Support IO UARTs for earlycon and console
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

On Thu, 3 Apr 2025 at 03:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Mar 15, 2025 at 02:26:00PM +0000, Simon Glass wrote:
> > Update the string to take account of UARTs which are connected on I/O
> > ports, as on x86.
> >
> > Fix a typo in an error message in the same command, while we are here.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Add new patch to support IO UARTs for earlycon and console
> >
> >  boot/bootflow.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > index 58a1afa7a75..4054a966af8 100644
> > --- a/boot/bootflow.c
> > +++ b/boot/bootflow.c
> > @@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
> >       *buf = '\0';
> >       if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
> >               snprintf(buf, sizeof(buf),
> > -                      "uart8250,mmio32,%#lx,%dn8", info.addr,
> > -                      info.baudrate);
> > +                      "uart8250,%s,%#lx,%dn8",
> > +                      info.addr_space == SERIAL_ADDRESS_SPACE_IO ? "io" :
> > +                      "mmio", info.addr, info.baudrate);
> >       } else if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_PL01X) {
> >               snprintf(buf, sizeof(buf),
> >                        "pl011,mmio32,%#lx,%dn8", info.addr,
>
> I suppose we're well past the point where we can delete
> bootflow_cmdline_auto() itself because that's just going to lead us to
> trouble down the line (5 years from now when the kernel adopts a new
> preferred way to pass this info) and grows every platform by some amount
> of space every time we add something new here.

Well firstly, why would you want to delete this command? It is very
useful to be able to change the cmdline.

This command is only available with BOOTSTD_FULL, which is less than
10% of boards.

Regards,
Simon
