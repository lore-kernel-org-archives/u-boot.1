Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4D4EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E2B871D2;
	Mon, 21 Aug 2023 21:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b5u55BLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47ED98717E; Mon, 21 Aug 2023 21:13:46 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23657871D5
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d62bdd1a97dso3765817276.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WMUW6TO7s4OLrsUBbRmCbu/zPPoacMK3PJUQrMs8n/A=;
 b=b5u55BLTy7pouY6+gwfhqvLKEDUxrhsRmUV1KahwHSLnEExOvw7yfyqcUYvOdRQCJR
 XvC645v0lf2wIttAFZbgAm6aeJxRaC0TLipkTzbUhBIdbT2vzb9ka9f1mWSq9fNjpcWA
 HIcLhd3+Eq0l008Pdo/6g3TEM6sl3aabVCkhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WMUW6TO7s4OLrsUBbRmCbu/zPPoacMK3PJUQrMs8n/A=;
 b=M853loD69FmvUjVAfa+GsddtPd8eWEasEdsD4ilMGKs5D4K9nK+Gnup6uIGEFtJeHh
 lpy0doXvXLkwiGVQE3x6GWO2ePAeivKu+pyGsmstYGvPeG/+/+DVU6vEjECV0Si3a5LK
 IkTCyA6SrB8Umoe64v0uW34avads57KEIjbAyLmWe0ZSx91WLAJCWGQuAB7NJ99BIRGb
 doU+hkncQmMhafk7o47WKTcUI/JwCjudHa/ETqo5JlnJ2IQjug03tTCyCXQmr8DHkfa0
 Anw87WJZQPZYNdXFZq4gQi2Nq+oZ37XEB3kADEDBElTd5bncEq4i2nGW29nZrbxp0JYt
 m4Kw==
X-Gm-Message-State: AOJu0Yz2nKKPzTheSqml9IvQN7nCbrqpXGSwtKsD1Rm4dhiZvtR+xvtm
 IPZDcJ15xptqCDQbs1dLSFp9HiQqVpHqkzafaHn9vQ==
X-Google-Smtp-Source: AGHT+IHQ8ACty7XUYY5fYJQe5Mv4PycpHviuRMD838wb6yQ8F1vGISm07MO6Fh4CTcLow3LoDqRPk8BR//6tQoK0l5I=
X-Received: by 2002:a25:6954:0:b0:d4c:f456:d558 with SMTP id
 e81-20020a256954000000b00d4cf456d558mr7590941ybc.13.1692645218715; Mon, 21
 Aug 2023 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-2-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-2-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:46 -0600
Message-ID: <CAPnjgZ29b2X0NXWMUXE=FY=3mojzqjPpDgqmJvZNdTBtg8UiYQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] video: test: Split copy frame buffer check into
 a function
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
> While checking frame buffer contents, the video tests also check if the
> copy frame buffer contents match the main frame buffer. To test if only
> the modified regions are updated after a sync, we will need to create
> situations where the two are mismatched. Split this check into another
> function that we can skip calling, since we won't want it to error on
> those mismatched cases.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Add patch "video: test: Split copy frame buffer check into a function"
>
>  test/dm/video.c | 69 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 11 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
