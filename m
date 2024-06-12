Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20949C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B2E88850;
	Wed, 12 Jun 2024 22:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JOQSUfkp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0285588863; Wed, 12 Jun 2024 22:24:42 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6370688861
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c2c9199568so202306a91.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223877; x=1718828677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TOOXKKLpXN+Bw9ZdDP6IWm96x0SECPBqND9UjBJEP+s=;
 b=JOQSUfkpaU0jhtzsSXMMNURB3XSx6Ce3rD5Gq5hyAhdImvNte1xw0iw7QPadSpSUdD
 fYO3kSxAZ2+oXlNynfgOBzrnclk34LhkfYhs0+GFddUeWmVzR0rM1XrwGUb/2DOR2+SE
 cfQC4c1AQVJX5spJ8Obe05juD0XVDT+Y8JfIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223877; x=1718828677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TOOXKKLpXN+Bw9ZdDP6IWm96x0SECPBqND9UjBJEP+s=;
 b=XpCfbxYoO4RA0g8tby4JYg96EhJP/gp2mC5+qOBSaLtBxJwPnfERyQ7IpOri55dx/p
 iExXBa2maKb088U63lqbLINa85jv+OYdgbxnian+wVW6h94FMVu7nA/kZfAgFare+aCA
 MiWhwKvIfw+eMZUKnjhEnbrreDy41RE4FO2qRU8MKWdAxlVxQdAzGtIGJp7Ck4Pt0LpC
 Oo2A0/oTpTyK1MEM2sMscCh6rxvlYc+RLRkINziTOgb8gZRNZSQgCnhgWSAWm8DwHIcJ
 6DVNVZ5bTXDuQjW4UBV/BOMkOjuLXfbHWh1AHSH9dQBBPScSzuN8xKllhJywxFC61TKb
 CQSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmiRlXmmvjo/mxL3eok/mVGcOeizwm3MZmOSIwNL6wblYfzrt50ZDkvEqTias4kdbd8NJXRZcQLF2Zi2vUlAg/9BD2yg==
X-Gm-Message-State: AOJu0YyF4NYP+8uM7dyfp3tJHmfNPs+SmGJ7ZXT+4OONEcsRCb8MvtJe
 RpL2wm4hukVk77aQK2sn2VEMB/orqxiqrg3CYkbfNU7Thfk1kgvz2ZNqwJeR4WjC5fXFXL12U5B
 u0YcGdm9SAszeW9gCYR+tgNsGWRKw9a7tYnEd
X-Google-Smtp-Source: AGHT+IGT4iTlwQVnb/mqEI55FqVWjmfjaSDerHtQ24b7LlpdktO407Y733933T6Ahb13ql9a+aBPoE6C+CdSe5C6aJU=
X-Received: by 2002:a17:90b:3793:b0:2c4:aae7:e27 with SMTP id
 98e67ed59e1d1-2c4aae70ee5mr2750950a91.23.1718223876881; Wed, 12 Jun 2024
 13:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
 <20240612-bootflow-efi-crash-v1-4-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-4-27b71b0ff08a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:22 -0600
Message-ID: <CAFLszTh73PFJFT8j3vHByWj2GzbsQUpv-KY4GQfDri-qvx9bCw@mail.gmail.com>
Subject: Re: [PATCH 4/4] boot: bootflow_menu: fix crash for EFI BOOTMGR global
 bootmeth
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 12 Jun 2024 at 08:58, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The global bootmeths don't set the dev in bootflow struct which means
> the dev_get_parent(bflow->dev) triggers a NULL-pointer dereference and
> crash U-Boot.
>
> So before trying to handle a bootflow, check that the associated
> bootmeth isn't global, otherwise skip it.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/bootflow_menu.c | 7 +++++++
>  include/bootflow.h   | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
