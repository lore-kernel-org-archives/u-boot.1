Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EB9C35FFF
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 09:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF9F18129F;
	Wed, 19 Mar 2025 10:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ro82xKNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E4B8141E; Wed, 19 Mar 2025 10:28:43 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E2081101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 10:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e63c966fe37so4552589276.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742376520; x=1742981320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rZWhEgTQVBZrzRuoMmoNoi93H0XG0Rn+T1QTpvT3iIk=;
 b=ro82xKNkSQFb48cewB/XS6MonTYTGKdTe1zU3LJ1gobvaxnPn6yNUZ7RdI4Ssjafsx
 ggWn8Vlc4tvcTRk7iZKOlB0W2dY1OHxyDJ3xIUiaUkpZFWmFDpq31Bz+ZqqNLeUA0pUW
 axkT1dXiPXGuKvYQSgUsJAr4Gxn5BjoVAJ12byvh7YTVv1qT4aevfsleZ0nxrh5lwpGU
 Xb+Bsv05VdECW46VlVIv9kH85Xpno0psCinjd3wFqmWzz/FTC/cIMoTrTvqMh6It6lyC
 SClsiCtr2ix7oj/DoDeVn5eOOgJYUmQBaOzES1bXH0Tix3tTqaAq2YMOT9poXec4rjqu
 C4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742376520; x=1742981320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZWhEgTQVBZrzRuoMmoNoi93H0XG0Rn+T1QTpvT3iIk=;
 b=KBOkipithLBDazNDMcoxVhqdjFzUyHf9EIe0qS05foF9BFKaFtPO5qxldrAdJGTUkH
 kYnBFGStkHJO6kprkM4+umWbhnoEVofbsKQYjniU669lyy+nPR4WnQFU1yIAFNGW3Ssu
 OqUwTpfcAVLP8xn5Lk2pispMn6KRGjvedw9tg7ZzjAQbsu01S3XpA9p5KrrVH6iPVdSo
 LWkcSfpfjg/RGwjGglG+n5dvyxpxt6bt+dQSL5fASoR5F8/oR7wBwsZt8Qg/BJJAnjX+
 n+XgWQw41NzUhwcf33iWqVmlBjcEV4NqthTMKHP2jnpxLZ/R8zeFFkyJi+eWKMut8Ydt
 33LQ==
X-Gm-Message-State: AOJu0YwX22aDdl2+6/yY36n4lSl1712ZFSJYApT6+jeF3ktRbLQD8jQT
 YneIsbtSCR6e7DhKukI7+ulfJqlAFVuPqdX7mPWYpIJYfR+TvJOrrdSpyV+EmPY0FcqmfnCbp5w
 b2ZuD84+s5yuWRudM1U0cE2RL1px+RkzOTI1iZaFZgFjRdHQI
X-Gm-Gg: ASbGnctyAK+jz+mkMs+GlqgNaqiGfEW6Yp4Z/yAQsFp2b0dtlhZt2wh2czo7bVB3FXC
 V82xMcSs16E10Z7yCuXWEN3Up9i/wz9aQ3uKILM/gyx2EFjGgPSfRDN3m8daofjCe57mLN47RBm
 l5fn2wV/NUjwaxa++7gBHIlh0oLhg=
X-Google-Smtp-Source: AGHT+IGSlbfq1ys/gMPDQ1tzCicgRZHegNd9zO9HxjslgckcbGIPK77m0H8Ve3xWKXzVHfkKPMTzwn+WYIk0zVzg7ws=
X-Received: by 2002:a25:7243:0:b0:e63:ec04:3140 with SMTP id
 3f1490d57ef6-e667b3a1a21mr1939604276.10.1742376520592; Wed, 19 Mar 2025
 02:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-2-adriano.cordova@canonical.com>
In-Reply-To: <20250318132347.646703-2-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Mar 2025 11:28:04 +0200
X-Gm-Features: AQ5f1Jr4wh8bHtfc4liPfpSB1cuPq4zBss1Y-iE5UpoXg3soh7NpdAsq55T035k
Message-ID: <CAC_iWjJ=+dqqVen8b6NfsUx8-NpkzOeYbq4UG-LUcf7E=88jwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: efi_load_initrd: provide a memory mapped
 initrd
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

On Tue, 18 Mar 2025 at 15:23, Adriano Cordova <adrianox@gmail.com> wrote:
>
> U-Boot can pass an initrd to subsequent boot stages via the
> EFI_LOAD_FILE2_PROTOCOL. The current implementation only supports
> this functionality via the efi boot manager: the initrd is taken
> from the load options of the BootCurrent variable. This commit adds
> support for registering a memory mapped initrd, e.g. loaded from a
> FIT image. For now this new method takes precedence over loading the
> initrd from the BootCurrent variable (if both are present) because
> the BootCurrent variable is not cleared on exiting the boot manager.

So for this to happen you have to
- Invoke the boot manager and eventually have an entry that eventually fails
- Load a FIT image with bootm right after that?

Looking at the efi_bootmgr.c , removing BootCurrent on fails seems
straightforward. Bu I can live with this for now.

[...]

Thanks
/Ilias
