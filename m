Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4D1C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 22:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CEF83B83;
	Sat,  2 Aug 2025 00:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q63nEtWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E1C83B9E; Sat,  2 Aug 2025 00:30:08 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FCB083B6C
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 00:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-432ae370f7dso1510184b6e.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754087405; x=1754692205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwsDli8jlVhHfmcSMcrSWWN57aSl+JmkT4tRRksmywU=;
 b=q63nEtWsOow1V+3JUf858eYD5uZm9TkYn3VXw6730S8xdYgmkswgyAPb3emodYe+Zw
 g6XtAGJ6WjIpXUrKkn8P35auhm+baOVlX+6ol2/ziF9rzWhh4HjF3PF3C3YdWcMWZkC5
 yZiVkXyEiF5sbsUhrLXp4lQqazby4hQXL6XNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754087405; x=1754692205;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwsDli8jlVhHfmcSMcrSWWN57aSl+JmkT4tRRksmywU=;
 b=jWy8YRLzGm05LhPpoTXUSPOi0xVOxOebw/UA2qQiViKypN/ufYUxxuNFTU6ytuNGJV
 mxB/5FzqE64yGgnjVEosI3oTvS7oktRnzW4envS5comEoaZh7V4n21Xn9Bxw3Ok9qyxu
 T0e++y3d6rt8rAbUb2iBqKBn4GXDZEQ2hsehxgkeh9sJPvSqHIVVS7rjp5bkwEKQWfdh
 jjJ/EU/T6AEi/+YI8gr8pytgTdqTU4moZDw9ehKyyL/hk3Fk324CDZoSoaEqSECL4idB
 96kySmghRmi2hFpgF0F4KU6wK8PBWoFfsEK4832EpsHwPZSwVAl7pAKps1zaxCNnD0gv
 Cg+Q==
X-Gm-Message-State: AOJu0YyDuipnlrwKcEknWtiMW2k/8c7imat1Q6Re0HwnUZceoZ4akr6w
 T49l9g5XHw+aj0qCeQkRv5tBa8bCvnrKPB3jtA3/nT1SXiBPchtjeiT6Vdtkluw6Kp0=
X-Gm-Gg: ASbGnctQ1mg/YdploLESJ4z56zKLUwLTaGtmlPDxLiB9EBSPI92XCBFzn47rEoYeuxR
 tURb958saqE2Bkwffjbudc1HylQ3JZ/zbDRT5X1psBooMqx4rKGh/HmKZgb9ytcMEbB9tb2P9OY
 ECv4e+6FK7Muagn6GW2kCCx0jHg0kA6qN8+GgdVEwRcSAsQwpwRZIDu2qZ6rD5TMttBzgW7FjOT
 uUO0nU1TEhpHOpS620Nnfhrhx5TzmjXVjYI+zHhcCXdH7795Su+yOci7+9lZVDonMaoukVuonbD
 G6K+YBVeFCVNs0RZtO0TGGfwnG1FAJMgOy8im5XCp19XNkIrduWlfB8+1f8SWjX7hlB8uOZK+51
 AFNmo8Yi/7PTjiJWraUhE1wjfiBq9BeHlumzypyyeuZPy34E16C1QamG9cWaPeYHbzg==
X-Google-Smtp-Source: AGHT+IGsSVsFOVLhrGzJxBndRVsKr07y/yekIxewKDUybp9/yobG8Dtj49a1lmnRu5dY7heBL/8Nqg==
X-Received: by 2002:a05:6808:6718:b0:401:e9e:5042 with SMTP id
 5614622812f47-4335463f157mr4360810b6e.15.1754087405101; 
 Fri, 01 Aug 2025 15:30:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-619705183bbsm701619eaf.10.2025.08.01.15.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 15:30:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20250731115248.264837-1-mikko.rapeli@linaro.org>
References: <20250731115248.264837-1-mikko.rapeli@linaro.org>
Subject: Re: [PATCH v4] Makefile: add dependency from lib to arch/$(ARCH)/lib
Message-Id: <175408740420.4019035.17235319646857696633.b4-ty@konsulko.com>
Date: Fri, 01 Aug 2025 16:30:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 31 Jul 2025 14:52:48 +0300, Mikko Rapeli wrote:

> Top level Makefile starts separate "make" processes for each each
> subdirectory. lib/efi_loader apps now depend on lib.a from
> arch/$(ARCH)/lib if CONFIG_USE_PRIVATE_LIBGCC is enabled which creates
> a race conditions since dependency from lib/efi_loader EFI apps to
> arch/$(ARCH)/lib/lib.a is not explicit:
> 
> arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such file or directory
> make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/testapp_efi.so] Error 1
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: add dependency from lib to arch/$(ARCH)/lib
      commit: d0075e2d730a4fa48aa763a669e5edbc02c33a22
-- 
Tom


