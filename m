Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07130C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367FB80805;
	Tue, 25 Feb 2025 22:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QExA4TS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1932B80F7B; Tue, 25 Feb 2025 22:45:01 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 620FB801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fbfa8c73a6so12045661a91.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740519897; x=1741124697; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sL/QbfjPHKGdxHCo1jcZguR8INDDv+VABSfqUqHhCuc=;
 b=QExA4TS+8zCJ3MJsHTXmM77oSWT7Vt4t78WpdAjL4RMt3s4Tb6V71zRYOLnOkr0Z6S
 o08H/aliv/nPTjFH3m10Xb5y8CssD2bOV72lQ7mrfQfuHOZL6DLDf0fLoo8h/m9RjwQ+
 jQqAAl0hPysbmEkyoowTXDodfTgWQv0IKUTxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740519897; x=1741124697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sL/QbfjPHKGdxHCo1jcZguR8INDDv+VABSfqUqHhCuc=;
 b=PxK+Xl6/qJkrLFPVcOAWo/ACgXFRXhxosoK/7pHORCgum8eBYUiIZJpzcqnY6hG932
 eaLi77OVxH7CyNKA/O4HA5nJ+/2DnS/raLWHp2820QVQ9g7cxbVPHBLJ11FlSQYpzYK6
 SiArZku0JY5Kd4or2Odbb9VKl4KRmr7E04YJ4LMlE7PdNtjixfk1ej+YSWRO9k9itaT5
 WmUDey/xUDrlvh6Mp/nj+ZRK0A5Kj5957mffptAoIKfZaireK7oYnObWhZ02rk/onDYz
 sQFkbqye/t/ntwzZU7DFqhjDfW5ytXp1+jVzhB1ibFtE8ORC9/pNYg3xv8wgfLi1aOLm
 6cMw==
X-Gm-Message-State: AOJu0YwoIZpQvlCbmBLCHE3Z7CxmqGO+9qRWMFbQNIGWyWejIXQNDk5K
 JOZ5ve8xhFQ6muI8TzgN45Q6b9/GzmSF22KLJZtS1BRqyW1uGAHL5YcSJ3S7+BASnEpshE1zJI7
 HiBpCr/2RzxP8zOGuO/KWpoDFSE6g/pDmNwVu
X-Gm-Gg: ASbGncsHtc7FUHHAuhhoBb8khixsW5maAek4+/yVgJfxGzMOPBjesP6HxeLJQS6fguB
 sVs4mfxjcXStwLanCweyaPVw70Hb2lNGXDyD3/WgQtyztDrQLeBOELRHAgYrhiwEZFJ8dgEOm0E
 0MCZc+r9iB
X-Google-Smtp-Source: AGHT+IErLHuXh8a+tQWdePFJ9UredPpMU/L/PlTpLxNZgYth7kT7oCyC7TH8X/c87v5rB8wCNnpdxOyhX0fy87kV9+Q=
X-Received: by 2002:a17:90b:5148:b0:2fa:17dd:6afa with SMTP id
 98e67ed59e1d1-2fce86cdeddmr35179035a91.17.1740519896941; Tue, 25 Feb 2025
 13:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
 <20250225213152.GB2640854@bill-the-cat>
In-Reply-To: <20250225213152.GB2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 14:44:12 -0700
X-Gm-Features: AWEUYZlMTnBbULWg1qBox-crycP59D6DMY_ivV1EDU5yqdMsvK6pJW6zp66VL0g
Message-ID: <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

On Tue, 25 Feb 2025 at 14:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> > >
> > > > This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> > > > are still not completed, so a work-around is included for those.
> > > >
> > > > A few fixes are included for some other problems.
> > > >
> > > >
> > > > Jiaxun Yang (1):
> > > >   binman: Workaround lz4 cli padding in test cases
> > > >
> > > > Simon Glass (6):
> > > >   binman: Exclude dist-packages and site-packages
> > > >   binman: Drop GetRootSkipAtStart()
> > > >   binman: fit: Drop unused code
> > > >   binman: Drop algo check in CheckSetHashValue()
> > > >   binman: Workaround missing test coverage
> > > >   CI: Run code-coverage test for Binman
> > >
> > > While we likely need Jiaxun's fix in order to be able to update to
> > > Ubuntu 24.04, the series itself doesn't apply to -next, please rebase if
> > > you intend for this to be in mainline, thanks.
> >
> > OK, would you able to pick this series up?
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=444576
>
> It also doesn't apply. You should really put together a PR, against
> next.

Oh, it needs another patch anyway. I'll send a v2. Once that is in I
can rework this one.

Regards,
Simon
