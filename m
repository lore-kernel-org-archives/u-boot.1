Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0A7CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A95E83952;
	Sat, 11 Oct 2025 19:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UceTv1zW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87688393E; Sat, 11 Oct 2025 19:07:27 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922E283906
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-64e3e259f93so1583581eaf.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202444; x=1760807244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WZ+PhcknuqRIG/NR0famIIrDRA1qkaY2kYzZecKNuHo=;
 b=UceTv1zW4Tm20sVTQSYiXL9DBSJpluT54MVXjwTjV1kLg5ZW24V5gLC23fTsIsOZ1Y
 UNoPVYk5MEYKZY2di/HtUfPr8qjORmb1bCFxGDWbcu3vE6d623ig5SJKQJKtuOCMkZhE
 MTOuUy25J2cKux4RPjHfit0EfNdJNJHY6GoLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202444; x=1760807244;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZ+PhcknuqRIG/NR0famIIrDRA1qkaY2kYzZecKNuHo=;
 b=oG2ss3hIriWxeA2hGfcm7eYnJIsUqVPL+3KVwBZJYHEoDFM581sAmYoacwSJB8RQTa
 gtF43xsMV8Y5fL5zOTwVJ51UOCsInXTnEf7sj/hWBses9FwechLw4Kg2aSuvjkUaPjwO
 QYoqe7xai7y0f1CsW/VkXxL9aBcGWfkTxxjfEwle7EjE+NUyT8p+7i80aHSXDxKxBl7m
 xNgNAtx4dQo9/Zcj2y+KO0KF0tt9ym7uBcRlJuirv8gLyBwhhLQLs66gwXS12wKhVZnV
 DH8egIJiZrlxBQ45JA+eqIil3e+hX+gY6sPzm/EWcIM913TEfROUyEix0BVsMhk8MYeE
 FMVg==
X-Gm-Message-State: AOJu0Yxp72zEffUhHUYXKfSnnPzm3wsDbyDdX6KrXvEGjpG6Cju07/gD
 8H3rYh+ZyrfAZwxgaeoZX9ScprNChGwh/tvh++MYhZ7til2DvbDNcq28IyUF1xX7EC3EQ327BIQ
 fXy+48E4=
X-Gm-Gg: ASbGnctV929HLGHRfNC0Es5IqaX2N5L1XewgVk6WLkG6XNXyWizRIm50FvDAcGc3+wr
 N5VChUI8A2IFZXmVVutu26J3HqGt/NkSmQ+22/3/SP9s5tSV5l+vrzm/gSKcG1fD/KN2jPIm6Ke
 eE+1XGNhCxw12rFuiCPpdut7GRT0bZfJ+3vK+aEaGKIoAcD7g31H2EK3YPnZvb+rqcg/xFFlLRU
 uHknQsfJm5qfswjOqf4MMfQm83X7fIC0ZbjYKo4tvhXHmMZ8oaY/lERVi9nOwy3DgivgjNs5jDb
 5EOwNSskkIzS0djl6bMpr31CHkAimFUhSnhK6xjR7w0SA2jUKQ/krABsTzPFsfkO9Lv9bvEiw26
 j3sFNRuJ+gicZnBlHt/A7wj24gqCVs34evAzfJaTzbQ3ovfoRO6ZksNhFKE2ILcBOd+1JsWO/tG
 TuVC4=
X-Google-Smtp-Source: AGHT+IHbFdG3eEmflJutnR+bVxjSZivVJXggJasRvxi9rOivjOTfm82JMvi1LXYNMkZ6V23n9jNhgQ==
X-Received: by 2002:a05:6870:888f:b0:375:270b:ea56 with SMTP id
 586e51a60fabf-3c0fa4667e9mr6531207fac.42.1760202444333; 
 Sat, 11 Oct 2025 10:07:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250813205511.3420638-1-trini@konsulko.com>
References: <20250813205511.3420638-1-trini@konsulko.com>
Subject: Re: (subset) [PATCH 1/2] arm: v7m: Allow SYS_ARCH_TIMER here
Message-Id: <176020244360.1312138.4916087068313364473.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:23 -0600
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

On Wed, 13 Aug 2025 14:55:10 -0600, Tom Rini wrote:

> We have had an implementation of the generic timer found in many v7m
> chips since 2017, but as part of the Kconfig migration forgot to allow
> it as it wasn't being used at the time. Allow it to be built.
> 
> 

Applied to u-boot/master, thanks!

[1/2] arm: v7m: Allow SYS_ARCH_TIMER here
      commit: 9de2fc9878e7a79752fab26312f9d160b4103e3e
-- 
Tom


