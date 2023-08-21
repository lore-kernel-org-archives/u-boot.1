Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BE8EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2737F871DB;
	Mon, 21 Aug 2023 21:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RhXqEdoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 805E6871D2; Mon, 21 Aug 2023 21:13:46 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E489871D8
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d63c0a6568fso3892152276.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gMx4SAEmCOEjypXqFCdH/BNDX1/vIZARR/zYEociwpo=;
 b=RhXqEdoWW/phumjtMZ6oVIIfsHpnZY+nsmeAqb82rsJCcxlqai7RfH9TWpNInLO52M
 gycx9U8pKYiJ+hc0Y6JBkuAkmw5Z5f3Lo/y3QzyDKcK8Fy2XMpp+rzCxsVVzUfjnsrBZ
 QpxzRIDJkxWkAe/2AP3H18Pc94C3UUx30pBhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMx4SAEmCOEjypXqFCdH/BNDX1/vIZARR/zYEociwpo=;
 b=EIXlHiIF8BWKYKaXnoY/hGK7cq8ur9PcF02aRTaKoEpBjSaHclubhXTAuUTVmUuFkZ
 B8B3XSbHvDRCt1VkcY0zF4Icz2Ztp4KAi7wFSypetQMWxyQ9iEW2pdpYcp1vfRw9koTO
 dSzWFhVnePA101vIhaT1JkoQR//GS/qpM9VtPIIcC2O2lhKkoAzbUjV2ZKp0oZjhnyJe
 k+qg0KUppjCz3QmmGFDyTEv1b7Ku7aWSL7Xb3TGu+ElyYNavqEguS4aYyz0QEv5g8X5F
 YS/jmnqBK/txsVPapJLeBH/OGKrrC3A2+tyBVKO0xblT8YGnCSbENJeik1R5I+5dTxsY
 JBpg==
X-Gm-Message-State: AOJu0YxzZGFPipl79+6T5biRAxXBPO0ltHhpqWglLEUFBQKZ5sBUeL/5
 ft/BOsYwxddcz/0+y1+oa0hqrmYPXIOrL4LZHnQsJA==
X-Google-Smtp-Source: AGHT+IEVvHfYOacHVBGBIAhLYpfCDFP69Fhjan2SdnF/CmIsSiJQ0rgd3ECVipfuWc/GSYjqvjU5CjCCqDlxlIU2Ne0=
X-Received: by 2002:a05:6902:18c6:b0:d53:f8e6:8447 with SMTP id
 ck6-20020a05690218c600b00d53f8e68447mr11064045ybb.15.1692645218711; Mon, 21
 Aug 2023 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-4-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-4-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:48 -0600
Message-ID: <CAPnjgZ3Tpz+3EbxnS_qU=vHRyeCx4bT14J75ZP_B5+CiF_5v8w@mail.gmail.com>
Subject: Re: [PATCH v5 03/13] video: test: Test partial updates of hardware
 frame buffer
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
> With VIDEO_COPY enabled, only the modified parts of the frame buffer are
> intended to be copied to the hardware. Add a test that checks this, by
> overwriting contents we prepared without telling the video uclass and
> then checking if the overwritten contents have been redrawn on the next
> sync.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Add patch "video: test: Test partial updates of hardware frame buffer"
>
>  test/dm/video.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
