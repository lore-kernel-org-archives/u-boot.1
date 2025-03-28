Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8689CC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1782F80ECC;
	Sat, 29 Mar 2025 00:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ba6SdiqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DC0805C8; Sat, 29 Mar 2025 00:41:50 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC61181E06
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1c6ff8so5123246a12.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205303; x=1743810103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bnGv7l94dsOs2UPobJodgI1HwuAczd3l7NMRnR+C1jE=;
 b=Ba6SdiqZk4/WFg5SCi3eRebA86YWPRfqbXezxEeJkw0H9B0x20Y1tSvDYmRyI0ORy/
 kN1CNgyvd+m0KkLUDWDnb0WLkkn3YLdAcGp5k12PLo1nr/bTKoSbwFO7OLy9BcKGFl2q
 CMwZhb8rdfnNn9zrG1hiLv1u+FjuXu7rFFQ8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205303; x=1743810103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bnGv7l94dsOs2UPobJodgI1HwuAczd3l7NMRnR+C1jE=;
 b=wm+MTJAY8W19dYCXug2nmMW5EnoXXwtuwf+kIDRplKtqq+8eD6Uc9TXvV7PdHPKgCa
 KjdwzMMPXo+WeXDmWPUy2/aK/ZQjd3DNG3glOLEjjg5ZDELbJQEl3oHL64+BWHykaVfn
 FdmLpeYpnoEctzQtcEwAuxDgBg0hWggoDWgBP9EomAAmgVfPRexZuItD2Opd82dz81Q8
 +ThbCADcgFezCSlSECnMWgrsQ8HV65MeOJRJovvu6JK8obhfkbg71P8oH8OoF2+0ePEV
 mlP0iCS7xj4ISS3JrAFmpp3gI4lF8mKf44rzrD7NF6x4u8xJcz1RiuFNrS5Aj66NtuI+
 9LoQ==
X-Gm-Message-State: AOJu0YzDeBw0+Xw19dNOGeXAFRV21nmsd/oR6kBpi+t9qG3PZVIryaL6
 biNlKMmQKxbBf1qLoqIjTuUfjMby07jRO7yQsMqHGU1S5jtOLLDtXSUotn9mCKzlf3aHFQTSI9y
 kBAMKyiHfkGSqYhhJ8XaDobzRQuMwADxhdSks
X-Gm-Gg: ASbGncuY36L21nI/f5AU+sM3uyspjJvfC0Xj0QnSgRQSDdqo7fYH6PiSHb261aYMtbZ
 4SVMf96NAhgHmS30i4CqdvMWheJ32Qp/dyt7xEYwUeM5YWf0I3y2JblI0I8AXuCYTJ43q0SH6FT
 smMxUvNqk4qUZS6rsafzoS2mZVp7y/40+G3L/sAA==
X-Google-Smtp-Source: AGHT+IFHxwSfHafFDOMtppJdUkLH03CIhiIz3xqvgCyInxwnUQSkG3jOA/nbVzwdO1sMiSakY5dsHoAWepbxCDxYVGg=
X-Received: by 2002:a17:906:8465:b0:ac7:3916:327e with SMTP id
 a640c23a62f3a-ac73916334dmr67861766b.61.1743205302963; Fri, 28 Mar 2025
 16:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250319145512.2391122-1-sjg@chromium.org>
 <20250319145742.GI2640854@bill-the-cat>
 <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
 <20250320142121.GQ2640854@bill-the-cat>
 <CAFLszTgsMu1ZtK1Z-u6cmH6k__0Qhn+G2SPh8w_NdrihLkQ7jA@mail.gmail.com>
 <20250325162420.GI93000@bill-the-cat>
 <CAFLszTj49W-Vk_4xpmvtyFH6AH1QAZTLRM7x1k-Bhz7a3uEuBQ@mail.gmail.com>
 <20250327141742.GP93000@bill-the-cat>
 <CAFLszThJqyEQLvngTdxwqa-fsox5jjHBMYVryo6vPA7k_6jhUA@mail.gmail.com>
 <20250328164206.GE93000@bill-the-cat>
In-Reply-To: <20250328164206.GE93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:41:29 +0000
X-Gm-Features: AQ5f1JoJlHwdztjXsuK2ma-6MnyCth7s_hL8OKlEyHsy-43pFXEHuavibxVjX5c
Message-ID: <CAFLszThoz9D=JRzwrfJmeu0dAZ3R7bNS-5UJ2JfzU4a-qx6=aQ@mail.gmail.com>
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

On Fri, 28 Mar 2025 at 10:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 07:05:35AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 27 Mar 2025 at 08:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 27, 2025 at 07:36:02AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 25 Mar 2025 at 10:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Mar 21, 2025 at 07:38:45PM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 20 Mar 2025 at 15:21, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 20, 2025 at 03:39:26AM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > This series collects together some new features for expo to make it more
> > > > > > > > > > useful for boot menus:
> > > > > > > > > >
> > > > > > > > > > - measurement and display of multi-line text objects
> > > > > > > > > > - internal alignment for objects (e.g. centred text)
> > > > > > > > > > - editable strings in text fields
> > > > > > > > > > - new 'box' object to draw a rectangle
> > > > > > > > > > - highlighting of menu items, rather than just relying on a pointer
> > > > > > > > > >
> > > > > > > > > > Expo's boot menu is restructured so that it is possible to iterate
> > > > > > > > > > through various bootdevs and update the menu as new ones are found. This
> > > > > > > > > > is more in keeping with how bootstd works.
> > > > > > > > > >
> > > > > > > > > > A new textedit object is added, intended to provide a simple text
> > > > > > > > > > editor. Future work will complete this.
> > > > > > > > > >
> > > > > > > > > > With this series the boot menu has a better layout and appearance.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Simon Glass (52):
> > > > > > > > >
> > > > > > > > > I see you haven't internalized the "don't post massive series" feedback
> > > > > > > > > yet. Please, stop posting massive patch series. Figure out how to
> > > > > > > > > logically break things down in to smaller chunks that can be
> > > > > > > > > meaningfully reviewed.
> > > > > > > >
> > > > > > > > I could split this into two series of ~25 patches, perhaps. Would that be OK?
> > > > > > > >
> > > > > > > > I believe no one else is using expo yet, apart from postmarketOS,
> > > > > > > > except the trivial case of 'bootflow scan -m' but I'm hoping that will
> > > > > > > > change in the future. I believe that Linaro is mostly encouraging EFI
> > > > > > > > bootmgr and the text-based menu. That could be converted to use expo
> > > > > > > > but I doubt anyone has looked into that, particularly as grub is being
> > > > > > > > pushed as well. I did look at converting the existing menu code a year
> > > > > > > > or two ago, but it seemed better to eventually deprecate it.
> > > > > > > >
> > > > > > > > Also, there is a following series which I split out and will post
> > > > > > > > separately, but not for a while as I have a lot outstanding.
> > > > > > > >
> > > > > > >
> > > > > > > It would make sense to split expo out to its own series as there's not
> > > > > > > likely to be any feedback there. All of the other parts of the series
> > > > > > > already have something else in their subject and that would be logical
> > > > > > > places to split this up more and then assign to the appropriate
> > > > > > > custodian. Thanks.
> > > > > >
> > > > > > This is the expo series and it only has expo patches, so I believe we
> > > > > > are OK there.
> > > > > >
> > > > > > The bootstd series is small and its own thing.
> > > > >
> > > > > OK.
> > > > >
> > > > > > I can split up the strim() / test series,
> > > > >
> > > > > OK.
> > > > >
> > > > > > but I'm still unsure what
> > > > > > you are asking for with respect to code which is not yet used. I can't
> > > > > > reasonably do all of a) send code only when it is needed by later
> > > > > > patches in the series and b) keep series sizes small and c) keep
> > > > > > series related to a single topic.
> > > > >
> > > > > I don't see why you can't do that. It is in fact really hard to review
> > > > > how useful some library functions you write without seeing how they're
> > > > > used and if in turn we should be doing something different. You might
> > > > > need to defer or break out as it's own some refactoring changes in order
> > > > > to meet 'b' above. However "here is a thing" and "here's using a thing"
> > > > > are still a single topic.
> > > >
> > > > You could just review the code itself, perhaps, rather than worrying
> > > > whether it will never be used? For me, creating and maintaining a
> > > > series through acceptance into your tree is still a lot of effort,
> > > > unfortunately.
> > >
> > > No, that's a no-go. Reviewing a library without knowing how it's going
> > > to be used is not effective.
> > >
> > > > While on that topic, it seems that the sunxi and rpi series have still
> > > > not been applied to your tree. It would really help to see some
> > > > movement on those after all these months.
> > >
> > > I provided a detailed explanation of what's still wrong with the sunxi
> > > series.
> >
> > From what I recall this is that you want Heinrich to do a workaround
>
> Please don't go with what you recall. Please read:
> https://lore.kernel.org/u-boot/20250310155336.GJ2640854@bill-the-cat/
>
> Which is what I promised to do.

OK, so I'll reply there as you still have the wrong end of the stick.

>
> > with bootmgr and bootstd, but you don't want to disable bootmgr from
> > sunxi. In either case, there's nothing I can do here. The series is
> > probably getting more and more out of date anyway. Andre might pick it
> > up, but I doubt it, given all the arguments about it.
> >
> > > The Pi maintainers are still actively working their way through
> > > things.
> >
> > Is there any ETA?
>
> I have pinged them about it.

OK thanks. But that's not an ETA. Raspberry Pi is a widely used platform.

Regards,
Simon
