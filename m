Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077CFC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D898082A;
	Fri, 28 Mar 2025 12:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZEMJsvqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 804208082A; Fri, 28 Mar 2025 12:34:21 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 812B1805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso384408766b.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161659; x=1743766459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jxnk2JPaxWVQC3NGtmQgEHF2TbMrR//OO58bwAQSpE0=;
 b=ZEMJsvqgmeVoYns8o044ESOYovJifis69nu9uzxsXAzxlKnDl+DL8N28Hiq3Ray/5T
 WW8/YOti1SGvZ0hCH+rDLMZzZMGhqRurBs+tEk8KoQkvcadAXYAT3/LvgnzRkjdKsHSo
 8LjI+CO4LayFLYPHHiVcLsAbMznagpBbMjsOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161659; x=1743766459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jxnk2JPaxWVQC3NGtmQgEHF2TbMrR//OO58bwAQSpE0=;
 b=PQsxDlSEIRUeHaaNRIP9HHgEBzm8EN/8H3rnq0i1+VMX8naazVAzeM3C0ou8P7J9E2
 QQ/5lmrPXaaq6xMKHRA9ZNoNKEdXdnGUVmfDi64N8LLpv+dozyXB9HIJuwYC6M6Toz/B
 2INznfH+3Yd1xuHOGxNMvbQ/PFBnq/3MJZusHiJ8JI6WQ1ZWofaU5yRcsdNke0vKYygz
 xTZTxmLyoQ7yPQypbPPEVSMJXGIZnd8kEBZDAiaoRcHjvWQjx9eVXd79QJBdtU/HN/Lc
 2ELGmeT9y+ZAdmLdZSl8BwKAEQVXQNllmZdppDPMB5JXh7c6QOBqApdXuFvU3oE2+B3D
 oXTg==
X-Gm-Message-State: AOJu0YzZsBg1p0THKx47BV8Bj1oGYTu6TjnyPpXY4V6PmzXxEj47lirG
 vFKMNbaMiemC5NoIKtAylzGGHi7cLEHoJ8cOTR6fgnUNenenctyz+QXKeLmM6e48BYnlWnLBqq6
 HrMBz8t9e9NCNvPHlnsXAq0pdkJPEj7abG81B+GObQpd+D3E=
X-Gm-Gg: ASbGncsJeuIpqJoRMEmDT1sHjXm2/r3UxfmIwVhwd7CN8WeBTp2wT/7jVeh2LF4TRhs
 +o7Yd7kbF77d4xMyTXKg9k7i1kb91C3u7utrbcBlW8oOFishitz5D4EipTzyiefxWYo00nsRhiY
 UxmqS77kb89IfClS/c5el5XdVlpXTaQkCSVGr+Bg==
X-Google-Smtp-Source: AGHT+IE+gHGZM3/HElpL75Tz+FS7xCddgOSAWh38TOBr+SzNwMJ9YGfA3F4jRFvr8XZ5EgesNNStd5kL4vmDf2I95CI=
X-Received: by 2002:a17:907:60c8:b0:ac2:b684:542a with SMTP id
 a640c23a62f3a-ac6faf0fd2amr700971066b.33.1743161658862; Fri, 28 Mar 2025
 04:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-17-sjg@chromium.org>
 <2723a871-b7fe-4a4b-b898-b93b750167f2@linaro.org>
In-Reply-To: <2723a871-b7fe-4a4b-b898-b93b750167f2@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:34:06 -0600
X-Gm-Features: AQ5f1Jq-nlz7PnGwIesiRvJkJ--C-fKqi_7vH9AcASUYvUxM4Rwvb_RMghJCkE0
Message-ID: <CAFLszTi-QM_F5NVc7xRgON5rM2upXboGicpumAEbAFUojrKhFg@mail.gmail.com>
Subject: Re: [PATCH v4 16/29] efi: arm: Avoid enabling caches when running
 under EFI
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Caleb,

On Thu, 27 Mar 2025 at 10:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 2/15/25 04:22, Simon Glass wrote:
> > The previous bootloader has already set up the cache, so don't try to do
> > it again.
> >
> > This fixes a crash in QEMU when booting from EDK2
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   common/board_r.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/board_r.c b/common/board_r.c
> > index 81715397544..e7d9a3b312d 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -110,8 +110,9 @@ static int initr_reloc(void)
> >    */
> >   static int initr_caches(void)
> >   {
> > -     /* Enable caches */
> > -     enable_caches();
> > +     if (ll_boot_init())
> > +             enable_caches();
>
> For the sake of consistency I think this check should be inverted.

Do you mean:

if (!ll_boot_init())
   enable_caches()

But then we wouldn't enable the cache.

> > +
> >       return 0;
> >   }
> >   #endif
>
> --
> Caleb (they/them)
>

Regards,
Simon
