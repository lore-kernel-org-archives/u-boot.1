Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A47C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368A78773C;
	Wed,  8 Nov 2023 05:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XKs70b2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF8C8770B; Wed,  8 Nov 2023 05:27:33 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F7B87770
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dae0ab8ac3eso3383242276.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417649; x=1700022449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zOvFMJV79JK1+bLn/KrUy1Sif2voMXCGTcaBnx1jpxY=;
 b=XKs70b2QSchM5zq9Z2FtmOjAGiFXKOnkFJ2pelM3O4Nnwlt1VngHzEfpHTyO/z8T6J
 RuRXgLVg2cMPVGtgcbq8bN4umJbE6IH9Gpu7ZawygT+q6g2Q5pYF63GefDRjSzu2/MsW
 fBs1vWkkt6c3IYMequ6ihrFgLFXEVBEEez0GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417649; x=1700022449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOvFMJV79JK1+bLn/KrUy1Sif2voMXCGTcaBnx1jpxY=;
 b=kuI9MUUVJLz/qCVBZ93mNjXwyxELV8SFyHSzZkQeTjLxlFdO9pjp8w3jpiwc/t9uki
 twvxxUeVOrl7hIRhM+NX1DRyO3toKLCVPJER9pYBbu8DoetbA6KNUQjEGxz0Ea416wCa
 jpQCpPUrEE3H4PTo+HhztBcv/liHITcau82rkAKvjCDR/MYGDnmeZJSBWYPVFBDrMmyd
 FMMgFbw1iKNlRro4nmgoVJVyrEXwT+bhGzAovDyEtVdzoGAVOc1mccLLWW3ysdbVr5cq
 9CrpWQPrmWDL8otmPBqu0G5x8aSy0KcetHxECwnC2iHOYVIAZrwtlbOnzlxtoHSK5/w4
 QHoQ==
X-Gm-Message-State: AOJu0YxQIotuxEi4tCuac2OVCgluOyHj/wVtbbfpr1xKHdulC0/jt+QE
 5dM85jobaKeTWs0FXTFq5kxVbmKBjg4mAEp6Sb1cjA==
X-Google-Smtp-Source: AGHT+IFM/Y9qIZaHHZXfgA0hMoFEgYQRfbcvqGd6AHdwkpmDHMdvlXEplgO7sdSGFeg1bxr2BnEELJWdkdO2INIntVc=
X-Received: by 2002:a25:d748:0:b0:da0:cbff:4e20 with SMTP id
 o69-20020a25d748000000b00da0cbff4e20mr818316ybg.56.1699417649441; Tue, 07 Nov
 2023 20:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-2-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-2-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:43 -0700
Message-ID: <CAPnjgZ0fH-_5ub0t5rq5B2=y8g97iRx6-L_R=R-Pkz63AEjg_g@mail.gmail.com>
Subject: Re: [PATCH v6 01/25] spl: blk_fs: Fix uninitialized return value when
 we can't get a blk_desc
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
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
> Initialize ret to avoid returning garbage if blk_get_devnum_by_uclass_id
> fails.
>
> Fixes: 8ce6a2e1757 ("spl: blk: Support loading images from fs")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/spl_blk_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
