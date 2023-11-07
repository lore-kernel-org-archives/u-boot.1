Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70160C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7332B86FFC;
	Tue,  7 Nov 2023 13:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ojw6sBtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB47803AE; Tue,  7 Nov 2023 13:23:19 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF2E86FFC
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-542d654d03cso9263205a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699359797; x=1699964597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p9W+86KUTR88WSrC05X78bLKCClG/bk8jpibfiooDFc=;
 b=Ojw6sBtxzJl7U0d7EKVebRxiJkDnSroIgaKAIqNiuLBWVuXU9Mxm0Xv8Gj0LhYlcj9
 lQMFq6JpVelDi3vTXX+DWvbRkKK2owg3KHdzoxZ8cBpXeN28hRf9/WheE3QHW1MgUO5l
 t79l21jwOIqHEP5WnIO+3lo5h4D9tI3WoUTJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359797; x=1699964597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p9W+86KUTR88WSrC05X78bLKCClG/bk8jpibfiooDFc=;
 b=NDae1HeO1xCwUmGOPJAK22UqJhvxLrup3f8+FgdkQVgbWGugJNTOlj+/JjROaqXd82
 XkuLzCOFi/Yzrra/HDxuGTbH388juslwU+pnHG/l+BXOcBx7pnAuhm/99mq0+YPdubc5
 GYa15DDLxNMMi5386XvrrT0T4iXLhvDuTStbWgKHwuG9fWv7ro+/Mu14V7D6DeOvGWU1
 UD658FqLZFUKJcQClZcX6VLzfwQcnYqRevMXs2cntHi6yZZZaBXmuEN4qGlV24rQ+gKb
 iq0p9D6zUPmrolWocxgBqXjYpEzF8kFRu2zaUs3Dss8k9ibGfd+kCKDVQJ1BoNCxO9p1
 fJ0Q==
X-Gm-Message-State: AOJu0YyBzzWC6/LgfT0Rj+58N+PZ1hmU8jLBV2WTFTQNFx5A5QUXNg29
 ftzEx5G1ik/tlVM5as694zen9ER3mzzNUFR6TZ3glQ==
X-Google-Smtp-Source: AGHT+IGobw4hq/Vulh+kIw9XGubxxGdWnuS4NXczZtGIRNuA9wYeF/Fx+S8G5sHfSiqFWjDEOaaQv/YkLMliEaGrOxw=
X-Received: by 2002:aa7:c98d:0:b0:53e:323a:274f with SMTP id
 c13-20020aa7c98d000000b0053e323a274fmr21100646edt.42.1699359797240; Tue, 07
 Nov 2023 04:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20231105200453.1887418-1-sjg@chromium.org>
 <7a1345b9-8844-48e9-a1b5-8c7508cefeb1@prevas.dk>
In-Reply-To: <7a1345b9-8844-48e9-a1b5-8c7508cefeb1@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 05:23:05 -0700
Message-ID: <CAPnjgZ1BbpM_Ksr5aKg2zWLv1FPy-N_Kz6fbrkZoh=i7LfpMUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Eddie James <eajames@linux.ibm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Rasmus,

On Tue, 7 Nov 2023 at 02:56, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 05/11/2023 21.03, Simon Glass wrote:
> > This little series corrects a problem I noticed with arm64 images,
> > where the kernel is not recognised:
>
> The $subject is misleading, bootm works just fine with compressed arm64
> images, with the type set to "kernel".
>
> >         Type:         Kernel Image (no loading done)
> >         Compression:  gzip compressed
>
> Isn't that a non-sensical combination to begin with? Decompressing the
> Image.gz kernel image to any location (however you determine that
> destination) _is_ loading it.

Yes, I agree.

>
> If you want XIP, obviously the image must be uncompressed in the FIT. I
> don't understand what you're trying to do here.

Hmmm, I think I have just got confused about all of this, perhaps
because ChromeOS uses kernel_noload with compression. Is that an
invalid combination?

But then how does loading actually work? We don't want to put the load
address in the FIT, since we don't know what it is...we want to use
the address provided by the board. Which is kernel_noload...so how
should this be implemented?

Regards,
Simon
