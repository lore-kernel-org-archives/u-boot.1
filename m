Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305ABCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 937E686EC9;
	Thu, 12 Oct 2023 17:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="aLM+Mhzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8D386DC7; Thu, 12 Oct 2023 17:31:22 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC3D86EBD
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9ae7383b7ecso483592266b.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EWvduFrKHG4Tk899XR8NNWu4dMpDHBVFbvmdjZ/7mAk=;
 b=aLM+Mhzp37/CPe+jbZb9hyaa3uDy8yAh4wD+2oIusgPrD7/Y6Wv9Kvzieyg3o2eyZU
 pbMY0gUKHX8HyZmlxje1IhwZUSt1tVux02ax6X8XK3RS7rIaFBTNiJng8AnMzdtP42Jb
 e8jJE95wYsNVSpW0Fn+KAF8CkS4mgfv8VwJ7lbmXzAyPG7pJPxL85ULaVn0Wmb67yNgx
 d9CZfJ6GkzQ5krM/oKKKPrR1YNPZDLZK/0itrostj95QY+xNkkuSz4hJCI6g/iByiKV8
 zSsRbNPK1O3jPe0EJoassRz2ZL9fflxhLCp/yNsKUXSDW7yLhGETyfRvrlTQvMW7A4c3
 gMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWvduFrKHG4Tk899XR8NNWu4dMpDHBVFbvmdjZ/7mAk=;
 b=KbG2KcPyU1wN5vUJ391Cyr85D+rJGvtPMYh/svhiNk+m4OnZcSz08tW07L/2PLWSnJ
 TTOqiDEKPWRFnUPHEvc44+WbR2jyVfudXtZGRCpxavUao6PUMXFqUZD3TuGJzp4ahTXs
 3aGgP24aA4IJyjIp5D40OLfSxs1g0XCA8idX3rncW/L+LIVoSwmCe9+dWe+YfTtiuFJS
 rNVmQd8A7O5AjH85Scq1uXi5NKl8pWZjCQWuGwB7lKOOJGtSTIp/XRw7jyyIOSbc9G22
 6f6FC5nNqVCPhaXdveYFz8sgojMjlb7wYEb5nViMY9Qr7eMYo1kf2XHqbZGXVAC+5HTb
 36Iw==
X-Gm-Message-State: AOJu0YwDL/2vgBBTon9ioYRJM99bHOMa7b7PDX6ahSTX0EndRHvH254r
 R4TZB3I/MJOL4aGpwbmCLOHrz2PeUx/7Gkfv9uW0/rVW+iHdoMvdhXQ=
X-Google-Smtp-Source: AGHT+IHn8SiJ40RrT21rCH43vyZymb8wwGrlJKiJ9WCILzSK/mcrN5mpGGXbCHp2kFnPUw8/R6cshGdBqEFziC+wePo=
X-Received: by 2002:a17:906:3012:b0:9a9:f042:deb9 with SMTP id
 18-20020a170906301200b009a9f042deb9mr20476191ejz.19.1697124553313; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012063509.2963258-1-randolph@andestech.com>
 <20231012063509.2963258-6-randolph@andestech.com>
In-Reply-To: <20231012063509.2963258-6-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 12 Oct 2023 08:28:59 -0700
Message-ID: <CAPnjgZ2QFi0AytB4mkcWACAyn7qFeM5HCOh_Wv-ymjXVGyUv2Q@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] spl: riscv: add os type for next booting stage
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

On Wed, 11 Oct 2023 at 23:44, Randolph <randolph@andestech.com> wrote:
>
> If SPL_LOAD_FIT_OPENSBI_OS_BOOT is enabled, the function
> spl_invoke_opensbi should change the target OS type to IH_OS_LINUX.
> OpenSBI will load the Linux image as the next boot stage.
> The os_takes_devicetree function returns a value of true or false
> depending on whether or not SPL_LOAD_FIT_OPENSBI_OS_BOOT is enabled.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  common/spl/spl_fit.c     | 3 ++-
>  common/spl/spl_opensbi.c | 9 +++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
