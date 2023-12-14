Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C797C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A0287B20;
	Thu, 14 Dec 2023 19:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OhqYuiFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C8287B20; Thu, 14 Dec 2023 19:07:51 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A17287B0C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e35405c50cso7452207b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702577266; x=1703182066;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5i3CMkMuu7wbzPqtg/zsvUSwoV2hw/KPP9Szk0Y4H3Q=;
 b=OhqYuiFomFBIle+XAR4qaDflyUbbX+CpdSxFQXmIDD5eZgqX0fdYNhqG5mNywAuwTF
 JIcp7+0F2t94PZbFl0VcZ7vIBs7bIlolvZb/CBkxjpvbtuUJtzdh3LiAM0TpPHEnXrwT
 lXK7rBIVz+d24FWsHcR/iTXFP/ujTBw3JzUvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577266; x=1703182066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5i3CMkMuu7wbzPqtg/zsvUSwoV2hw/KPP9Szk0Y4H3Q=;
 b=d1h576TwmD6Il0ic14xXpNfAMZ/cq6OYzz7h/gVina8UJERSk/usuoxZ1Z5u/xDXZE
 MfY5bOrfbAaE+LgbubOF4wdXsJ0mXA5gioXR7/yUU54C8C26cwhNPPQDL1mhqjcahBfJ
 fvZrudUlhPNitKiAKia6F/OyuCyWP8FsuobH3TwYYfSlmmYFt+dYONOMvb2hAu15SjRA
 GZUPd8PtF9XgE9F+Td7z/LnFxj15fZ3DP+lh9QBOYTvhfAB90gJSHHGYn3H04h3KHzPI
 Ho+O7TjRkiJVo02VTaLH+mfEAzvK1na3ZxhtMoYEg5NPvbVvKLhMR44RPvgd3qSxz3fK
 Qgzg==
X-Gm-Message-State: AOJu0YyDc2PVDnN0NQB0n+iHNqY0RXcmQOkxW+cp5qHPE+fGvsLMgSc8
 jdLxChV4rOV754aTQs+hLkCfBOMVOuI70Jr/Qmz5hfhZw8bllltSaUo=
X-Google-Smtp-Source: AGHT+IFjkNUgyGl3TgneU1lOSUtxW89pyWrLVIUVY4fBUC8v3lHtQEYtFAi99Cgpal/fhradjJrFuNxR/6cRv7qatow=
X-Received: by 2002:a0d:f6c5:0:b0:5d6:2ebb:3b5d with SMTP id
 g188-20020a0df6c5000000b005d62ebb3b5dmr8208944ywf.21.1702577266238; Thu, 14
 Dec 2023 10:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20230912095035.1163945-1-u-kumar1@ti.com>
In-Reply-To: <20230912095035.1163945-1-u-kumar1@ti.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:37:35 +0530
Message-ID: <CAMty3ZC+t32TEdT38_2P0Lb5-b8sbtUBz+vdt4X+pXgcnjSfMg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: cadence_qspi: Select flash subnode at runtime
To: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de, nm@ti.com, vigneshr@ti.com, trini@konsulko.com, 
 Apurva Nandan <a-nandan@ti.com>, Neha Malcom Francis <n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 12, 2023 at 3:20=E2=80=AFPM Udit Kumar <u-kumar1@ti.com> wrote:
>
> Currently spi driver gets flash parameter from first subnode.
>
> Few boards have more than one flash with different parameters
> and selection of flash is done by on board switch settings.
> In such case, uboot needs to be recompiled with updated
> device tree to align with board switch settings.
>
> This patch allows to select flash node at runtime.
>
> Boards those are supporting multiple flashes
> needs to implement cadence_qspi_get_subnode function and return correct
> flash node.
>
> Cc: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> ---

Applied to u-boot-spi/master
