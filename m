Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BFDEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80E4871DD;
	Mon, 21 Aug 2023 21:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b9lpHhJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C4087180; Mon, 21 Aug 2023 21:13:46 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35140871DB
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d45caf42d73so3663364276.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wrHPGPV+rJ0zVUExLA2bPtPFKxsZ1tfddRhCzAQvQDw=;
 b=b9lpHhJE/mYtNcE4zAx/3kFf0oa9jJSlumD2iUc3hIsM7LnYKhz92Lix9luQdZYDwm
 6I8W/vfyIABAS+RiImGMo6eJWxFZv0Z43qCFqTdhg/1aBNfccVQdi69WJ+7uDSGbIK2/
 HZWJVwBX5vknWNbOLQCQNpBXlGGkhFLINWlgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wrHPGPV+rJ0zVUExLA2bPtPFKxsZ1tfddRhCzAQvQDw=;
 b=GGf/r82Ia5GbIcX0DwGjxKqlpMvl074f91jqrC/lCFEiA22OF6926Wm4NppdNpUDxg
 5KdRWRyrNBg+uOkF7M9Bl7ySsqJhSg5dmPqtxbAOM8M95nvs+5u1roBr7A/coaMnwt6G
 X93/rFk8cWdFYLquxDdDer6sFFrdbeqeiRhIfRZTAGdX9DIOHpJDWZOZUKGGrYK/rPWQ
 nU3LV6JqkM5U+qPmk7YKj3YNZrMLIRBRzhaPB5QXGUjcR+zt9Mt/5oayGsp1KQkKxsOp
 KpmqzaUtfHqxcseY40yfZ1OBFobfIYnBZrot0Dt34d2bwKZB/5PO0+hH8XCGT3rfxXr+
 7+HQ==
X-Gm-Message-State: AOJu0YzVh6EoCQ24/s3RBBqE9S0wgXLvaPYbc3qiwhc77FPt2FAfSG3g
 OGj0pzLYtI87N+21mUGJdf62YVsBYafv9MBud9Im6A==
X-Google-Smtp-Source: AGHT+IHUSWDesZbAxqSOnsa4OXjDVG6/61Y8rTwnQJnak052erAbLStEX39cLZAwcROdtMdPCdncwprS9FU6Z/+hluE=
X-Received: by 2002:a5b:c0e:0:b0:d23:d12:edf5 with SMTP id
 f14-20020a5b0c0e000000b00d230d12edf5mr8140214ybq.44.1692645218723; 
 Mon, 21 Aug 2023 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-11-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-11-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:57 -0600
Message-ID: <CAPnjgZ2_9s_n9RWO_t_UUJWK1uvjDQSHikpMg7VbpmCn9uuk5g@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] video: Only dcache flush damaged lines
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

On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> From: Alexander Graf <agraf@csgraf.de>
>
> Now that we have a damage area tells us which parts of the frame buffer
> actually need updating, let's only dcache flush those on video_sync()
> calls. With this optimization in place, frame buffer updates - especially
> on large screen such as 4k displays - speed up significantly.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
> [Alper: Use damage.xstart/yend, IS_ENABLED()]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Use xstart, ystart, xend, yend as names for damage region
> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
>
> Changes in v2:
> - Fix dcache range; we were flushing too much before
> - Remove ifdefs
>
>  drivers/video/video-uclass.c | 41 +++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)

This is a little strange, since flushing the whole cache will only
actually write out data that was actually written (to the display). Is
there a benefit to this patch, in terms of performance?

Regards,
Simon
