Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99471EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E66987075;
	Mon, 21 Aug 2023 21:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YOdkDu7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261B58664A; Mon, 21 Aug 2023 21:13:54 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97720871CB
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-bcb6dbc477eso3630230276.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645213; x=1693250013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FH3eOxQscQ5CAcOn0+VC0pA6Dmlur/T4lBfA3IEN4wo=;
 b=YOdkDu7ViaDsC5BZPnPn1WC/Ng+P/Fr8bvL3mLJ6CZDIKNlF+AWggY0MaZAp+NhKO/
 q3Eoa7FhYyGHmq7mJfF2TAAIrOQMrap3gMd3iOMTH2kxS1nTdGO8eYjLWHJqA5r4cebD
 w/+E0a2dUeNxIxoUht9qbdas6hnQyxgd3AOOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645213; x=1693250013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FH3eOxQscQ5CAcOn0+VC0pA6Dmlur/T4lBfA3IEN4wo=;
 b=lYRbVvXJE4AArJi1gRr4o8uKrKv7DsG/0PbHJuEG9HQfkoyzfM4AFAphP3fJ2TOvMW
 ZDpR4aelwzdxCZGiFNYKOBL4MF5hufffMvEoNPsXIv20EphVlWv6qbAL1Fv9e+lTIA2+
 skrOcwiwqxrshqwQI1ZFv+mc/oD4RBbEuQIChDuY8TcJdmFI+3BUxcgv9gXdgrwVVfDY
 rtaiZw6g+grAxsvJXUAWWg090vcIIVR2yDsCyy/dxwdQNNlWqnhb9DvdusAFSNps4EEI
 2ccLYmQOeiUV882lx11AWWm1VJIXb/bzoYz9Se8ps2dAuDExBz6lTCC3kMS1qiDfR8CO
 p7eA==
X-Gm-Message-State: AOJu0YyyvQoo3r0GklwRdyfIHOiG32VUrPnRDvRO3KZllmOycmL9+1AK
 DI9I6eE0sWaVTiJKE3/mWjwXfCrgzEJZNWiO9dMUag==
X-Google-Smtp-Source: AGHT+IE7suHGnf0gmADvcf8XCIbakY8DW6RMnsLPMiGUm8Q8Uz3Olc8CbsWIlctiQlhOphLfBnREyw9QyMVEkJC8WXk=
X-Received: by 2002:a5b:dc3:0:b0:d62:bc43:426e with SMTP id
 t3-20020a5b0dc3000000b00d62bc43426emr7076775ybr.43.1692645213133; Mon, 21 Aug
 2023 12:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-5-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-5-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:50 -0600
Message-ID: <CAPnjgZ20VRYsP=5S5HJWjR2sNvmOudseHiXUcjnZmDCA=0jfnw@mail.gmail.com>
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

On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> From: Alexander Graf <agraf@csgraf.de>
>
> We are going to introduce image damage tracking to fasten up screen
> refresh on large displays. This patch adds damage tracking for up to
> one rectangle of the screen which is typically enough to hold blt or
> text print updates. Callers into this API and a reduced dcache flush
> code path will follow in later patches.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
> [Alper: Use xstart/yend, document new fields, return void from
>         video_damage(), declare priv, drop headers, use IS_ENABLED()]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Use xstart, ystart, xend, yend as names for damage region
> - Document damage struct and fields in struct video_priv comment
> - Return void from video_damage()
> - Fix undeclared priv error in video_sync()
> - Drop unused headers from video-uclass.c
> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
>
> Changes in v4:
> - Move damage clear to patch "dm: video: Add damage tracking API"
> - Simplify first damage logic
> - Remove VIDEO_DAMAGE default for ARM
>
> Changes in v3:
> - Adapt to always assume DM is used
>
> Changes in v2:
> - Remove ifdefs
>
>  drivers/video/Kconfig        | 13 ++++++++++++
>  drivers/video/video-uclass.c | 41 +++++++++++++++++++++++++++++++++---
>  include/video.h              | 32 ++++++++++++++++++++++++++--
>  3 files changed, 81 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But I suggest an empty static inline in the case where the feature is disabled?
