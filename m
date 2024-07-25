Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EF4C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F8A88637;
	Fri, 26 Jul 2024 01:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nQKYKBdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BE588614; Fri, 26 Jul 2024 01:32:43 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FC688498
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b797a2384cso556536d6.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950359; x=1722555159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cDl1q57p3IVLfxiPsUvWX73ejH1cYR3nZqHSphQqIrY=;
 b=nQKYKBdz+HcXiygbD9f/AXIrlEA7qyfWv3mwSRLahMo588NhgmjmXgzzWZzP6vx9kA
 NDtx3gCwTMot7Euv0z86SOURzHHc3EjAH1ik5483QhCwRFLgdXpMDcrrBaAXNExBQpiW
 boekhVmzDACoYLRWesJyX55CcoF3lwSAJcwbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950359; x=1722555159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDl1q57p3IVLfxiPsUvWX73ejH1cYR3nZqHSphQqIrY=;
 b=G70RPQPkrHplmDShlmxmCfizcgLSlGV9wOG9wzwpkbDTWSgNITOwG+tczxt7w8dWRe
 0S39svLuLcD0FjCkvhgfMnACKm12cpKOBf8nzCVrqepGPeWoH9ElzaQgUbfdX5QsOgoM
 BjW8/Q1loO0D8xvCmECVu4PGxsNo8047UqCIPkghk/HeWaIBEu8XenoxfhgTDq1GKCKg
 c/GSbLRYs2cslQnDPwwau4I2KpB4ymvqvgIj9hndQE9K3arjQoPDq4gPvj3sdDPvYs1V
 5Pc3yKZt2EN/gvF7hTftARoaVIINryu8g1s4eEZ/Uua1H4KFVfp2x2LIsixtdNa2bKC+
 EsoQ==
X-Gm-Message-State: AOJu0YxTcR3ml4IXPEtQffX4AIyqiAqpD2HHfKSw4xNRSjkAd/r17LuH
 u1zSgyOsfmWVOv94FLE4SHXRVEbDTjW8ZuVrPxCZT8+zeFn46OEYfGXN6lUIJxGOyodL8/iNY5E
 b0XPPOi5YF6q3JMkFZsGc12p2P0IFguUXVDTcwYD+XGfoQJs=
X-Google-Smtp-Source: AGHT+IEDyzPEzJl78rw1O9NothJxawKwxqdWUPzkvCVB2yZEdUi5QiWq6k6jerBMcoOqyfsC/u1vtC6BR9ZK8lkBhp4=
X-Received: by 2002:ad4:5ae3:0:b0:6b0:613a:984a with SMTP id
 6a1803df08f44-6bb3cac5322mr65893476d6.44.1721950359419; Thu, 25 Jul 2024
 16:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-21-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-21-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:28 -0600
Message-ID: <CAFLszTjhZ72T5kKw8_C5EvjV_k+m9eaXE9Z2V=2rFq8NwvWZvg@mail.gmail.com>
Subject: Re: [PATCH 20/40] lmb: remove lmb_init_and_reserve_range() function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the move to make the LMB allocations persistent and the common
> memory regions being reserved during board init, there is no need for
> an explicit reservation of a memory range. Remove the
> lmb_init_and_reserve_range() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> Changes since rfc: None
>
>  boot/bootm.c  | 15 +--------------
>  include/lmb.h |  3 ---
>  lib/lmb.c     |  8 --------
>  3 files changed, 1 insertion(+), 25 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
