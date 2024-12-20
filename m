Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE57E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 19:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0609480384;
	Fri, 20 Dec 2024 20:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UGN2M0EQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7C4803A9; Fri, 20 Dec 2024 20:35:09 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C0780381
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 20:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so578776466b.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734723305; x=1735328105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xVwSM45BdKzC5yy8NteBxjDE6uW8oh0yQ6seYYEZdM4=;
 b=UGN2M0EQa0gBTJAktFDrHU+iF/GTBcMF2TvmY5OlSlEM5oUVWMg8nUEPP/WT+xYy+p
 EQjvuMu8b1y0twO1UuAt83f/WuevFGfv9vFwGzONEx/jMcF+1PK30WJoWlzOmUkv5JmE
 3p6iTODXrGlY96mnUPl4qtdhypqifR5ocNZdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734723306; x=1735328106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xVwSM45BdKzC5yy8NteBxjDE6uW8oh0yQ6seYYEZdM4=;
 b=qjHpdwCLSqmdpKJiIqsHnaGN2OG16H/w3vpRIokoU95gfIGwKGiTmEe585hZewg2NP
 2XPaHkaM+Mqj8bN0AEX1LKDLS1JSkHmFsOYNao1jj+BTYseiK/+azfMSpBvkoU8EQ9ET
 25JWAXowdecOmC4CXKFq+ZEXsrHoj7X6lon4OOFRrSB9fnkghlzhTwBRf32GtdcdoiRV
 XHCvHrnPITHdcalSnpN7GuIxMHJhxlXomtZ5cDqGlxf168sKMRgE19bkx17IxojzgnXl
 pD6BNPBt+zt5m9OP/rjqumNAomLFauioqURSc0W26ztb3N5rJ3dRVcWyVcDmx4C3/43i
 NF9A==
X-Gm-Message-State: AOJu0Yw7KO5E1HJU3JyqIavU3ZSTrLPS9DPfoG3gjmnhpZMmQzIuMTAQ
 aIbbxlRT8AzxLL3LZJ7LZHVI6z0I9ijfU4kd+sWYnPgT/zmaawFko8VhKzOvBxJWqK439wAnj4E
 SXxKtyWSiv9qswjUDxtbGFEFjIoIix6QtTLgNyV0biqWAZeQ=
X-Gm-Gg: ASbGncv8c+0YNKSa7kPw42Furow+xQPDcPgMnfywQqsDdSeFvOq9jH9RJtu/MlOLzEI
 t1T8fnXVV+RY8YUXWdL70n/khPHclY+WWE0oMGtc=
X-Google-Smtp-Source: AGHT+IE72mZBrXYO+BkVqIDg/X9TF3uyi4ggef14O5KiF79UbQgmbee3D+lVF4FdrPdAN2EoOOusuk4O+lpNsnCqPQQ=
X-Received: by 2002:a17:907:3f0b:b0:aab:daed:9ee9 with SMTP id
 a640c23a62f3a-aac080fe50bmr823564466b.6.1734723305651; Fri, 20 Dec 2024
 11:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-6-sjg@chromium.org>
 <20241220144453.GB1505244@bill-the-cat>
 <CAFLszThceeEktXy0zQLny5Hh4wAq0jXks4qijVyzgN0uHtG95Q@mail.gmail.com>
 <20241220183059.GK1505244@bill-the-cat>
In-Reply-To: <20241220183059.GK1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 12:34:54 -0700
Message-ID: <CAFLszTj=s7o7G9QU4yoL_0YoT3O+Zb==j40kJy=LhrrZNNJDtQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] pxe_utils: Support the SAY command
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Weinberger <richard@nod.at>
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

On Fri, 20 Dec 2024 at 11:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 20, 2024 at 10:36:56AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Dec 2024 at 07:44, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 19, 2024 at 09:01:20PM -0700, Simon Glass wrote:
> > >
> > > > This shows a message for the user. Implement it to keep the user
> > > > informed.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Where does the SAY command come from? This is in neither
> > > https://systemd.io/BOOT_LOADER_SPECIFICATION/ (which redirects and is
> > > limited) nor https://wiki.syslinux.org/wiki/index.php?title=PXELINUX
> > > (which is where http://syslinux.zytor.com/wiki/index.php/Doc/pxelinux
> > > redirects to now).
> >
> > https://wiki.syslinux.org/wiki/index.php?title=SYSLINUX
>
> Ah, thanks. Should link to that too in the docs then, I'll v2 my patch
> there.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Thanks. The confusing thing is that there are a few slightly different
formats at the same URL...

Regards,
Simon
