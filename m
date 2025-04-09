Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A94C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13788384B;
	Wed,  9 Apr 2025 16:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VmGgIqq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C24F83852; Wed,  9 Apr 2025 16:30:18 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF0A83844
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so1122005666b.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744209015; x=1744813815; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PBcdjyZAi8RyconPOuNtb5gp+BRXXw2EA6Xq+JCEPwA=;
 b=VmGgIqq9tumidhnJY0QVCRRPSbm9U+x1IH+KISDO+FAHXSk+rvioyQVgwN/oJJKbda
 GxlnPmZ+SdKsZ7QQTEODvDgJf2Ykn35DqpAnEvkKpe4Ykz4TXHcfOFPvAocPP53yS+7p
 j25tKy5UnBrfS/KrvojM8MEReCtdvYlZSvURk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744209015; x=1744813815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBcdjyZAi8RyconPOuNtb5gp+BRXXw2EA6Xq+JCEPwA=;
 b=j2ULaUGJ7B1zb8MauPVgdY6q3ye5Fw583gf3PeVbBO+xL4XFORIW+WiWUZz0Jhh0+8
 Ss9/MmB/mRbrttwlTkO3FzYbsOAU7T5LpUEya78L/lqjqAnGRUPSIyqbktDpjbJEMIZ0
 74Bqkt9Z7/3ZWrVwO6M3v37RgeDiMwSLo7Gi8OsqS281/Os0Tt5h9PMt+Q2Xbe9tGOIn
 ssqjjh1cAaQHJIAgMLBR0miVDqzUZ9Fg+lvOCc4Ba5By6WC/iCqxSRzEymzsd2o3dV4E
 k1elBTY3f3yp1vfQbczajOAgqjYad9rd5m5bv/BjNIzH3si7eduVlH8Wt4NSld0BhRcO
 qr/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQh3xC4mgZV0qWVz8EQei2lJqiPF0u+db8pgOex6MTVJE+duJ1O4oSWHMvqDMb1Wxx6B5FnYY=@lists.denx.de
X-Gm-Message-State: AOJu0YzgBDtAXU0XCIINg5lxzZ/FUvSQlYdKabZQ3+ho+RzHL32ksMi5
 CNpIxMNqWOMiN1K7IilauyDb9dL3DkkZpJyrtiH7for1gSBnlfFDGJE6JxzzkqzTox+xDyaB4cO
 S8Yo+b4z1+ZC+5XUQ8R32VlPXGRIEP9KINcYPIgv6qcsgOys=
X-Gm-Gg: ASbGncspGtPYzPKmTNg59WjStokao7T+OtwLHM9QHDm7oCx6u9s1Q/8UQ8aP51mU6Fb
 68qL7te85NztQE8PM4mD/IZrGre6QOwh9Liqgkf8N7NMD+PW0UbcGx7icfIsKa3jNBySR/3+Z4H
 ooCn+Uh/e+qlbkC4DU4kG/bPs=
X-Google-Smtp-Source: AGHT+IGUgOrJ/UhFVxCY2oM0Rr4wipChadCdJLGbSflF4l8WHLpk5dKbwtbiEXwCz+jVszmDwLZcorawfIgXvyVfFGc=
X-Received: by 2002:a17:907:1ca5:b0:ac3:8aa5:53f6 with SMTP id
 a640c23a62f3a-aca9d61854cmr330056666b.24.1744209014599; Wed, 09 Apr 2025
 07:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
 <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
 <e7ac70c7-676a-4df1-b1bf-5c4bbbc31a1c@cherry.de>
 <CAFLszTgGfXmBrTu4RnSo13WE82W+E-bVrCrif48BbHFxzx-TFA@mail.gmail.com>
 <53f32547-6758-49a2-8246-72b9046cac03@cherry.de>
In-Reply-To: <53f32547-6758-49a2-8246-72b9046cac03@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 08:30:02 -0600
X-Gm-Features: ATxdqUGXKETSA0-Lw5vlwZ6YnZVqQ8BlFqzqywZO6mjCoC29GYwrJg6i4K7S7H8
Message-ID: <CAFLszTh0et26pngJK1e6JjeLHaNsm7XDhZn3kfZZc7LBeAt-iw@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
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

Hi Quentin,

On Wed, 9 Apr 2025 at 07:35, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 4/9/25 3:33 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 9 Apr 2025 at 07:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 4/9/25 3:22 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Wed, 9 Apr 2025 at 04:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> Hi Jonas, Simon,
> >>>>
> >>>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
> >>>>> From: Simon Glass <sjg@chromium.org>
> >>>>>
> >>>>> The simple-bin image is normally written to MMC media at block 64, which
> >>>>> is a 32K offset from start of storage media.
> >>>>>
> >>>>> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
> >>>>> other embedded binman symbols in the output binary is referencing image
> >>>>> offsets correctly.
> >>>>>
> >>>>
> >>>> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we
> >>>> know it's wrong before this commit?
> >>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>>> ---
> >>>>> Changes in v4:
> >>>>> - Drop defconfig changes
> >>>>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> >>>>>
> >>>>> Changes in v2:
> >>>>> - Move this patch to the end of the series
> >>>>> - Drop 0x8000 offset for SPI
> >>>>> ---
> >>>>>     arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
> >>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>> index fb38b7b80c43..65b81bf58626 100644
> >>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>> @@ -154,6 +154,7 @@
> >>>>>         simple-bin {
> >>>>>                 filename = "u-boot-rockchip.bin";
> >>>>>                 pad-byte = <0xff>;
> >>>>> +             skip-at-start = <0x8000>;
> >>>>>
> >>>>>                 mkimage {
> >>>>>                         filename = "idbloader.img";
> >>>>> @@ -178,7 +179,7 @@
> >>>>>     #else
> >>>>>                 u-boot-img {
> >>>>>     #endif
> >>>>> -                     offset = <CONFIG_SPL_PAD_TO>;
> >>>>> +                     offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
> >>>>
> >>>> This is confusing. The documentation states:
> >>>>
> >>>> """
> >>>> offset:
> >>>>        This sets the offset of an entry within the image or section containing
> >>>>        it.
> >>>> """
> >>>>
> >>>> My understanding is that it should be relative to the beginning of the
> >>>> image but this now needs the knowledge of where it will be stored on the
> >>>> MMC device (via the value in skip-at-start).
> >>>>
> >>>> Why is skip-at-start automatically deducted from offset?
> >>>
> >>> This is how binman works[1]. We are trying to use the feature designs
> >>
> >> Why is it deducted?
> >
> > Are you asking why skip-at-start is deducted from the offset?
> >
>
> Yes

It is confusing, unfortunately.

When you use an offset (say 0x78000) then normally the entry will
start at that offset in the image.

When you use skip-at-start 0x8000, its value is added to all top-level
offsets in the image, so the offset becomes 0x80000

BUT the image built by binman does not contain the first 0x8000 bytes.
It is expected that the image is written to offset 0x8000 so that the
offsets will be correct when used within U-Boot itself.

Another way to think of it is that skip-at-start doesn't really change
any offsets; it just creates a hole at the start of the image. If you
didn't use skip-at-start you could manually set the first offset to
0x8000 and use dd to skip the first 0x8000 bytes when writing.

This feature was added for x86 to handle memory-mapped ROMs, but it
has proved useful for other cases now.

Regards,
Simon
