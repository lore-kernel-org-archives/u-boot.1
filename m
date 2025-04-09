Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61852C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5AD4837C9;
	Wed,  9 Apr 2025 15:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TylUYHif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BA483811; Wed,  9 Apr 2025 15:23:14 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED08836C3
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so909351166b.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744204992; x=1744809792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RD5pmmo5iHtUnBTfT5WVmB1JndLrnkgiAZCezmMIq0Q=;
 b=TylUYHifzJlagP7sGl2nAXM+FiLnJmZph/wM/hbjY3SFDsPW7HrCIRgjAUYoVur+/U
 juYcEHqg1PbdB8kzhWXJz5Zor0x3aHx9k5bRyT8zY3hIRxYkDLToFkXUI1wP+e75dILb
 PWWiIpnVMpAx1GQMSzTwfKv8ZtfGFzf5cdPB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204992; x=1744809792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RD5pmmo5iHtUnBTfT5WVmB1JndLrnkgiAZCezmMIq0Q=;
 b=YkSJw8KxQQRP3Z7Khi4jFzygNwNyGHImWIrq5yzIL4c6xXRKJpsVABVmQrr5WXgQEG
 gZPFHGta0tXjnGZ/xFPpEVsjaGCAb93ER1ljlyyIGUwo6+6c9fI7M1hBfeg1iH4XtJhO
 AQTF/FigAvWhA1qo9MZJK1UE2r2af9wIN1kwKVcYKoMLFgHEBCBAtfpZZZS2l2Tmh3IQ
 lEoVgWwxo3NeIRY4QlhhXv2SIqe1B/4SFn6Wre1Fr+/o0FR2i9/qttTXnq53y/tE4jPF
 OnR/hPmMJYNbizjs0qGHFGxAT0KmZ0BkpEEWdaLUXBJESwOMyTEBT/RJPcz0/Fp9fnnP
 QjIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ulKbv8QsQbm87f945aguSgKcJq2dufz/0k8+NPNik4tCivHIYP5pJL/JYT5JxnMhVP2t+SY=@lists.denx.de
X-Gm-Message-State: AOJu0YzYxVpwEKEnLHZdZQY4qRENCJxb12mq+F9tpYe/4daLwcM35LqI
 dZ77of0/+4Pf4nUsdnzHNvtVDyn3TMxUDeMbUpvZ3TLrrCuz2WKlhHMkkxLxW4t+oPzIOvZxVq8
 kwK00xBVmjiGSOZBdRVnwSwJmk+AqOkrYEN2wGWpiN0NHjtQ=
X-Gm-Gg: ASbGncsnp7lb75jTPZqquSO0mQPtnfqDuRMIM7+eeL5FJ+OYXJdwsBkkXFEZtQc/GZJ
 2PKpsnScp9GpUaU7U+b2v+lyI/AHp0OzibVzA4dwIXu3/ou9iaRe+oAjV55AAHwXXqkHUVXKdOx
 0tg/K4fRbJvMZ10H28A6lu6tU=
X-Google-Smtp-Source: AGHT+IHfMGZod3wyviAi2Xk4UdeGzG1CZwZzF8ye41nGgaoahBFju72rAyxMQjkHV+OCIPVX+XfyaQxup4jUYyp8CRk=
X-Received: by 2002:a17:907:3f8e:b0:ac7:3918:752d with SMTP id
 a640c23a62f3a-aca9b7350c2mr258590466b.58.1744204991470; Wed, 09 Apr 2025
 06:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
In-Reply-To: <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 07:22:58 -0600
X-Gm-Features: ATxdqUEPf2GhfLz7AcGOrhi9pDQ3BGNwvc22ykti-U5ZfalU-Vb9-PbL9pQE0Q8
Message-ID: <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
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

On Wed, 9 Apr 2025 at 04:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Jonas, Simon,
>
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
> > From: Simon Glass <sjg@chromium.org>
> >
> > The simple-bin image is normally written to MMC media at block 64, which
> > is a 32K offset from start of storage media.
> >
> > Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
> > other embedded binman symbols in the output binary is referencing image
> > offsets correctly.
> >
>
> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we
> know it's wrong before this commit?
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > Changes in v4:
> > - Drop defconfig changes
> > - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> >
> > Changes in v2:
> > - Move this patch to the end of the series
> > - Drop 0x8000 offset for SPI
> > ---
> >   arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index fb38b7b80c43..65b81bf58626 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -154,6 +154,7 @@
> >       simple-bin {
> >               filename = "u-boot-rockchip.bin";
> >               pad-byte = <0xff>;
> > +             skip-at-start = <0x8000>;
> >
> >               mkimage {
> >                       filename = "idbloader.img";
> > @@ -178,7 +179,7 @@
> >   #else
> >               u-boot-img {
> >   #endif
> > -                     offset = <CONFIG_SPL_PAD_TO>;
> > +                     offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
>
> This is confusing. The documentation states:
>
> """
> offset:
>      This sets the offset of an entry within the image or section containing
>      it.
> """
>
> My understanding is that it should be relative to the beginning of the
> image but this now needs the knowledge of where it will be stored on the
> MMC device (via the value in skip-at-start).
>
> Why is skip-at-start automatically deducted from offset?

This is how binman works[1]. We are trying to use the feature designs
for this purpose (dealing with implied / missing chunks at the start
of an image). At this point in the series CONFIG_SPL_PAD_TO is set to
0x78000 I believe, so we need to add another 0x8000 to get the offset
that binman uses.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/package/binman.html#image-properties
