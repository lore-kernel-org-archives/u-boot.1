Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A357BC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEB280F03;
	Sat,  3 May 2025 23:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YUhfEFAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2953E80F6B; Sat,  3 May 2025 23:23:59 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEFD80EE5
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f6c3f7b0b0so6323258a12.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746307436; x=1746912236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NG7/oMp850ZcZDNhMsR6sPXtWj6CXWakWGzMl1/wiUI=;
 b=YUhfEFAnegX0elMq+KUb8Lhwz3/s+uaxoI/sz68/a8/cuMX+jDm0z78QBhkAc0nwqq
 Zr6/+sEJJbqN+NwYIhENxUyBgGg68q2ES4xJmfw3S4xzFm9umLcIA2tNjExeTc323hrk
 eZHjJBEkYN/b7i2Ca7hHc80jBVga4a4bq70dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307436; x=1746912236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NG7/oMp850ZcZDNhMsR6sPXtWj6CXWakWGzMl1/wiUI=;
 b=H8I0phi07wGVBSa9NE5NEqpaa+3XPyVmj2/xFCeGvYtymL1nbGuWKk5KDGNWFImnFr
 swRFAORGRVH+ywLXIbmGn+H3ARuYDOhwCW/sL7G3jXXptyr5KJ++66hC0K5m+rDECM78
 3Gh8iEATt5F/dM75pN43dG+GPA4G8L0dAFccO08O4hHJtbEb+xXpBF05sPhUOCeGOKQH
 J6ThUgfzUqzQbYoc/J38rFoO1SBq/g9nvagevhIfHTwmoJrZ7rg+s1mdgvJi2oRDbG4A
 Igf+iEtnXLMa/iwLCxL4skMhJqrldFKtOP/iVGGTU2AwrPWC8Ou2DeU7Nz1Klcf+t6b6
 Kllw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8zvKUW4RtuQXk1XjNBBQ8YE4GiWjPmYCDCBADAEwxZnTGX+bNPa9cHQ9sYMRLdwuKnhoIXbk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+DKsVBHWXTSVJ7RaJY5gBGIa+/WQxn+zmrjnMJPaiip4sa28w
 vW+Qwnlb/GICTTFD9hhqG1s3h3Yr7r2I+Y1Nxr1dHfRrJBf12PMWZLGsz4jpxZGZvyPlGq3ke8V
 XIYJDLusJ7ZUDZ2Sdec6dWRzNsefgtE4sfdWH
X-Gm-Gg: ASbGncsrh1Ojswu4RlgFEwfF01XGVSsLUYAwGCesX1k3b/5WT5mHLw9blJVGlMdbaQJ
 3vzgBYIJZczvsI0PyMFZKT1EhOB198BCUM+HqP+eSPlU4IsxRPfGdSgLmoVlFEoU3jcyrUElSOa
 NX2zlja3ZAW8QHUbskgO7i8KWu5PQHSQrFf2OR1eTLZeede3xqr98YVf8=
X-Google-Smtp-Source: AGHT+IG5woAgKo6DVWcMfPOXcOWDI5E8g9sfERrns1ZChWY5kBIdBUpBeWMC3pMrwbIoLReHfaWmLlAnllSQfC6Riw8=
X-Received: by 2002:a05:6402:3587:b0:5e0:9959:83cd with SMTP id
 4fb4d7f45d1cf-5fa788c0596mr5657898a12.21.1746307436482; Sat, 03 May 2025
 14:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250502144718.313633-1-sjg@chromium.org>
 <20250502150035.GU1261075@bill-the-cat>
 <CAFLszTiic_fp=etd+t8OCiEy8=yWdrwEAp8XNChFecbpXVJ=aQ@mail.gmail.com>
 <CALeDE9N3d+paBv3gp=JnBt5E02XAs0cZjT701h3Yf7fxkWopOQ@mail.gmail.com>
In-Reply-To: <CALeDE9N3d+paBv3gp=JnBt5E02XAs0cZjT701h3Yf7fxkWopOQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 May 2025 15:23:42 -0600
X-Gm-Features: ATxdqUG9f8CDwjn1IZe8zlgKknuhd6fSy-pmKg10p7vzdWn-lOsgADn-IheCrRY
Message-ID: <CAFLszTi8cfRdYks4xHwXVcdVd6yG92iyAYOjfovvWy6JPWD72g@mail.gmail.com>
Subject: Re: [PATCH v2 00/60] expo: Various features and improvements
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Peter,

On Sat, 3 May 2025 at 02:37, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > > > This series collects together some new features for expo to make it more
> > > > useful for boot menus:
> > > >
> > > > - measurement and display of multi-line text objects
> > > > - internal alignment for objects (e.g. centred text)
> > > > - editable strings in text fields
> > > > - new 'box' object to draw a rectangle
> > > > - highlighting of menu items, rather than just relying on a pointer
>
> Each of the 5 sections above should be a separate patch set. A patch
> set should be on a single topic, as soon as you feel you need to add
> the term "collects together" you should be splitting it up.
>
> > > > Expo's boot menu is restructured so that it is possible to iterate
> > > > through various bootdevs and update the menu as new ones are found. This
> > > > is more in keeping with how bootstd works.
> > > >
> > > > A new textedit object is added, intended to provide a simple text
> > > > editor. Future work will complete this.
> > > >
> > > > With this series the boot menu has a better layout and appearance.
> > > >
> > > > Changes in v2:
> > > > - Add new patch to pass in the video device for cedit_prepare()
> > > > - Add new patch to test rendering a lineedit
> > > > - Add new patch to test editing a lineedit
> > > > - Handle the case of an initially empty string
> > > > - Only check the text objects used by the bootmenu, for now
> > >
> > > ... include the 13 part series you asked me if could go in now,
> > > yesterday?
> > >
> > > > Simon Glass (60):
> > >
> > > 60 is far too much for anyone to provide meaningful review.
> >
> > This is expo and no one commented on the previous series, so I'm not
> > expecting much feedback. But once people start using it, things will
> > come up.
>
> Well a series of 6 patches just goes straight into the trash because I
> don't even know where to try and begin to test it.

Yes, 6 is a lot! I'll try to split it up next time.

Regards,
Simon
