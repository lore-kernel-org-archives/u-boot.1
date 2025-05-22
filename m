Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F3C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFFD8309A;
	Thu, 22 May 2025 15:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gK7DTsBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F22830B5; Thu, 22 May 2025 15:07:46 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 892D78006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-551f00720deso4650354e87.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919264; x=1748524064; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EsFIDHR75JjUnDVfEVKXoC6zvtoK24SL+MdcR67Hl0=;
 b=gK7DTsBcvidQyLikaPcukKf+enSqXaUJqmbXiAQQYfr7+faQOVId8bHUYMKL2qyGM7
 eEfxBLmJcKxAU9qrTVO4CDZ7XEf8rSuRGuYXW93inn2pIo6UQq9RrNrcSeCYwhpZjZj8
 Jx1DUoiVoCJUsdXmHidz4kjc2a/9oPOJheNCzzOvakUSv67N0HwWvOmGwlkbRAbnAFNW
 syfo25f4A0EBV5Pt5WiMFk03P83yht2AK8G5cwVxmgbmOE8p1VRgcOBIiLkWJsSbLRp1
 MKy1EjEuimvK/efARwVYn9pd3LDI5kuMmHQdx8m3e+j3oDLMrw6dWiZgiBljFbaXJMYe
 YnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919264; x=1748524064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EsFIDHR75JjUnDVfEVKXoC6zvtoK24SL+MdcR67Hl0=;
 b=nMaaym/KHqeeA84U/oLlokD3e5SG0E4d/xgrg37M29qqMJUdOcRvR3h9NL7jU3pFFi
 13Odl3Y1x/biCx0RcFpKiJjYr956FxstODUHUHG/AVEt+tyj7uxvV9yeqXEYG/pR/c0q
 X5P6gxgk++PebdWuycj4WPd0K6ZvDzkvr4EhizNbrakwVDK3orJT7toXnDr7WDkrCRaN
 DCzeNAfgsQICxK5aUpkxi9W2XxTpXBJ6D1YjEdQPMQ/vgtTf1kHnTliIdFOA3eXFToZ3
 4z6poxPhSVMT6FL7NlB03iuMD1JuRdebHNeiKdt9+kEY7vse6rJHxfEHTvuFfg/BEccU
 6syQ==
X-Gm-Message-State: AOJu0Yy4a3s6JM5ceP6Uq3NR82/sTb0F/iZBoODqSejhwC9pbjLy+Fw3
 AKHO/BAwrxh/djFSSiwn1GceD3D+X6ebbm7RHm9GknCU4lfp20lpb6/D5qehR0ZzgkJYangSUzy
 8CrAp+XjX+xfF6FKyluysGJvkGUS7mRo=
X-Gm-Gg: ASbGncsvhZ5la7GrzjFlhZGQhuXhp8/yma8qRTj0jprL6s4Bm0by1tx67Ky78eZ53y0
 mS3alTilS1MyPQCfffqBt8j1lno8RlAjXJVQ6CkwvehGGYeQT5w8sIOUBRUbKKOAMtVMH/BGAub
 ZxYfIexbWmrNDhznm+vsZOMnCmVFW83ceMuP7vQvnkYyjCdWzML0EJyYUH0i+L/zSBr2MV2/qLj
 g==
X-Google-Smtp-Source: AGHT+IGosQKJ9ofpuqGBGYSuiaI6IKbnVaOfBPRL2gvRfJW5txTEIqE1yWKDnAZbClk5kO3z9Gc/DxaeFZlmTWJJwhI=
X-Received: by 2002:a2e:a886:0:b0:30d:e104:a496 with SMTP id
 38308e7fff4ca-328097c54f6mr85205331fa.40.1747919263625; Thu, 22 May 2025
 06:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250521094735.1037146-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250521094735.1037146-1-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 May 2025 10:07:31 -0300
X-Gm-Features: AX0GCFtz4lx72kIptY54RfDEosR2gA3N2h0y75S7Kn2z04ILN2eNzq3sdIAISNQ
Message-ID: <CAOMZO5DQEf5w+hHvoh+bUD9yuD+vT5-zaYxyCdSg-c-AVLzPsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] board: bsh: imx6ulz_smm_m2: Match SPL DDR settings
 to DCD table
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com, 
 Simon Holesch <simon.holesch@bshg.com>, linux-amarula@amarulasolutions.com, 
 Michael Bode <michael.bode@bshg.com>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
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

On Wed, May 21, 2025 at 6:58=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> When using SPL on i.mx6 we frequently notice some DDR initialization
> mismatches between the SPL code and the non-SPL code.
>
> As the non-SPL code have been tested for long time and proves to be
> reliable, let's configure the DDR in the exact same way as the non-SPL
> case.
>
> The idea is simple: just use the DCD table and write directly to the DDR
> registers.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied the series, thanks.
