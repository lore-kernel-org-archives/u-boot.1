Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D514C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B2D81703;
	Wed,  2 Apr 2025 17:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WF9O/ILi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69CD681CF0; Wed,  2 Apr 2025 17:10:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D19D80194
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso49301525e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743606635; x=1744211435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yGQCFtuNnWaUJ9njrZfbAii/sFLJrckLQ04uHj3qqzU=;
 b=WF9O/ILitgrdkO+s7q72zl2tfPJCGKwWw96CKOf5ZzrGO7T29JmbX8X3WMWIGzd1uW
 YhCqTQW9983E+ZE/ujFx2T9bes6zpa3DHja3+JtVxK/BRpIx42IRAJxokfuUtxfkIcsc
 fjEVM/XOibxmVQvXnklF5bBS/RGsxbdZiUieG/pfl/pO9BxkSTCk0iDGjG4CZT6tbRYn
 nKZMBaPOmwLa/vYi78046C8nxRKpQlcVRxviztGr/67Wa763+fFOCHqi21vCEjwLwqsg
 v98bK/4WaxkG5jpN9NxiW9yh+cDtHivR5Ni+PAVkbJhC2k4gDPOFO/Hf+aJ3Hu7BW911
 8L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743606635; x=1744211435;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGQCFtuNnWaUJ9njrZfbAii/sFLJrckLQ04uHj3qqzU=;
 b=A9lavIPavtrDMLLgML++Q9Nw8OFS3YkybzLe3VCtPVdRVnLC85/E+C1Wc/Cgg9D4ZR
 ucaOn2jp998grjvTrW2Rn1KJILRKl18otryMfkqyj3Ink6LSyh33N/nvQHAFF4M5u55e
 TtCoU1YwgRoIDnMvGTrO7wavyv3Z6G+7hbngp26uk0Wd0oivh3jMErzmSdHC+TcYQ5bn
 n7TORVS7GL1gkfk8J7oXz/jqrvKJpsr2CC9TejErUVaygqOCs4xcnfDQuTkLMQ58FELl
 KtiKnoI77vc3+zKIErpMUhpnt2i36lVemxfzRSfWZjKRRKOl6/5fn/pEgcydYZbK8nGD
 /6Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEPeKXJnEK48vr5z20Khu+0zPKBuHw0mA2G1VYmJXuoZtytcZPhPk4N82TPG3Yv9kNT5UXWfA=@lists.denx.de
X-Gm-Message-State: AOJu0YzpQYy33VY3FvyGM6gk0ozLc3g2TeNs1KwqjAYMCcQMIoZ4Mr60
 ZC/8pgdNYQ0doONgyZ+84rtRH7pByAhVXNfjfFRVlPJXxNziA60S
X-Gm-Gg: ASbGncv6dU8ygUfQY+T5Xau/t2jRVOR3nj8rKJPicF5zRonGtozUvWEydS+JWHTJqDx
 xn0SmT5m99ku5tzGM8VyDIqdDaHbWANTgmV6cxulpij31ktnWf50luqSOak21Q9at1TEizTt+jC
 OIfwPWECtp9cueHHtlUK5docWYlBL1LO5OJnpV2QEgo9hLxoY0pkE3GFent5NRK5J3IM17GeKjk
 2gJJxa97i1msAgZxhtZWv1CcOLhvrrOo3jBiXF0tNGkA7uXMh83s1QdNnczztnpQnWaz+y6Y7rB
 wRluTZlM1S35jsXc14M6KawI7KvHltjvmJbL7ywXE+xIBs9/ArTjAgM6Psqgz+TxZ89rm78AwlD
 hn2KDGNtJekI=
X-Google-Smtp-Source: AGHT+IGwCIAI3nDyhL6gBBSZ0wMUNVThbcaYrcoW2FoCMfB6uJef9J286lhe9o+Csuo1M8dnhD15tA==
X-Received: by 2002:a05:600c:19cf:b0:43c:fded:9654 with SMTP id
 5b1f17b1804b1-43e9dec31c3mr83144975e9.19.1743606634608; 
 Wed, 02 Apr 2025 08:10:34 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb5fcdf58sm24300055e9.10.2025.04.02.08.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:10:34 -0700 (PDT)
Message-ID: <67ed536a.050a0220.3bc19f.b184@mx.google.com>
X-Google-Original-Message-ID: <Z-1TZ2bgDOSkVxN2@Ansuel-XPS.>
Date: Wed, 2 Apr 2025 17:10:31 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] env: Introduce support for SPI NAND flash
References: <20250401225803.27519-1-ansuelsmth@gmail.com>
 <20250402150542.GV5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402150542.GV5495@bill-the-cat>
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

On Wed, Apr 02, 2025 at 09:05:42AM -0600, Tom Rini wrote:
> On Wed, Apr 02, 2025 at 12:57:57AM +0200, Christian Marangi wrote:
> 
> > Introduce support for SPI NAND flash. Currently we only support SPI
> > flash based on the lagacy sf cmd that assume SPI flash are always NOR.
> > This is not the case as to SPI controller also NAND can be attached. Add
> > support for it by adding an env driver that base entirely on the MTD
> > api.
> > 
> > Introduce a new kconfig ENV_IS_IN_SPI_NAND_FLASH and
> > CONFIG_SYS_SNAND_ENV_DEV to define the name of the SPI nand as exposed
> > by mtd list.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  env/Kconfig            |  41 ++++-
> >  env/Makefile           |   1 +
> >  env/env.c              |   3 +
> >  env/snand.c            | 338 +++++++++++++++++++++++++++++++++++++++++
> >  include/env_internal.h |   1 +
> >  5 files changed, 380 insertions(+), 4 deletions(-)
> >  create mode 100644 env/snand.c
> 
> Since this uses the generic mtd API, it can also support SPI NOR, and
> "regular" NAND too yes? If so, I'd like to see this named more
> generically (and my feedback about naming things from the UFS one
> applies here too), and then perhaps a follow-up converting some other
> platforms to use this? Thanks.
> 

I assume yes. So maybe we can change this to env/mtd.c? Any hint for a
better name?

Can you link the feedback from UFS, I can't find it.

-- 
	Ansuel
