Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5803EEE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5329986722;
	Mon, 21 Aug 2023 21:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ACwzDPRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5BA8717B; Mon, 21 Aug 2023 21:13:51 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F59B871DF
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d71dd633f33so3803786276.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I9l2lf+VGiR7RfTSgv2adKCh/z/cr473s3t2o62ozoE=;
 b=ACwzDPRf5jEknOTG+qHBDULl92hSOo8suobYVfNKrl7roJoEWHh1QvKPzR5y5EXZEw
 RwlN60Zu910BcaLR8FBtfbrAO8TjvyfqbR4yFZUYkk/OSYpAbvnZI5/RQTm94cWeptSM
 fg8T/C0K+0Cefg93vYP69xzvbMWXBAn+6UtRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I9l2lf+VGiR7RfTSgv2adKCh/z/cr473s3t2o62ozoE=;
 b=ajgccSwQ4J4d34hUNSYl4A0p5Y39ian09TYsyxf0Xk7zCRe+c0I75rxkZLpC/PZ38X
 IiDLArrjMgyvk6GchhayEOE/ezqNvYb2WZtCpXqskBwqEOBrp68i5J0Njq+DO52LpOPm
 iy3Go6cBJ5/yEaTTI3xyDtjjbBOV4aizK6rnGsXjPU6SmrC95NFh1FS/Z7zfnToJAdV9
 xO8h3z8fiIncUfw2HaLpc9nflIlpPGUVFwTpOCFTcdbgGI2Cggy+aR8WK8weaujUo/Ia
 EypckzHBogj0K8x8w+bEbj8Z1ecbmWMudsMXPgqQt0MlicqjptO0xFOvDdWSIRUwlMg4
 ZO5g==
X-Gm-Message-State: AOJu0Yy5XZ91DGTguxlHVASIlbPbJpbOSzXBhp2vCnm84JslvixHLI7R
 k1JKq4gt5AAVCjrIsmc0Ay7ZQ9ePvlpztHo6upy53Q==
X-Google-Smtp-Source: AGHT+IEnF+jT1Z3/avsJt1ftzordFasavsoKtdgzgwGOO9+XwOXG2nhzmGg0hq4MzleXC1ghsRkRFbEBjefOMXUg/Kc=
X-Received: by 2002:a25:f81b:0:b0:d15:e204:a7be with SMTP id
 u27-20020a25f81b000000b00d15e204a7bemr7408289ybd.8.1692645218725; Mon, 21 Aug
 2023 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-7-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-7-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:51 -0600
Message-ID: <CAPnjgZ1e89kjsZLndKxh7U02GsfRzw+rhKJvza6LDiq+QahH+Q@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] vidconsole: Add damage notifications to all
 vidconsole drivers
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
> Now that we have a damage tracking API, let's populate damage done by
> vidconsole drivers. We try to declare as little memory as damaged as
> possible.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
> [Alper: Rebase for met->baseline, fontdata->height/width, make rotated
>         console_putc_xy() damages pass tests, edit patch message]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Use met->baseline instead of priv->baseline
> - Use fontdata->height/width instead of VIDEO_FONT_HEIGHT/WIDTH
> - Update console_rotate.c video_damage() calls to pass video tests
> - Remove mention about not having minimal damage for console_rotate.c
>
> Changes in v2:
> - Fix ranges in truetype target
> - Limit rotate to necessary damage
>
>  drivers/video/console_normal.c   | 18 +++++++++++
>  drivers/video/console_rotate.c   | 54 ++++++++++++++++++++++++++++++++
>  drivers/video/console_truetype.c | 21 +++++++++++++
>  drivers/video/video-uclass.c     |  1 +
>  4 files changed, 94 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Suggest dropping the change to the final file
