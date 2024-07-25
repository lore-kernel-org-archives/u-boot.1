Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ABEC3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27278869E;
	Fri, 26 Jul 2024 01:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TD1tPwy5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F70884CA; Fri, 26 Jul 2024 01:32:49 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0EDA88621
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso656076d6.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950363; x=1722555163; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4te7+p9ES5HsPPrHljnEu2t45LXg5GZAwSyZtt9cAC4=;
 b=TD1tPwy5xCMKUBVVJsEgh+nXgFLe50ebu3khK4SyBLlAEQIFJhcoxwiGlblI0ZuVpx
 MgQyo2n3LQIvdDdEPBWRBtyVLGAkVADPOdClnlrlo8d+Igo9PkqisrKoB9jEa7wjXh/Y
 oO4hM7mojq7lH2IyKs2hJF73ibKtACbHT+S6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950363; x=1722555163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4te7+p9ES5HsPPrHljnEu2t45LXg5GZAwSyZtt9cAC4=;
 b=YsW3OnpxlhDrJg1Jyr1m9WcGVGDAa9xghRATMoVbHfuao9J2F3y1j64IvIrjHTUC18
 Qe8HB9lnxbwF7rhcu5nkbayvgZxlQUuiXJqCAgftrt6xgxYXAcQM11tJRKXlqvRywpzo
 +l1tOWjXIVYcylU3oyB/8sSE1Va7MWfKF1AJywAFpY87Y+R+DGBBg2pfJdOT6EIfPN7r
 0vEWEeepfMGhI0uDFTfMsjOHQafO/WIp8RtkSrZ+bv9ukIhXaxhmumq21EZc5zhvL9Y9
 TJ+PLe8sWLUkkBNe+9P/H22r1F0++B880m7FKLZE0laz2qNcJZdMjYQRweiVQuvB2gYV
 vyog==
X-Gm-Message-State: AOJu0Yxv1ACkgM6lBDngxT0w/Kcc6MdHVH+kWOBeZHuZBeGA0fu+m2e2
 iX/d1kymYrkldsFvPj9f9nb79z5heu1YKdxFFpRgcMELqkZIxKcvs1FpSOqNnCjzVISPxBY/rQx
 OiwIuDFZ9oP9EiwF4GFXernSnAJJfsimF9Yji
X-Google-Smtp-Source: AGHT+IEMyivrHMtmSxeU3/J0o061hy/e8i1o3U042Oidujx87dvd18ObPI/F9FHWG/tDkcmP09BFmeLCpxhhAqzh+B4=
X-Received: by 2002:a05:6214:29ca:b0:6b7:ae86:e33e with SMTP id
 6a1803df08f44-6bb40862149mr38543546d6.37.1721950362790; Thu, 25 Jul 2024
 16:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-25-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-25-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:32 -0600
Message-ID: <CAFLszTj-+LgVc7ychfuiQXB27WRVzAuqUCV6wQvBLgk0_PzwKg@mail.gmail.com>
Subject: Re: [PATCH 24/40] lmb: add a common implementation of
 arch_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Almost all of the current definitions of arch_lmb_reserve() are doing
> the same thing. The only exception in a couple of cases is the
> alignment parameter requirement. Have a generic weak implementation of
> this function, keeping the highest value of alignment that is being
> used(16K).
>
> Also, instead of using the current value of stack pointer for starting
> the reserved region, have a fixed value, considering the stack size
> config value.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  arch/arc/lib/cache.c        | 14 --------------
>  arch/arm/lib/stack.c        | 14 --------------
>  arch/m68k/lib/bootm.c       | 17 -----------------
>  arch/microblaze/lib/bootm.c | 14 --------------
>  arch/mips/lib/bootm.c       | 15 ---------------
>  arch/nios2/lib/bootm.c      | 13 -------------
>  arch/powerpc/lib/bootm.c    | 13 +++----------
>  arch/riscv/lib/bootm.c      | 13 -------------
>  arch/sh/lib/bootm.c         | 13 -------------
>  arch/x86/lib/bootm.c        | 18 ------------------
>  arch/xtensa/lib/bootm.c     | 13 -------------
>  lib/lmb.c                   |  6 +++++-
>  12 files changed, 8 insertions(+), 155 deletions(-)

How about not having a weak function? I have to wonder whether powerpc
really needs to be different? If it does, I suppose we could use an
event to deal with powerpc.

Regards,
Simon
