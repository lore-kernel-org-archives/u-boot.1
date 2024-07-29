Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844A3C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03813888B7;
	Mon, 29 Jul 2024 18:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dMD4tfPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0452388874; Mon, 29 Jul 2024 18:19:29 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EA088863
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7af49e815so22107646d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269965; x=1722874765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PDoqk4dXZCG3nKDFMyXedUWY73W9iKBh1KTJy7NXgHo=;
 b=dMD4tfPYyYSYed+HpRoKqb9SfCZZf7Pfm6GjCXfEJn851t2Tunh3cgCNWY7hFSFelf
 v4kW/NTsftPFUpQ+z3Nr662uFx7Jgxel1LVpTs2odEJnN2leSlPcTSyNdAZbjN6T/CXs
 N+FHEuurXTnCtLYuV9j1vs4Ji4LBx9ZHu7SVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269965; x=1722874765;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PDoqk4dXZCG3nKDFMyXedUWY73W9iKBh1KTJy7NXgHo=;
 b=Vf3wwf+x0OwPzgze78CFzlxy8B+6E4pbh2yOf0y4HrHuftZkHqJ1qWvyJsC4nOANiB
 FWReIdLj9pUfdGJtNdKuCmF1qOZD5dZ08Egak3P3mlWzkiPq9uoYgoHSE95pwPOvVBUg
 NDzeUYw7jt6SeSqy3z9j3wfO6SJEKNhxrtsAlVx6GOcAjvjzFphWEj32WQ6Nz91S4pgV
 RFQWVwVFBSYmxF0W6xMa8MiaABU+TqM2knz71nrt/Lf5gmi3KjUg3R+yos6p9wN3/m+A
 FCDJw2J7Hgj0wkG4iiQRyuPrNZ+DVMcwWGzJJqR7BpZQwr2D1Fy5KvoU+GxeaAphbiZs
 gO2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJMJLNwcjM1YClNaJA8dTlNS2yyIQgS63A3UkA7fLqTBmmPL+9SglJf2+wMXu1KHAgMMbJoF5980XKV7S+bsaDmSvXtw==
X-Gm-Message-State: AOJu0YxJRbAqdyWTsRsbupHC1z3o/F0vBX7xs+tJjoYzvHWwJrvDItXO
 8hMMY/LnCTRMu0LRnMRet3suFdDMsvXGrPVb4Gj5OsZGQ4Ajr+cnQ4vejTOUCOyTx+EogGxcUnp
 YwWpH/MlZq1bEhCouALkYyU/ngFzF8Qw0JiwW
X-Google-Smtp-Source: AGHT+IE+xOhsyBGp/uSmYsSKwVhtZUJrYapslxlc8MrWM69Qwi3oroYx81i1TQHKvz24q7AKsIBYAMtu7eAAOoR1Jq0=
X-Received: by 2002:ad4:5bae:0:b0:6b4:ffa9:c320 with SMTP id
 6a1803df08f44-6bb55a4b58dmr106546616d6.22.1722269965109; Mon, 29 Jul 2024
 09:19:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:24 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-16-sjg@chromium.org>
References: <20240720104950.2730773-16-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:24 -0700
X-Google-Sender-Auth: LxciupMHvIXR6aKTn6QhbK4OEXg
Message-ID: <CAFLszTgvFMZ=8C-zNy2vjeL8Yd6xfK73bnK7fbveJfuMTZOfqQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] binman: Add support for alternative FDTs
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

FIT provides a way to select between different devicetree blobs
depending on the model. This works fine for U-Boot proper and allows SPL
to select the correct blob for the current board at runtime. The boot
sequence (SPL->U-Boot proper) is therefore covered by the existing
feature set.

The first boot phase (typically TPL) cannot use FIT since SoC boot ROMs
don't currently support it. Therefore the TPL image must be specific to
each model it boots on.

To support booting on mulitple models, binman must therefore produce a
separate TPL image for each model, even if the images for the rest of
the phases are identical.

TPL needs to be packaged as an executable binary along with a reduced
devicetree. When multiple models are supported, a reduced devicetree
must be provided for each model.

U-Boot's build system is designed to build a single devicetree for SPL
builds, so does not support this requirement.

Add a new 'alternatives' feature to Binman, allowing it to automatically
subset a devicetree to produce the reduced devicetree for a particular
phase for each supported model. With this it is possible to produce a
separate TPL image for each of the models. The correct one can then be
loaded onto a board, along with the common FIT image(s).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/fdtgrep.py                |   2 +-
 tools/binman/control.py                      |   3 +
 tools/binman/entries.rst                     |  42 ++++++
 tools/binman/entry.py                        |   4 +-
 tools/binman/etype/alternates_fdt.py         | 132 +++++++++++++++++++
 tools/binman/ftest.py                        | 121 +++++++++++++++++
 tools/binman/image.py                        |  13 ++
 tools/binman/test/328_alternates_fdt.dts     |  28 ++++
 tools/binman/test/329_alternates_fdtgrep.dts |  29 ++++
 tools/binman/test/330_alternates_vpl.dts     |  29 ++++
 tools/binman/test/331_alternates_spl.dts     |  29 ++++
 tools/binman/test/332_alternates_inval.dts   |  29 ++++
 tools/binman/test/alt_dts/model1.dts         |  24 ++++
 tools/binman/test/alt_dts/model2.dts         |  24 ++++
 14 files changed, 507 insertions(+), 2 deletions(-)
 create mode 100644 tools/binman/etype/alternates_fdt.py
 create mode 100644 tools/binman/test/328_alternates_fdt.dts
 create mode 100644 tools/binman/test/329_alternates_fdtgrep.dts
 create mode 100644 tools/binman/test/330_alternates_vpl.dts
 create mode 100644 tools/binman/test/331_alternates_spl.dts
 create mode 100644 tools/binman/test/332_alternates_inval.dts
 create mode 100644 tools/binman/test/alt_dts/model1.dts
 create mode 100644 tools/binman/test/alt_dts/model2.dts

Applied to u-boot-dm, thanks!
