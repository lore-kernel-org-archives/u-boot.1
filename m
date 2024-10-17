Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA83D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3078918B;
	Fri, 18 Oct 2024 01:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cnd7Lbmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC05890E9; Fri, 18 Oct 2024 01:12:07 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5694289128
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cc250bbc9eso9418916d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206722; x=1729811522; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kldVsk6Z54eErWUmX33ZtFH0jYNUr9QX5fbn+FrFqNI=;
 b=cnd7LbmbUQoiBRwCq4sEWSVV0twJdK17ChHD9crEf/4kk+yTfFlYKfzJXCH+XsUgux
 uJz9C77xRuo2QFO/lRS2LFYbFBDJPnTHnz384Pq0mnv6ym2+zHctVGY2iXbYOEr0Ryc6
 WDQda3eWNfE80xqmItGJvIFKqMRDCOYXShTTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206722; x=1729811522;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kldVsk6Z54eErWUmX33ZtFH0jYNUr9QX5fbn+FrFqNI=;
 b=ikPmtyrYqFgnBqJzdp2lTvZUo9KAR5nfpYEQ6IzUBlHCbIdtx6XGo2oX2ct3f0a4X+
 QSkH3xBSXd8+CwreqykNRITtjZEOCeRDRsEa0x6EDxMNR4RkV64uxoR+MJ18KP+jZ/y2
 0vlPhiOi/NzDsYnhnu4CeAaBgcGwsWUaqDMcq2uoe6J+dHZkInFHIWDfhScT0FVW3VQi
 qW75XEYA/7yJYJK/6eDWd897zFU9I3whD58h4tjzlEtb8rRUivVXDDRctYnDudI+w3Sv
 YvVIx5XlEH5P8nqcYv2Whr+KTe7uwVcaafzctis0D2qoQLu9gVYL0yA7CL46GlbmVmeH
 dOxQ==
X-Gm-Message-State: AOJu0YxBIq9gX5ekuW8zyT+5F1KNHC/DVbMIu5iRfzRKhv9F3Yxt28Dq
 uasGeHFZlN7TluslvA87fpzORSNPK80+Tai+duJz7cUaaYBX6JXj4m2gm/sFbPzDDSjccoB9rjo
 3LGoKiAB1R8Fl5aCjwcLhPWCDR2L9IPcYJuBw
X-Google-Smtp-Source: AGHT+IEYOBSsZrtav4vIGf23vJc3BTPkLHdF26BHFTx0N346YZ0Qhyvq0LU/xocD2PykZ6Co925V09yKaCHIJGCEDyc=
X-Received: by 2002:a05:6214:2d44:b0:6cb:e813:523a with SMTP id
 6a1803df08f44-6cde14b6b2dmr5445616d6.4.1729206722149; Thu, 17 Oct 2024
 16:12:02 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 23:12:01 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjFVU=M42bj93PiNt1iOd29gUNn4YeV=zGmgLt-3qPOmA@mail.gmail.com>
References: <CAFLszTjFVU=M42bj93PiNt1iOd29gUNn4YeV=zGmgLt-3qPOmA@mail.gmail.com>
 <20240916082446.32082-1-al.kochet@gmail.com>
 <20240916082446.32082-2-al.kochet@gmail.com>
Date: Thu, 17 Oct 2024 23:12:01 +0000
X-Google-Sender-Auth: CDfpQOD42syiFtr-ogj-xuD3NwA
Message-ID: <CAFLszTh2udj=Qyf_2rzTd26Ywk81WuYRsbGKpqA5u4JMTiWMKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] binman: fix passing loadables to mkimage on first run
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alexander Kochetkov <al.kochet@gmail.com>
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

On Mon, 16 Sept 2024 at 02:25, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> FIT use mkimage from BuildSectionData() to build FIT entry contents.
> BuildSectionData() get called several times during building FIT image.
>
> Currently when fit inserts loadables, it use self._loadables property that
> contain loadables computed during previuos BuildSectionData() invocation.
> So for the first run it use empty list and pass no loadables to mkimage.
>
> That makes problem for adding signature to FIT image because mkimage
> fails to add signature and aborts building FIT if no loadables provided.
>
> The patch fixes described behaviour in a way that BuildSectionData() uses
> recently calculated loadables value, not previosly calculated.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  tools/binman/etype/fit.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
Applied to u-boot-dm, thanks!
