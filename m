Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97008C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AC982958;
	Tue, 29 Apr 2025 16:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kn9UuXWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91ACE8297E; Tue, 29 Apr 2025 16:35:38 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F65A8293C
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-acec5b99052so183858766b.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745937336; x=1746542136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rAeJrEke7eOwWcBybrLe2S7NIFA6k9J9PNinTzemeoE=;
 b=Kn9UuXWSTj+aqctMOzMGgT0Q5/5eLfV4KGk//3b7131MGVwz77OASeDlSTeu8qBLSe
 Do4F4xnQhv1DQX1nR4ZVPzF6JeigaaBNm3+QisesxeuLRDzHFmTWr/885RJJAxzihnSf
 8TJcVsD6agLVbdlY6FMAd2qAmgiHmMhTQiDG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745937336; x=1746542136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rAeJrEke7eOwWcBybrLe2S7NIFA6k9J9PNinTzemeoE=;
 b=Iv5voyqJCdDc8lXJhi/JqvbRGePKxpXDJ1kTAzeXdfMdgGyu8f2VDriKKvW7vHx+jc
 tzpfVnRjPfTGctIVrKMvgS6qiWE/2nulzYphdA1ffsSIkbSNTUpU51QtvBm6ocvrp7jX
 4Bmuxdkg49whB71/ha2lMmBflFgtGbSWm768pyFQ6n8/GVX1SLO1zysfFTxHv1i/BMbD
 ep/mUqVHEDw/mCaskFZ+NHwXbWXsObK86WSRJmNWBO+4f5oeB7oJgxWS3oHYqI85BAQz
 TONXPHSYecV7hUxwe9lCNz9gWg2G+uDfrRJ9kXdu1PHoorZU/exTH4XQoHGXSQpT5E19
 N36g==
X-Gm-Message-State: AOJu0Yy/Iik6Aq9r1jeIGEVT27VqbrY87yIM6vpAQ7tj7fOQZPamDHj9
 hkEC2C8VxxQ/vo2Zx6CPVx/+Nx6fh1ateELPR/Jmj75U5nzidsKVGHgasDtrLPpIhVoCKxerW0x
 BEWOKVGl0I8el0kX5ErHzv5HdpQmtMTLKurK0
X-Gm-Gg: ASbGnctCDhoZUYZpjWFOjxYkbydqdmgHqyCU5Eh4b2VKMyS0eT6QVrx3FefAZR4c6jO
 41FTikLp2LNDVqOVhGi0JbZ832Bn+79PlS5HlQ14qs9IoJU67GoQkltLdBJf9z3G9iVlZrB5/mD
 gKflZJQ5BoLGinEN9tn9tglfk=
X-Google-Smtp-Source: AGHT+IF/sFZXouHwtM0p0IsDgOI9J5/sjlP6A0hKUKh06MZlLicDV3RrPeCYNcllLfyNQWQqrV2IjPEt0kQSv5S289s=
X-Received: by 2002:a17:907:3e98:b0:aca:aeb4:9bd6 with SMTP id
 a640c23a62f3a-acec4b6b380mr367003666b.10.1745937335980; Tue, 29 Apr 2025
 07:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250429132239.251756-1-sjg@chromium.org>
 <20250429134846.GA1261075@bill-the-cat>
In-Reply-To: <20250429134846.GA1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Apr 2025 08:35:24 -0600
X-Gm-Features: ATxdqUHvZDskQBCsvxoqOOaIa14PwU9l7b5FZ_pTN6XqRz2un5BeYXh3o1SIGz0
Message-ID: <CAFLszTgrJvgWJaCXFgefJ1bObsrGfZa6AC8C6ypFRKJQTWm5ZQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] patman: Move to asyncio and other updates
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <seanga2@gmail.com>, 
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

On Tue, 29 Apr 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Apr 29, 2025 at 07:21:57AM -0600, Simon Glass wrote:
>
> > This series moves patman to use asyncio instead of ThreadPoolExecutor
> > since it makes it easier to handle requests sent from different parts
> > of the code.
> >
> > It also includes some updates to bring patman in line with the other
> > major Python tools (buildman and binman).
> >
> > With this series, we have a better basis to add support for syncing more
> > data from a patchwork server.
> >
> > After this, the next step it to add a new 'patman series' subcommand, to
> > track and manage series workflow.
>
> This conflicts with master, please rebase this if you intend for it to
> be merged to mainline.

I will take a look and see what patches my tree is missing.

>  And to avoid confusion, while I think managing
> these python projects in this manner (and not AFAICT following python
> best practices) makes life harder for everyone else, that is not me
> NAK'ing taking more patches, I continue to be compromising and "Saying
> Yes" to things you do that I disagree with on non-arbitrary technical
> grounds.

I'm open to managing them in my tree if that helps. For now it seems
like too much work to manage them separately, but if someone wants to
volunteer to help, I could do it.

Regards,
Simon
