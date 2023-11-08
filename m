Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC47C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252A687724;
	Wed,  8 Nov 2023 05:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cDT3wCta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF808772E; Wed,  8 Nov 2023 05:26:55 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA3A88772B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a87ac9d245so78054207b3.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mNYz/OjFTNr2g0x1YzQn/hT0auo4qJ7gU5Axkf4kTno=;
 b=cDT3wCtaBwAveM67rmc1bCDqaH9h2XYshUEILhjGmyIomRkBkatRh2HtAF3Iw//GLO
 ZumFEzAk7Y+IRUuDUdMzqOVAcMWe8wqrjPqIFz4nKHlCyE02yxkJUp9OnWdUPSRnniRF
 m5kOxcOWH5EJresWj/SIqPyPHKOnyKzS0HlU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNYz/OjFTNr2g0x1YzQn/hT0auo4qJ7gU5Axkf4kTno=;
 b=YFQeqckAo61acgNyY2Uup63F6rwj1pkbWx0nstFw/HaZx6UYUHC+nv+kIIfZ/4BNg4
 fY/F4Q9eCFpbwgOKlCk10xhr9iG3sV91nzAho1VOnRKWvRGn7sv5pQwsUtK7+bpRl0ph
 95pFXJ8uiEYuAS11RveX7JZhwF3ptzGVlNgvF/hBQTEkfm1gGwGLZnYnE+k9k6OHo6Vd
 5+wsSKeRgDd1Y4VQCjqUSUYoaC8nt6jgwSOz4MTiPb/FGVTgmvzGhCian4ptwDOVQAZg
 R9hT2AuXGBh4Uv/M0OJxFObiWood8i3bMiKiaTwz7h6L8hCYZ/lcKtGIhdopl2nYkNBO
 OLyA==
X-Gm-Message-State: AOJu0Yyhv/pfo6SG4aM7O3irYkpjMwdypsTN6ASs7vhI+e/XYxTsLeIF
 w91EOiZOo+kh+bhoT8bfwixjqfOadNnVbv4Jt+/6PA==
X-Google-Smtp-Source: AGHT+IEYCYniYspEfJ4m5y+ezJgGOrFDxgozrARn4JTM39bstWiIvmbB95fk78HWQyQLxwEo6d3wrvJ2rFPHGZfn+F8=
X-Received: by 2002:a0d:da02:0:b0:5a7:a874:d83e with SMTP id
 c2-20020a0dda02000000b005a7a874d83emr669251ywe.42.1699417608100; Tue, 07 Nov
 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-14-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-14-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:57 -0700
Message-ID: <CAPnjgZ0zLsf-8Mok5pgGaiK8PSSjeh-L-+xXJAESZt01ErObbQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/25] test: spl: Support testing LEGACY_LZMA
 filesystem images
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> These will soon be supported, so we need to be able to test it. Export the
> lzma data and generally use the same process in spl_test_mmc_fs as
> do_spl_test_load.  If we end up needing this in third place in the future,
> it would probably be good to refactor things out.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  include/test/spl.h       |  4 ++++
>  test/image/spl_load.c    |  4 +++-
>  test/image/spl_load_fs.c | 23 ++++++++++++++++++-----
>  3 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
