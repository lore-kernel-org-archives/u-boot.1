Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD442C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 18:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72846809A4;
	Fri, 21 Mar 2025 19:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oRUqlSpL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F188809A4; Fri, 21 Mar 2025 19:39:00 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388B1803DF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 19:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso244986866b.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742582337; x=1743187137; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6K3vYSQcdYZOTFTW2Ar+H23qBH11H7aXOkwjvJifgJA=;
 b=oRUqlSpLbABirTxxQ3isRX/fpKk5uWtIOOgYeqmIEkhXPwNxJOIpgHoRGSUySoObAs
 iP3wINmjcNNk++YKaIQxWmoKVE9pb/IR2eWkbzq5wVGrUP3mYheHcs24prjwHvI2LpQk
 IPZeuSIbTYgJ/FomdlP6+HOHGQGbAKGhMwbSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582337; x=1743187137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6K3vYSQcdYZOTFTW2Ar+H23qBH11H7aXOkwjvJifgJA=;
 b=YCdzNmQyFGij97sZuXDwGTaopKHB9XQjjBsrU83Xi5/L7a+iawxUDD7G+czKNLYyyJ
 Q6vfk54lOZnL4hP5YSAjG1tYmfsylHbC/CTvKBgxS5hB14cViv2TIsi8zeLd2r4jvVBl
 r6c41ckTsEVekIvzbnpAfsAV1I5NmIyQZxZ3uT9glIV1znfQVQmWfy91/wrGAzL0xH8v
 r8qAW4Lv7MvlAa9+MPmIdCtBb8igECL6stDKNRAkGGVXa4ZnZ5LJpSMJ/3NrNN/Bwahq
 M6ghzP40BI2XNDycPHJ/08il3GYGNx+NVPYOuWCN+V/jX3A4jD35x33SV09I0bul2Ouw
 7naQ==
X-Gm-Message-State: AOJu0Yzxg8edQJheutTedGFDA3b3KVEySemTlhU1QjwPEqXgyeYiIf5M
 0145nbTrMEAFA6OfNQQWLXYiNabZgW5o8YbQWqihxcmhE65MNkan8YEL9SeSA/7CeUL0uWg7EXt
 AWDpV1NWG30eHDI0ovJ4tQHo+7pK3F1RAJMhb
X-Gm-Gg: ASbGnctl7ZckRwZRzVwzS/4ezgPITNsBZ5EdpCFmnQwPj7jFET/ifE+Cf+vdCGfePl6
 M3G4M+NRb9QBzNbX9Yj5iaFCoe9ZpUfJwD6JYzFx9IIVsLrQwrWpPiOrNkaP8UWdbA0yBC0TZw9
 yrtkFzEsW+IWc8+hPRbu5msiDW8M1rSXz7sJo=
X-Google-Smtp-Source: AGHT+IGaYl0j09rsicbY8aPwfTFO1UjRXjSX+rZ2KC1lidn0GERmWL93kAxfKULffNFGyCp9L9rbAPtWg9CS+w21LsI=
X-Received: by 2002:a17:907:7d8f:b0:ac2:2ba5:5471 with SMTP id
 a640c23a62f3a-ac3f22b4064mr446895166b.24.1742582336524; Fri, 21 Mar 2025
 11:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250319145512.2391122-1-sjg@chromium.org>
 <20250319145742.GI2640854@bill-the-cat>
 <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
 <20250320142121.GQ2640854@bill-the-cat>
In-Reply-To: <20250320142121.GQ2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Mar 2025 19:38:45 +0100
X-Gm-Features: AQ5f1JpTTc6VFUHI7CA4IabYJAqLAyu0v1NB7QTCzaO3j8A0xM4Rb0YQvM31y_g
Message-ID: <CAFLszTgsMu1ZtK1Z-u6cmH6k__0Qhn+G2SPh8w_NdrihLkQ7jA@mail.gmail.com>
Subject: Re: [PATCH 00/52] expo: Various features and improvements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
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

On Thu, 20 Mar 2025 at 15:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 20, 2025 at 03:39:26AM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:
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
> > > >
> > > >
> > > > Simon Glass (52):
> > >
> > > I see you haven't internalized the "don't post massive series" feedback
> > > yet. Please, stop posting massive patch series. Figure out how to
> > > logically break things down in to smaller chunks that can be
> > > meaningfully reviewed.
> >
> > I could split this into two series of ~25 patches, perhaps. Would that be OK?
> >
> > I believe no one else is using expo yet, apart from postmarketOS,
> > except the trivial case of 'bootflow scan -m' but I'm hoping that will
> > change in the future. I believe that Linaro is mostly encouraging EFI
> > bootmgr and the text-based menu. That could be converted to use expo
> > but I doubt anyone has looked into that, particularly as grub is being
> > pushed as well. I did look at converting the existing menu code a year
> > or two ago, but it seemed better to eventually deprecate it.
> >
> > Also, there is a following series which I split out and will post
> > separately, but not for a while as I have a lot outstanding.
> >
>
> It would make sense to split expo out to its own series as there's not
> likely to be any feedback there. All of the other parts of the series
> already have something else in their subject and that would be logical
> places to split this up more and then assign to the appropriate
> custodian. Thanks.

This is the expo series and it only has expo patches, so I believe we
are OK there.

The bootstd series is small and its own thing.

I can split up the strim() / test series, but I'm still unsure what
you are asking for with respect to code which is not yet used. I can't
reasonably do all of a) send code only when it is needed by later
patches in the series and b) keep series sizes small and c) keep
series related to a single topic.

Regards,
Simon
