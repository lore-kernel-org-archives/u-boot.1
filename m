Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784ECCD6E5D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 23:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720F58486B;
	Wed,  3 Jun 2026 01:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uah0kOmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389BB840ED; Wed,  3 Jun 2026 01:30:56 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20375840ED
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 01:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-486539875c1so389906b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 16:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780443053; x=1781047853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SYEoMU5O22iPAASbrHPdlBEYXHctI9APGkqrEl8WiM=;
 b=uah0kOmfb1WqltRrMetvJUXB/R2ZgwWb+B0Qbe2ufa/9eQ73aIPsV9S7+X0w09hIO9
 bnVbPUnF7J+S6A44ZyGWRMieMWgwJYGzo8P0d8F3kFx7eL2YZps3UUwvqPs7IxAF32iD
 jyal+1X/u1QQAEwu0SDxBCSTdzvqZaMCzZcX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780443053; x=1781047853;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5SYEoMU5O22iPAASbrHPdlBEYXHctI9APGkqrEl8WiM=;
 b=Z0tW0l1LnrSGOD9BUBcuIfdr8/odmZmFwujD+5yzJL1NQNxaA4krvTTDwqRFY/ZdVV
 AaAnirUQGiLf4RdLwFWYXyrFkog7eU29qcWbsvYaXkE8JEmWdH8WUK+9hzx0FXWGW0GA
 KSUOTiXc2rGrEt3J023YqlbMzYHro7TpKmbl7Ol8HWyxq8VLsnAth3dWnJdugh48v478
 twjdNS4/3nVBSXmGZc1poYuqryarxZUZ33RGKw1fqTARyiQyDzOXyb/0rkv/BA1jvsmi
 2yVKEE44aBC78PTz0oFP9s/zLNw/xCPpx1s42KW/1t00Fc9LK/Xa4dYQzQ9+uiHd/apw
 b9MQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ95qaqcpM/1s+XRPDe3hfAASt2UbL12IQebOTVNnrg40yuXeX6Xo91iRU/PItkibp6zZDJRY+M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxphm3HkqoIFX/Nq7DINufE16oQkJFcgzLCf9PgQUkjHrn9vB4V
 Y3K4PlaIENtl9EBxK5mwYuqS9Xxk3OVUXVMB4s/lbr915adV222LKgwQ9NyUO9BwmnY=
X-Gm-Gg: Acq92OEHUh/0KVi/ugi8PxqqgMZ0JOCNenk5GM6AwUziSYKFS9CTjY7gDciWXPR9PsH
 UuwUBG4N1leSpknih+uZhbf3gzlWH6mBDjFQS6YID6OLkxQCMFILtBUsNKODY8g6kLRj/cSoQyE
 HtObuZEIOSvGLq3ZkXvoDivnUHkE4rm0eqwfPCqlb5j2+thJwKFHm8/rIWgls9Jv/XbhJGmnMSV
 0C97eurkYRg3Ny8s9gfpC9g6zcOyDBN0Ua7mlWm9IqbDfw6HCFIxa087WoVqp72GXFODdvu+jOu
 utnZ7rKLr+93codMRWZ02vEsYG56l3DLjOPbjzKdN+UTeuIrpAVlVEw4NTatdie603I+LC+RKA3
 fsOIpC7aOmr5yRuIXqIDFV3F9558a7wzdNMzQVOhp1rfZNJkcCEAYiPUFSXgTlpBr4hTjuQSt23
 h0KHB8w1dTI3csdsPUe72JKkh5XnOEVSUpCMS2HWe5PUCIpfWyHMY3+xBAgPBS/Avkd5o1eHEr/
 BqVPiNyeOQrOvB8UGcXkixjeItfF0iPOfP/W8ww+BNQ+UURDCnCVBH9yF4L
X-Received: by 2002:a05:6808:bc4:b0:47b:c703:4239 with SMTP id
 5614622812f47-4865aad6619mr680693b6e.37.1780443052932; 
 Tue, 02 Jun 2026 16:30:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b745773sm513804b6e.6.2026.06.02.16.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 16:30:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: bb@ti.com, Swamil Jain <s-jain1@ti.com>
Cc: devarsht@ti.com, anshuld@ti.com, praneeth@ti.com, n-francis@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20260519141716.1346635-1-s-jain1@ti.com>
References: <20260519141716.1346635-1-s-jain1@ti.com>
Subject: Re: [PATCH 0/4] Enable splashscreen functionality on AM62X
Message-Id: <178044305205.1983368.8381562206358818302.b4-ty@konsulko.com>
Date: Tue, 02 Jun 2026 17:30:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 19 May 2026 19:47:12 +0530, Swamil Jain wrote:

> This patch series introduces splashscreen support for
> AM62x platforms by adding configuration fragments and implementing
> selective splashscreen enablement across different boot configurations.
> 
> The series adds two configuration fragments: am62x_a53_splashscreen.config
> and am62x_evm_prune_splashscreen.config. These fragments allow platforms
> to selectively enable or disable splashscreen functionality based on
> their specific requirements. The prune fragment is particularly useful
> for platforms like AM62P where splashscreen must be disabled when using
> TI-DM firmware with display sharing features.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] configs: am62x: Add splashscreen config fragment
      commit: 6c164d51d698802d1f768106b8700147ad0e3d46
[2/4] configs: am62x: Add splashscreen prune config fragment
      commit: e853b26d0cdd1f736e074d9b71922780a057567d
[3/4] configs: am62x_evm_a53_ethboot_defconfig: Disable splashscreen
      commit: 83f3e2c30b26d8079fa5a5e723c8e76d38d338dd
[4/4] configs: am62x_evm_a53_defconfig: Enable A53 splashscreen at u-boot SPL
      commit: abd948e5421559bbdee25df37b7261923a22c441
-- 
Tom


