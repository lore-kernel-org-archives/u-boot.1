Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065D4C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 09:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41041876E2;
	Fri, 27 Oct 2023 11:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="KykamI+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2AF0876E4; Fri, 27 Oct 2023 11:49:54 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABEC876CF
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 11:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ptosi@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9cf83c044b7so186726866b.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698400192; x=1699004992; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3VZtMxOpvKNKCczBDVVUUnvAzlt2oINIPMw5WfXCqc=;
 b=KykamI+y6oVhyOtK2/ydpQ2k2kVe6N0N8xVoGfD3oOs3AQNtM9WxVZgA1ECej0IRvg
 0mi7UKJoMMJgXElecwny+dA7UaNKyQiofJUxiW/LE3t1XGDSApJqfJObia2nhvyPeSZu
 obwCGLBpfeYhTkoC+bYfdW2IhQ54SZ2SCUm0D7ayMczYCeYPdHXDRRVWpZy0VhRbXdCg
 Sc5zpMS+AxkndyUq50bYJ8sgC49h+klklfcYOzApmlZJjWlmJB9dxNtyo25UWE/ELEOw
 0HLm58aKLZj4EolRq0fesWZe5y92vj8OBNbUYjUkxXBLtkqnWmX97502Lld2QuM2GdIR
 M/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400192; x=1699004992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3VZtMxOpvKNKCczBDVVUUnvAzlt2oINIPMw5WfXCqc=;
 b=qkYz50Fxl11rYjaBrRYhG0b1ENuzuVShbNvxBwGXi+u4DehwS9DJf7QWgwPjFEeljE
 fW0SX5PZGBkFtZoq/KGvZ6OK/KY4ylSDoJCXANUsLzFe6QfiUo//EXF5o0MKdF4uFrU6
 kCFIDybnFLu0YjhhHGvMeounbs+70F6QcPaKnljQimEXG2enQY1+h1WwiIx2bjkMhvma
 VNyRedsqpMnL1h7dXR0KcXeipzZ+qrvxVw5R5Pq9NHNNaWJjd1LIiIDPAwlX5QZAVtGr
 xQaaU8qICBCgPYZIluFVuwIjZUynG9EDlpB6p/Vh4XOWIolxLL14MovR5CO5/QyhqZcs
 CB6g==
X-Gm-Message-State: AOJu0YyoibbQJLCNRiTL7yx62kY16sxttwRlSbUWftJtL2GiW5BqFQ0K
 tlThGDGzx6unsjkhrKhkdwg/PQ==
X-Google-Smtp-Source: AGHT+IHMkfMek+9qwazEntK/7//PUipk5uA2okBavWL3/XCENHmVJHvZulLb4CFDJ7TN7Xy1KTZuNQ==
X-Received: by 2002:a17:907:2cc2:b0:9be:5ab2:73c2 with SMTP id
 hg2-20020a1709072cc200b009be5ab273c2mr1856281ejc.58.1698400192120; 
 Fri, 27 Oct 2023 02:49:52 -0700 (PDT)
Received: from google.com (8.239.204.35.bc.googleusercontent.com.
 [35.204.239.8]) by smtp.gmail.com with ESMTPSA id
 s23-20020a1709060c1700b0099bd7b26639sm930033ejf.6.2023.10.27.02.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 02:49:51 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:49:47 +0100
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Will Deacon <willdeacon@google.com>,
 Ye Li <ye.li@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>, Alistair Delva <adelva@google.com>
Subject: Re: [PATCH 0/3] Revert HAFDBS changes
Message-ID: <20231027094947.bhtwngq26e3loya5@google.com>
References: <20231027002409.430285-1-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027002409.430285-1-judge.packham@gmail.com>
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

Hi Chris,

On Fri, Oct 27, 2023 at 01:23:51PM +1300, Chris Packham wrote:
> As discussed this series reverts the HAFDBS changes that caused an issue
> on AC5/AC5X. I think there are some improvements that can be made to the
> initial memory map for the AC5/AC5X but so far nothing I've found makes
> it compatible with the HAFDBS changes.

Would you mind briefly explaining what those issues are and/or point me to the
discussion where it was decided to revert these patches?

The feature is quite useful for users of CONFIG_CMO_BY_VA_ONLY, to speed up the
boot sequence: instead of reverting these patches altogether, would a reasonable
alternative be to put them behind a build option?

Also, could you confirm that the "initial memory map" you are referring to above
only describes actual memory as, IIRC, some boards were using mappings **much**
larger than their DRAM address space?

> 
> 
> Chris Packham (3):
>   Revert "armv8: enable HAFDBS for other ELx when FEAT_HAFDBS is
>     present"
>   Revert "arm64: Use level-2 for largest block mappings when FEAT_HAFDBS
>     is present"
>   Revert "arm64: Use FEAT_HAFDBS to track dirty pages when available"
> 
>  arch/arm/cpu/armv8/cache_v8.c      | 30 +++---------------------------
>  arch/arm/include/asm/armv8/mmu.h   | 20 ++++----------------
>  arch/arm/include/asm/global_data.h |  2 --
>  3 files changed, 7 insertions(+), 45 deletions(-)
> 
> -- 
> 2.42.0
> 

-- 
Pierre
