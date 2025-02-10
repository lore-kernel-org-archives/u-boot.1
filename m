Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3F0C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 994CA80AE5;
	Mon, 10 Feb 2025 14:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="exb8+1ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD3C80AE6; Mon, 10 Feb 2025 14:09:55 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA3D807FE
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa2c456816so4063143a91.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739192992; x=1739797792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GUZHupOZBVFx2/RGFIA6sHaQo5HRJZqQp0ucg64v3KQ=;
 b=exb8+1evkzRSdVWMXhkR2EMAPUg9Ct471EYVdt7FG0Tp0H6Gfh8MS/lkTi22Ub/drS
 0tsP4ipTWaNclIW41BsRTquzghmW2LgGETwsWdjYdnlRtiFIyP4EKJxNo2dwNyFyhkLp
 MBXWmijTw/txixspMGduGq4LAlxTwPdnoXMgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739192992; x=1739797792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUZHupOZBVFx2/RGFIA6sHaQo5HRJZqQp0ucg64v3KQ=;
 b=LOnv+5Cb3RodmBiaJh8jpoUEXZ4PwyJGMNiwT5r2lAY/PJz+p5Ttp6xhzCoU6rbf+j
 G/iVITyQtKRoS9ngc1uolj6ZXj4GDxNYk5Jkv6OmWhOlAKcxpc0b7Ih2mRFmiOpQnvWQ
 4HEWszb3al2VSnGWxUU+uUYsFU8yDvzQbMlH3RILaLiKH2xAKLr45NUTg1/VyL0zrwq3
 gbEFyrYa18UmBgrowRy/ztVwpW4GCh0kd9eP1jg2lNE0+9K6la1uxYNqsx5Imyz18Bfl
 5o60SMruLJhuZ0++5ewj9XQuQdLgJ78Lt4ptxGXndsAPiJsAUC2a2ktZ1ej+2nABmqod
 VEsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ+yRLWX0FyhlApZzOOsNVPU/n73b4Hl2ZLbtFzNqHc/tW4dHBIaRMc0/2Y8HFVZHHDO4p074=@lists.denx.de
X-Gm-Message-State: AOJu0YxR1irGyGCvL6brJWNEN+rfcBHKbJtSpQQns+cK9Vm/hOA828U5
 Bnn1UMM0+9CbJ302iWnnAkmICihRxlYzVQaRDjMkC0hIIJxVgqi2mVnkdfsdgECycLEyNjte7qB
 r0b6vyo8w3q4uE2EmsNzQXtkpF9lcDjrEmL0q
X-Gm-Gg: ASbGncsHLTlaXEn/koYSOhiVIz94e009MjOKkpE0XW2+stQaw6nkn3fXTprhMoMZZet
 h5HZ3XJz26wSsjT1HosYP+05CNirhvnje3nSToyurL3cEqAxdwV/fh4IDqIRzFWUJObH6DYh1Nw
 ==
X-Google-Smtp-Source: AGHT+IGi5ZwYb1Bb1l4f9W1n0d7QY4SOw8AAOBEnFykUs/M4kqB9e9xmY2WLhgC7uXknyN0JxVXil2Q7xKzZJCBUM3k=
X-Received: by 2002:a17:90b:4b8c:b0:2ee:c91a:ad05 with SMTP id
 98e67ed59e1d1-2fa23f41ddcmr18106377a91.3.1739192990419; Mon, 10 Feb 2025
 05:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-4-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-4-a4534bc67cbb@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:09:03 -0700
X-Gm-Features: AWEUYZkDJqmBihPdKPVvrKtw2gsnDc9v4JvOmJp2l6tDICiSAZ6c5nEQ1EnV6EE
Message-ID: <CAFLszTgzTX=S3J2FV3caYJPr45ki6WyHLaBPe1r1h39eHcw08g@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] binman: fix faked optional entry handling
To: Yannic Moog <y.moog@phytec.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, upstream@lists.phytec.de,
 u-boot@lists.denx.de
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

On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
>
> When having an entry that is marked as optional and is missing, the
> following output is observed:
>
>   CFGS    spl/u-boot-spl.cfgout
>   BINMAN  .binman_stamp
> Image 'image' has faked external blobs and is non-functional: tee.bin
>
> Image 'image' is missing optional external blobs but is still functional: tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Portable
>    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>
> Some images are invalid
> make: *** [Makefile:1135: .binman_stamp] Error 103
>
> To solve this contradictory messaging, when checking the faked blob
> list, remove entries that are allowed to be missing.
>
> This also fixes the testFitFirmwareLoadables binman test:
>
> FAIL: testFitFirmwareLoadables (binman.ftest.TestFunctional.testFitFirmwareLoadables)
> Test an image with an FIT that use fit,firmware
> ----------------------------------------------------------------------
> AssertionError: 0 != 103
>
> This test failed due to the exposed bug when testing with faked external
> blobs.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/control.py | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Ideally your updated tests would be in this commit.
