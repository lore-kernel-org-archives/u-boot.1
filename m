Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A506BEE49A0
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F03D87209;
	Tue, 22 Aug 2023 00:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q+jVsQjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5970386898; Tue, 22 Aug 2023 00:11:05 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB363870BD
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso4817683a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692655862; x=1693260662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k3yjYsA6xAOdfbKcLUWJ0+K7BlLVS1tlQtFntQ4Cs10=;
 b=Q+jVsQjcbCbfylxTSTBr+c73/yvub2QzmDGAToTzwORoOaCdDjT1vbXFP8VgecJWoR
 CzkVDncEf4yrccfrxQMSoc7giL5ZS6BwnQgOuNgO/TOHSBxHkCsgyhjpWgrKwkntw6c8
 gj5ZMkjk811EQHdaLumguC4jF6wGxro+qwvms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692655862; x=1693260662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3yjYsA6xAOdfbKcLUWJ0+K7BlLVS1tlQtFntQ4Cs10=;
 b=bBRlaA4BH+ojJbJgykkStlFZMOh/mWaqdEjACc3EUA1ZSm95mNq1lJZHeWEG18OoFz
 HcxZlNqSR2SvT/I8PlGu6Mfp3HcR81Pfxb1bPdNNZnOjRyjT7lHm+NolB35tGj1x5D6J
 j4Dc+C1YQk/xrl536k454v4tgYOksVw/cHhZonZWCst/mMRnlWx0/u8lpOc8TcpXDFmF
 ERpaTO9rJD73Kp7k7vo5bF8+4wQHLI4zwlZ2gdb/CJkvqms2Sk0u0U9xXGs8fNl695W6
 LbViLgdWrReAe5sfEkX6Qv5PcBCF8bH+LeseKqaUV95TPUgsAFWHlz52+/v4aa+VG01V
 NN0Q==
X-Gm-Message-State: AOJu0Yzm2TsRk3JqzXmYx2G8ewuRGyU0umEifKE4QeXV6gE8GjWXhn5V
 RHZ6QxlEMYHEl7E1u3dzVsYYUa65PBs9eIG40YnbnQ==
X-Google-Smtp-Source: AGHT+IEiOnEylLgNF+9L1w+lRvA3j5meacB/rQdD20+QVxiSevLyWsrd6p/MBbNHQXNn/231nICOASSHg2VCUU7Pcdw=
X-Received: by 2002:aa7:d9cd:0:b0:523:38eb:395d with SMTP id
 v13-20020aa7d9cd000000b0052338eb395dmr5642255eds.9.1692655862479; Mon, 21 Aug
 2023 15:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
 <20230821181339.4135800-2-alpernebiyasak@gmail.com>
In-Reply-To: <20230821181339.4135800-2-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 16:10:50 -0600
Message-ID: <CAPnjgZ0BtLrWADzAbzLOv6Z5TnwANQDgO2VNrGPjNJzYWyQ9KQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] sandbox: video: Display copy framebuffer if enabled
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
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

On Mon, 21 Aug 2023 at 12:13, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> When VIDEO_COPY is enabled, the "main" framebuffer is a cached work area
> in U-Boot allocated memory and the "copy" framebuffer is the hardware
> frame buffer displayed on the screen. The sandbox SDL video driver sets
> copy_base to indicate support for this, but it displays the work area
> instead. Change it to display the copy buffer if enabled.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
>  drivers/video/video-uclass.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
