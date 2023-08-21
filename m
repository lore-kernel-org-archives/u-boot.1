Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3782AEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99448867C3;
	Mon, 21 Aug 2023 21:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a7iPTYYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A26B80727; Mon, 21 Aug 2023 21:13:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18CC871E5
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bdba622d1cso62209a34.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrvX/+Y+xBV4GzVOui8hB07YDsT+Fy9wVNWzIvOE/QQ=;
 b=a7iPTYYiGFowaVuOPpE0yxIvMMf1LY4mLcfrNzqLoa/EMLhhOQu8UowfkwxXGSkTtV
 2xb0CMT9pf2NHdTP2az5IR/Sk5l2D5L0GWh6HzZObmshKS8GcKiixY7585dSIEIikuHw
 pVsLj6ZEhCiBsu57o7uiTj1/ZMZkVctRtjPyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZrvX/+Y+xBV4GzVOui8hB07YDsT+Fy9wVNWzIvOE/QQ=;
 b=Pp3epr1o3clSy0cFyfsiNEXJqqBmmkEGsN+9BUeEPgxVFzIl2avZzdvStvZiYERLq3
 qc1rO8bzmcRFS/xqcb4szm/BqS25g8pVe63NKwXhFtPxmRgVQ6o4YOAlWMGt/dFJWSj2
 KP2U/yUVZON86KRVHq0YVL24IfJeeAdVldN/AlbnLoTmU1OqxS0T0m+P5V/aKuFZMGlO
 P4X4X+g4iik+i56bWBg+42Nbs6M4yRFHsmwJ85M9KAgPdZEFf9YTwRgJx+EUPzIKN3KP
 p9vhEx88W1jMFWohUYmvVRP5ctCy59dTfA/oxfIRBypaS0arQAHu3ZxoWqAsM6ajDTR7
 HPoA==
X-Gm-Message-State: AOJu0Ywnjq/q5pV7Bl1+KfS0+1gixS8qcriE4Rlh3B1MAOsFXaWm5v7l
 7n4hgN4x+PI8CWEqjJFbn7akIMAv73CXrpkI+/5geQ==
X-Google-Smtp-Source: AGHT+IF73LEANYqP925WGPT78QJlqd/bqVgU6FHI9UBCx8jj0DInYWNHg7FC3HJLATGN7UDr4F+1ZO5UzfhpxRTgmLM=
X-Received: by 2002:a05:6358:7246:b0:134:eed0:3bc5 with SMTP id
 i6-20020a056358724600b00134eed03bc5mr7625388rwa.9.1692645218757; Mon, 21 Aug
 2023 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-8-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-8-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:55 -0600
Message-ID: <CAPnjgZ2HEjkAHXVh4utmnJUh=hE5XxCKorXRGQqkEUptxN_WBg@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] video: test: Test video damage tracking via
 vidconsole
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
> With VIDEO_DAMAGE, the video uclass tracks updated regions of the frame
> buffer in order to avoid unnecessary work during a video sync. Enable
> the config in sandbox and add a test for it, by printing strings at a
> few locations and checking the tracked region.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> This is hard to test because most things issue video syncs that process
> and reset the damaged region.
>
> Changes in v5:
> - Add patch "video: test: Test video damage tracking via vidconsole"
>
>  configs/sandbox_defconfig |  1 +
>  test/dm/video.c           | 56 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
