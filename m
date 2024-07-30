Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546A5C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60A48886A;
	Tue, 30 Jul 2024 16:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kKbsNPTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA41488867; Tue, 30 Jul 2024 16:38:15 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B581888607
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b7b28442f9so50476796d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350292; x=1722955092; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iYAQtUBZMTSpUOxhqYHRQ6IZ79fiy9hl3SUMs3T4MsU=;
 b=kKbsNPTAgSBad8LKFAF3wCRAyUoqGl3NmcmaN1n4PH0BInF3pafG8xRs37tGSPiUew
 hWg/8HOivbl7rnquxwekjU/w42LU5qAEpFlj941plSStMX2X0fRpW7zbaFwHBO1MpYhu
 MeXgBs4i7hAxp6xO/HH1l6L/7BcZD+zB5z2eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350292; x=1722955092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iYAQtUBZMTSpUOxhqYHRQ6IZ79fiy9hl3SUMs3T4MsU=;
 b=NfGyMPRA/TOLEEqDyi5ozJLEnQoNFlYSVwQDJ6RsS8CbV12QfScokei+7zIavxOY0M
 wQ8G76j10Lt9ud9DWZ+m66QBQ75LguNhLagFEGRwf1UPpM07Jd6EYFC2zWGmRxMEj/2s
 zrJI3vqSFmf6A1p5YlMTPtUZp7lPyuNiHcnCbZmIpLlZszXpBuA0Rgb2T4HePnh10AS1
 Bnl2cdLixEp3M1DqRtnLKOGw+UsyLcdoYvlLLmtTlFLo8Pvq8b33VLq9GHBZe3CNf+K3
 dWpkrVQdFSJu8auKoFguRxmun1fgHC07G257K3OuRRDmThfDmA33PM+el3ru9wlrP6AU
 xfgg==
X-Gm-Message-State: AOJu0Yxt0MR16737oPO3caeapQVhMWUUbtz2zNqVRD5J75r04O03sKMG
 O9FXRKL4D8+Ixm8kIrOiBF3iuNS3UUwSKFiLR9sRf63oIyDl0Vg5dw1HzlprZdCy4UdHGAck5SK
 zlUzrB1ihRVMRnmfM8TLwFygSOb3xChi+Ujc5
X-Google-Smtp-Source: AGHT+IHMPcJul3GWjJN8OiR+QPhvQ1xlVgsQvlA3eDWsi8yMM4Nb/2czUvZstJliaZRJDaSahmDn4j4rKmQYfDkM5s4=
X-Received: by 2002:a05:6214:d44:b0:6b5:dcda:badf with SMTP id
 6a1803df08f44-6bb55acec3bmr128611916d6.42.1722350292604; Tue, 30 Jul 2024
 07:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240720104950.2730773-1-sjg@chromium.org>
 <20240720104950.2730773-16-sjg@chromium.org>
 <0e91fd5a-03b1-4a12-887a-3c81d056a6e6@ti.com>
In-Reply-To: <0e91fd5a-03b1-4a12-887a-3c81d056a6e6@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 08:38:02 -0600
Message-ID: <CAFLszTj1A+iVmnhcr0oXoyAGNDoO8MBffMC5Qf102KnhCV0hvQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] binman: Add support for alternative FDTs
To: Neha Malcom Francis <n-francis@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrew Davis <afd@ti.com>, Brandon Maier <brandon.maier@collins.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Neha,

On Mon, 29 Jul 2024 at 22:44, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi Simon
>
> On 20/07/24 16:19, Simon Glass wrote:
> > FIT provides a way to select between different devicetree blobs
> > depending on the model. This works fine for U-Boot proper and allows SPL
> > to select the correct blob for the current board at runtime. The boot
> > sequence (SPL->U-Boot proper) is therefore covered by the existing
> > feature set.
> >
> > The first boot phase (typically TPL) cannot use FIT since SoC boot ROMs
> > don't currently support it. Therefore the TPL image must be specific to
> > each model it boots on.
> >
> > To support booting on mulitple models, binman must therefore produce a
> > separate TPL image for each model, even if the images for the rest of
> > the phases are identical.
> >
> > TPL needs to be packaged as an executable binary along with a reduced
> > devicetree. When multiple models are supported, a reduced devicetree
> > must be provided for each model.
> >
> > U-Boot's build system is designed to build a single devicetree for SPL
> > builds, so does not support this requirement.
> >
> > Add a new 'alternatives' feature to Binman, allowing it to automatically
> > subset a devicetree to produce the reduced devicetree for a particular
> > phase for each supported model. With this it is possible to produce a
> > separate TPL image for each of the models. The correct one can then be
> > loaded onto a board, along with the common FIT image(s).
> >
>
> Realized I caught up too late to this thread, and it's already pulled in,
> anyways thanks for the effort this was needed.

Thanks for looking through it...we'll see how it goes and what
adjustments are needed.

Regards,
Simon
