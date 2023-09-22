Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4E3CD484C
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9976086AF7;
	Fri, 22 Sep 2023 20:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nAe9Qiz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302DF86AF7; Fri, 22 Sep 2023 20:28:49 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DCB586ADC
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59c0281d72dso31115287b3.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407326; x=1696012126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ogBvGG4lXtFbVXPuHsOkdOrcXB6usxzfIA2q2n1J3es=;
 b=nAe9Qiz+pp5RO7OmzhUWTSJ8H0dKCdgHipsOcK71UCZyWAR7oOyJv+nijGm+r6So1o
 lRNZIHQNt655UvtUMmw2OB2mqOweXhnqozlHql1LeN3HHM/BFs8T3GP/s2s8cp0790re
 MG44gccU3PmoNlzaOEJkX7N9CWh/bjYcrwbiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407326; x=1696012126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ogBvGG4lXtFbVXPuHsOkdOrcXB6usxzfIA2q2n1J3es=;
 b=Wt5+7UTb2Yd/mkdvdeWFzORnQTQ78p/x6T4DNjz6MPUFdX0IRwcBVzZx5pXBV0cSEM
 hOyJDIZJPOfLmX45g67U5X4OJwBaGNRkGcOrVsH3okoz/7rhr3KFh4kk4NSE4rw7vy0S
 9eH9DOjScXijvxhzI1+suH4dmnccjAsdvzoY6fM/Qsj4zlRUV3hNG2PjOnoeUiyx3Ie/
 MV5JqOJk1Rd7+ouMIwxvca7FP/Vuk3snCKGpsdj2SFh2BGWyVQ7CfxeyAqwZctoU3qdm
 mVsH3keBna7Dyv7ijrpK7LPHo31vqzyXrFeBRabQQGBlxgBE7CpFutVSINZ8mxi3BfA2
 iHMw==
X-Gm-Message-State: AOJu0YyfakZwwK4hvYpTT5UH/CQtL0OI5VhIjkn/BnKJw3ViAx/6VPVc
 rSUEYOwuarDjh8phewO/v1kNiu3cchkoZHeA1iPVVA==
X-Google-Smtp-Source: AGHT+IHDQoGpo3wyE6GG0qANfGkNgSWJdz6zDo29WPnecTnj2KvIliyZdr3UDfr+022c6OPSbCRBhJyh1yFIQphD6bs=
X-Received: by 2002:a0d:dd55:0:b0:59c:2d8f:1c33 with SMTP id
 g82-20020a0ddd55000000b0059c2d8f1c33mr567223ywe.19.1695407325744; Fri, 22 Sep
 2023 11:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-9-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:35 -0600
Message-ID: <CAPnjgZ0LtGaYh=JG7JrsqWVaoAkLjCp2PLxb9j1CF=o5eq=4nA@mail.gmail.com>
Subject: Re: [PATCH 9/9] test: bdinfo: Test bdinfo -e
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 20 Sept 2023 at 16:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The bdinfo -e should print only the board ethernet settings.
> Test the expected output.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/cmd/bdinfo.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
