Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F28CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 16:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68C283045;
	Mon,  8 Sep 2025 18:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sHAxGl3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C827809A5; Mon,  8 Sep 2025 18:18:17 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FC482C84
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-31d6e39817fso5947905fac.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757348293; x=1757953093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJC11DeRCpq3zXHvhJKixtKH79j0A27a2+TSQc61nYs=;
 b=sHAxGl3QNkyYvjdZnkUDBWGi6CTKLtoqG+FDzH1E+7NM9Ju4DyVYTb/VYSSLpSLB61
 DYyW7Dj6ybY6wepiiuQUw7dLzfcSJX8uugWCP3UNM806QxYJNJoMjp4IvID9BozVdHBw
 vWj8aGfe6Zu/ADsFgppj7BQU+pwc2aCm5+7j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757348293; x=1757953093;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJC11DeRCpq3zXHvhJKixtKH79j0A27a2+TSQc61nYs=;
 b=AobyykRqGv1eq03lKy+KAgm53FJ67fRvZ+vIrSJXLCMYT2HvfDTVRvzETgq125QU0d
 xFrYNqIsBhh4UXreRPqpOarP490Bf6pOcwnAg5g10276sSmUSGvIKgr8/exMXH4H2r7X
 atXUOJpvKQ+k90laG15lrynW0+GFasIpRhXEGj3Al2Og/JPInDpXBs3JcTwPH7mBwD+t
 0lKJ5tCUB5TW5vuFCsRMa0w9XEx0bIryUdMsDhPHdf8iC6v3PFAeI3oD8+s47byUpuQX
 bKg/RSzAVpw+pA7hZh145Zi2b9advxZ44WFybI78Pbsj95Ztkb5Qvnk0wV28+N10aWqd
 SX8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiJv3TkuveEg2CRE8dSMAcOolKOC5uR/C+BvBy2HtsA9jBCpNpBdfn6tIj8/IBzqAzQGavTLc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/PuBbpsDb4HJqBAeqTmmoKfjdO4r+sRT6ZbXcdeKm/ytoRKqB
 coQ609bfOWrOAWJ61zsm+hmkN46BKqrJEVWmgbIAVZvW9Iw5vUGsnEa5MzZDajkwFJQ=
X-Gm-Gg: ASbGncuLdJls2+d0xA04FwDLJUSdYvnrCKVRxPtYr/IKMzMy3/BuFHxgGEQ+BSuFbdS
 CE5ukXSJrxa3i8VjN3+j/tbXnsXn5IxzP77xKp0Als4u9mGKSBz99l5YBZPm6J7d+Ve+tZcQ3vn
 intwbNj4mHVW+FBxaht0y2VdKowx+3nbLnYZF+NcJRkX1JfUoYfozVzIS8K7VQ005vIbkPoX529
 3m0apE41mRrRBcIYmKIk6II4+Tewk4DbjAH4YXvfpclIOAJqMS+iBzSGwlvj71KsBgl0XPoJCzt
 5jlu9RSJFNFDMw8EOxK1Ur9Lj+pvafeg9GAexPwBbF9gxFkEYa86s+xDRafWjCjP3y980SCwexD
 fFiykj+5rPrIQlDo9OI+4F2ECIOdrELeDGBzsfQYmKqIt4G3YlbpNd8nAMkAavt4YVdn+Vrer+c
 oy
X-Google-Smtp-Source: AGHT+IGkdSOUQhKguawLR8t/jOeQ/0g0PSfdE7P0U0HC02NkobQgJpIlhc6eixHT9jQmaubOtb8NhQ==
X-Received: by 2002:a05:6870:9713:b0:30b:a81d:b56 with SMTP id
 586e51a60fabf-32264a1f9a0mr3673376fac.38.1757348293308; 
 Mon, 08 Sep 2025 09:18:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-31d87e05270sm4597371fac.28.2025.09.08.09.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 09:18:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: n-francis@ti.com, Anurag Dutta <a-dutta@ti.com>
Cc: u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250901061659.986164-1-a-dutta@ti.com>
References: <20250901061659.986164-1-a-dutta@ti.com>
Subject: Re: [PATCH v2 0/4] AM57 boot fixes
Message-Id: <175734829246.1435428.15041657389264955124.b4-ty@konsulko.com>
Date: Mon, 08 Sep 2025 10:18:12 -0600
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

On Mon, 01 Sep 2025 11:46:55 +0530, Anurag Dutta wrote:

> This patch series migrates from .h to .env format for am57xx/dra7xx.
> Also, we do relevant changes so that the fdtfile can be set from C code.
> 
> logs : https://gist.github.com/anuragdutta731/82560cc9bc958ca70a25a95a7031eeea
> 
> Changelog: v1:
> 1. Converted to plain text environment for am57 and dra7
> 2. Added dra7 support as well
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] include: env: ti: Use .env for environment variables
      commit: 5138d3a561dc9441f956378aa649f7804874e8b8
[2/4] board: ti: am57xx: Change to using .env
      commit: bc020bf53adca747a533a364969bc6396ef58b13
[3/4] board: ti: am57xx: Set fdtfile from C code instead of findfdt script
      commit: 649f4a7d3ca753991c27c9c159a0aacc9954d96f
[4/4] board: ti: dra7xx: Set fdtfile from C code instead of findfdt script
      commit: 878888fd07bab1ed97f7f0fef7f6e93269074da4
-- 
Tom


