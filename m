Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3166BCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A3786FAE;
	Sun, 15 Oct 2023 09:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JpVgjZZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E7086FBF; Sun, 15 Oct 2023 09:02:25 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4091A86F9D
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e2dc8fa02so4317528a12.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697353249; x=1697958049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ui+cKwrxnW53vKgV6U6hAAsXUY12pw3hfzb+8Hio6gY=;
 b=JpVgjZZgU1gMBanAfDftM51glXp9td34TeNU8GtIk59PJ30p62zDKZ/KNuq6UToFgC
 UAtkpg1NGqXCsYTu2N2+svFKOXS2TAsB0XxVIvP8Y4dli/9FEPbiETmqnnuX57VkZ7Xl
 8c2X3VgrPiaXVi9QGauG4qR7Ai9ZB/DyDzbg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697353249; x=1697958049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ui+cKwrxnW53vKgV6U6hAAsXUY12pw3hfzb+8Hio6gY=;
 b=f7z4XSeWEmXOIjkPrxLm5Kub1uz1TWwr8ZwL3S+Ym5Fl5pBMzuOZMQRn/Hr+J4D0bT
 3Vpd6Gs9Kaww9Heh4/CcG/XO1OMKbE8Ax16/QLiE8KmFB602GTz6srRjCP4Q0/4e5S9v
 c/eGsPIC9P9gMieMLpGExycuXkXbx/GkhOiy5ASuvWAnL+4prr50xzeiTj7V4A9wI64B
 MbL2CLLGi9bMoKOr/NzbStM/fhbmlamh0vK7MwE7ddFvgl6zs7DsNesCbyHcNpx6V4Jb
 28jML5NpAJ74mh7hIPKsCtbXc1eoxdiLcJFpdROjHRIVcYNAXqvYIi/bvY+cuKJz1QGR
 L7BA==
X-Gm-Message-State: AOJu0Yx06zppTkrJ8GB6xBecWwVgTbh5L17chBusSyR9n9WXSAI8rH+w
 aDTRD/OJiFVWcMLDX87PZO+6LPnUG6ZuF+8FuEsqvUux26VKUvR+FwA=
X-Google-Smtp-Source: AGHT+IFjqjfLdDkRSlsKm3Kn5UMFkFGR2YpV3gsaEcF/QXsqe/YqWZVVVvD8MJXc9Zx/u2rX54ayvRC+zchOEnvWDRI=
X-Received: by 2002:a17:906:144:b0:9ae:54c3:c627 with SMTP id
 4-20020a170906014400b009ae54c3c627mr24983475ejh.71.1697326519808; Sat, 14 Oct
 2023 16:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-25-seanga2@gmail.com>
In-Reply-To: <20231014204805.439009-25-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 14 Oct 2023 17:35:06 -0600
Message-ID: <CAPnjgZ25a7uNVPW7tQ3g5LJ=LC4SWx-scGqAH6Xub5iUga2zrQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/29] test: spl: Add functions to create filesystems
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sat, 14 Oct 2023 at 14:48, Sean Anderson <seanga2@gmail.com> wrote:
>
> Add some functions for creating fat/ext2 filesystems with a single file and
> a test for them. Filesystems require block devices, and it is easiest to
> just use MMC for this. To get an MMC, we must also pull in the test device
> tree. SPL_TIMER is necessary for SPL_MMC, perhaps because it uses a timeout.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v2:
> - Explicitly invalidate FAT block device cache before testing
> - Remove unused dm.h include in spl_load.c
> - Add note about why we enable SPL_TIMER
> - Split off ext/-T changes into their own commits
>
>  configs/sandbox_noinst_defconfig |   7 +
>  include/test/spl.h               |   3 +
>  test/image/Kconfig               |  11 ++
>  test/image/Makefile              |   1 +
>  test/image/spl_load_fs.c         | 306 +++++++++++++++++++++++++++++++
>  5 files changed, 328 insertions(+)
>  create mode 100644 test/image/spl_load_fs.c

Reviewed-by: Simon Glass <sjg@chromium.org>
