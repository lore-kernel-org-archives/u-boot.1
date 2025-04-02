Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA811C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 23:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CD681DE3;
	Thu,  3 Apr 2025 01:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GNTbYv2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 581A981F4D; Thu,  3 Apr 2025 01:55:12 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B244E8035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 01:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2902f7c2aso48115566b.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743638109; x=1744242909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q8yvcoxwtalbgXgnO9hYki3pRUkmOSYRRTp/hWWqpnw=;
 b=GNTbYv2wdBBvL29XdaMNZnKT3TP/P7jnep0PRPlKiBr8JKfkfhA6AzFzB0UvbkwG4u
 FQ1u7x5vSmVur+GWmkWsYZHMVclwRllLU0KAkjdkg9S/RgsQzyOGMAvaZxk103YzlK43
 b7mYWEpmC187IVWldjKiDvtreJTJauqBNe4sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743638109; x=1744242909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q8yvcoxwtalbgXgnO9hYki3pRUkmOSYRRTp/hWWqpnw=;
 b=qQ6GxEg0yWhbl+Y9jTsn1Dwmbk5FL6UlRHRmpzC8bmpqczQKf/dAqgeSi59IbeFH10
 O/aoBui14Uymaonlp0ehabd4N1+cuaJ/OgaIe1vmAoeBwHuYXFeHRHo6fZZL/e2/Klnv
 2gq1Q90hZc/Z3uoolrjk0v7HQBP4KMf2lQJstgs6BMQTtyuHHbBqOcfray6jY9TNF5ve
 r2hNYoK5Ozt6fhqkswIACu6MprGFsElvA6ohtbWs9s9FTPpxpyfSAv1ZBxPpYL00EMZw
 0oRz4Fx7IZgZ1r2NRZ0270SGUtQ4prnwcbQutmC6sp60iyKAYLWd5rv8eRSvmS2+dRRw
 /9Qw==
X-Gm-Message-State: AOJu0YxqstrCNF5rBYEKkeySsFjLxPBAMs6G4xkankHDwAxlXdYTdaf+
 sKP6f4yhFx4xzQAiZ57FxzQYBdGr61Iz9aeR7aCbB7S4gtGxBr2FSGDgFI4oTktbZpJhquJsWvy
 A7L++CGZzQON6PYIw814Inb81rHBKF9xdhW6r
X-Gm-Gg: ASbGnctNfWY6/MX3vxSrI3nHeKWrwB+VXo6sB97ypZzHj7D7/komRwkWOMZ82VsuQbz
 n5NVJhbSZPI+qoWHANb0lG72Ee0ZxMYnLf6QT1oMEUYmgPbWaSZrqm8mpZheUPbZg0vhjjWzXvB
 KhuHZuP2T/fvqStd+ZECewxkETRaws
X-Google-Smtp-Source: AGHT+IE9zaLtM7HApl6wF/PmmGptO1zgQ8ap1WiFrlEqK7ZC6pdxOIjA8qzY/5/veWzFksjeFZlsNQl3ghT7W+qSh8Y=
X-Received: by 2002:a17:907:3f07:b0:ac2:9093:6856 with SMTP id
 a640c23a62f3a-ac738bf65d7mr1706964066b.54.1743638108946; Wed, 02 Apr 2025
 16:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
 <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
 <20250402150024.GU5495@bill-the-cat>
 <CAFLszTh-N2PSKPV_OHa63mEi1ar6Y9+p+A4UTfTbf329wOiN9w@mail.gmail.com>
 <20250402211100.GD5495@bill-the-cat>
In-Reply-To: <20250402211100.GD5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 12:54:55 +1300
X-Gm-Features: AQ5f1Jo4oze4OCEFhWczxBwE_TOAI-IsqhotK_ZcdFkQxlLw5Pu_pB6EMnZ70e4
Message-ID: <CAFLszThRQi2o5g5S+=eciOS8+XC8TV9AyBpYf9LQKmH-2kkmvw@mail.gmail.com>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Thu, 3 Apr 2025 at 10:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 03, 2025 at 08:19:03AM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 3 Apr 2025 at 04:00, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 02, 2025 at 01:08:56PM +1300, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
> > > > >
> > > > > > This series includes some precursor patches needed for forthcoming expo
> > > > > > enhancements.
> > > > > >
> > > > > > - truetype support for multiple lines
> > > > > > - make white-on-black a runtime option
> > > > > > - support drawing a rectangle
> > > > > >
> > > > > > This series was split out from schd2
> > > > > [snip]
> > > > > > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > > > > > branch: schg
> > > > >
> > > > > I get as far as patch 4 before it doesn't apply to -next.
> > > >
> > > > Your tree is missing the video-damage series which adds some more
> > > > tests. It is here if you want to pick it up:
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/list/?series=369663&state=*
> > > >
> > > > I can rebase and send a PR if you prefer.
> > >
> > > Reading the cover letter again, that doesn't seem ready to merge either.
> >
> > It seems OK to me. What are your concerns?
>
> The cover letter read to me like it should be further reworked to
> address some of the problems it still has / exposed. That's likely why I
> marked it as Changes Requested a year and a half ago.

Which bit of it? Are you talking about my conversation with Alex, or
the actual cover letter?

Anyway, if you are willing to pick it up I could send a PR.

Regards,
Simon
