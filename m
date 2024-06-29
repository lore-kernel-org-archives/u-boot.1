Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7B4C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 06:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 162AA885FF;
	Sat, 29 Jun 2024 08:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ME3TuAyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C4D885FD; Sat, 29 Jun 2024 08:56:17 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E295F885F6
 for <u-boot@lists.denx.de>; Sat, 29 Jun 2024 08:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6ad8243dba8so7769206d6.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719644175; x=1720248975; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yVDgnPqLyB039p/27unyr6s8Xd7f/CqmtZT+tV5XV2c=;
 b=ME3TuAypwjOHDZFHwNU4qSKKDQBWOXmYT1b63x//TJ85UXCntjbx2SZY/mrbAbqq8i
 xuCjIXWjdamVFW6h0SqBSFJrZ2PzFLncMo6laciiATMrWKlSEl3OvlDAgVu/BIFLngBw
 L+ULl2xwshSB6SGnZSQ9w0kPFmqGEeOpKQutw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719644175; x=1720248975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yVDgnPqLyB039p/27unyr6s8Xd7f/CqmtZT+tV5XV2c=;
 b=CfARRlUQ4Oy3w3jOQEjcRkETyfrctP5Bo0K1u+vJeir1umVB2AaAR0VmLTCiD/GfZq
 Jb58ECw3qBNU8tSRJAKcfyPb1CHc9MryhNPUeWtATSiyCwH4T/HFbXDM2wPC6YqyPfTn
 fV2mL+m48XhJxZeLjASFmYJF2ungr8Zg+ckLrhmeTaOV7JVAGzmK14Kd/ROdQTJvpnUm
 KkOpXG4iqHFCTQeYSS5LyIaTjoDrTOsV/THZQ0q0frNjeaDJVZm6dOzCjZmuq9FJYglG
 czdbkbPRYHa9Hclb9i/rAGYSITlirdO773dgzNMW41QAGoOMnHnvJQeoV/8eq+fbKrM/
 gctg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu6Z0dEqVGroxpE1I3XVNAjDIHLYYCWsjRZr0htS+8i3XGByDAPru0NvcqL325HBxJh+bJsksAswU3DRoGG067CSsI0w==
X-Gm-Message-State: AOJu0YwK8wqVMkeJxnduuimnsvu19Y0pP/9GX9YfAd8kNmYjvPPMvnbc
 OdlkWd/9BIfi8RK6nnkQ4qkeB61/yflSLQBhoXAdVUTdtx8AS3WGv/Dd8Nbq5JMV4DeGMq1HBVH
 QdyqLic3q1t0UaIfs3L3Wj0FK+CvwhdvIZf5fc06Dk7tVfqM=
X-Google-Smtp-Source: AGHT+IE6GSmf4q/UrwlDmDJpoNuCzLYwzvuJvsPYNvJ0OYv3Pee1HNL2LggiYlSqdIfCtP/lLzqYcnzcEDMprsH3eik=
X-Received: by 2002:a05:6214:20a6:b0:6b4:fd24:95f9 with SMTP id
 6a1803df08f44-6b5b70d27f6mr4478716d6.38.1719644174851; Fri, 28 Jun 2024
 23:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240628083411.19843-1-Maxim.Moskalets@kaspersky.com>
In-Reply-To: <20240628083411.19843-1-Maxim.Moskalets@kaspersky.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 29 Jun 2024 07:56:04 +0100
Message-ID: <CAFLszTgWusENqmRi7ehDAqK+dJsCV_Y-cAAprQ9vbragBwdFWg@mail.gmail.com>
Subject: Re: [PATCH] cmd: add resize for FDT in bootelf
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, 
 Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
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

Hi Maxim,

On Fri, 28 Jun 2024 at 09:34, Maxim Moskalets <maximmosk4@gmail.com> wrote:
>
> In some FDTs, there is not enough free memory to add nodes, so this
> operation fails.
>
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>  cmd/elf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/cmd/elf.c b/cmd/elf.c
> index 32b7462f92..673c6c3051 100644
> --- a/cmd/elf.c
> +++ b/cmd/elf.c
> @@ -68,6 +68,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>                 log_debug("Setting up FDT at 0x%08lx ...\n", fdt_addr);
>                 flush();
>
> +               fdt_set_totalsize((void *)fdt_addr,
> +                               fdt_totalsize(fdt_addr) + CONFIG_SYS_FDT_PAD);
>                 if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
>                         return 1;
>         }
> --
> 2.39.2
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Would you mind adding some docs for this comment in doc/usage/cmd/elf.rst ?

You can also use the 'fdt addr <addr> <size>' to expand the FDT.

Regards,
Simon
