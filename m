Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE61CC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA0288581;
	Fri, 28 Jun 2024 21:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sTVoKO4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE4F885A2; Fri, 28 Jun 2024 21:49:28 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D06188570
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d55f476494so473413b6e.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604164; x=1720208964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/E6zfWd+ga2Aq/QE9iH7Pna1Ry6UgYRIQ4akHtkgc1w=;
 b=sTVoKO4ZX/RNUaUZSKiZPvANX46Sq6HdzgxWXqfadjOO1Yk/YaoQnQprkb337IDgia
 cW0sysdeFP0ZB6UKO+RKrKnOTG7YWO4/TEkfdei/77jStDTUA4WXz9c0GQv7RuNHmR0W
 1r+bN80zxwFmUQ7l4D+Oz1Twf5sVfCviOeRUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604164; x=1720208964;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/E6zfWd+ga2Aq/QE9iH7Pna1Ry6UgYRIQ4akHtkgc1w=;
 b=iN7OnldXTu04MzStwC+NmWEXrjiP50H/9UA/RQsfzyFqGzgkEFOiLQCr/KXHRqvB6f
 SHQ41ZjRHKTbN+KdgwwzT1JfRGeARnuS/ZLotD6neMTOhLRNXoHXtsllb64ZokjRVg5c
 VazglvSo0+mp61spFXsMy3buHv6ms3xZX4aeg5qMY+BwW1ERM6Vod3NAK5+C9+EXyI9a
 aSYTQLRl5mJznN0UBzVDmrqjBm65C/IO+sIQ1igrQCNKS6NS+vGj6ei6+KjEdNSuqHh1
 z2lck+RTnxeA9vdT2KAlZfiuzAwjdqE4t0kcwvcBTP0c4wwhpY3E6ETWiQPhXLG5veku
 9DUw==
X-Gm-Message-State: AOJu0YwJ0cqHGQkTt0eex+vF1jm6ejuC5ZOif+NdwFQdk3Ht9UvihD8O
 yc5Gr3C73gSoyjKU+2gdd85VqhEMS5QaYhplJiLdkpGmV4wXuofRkoLCXoL9IhA=
X-Google-Smtp-Source: AGHT+IFpdd2IkG4M8/2khKCUeeyHpr816xQ/DDmKh9nx7sr73gTSoswji4wHsczbmH/vnLSSoLmlpQ==
X-Received: by 2002:a05:6808:10c5:b0:3d2:278e:7704 with SMTP id
 5614622812f47-3d6314aa0eemr1001767b6e.15.1719604164058; 
 Fri, 28 Jun 2024 12:49:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Bryan Brattlof <bb@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Hari Nagalla <hnagalla@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Sean Anderson <seanga2@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240617092201.30245-1-ghidoliemanuele@gmail.com>
References: <20240617092201.30245-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] arm: mach-k3: j784s4: Fix MCU_CLKOUT0 parent clock mux
Message-Id: <171960416298.3614069.9003818656208090135.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:22 -0600
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

On Mon, 17 Jun 2024 11:22:01 +0200, Emanuele Ghidoli wrote:

> MCU_CLKOUT0 output can be driven by two different clock inputs:
> one at 25 MHz and another at 50 MHz. Currently, the 25 MHz input
> clock is not selectable due to a duplication of the 50 MHz clock input
> in the mux configuration. This commit corrects the parent clock mux
> configuration, making the 25 MHz input clock selectable.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


