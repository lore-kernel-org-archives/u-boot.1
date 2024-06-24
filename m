Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E963C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E82882BE;
	Mon, 24 Jun 2024 15:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KnWSaDoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A454087DEA; Mon, 24 Jun 2024 15:38:07 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA23882BE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c2c91c9279so649008a91.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719236277; x=1719841077; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wVjx5WfcWdN3dD7KzQKcDaQgUPehk1R6WwAD73mMII=;
 b=KnWSaDoRdmJBzAkZCHZjQMv01OGAMlHAwiXREx4Qao0eXpFOv0oM5OYypwlYr+6Gju
 9EAHC0WN5BXiibmK+/bWa31iXHxudPb8xs5FYZbi0VxC5392lEUWBXEPzIVvSn1GHRSK
 FubdIkFRilRzRKi1qNBdq9d/4o6gohiOz7Qi0wLKRWrxIxFwEBhuc4YDr9PYBvUyix+a
 xt8oNJSR8LUMlpdSr+m9H3aRrnMHzqjenuA0mTHpBpaMn3MDxnhYjG6TgJE1Nf3CIFOV
 GKbLW57bpaUfMWmj0g56DMLk7LTV5eulZc5QS+UFQkN38g8Sfx29fDQTH/jEEEXf7his
 S/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236277; x=1719841077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wVjx5WfcWdN3dD7KzQKcDaQgUPehk1R6WwAD73mMII=;
 b=Yj/G6tSZcBSxeEGtFKdiJOc7yzYGeIfLPdQvCdmDEmeUwbY5Q0Hxlwi0hKkNJSxZNh
 ri8kXjFmsGwtyKlPcZt25o3azZnJcSuGj1AQ4gXf5t+zGrKCb7VOWDcA8t697hIJsWIK
 gMn8k02FPgD8MnnJwGYzwj8E8Yc3qTYDO3G+n3xw8gnMNuZSIIbJPkQfBYU7FvCWPqus
 KElL9Q3Oosk1Kg5LW58/V65fi/QGP5wcr4auHuSdUoSwFo641ArOn/xy15s/IPhNFo8/
 hiGAHLLHun+f5oCRq/+0rHPAoxYsgxAUAT7/KA8ozlTY6AzQWSkOGkxqdzEdFdRCe1Pv
 Bs7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1iLLu2RFJC7iHLJxPlUE3x5bOBxc+hZjyzYrfK8cBzYvgovsJdPsY5+fjQiUpThaYiWJ5wzmM3pjxu0hUFeHSByr7mQ==
X-Gm-Message-State: AOJu0YzF009o5uQeUWGtTLxyeTCW2x+q6iQ7zawe9I3nmk1eL4k5hQFQ
 XWZVnGU5Rpw1RVXBbUmKSU2QW4UG1lfpFagoAHAyiMr8/2xLgqnSsZS8diBlzCXHC+mUdh8NijU
 F60pN19WfFXnyVJdYuyu8kIY506E=
X-Google-Smtp-Source: AGHT+IG+gau0jUoG4PKbCpqXd89PahKtcO4c4ebXKT1Hv4WUTW5vOgBAtj/L00OPSM45t5QANHke7jl3hjR98Wr7pVc=
X-Received: by 2002:a17:90a:fb94:b0:2c8:4623:66cd with SMTP id
 98e67ed59e1d1-2c846236d22mr5090237a91.1.1719236277498; Mon, 24 Jun 2024
 06:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240610212209.277486-1-patrick.barsanti@amarulasolutions.com>
In-Reply-To: <20240610212209.277486-1-patrick.barsanti@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Jun 2024 10:37:46 -0300
Message-ID: <CAOMZO5D-NbC0n68-WNDuY_-uVTOkhTD_RfqzTLzEhtZ56tB5wA@mail.gmail.com>
Subject: Re: [PATCH] arm: fsl: imx8mn_bsh_smm_s2: Migrate to OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
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

On Mon, Jun 10, 2024 at 6:23=E2=80=AFPM Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Migrate imx8mn_bsh_smm_s2 and imx8mn_bsh_smm_s2pro boards to OF_UPSTREAM.
>
> Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
> Tested-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied to u-boot-imx/next, thanks.
