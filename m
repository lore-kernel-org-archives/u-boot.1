Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5044C3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 07:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56DB18823C;
	Sun, 14 Jul 2024 09:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DuVveDL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21F987EFA; Sun, 14 Jul 2024 09:24:47 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE2E8823C
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 09:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a77e6dd7f72so421791266b.3
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 00:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720941885; x=1721546685;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq/rLAS0uFmsoSsU7MEPXijaIMWzpELVJtjj1/94iDs=;
 b=DuVveDL2EM3+EpIH3yJOMpCj8NTHo7cTiURlE4poeuAFL3+YBdlF7Xn+HP0cNH13tZ
 U8vCESz/qn13pz+DMPPJK3vhfUo7LXazRRj/0JBpTcek4q7FetB+AZlZS91/+qF9jQ1b
 gD2Yl32o0mxKAVA6kXuI5qQb9qQpWnDYUFDLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720941885; x=1721546685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dq/rLAS0uFmsoSsU7MEPXijaIMWzpELVJtjj1/94iDs=;
 b=KralK+kc9SjJwyhK5VFxpG33314gkY+dtJeqR/O3Ubrj0YSwG1u7/zG+XSznYrAy5G
 E6QNKaYILcJchX1KZlp0DblA/6RDToIuTgSoQ06NHuLYsF6N1rhNVH3S/Er2wuit2xdF
 r4Qm3jr2cKRXd/HfhIVC5PqVf9Q3qoqnbhH71pfJpvklB0B8nPyKnJe9/gxQzZAA+2fg
 gKfsVBbt5JkKGOml8siHh4LTySZvKNAyFTJFmFWkUr2JRBd+LsMXAwXyUpp4aMroulEc
 hbqsC/lzSsxyER0cyFGXujwTj3/QWYUSSJ0GqN1mAW8I92RL2GQxVhtMnRHruABm22PZ
 fkHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVAXMF8ztB9blai6HkbYpxyFnWFAq2d4BExm9aIfacZe4SchUcUAL2X6G9Zmp9xCqtclcmtvVAlkP9rgI/je1jW9Nu9A==
X-Gm-Message-State: AOJu0YzKuDswF3l71thfS66CCjpMp/tH/dG5g+V/sTs/83LdaQcEb/Dd
 Bj9NVeAodgAPoK7NxduQx16I0KSvFu+GpRX3Pb42ktaKzpSDycG9tABgAxBKxfD0sqxKUkRvoJJ
 YiJtoFHm7ktIdRb75afpdo3bzCxoS12sbvO3mKg==
X-Google-Smtp-Source: AGHT+IGewKc1vcJ+ipoYLkJjJDobJMqiMhNEoud6ftMByDmqI05lgeXduZx2+9HYrAYQtc9JAOObhORXc5BT1iEmgS0=
X-Received: by 2002:a17:906:eb55:b0:a77:e1fb:7df0 with SMTP id
 a640c23a62f3a-a780b688b3emr1002087566b.2.1720941884706; Sun, 14 Jul 2024
 00:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240421140745.25870-1-michael@amarulasolutions.com>
 <CAOMZO5DbWbsT==bTczp9b4uHuBR6dPsbsHEfoJTugTp4zwTJjg@mail.gmail.com>
 <CAOf5uwnruzdTfsbMqvU9UEnsL0Y5_xWs8tCsGHCTPAbHbxb=rg@mail.gmail.com>
 <CAOf5uwmGtY--s9CNUPVeLYghw=O6+DCpaPUJoBrJnWKkXR7CoA@mail.gmail.com>
 <CAOMZO5A_j993PXvBMK3CZvOC+A6CLsyO__gihEfGZcwoFAHdGg@mail.gmail.com>
In-Reply-To: <CAOMZO5A_j993PXvBMK3CZvOC+A6CLsyO__gihEfGZcwoFAHdGg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 14 Jul 2024 09:24:33 +0200
Message-ID: <CAOf5uwn_K1fHVo_10eU2AaCycLd1J4aUf6dGv4RjigbdBP6yfA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mn: add video clocks support
To: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

Hi Fabio

On Mon, Apr 22, 2024 at 1:17=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Michael,
>
> On Mon, Apr 22, 2024 at 7:36=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > Are you considering if I wrap properly with VIDEO IS_ENABLED?
>
> I prefer you resend this patch as part of a complete series that adds
> panel support to an imx8mn board target.
>
> Otherwise, if this gets in as-is, it will become a dead code, which we
> want to avoid.

You can find here how video series is going, I will post it soon

https://patchwork.amarulasolutions.com/project/linux-amarula/list/

Michael

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
