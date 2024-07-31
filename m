Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637FEC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E446F88A08;
	Wed, 31 Jul 2024 16:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U5Wu9Y4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 745B38897A; Wed, 31 Jul 2024 16:44:05 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524EB88A08
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b7b28442f9so65201996d6.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437042; x=1723041842; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PSUBiyMmRVxE6QbSmG/GWb518zSVX/ECZF4D++6OSXc=;
 b=U5Wu9Y4ww/kPUev6sLd3NO1faA0G8HMpym1njqKT+onBiSJXEJUxL6Dhe08dipo9Fr
 59Bud6n+57vYvW+uAtOsimsL7r8Jgtaa7pEIlyYlnJJ+orsSF6mtWxWs9dMh4ABwTbsy
 bmPG7AiYS3d00ZRcRCUdmy2UDLKVIjUXMFFkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437042; x=1723041842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PSUBiyMmRVxE6QbSmG/GWb518zSVX/ECZF4D++6OSXc=;
 b=goMYoJ8Z+tu7dksmydSM43wSEjcuiXMZEN1w435C4HpZdVl3dD/Gs96IJ+Ghuhgjib
 7NGiIgqKeoNM+LEvRi+4UXb5CrDm/22GFaGgYjR4zxBCYARAAM31agGMTc1liIG8DWYl
 wY/qI0/3JhM7hEUsjZwC1ufx5IQrD81ZQtViVGl0bKQ1yzTRcWe8HctcXPYhyqx1Vgyi
 QxQxiVajGVZfEdS/qzy4EWzKoZ6Lfv/ASQQJCv83MAMp2kL2l38mkkmIKMCob1VR0CVK
 RsVEaCBVVW0KkJ/3sFRaTaldWolEDxHTmrnzVTJ0YWBjsf176sQmclfnZzPh0TipGCn8
 nmUg==
X-Gm-Message-State: AOJu0YwWbUOWmtprbUwGQMoMYGkrCvl883U/kFD6mcaTotisof+Ggd5y
 1TdUTI+vPdIQHLd1cob+SWX1gTlYK/bjwMEJwPsqkgqUoHySYCG3Ydo0co2+AQbPE/oxiMfNz9D
 M/mtUoE7UR5924kAtb/PTXFuht2stJkzSfG2iLE1kl4Jmb2k=
X-Google-Smtp-Source: AGHT+IF5DgXe7oxWdT+pX1rPbESfm857PvtlAcAVAs7tnhJiYgZ1Zn1roF48ZO0iKZBWxojgtO012ufF0fsFKaN+apU=
X-Received: by 2002:a05:6214:b65:b0:6b5:97:1796 with SMTP id
 6a1803df08f44-6bb559b4d37mr229714176d6.12.1722437042138; Wed, 31 Jul 2024
 07:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240731144112.787509-1-sjg@chromium.org>
In-Reply-To: <20240731144112.787509-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:43:51 -0600
Message-ID: <CAFLszTj0ByN8GA=AFAfJa0uWdGZ084PN38TgKFYBy0btGnX+iA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] video: Improve syncing performance with cyclic
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi,

On Wed, 31 Jul 2024 at 08:41, Simon Glass <sjg@chromium.org> wrote:
>
> Now that U-Boot has a background-processing feature, it is possible to
> reduce the amount of 'foreground' syncing of the display. At present
> this happens quite often.
>
> Foreground syncing blocks all other processing, sometimes for 10ms or
> more. When pasting commands into U-Boot over the UART, this typically
> result in characters being dropped. For example, on rpi_4 it isn't
> possible to paste in more than 35 characters before things fail. This
> makes updating the environment or entering long commands very painful
> over the console, since text must be pasted in chunks, or the
> vidconsole device must be dropped from stdout.
>
> This series introduces background syncing, enabled by default for
> boards which use video. The sync rates for foreground and background
> are configurable.
>
> With this series it is possible to paste in any amount of text to the
> command line. Some sandbox-specific workarounds can now be removed and
> sandbox video (./u-boot -Dl) is significantly more responsive.
>
> This obviously increases code size, since it enables a subsystem not
> normally used by default. However it only applies to boards which have
> VIDEO enabled, which are presumably less worried about memory space
> since the video code is fairly large.
>
> Also it is possible to disable CMD_CYCLIC and reduce the growth to:
>
>    aarch64: (for 1/1 boards) all +1081.0 rodata +65.0 text +1016.0
>        arm: (for 1/1 boards) all +945.0 rodata +65.0 text +880.0
>
> Without that, the increase doubles.
>
> It is of course possible to disable CYCLIC and still use VIDEO but this
> reverts to the current behaviour
>
> Changes in v4:
> - Imply SPL_CYCLIC if WATCHDOG is enabled
>
> Changes in v3:
> - Drop inclusion of kconfig.h in cyclic.h
> - Adapt to new cyclic API
>
> Changes in v2:
> - Add an SPL_CYCLIC symbol
> - Add a lot more explanation about the header files
> - Expand help for CONFIG_VIDEO
> - Fix 'groth' and 'work-around' typos in cover letter
>
> Simon Glass (5):
>   cyclic: Add a symbol for SPL
>   video: Move last_sync to private data
>   video: Use cyclic to handle video sync
>   sandbox: Increase cyclic CPU-time limit
>   sandbox: Drop video-sync in serial driver
>
>  common/Kconfig                    |  9 ++++++
>  common/Makefile                   |  2 +-
>  drivers/serial/sandbox.c          |  2 --
>  drivers/video/Kconfig             | 35 +++++++++++++++++++++
>  drivers/video/video-uclass.c      | 52 +++++++++++++++++++++++++------
>  drivers/watchdog/Kconfig          |  2 ++
>  include/asm-generic/global_data.h |  2 +-
>  include/cyclic.h                  |  5 +--
>  include/video.h                   |  2 ++
>  9 files changed, 96 insertions(+), 15 deletions(-)
>
> --
> 2.34.1
>

That should be v4, so I will resend this.

Regards,
Simon
