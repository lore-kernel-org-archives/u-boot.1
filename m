Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7FECCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7BB83642;
	Fri, 31 Oct 2025 02:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E2QTUwX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B543838BB; Fri, 31 Oct 2025 02:52:13 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB568331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57f0aa38aadso2536851e87.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875531; x=1762480331; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLLe60NhUNSDONqy5ljYXBEG45p0zltv+2O2aK4yQdo=;
 b=E2QTUwX70aEGepQwfT+XPZeO85GuyfoXAfAcYKwOy2We+sy1+O56L7mcwH9KbWBKQ8
 ny0rM9RDEVGkD4w9woxtE4LC5clXZ3egiAebLaJtOpteQvVuLSvwQgttHLETq5s1CGwH
 gMPziHmwN8iukeWQJXGnjxnOC3nRBUlTXGWr/rs/UZHJp3W9aDuvHYZT50fx+/cq92lq
 7avlhHYsqYvsIeX/F/X89IPI6VGxbdWrATouTU/eVj0/H8Uo2Kx0ZERKAenMHY1blno9
 /qG6jJn4/LjUH2bYDeQeax0jkB3yGu1p4cHwEf0aeUt4Ow/arB5snG8r+ZeEFXqBysFd
 CkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875531; x=1762480331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLLe60NhUNSDONqy5ljYXBEG45p0zltv+2O2aK4yQdo=;
 b=aWHE1JQndehlqMiUiQgksL5a+ad8ONKjFvAZ8o1hC0a0ECkoD76UhdmXNrv4F0a0CS
 v0BAUek1Izk7q/9K5+mGkWShvuaY2tfSk+xv67uWqpH0T1FoxD3Ml/sLHqH/ENcU+0SE
 HjQBmlhNKsoAITpLlzgyaKdATnb7UJr2r2kHkSq62lCLv9ETDQeQZamCOVF2MyqxC4qU
 53WcGKELedThIC5pNhynFd6tNiQGDw3gEztNtdyJdQr0F53+c5iHNd1jlDT1uwkQ274B
 9WT2E4yqGBQdFtBkaaCpIJN4CsYP8JcOSPCggyD7p1vyRMF4Ykq1tJOS85kWWxRCo0os
 ywdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX42G8wcNmGf5GYsgu6rKZYVQJXDg0gU/6XwkN3G6nsNbcMPrLpZh3TVOfJQAkDjpjUcP+23zw=@lists.denx.de
X-Gm-Message-State: AOJu0YwWgbC3eyanNNwmeCev0VRbllv9FgevC5Z4/CJ4Pq3ZctIjNkoF
 nZw81fVcWA5XNiwe4Dg7c5jU8tJYWRvkHxH+bGfPjRs2l/GzkNizZGc7JmEO1+7V7LZVifhZyCF
 EeYLfBzh/dh8TJlHsCgZygs+g9j7h2DQ=
X-Gm-Gg: ASbGncvEii4I5D0sZzL4gaXei0dtia//+DT5jp3hSzXp45LgwtIu8fDMrhjUHbvzFEM
 dADxPXirJYDVqSChHUn/1OvdJC4mW2zbMP/Vw3lJa69pboA7jqJsRZJ/PIQ6iVGpDkPgPMtq0Ki
 1qYeEy2CHzdloK/EQQnoYd9G+mQWt4MLpWckM3qdFXl8n8gvFnBEhnyXN6gIQ1RsVsVeOAsabAQ
 FQjCfAydOGt4LcdK38jgjKLFsvsY3WuspG8B6n0KX9JqvXBnMLE+1Vs8GPBeHJdzmoGq17dPBgZ
 eYzbBMnj
X-Google-Smtp-Source: AGHT+IFQT2dm9IQcLueMToc48QFsbhx919CZR98jUrNxbjmYDmJabsWmzrn4qLlLJbPiXRmHjwf8XZz9tYLbWz9rcJ8=
X-Received: by 2002:a05:6512:6614:b0:592:fc21:bc17 with SMTP id
 2adb3069b0e04-5941d50dda3mr493999e87.3.1761875530661; Thu, 30 Oct 2025
 18:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251024054036.676912-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20251024054036.676912-1-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 22:51:59 -0300
X-Gm-Features: AWmQ_bmiA4e-31KWa3861D3eBml9Et2hLYtEA8bxK38ZAyCctqIY9XP4UELiqzc
Message-ID: <CAOMZO5CPpzEoNzpO9f3HJEjOD-9ZTF60fJPASmHH0P-gXf8dzQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm: imx8: select ARCH_MISC_INIT if FSL_CAAM is enabled
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Fri, Oct 24, 2025 at 2:48=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Commit 2a7acc865b9d ("configs: colibri-imx8x: enable RNG support for KASL=
R")
> enables FSL_CAAM which requires initialization in arch_misc_init().
> The ARCH_MISC_INIT configuration was added to the relevant defconfig.
>
> Commit d0ed9636902b ("global: Make ARCH_MISC_INIT a selected symbol")
> changed ARCH_MISC_INIT to require explicit selection by the developer.
> With this change the colibri-imx8x defconfig is no longer sufficient to
> enable ARCH_MISC_INIT when FSL_CAAM is selected.
>
> Add the necessary selection to automatically enable ARCH_MISC_INIT when
> FSL_CAAM is enabled on i.MX8 platforms.
>
> Fixes: d0ed9636902b ("global: Make ARCH_MISC_INIT a selected symbol")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Applied, thanks.
