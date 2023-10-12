Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68381CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836F186F4F;
	Thu, 12 Oct 2023 05:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZhbcPNqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068B586F0D; Thu, 12 Oct 2023 05:46:30 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBFB86EFF
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7af20c488so6658847b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082385; x=1697687185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zzQgyo22Y3R5niRb9QGFAhiWdJUxRfzSaHUbVoIa7aM=;
 b=ZhbcPNqpE/em81WSUbqyqRre3En986wcA4WNu7B13Rs8H5r7PWSIQqDYX+htnN8aKc
 2m7OnPFH9V5gO6fKeyV+A08+NtfdHLffPgX/PfwZTkVkY2oK65F9txLHUANQPY01XjDb
 pnZeHbl25ffKh2zFHjrZ6WGjnUOgf/sv5bRew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082385; x=1697687185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zzQgyo22Y3R5niRb9QGFAhiWdJUxRfzSaHUbVoIa7aM=;
 b=umC2iumRRZY2jF7eFuOZsScyJj6JtpVoKe6e6BSKRdr+OFvYMkc6QqSlB/UTHD8MVy
 yrm4RCwGWJj34kq+myX6KzVuTeUDv8Ie+l9Wo0x7RtHScZTTKOpuU/vEtIW4ZPOVnuHk
 oNGzs73einoMywCVOjd2neDBLEKtFXtC+tWw+CCrGB4vjHjfaMkzwFWVphGCDqBd0Hqr
 9f9xh6af7dlEHC2ZpNJt655D2x6wt3yckACR2o4Z1y2Lm9mAYejkvRqTMWAAfHc7IXE8
 STCgszx7Yn4CSDtUCH2qF40lxIfDFnSV4rql0oh+R2G+0wOx2NXe5eSI9fL7n1HH3WeQ
 lIyA==
X-Gm-Message-State: AOJu0YxL7LXwsPXPaCHu0sogOxp566uJjDxovdnoCJxbDLUTlCXl5CoT
 /iwkBcGSLnNaQrXnJHnKf4ZgwR8Wv0414k9LlPIZZw==
X-Google-Smtp-Source: AGHT+IHT4q8hi4Xa6TFfaXfceH14MqehsUfXus67GMFT3hfgz1I/zCaQSkulSGrSyWb+8/HpPKBI1Nx/gvRNxYIBhHY=
X-Received: by 2002:a0d:cac6:0:b0:5a7:dbd6:14ae with SMTP id
 m189-20020a0dcac6000000b005a7dbd614aemr4187709ywd.29.1697082384602; Wed, 11
 Oct 2023 20:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-21-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-21-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:12 -0700
Message-ID: <CAPnjgZ3GmCq6OJZy9=Dcd49oW0T9fqsyYufNAWX1cHcuZi0UXg@mail.gmail.com>
Subject: Re: [PATCH 20/26] test: spl: Add functions to create images
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 uboot-imx@nxp.com, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> This add some basic functions to create images, and a test for said
> functions. This is not intended to be a test of the image parsing
> functions, but rather a framework for creating minimal images for testing
> load methods. That said, it does do an OK job at finding bugs in the image
> parsing directly.
>
> Since we have two methods for loading/parsing FIT images, add LOAD_FIT_FULL
> as a separate CI run.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  .azure-pipelines.yml             |   4 +
>  .gitlab-ci.yml                   |   7 +
>  arch/sandbox/cpu/u-boot-spl.lds  |   2 +
>  configs/sandbox_noinst_defconfig |   6 +
>  configs/sandbox_spl_defconfig    |   6 +
>  include/test/spl.h               | 117 ++++++++++
>  test/image/spl_load.c            | 352 +++++++++++++++++++++++++++++++
>  test/image/spl_load_os.c         |   5 +-
>  8 files changed, 495 insertions(+), 4 deletions(-)
>  create mode 100644 include/test/spl.h

Reviewed-by: Simon Glass <sjg@chromium.org>

The error handling for the FDT creation is a bit unusual, but it is
test code, so if it fails all bets are off. So OK.
