Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA641C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A14811AC;
	Thu, 27 Feb 2025 17:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDURTcKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A5881335; Thu, 27 Feb 2025 17:28:19 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E920381113
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso1994176a91.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673695; x=1741278495; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8X+lLqc1fWfYO4SGtKb1Ww7PSLRGAx3o2i4YiKfNaww=;
 b=VDURTcKXuacK/XYCLlejv3I1ZCuFwUObIqot4Z4oFaUVWVUET34M8dZ28FdZ2IsnTA
 I85hHZeFPXAwkeuOd5zDBUN/mKWF59G7enoDjdlq+DJfilmGLGhIg1OhqD16Mcg2ne/j
 6D7SXdzr/HFOAbN4ENeS44KA5yWKGr20ivJSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673695; x=1741278495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8X+lLqc1fWfYO4SGtKb1Ww7PSLRGAx3o2i4YiKfNaww=;
 b=luEkQzNfewCRhNJz7Ij09NOUzBThII8IRcP/jc/xBjLcZTlTmN/neqs6kD5ullo3nF
 b6ZYnQCdvH/Vi9Ujolk+mQRT+vrOAsB5+hbK6rROYZgNL9qLLel54Zz4qAmRxpfUfHQ8
 qtmJigtjvClXeKSqnUaZzT99es39SDVWkpZDYkq3UVwpYboigICB3b1n+7/eObE6VNAj
 OLaT3R94/r7hoBk6LZ2PELNJP8tU8TKKa5sfniHopdCMVRnhGgRarVIuaF1BEmhQr3Cv
 C51dHW1yJlX69GAdqbmhibwOBVJTDyXoxJiZoiNCO9gRRMstTpAsHUEpc5k1hZ8fBLHr
 hj7A==
X-Gm-Message-State: AOJu0YyvLQ+TmaJoves9DMoRtNnD1xPUf3DWuoYF9dcd+BEGlWeMVHPA
 BdE+/E3Se8lKlF4I118y903yiVXv2KYAWaovLdf31MNz4Nrc2LYaBzyG3z69DO8MI9Myw8+qNtT
 WmwvHJ68fE3idW3SnuU4H/FEOhrvMKUDbwIyc16Eqr5hhhec=
X-Gm-Gg: ASbGncvP9Jckp5Kyr6ZP+vUUOU422T9a3kB8MtaJziu4+zHE7aK5Y5aCbEboTinZ54k
 7QCNOWD/T2miqixJ3L1P8MPZTScV21Z6+chDrgOIGIKAXv9nzrgZ/DGK3taJ/fUkkcMpn+knnfd
 sFY80NMrI1
X-Google-Smtp-Source: AGHT+IHY71bepnToZ5nacz8jCXADNVjdpBaPTg4wmWlLkQtVxb4ZVxruAuvL7c+T4HlqkAUxLrzSJJGiHis3nRpNW3A=
X-Received: by 2002:a17:90b:51c5:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2fe68ada512mr18718144a91.13.1740673695537; Thu, 27 Feb 2025
 08:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-31-sjg@chromium.org>
 <0140a9ed-2f9e-460d-85e6-c3490a9223db@kwiboo.se>
In-Reply-To: <0140a9ed-2f9e-460d-85e6-c3490a9223db@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:27:16 -0700
X-Gm-Features: AQ5f1JoXybTgvfNtapkeg7_lKEplk_9nC1-WFIMP9BY9VJ4TIdcOZFxJCBoKsyo
Message-ID: <CAFLszThFKOzEXcnE07c6-FvSPtogbV9HpynTAo9==bPZ2U1K9g@mail.gmail.com>
Subject: Re: [PATCH v2 30/35] rockchip: Set the skip-at-start property
 correctly
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas,

On Mon, 17 Feb 2025 at 15:10, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > The rockchip image is written to the media at block 64, which is a 32K
> > offset, so set the skip-at-start property to 0x8000
> >
> > Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
> > Binman is dealing with the 'missing' 32K now.
>
> This confuses me, to me the image is the output binary image. And the
> offset in the image is what SPL_PAD_TO already is referring to.

It is confusing, but there actually isn't any change in where things
are placed in the image. All that is changing is that binman is
handling it for us.

This depends on the binf series ("Honour the skip-at-start property
more faithfully") of which I'm sending a new version.

>
> The help for SPL_PAD_TO mention "Image offset to which the SPL should be
> padded before appending the SPL payload.".
>
> I can be fine with changing it to payload location in storage, however
> do such mass change in a separate series and with a clear explanation
> why SPL_PAD_TO should mean the offset on storage and not offset in the
> output binary image written to storage.
>
> With one patch that just add the skip-at-start prop and adjust to use
> <(CONFIG_SPL_PAD_TO + 0x8000)> for the offset prop. And put the mass
> change to defconfig in a separate patch.

But that would break bisectability, wouldn't it?

>
> Another option could possible be to use SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
> in a calculation and drop use of the SPL_PAD_TO symbol.

There are too many options and we should really just be using Binman.
But this is a step in the right direction.

>
> Else this blocks others from adding new boards, and/or will break them
> if a defconfig was missed. With a separate series adding a new board can
> just reference the smaller series.

OK, once the binf series is in, then this could go in separately?

>
> Regards,
> Jonas
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Move this patch to the end of the series
> > - Drop 0x8000 offset for SPI
> >

[..]

Regards,
SImon
