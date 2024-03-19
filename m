Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9751C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 11:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1609E87D37;
	Tue, 19 Mar 2024 12:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="W9ls0vCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ACB487E47; Tue, 19 Mar 2024 12:39:12 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6208487B2A
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 12:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ptosi@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a466a1f9ea0so365101266b.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710848350; x=1711453150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HZeJZdZYyKvD2JO7tdY+/ghfWY/cavGBbuL8uXFmleU=;
 b=W9ls0vCptyeTGp3UQpNLBAue7Vj+Z8Zh0s9phaM8DFEjt+9iwIUBY1FgoZN/RGLSzh
 EHC1HMBXqdE+9BCdA0I3jQC+U5SKodZPkQmbZLWa+EkjTsz97YP8YrAIsKkAipf2TF/P
 39xuE6FeALVFE3TRaYiFDI9gLF6VTlEG0Fxi4TbxAgciSfLh7csClAlhaK3b8sovdCwT
 sQY7Lx0tEvq4EM6S/mFRA8dT5cXpNCMV+kNrIrMI3AePjswZFS+bsukKouW7NqewbJuq
 DS7z5LcISbHWDBw0pnQB0AvQjaP1IJ/F+QWX7CntYTvncWRQ/BlHk9Nz5fEFwLWrtxvZ
 ewIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710848350; x=1711453150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZeJZdZYyKvD2JO7tdY+/ghfWY/cavGBbuL8uXFmleU=;
 b=bgYLqZ/MDuGm0mZKKUZ+dn+RrYmAQtYx6C4erN7kXVhwhy9faF3mTAdyIcqNo1skIy
 2wI6kjdsqCX1Zz7cbihlclI9e41U6UAVPv+Oyp4a39qYX4tb30fCBB201bQaISY7zDhH
 pvrX+8UiaRRyDoxT8wF7hH5QTonIiYGBOM89jqATzTjOLg7ASOkeoASdT2rg+2sbLTE4
 XLKA+O22vOAD4G81aUGXKfoYZyFZ0gVIZURFZbS2quRxCm18b4W2Mv3FVOBA5YFH9xZH
 1DwHImca8AFd9xrgQPfJ5gk8VfyCmxnhBemUbdE/eyY9hQxRCTq0pUCEKhSZ4Ze3tbCL
 mgJA==
X-Gm-Message-State: AOJu0YwuwpL4TBCu7orSNQuXDo2lhStokWkZzbMvOHwRIKD0TjdHbILe
 gBSzzWAzyk6SaaZ09XWUmwLO4yjkHRJt4+z5q6hoS3X6pY1nTcFDJ4X4m1xbpw==
X-Google-Smtp-Source: AGHT+IFr/SAu6ZtM7+iW/haGv2qLYOCPvgKsL4aww/HWVzZDdABG2J2Mt/3wzL/XrHdMR0beSn0RQQ==
X-Received: by 2002:a05:6402:c47:b0:565:7b88:1cff with SMTP id
 cs7-20020a0564020c4700b005657b881cffmr9745599edb.11.1710848349686; 
 Tue, 19 Mar 2024 04:39:09 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com.
 [34.90.227.64]) by smtp.gmail.com with ESMTPSA id
 er27-20020a056402449b00b00568d2518105sm2656268edb.12.2024.03.19.04.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 04:39:09 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:39:05 +0000
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
Message-ID: <qnca6it6fh6pznsvm33rwa3pf6ushtkpvyui6fds43fcdjxcz5@66tiqctl7arc>
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
 <86o7bazheg.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o7bazheg.wl-maz@kernel.org>
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

Hi Marc,

On Tue, Mar 19, 2024 at 09:43:03AM +0000, Marc Zyngier wrote:
> This seems pretty reasonable, thanks for looking into this. However, I
> can't help but notice that this is done without any BBM, and no TLBI
> either.
> 
> Are we guaranteed that the updated page tables are not live at the
> point of update?

This means gd->arch.tlb_addr pointing to the live PTs during setup_pgtables().

In arch/arm/cpu/armv8, setup_all_pgtables() runs with SCTLR_ELx.M unset.

In arch/arm/cpu/armv8/fsl-layerscape, setup_pgtables() is called twice:

 - early_mmu_setup() calls it with SCTLR_ELx.M unset;
 - final_mmu_setup() overwrites gd->arch.tlb_addr before calling it iff
   CFG_SYS_MEM_RESERVE_SECURE is defined i.e. if CONFIG_SYS_SOC="fsl-layerscape"
   so that <asm/arch-fsl-layerscape/config.h> gets auto-included through
   <include/config.h>.

So can CONFIG_FSL_LAYERSCAPE be set while CONFIG_SYS_SOC != "fsl-layerscape"?

I suppose Fabio and Stefano can answer this and/or help with ensuring that
setup_pgtables() is never called on live PTs.

Thanks,

-- 
Pierre
