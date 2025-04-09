Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB9CC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D808836C8;
	Wed,  9 Apr 2025 15:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JJujQ97W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F70E837EF; Wed,  9 Apr 2025 15:34:07 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171258297E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so10482134a12.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744205644; x=1744810444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sjgp8KYo+8AjEVBejluQYyG7hsC4DMBLZ/B1Wtyo4js=;
 b=JJujQ97WwVqbtXBmmsEiHPgM97dytQIXhvQ8FfESdXD2Op1/pImnogCCtwYyAqxTb4
 pH34i5RX2SsndF5s14BMNNYIn3l3MWoap7l3h4KR/cFIsolJ2JKxesLfoTkwGEkZ7wIa
 /KjnJde2WJDQXulsIB3xqXst/2PXQ7JzA6tLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744205644; x=1744810444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjgp8KYo+8AjEVBejluQYyG7hsC4DMBLZ/B1Wtyo4js=;
 b=mYnZtrIFJO9yLx1ZCDAxFEsrmSJG+hmUVWqMkXHsCnmhAYImhuAoJ4gVrr99nC/+0N
 nY1AQBwnkoFcnEH4IqTnzymWxndoFd3/pjmELbJP5F0mHHO5pcS9WC//ajPxVwT45Nht
 XrczyBPTVPb8WGbj0EBvcz7wKIXbgpcBTsDpsBneH13KDcz7qa02ExyCrRqMPc2xiD1q
 0/YUKvJLecz+YroCStpHcrjBsP2O9WC5/e5EUQOr1ooZPDX6qJnyPaY5ubnGKJvHqi7i
 eHYMAgmjIMbaF+aD1sANaMMU2SH+sPY5ndXQffnXKfNroeVzXE1qQYp5jrwnaYL35uOg
 QuDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlC5JZYo4weKEAZ5hAeC2U5dT5OBYr74Vovlq32d5uAwSR9pomeKWNorCMQYOQmKqTL/bGVK8=@lists.denx.de
X-Gm-Message-State: AOJu0YzOdt6CBrLiNXhcohaK3o1aVjCmCFNJvgU4NrOaLkPahQ9+Ky6x
 u6AaxUxVg3HWX33UUe24owJpCjN3pNxBuj5o3PxXuLItne7Tgb60Lu4ArM5zqaYo3aQX+m3sEb0
 cnFn6xiB31WJfalpLGVHZeVc4En4Au8Jup4lT
X-Gm-Gg: ASbGncuyRhv5SdYuy2MA3R30PG76slU7IePYbyDs0DyRuGRRSa7/Y72oqNsK25/uH5q
 Zw8kWYTgjU/mVz5d9DUzozuYyXQg7g0jP9rOI/ZexPf/IibuPLh+iQuj5Z570BvdunkTTAPwpEg
 Zu74stEhtzwX9sm3ps/fcJ7SU=
X-Google-Smtp-Source: AGHT+IGjo6yErM1nwqZ0oGI5YbG8A/dm8NFG25YFDZ4X1ZxtNxj9ez3rMg4gilLunLtnoK8Z1akGpDVdAV/yqfgxK5c=
X-Received: by 2002:a17:907:86a3:b0:ac8:17a1:e42 with SMTP id
 a640c23a62f3a-aca9d615aa9mr254850966b.22.1744205644513; Wed, 09 Apr 2025
 06:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
 <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
 <e7ac70c7-676a-4df1-b1bf-5c4bbbc31a1c@cherry.de>
In-Reply-To: <e7ac70c7-676a-4df1-b1bf-5c4bbbc31a1c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 07:33:53 -0600
X-Gm-Features: ATxdqUEM9IplLP66cmR8TeYVVzjYIsUqNdzBRmwYfSXPGLhT1o3h-tVSiuL9Ks4
Message-ID: <CAFLszTgGfXmBrTu4RnSo13WE82W+E-bVrCrif48BbHFxzx-TFA@mail.gmail.com>
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

On Wed, 9 Apr 2025 at 07:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 4/9/25 3:22 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 9 Apr 2025 at 04:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Jonas, Simon,
> >>
> >> On 3/29/25 4:06 PM, Jonas Karlman wrote:
> >>> From: Simon Glass <sjg@chromium.org>
> >>>
> >>> The simple-bin image is normally written to MMC media at block 64, which
> >>> is a 32K offset from start of storage media.
> >>>
> >>> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
> >>> other embedded binman symbols in the output binary is referencing image
> >>> offsets correctly.
> >>>
> >>
> >> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we
> >> know it's wrong before this commit?
> >>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>> ---
> >>> Changes in v4:
> >>> - Drop defconfig changes
> >>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> >>>
> >>> Changes in v2:
> >>> - Move this patch to the end of the series
> >>> - Drop 0x8000 offset for SPI
> >>> ---
> >>>    arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> >>> index fb38b7b80c43..65b81bf58626 100644
> >>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> >>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> >>> @@ -154,6 +154,7 @@
> >>>        simple-bin {
> >>>                filename = "u-boot-rockchip.bin";
> >>>                pad-byte = <0xff>;
> >>> +             skip-at-start = <0x8000>;
> >>>
> >>>                mkimage {
> >>>                        filename = "idbloader.img";
> >>> @@ -178,7 +179,7 @@
> >>>    #else
> >>>                u-boot-img {
> >>>    #endif
> >>> -                     offset = <CONFIG_SPL_PAD_TO>;
> >>> +                     offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
> >>
> >> This is confusing. The documentation states:
> >>
> >> """
> >> offset:
> >>       This sets the offset of an entry within the image or section containing
> >>       it.
> >> """
> >>
> >> My understanding is that it should be relative to the beginning of the
> >> image but this now needs the knowledge of where it will be stored on the
> >> MMC device (via the value in skip-at-start).
> >>
> >> Why is skip-at-start automatically deducted from offset?
> >
> > This is how binman works[1]. We are trying to use the feature designs
>
> Why is it deducted?

Are you asking why skip-at-start is deducted from the offset?

Regards,
Simon
