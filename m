Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227C7C30658
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E579882DC;
	Mon, 24 Jun 2024 23:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L/JxJ34s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45064866EB; Mon, 24 Jun 2024 23:26:31 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC3D866EB
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c1d42d4470so1837432eaf.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719264388; x=1719869188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UApMtD08AIn61SdIBJ+kjf1zsC81C9iSU17kaNWLxs=;
 b=L/JxJ34sfdJphu5ht9jgRS8zfTnBFkwy89TPbezVur2I289wWanl1CDghTp+Ax8JeD
 IvvLRuCNOeIzaYozXE4DICOLolX+XZ1YGuMaSopfZOZbA1plb+cKUCrUaMKWFas2A464
 GHAV9WWiuT0k9Uxs0OUVAiiAZkubiQB+puq84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719264388; x=1719869188;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UApMtD08AIn61SdIBJ+kjf1zsC81C9iSU17kaNWLxs=;
 b=rp698Snd4kpYFQgK7AdflNGTq8hoFmFChTHQ3qhoDJ+DopFAaVzcK07qRwyyE8R350
 qpyEJABMob8hU772V+9O5N+51fKtvNAkjQM2shT5ZdmQyU+MGhmO0a47TmRKrZehNIBS
 UTUlGROAJkIjDziYyX/phgn/4F+xlcsBppp4RaqJqveDcvRVlAKVOpn0HPVB3+bJoES8
 WxQ3nuPe9cfTrp4E/BJgKHF6MMlCY2LA1RA6iFegsFwkyPpLqDiKT2xi2RP+5H5zAaCb
 D7Kj/W6N2YK7nOTjWNG9SJwhz3FHVN1wkiqlsGFiGzsrL/XpaOoFIuq3KGDpkAwoPBpD
 Xj3w==
X-Gm-Message-State: AOJu0YzpfZSBrB3dqaNnwpTZROqsVZjLE00sgWejlrVQel/pf8AyaQj0
 CNO7nk6FTrQXekRU9iKtI3x+H0OoWu4rGtUoiEbMoYcH7Ie1uddRMi+DeVqnEow=
X-Google-Smtp-Source: AGHT+IHQfKZATxXiU8RENpydi1yz8vu6MTErevM8jNs9GS2JDwaNkjZ9+09zFNi6Iy6oe/6lfdE6cQ==
X-Received: by 2002:a4a:3055:0:b0:5bb:3326:175a with SMTP id
 006d021491bc7-5c1eebfe6bcmr5741960eaf.2.1719264387756; 
 Mon, 24 Jun 2024 14:26:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c5df65csm1332833a34.9.2024.06.24.14.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:26:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20240619-play-fdt-fixup-v1-1-18e2a728ca45@ti.com>
References: <20240619-play-fdt-fixup-v1-1-18e2a728ca45@ti.com>
Subject: Re: [PATCH] board: beagle: beagleplay: enable OF_SYSTEM_SETUP
Message-Id: <171926438692.1912351.4241540655800115685.b4-ty@konsulko.com>
Date: Mon, 24 Jun 2024 15:26:26 -0600
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

On Wed, 19 Jun 2024 14:12:30 -0500, Bryan Brattlof wrote:

> Unfortunately when enabling FDT fixups for the AM62x family of SoCs and
> moving TF-A to the bottom of RAM we missed the BeaglePlay. This is
> causing Linux's memory allocator to clobber TF-A and break its boot.
> 
> Enable OF_SYSTEM_SETUP to fixup the kernel's FDT to inform it of the
> actual location of the firmware
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


