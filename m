Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99FDC369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0145D83106;
	Thu, 17 Apr 2025 23:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MrltCJzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD2C830EA; Thu, 17 Apr 2025 23:36:14 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3609082CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so194832866b.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925772; x=1745530572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n8AxwP1XckPZP6wBpWCmPzySX3mflzAuTxJ3etEC6gw=;
 b=MrltCJztMoXsdWCRladYzQa8wOnSzergmAPP65Bu1++8JxTgJZgnv1gcZWSJfGs2nF
 M5LLQY7lXOcNRC84Apw51z2K2XuES7pQQnn+/iR2j0fUXbZnDnbXiAEA8XUhMW4YhZEA
 gg5S8+9hwwGTaqKIPZ++nADHZHKbrMVft3tNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925772; x=1745530572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8AxwP1XckPZP6wBpWCmPzySX3mflzAuTxJ3etEC6gw=;
 b=D8yGi3ptRZAjTLFFfOmbz6atN44uFKBIfDw9iclF7WewNjtbOcKf26Qo3igr+WZfrr
 lKJfhsmLTLIzT9HiwXdaVVOqZsgbhBfxAnLlwWmCktct1xzTSP9d42uhzXfScXgG5Vpx
 iJjFmS0JUQXd/oknmWoJXW38ModLD8/Q/mqK9gwRgd1akBZPWpMGBS24xRZdqCu9Rflf
 d+YWKMKJIcoPJScOe5pTif9PzP59tsUtdbZsj10HDrfNeY2MXRAPYNJkKAZ0CDdPgo0C
 8362sMwxdRmqrAI4kMWWnqJC4KWSk5vT8IDY5Lt2u2Ret+SvevalNSYEMpZV1z5H+629
 wOkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPIgOlQTrTWvyRIUrL1NA/I4w3ZvMcd3T3BkNKpUsoaYvTIaaTIbzZJQokNmE6wUSo84BRLFg=@lists.denx.de
X-Gm-Message-State: AOJu0YwlBs9qrBrtWnIMCaMrwU6EKMm0dL7fI11sbkjBqQsLz50yVy83
 MqBHS9n2jUSzSz7geDjQlVNR8dSDeTckU1CizBbNn7M01tHzslP1UvAd9U/JE3s4u6Gln0MsCI7
 +wfEnRuZ2h90IXlWt1aW+qqNIYxT1kw17XD/3/hxWclAap0I=
X-Gm-Gg: ASbGnctamxHq4++waQfPmdU6IZCFXRHPo8vTSsuFvbsGcZJU5gR8xpbfHRgAqhllyX8
 3dWdogYGto2fI4nVg5/1X+Ydd0xz2VzzwDCy3b2to4rgF67qXXDqPqNDuR6CHQcH3/U+jsws48+
 kmy7ikCifRpTz5DDtqdM1vVkMmKNZH9Pnerg==
X-Google-Smtp-Source: AGHT+IGUOBx1S51SLbwshDsEADx7g7mKMO6QjzGEWsvVJKWXwOxcvQt2F6zkHCtGiHbNGpyB1p97g9T9C9gXpx6AdG8=
X-Received: by 2002:a17:907:6e91:b0:aca:e33d:48af with SMTP id
 a640c23a62f3a-acb74e26190mr24759166b.61.1744925771600; Thu, 17 Apr 2025
 14:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
 <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
 <e7ac70c7-676a-4df1-b1bf-5c4bbbc31a1c@cherry.de>
 <CAFLszTgGfXmBrTu4RnSo13WE82W+E-bVrCrif48BbHFxzx-TFA@mail.gmail.com>
 <53f32547-6758-49a2-8246-72b9046cac03@cherry.de>
 <CAFLszTh0et26pngJK1e6JjeLHaNsm7XDhZn3kfZZc7LBeAt-iw@mail.gmail.com>
 <fbd407cb-e0dd-4055-91d1-0b57b45a180e@cherry.de>
In-Reply-To: <fbd407cb-e0dd-4055-91d1-0b57b45a180e@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:35:56 -0600
X-Gm-Features: ATxdqUGihusd90FqOtjb9jISpKs5xueyoWYn6D8jspZB_ZvftUURn3g-Atoy9OA
Message-ID: <CAFLszTi0tM6NLzK02KQgYecBGCm=pOZjAC2F5zU0JDe_x3F5FA@mail.gmail.com>
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

On Mon, 14 Apr 2025 at 09:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 4/9/25 4:30 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 9 Apr 2025 at 07:35, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 4/9/25 3:33 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Wed, 9 Apr 2025 at 07:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 4/9/25 3:22 PM, Simon Glass wrote:
> >>>>> Hi Quentin,
> >>>>>
> >>>>> On Wed, 9 Apr 2025 at 04:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>>
> >>>>>> Hi Jonas, Simon,
> >>>>>>
> >>>>>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
> >>>>>>> From: Simon Glass <sjg@chromium.org>
> >>>>>>>
> >>>>>>> The simple-bin image is normally written to MMC media at block 64, which
> >>>>>>> is a 32K offset from start of storage media.
> >>>>>>>
> >>>>>>> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
> >>>>>>> other embedded binman symbols in the output binary is referencing image
> >>>>>>> offsets correctly.
> >>>>>>>
> >>>>>>
> >>>>>> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we
> >>>>>> know it's wrong before this commit?
> >>>>>>
> >>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>>>>> ---
> >>>>>>> Changes in v4:
> >>>>>>> - Drop defconfig changes
> >>>>>>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> >>>>>>>
> >>>>>>> Changes in v2:
> >>>>>>> - Move this patch to the end of the series
> >>>>>>> - Drop 0x8000 offset for SPI
> >>>>>>> ---
> >>>>>>>      arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
> >>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>>>> index fb38b7b80c43..65b81bf58626 100644
> >>>>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>>>> @@ -154,6 +154,7 @@
> >>>>>>>          simple-bin {
> >>>>>>>                  filename = "u-boot-rockchip.bin";
> >>>>>>>                  pad-byte = <0xff>;
> >>>>>>> +             skip-at-start = <0x8000>;
> >>>>>>>
> >>>>>>>                  mkimage {
> >>>>>>>                          filename = "idbloader.img";
> >>>>>>> @@ -178,7 +179,7 @@
> >>>>>>>      #else
> >>>>>>>                  u-boot-img {
> >>>>>>>      #endif
> >>>>>>> -                     offset = <CONFIG_SPL_PAD_TO>;
> >>>>>>> +                     offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
> >>>>>>
> >>>>>> This is confusing. The documentation states:
> >>>>>>
> >>>>>> """
> >>>>>> offset:
> >>>>>>         This sets the offset of an entry within the image or section containing
> >>>>>>         it.
> >>>>>> """
> >>>>>>
> >>>>>> My understanding is that it should be relative to the beginning of the
> >>>>>> image but this now needs the knowledge of where it will be stored on the
> >>>>>> MMC device (via the value in skip-at-start).
> >>>>>>
> >>>>>> Why is skip-at-start automatically deducted from offset?
> >>>>>
> >>>>> This is how binman works[1]. We are trying to use the feature designs
> >>>>
> >>>> Why is it deducted?
> >>>
> >>> Are you asking why skip-at-start is deducted from the offset?
> >>>
> >>
> >> Yes
> >
> > It is confusing, unfortunately.
> >
> > When you use an offset (say 0x78000) then normally the entry will
> > start at that offset in the image.
> >
> > When you use skip-at-start 0x8000, its value is added to all top-level
> > offsets in the image, so the offset becomes 0x80000
> >
> > BUT the image built by binman does not contain the first 0x8000 bytes.
> > It is expected that the image is written to offset 0x8000 so that the
> > offsets will be correct when used within U-Boot itself.
> >
>
> I would assume all offsets are relative to the beginning of the image in
> the binary? Adding skip-at-start doesn't add 0x8000 bytes at the
> beginning of the binary file, so why would the offsets need to be modified?
>
> Also, while 0x8000 is the typical address the image can be flashed, it
> is not necessarily where it will be as the BootROM tries a few other
> offsets if it cannot find one at 32KiB offset in the storage medium.
> This seems to me to be a case of "somewhat helps in one case, but makes
> things more confusing in others"? Will we need different offsets
> depending on where the FIT is flashed? What happens for A/B updates then?
>
> I understand that we currently essentially have skip-at-start = 0; and
> that it is bad because it doesn't reflect the actual address, but how is
> that worse than hardcoding a different offset?

It's probably best that we discuss this on a call. You could also give
it a try, e.g. try accessing data in the U-Boot image from SPL and see
how it works for you.

Regards,
Simon
