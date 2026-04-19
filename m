Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EC9EA7186
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 03:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFCD83B99;
	Sun, 19 Apr 2026 05:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GsJ7FwtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC9883B99; Sun, 19 Apr 2026 05:52:48 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9D7839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 05:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-671c24f23b1so3088565a12.0
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776570766; cv=none;
 d=google.com; s=arc-20240605;
 b=ZkwZhldLwYSNvhn5oCQ6r8AmSEp7tpcdZak2kFBkmM8x0gCAGhwHB1TvxsrdlfTnnZ
 59R3VYLNSLp/6Gs0Pfo6QVK2ZeSErdGDr5RwhXGTkQxCodpfnY8flXugcbNs+UhJHQz1
 LFD+D6dCGGpBwyMdiuPZXu16oa2DxUBm5o6du4BiVax+ca2Ig+IqHehtQq6DTBiyrpBY
 kzcF/oBBr3+jtFT4h+sl8rjnvA0nsrdsWqLOPRq5gSwwmnc+sVa5dVHUpcgNeLl26R4C
 vK+AwG/Dv1QpdubzELop6f9bHG0WnwktfMC3HvkmR0O2WiIsDv9ZR0OtuoB8q6GVCxl6
 yr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FBTr5W+drS1OqOKCizRw26vkYTnuevgYPrJKgPL8m7o=;
 fh=mGCDOPabMRqyfWf0ItU0NZ/rBQDBRnekra9YVlArh6o=;
 b=P4RF6/ypLSeyM2/iN3VMfYBO5D9zzFmLmo1rfraIqte/CNILXZlBox0lDxDDgstq2Q
 fbSCf3Zvoxr0j626qndH3cEgwfw9WdKSGmeHFudJu8OgI9J5BJcZKZkfup679wpqZqcR
 E0DGK+hPfzbLY+yuer/GAvtQpvRUDcW/bByeS/QaWGiuYoQ2I3geSqHccWorwZTWTuib
 PEmdBPQiF6khTrbYwr4e1Hhhzu0zvS3aF2CvidtULtMSpTl9JzoCw29hZPNi/6qVeEA2
 85fs4sc56K3GOnjtoKl24Sfl+EHcKl3IFladdpcEZ/GWOgQGTOfl/jvxf3hWcqbhQWB1
 A7bQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776570766; x=1777175566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FBTr5W+drS1OqOKCizRw26vkYTnuevgYPrJKgPL8m7o=;
 b=GsJ7FwtSwbRjebHonLsdI3KpjwVCqcYlVtKBEfc8J5D8EP/sKajMaxA0Qt2zkylqRl
 RVU/Lm2Dc/jBX2WFeZXeOVJkvXtPlx6Ag1D3Wkxz9XruYOSrrSPdt5a2xkUQd02Jn05Z
 RyT8YczPN9pOJHUZD7hWSt5AxCugQ0fh4vQO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776570766; x=1777175566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBTr5W+drS1OqOKCizRw26vkYTnuevgYPrJKgPL8m7o=;
 b=YeMjqaHIO8OVJ7tDRCqIvcl/mJtN90OSUCmKdWAS7EpmVOz6ZCaKwfulaibsgG+hJ1
 mFo0kml+wgzcogQtLfkEMIx4g1E+LdvmSOHAMxGHO/tbUZcLny7eGEqyVTdBKTC9VJqn
 wSQG/F2b0DYuLZoiUXP/y6NWRdUh3hbLx3kNpIGpYTbNspq3a3tsG16LS61GVyaDd4Jg
 NLuWgdPrSXb58CHnbyAbY6H9cxMBQp+yH6SZ6+f5h++zpQMZu6x/o+mpHDd8e5wFkGVg
 PdihlGNAE4cUU+WvxL1g+FsGQA5qNE7sLBajNa/Fq7j1SRHmmzlFhv/Ko2QtTFeAW9Hr
 z5eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/duG5bJWGDf/GzUW3qd56HxJoGaoMlfLEHccL5cWZWiMwKQzgFbA+E9DBplTgRrju1emA56mY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh47tcy+mbhe/3dWpSwpL1i6JGD1zGrk/2hiI50YgcwvRwfWuq
 HqrlwaHNKVspbK2C3xMq0GNRq+z8tPqTFUXrkLQ1UUuastlIOV+iafR9/HD9TwfFe0+P0sZ0MsH
 GZyVqfQISyYZTyNN9MfH4UIdIBNFNQ2XNrkCYHWjy
X-Gm-Gg: AeBDievUt6pdwZlyC0dTiHmexdzZWmTINnVKylyHpJjbvsPThe+V2cUHhCBjqG60Cu1
 ewDDPjn0V+gf6xRfzcQWX7X5gsuPX19bZxScl2Sabp91gRkX6jrIfAJe5B1ZOFU2wWoPrSJFLfn
 gQh5RjdPCFkGfjzFSipmciJpsBKGEA7iP0ekgLtQCWV12GDohI2Ros68bwODAhB2wLcLMcqF7I1
 3LMJcRDeahoekhgt1Rb/R2ZiTK+I3zDjeO81DSa+O3oA33kp3C5nsPuHi6B4OYLr6oH20Q5Kmq3
 oxi7EWgEZ+PdviQIimCz
X-Received: by 2002:a17:907:26cc:b0:b9c:6ef1:ed13 with SMTP id
 a640c23a62f3a-ba41a0474c8mr389707666b.31.1776570765535; Sat, 18 Apr 2026
 20:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-5-rs@ti.com>
In-Reply-To: <20260413203555.1990337-5-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 15:52:30 +1200
X-Gm-Features: AQROBzAdeKtIfskbScsz3tY_WAMfcAfYVsh2V_2LSrX2CCV40TohNV4tSHGPQPc
Message-ID: <CAFLszThZrWV0OOB1_fuwi0X=ipiYoJ6G9yjdkUCeN_puimnE+Q@mail.gmail.com>
Subject: Re: [PATCHv3 4/6] efi_selftest_memory: check for duplicates first
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
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

On 2026-04-13T20:35:52, Randolph Sapp <rs@ti.com> wrote:
> efi_selftest_memory: check for duplicates first
>
> Check for duplicate memory mappings before reporting any incorrect
> attributes. Could be that second allocation has the correct type while
> the first doesn't. Knowing there is a duplicate in this scenario is
> more helpful than just reporting the first mismatch.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> lib/efi_selftest/efi_selftest_memory.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
