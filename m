Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4152C36010
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 00:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C8580F6B;
	Wed,  2 Apr 2025 02:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RyW/ejCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0B481703; Wed,  2 Apr 2025 02:09:12 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B4180584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 02:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so11123759a12.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743552549; x=1744157349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pZUcEP3xORBKOURYA7gMfqwpsJxkqzlbnxLUunmAzIM=;
 b=RyW/ejCOOlu3aukohIMDJl3lu+FUoskM5xyf4yjVwUdl/i20y5pmI9cUDgD04K5/lZ
 HpaawY8GtFcTMjD6Ipq4OnshCrxPWDNJIcDfb3n+EMZ/yhf+Hjf+g32q659vV2WlH8WS
 WtVMZxb+3Xd6ka15y9xzgZ5nUmxkuoUefdCBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743552549; x=1744157349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pZUcEP3xORBKOURYA7gMfqwpsJxkqzlbnxLUunmAzIM=;
 b=UI8d8dIm5GPepz+W1cShVLTIncKrzM7UOHa37JpIthH5/RhD6IamxypqViAn7dd+1+
 ffXFQaI0zCalUvSwRFBwAoLsTG7iyTuMh+JRe2odfvMdb/piFaiF+T6yGbmNh+carGYr
 rXsnzu1IIf5l14KWpqh4zpRq8dQ1+MYeUWwpFpTFc1YvlTx7LR2p+E1tJ3qr7CEpPkX9
 k7gbgsuxV6tZy+PV5x9j4ZiY/oSshFKHhDxmDf5EIXqY16iVtgBLQ2WeORcnh+Lgth8o
 AU8Gl0XHMVU1MFsYhq1L7394m67p5HLGUw3YknbeG+yyAVz1M/RezESV7K6gsK2xFL1z
 NwWw==
X-Gm-Message-State: AOJu0YxTlUWRh1DBNpQEYfiTgVVvX6iInZCu2/nBGNLbL5drihfOIpmB
 AA8WivC7P097Du5VgDtaLFqgIIqcWkjuu/0uit39eag+uojnDe78FCmGIvV7KqmvYggpjEBde3m
 BVMUwJjNJNYEKLfsbN2o/bMJUH1rncm3FjrxY
X-Gm-Gg: ASbGncvL6et8Nz94OxCHdtrjsG9rSiMYSx1iMr4eelld2YsuNtGiJGaJDit/OpPuQ/T
 5rIM+khqTPMyk7aPOY2qpt9eOFxZWDFTwXimC5umES0RC9wNZ2nEtDDhBYIa+RHjYHC2dCE4ZCw
 ebU7MyWS0VXMLo/PAAByrYg9HZzQoZ
X-Google-Smtp-Source: AGHT+IGSi4bRHuMUYkX1ECU/4UfFSxmpJqVrtKn2cJwEkXbbUFT7t7ygziJsSLHNZj9uNa41MjzVQngBoU1NwuxkOZo=
X-Received: by 2002:a17:907:97c9:b0:ac3:3fdf:d46f with SMTP id
 a640c23a62f3a-ac738975de7mr1246811666b.8.1743552548928; Tue, 01 Apr 2025
 17:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
In-Reply-To: <20250401214113.GP5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 13:08:56 +1300
X-Gm-Features: AQ5f1JoEr5bmbgxWmpLcmgtLFClw7cjsSQFXRzm0fpsSTsXrxE99040_pHixtpc
Message-ID: <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
>
> > This series includes some precursor patches needed for forthcoming expo
> > enhancements.
> >
> > - truetype support for multiple lines
> > - make white-on-black a runtime option
> > - support drawing a rectangle
> >
> > This series was split out from schd2
> [snip]
> > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > branch: schg
>
> I get as far as patch 4 before it doesn't apply to -next.

Your tree is missing the video-damage series which adds some more
tests. It is here if you want to pick it up:

https://patchwork.ozlabs.org/project/uboot/list/?series=369663&state=*

I can rebase and send a PR if you prefer.

Regards,
Simon
