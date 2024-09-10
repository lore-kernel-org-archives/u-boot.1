Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E25DEDE9AC
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACF1890F1;
	Tue, 10 Sep 2024 20:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ByG84xrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDFA890F1; Tue, 10 Sep 2024 20:41:44 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844D889037
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c3552ce7faso1049626d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993698; x=1726598498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OYzu9opjWxlxAxKiI/M/W5XPfocF09R25XC1ZReoUKY=;
 b=ByG84xrJZTX6cPPbl+/7QWAM7sN3sHIJK0QM6KSwGkKgEfEqy+2iBb09RUN4DVPAwL
 MS8wKA9S4RwJIdXwCb+OElyazSZ12IxChx5nb+w17Rnwq25u6K5+WkInLpyScXd8BKbj
 RCq2hMikWxGsXrpQHAtZZvoGJK5Kt40TlGDYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993698; x=1726598498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OYzu9opjWxlxAxKiI/M/W5XPfocF09R25XC1ZReoUKY=;
 b=qTzhZj9+ybqr8jPyZxJZilmWNFwLJzZHfDer6L2kn65Vk6zoport7dMdiN5hJZWUki
 kZYL8lGd+wE/UBVRtg4YA7G/xNuK4GYKeMtXME1x2sTLSXFLSMx3tUz5MxIAhsYX7DZi
 Rug9k206NCp6nXbAJanxwZGcBkvEeDXVDyilrq/QCvnVl5yHKufhim9FZUx7B0URfgo7
 fwmQMnOR3DlKYWSvuoAGSz9YW0iAYAe1GB3GlR7jOXML98aa3mSZAvNar14bW16butdn
 qZspvSBrvO/PNv0oi7/cLWxW+PYx1EWrU9OhNw1a2aUPYX976RT0z0r6K9ZbJDjjfS5s
 TakA==
X-Gm-Message-State: AOJu0YyM8hk5VdHFIRF9O5pq4Kx7OPfl1PPfHH0guFR7itfbULxgskmd
 MpukaqKn7ej229MTqsP79BQTkjMR43tccHnT7ut/QYLL19l4wOfkEHfTRQPBCrnnv2yWrf2xJB9
 xe/Gi96esYOBhscduD8EGXbrqxLVJ7SPkfZi3
X-Google-Smtp-Source: AGHT+IFxv6G6Z7S1MTr0mMVkzbs/5Wo9jZgPpuPE9UxWMLLaPB5nhkBL3mRqLjtwXdA168mYfYp5HirEI07p1Mr3nGQ=
X-Received: by 2002:a05:6214:1241:b0:6ad:84aa:2956 with SMTP id
 6a1803df08f44-6c554d4e4famr72863206d6.13.1725993698342; Tue, 10 Sep 2024
 11:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-4-sjg@chromium.org>
 <B266038B-370F-491F-A047-52F6A0B2882F@gmx.de>
In-Reply-To: <B266038B-370F-491F-A047-52F6A0B2882F@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:41:26 -0600
Message-ID: <CAFLszTiyBQSn4+kBAGTtamxucJKNJfcgC9AzYBhb99F9youhcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] efi: Show the location of the bounce buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>
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

On Mon, 2 Sept 2024 at 05:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 2. September 2024 00:22:59 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
> >clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
> >lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> >
> >This feature uses EFI page allocation to create a 64MB buffer 'in space'
> >without any knowledge of where boards intend to load their images. This
> >may result in image corruption or other problems.
> >
> >For example, if the feature is enabled on qemu_arm64 it puts the EFI
> >bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> >1088MB. The kernel is probably smaller than 27MB but the buffer does
> >overlap the ramdisk.
> >
> >The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> >version being dropped. For now, show the address of the EFI bounce
> >buffer so people have a better chance to detect the problem.
> >
> >Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
> >that the feature may be removed.
>
> The functionality is still needed. A warning is of little use: what should the user do about it? The region should be reserved in LMB.

I don't mind dropping this patch if we can get the other two applied.
I suppose my main purpose was to highlight this sort of issue and get
something in the commit log about it. For me, the message helped me
understand why memory regions were overlapping.

Regards,
Simon



>
> Best regards
>
> Heinrich
>
>
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> >(no changes since v2)
> >
> >Changes in v2:
> >- Drop patch 'Show more information in efi index'
> >- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> >- Add the word 'warning', use log_warning() and show the end address
> >
> > lib/efi_loader/efi_bootbin.c | 9 +++++++++
> > 1 file changed, 9 insertions(+)
> >
> >diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> >index 5bb0fdcf75d..9779dc09b5e 100644
> >--- a/lib/efi_loader/efi_bootbin.c
> >+++ b/lib/efi_loader/efi_bootbin.c
> >@@ -211,6 +211,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >               return -1;
> >       }
> >
> >+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> >+      /*
> >+       * Add a warning about this buffer, since it may conflict with other
> >+       * things
> >+       */
> >+      log_warning("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
> >+                  efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> >+#endif
> >+
> >       ret = efi_install_fdt(fdt);
> >       if (ret != EFI_SUCCESS)
> >               return ret;
