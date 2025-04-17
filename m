Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E3C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCEE583190;
	Thu, 17 Apr 2025 23:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hHMFhLsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C550C831B4; Thu, 17 Apr 2025 23:38:06 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED35583190
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so193679266b.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925879; x=1745530679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yhIxkmx2bJLt9CxwO060M1J164hbOmLWFKEzvu6+mnA=;
 b=hHMFhLsjvsrB+G2mpAJ1XHLuRLgtrIGxcfMLUavXJMTOXZA+ribs7YB3KcspQD+9GF
 f/cFSIRdeo9oEkRNP4l6vKnR5dYa8bP8H6ahpVwaOYomJIZ8xfJox/xkLlUFgvqfBPMX
 CdfDWRPp5N7osRJIFZt5lzos70GxlPnh7UCb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925879; x=1745530679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yhIxkmx2bJLt9CxwO060M1J164hbOmLWFKEzvu6+mnA=;
 b=j++FMYo0gdOTIoyachntcrIp8i3927b3GXmGAOxgX5DvJaKdLFVV9f6+oBgzfDp2zl
 D6A2eoTiT9/tJdZ/s5VguTvymlZwfvOb+iNanhut5wE6072+vUszXvPotIaBsbyS1tj3
 QrzyZKpSALN2nI0HWcRmAXh26SPSjxZLxYfPAPRxQlA0Hwqek3BpLPTkZPGcjL+Hr0kX
 j0cql+1RzVM7NXRNSQbrS3YkBoEFiJJizK8PXq2qnB9PTtvuKwQwyhPrV6ylRvh5ucY9
 ZtM4JNnUClqY96la3yQImxXwchI73HxxWIUa3aoJFNf76V7onAqS9bm5jYUbzNd9Cha5
 g5NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd4oQyRVN0yXAWNNUR69G6Cmsya80e4XACzMPq54ApQux7UVTOx8B3Km/KaG6yciDFOTt0EA4=@lists.denx.de
X-Gm-Message-State: AOJu0YwxAxBUvkM7L6YNB5ahsiLoHso1ffI2vweBFJpe9uFYsvxjRyCg
 4xk7K8vethfa0wPuFPc7LIJ00zqPlVGrJuI5GSorHPUBjnVWPk+8SzIdbGDIcfOOlDQxnEEyjGt
 tGEdz4VTRSITrB6oM8mcetgRq5+waISBoxSYjNtcbxS9+hro=
X-Gm-Gg: ASbGnctry4VK1cEHjqwpJ7BOAg+oHvcf5JqQLLj6KtijL8jeT2OiL73JAde5BfiIYId
 BJA4M4xHvjmVIh2mBHjysVOwLqW+O65qCgoOiSBXVwN4D9N0PV4sfjoDpASZR3C2VUuMDPIWTHw
 4WeSUiCXAtYJwrwjAsyNCEodA=
X-Google-Smtp-Source: AGHT+IFPEkBMtTryO8i5KU2YNZySurSXjpIB0hGJ+G5ouFm0EXm9f/5qn2+L/OqPaU9W2uR+Aa+Eve7ScArs2BhLj2A=
X-Received: by 2002:a17:907:d17:b0:ac7:95ae:747f with SMTP id
 a640c23a62f3a-acb74dd4b27mr29551366b.45.1744925879307; Thu, 17 Apr 2025
 14:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250408141436.712387-1-anshuld@ti.com>
 <20250417205833.GA3017152@bill-the-cat>
In-Reply-To: <20250417205833.GA3017152@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:37:40 -0600
X-Gm-Features: ATxdqUHm7hg7gjFi8_T7lAfKPzcTS3VvHAtAPM0OSebgw3DWlfXMuzNLOSSE-Eo
Message-ID: <CAFLszThNt=+6ufoobs_QgMqotnqKZU1UoB6B8NsKUQquv3z5pQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] spl: remove usage of CMD_BOOTx from image parsing
To: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 nm@ti.com
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

Hi Anshul,

On Thu, 17 Apr 2025 at 14:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Apr 08, 2025 at 07:44:30PM +0530, Anshul Dalal wrote:
>
> > Using CMD_* configs from spl doesn't make logical sense. Therefore this
> > patch replaces the checks for CMD_BOOTx with newly added library symbols
> > BOOTI, BOOTM and BOOTZ which are enabled by their respective CMD_* or
> > SPL_* counterparts.
> >
> > SPL_BOOTZ is enabled by default for 32-bit ARM systems and SPL_BOOTI is
> > enabled by default for 64-bit ARM and RISCV.
> >
> > The respective C files (image.c/zimage.c) are compiled based on library
> > symbols BOOTx instead which are in turn selected by both CMD_BOOTx and
> > SPL_BOOTx as required.
> >
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> So, for the series, we have a few problems, still. First, this is still
> not size neutral as we now end up dropping bootz from a few 32bit
> platforms (gwventana_nand, display5, gwventana_emmc, display5_factory)
> and growing colibri_vf. Next and more importantly, as after Nishanth's
> explanation, TF-A isn't going to support this case either, I believe
> it's best to just drop this part of the support as well. Thanks for the
> effort all the same.

With the size issues resolved this patch is a good step forward
towards being able to entirely disable CMDLINE in U-Boot and boot with
standard boot:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
