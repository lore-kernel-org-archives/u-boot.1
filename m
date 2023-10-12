Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F101CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BDA86E54;
	Thu, 12 Oct 2023 05:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TeJzYl7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FF086D12; Thu, 12 Oct 2023 05:44:24 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322FC86E0E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7ab31fb8bso6370867b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082253; x=1697687053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SKgqG5OL1AYeT2Qus2c2Yk91GkX68TyU2WOXrRfevMw=;
 b=TeJzYl7yaWmDpLAf20kh7waCbZKJ9L+mAA25dY8tO1sHW9exz0kHy9ZbOSu6HbUDvB
 4MLOH/fu24KV+/3B8r9QpCYP3+wqi0/roIUGG7nmgojSAdJuDcx9CsEAmmIpazcxj56J
 et9EEHzRuK14O4lPmm85mhVMvOr9hC7m0cCyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082253; x=1697687053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKgqG5OL1AYeT2Qus2c2Yk91GkX68TyU2WOXrRfevMw=;
 b=lwlOH1NudmRJt4Sj8WUylraPJibHSkhxNYmH1SOxVmZa+tGDrwLYHNatB+S0B7FxRX
 ozzLqs9f17T+sr6qcm43iVfnU+ZK1xgFO+ctkb7vgZCa4iXXj2JuBkW69ct1q5gWHx33
 +F3pSIfXCcRM5qTEw+zcIls+6lZmUcGpa/IKfwj6LEj+rHb01U4MVC/R0meMInK1n9NO
 vMmfpak1IofoV9KMHbSq9YAnGfVNhFuGXsbq2I3aUpvUGP7CmEC06RLVDnpMJu3r9twx
 JI5cEwkHbc01wQuhdfp9pynCcLWGRP7RgTfGDU50Cye0CDmkFxQDy/4BP/h1Z4kgEy3+
 v7+g==
X-Gm-Message-State: AOJu0YwCE8JfJPeLjGIUnCWUQcVHm5k5eRq9gq73lPFqnuSw8zw7Puo5
 VXkgsjEhBOwIdUWVXtQ1yZ0Dzi621WnQRvL1BGOMkg==
X-Google-Smtp-Source: AGHT+IG3crQPsWG85p7x2QvH3wAYv/qIDvl4niuo7yMgwO9NHKiGJx2MlPjPTBjPRvIbVroFKSxo2otK2YRfCHsFg3k=
X-Received: by 2002:a81:4882:0:b0:5a7:e125:478c with SMTP id
 v124-20020a814882000000b005a7e125478cmr4381179ywa.42.1697082252764; Wed, 11
 Oct 2023 20:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231011130535.3964-1-bmeng@tinylab.org>
 <20231011130535.3964-2-bmeng@tinylab.org>
In-Reply-To: <20231011130535.3964-2-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:32 -0700
Message-ID: <CAPnjgZ1hrQ8HjEp_cuu8Vo=4iafEA8maj37316nLN3T-f7S3zw@mail.gmail.com>
Subject: Re: [PATCH 1/9] ufs: Correct the UFS terminlogy
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:05, Bin Meng <bmeng@tinylab.org> wrote:
>
> UFS stands for Universal Flash Storage, not Subsytem.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  cmd/Kconfig              | 2 +-
>  drivers/ufs/ufs-uclass.c | 2 +-
>  drivers/ufs/ufs.c        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
