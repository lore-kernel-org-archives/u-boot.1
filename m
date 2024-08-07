Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1253CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A58F88BDD;
	Wed,  7 Aug 2024 19:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ej5QKWWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC6288BEF; Wed,  7 Aug 2024 19:38:55 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF0F88A5C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5d5c324267aso75655eaf.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723052332; x=1723657132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjQoYpkQ2Oq6y9g7f+RTxU/2eFh/zGOFUR3+AfjYPlw=;
 b=ej5QKWWJAOqHHJmiz2xlWpUCh1gDhvhoK9GLYBaxrOAfjy6cVMw+p3Y01C6aEfhn7w
 pnRFxL4DCCdx2Q5fAtug3leidJbiazHFCR58vmzt7EEL0fkT4dFnLOjz6HSYBZTMA1dw
 CFVvDUaHLqJWbpfpPS0JXgQue4uXS59yLIr2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723052332; x=1723657132;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjQoYpkQ2Oq6y9g7f+RTxU/2eFh/zGOFUR3+AfjYPlw=;
 b=C25wHNrPGJqvf1M9/q4/J0Egeit03nATBhy927CUdkCGI/PXvFOtLdYehP5cK8el7L
 CcqJl3bKB8R5aPSfVaXhd8f2CN2Uwzl/OleXgapJaxtOvZabCWVZnnAqlhUBs4RkLyAc
 GzW2Yslm2T0q/1oOkPkpXREF9WV1UEazOw4r3+NhbIZsOkPPvyeEVp4Nlu09zv5lBj98
 AvWmuAgagYpwkq0Yt5O6e8IitQ+t3Yc7m2bjV9I2rYo4yPZR3p8j7+rkVxgdKJJx1rW5
 n1xC6yo5KNsVz+8ceJw2cdx4Zy2m0FANKwjdP/zRaE4hNDqm8W8Q6WqYNPnPm6eEHvzw
 W7aA==
X-Gm-Message-State: AOJu0Ywss5KE+kFkYnJm2JjVm+/MCYrEwC+a4n2Skek8YLeI45mVZ0nY
 SwaGysaCAhH96Jw68tlr8SkUhUeG30n2+nfAdg9wkVB61k3zB1JDEMr7vP24tas=
X-Google-Smtp-Source: AGHT+IFsv8bjhoiIP6Vdam4NUK1X0t6algD0nGEoYQ0kVNLHu4fjOPxIfEgceYtxGfEJ85oHLa7RJg==
X-Received: by 2002:a05:6820:628:b0:5d6:1082:4f4e with SMTP id
 006d021491bc7-5d663aca17cmr24072820eaf.4.1723052331713; 
 Wed, 07 Aug 2024 10:38:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-236.totalplay.net. [187.191.8.236])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d76261a27fsm3270333eaf.39.2024.08.07.10.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:38:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20240730143938.3991937-1-sjg@chromium.org>
References: <20240730143938.3991937-1-sjg@chromium.org>
Subject: Re: [PATCH v5 0/4] alist: Implement a pointer list / array of structs
Message-Id: <172305233086.1720190.1601424366002059119.b4-ty@konsulko.com>
Date: Wed, 07 Aug 2024 11:38:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 30 Jul 2024 08:39:34 -0600, Simon Glass wrote:

> This data structure provides a list of pointers / array of structures.
> I was planning to use it for the lmb restructure, to allow it to
> support any number of entries, but then I gave up on it.
> 
> There are quite a few places in U-Boot where such a list would be
> useful, since it supports growing the array.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


