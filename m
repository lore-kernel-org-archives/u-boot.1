Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12003C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4FB288CB8;
	Wed, 25 Sep 2024 14:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ajsTgSQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1CB88CE1; Wed, 25 Sep 2024 14:54:04 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0C588C44
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb2d2a7d48so963536d6.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268838; x=1727873638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=84A2sWNbv7T1qwsSgmqovjuDxxiroacnvSKNHYHUJIM=;
 b=ajsTgSQKZlbNq6n0tBCZ3uXt/YIz9gK08OeLXFTaiMgbDK8AWF4iUiGLkKPVfmB2PS
 XTz2ubH9koVv3vsTwVjXushVc+lwlXh7e7I/6rt/J316o0if1aZWMRc/FigM/GpuVgbc
 ttGBbf0F11btLXE65MmfPIYCY5SnmEPMQ1Fzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268838; x=1727873638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=84A2sWNbv7T1qwsSgmqovjuDxxiroacnvSKNHYHUJIM=;
 b=AsNoSdU84FqOR/PqsyphNh4A4UX4ZtWedoLLEQo4JMoRzPxqKmbXkBJszir3HI5eSj
 Wd2J+EaDWVu6Wj8pxDbc+UD4hmM/BqrjxdkjUlWVCLq0uv7oysOLQtjFLMcP8j53jGaf
 Exfj5phgwUmW+NZ9501pGL/Zb0xZpmroHVVQQUi7qDETdxebxIj/i1xSqWFgFde/FPqC
 CsGo4XBr2Es2OL+1RGsrvVuBoSbpKQ1oa0YyYpI3WXWbhze6/Wyy2ZddaYM4BgJS/ssb
 DvM/1oRt7odppowDIsXk0hHMNABTE9ZxfzFeaci/kVk2Lz4rsMGo9GQJt2sKRR7Zh7Gm
 YqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/VVah78C+msHulII/XooIY8jFuBkqufuFdPYjfUmqYEn/pSMsZloujF6A1t+Ijav2otGILZc=@lists.denx.de
X-Gm-Message-State: AOJu0YxedNn/GEiSYo5bpTfTPjxhU6Chm3rYzd8FTxjZfb83WXcogcpn
 Dv2HcBx/DNwQHIeTFKNzjMR+yX/wKRcUAGAdJlf0ddiVpIKK+vSkrnIB3Y6uMO2oXKVzOBG15Wr
 kD7C/oA11u29wEPGd6nwsVbQgoKa0Qg0HH/Q1
X-Google-Smtp-Source: AGHT+IFKW6+6vZZWn/gjU7z4YlMXyDKkzpz5CXv0DxHEJCrlMXtX/5RX268ONvElf6mLSMVOCr1oHlVD4SMwDfIfXDE=
X-Received: by 2002:a05:6214:4383:b0:6c8:f32:553c with SMTP id
 6a1803df08f44-6cb1dd6d4admr33388656d6.25.1727268837845; Wed, 25 Sep 2024
 05:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240925104501.44457-1-sjg@chromium.org>
 <478ac7c2-88cd-4880-88da-2c786930ad2c@gmx.de>
In-Reply-To: <478ac7c2-88cd-4880-88da-2c786930ad2c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:53:46 +0200
Message-ID: <CAFLszThLE=PADovhbDTH9v+0XkGygBNGtAFrOnyte1FcUhpGyg@mail.gmail.com>
Subject: Re: [PATCH] sandbox_spl: Restrict use of UPL when not enabled
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Wed, 25 Sept 2024 at 13:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.09.24 12:44, Simon Glass wrote:
> > With sandbox_spl we want to use the file-based boot in CI, so that this
> > flow is tested. The recent UPL change enabled booting via that method,
> > thus overriding the file-based boot.
> >
> > Correct this by using UPL only when the --upl flag is given.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 91fde8e1764 ("sandbox: Add an SPL loader for UPL")
> > ---
> >
> >   arch/sandbox/cpu/spl.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> > index 1c33a520c64..76638362564 100644
> > --- a/arch/sandbox/cpu/spl.c
> > +++ b/arch/sandbox/cpu/spl.c
> > @@ -55,9 +55,10 @@ void board_init_f(ulong flag)
> >
> >   void board_boot_order(u32 *spl_boot_list)
> >   {
> > +     struct sandbox_state *state = state_get_current();
> > +
> >       spl_boot_list[0] = BOOT_DEVICE_VBE;
> > -     spl_boot_list[1] = BOOT_DEVICE_UPL;
> > -     spl_boot_list[2] = BOOT_DEVICE_BOARD;
> > +     spl_boot_list[1] = state->upl ? BOOT_DEVICE_UPL : BOOT_DEVICE_BOARD;
>
> Wouldn't the UPL method check if the loaded file is a universal payload,
> and if not the BOARD method would be executed?
>
> In upl_load_from_image() I am missing a check that the FIT image is
> really a universal payload, e.g. look at the spec-revision field.
>
> Considering
> https://universalpayload.github.io/spec/chapter2-payload-image-format.html#example-fit
> it seems a field uniquely identifying universal payloads (in contrast to
> non-UPL FIT images) is missing in the specification.

Yes, that could be done as a new feature. But this patch is still correct.

Regards,
Simon
