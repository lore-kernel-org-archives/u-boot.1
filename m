Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5930A8859E;
	Thu, 18 Apr 2024 05:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZSsv8mT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12FF88527; Thu, 18 Apr 2024 05:40:17 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4BD688562
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78f0e3b650cso7002185a.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411613; x=1714016413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2giPCxELbuuFbh6nj1OHnTa6ZsshGYfRta9d1xlCAA=;
 b=ZSsv8mT8IcO7I2FLolwP8lG6IQt5J8irqQBHshnW+IuouetP/qCDbDlh1105/35kwo
 CJg16IBgg3k3FHavLUJIrJzgZxsj46+zcIWEH8QqeYNLHaL6f4XuBbFdj+sYlw13i4FO
 vJEy3RUYJ7NS1bMY7ITcsKhdskDqSCB6R5U80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411613; x=1714016413;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2giPCxELbuuFbh6nj1OHnTa6ZsshGYfRta9d1xlCAA=;
 b=FFMvNX44ofZdg40T6EQaHs1Y0uMxTWumpT5GL8DHq2T8GNivtNrouQ8cAUcWBiSmHc
 PRP+xthkjYG5fpidX3T8YUL3kw8IYNIu7apjG0u5YgJiAvgz9ueaSihgLno7sonxSFG4
 3riXMR64WDwIXFMXYLtENtpr5SKva4rr4j5B9ZmzMMZq4gHE/TJb5ShQIjXVrP51JhOZ
 /bXbtB46adIE+ZcTdJvubvD5VWvJ/NoRVJtxH45HKD3/dWBxPwkDG8uo1fm40CtVWMc7
 hx009D1BAmF+rk3af61uNbEhOmyY9hKVPE+jtwWmXlONCxiM3TDpGhVJdaAXbZDvLkHR
 wldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRF6r/DM9n9CpCUgatCDNM9j7Oab68MH/HxhN5iMBLnBuhOJ1P4NzICtzA1Wx0Koit3577dCTHZjVXvXjQyUfeoRwMYQ==
X-Gm-Message-State: AOJu0Yzrif+9m2CKPOP60WZh+BshoY+7CHxAovqFbSb74DAhU06tMtfq
 R3E4QkQ8PKB88SD8bNo+H4zHWEWak+O7ToRlR2gTEyK9HfDwNHVHuBQkFoBEFbg=
X-Google-Smtp-Source: AGHT+IEhJ2lDhZkmMKTCGcgyszEESUznbTAwazkgrApe6vxYtMASfdjGMw1aMcIEnasqYYwbl84Riw==
X-Received: by 2002:a05:620a:d4a:b0:78e:fe43:2916 with SMTP id
 o10-20020a05620a0d4a00b0078efe432916mr1525693qkl.38.1713411613554; 
 Wed, 17 Apr 2024 20:40:13 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240409180456.39581-1-heinrich.schuchardt@canonical.com>
References: <20240409180456.39581-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fs: fat: convert change month correctly
Message-Id: <171341161248.1250683.462355895601095107.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:12 -0600
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

On Tue, 09 Apr 2024 20:04:56 +0200, Heinrich Schuchardt wrote:

> The month is stored in 5 - 8. We need to shift it by 5 bits.
> 
> Cf. Microsoft FAT Specification, 2005-08-30
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


