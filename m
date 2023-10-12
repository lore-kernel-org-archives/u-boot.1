Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD71CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B07B86F01;
	Thu, 12 Oct 2023 05:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ehvek0oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F65486E1F; Thu, 12 Oct 2023 05:44:38 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE9586E1F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d9a6399cf78so433598276.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3KcHXBDwsMcFa6WpHcFiF16zAfB27+AqhS9jndXl1o=;
 b=Ehvek0ocFiKa3CV/817LSRmd1mF+TbLbjJzelErPlQem0J0i7ayIZnVdnvZz7QlVmb
 W1nujRhsg3Vtl6HKrZuD5YBUWreJyLO4mrn8AgIrTgeCXV5jUpSlVUnZjcF3jrKbGnZD
 CrLXAlxPseCGPghhmcIujxNVjPx14c4ZXX1Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3KcHXBDwsMcFa6WpHcFiF16zAfB27+AqhS9jndXl1o=;
 b=Qg8GwCNDCRQHqj+Kf2PI0hESAgMvZ4svLtf/Tnz9LrA60jVJE1ZpnEQu5nlXwfiYsd
 nky0gJd+ZzUwffVAGtCogyICKBBILAYXNL8JBJTQ3TwVSxDGC389FgiRG7ca/i2NoRO3
 WoIsS7mk2d32XQRDz9TZqnpTdzyeHlCBhT58YAV3VAxU3bPAmIAAVWXsesqcZmmYn2iD
 oBUrjchKQilsKX5d1sYNXHqT0RNF61UzwOYV8B+QPf6hUwy4VLOPysIMXSl+YnDHQoKO
 iDLfYitE94VbaAYt4iJLCgaQyyyTkLVCizlwqOcmKS6OoQaL+rG9PeBPMuG/2lRlcxMT
 ARhw==
X-Gm-Message-State: AOJu0YyTsk+YTV1Yu1+uoJd8lc9siPwm6uIY+YAPAMS6CLPfVPUe2vHS
 0RFGM3GDleEwmUD99IRvCGXvwfZj0bHWhc4qHFv15w==
X-Google-Smtp-Source: AGHT+IFFxAHhTa0yQAlrKDl2Et39JRmQb36pzOa4l6x2cirxgUP2d+80GkBYLrNWv2vlr2Lxly8ZTbt7hX5ADXEk1/Y=
X-Received: by 2002:a25:d081:0:b0:d9a:ce06:2b85 with SMTP id
 h123-20020a25d081000000b00d9ace062b85mr127186ybg.2.1697082263690; Wed, 11 Oct
 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-8-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-8-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:41 -0700
Message-ID: <CAPnjgZ0X5XeuYqvhSVzv3t5_rxv2STNZCh0KbEqPASwrV2yHzQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] ufs: Add a PCI based UFS controller driver
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
> This adds a simple PCI based UFS controller driver with a QEMU
> emulated UFS controller on the PCI bus.
>
> Requiring QEMU v8.2+.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>
> ---
>
> Changes in v2:
> - fix a build warning
>
>  drivers/ufs/Kconfig   | 11 +++++++++++
>  drivers/ufs/Makefile  |  1 +
>  drivers/ufs/ufs-pci.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 drivers/ufs/ufs-pci.c

Reviewed-by: Simon Glass <sjg@chromium.org>
