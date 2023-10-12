Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F88ACDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E2886ED0;
	Thu, 12 Oct 2023 05:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PUzEeb2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3157386E82; Thu, 12 Oct 2023 05:44:39 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1E286E5D
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7b92cd0ccso6951907b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/3fl86Bxat/6kiCVHiK3KdDBLYkLW2/gRhiN2a0VMk=;
 b=PUzEeb2ZeOao5RBERuO245miv6LKc+/VHKjjxYZS/ubwbRGbOPipWZYamRdjhbyZr2
 4X6KntWnLoMidKFUEtD4J/7dIWcTkIdxHxmtN4Gw9vy3PU/1AVyZ/cBAkLDY4vt4lVFW
 Uewq6wIC3I0PE54/F1V3UGX5OKOh+SXrsnnRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/3fl86Bxat/6kiCVHiK3KdDBLYkLW2/gRhiN2a0VMk=;
 b=S+7sBpKLs1QEvyMvUNnOZciMvUsMrUZQkdjrqkRBz7Y10/JP3vb7upr/9vkQYUM32s
 HXJ+uLYRy5m5vJULRCWdHMD+PyivIOx1/qJfdx4bCufTzPlqFc9FHiPCw69XYEUbgyVa
 TMHm3spXF5s48n23eo1FsQqxj5LvGqag+SA856skmmEfeHlwi3pu422Hu/kC+ODv2Rub
 /6j6RYFjY4ELxIzp3UDMB92OmA8A8Sdsruu7A2t60CLfG+feXdEfNZO7iAJgDlLSUFDv
 wGF9DPxtVIT1KPpiyM8xrAC3mfOm6LY6WhOWoSDF/Xfo2tWBDiDnN+FIXzqYR2yodk/w
 ZYwg==
X-Gm-Message-State: AOJu0Yy8jG9morepxnkc4Ezu/bHSpMExoW06ZZ/TNFwc2UKPuvPQYUJr
 LjW9kLo2t9z2/1dk+/7tVc+zkfxVd7d9E7yLRdfxgQ==
X-Google-Smtp-Source: AGHT+IHG58R2l64huDFW+5G9oW0tqBMpuu0FYZfnsADiRrLTKDbIiXH9UWeZC4Th4xACjG1NYYP+v5j5eInAtYKnlRc=
X-Received: by 2002:a25:2d07:0:b0:d9a:49cd:82b2 with SMTP id
 t7-20020a252d07000000b00d9a49cd82b2mr7150496ybt.32.1697082263739; Wed, 11 Oct
 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-7-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-7-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:39 -0700
Message-ID: <CAPnjgZ3DPtaMaHB+8C-s2Nv6XQYmR121Sds0oPFuWqBVWEVfjA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] ufs: Allow mmio registers on the PCI bus
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> Check if the UFS controller is on the PCI bus, and get its register
> base address accordingly.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
> (no changes since v1)
>
>  drivers/ufs/ufs.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
