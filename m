Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BB1E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409FE8958B;
	Sun,  8 Dec 2024 16:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h9xIoVWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BC8894B7; Sun,  8 Dec 2024 16:29:41 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07C889618
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a68480164so470434466b.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671778; x=1734276578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vcOfyG1GWixb3QF+koQmk3A+3hatNpTIjTGB2QI2dv0=;
 b=h9xIoVWqzVovJOVmPTEA5JHc7PHBUOXmYXl8IfX/ju3wOHTPtTn35DOLNVe88oLXxc
 tP2pQx9/29L+asrKI1xltIV8ox/j1qtL2c3vEiEVCenPXSdV4Q6vea5TBlplTg6VSE75
 dXC05JolJrLZchat7eGgL6BIO9bF95O+Rfo6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671778; x=1734276578;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vcOfyG1GWixb3QF+koQmk3A+3hatNpTIjTGB2QI2dv0=;
 b=IR0IbLaTVhTSEYK1xeHrmODpGjp5a8Q+brewhboEQQbz4v+AFEHyk6bD0PZGA5tvmS
 Q+0xmiHzGCQGBEk2fHMUmtBy4PACh+EGNmA0bxG1RRp0/uyWtweLQ2qQNvuiYwQVHKvW
 02rLkuKymeq20yny8N/DwNQ6iGBIHDsyQ6hY8JzmmID8Lc9/rO9uvkrgKIMdKltVjPzr
 pR9xxAf/f0nEysRJBqfCgxV64CMMo1JW82DMtkwLPJkKox+O/ewnHsYPQO7ML6S6bmkH
 KDQlSR4gnxRrhKleCo+tz/XPR7lqgoOwgnpp1jAM6P+zUjWHNKk/em4Di/rcQru1f3wF
 3Spw==
X-Gm-Message-State: AOJu0YyPVW8vjod7nhs9vBtJZa1uK1NznpuZtIGYZ18GhhYYr1TyaDys
 Qe/LLaGMi+jeN5xWfxuRjVaTwicabKNort2Nar3i/0zzfGvHPP+8DmyHLmToOZTGyJpVRSrjbb8
 MKMOkuskx5L03zR4DoUVhCde6K60hmLHdaG7i
X-Gm-Gg: ASbGncsfrSFXHPTDAVt2aHctF07EaxkDekHkCi5RJ6nq/uPCNKZwDInPppAsf/kRVyM
 PpbBXsO7DeH4qhI6P9AuDq1BbmCZwVzx9
X-Google-Smtp-Source: AGHT+IGQDrUqjE5Shtcxgsg3XjDpxkox8UAbgD/MDhUez6x9g/pRYbs+F8ljEFwlOIAUZhk89ueT8RWevN8dlkBxNDg=
X-Received: by 2002:a17:906:3cb2:b0:aa6:538e:a311 with SMTP id
 a640c23a62f3a-aa6538ea57dmr513864566b.18.1733671776746; Sun, 08 Dec 2024
 07:29:36 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 07:29:35 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTh6R_bnyz0RNGXmB_uNDrpgcwftVc-1tdy5C8PY9pSj-g@mail.gmail.com>
References: <CAFLszTh6R_bnyz0RNGXmB_uNDrpgcwftVc-1tdy5C8PY9pSj-g@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-2-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 07:29:35 -0800
X-Google-Sender-Auth: T-bks2SRr8IPBMAaKZR8P-HJT9E
Message-ID: <CAFLszTgGYVe=6Y_7y2T2tNzsTdCVY1WkRext-F=3_D8F3ZYq3A@mail.gmail.com>
Subject: Re: [PATCH 01/10] Add EFI handover support to bootm
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Matthew Garrett <mjg59@srcf.ucam.org>
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

On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> We want to jump into the EFI stub in the kernel so it can perform
> appropriate init and call ExitBootServices. Add support for doing that,
> including ensuring that we copy the kernel to somewhere that's not
> currently being used by the firmware.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
>
> ---
>
>  arch/x86/lib/bootm.c | 49 ++++++++++++++++++++++++++++++--------------
>  boot/bootm.c         |  5 +++++
>  include/bootm.h      |  6 ++++++
>  include/efi.h        |  1 +
>  lib/efi/efi.c        |  1 +
>  lib/efi/efi_app.c    | 36 ++++++++++++++++++++++++++++++++
>  6 files changed, 83 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to ci/master, thanks!
