Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EBFC47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487DA87D5D;
	Mon, 29 Jan 2024 13:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iipkR/2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F04B87D64; Mon, 29 Jan 2024 13:18:25 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AAB87DB6
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-602d222c078so27146777b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530699; x=1707135499;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xQ6keAXiAAfXz55E8IezYXxK/i5mbzcjWgkY6wUg2M=;
 b=iipkR/2Jk2csC1rJNmhraShmS21j26KhccmjUyTX+JL3Qb0ATINiBjH4gNoMlPJzuo
 OyyaHEo/TYMg2r8QnCWcO+jU9Bsv8ZcigEWn4muYpHK38gDtcxBr/rsWaphsSVg2MTuS
 NjhKgx8buty1H/uGK0idd+TeUOKJKeW53jxIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530699; x=1707135499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xQ6keAXiAAfXz55E8IezYXxK/i5mbzcjWgkY6wUg2M=;
 b=jvE73ATPDLB0sP54UotJSmrsss+cBEyNj9bB23RjGSnoDL1pTGXlvPaKt+lEUr/cyJ
 Hjj1yvrG73uvEmsEY5SUsUg5jWWg+ccUJCvablZ1IBguHKqbBMbAk4QZpvGbIbQnn5Mw
 cGLqIEYVo2YQdN5KC0SBZfFX6co9L56o9oBm0UdEjaN/T8uZ+Q+Z8XmMyXvRHvaFyF6X
 E39eGmbe51aZsMVfSjQSm9cKsDjUm39zP9agygwbiXAAao1dOg2m0rpChVh5GzW5rvTm
 4IlsTkR6BUT872qZfhiYxuIXzBW2V790tWmwSpF1qtDIs9gN50aBMsIUoi0Um5Lvtp0i
 jM+Q==
X-Gm-Message-State: AOJu0Yww6yD6LqnKDzNdeiMKLcKSgrFtdnDqG2CRO+jlo213OImt5Ic9
 MhnSvLsAUaBHTEGMXmL9BD3C1rKCBGdzFIuIrEWg7Jnpc2wzPIjWFZqbCnb/Zv1xwPPx1Z+tgSG
 IASBvWdmBI4iCDQNPnHfaEwkB5xskEChAAzvaag==
X-Google-Smtp-Source: AGHT+IEyKsfR1/rW0r5/0EY9IYQmeZz532l6Ee9R2FJ+a+G4skc7AikzPaumEcw8Ike3SMskt0XqUHv+KGxq9NjQBaI=
X-Received: by 2002:a0d:d688:0:b0:5ff:63e0:885b with SMTP id
 y130-20020a0dd688000000b005ff63e0885bmr4171203ywd.76.1706530699273; Mon, 29
 Jan 2024 04:18:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <1e205ee9275691afdc41129009a18dd715e6d1f2.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <1e205ee9275691afdc41129009a18dd715e6d1f2.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:48:08 +0530
Message-ID: <CAMty3ZCYGe6v1TbxS5LvjAVA=AEmfuAFuu6PSViRJQHbnKmLOw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt
 ID
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:17=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> Infineon(Cypress) S28HS02GT is 1.8V, 2Gb (256MB) NOR Flash memory with
> Octal interface. It is a dual-die package parts and has same features
> with existing S28 series.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
