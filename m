Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63757C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A108831F;
	Mon, 17 Jun 2024 15:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DOgcEZIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D3A882DA; Mon, 17 Jun 2024 15:53:40 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E976882CE
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6316253dc52so32274747b3.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718632417; x=1719237217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DyiUUuU+L4uyiZ5oPYpAc0P6ln+4DLBCwP7bMYW1vzM=;
 b=DOgcEZIgPA0kQ58PbZkvnBWXdUDbiB2W6Ceeqw9lgq1RdSi8misIPf/lbxAiUok2bW
 oC2OAygzzzqNe1p8sUmiv5iDAMQOPLLSPqlWPGny/e80kMVlDBmRqZSxiIrtqt8NQiuM
 RMxiIvSOYafkMU6GF+c+v2TDw/Op844+Ui9cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632417; x=1719237217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DyiUUuU+L4uyiZ5oPYpAc0P6ln+4DLBCwP7bMYW1vzM=;
 b=QeEw4l4/qa5AlzUGDBY/iqV+29gIy/zDD6oeKCjgkm+vkJpMra+IZIMPp/RYFB5C1u
 eshoW2gxETIYJywK8KIXKOUqLh6gkcKymofop+spZbasChZc5wVh5oEW38n4rOT/JG1n
 RuOhy/GsDesJgbY85M148eKCg7sLu4APna2Ja6JGH4kk4e3KMvmgdWjuFeChdUmvH9E4
 w3qJ0AMdKriJBI6euqHAljGNMEO+qnrnbt7Hw3EkaE0N9dLJo/o2K4Zr+wHQS2Z7tTYN
 K7RFN3y8jGtn7wNRv76hh5kQssEL19Fbo78h9T4BlrtrMWEZoovEgVFxu8GB7DRIBacU
 nsWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVheAoikSi8JKGKKOCV5PbZm1w1uRRntCE8tHlGF2ycFXkD82lTneerkxQTrO8BWvOvGrOXajPVcSlHKp9uBLTmX5eTOw==
X-Gm-Message-State: AOJu0Yy3+OtwjktN+u8fNuwy7YRNSbFFpvFam6zWG6QF3Okjr+7X8k2z
 7WnE6hxrvL/kAnvOHo15AP0+OkEb7AfT5qMeoL/PzmAcyx6vpCKX/8iClXpXCbRDwYOoEUps7wX
 HyLskF1lsp7e9w2D7rYrlxDSzqxfVcwosfC0g
X-Google-Smtp-Source: AGHT+IGstmFwpwrLTXJ53Qp6XRUvJh2FPZcoUDw5xfua5oO044JSgH6NDUREP2gd8bB+lYZz45Fhi8e5MfwfBYASzH0=
X-Received: by 2002:a05:690c:84e:b0:62f:c163:a05e with SMTP id
 00721157ae682-6340b2e5048mr41476147b3.30.1718632416218; Mon, 17 Jun 2024
 06:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
 <a7410171-c413-4815-8187-606d32b0c5b3@gmx.de>
In-Reply-To: <a7410171-c413-4815-8187-606d32b0c5b3@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Jun 2024 07:53:25 -0600
Message-ID: <CAFLszTjsv8xYM+R1qKn+a61pCLkGr1Rs_zYy0FS5AvRNFTadtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
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

Hi,

On Sun, 16 Jun 2024 at 01:43, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/4/24 17:15, Mattijs Korpershoek wrote:
> > According to [1], we should use bootmeth when describing the
> > struct bootmeth:
> >
> > """
> > For version 2, a new naming scheme is used as above:
> >
> >      - bootdev is used instead of bootdevice, because 'device' is overused,
> >          is everywhere in U-Boot, can be confused with udevice
>
> Boot devices are udevices though they don't relate to hardware but to an
> abstract concept.
>
> bootdev is just an abbreviation. This does not make the meaning any clearer.
>
> >      - bootmeth - because 'method' is too vanilla, appears 1300 times in
> >          U-Boot
> > """
>
> Avoiding abbreviations like bootdev and bootmeth improved readability.

I think people need to learn the terms used in the code. Having a term
used consistently seems like a win to me. The documentation helps here
too, e.g. [1]

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/bootstd.html#bootmeth
