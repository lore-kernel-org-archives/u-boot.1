Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CF8CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E81C86ECF;
	Thu, 12 Oct 2023 05:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N3DHNt+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B80E86F10; Thu, 12 Oct 2023 05:45:20 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F6B86F0F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59f6492b415so4389897b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082302; x=1697687102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DykmkwS8BtxeWNWZ8udEYNs3hxSnOxIz2UdZMdm8BjE=;
 b=N3DHNt+9ErBtwSgzbyk/PyaC8Efll8OAI7slgx0KJbf/WHKqgUEImiODTmICbJ6T73
 xfj7760GwH6MPWw9bMpuXzRW+nlK63pqf83km0CYpx7ADcAGCIH2Yuya0VQbsvwIoLjg
 RQQ/XvvxWiKpsQplqtlBZOBGlzdROCDh5xvZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082302; x=1697687102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DykmkwS8BtxeWNWZ8udEYNs3hxSnOxIz2UdZMdm8BjE=;
 b=cWMgbj0dJiwJwnLuIX3pyxGAyvGKyt0PiOXMSGVKAQuyrbqYAI5v0W4T4HNjxdh4EH
 QHvqc8yRHwKPeKUmftn82zjgwpsWTCdEIxP3WqLYtD70kpqhe0dNUNGOn3LQdLmwVAyn
 Vqp4e1UpCuukRZK+HCLAAVV0fnrQZKpw5TPB8iH+MKhL8NgfSXmT3CM7qALfgzeS0HfZ
 SRVJ5Tvo25dlHEs4pbnSZxhQ9f739TLVX5enPHhHUvpZUF+T3K+E+AQ278Aj4EtBP8Q1
 2LrhK0Fy9HkTAgIhXsjOG7VbclK8EgN6thfFIg7GZISSU5bBz7VsRscHMQ/sDa2WgRYq
 cs4w==
X-Gm-Message-State: AOJu0Yxv1e+SLDO/FPiRFOWFje6KW6dcEileREQS8LCG3LaspfRZ5J/E
 o69WT2xDXM26Kt1u28gih0eX6aKZgd2NaFDRZRp6Tw==
X-Google-Smtp-Source: AGHT+IFa7+Rn83l+zSU/SUvJE2tkTomJGp+dryl7i+WglwngPPDhSPOwy+lVAZEF0GhSY+nzT++KvTV6zuV2lAByYxw=
X-Received: by 2002:a0d:d491:0:b0:5a7:fbac:4ffe with SMTP id
 w139-20020a0dd491000000b005a7fbac4ffemr447372ywd.22.1697082302427; Wed, 11
 Oct 2023 20:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-3-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-3-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:22 -0700
Message-ID: <CAPnjgZ3yH1G13F1r2U00r=sD1mTEn+sY3G0-ggpRvfpLaUxNDA@mail.gmail.com>
Subject: Re: [PATCH 02/26] spl: nor: Don't allocate header on stack
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Roger Quadros <rogerq@kernel.org>
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
> spl_image_info.name contains a reference to legacy_img_hdr. If we allocate
> the latter on the stack, it will be clobbered after we return. This was
> addressed for NAND back in 06377c5a1fc ("spl: spl_legacy: Fix NAND boot on
> OMAP3 BeagleBoard"), but that commit didn't fix NOR.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  common/spl/spl_nor.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
