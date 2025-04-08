Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE87FC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 006358322F;
	Tue,  8 Apr 2025 09:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oQ1V/sOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A6883260; Tue,  8 Apr 2025 09:01:20 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDA98312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso980951666b.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744095677; x=1744700477; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1xDZ1Ag/eI+LxC+UaFIVqPQgMpm/rPVF+M0q/xxbXO4=;
 b=oQ1V/sOI8MlMQ4wYz2EI1w4a+ozl2zR04yalvpSXtBepVEdS0YIucipU759oEHEL9l
 af8hmPew3JbUiCMMc7xVOpOCyqJ280Vxix7ppGrlj4Hra/AvOov8asexxOwZDKSauNpi
 ElllFLR0nXLGm6kzqAB/2VpLG1gfGV+lG9GkO06fUZB1nQgp/C57/4DNq6FK5FewXttO
 nU5pPTEYRIgAG6EydZCrw1V7ttqV2gGwZZmtE77mOKpaTUrxemM3Q7BSPrbHvF+FDM/q
 x3gfnkTpT9kU3AKt7Uwl2PB99gq6kxP1Y2tDgJ1wYqofWtwoCJBV4jYiwbNkVqmE5EVq
 dZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744095677; x=1744700477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xDZ1Ag/eI+LxC+UaFIVqPQgMpm/rPVF+M0q/xxbXO4=;
 b=mevyRfveTwFk5+jzU0K8tV5llAwuZERVhSFnD83BUYrqkIwg+qr7b31qkSgXiLz4ZI
 0MRmVbPy8oBGZoJyUyJLgwWPHseQ0U7k3QzTOqUF8Xi8VA4u/JiH+upbMpdmPNxjh1mr
 adqkpAz/JTlfZRJ1iKEOY+UW+RrkZzZo+5RAroQPR1ChOYX/lHfUqhQ/aioaouOWeR8/
 s0G7t9ERhRsuEgubSzHKRM0m7/43uAAupXJ4ZLU+EH02rDlhFfYWFc2UXxCbLQB1uvKA
 aHHvoogHIkfvyvLQpD9/OR87xNMMlcKBm8lWtKSUDm/RdOO/ExZbDChHRBa4XMVBY0ek
 X3zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbICGvRlJjyVuGVhVrOZPfls3qXHQmbJLiJRmU3UsO0wL56ggWQOhX8fJsLwcVirdzgxCppd8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy89SIvnfq49A1LdjXsE/RBNwoBMy5S5uUHKlU+fEnd4S/5gyu
 w9Psa2q1ofKtQK+M+tOB3ys8n62mjCi1aqXsr4CL/WxbK+rSbF05SiC8zLF0xO4=
X-Gm-Gg: ASbGncva2Mf24YVciqraZTITNha7ckDYbVueE/JjW3ydfMckvJ6lHM0/h3KF/CwE97m
 g4SeaGJbVzM+iVMzSd3D5xEfQyAHpWzqcZXovAd33AJSz8zIUi4vLh9Ig2gnqAxBVsPvblBTBmW
 mR3V+pQZpZbWO73IWwIfjjG0/iYzZMl6yQeIh/T5SS1aFwd1rcEwI+IiqtZexL4evCiPdhGIVJc
 B2aiBqop2snu3SHCqaA+WR4bZXB6u3InP8TVbORcLGR04QPIzsxvXAMrUMknRb8KBU4KD4utovr
 qFaiX8W8AXYDbm2CbR2z660Ao0vB8zGesEGYN8C1hJmHDh+vZbgibFub
X-Google-Smtp-Source: AGHT+IGSq311NYiAlQF3UppOeK69RBKo+xf8Bd4OlzjZ5VquWWsSH/dEJz6tR84dDXrB7zegf2hLWw==
X-Received: by 2002:a17:906:7955:b0:ac2:baab:681c with SMTP id
 a640c23a62f3a-ac7d6d5278cmr1462527066b.28.1744095677297; 
 Tue, 08 Apr 2025 00:01:17 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:5555:ad45:96f5:6396])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5c5c5sm855307966b.29.2025.04.08.00.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 00:01:16 -0700 (PDT)
Date: Tue, 8 Apr 2025 09:01:12 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: Re: [PATCH 11/13] board: dragonboard410c: Enable support for Android
 boot images
Message-ID: <Z_TJuL42qnWemuyl@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-11-524aefbc8bb4@linaro.org>
 <fb4750e2-2f1b-4b17-8bd5-c050dcca01ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4750e2-2f1b-4b17-8bd5-c050dcca01ee@linaro.org>
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

On Mon, Apr 07, 2025 at 08:10:24PM +0200, Neil Armstrong wrote:
> On 07/04/2025 18:59, Stephan Gerhold wrote:
> > The U-Boot port for DB410c still has plenty of extra space available at
> > this point, so avoid disabling features that would be normally enabled by
> > default. In particular, this incldues support for Android boot images,
> > which is quite likely to be used together with the USB Fastboot interface.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >   configs/dragonboard410c_defconfig | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> > index 62fc42c9460d075fd27c3e2823eb8eea2a559772..414dda6778c95eb3fdcd6ef522d8c7d0ef9219fa 100644
> > --- a/configs/dragonboard410c_defconfig
> > +++ b/configs/dragonboard410c_defconfig
> > @@ -14,7 +14,6 @@ CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_SYS_LOAD_ADDR=0x80080000
> >   CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
> >   CONFIG_REMAKE_ELF=y
> > -# CONFIG_ANDROID_BOOT_IMAGE is not set
> >   CONFIG_FIT=y
> >   CONFIG_BOOTSTD_FULL=y
> >   CONFIG_OF_BOARD_SETUP=y
> > @@ -25,7 +24,6 @@ CONFIG_SYS_PBSIZE=548
> >   # CONFIG_DISPLAY_BOARDINFO is not set
> >   CONFIG_MISC_INIT_R=y
> >   CONFIG_SYS_PROMPT="dragonboard410c => "
> > -# CONFIG_CMD_IMI is not set
> 
> 
> What is IMI ?
> 

The "iminfo" command. "print header information for application image".
I don't know why we need to disable that. I just dropped all weird
exclusions in the defconfig here.

Thanks,
Stephan
