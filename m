Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DA3EE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE0D86672;
	Mon, 21 Aug 2023 21:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IHLxDVuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF56F86672; Mon, 21 Aug 2023 21:14:05 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4578713A
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-c5f98fc4237so3452037276.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645240; x=1693250040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gh51Q9edqHjazcD4VlSBwWUs6eEWSX3OB6e7HH2lqTU=;
 b=IHLxDVukKIH9SF70UzhN9DEDvJ/A0/cQxZ0G+iLQqSHqeFc1tIMhDPGijVhZYWPYmZ
 ZXHHfZdsc3kmjdGODzVDsHo2J7RjSUq3yPfnWT7CYpXxK9ouVXXvtsThf9NRvgmmC26i
 fGcwM1nYIJMKnuC5dF4K3oMTxi0WWqnN+cOaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645240; x=1693250040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gh51Q9edqHjazcD4VlSBwWUs6eEWSX3OB6e7HH2lqTU=;
 b=Fc1Lf/UDVP/HFKjZth1e7siSF3O1aqsBU3HucQ0DYHmjqY1pClySH5A8HUpBJuSnff
 v4CB1cVRdiO0T3E3S7D7CA0IExzdcL3nVldX0bdjU/sBhMZ5nRrFbQBHAzDvGRlavGyW
 zC3DRLPrE+l6aDCRFDk3o2b6rfbRF/2iik8fN8jmF3HNQfEeBuc5syVkA1uxH7Tr6GNh
 JV6ytOLSfODv98RWjsxqS26hnuH8aOvTrK2CjuRikAd5oCj/hUmNyN4P2c1S86Tkw8Ql
 XKXSFNkO1+3H9mcbDuGDa6njxbNcEdKpdg3rCqwn/vCtuMhJLc5orRLtO5HysPcWPCvb
 ZdxQ==
X-Gm-Message-State: AOJu0YxrCN7AX52RdOKPy9CeKnI7MfgD2rt+IV/a4m/OLF+fpdnFIo70
 dc/TvnQLaA7qt+YxMoYGBFbzYLtVY8SM1GXLS2vUAg==
X-Google-Smtp-Source: AGHT+IFeQrUDp25LtgTjyX80X0IMeUzGGzXNIGbMGuLfVWnohlPcPpRXvEyGBxgTXf87RjPUFh4IAuHNULNfCXp8I9c=
X-Received: by 2002:a25:445:0:b0:d5d:4bae:6fd7 with SMTP id
 66-20020a250445000000b00d5d4bae6fd7mr6851319ybe.31.1692645240458; Mon, 21 Aug
 2023 12:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-10-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-10-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:56 -0600
Message-ID: <CAPnjgZ0KELg5yMJ=Mu9GLWmxyKcWWPphk68Bqi4u36iNwtQZjw@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] efi_loader: GOP: Add damage notification on BLT
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
> UEFI payloads when they BLT data onto the screen.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> [Alper: Add struct comment for new member]
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Document new vdev field in struct efi_gop_obj comment
>
> Changes in v4:
> - Skip damage on EfiBltVideoToBltBuffer
>
> Changes in v3:
> - Adapt to always assume DM is used
>
> Changes in v2:
> - Remove ifdefs from gop
>
>  lib/efi_loader/efi_gop.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
