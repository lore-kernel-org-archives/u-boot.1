Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DD2C27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDCE88A2C;
	Fri, 14 Jun 2024 16:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qpg70Qe9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3260188A06; Fri, 14 Jun 2024 16:54:34 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2E2889E4
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24542b8607fso1130589fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376870; x=1718981670; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnqbREBL57zurgoNW/kIC4t59UCSzgooZARKW2bSZ24=;
 b=qpg70Qe9nmh4QME1VTm9SB9MILd5BBJMagkK89vc1GXBlRVNirQ8XYzg4K94bfyRlv
 7jtzEvphNYDDAcLa+bj7FkudT30joczSGVddO/uv3XDFuSakvoMaYyNrSG4j/Bj7jWNK
 8HIiLND9c9m0lAg6hDzdLvk2kPfgCvhchL9bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376870; x=1718981670;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnqbREBL57zurgoNW/kIC4t59UCSzgooZARKW2bSZ24=;
 b=bnOUq+8XtP2ojM+sM/+JGHO1fQbnsv4Ssg5GiVX9Okv7EyfW3E2Prhqz+aza75ymN4
 IMSDEGNKYSeX0e1r6rEQZc/EmzbZYuoxld8R2GoM0PHDZVKOXu+OPddFmBqEv7kkI4PU
 Ptzx6nsYE2AJ9Z89KiG0Cka5Ypc3dTFtJ8AqiOfUeBMBLRNk6ems6cqA1moB57nNW3NI
 XE9iPStik1rpbLMyME6dRrLAxPY9v76m+nWpnqQ/la5DVRXiW3xC0XNYphyHkXpZ8YZl
 TFXjFsdc0XPXhxHyPyjMREiJ4Rky7vGOmiJDDjH/mF25fsW90bJsGBGmQm+2p/Fy37qv
 KpBw==
X-Gm-Message-State: AOJu0YxpPzRre6okqfShzXvm1pQTwsO2qERwmyfdevd8mhDJaA5Zc3kk
 HsHvY1pePM+uSL4xp28E9LMcSbbK+X57QrEIM4GrcqZBIjegoKUc+ywjrDL2R0Y=
X-Google-Smtp-Source: AGHT+IHef0v+TFJmrVmM9En0HIHfIixDd0uZZWw3DBKmF66fWyW2PzDULBGctnOOecbn//eJUbELOg==
X-Received: by 2002:a05:6870:584:b0:254:6eb5:ab2f with SMTP id
 586e51a60fabf-258428976b3mr3338126fac.6.1718376870000; 
 Fri, 14 Jun 2024 07:54:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, swarren@nvidia.com, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <60e9180b7eba8f97410a320d9ac69101479991d3.1716383488.git.love.kumar@amd.com>
References: <60e9180b7eba8f97410a320d9ac69101479991d3.1716383488.git.love.kumar@amd.com>
Subject: Re: [PATCH] test/py: Add support to enable check for bad pattern
Message-Id: <171837686929.2655592.17867615820286594664.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:29 -0600
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

On Wed, 22 May 2024 18:45:13 +0530, Love Kumar wrote:

> Executing a u-boot command may raise an error or extra bad pattern,
> beyond the default bad patterns. Providing a way to enable the console
> output error check in test.
> 
> For example, description for OS boot test:
> import re
> check_type = 'kernel_boot_error'
> check_pattern = re.compile('ERROR -2: can't get kernel image!')
> with u_boot_console.enable_check(check_type, check_pattern):
>     u_boot_console.run_command('<boot command>')
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


