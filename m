Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A66EA71A4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9FA18422D;
	Mon, 20 Apr 2026 04:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FpjDZk07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E0884286; Mon, 20 Apr 2026 04:51:11 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F88B839D9
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so455227866b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653469; cv=none;
 d=google.com; s=arc-20240605;
 b=KSI91tu8bDg6dz80ajKjBoX+HV1sY+hDkF48D8nzY5E8HPJHJybi3GTCK5tJ9jAyay
 nHnh444cnP6qyFYRefoaLMab68KD1I3HNPgpmchovKMA7iwjPrR1L9Q8VrdPGPkNhUQZ
 t1KHdF4g5WmTCK0/3O9JF53LraCAbmxm3gYMhCLAmzMzBn+EyvWGhzL99+ZeL1ae+Ulv
 ReAMi6jonfwo/lAYLduzX6WjS9qXtpyHS9eJ4ory1bDfBl5Z2ovALBdatffL20Csg8wN
 8dYNF+THRXRXfsTXBMMYpAEMoYFjhAM02vjNaPr0wsJkoky9x+ZuQhI2iWZdJsYpOPgf
 BbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+/KABLa+1p6/3SL+ME5W+zxDE2JC6NuulVK7qkmo84w=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=GRvK/ONN8qS4tFpqfC4SBiGKZP7E/ZMnCOkgNFrEaLS55K8B5W/Xd+aNDSC4Y3+juS
 +YB0FIRaCTAuzgsCilnDSK3uZIX7/CWwRjfaeKl9lVNo6cFxThWhnnZnTmU8Ylm4/+xN
 TYISka6A0BB5vVCN0Uau+Gznyd9FHB/d+clBznuQ+RSZqTzJEuYSO2VGTC78LERZ8R9N
 bOseJxrCSjOKCJRaoXzgUvxsx5QDE2TGZq3Smhb8RYUIbuEMb6Hvkgc1K0HbOCy/XbhZ
 ULXvN+xY5IIIy63ype0Bx+lEqd4NgX0WI+ZHSlGjlLYT0JdQkuVWw1O1B+BuTAguddS+
 vElg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653469; x=1777258269; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+/KABLa+1p6/3SL+ME5W+zxDE2JC6NuulVK7qkmo84w=;
 b=FpjDZk07tNM7Dyw8IuzLeCna3O/+COxAlXeOQWCIuHwqo46H1zNK6AlXyXfLTLgzi1
 dsJCtEkUt3M7SeGmtidWCOTWTWUjo7bMI1nOOmt/Uc2Oi0qW3lwwSodtn9ezdwQ8zjyW
 AcopUr1BPXt4v2rj4cOexhDDNrsk1F4wN0XRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653469; x=1777258269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/KABLa+1p6/3SL+ME5W+zxDE2JC6NuulVK7qkmo84w=;
 b=ee6BSMGCNUplggnDTR30QdZdzy8FWgbrnvvVemZm4aFODFHxiHobxT7a0Hb3VVYsvb
 6knUnwDSzs0NiAiCy1Af1x7bXSyG8K7SqkXZT3o6DYBpAFF8mCv8gos/gXwgI4YStnPK
 47kblkfvI9AG56rP86rbHWk4wsHsJeKcyoo8xbw/PFnsaHZU3ylMxCc9mCvTJ4yzhDAp
 g19KARmS9bJ4muKJq5JwjSOCebnp5IF8qOam5fOPuAr0CVbAWUl2UVFLa+1XW/2QsVzD
 /0e3DVHkEg7UkhwIbTJPPKxSWY37rQzqf6ZNvzRBpqZTZOMkP0bqjBJDZA2Xlwdf2ojf
 14/A==
X-Gm-Message-State: AOJu0Yy7wSFurnltH1eWW5T2meH1iHi6VY5gq15a/6YjjCSubuzQFbAk
 FhwmCvlIqNPmEHTifPmYX4/tFWblWgUvAklqCfWXZhoh5PPCQqe0IEchn777SgVHM+g95SKXShV
 qo2aBDOuDad9TP8ZC3qnj0UHMKlIIYDrrisyoEt8l3ABqS1JtxSGvsw==
X-Gm-Gg: AeBDieuk8KgJVfBiqmzWjkBDD1wXa4Hkl3A3gEQZdnG2paxFDfEUHtiELegHPAkCpq6
 T1hDJ0pdu3W8L3cxC6IKlv7ASgKSGiGBvdVyx33Ge3maiQFEY5LunuRghTfKAMW6V12FAu15amo
 RrS9ImmedjGglXf5Hkl0gO2mR3SSsG7d9PyQVKbAXjxoDCi3/mlBDVJXpDtUQSiEV7+mIozNlgY
 WY1b+K5reFxlHX8Ujxhg+Ms/y9eVAEn0ZNHZ+OkPvWUtqG4oVSGf8CQxkZml+4O1G7KIkD2Alu2
 W80dHItVMLTWe8XKfPN7
X-Received: by 2002:a17:907:3dab:b0:ba7:ac06:e007 with SMTP id
 a640c23a62f3a-ba7ac06e6afmr93905066b.43.1776653468524; Sun, 19 Apr 2026
 19:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <8828f1578de00eed645b37bae41f191f8ef687c8.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <8828f1578de00eed645b37bae41f191f8ef687c8.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:50:34 +1200
X-Gm-Features: AQROBzDQxnONquoKNm00dlJtbHjJMD3dEaQy2tApP-hBwSquQZlfSXTDVmQmphk
Message-ID: <CAFLszThQvVk=9CLy2xYuC5og0KBp4AVh4cORbwnLo7R1U9EGXg@mail.gmail.com>
Subject: Re: [RESEND v4 03/14] mach-sc5xx: Update boot commands
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Update boot commands
>
> Update the default boot commands to match the expected
> bootargs in Linux and new SPI partitioning scheme.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezkit/sc573-ezkit.env           |  2 +-
>  board/adi/sc584-ezkit/sc584-ezkit.env           |  2 +-
>  board/adi/sc589-ezkit/sc589-ezkit.env           |  2 +-
>  board/adi/sc589-mini/sc589-mini.env             |  2 +-
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  2 +-
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  2 +-
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  2 +-
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 +-
>  configs/sc573-ezkit_defconfig                   |  1 -
>  configs/sc584-ezkit_defconfig                   |  1 -
>  configs/sc589-ezkit_defconfig                   |  1 -
>  configs/sc589-mini_defconfig                    |  1 -
>  configs/sc594-som-ezkit-spl_defconfig           |  1 +
>  configs/sc594-som-ezlite-spl_defconfig          |  1 +
>  configs/sc598-som-ezkit-spl_defconfig           |  1 +
>  configs/sc598-som-ezlite-spl_defconfig          |  1 +
>  include/env/adi/adi_boot.env                    | 16 ++++++++++------
>  17 files changed, 22 insertions(+), 18 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
