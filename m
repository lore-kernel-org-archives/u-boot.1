Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13538C28B20
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 01:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36AA380F9C;
	Mon, 31 Mar 2025 03:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gu/S3nKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D32E81026; Mon, 31 Mar 2025 03:18:40 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5039280584
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 03:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac34257295dso775646266b.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743383918; x=1743988718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LIvBoRDB0QSVBGJJOYxSV/Lhvy6Y14AaeDhNeqDI+Vs=;
 b=Gu/S3nKFPe+EqC0MPVMZ/670GuoU6lOkmFuTOGxFgv+L9zWOJmvMzt/8TpckiZKtMF
 dlSDMvthqD1cAHD3Xrq1/jn2woiIieHOIhXxOwDey2DJL8ZaROxDrvsoDHzCHaMzOGDP
 +fLs9XWDgQUY1dWB3IIrcwcNIl2BKBKXux4gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743383918; x=1743988718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LIvBoRDB0QSVBGJJOYxSV/Lhvy6Y14AaeDhNeqDI+Vs=;
 b=TNU4/K/yBTcm664MJevzSs6X0Zan5DPe5mgrjPkoTHUUdmKDR1bdoAsz++Mia28bga
 q4OoWuaXc6UaMDkcg3qiXQNvcbXKEziQO0DL3F+ofLzB/NTlXliVlFGwTqXZJAwnHuyC
 6yWMQXseSVnoqzv+dEWeaqkUw8SZmzoFvhba9IoiscjY8MAO1s7DcoadBJ4vx+y+n0mu
 yf25k+AGKSoPqlj6sjmYx1Rqn7PLHTO2bMl/6FVMtarw6Rf3/+cN2CjLslmj4CT6ik2i
 T0augWZbRpcq9hX0cCsNJJOkeVJCtu4kXsC9t3UvwHVNqlUdAfsjyRlXVXw4cb6jVy4u
 MHsg==
X-Gm-Message-State: AOJu0YwLRsyWuGujnSU6iOjp36cI3X9TslGgIrAykDNKFx2zsV6Aefp/
 1JKU9Id4AAiABZ/20OVS+WaXOyI0SeWIZGnFXgD9PrgaLE/TtzATFfIPlH4hEyR0KNeq0o7Yr/Y
 73h/K7WxGj+P+I9w5FONCkfVhI15YfwOCTb1x
X-Gm-Gg: ASbGncuV2z8tqYXLakiv6CtqvSdwFwlsnDv+bEKjDEFkXcShgqro3IMGy5mi5gEZNoH
 NoFj3kvfEK9rI3oVtjjqoV5ufl0u/F7+TYnX3jvcuOg9nN2E+Zum34RnEn2nldmMxgB7NVu69ic
 NXytyv9wnal5RxaSy6vb/cFAPaNScv
X-Google-Smtp-Source: AGHT+IHG8B51DH3oMLRnLOvMnynPga6qposSJa9tUBBUfWSeKF4WIWIY8aIeJiZ8HdJMORXThwGkDyC3DInnUYMRDuk=
X-Received: by 2002:a17:907:9491:b0:ac6:b639:5a1c with SMTP id
 a640c23a62f3a-ac738a4bcedmr596619166b.22.1743383917673; Sun, 30 Mar 2025
 18:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250328130713.2612648-1-sjg@chromium.org>
 <20250330144709.GR93000@bill-the-cat>
In-Reply-To: <20250330144709.GR93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 31 Mar 2025 01:18:25 +0000
X-Gm-Features: AQ5f1Jp_Y3Dss59jiL8TFeT9XgZm7Dybqf-DefGh1F49M1qG3QNHXPeyqKQYWQo
Message-ID: <CAFLszTiykZ4EaLz2oBmUduLm_OsdDxamANf0cbBFaOvzyMwmMg@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 03:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 07:05:47AM -0600, Simon Glass wrote:
>
> > This series collects together some new features for expo to make it more
> > useful for boot menus:
> >
> > - measurement and display of multi-line text objects
> > - internal alignment for objects (e.g. centred text)
> > - editable strings in text fields
> > - new 'box' object to draw a rectangle
> > - highlighting of menu items, rather than just relying on a pointer
> >
> > Expo's boot menu is restructured so that it is possible to iterate
> > through various bootdevs and update the menu as new ones are found. This
> > is more in keeping with how bootstd works.
> >
> > A new textedit object is added, intended to provide a simple text
> > editor. Future work will complete this.
> >
> > With this series the boot menu has a better layout and appearance.
>
> Did I already say this for v2 and forget? It looks like you forgot,
> again, to split the expo stuff out from everything else, which others
> might review.

This series is all expo stuff. Can you please explain your objection
more clearly? I still don't really understand.

>
> [snip]
> > base-commit: 37ef92a972663c6de1b81d24d2ca5cfd664fc6df
> > branch: schd2
>
> Of course, not being on top of mainline, no one should spend much time
> on this anyhow.

As I thought we agreed, it is helpful to review patches so we can keep
the trees in sync so far as possible. I take your point that few will
be interested in expo and there may not be many comments, but sending
it makes it available for review and potentially sending a PR for your
tree at some point.

Regards,
Simon
