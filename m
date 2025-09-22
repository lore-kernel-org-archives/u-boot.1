Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7452ECAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAA983443;
	Mon, 22 Sep 2025 16:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngZomMWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8577832F9; Mon, 22 Sep 2025 16:22:53 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53E283443
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-36c5527a46bso4854731fa.0
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758550971; x=1759155771; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JvY5g7aBv/Vf2mngQ9o1En0Zax3qNGjIuQ96mrftFA=;
 b=ngZomMWGWzeeZaM4BE5eCRWucRAsbyCtwCrClmDE8OItY0BqEHmoUhsnGOdDcKe9TI
 A0p2nzJurOlj2a0BAhpXJoX3tU4OULUTgkAFo9hShXnz6y3OviwocCuFg4E+S7THnnDH
 agbw+uOXEYHe+MG0uCjSapj5DMuAFhBeKcbl4uNb3A1GT75PAXow3FT669j4IDDEKPgY
 6+sE6/5+Pu7KgiqcGs5fLvnLmNmKop1ONti3bgK93FngJkvR/A75I0NdREtvFu/uYfif
 kfbqpM+03MWh9btepWpo/6o2v9K2Ob9rcj5cfX1TCYRhBhtbkNOjykYR55Y7Tq1PqN9f
 tZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550971; x=1759155771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JvY5g7aBv/Vf2mngQ9o1En0Zax3qNGjIuQ96mrftFA=;
 b=DrTpBQLxrmKFW6VZSmdLoDLLCpc4UO8eKw4E5K8NZVNADEhJUE37n5yh1kcdEx+RhT
 ByVnfxVxpjF4xnk9ETCHqiGsdgFpUSXNUtQEVEv33xen9FGax6kcLI0QdJExtNsaPNnP
 A5rdOaAtAmnTqqpMhpR5B593IkBca+Iz/Rk4SljBRl4kAdIYo8hPYSI0+VmAbvdbghYL
 2An3NijXSHWiYGHCe5rDSH/i8trlL4G+zQHrDia2c1xykcxNp6F3shoKmOmktF6/ih0L
 DR2Fz7N3EhsXsm7Uq7LyjX79twbJpiO0Qlamq5ju8kK+GVevjWlwoiXxyBFRW2vJV/Gi
 RLUw==
X-Gm-Message-State: AOJu0YyJb2MA9RXU4uSMwajS391GE+/FAwaUoYjF4FJ8RT/wt0lUF90U
 mi+RwocXbYSS64t3T0IJPIBTIigySSjaTnMt9qyRTaxvwhRSntpLLBuXGo8AD5aEarScV0H/897
 VXhqphYBnF8nJbJjtLQXc9JP3EzEQZos=
X-Gm-Gg: ASbGncuntbCMHCeOWpK1DXBl7g1TYVjUj+Z6fQuP5w1VhHqiFN7xNSekJOBGyuBTmnX
 KfvGhTs8r9mCgFFBatJJQ+3/kwI2dDa6SitlNJ6cFayCSMFGktaPJtHSNjZsrKFeTSObDK65yUY
 tWr456swetkx8Chdj2B6W4Xeemyum3HBU2jqexLR+KTxIx0swGvErdnDxIyFRG5CH7JHogeExqG
 XPeq7BMEzvui1B/r1Jp+7yRHPY2BGb9mBBzxfs=
X-Google-Smtp-Source: AGHT+IEL4Xb/gCSJ7up2lkIqhwTFwggRJftNXGpZG4L/e57aI5+jvZ6RU5dWYNgAMPT4EYsoOrYhDKCp8Gh8ZKzEXPM=
X-Received: by 2002:a05:651c:2211:b0:336:674b:e8ac with SMTP id
 38308e7fff4ca-36417754f92mr44724111fa.27.1758550970779; Mon, 22 Sep 2025
 07:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250917155932.3096-1-mark.jonas@de.bosch.com>
In-Reply-To: <20250917155932.3096-1-mark.jonas@de.bosch.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:22:38 -0300
X-Gm-Features: AS18NWAzVvOoVUhQek5E29PL65K6Wi6yByDLGUgEdqJ0G4DBvqOz8_Eng-n3zQk
Message-ID: <CAOMZO5DYD7N9d6L2HLoegJgNgsHmkUtPudLXosYwV4xVScp5Lg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx6q: Add definition for missing PWM clocks
To: mark.jonas@de.bosch.com
Cc: u-boot@lists.denx.de, emil.kronborg@protonmail.com, 
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>
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

On Wed, Sep 17, 2025 at 1:00=E2=80=AFPM <mark.jonas@de.bosch.com> wrote:
>
> From: Ricardo Simoes <ricardo.simoes@pt.bosch.com>
>
> Following the work done in commit 7f39ad5a, this commit adds definitions
> for PWM2, PWM3, and PWM4 clocks. Allowing one to use these PWM modules
> together with DM_CLK.
>
> Note that the solution was verified only against PWM3.
>
> Signed-off-by: Ricardo Simoes <ricardo.simoes@pt.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>

Applied to -next, thanks.
