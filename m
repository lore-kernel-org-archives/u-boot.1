Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DC5CD342E
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 01:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD0B869F5;
	Tue, 19 Sep 2023 03:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kEETY1mo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C03D869F5; Tue, 19 Sep 2023 03:05:02 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7AF4869F1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 03:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso4843307f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695085498; x=1695690298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QEJ+5uRN/Fax2LRsEGmdta4AcNFRLNy+9N+CwqEimJI=;
 b=kEETY1moptCw1Wte5ILF0T622yVqcR1z1Bw5K9VCeMjnlRSf7Ib9t8BKcj1IabnNYl
 3B/ntvhVJswvldX0fUCouVTS6qWSTXnwn8nZ166o++atIypNPefEkqrs/cyvR0oXwvqB
 rCmNwJnoCctp54IvGkBoGN779bthjJIgJdcXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695085498; x=1695690298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QEJ+5uRN/Fax2LRsEGmdta4AcNFRLNy+9N+CwqEimJI=;
 b=K+LJ3cWG7qqw0M/nxxi63fhawXyA6xAFBWFADuUFRLgiFpdF8sbvnBN3o4Pyw7lErO
 BPeyc8mH2GTBV6Ssh8uOTs4vvKt0y8n2zrAciMwYkK0Rn/Dt6fx2pKk15n6tZbKf4Ca+
 Mca+29plSjsr2o3+S+uhEttKZA9btdj7xT9giwVoIPz5E0I5ztGYxwc4Rm6ee3d8PUQH
 B9e3oR+LZVyd5N8zIiM0jlSpek5BLIHWKikNpcfb6sDL4C/crZNBS4BMrZK6W7joTCLV
 X0si7vU0qXiLE7gvWVVaSI/cN1SkNpzfbshld/dcNiaCgXJPVCNBhc7k18DsvKHb8MdC
 Lffg==
X-Gm-Message-State: AOJu0YyoUNkubLP5Rykg8jCQ76rXakRgSPKLLGzzoeaq2bbY16Y8pJZJ
 q4iooWCSMm6YmNw9NwsMjZgOre/dwcJDtBJz5kH4Yw==
X-Google-Smtp-Source: AGHT+IHxp1s56nNgq4H16EtFlQxm3VQRtdUkxJObpM2D9N8F8uk21B30VykfSBcFcr4/nAw0vLTDUjrRrTDjg4rmKUA=
X-Received: by 2002:a5d:6ad2:0:b0:31f:db12:f5db with SMTP id
 u18-20020a5d6ad2000000b0031fdb12f5dbmr7739879wrw.32.1695085498137; Mon, 18
 Sep 2023 18:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <1628fc37-2c9f-493d-82c2-9bf225f2645a@moroto.mountain>
 <20230809013930.GR3630934@bill-the-cat>
In-Reply-To: <20230809013930.GR3630934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Sep 2023 19:04:41 -0600
Message-ID: <CAPnjgZ3cooZZGKryY5UwBpd7O2kL5W1z++QxQf-Z304eaKvzUg@mail.gmail.com>
Subject: Re: [PATCH] video: Add parentheses around VNBYTES() macro
To: Tom Rini <trini@konsulko.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
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

Hi Tom, Dan,

On Tue, 8 Aug 2023 at 19:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 26, 2023 at 09:54:08AM +0300, Dan Carpenter wrote:
>
> > The VNBYTES() macro needs to have parentheses to prevent some (harmless)
> > macro expansion bugs.  The VNBYTES() macro is used like this:
> >
> >       VID_TO_PIXEL(x) * VNBYTES(vid_priv->bpix)
> >
> > The * operation is done before the / operation.  It still ends up with
> > the same results, but it's not ideal.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> In that this seems correct:
>
> Applied to u-boot/next, thanks!
>
> But I want to note that with gcc-13.1 (and binutils 2.40) or more
> specifically the kernel.org arm/aarch64/etc toolchains, this causes the
> generated code to change:
>    aarch64: (for 1/1 boards) all +8.0 text +8.0
>             bananapi-m5    : all +8 text +8
>                u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
>                  function                                   old     new   delta
>                  video_post_probe                           248     256      +8
>
> So I don't know that this was a harmless bug.

Hmm I should have read the comment directly above...

"Note we omit the outer brackets to allow multiplication by fractional pixels."

Having said that, it doesn't seem to matter getting (if indeed we do)
a less accurate result.

Regards,
Simon
