Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B641C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 10:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD6287B36;
	Tue, 23 Jan 2024 11:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXGzvtJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E64E87B9E; Tue, 23 Jan 2024 11:06:37 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45F187A0E
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 11:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so53048495e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 02:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706004394; x=1706609194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=27ffTG+0hiVj6c0wIfq1GplM3iPSqVyrAN+jPwuGaMg=;
 b=QXGzvtJrge2aIQkpDGiWe5iCUSqhu0+oCfwprdrmzP4gZmOWePjEgnmUy+HQ9AEeJf
 URPYiwoB4NsY+oRs7rpy21SF+r828tSUFLUkOm6UiRxxTfqyyOxTTli5xmECIlsSJ2Fk
 fcxvHXCNnYGbgzOC0Hc7vI6UwIoNAxM65Rh/iY65Z6TQ0aQUBNkIwMAhinikrKXTvbwL
 hBJff7m4Ass7cyUst7vsj+coJra5AYC2MZ1o4UCQSuaLGmYOtfSJL5V7psuruRluVxCf
 MBghFKpv9wicCNWR8pU8gob4U4rjfLrsi5XLGHlLkMy2Pblci7GXs6GfYUBt3WKZxnST
 ArLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706004394; x=1706609194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27ffTG+0hiVj6c0wIfq1GplM3iPSqVyrAN+jPwuGaMg=;
 b=h5WtVTjRhg015oLkyWFm4428uNOYjklg+ugx77dS9MzaIL2J3TcHGL4CMWot6/eEge
 DISFt4iKD3d/qap4gveM9Uq+PWO0x6NLXF0hYtE0r7ZXA5OLoaG6xJCl14u7UEZ/VY55
 JDG07FiwQAFCubdErqTu8lMJX/C8wPVhFExADTUyd5UKpCT/B4BycarxArasyzpOKfMv
 sABFguc6iAj1kNUNtH+m8WRKjVkGK1euF5SEahQJ2Om2R7zCGEo9BlmpD9ZTDDDnQYNO
 Ad4LjTvew5EjgGXhEN4GOsu9sISaUQdGX7Z4vPk+KA23pSuPDpofUmMDCu09VzDOrS2S
 eQuQ==
X-Gm-Message-State: AOJu0Yyk8Uqp28vwvCWamd9X2wTnLEZvqag4zZ5nQ3dg1toLVBc7zqSW
 +38RqSNm7GpvYEQgTHsJ6uOca3L9vMZltdD1qNGLE4GZnmGR//sZ
X-Google-Smtp-Source: AGHT+IHKM4Ef4DxDPYvVB/D3ewfrTKvibSiGQYud3oPzKRoCONWd4KLkpCcAD3YENryFBzuc10rSRg==
X-Received: by 2002:a05:600c:4f04:b0:40e:3505:32eb with SMTP id
 l4-20020a05600c4f0400b0040e350532ebmr361961wmq.133.1706004394033; 
 Tue, 23 Jan 2024 02:06:34 -0800 (PST)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
 by smtp.gmail.com with ESMTPSA id
 iv17-20020a05600c549100b0040e5034d8e0sm46167654wmb.43.2024.01.23.02.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:06:33 -0800 (PST)
Date: Tue, 23 Jan 2024 11:06:32 +0100
From: Max Krummenacher <max.oss.09@gmail.com>
To: Ryan Eatmon <reatmon@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, sjg@chromium.org,
 vigneshr@ti.com, bb@ti.com, m-chawdhry@ti.com,
 alpernebiyasak@gmail.com, nm@ti.com, u-boot@lists.denx.de,
 vishalm@ti.com, jonas@kwiboo.se, sughosh.ganu@linaro.org
Subject: Re: [PATCH v2 2/2] tools: binman: ti_board_cfg: Check for linting
 problems
Message-ID: <Za-PqGxk6is1ToLc@toolbox>
References: <20240105113917.1117945-1-n-francis@ti.com>
 <20240105113917.1117945-3-n-francis@ti.com>
 <Za5munT0bYuZ5bio@toolbox>
 <419c31bd-7cd8-4439-b001-adad75184cf9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419c31bd-7cd8-4439-b001-adad75184cf9@ti.com>
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

On Mon, Jan 22, 2024 at 03:11:35PM -0600, Ryan Eatmon wrote:
> 
> 
> On 1/22/2024 6:59 AM, Max Krummenacher wrote:
> > Hi
> > 
> > On Fri, Jan 05, 2024 at 05:09:17PM +0530, Neha Malcom Francis wrote:
> > > Use yamllint for checking whether YAML configuration files are adhering
> > > to default yamllint rules.
> > 
> > If I understand this correctly this patch now runs checks to verify
> > that yaml files which are part of the U-Boot source tree are correct.
> > 
> > Shouldn't this be done when one commits a yaml file, i.e. in U-Boot CI
> > rather than repeating the process on every build and thus having an
> > additional dependency to build U-Boot and additional build time?
> > 
> > Note that in openembedded there is currently no python yamllint
> > recipe providing the used python module in the regularly used layers.
> > How do you plan to integrate the change in the OE U-Boot recipe?
> > At least our OE CI of latest master now fails (for a TI AM62 based SoM)
> > as the python module is missing.
> 
> I have submitted a patch to oe-core for this missing recipe.
> 
> https://lists.openembedded.org/g/openembedded-core/message/194192
> 
> Hopefully they accept it.  Otherwise, we are going to "temporarily" carrying
> the same recipe in meta-ti-extras until they accept it in oe-core.

Hi Ryan

Thanks for looking into it.
Max
> 
> 
> > Regards
> > Max
> > 
> 
> -- 
> Ryan Eatmon                reatmon@ti.com
> -----------------------------------------
> Texas Instruments, Inc.  -  LCPD  -  MGTS
