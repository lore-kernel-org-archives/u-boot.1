Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4E9CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E760686DEC;
	Mon, 16 Oct 2023 23:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D/8QuEth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1405C86DF5; Mon, 16 Oct 2023 23:55:03 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFEB186D18
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso37470081fa.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697493300; x=1698098100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C0xz2tzwX3CiIRNNpCZxgz1SaiPQj7pjqviAVLTiMh0=;
 b=D/8QuEthdrjcAVflN//GHSPTJox77LGoBk+Qrqf2ipNz0SLMl26BJllT13VTkXW7MK
 RGkUq4UX832eYa28ARa3Kq2K6J6+SzvLAINSA70ik+yjtioODfEkKsw4CMBYUyGiSsib
 7nDsJnyL/D8A85wkkdaZwEsA25KIE5ZQRPS28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697493300; x=1698098100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C0xz2tzwX3CiIRNNpCZxgz1SaiPQj7pjqviAVLTiMh0=;
 b=aTCQcN4K7e40j51PDDNxtDeKO9rBOX1InSXnuKTPt4htG37N1OL2XBbTmJQ7sFb+jg
 lFWKPDHRvailIlT9ysBzLwgZpzn0ltvPnCvQ1lriaQnfZEYxoRxU6yK/bnZUam2rCHdu
 0cf5b9PNStMeJ/BP5mI5zaTsdO+b/PrE56fxPvubPaRDIB4hXaymIy4TtMIFqFK5DrXu
 G7Ss2lPjYKsZokI43LutYzCoLLIzoaOrF/0fHuvQVCpYI/9fxuBaLVD7I468Nz9Lridk
 eftBiVZX7k3ZTR4lvWfVHeX+TBl60somIZV+kokAuER4NC/DdGqN26SblSOXge4KXpUz
 zaSg==
X-Gm-Message-State: AOJu0Yyaz3reAx5rt/BKUefUf5CHLz68D/OiST1cuOAkoK28JG+zaR5Z
 errCfjGXvMoj10agsqHu0EQxrdTP5FuUv/5As6jy1g==
X-Google-Smtp-Source: AGHT+IHreGF89jGtyvhDGGKHKIvFey1Qk1HfMAPmDQsc5v1rzv0NoFG/h+L9Pxk9zFOO0WeFHkSc4vdTaSJ/w7+tHGM=
X-Received: by 2002:a19:5055:0:b0:503:95b:db0a with SMTP id
 z21-20020a195055000000b00503095bdb0amr448628lfj.12.1697493299639; Mon, 16 Oct
 2023 14:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-3-detlev.casanova@collabora.com>
 <CAPnjgZ1s3OP6cq94qLF3mzkK6YwrjEFc91LOiUQWadj0NBZSqA@mail.gmail.com>
 <12366510.O9o76ZdvQC@arisu>
In-Reply-To: <12366510.O9o76ZdvQC@arisu>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Oct 2023 15:54:47 -0600
Message-ID: <CAPnjgZ0Aa9Rw2gPuwYMnWTaPPpZvzusa_48emJgfXX9BDKK78w@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] cmd: Add a sysinfo command
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>
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

Hi Detlev,

On Mon, 16 Oct 2023 at 08:21, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> On Monday, October 2, 2023 2:56:28 P.M. EDT Simon Glass wrote:
> > On Mon, 2 Oct 2023 at 09:21, Detlev Casanova
> >
> > <detlev.casanova@collabora.com> wrote:
> > > The command is able to show different information for the running
> > > system:
> > > * Model name
> > > * Board ID
> > > * Revision
> > >
> > > This command can be used by boot shell scripts to select configurations
> > > depending on the specific running system.
> > >
> > > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > ---
> > >
> > >  cmd/Kconfig   |   6 +++
> > >  cmd/Makefile  |   1 +
> > >  cmd/sysinfo.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 140 insertions(+)
> > >  create mode 100644 cmd/sysinfo.c
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Would prefer more help text in the Kconfig as this is pretty vague
>
> Indeed, how would that sound ?
>
> Display information to identify the system. It supports showing a board id, a
> revision number as well as a human readable name.

Also it uses the sysinfo driver for your board to get the information.
You could link to the sysinfo docs or header file.

Regards,
Simon
