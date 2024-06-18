Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB340C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77212883C9;
	Tue, 18 Jun 2024 20:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s5+ZND3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F38882D4; Tue, 18 Jun 2024 20:57:54 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A725882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d2469e797fso67314b6e.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718737071; x=1719341871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aszHdvD4+1ewG+X0RI3RKEddsGnPURnLBeq1PWokNZA=;
 b=s5+ZND3NbyP2GmNZCnmP8NQhZ/hkflAE+dLhRa32a5ouT9/jbHlnsI8O6j+iMYaL8L
 f/3jSIPhEA1KbuXbsW0n+H0yIE7nS2unVrK12J4luTM657OYbBzWIgD56xbeoXHWCO9F
 C82j81WF6xZsAnIJ9T+aEvnsBKgfQvrY/qgXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737071; x=1719341871;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aszHdvD4+1ewG+X0RI3RKEddsGnPURnLBeq1PWokNZA=;
 b=dxWBvfO7/mQ2NS9DZFQYwtfGpotQnih2+Rltk210BCQz5moJdDe8QBcNVGRXmpKYxm
 I0UT/VRSUgDjN94mtU14AZb8a8EJp1OHg25rvIXNMShK4wI13/YcCXqORoKFTSMCiIwn
 C7swVpO/tH5uXZL8l0txFo5c0JDC89N9A71c6CBZWRDNO/5js77WqOuOFe3LveWNSPo0
 snZlttxWy/BRo6x15uXy+KcrxDMwNCwdVQ5tJyCSot/xfTKS9neeDQJ6VEM6iqwa15TL
 COO43wXOHl0QsMlm2QCxDaLQxr3EHS9pzA9D3jik0AwTvUQ1Cs/BAK806Zyl0w0plC5W
 83yQ==
X-Gm-Message-State: AOJu0Yzx+fpDqsPnn9vWAWLlrqpQDiZNPoo6Yud9U5ih+9N8j6yUijot
 +Vs3FeqTIy+dn9uWNfiaTEU/H5JakeTvjgUUN0dKw0ToCp1Zyb6V1ZpFJBXyo7kMLZJnl/7eVc9
 rkJIa7A==
X-Google-Smtp-Source: AGHT+IE36QKlGImuYl+MGk9nKgNKueaJ/C71kjwHmAsc+LbppN3VpeyB6smhWRVJMcQy1F3f8MRB7g==
X-Received: by 2002:a05:6808:13ce:b0:3d2:22d4:4eac with SMTP id
 5614622812f47-3d51b5bcb59mr381623b6e.2.1718737071137; 
 Tue, 18 Jun 2024 11:57:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476e31cbsm1875120b6e.50.2024.06.18.11.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 11:57:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240610-smbios-sysinfo-v1-1-587e100a9d92@cherry.de>
References: <20240610-smbios-sysinfo-v1-1-587e100a9d92@cherry.de>
Subject: Re: [PATCH] smbios: only look for a SYSINFO udevice if SYSINFO
 support is enabled
Message-Id: <171873707042.3326390.8750889416442959727.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 12:57:50 -0600
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

On Mon, 10 Jun 2024 18:13:46 +0200, Quentin Schulz wrote:

> If SYSINFO support isn't enabled, it's a given that uclass_first_device
> for UCLASS_SYSINFO will not find anything, therefore let's skip the test
> entirely.
> 
> This allows to get rid of the following debug message that may be
> confusing:
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


