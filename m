Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA03C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C608781E6C;
	Tue,  1 Apr 2025 17:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AJ19sYIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D9C781EC0; Tue,  1 Apr 2025 17:43:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D89C81DE3
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so10773245a12.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522215; x=1744127015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DAHkFwhWDZqbhlJ/W+AaNLq36hTP/Vb+L6f9aMp0qsU=;
 b=AJ19sYIrZAtMX1wWST3kg0LKj/SyQlfQPJ5EUcc3MUHkOXDOt+Bf2kOn1G9KJsZPHA
 6GJVhdTRxMTKANnC0wO/f7rxoiQUXIv1/n7JH8QHyycQP+Iv/gXDbfa/vTatsYn9njWc
 seG6hlSpvrMnLj1X/WTnRpd4ORrfFJF1C/yLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522215; x=1744127015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DAHkFwhWDZqbhlJ/W+AaNLq36hTP/Vb+L6f9aMp0qsU=;
 b=EIoNGonphFAmekGJihtGvAPE5ecS0rjOvRceMM0gZWM1HNFzH1Kyo4WhNMajmACqQ9
 aV5vO70C98ChfhMROTOtZhgG67+/rtsKqvcHaEX7zLD1S5SzpfUHKznnydff22Bex7/R
 g8xCrFp79QkulbHpbqKUr0/N1MAeQAP2ZAx82w8BxTo6kdlM/X4NalN29uTLfIhRUzWM
 +MV/rPRPQEzbNMieO3UhZPP9JiSYIkElO6zcKo1Od9H+0w3E8Qkob0h3vlgW2o+ioxy9
 tfT2A+VYU0TEU669U1G5++qJ8i7fxrxPo7LjJkcEwmSuqt6qKm4oDzJItbPNUFWhl6UG
 qtLw==
X-Gm-Message-State: AOJu0Yz8mKOQ5f9OkswupT2ig9ZrAdal4FqUzf86VUVLh4v9eEu6XaDF
 NfLI9FEgAmQUEYTT7wc3bcdQN6Bm2UeI0sIOJr42cKzBpB4jrLIUIqBh53wMsJNORdtx9gZjeFk
 gen0hdeaTkKdYW7ENiD+p7ml8ZnDCuHWch4Wz
X-Gm-Gg: ASbGncuhJurcE27/MZbwLijTydGMWFyi5oeHg89bSimeVjvn1uDKNoUez+yWOVyJXNU
 B10irGEXz8U0WBy9dex+fKiSqtbOtPB3QUixWlnsWzd1Ay1h7zOiaToJrjw+umRTHDV2HodWu2Y
 ckd3152zhc4h9NaoGqvd8EnxAuhhtY
X-Google-Smtp-Source: AGHT+IG8DxNpQyrhVl5nM6fMW4v+nXtwK4qGPy0jNiZdU0fUwqcf0BeeikAa/jXVbuESfMDgPCRaozsHARvMdDfImp8=
X-Received: by 2002:a17:906:d551:b0:ac7:333a:a5bb with SMTP id
 a640c23a62f3a-ac738bac9b1mr1214987666b.39.1743522215549; Tue, 01 Apr 2025
 08:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250328130713.2612648-1-sjg@chromium.org>
 <20250330144709.GR93000@bill-the-cat>
 <CAFLszTiykZ4EaLz2oBmUduLm_OsdDxamANf0cbBFaOvzyMwmMg@mail.gmail.com>
 <20250331134239.GS93000@bill-the-cat>
In-Reply-To: <20250331134239.GS93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:43:22 +1300
X-Gm-Features: AQ5f1JqxMv4lyySZcWuA-RV8nMvRnt8dLEAI_k9_iwS3zMXEujzTTqvH2Be4a1U
Message-ID: <CAFLszTgnEkN18sD7oKZpriiWqUNLgQ5_j2_2WpNDtvZo6Pyc1w@mail.gmail.com>
Subject: Re: [PATCH v2 00/56] expo: Various features and improvements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 1 Apr 2025 at 02:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Mar 31, 2025 at 01:18:25AM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 31 Mar 2025 at 03:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 28, 2025 at 07:05:47AM -0600, Simon Glass wrote:
> > >
> > > > This series collects together some new features for expo to make it more
> > > > useful for boot menus:
> > > >
> > > > - measurement and display of multi-line text objects
> > > > - internal alignment for objects (e.g. centred text)
> > > > - editable strings in text fields
> > > > - new 'box' object to draw a rectangle
> > > > - highlighting of menu items, rather than just relying on a pointer
> > > >
> > > > Expo's boot menu is restructured so that it is possible to iterate
> > > > through various bootdevs and update the menu as new ones are found. This
> > > > is more in keeping with how bootstd works.
> > > >
> > > > A new textedit object is added, intended to provide a simple text
> > > > editor. Future work will complete this.
> > > >
> > > > With this series the boot menu has a better layout and appearance.
> > >
> > > Did I already say this for v2 and forget? It looks like you forgot,
> > > again, to split the expo stuff out from everything else, which others
> > > might review.
> >
> > This series is all expo stuff. Can you please explain your objection
> > more clearly? I still don't really understand.
>
> All of those patches that don't start with "expo:" aren't expo changes,
> they're changes to other parts of the codebase.

Oh I see, you are talking about the video patches at the start. Yes I
will send them separately.

>
> > > [snip]
> > > > base-commit: 37ef92a972663c6de1b81d24d2ca5cfd664fc6df
> > > > branch: schd2
> > >
> > > Of course, not being on top of mainline, no one should spend much time
> > > on this anyhow.
> >
> > As I thought we agreed, it is helpful to review patches so we can keep
> > the trees in sync so far as possible. I take your point that few will
> > be interested in expo and there may not be many comments, but sending
> > it makes it available for review and potentially sending a PR for your
> > tree at some point.
>
> Yes, said at some point we should try it. And it's been a failure, so
> I'm saying to stop. If it's not based on top of one of the mainline
> branches, don't post it. Enough other contributors have expressed their
> unhappiness at reviewing non-mainline code.

If you would like me to send patches against your tree, please
consider applying the various series you have rejected.

Regards,
Simon
