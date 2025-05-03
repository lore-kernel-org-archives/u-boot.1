Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFF7C3ABAA
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 02:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603F48214F;
	Sat,  3 May 2025 04:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CT/faEFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96FF81F66; Sat,  3 May 2025 04:10:52 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B717A826AD
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 04:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so481789166b.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 19:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746238250; x=1746843050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=APTf0K546Ty/LFwUOVmi1q47h2j9cK0d0dsD6dCrrr4=;
 b=CT/faEFInIJVBFRAhkWmrwQFNFi7J1OMQshmB2MTI88ayReBLN+yF38RaL5M7l16E6
 y0n6CeuM27RTvPvT4cPqogBgTPEFvpb2xQajdzlmpWD0EBC/wjWLHo4rE3VARB0rIGmW
 JLeWjda6CFvdOdZoTb3OAAxgjHti0/zO7wEMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746238250; x=1746843050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APTf0K546Ty/LFwUOVmi1q47h2j9cK0d0dsD6dCrrr4=;
 b=TgK474hNLnm5r+BAa9yBF29S5rqlmHn/lZ02AhFIsLJpzSxBbIgZgQFTShNXmw/LIP
 KP5lJAgfssK9hNcbuNLrbxZVzFHEpGkasP4KHNmmE5vjCBbxiJe0YuKbitKdp3KAKiGt
 kDy2HJaA5tmZ3OVWf8uzfv284+pHYJWjwQ7CVYtIIC0ZwIl5LWOSde4sIAEzRXdn+xSs
 fX+n8zCIdReZ5rs/x5CA+OdoQeOBv/Cp6WaMOiPzpYyTE8zCkIv4c8Nsq153qfHp7XDY
 PgV03Q8+W6Q3gsKeCyr5B3/EE7l79COtvGfivh7Ux7YGErlZfWkypTmbAWtkYwmLPxqQ
 ClcQ==
X-Gm-Message-State: AOJu0YyGnBz5PWWg4cHKj9DskiuOT6b/q7MZ9FZ2YR8mT8yLhtyBR2YB
 PVXriq9rqTg02DlNzFVjfaBxa4tKLU5i12T+bEEfm4ZYzI3LToLwjMpkK98DsN+5MfsX+F+OTQz
 q9GwqYPYssBelikLM0VNSOLPo+cpJOaxGTiwv
X-Gm-Gg: ASbGncu7WU79DIDVUuvv9ZxVihRLMoHwBWHAv23PwknVW/J4fWmIWdfzqK6qudQ84/+
 H9cp2ROVrbOrY555kI5nrd4BqJm3JSMUz8dOA8e35RDmT0Co8jWyu1xZHTGEChzbk7SJDkCi8Mn
 S/0D5VV/V1+DB5+M/LQRuQn/I=
X-Google-Smtp-Source: AGHT+IHlv4I82txF1N4a+xVGBJAHPq0yvYttS+pY2TmD6WjYwEX0BMLJs7V9i45ewg/4X5Z6fuHYtmOBJTfocgJVrLk=
X-Received: by 2002:a17:907:971a:b0:ace:3a27:9414 with SMTP id
 a640c23a62f3a-ad17aefb21cmr473228966b.44.1746238250252; Fri, 02 May 2025
 19:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250502144718.313633-1-sjg@chromium.org>
 <20250502150035.GU1261075@bill-the-cat>
In-Reply-To: <20250502150035.GU1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 20:10:37 -0600
X-Gm-Features: ATxdqUH-5-Y-rtEqGqmDYoHG_xWlmkXObxCAZhw9EWyVpOIEo2TMfrgsVKL5L6k
Message-ID: <CAFLszTiic_fp=etd+t8OCiEy8=yWdrwEAp8XNChFecbpXVJ=aQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/60] expo: Various features and improvements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
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

On Fri, 2 May 2025 at 09:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 02, 2025 at 08:45:58AM -0600, Simon Glass wrote:
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
> >
> > Changes in v2:
> > - Add new patch to pass in the video device for cedit_prepare()
> > - Add new patch to test rendering a lineedit
> > - Add new patch to test editing a lineedit
> > - Handle the case of an initially empty string
> > - Only check the text objects used by the bootmenu, for now
>
> ... include the 13 part series you asked me if could go in now,
> yesterday?
>
> > Simon Glass (60):
>
> 60 is far too much for anyone to provide meaningful review.

This is expo and no one commented on the previous series, so I'm not
expecting much feedback. But once people start using it, things will
come up.

Regards,
Simon
