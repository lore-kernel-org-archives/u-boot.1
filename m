Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42274C83F22
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A84D8655F;
	Thu, 31 Aug 2023 04:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FkTeFHIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34578655F; Thu, 31 Aug 2023 04:49:31 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216E280702
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7b89ae27d3so159471276.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450168; x=1694054968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ab5v3xQTqog23hxV7qH8oPiHUy/XADxQfdfyqt5fSp4=;
 b=FkTeFHIuLdmtW9tAtTz97andGI9pjAF4KPF0uVgyPSD05axzzemzMdX6rlQUCMTu7F
 FPh6/hR399j64MsJwO930lj2l8yf8zaFO41G1995IMk2HhA4jY+CuEA8Yy+Efd5i+SXr
 5VCF2CVla8BHzXne4Fg7JBnDlrGn4M6+b0MuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450168; x=1694054968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ab5v3xQTqog23hxV7qH8oPiHUy/XADxQfdfyqt5fSp4=;
 b=eXL8TAcP2li6XytwcKQcC91tUD0JmoEzyoabEAPLC59VpGRHpMlhpryJyVAKByAPt3
 M8actRAfFyo4Ktqw60lGqBOwE1fsKMPi5EcU9j7d23KOA03pG9dunoFATt8u1aD53Sxn
 8fqyN5ebHTL4xNubmW8ajdsOGTz8su1DO+/fJkoJGzrLoaTBrsLkmneHN6NzFhq9Sgdn
 IyrlE0s+y/ITORZTKdLrDKLtAjCuskhR0qasSOVCTo1iBqKruVhoXDf3ON6o/HH9gvJM
 onnFD2JS3aOfme4yNMickBa2l2hoUUmA1XivBGikcMVFzYXHtMbIIejAzVSc9pIciVjP
 1WAg==
X-Gm-Message-State: AOJu0YxACD31mje9PnL51qEwgiy1b5s6bAbSLMB911bujvz+JpeTr/pd
 //p8vgeQR+Lt/zLTFPeTV7yZ5FXgnYMAUsOegh7Nag==
X-Google-Smtp-Source: AGHT+IFXUjl0hp2/imbwwK7GNNi6W4ZfBrxrIiu+3+NCJvX771IAduEap3T+36O4cgh7ki4jHpSQGjdrkVMED09mGE8=
X-Received: by 2002:a25:d87:0:b0:d71:8729:23b8 with SMTP id
 129-20020a250d87000000b00d71872923b8mr3677269ybn.13.1693450167630; Wed, 30
 Aug 2023 19:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-5-alpernebiyasak@gmail.com>
 <CAPnjgZ20VRYsP=5S5HJWjR2sNvmOudseHiXUcjnZmDCA=0jfnw@mail.gmail.com>
 <3bae5070-e99a-4179-a59c-833c9a2971f5@gmail.com>
In-Reply-To: <3bae5070-e99a-4179-a59c-833c9a2971f5@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:13 -0600
Message-ID: <CAPnjgZ2EXNJ0-0Yo0ggd8O+h0Vi9bSCsqVO6kMUnE1nzc8L97w@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] dm: video: Add damage tracking API
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com, 
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

Hi Alper,

On Wed, 30 Aug 2023 at 13:15, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
>
>
> On 2023-08-21 22:11 +03:00, Simon Glass wrote:
> > On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>
> >> From: Alexander Graf <agraf@csgraf.de>
> >>
> >> We are going to introduce image damage tracking to fasten up screen
> >> refresh on large displays. This patch adds damage tracking for up to
> >> one rectangle of the screen which is typically enough to hold blt or
> >> text print updates. Callers into this API and a reduced dcache flush
> >> code path will follow in later patches.
> >>
> >> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> >> Reported-by: Da Xue <da@libre.computer>
> >> [Alper: Use xstart/yend, document new fields, return void from
> >>         video_damage(), declare priv, drop headers, use IS_ENABLED()]
> >> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >> ---
> >>
> >> Changes in v5:
> >> - Use xstart, ystart, xend, yend as names for damage region
> >> - Document damage struct and fields in struct video_priv comment
> >> - Return void from video_damage()
> >> - Fix undeclared priv error in video_sync()
> >> - Drop unused headers from video-uclass.c
> >> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
> >>
> >> Changes in v4:
> >> - Move damage clear to patch "dm: video: Add damage tracking API"
> >> - Simplify first damage logic
> >> - Remove VIDEO_DAMAGE default for ARM
> >>
> >> Changes in v3:
> >> - Adapt to always assume DM is used
> >>
> >> Changes in v2:
> >> - Remove ifdefs
> >>
> >>  drivers/video/Kconfig        | 13 ++++++++++++
> >>  drivers/video/video-uclass.c | 41 +++++++++++++++++++++++++++++++++---
> >>  include/video.h              | 32 ++++++++++++++++++++++++++--
> >>  3 files changed, 81 insertions(+), 5 deletions(-)
> >>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > But I suggest an empty static inline in the case where the feature is disabled?

>
> You mean with something like #ifdef CONFIG_VIDEO_DAMAGE, right?

Yes

Regards,
Simon
