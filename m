Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDC4C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C048888E;
	Sat, 13 Jul 2024 17:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HMqm7mzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297EA87E13; Sat, 13 Jul 2024 17:14:15 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9838885D
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b0e7f6f8bso2607338b3a.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883651; x=1721488451; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lrGt6It4tXgfrhn/hjsNbdvDxiP+V/5J7RPFzMOKkF4=;
 b=HMqm7mzqwNEABtIw1Kp8cZa7d2tIX8jZo8iz7v4FLh2+myQHGlI4Ddb/7H5c9PtlEb
 8ly4pnoYY89YRMFie7jxwyjbTO+yc06zaesg7OwRK8ZP+iMfadiYQl2SCTIRz6vCcFN5
 V4RZf+2p9tiuLrSlnpFCd6df4IFeuZssQk9uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883651; x=1721488451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lrGt6It4tXgfrhn/hjsNbdvDxiP+V/5J7RPFzMOKkF4=;
 b=LgeSY7iuByQckTKytvfEOTX3hkRKlaSRd9thNdgURHZ3uXuKD6a0EG9eZpVf7KPYwM
 cVL422u0C2nPl5VkOKSbgkntZ5zj0HkDtvG6CnurPjEOePaCFx7HY42s+b4KN/8ljrhq
 XI6MVB9tKUVJ9TqavPozEGyVwUuLxcqnCzvBxzATxm/qfSH5QW92IiMVTz46mZtshLcO
 6ARbvG4GQpW+6VBMsoT/vebnBCiJu9pfR5A84E8bHQbgqEzwRcwr91r1zKoJCDvBOtfg
 jjBkuEMnHtqzb8KWhz3XUXTnJYhuvCmALLZ/pKhtIbLr7RORTPDDjsjkPu7SUm6i4gGF
 Rz/A==
X-Gm-Message-State: AOJu0Yyq1rJwonRINjPWaP9MDHVMQtWFJhFPV7+un4M6k0hoH/cIrI/7
 NTCpQseB28nLzuOhGHNKOtYgJHXffHLfAvPYJAG7qIado9qtY8PVh4Jp4cSb01RkjbIEAWcSxyt
 vwiQvMqpOLeKVO7vr3keixnjOTFSU80fYwU16
X-Google-Smtp-Source: AGHT+IEu0xo2mzgsVx0yLTMhhWNFnhDyflynDa4seoTLkylDbaCTSyG8BWjPXcpEiVeAlSJsBdgTO5z4QiYusX/yDqQ=
X-Received: by 2002:a05:6a21:3393:b0:1b6:d9fa:8be with SMTP id
 adf61e73a8af0-1c298398347mr18169637637.40.1720883651501; Sat, 13 Jul 2024
 08:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-9-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-9-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:56 +0100
Message-ID: <CAFLszTjDpnbHMtwgKXFfwz4Vcx78KRj0VsKXDr3t0-Dw_NurZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/48] lmb: staticize __lmb_alloc_base()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The __lmb_alloc_base() function is only called from within the lmb
> module. Moreover, the lmb_alloc() and lmb_alloc_base() API's are good
> enough for the allocation API calls. Make the __lmb_alloc_base()
> function static.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V1: None
>
>  include/lmb.h |  2 --
>  lib/lmb.c     | 39 ++++++++++++++++++++-------------------
>  2 files changed, 20 insertions(+), 21 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
