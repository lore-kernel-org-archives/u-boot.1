Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B108AE85371
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 16:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F67840D8;
	Fri,  3 Apr 2026 18:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AHiX335W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1940483CF5; Fri,  3 Apr 2026 18:09:35 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E935C840AB
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso1031165a34.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775232572; x=1775837372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAvPMy6sL89BZd1CEJAMdUo1fS7PR2Nc9/Ql/IxSR+8=;
 b=AHiX335WFE3R+TjfswkFCVCz+W6hzyWrmi/mANwnoVOVmzSJP/3T1fDVJUmyZyzjPG
 EXPRORkrlCfTbHCMpeAR02ksvfKW2UeoGElzHkZAoaqWErdJJZwU6PJqFkrSN3f9+UgR
 HmUbK8R+T3f+TrlV6MCl4UteYNncsE89aCekE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775232572; x=1775837372;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jAvPMy6sL89BZd1CEJAMdUo1fS7PR2Nc9/Ql/IxSR+8=;
 b=PrSFte8ZxPQ8O7z44CZFzA7bUWUEQwlZodU/j1DoTTLQ3LZ99RzIcgmk4gotJ4uY6f
 RcuLCtdVYfPQUoy6E8aZJFBtnJfcLKy6PilJ2c9qRoA5eQ5f1/+RdQ3ogD8Zu5HW6bXb
 fLMd91zQFOzaTLNhEQ6hbFB7HGUI+Kgv+MdxZ8n1hJkFTIKm5UkZcwdBpKW34y3h90y1
 Nn2JQrkAKoi7FnZXFxPnwuSiwPJpwqqmWwpLgrJ8drJtuVy9F01kFPy+GjxCYXoxb/iR
 Gv8o/pr2FQxVdoK69PCg8R9apAIS+kRejMAX9q9QJPgyx9Asra52nXXj6RZuaQgeiF17
 eVXQ==
X-Gm-Message-State: AOJu0YzEKqI99SFpAdEr55ziMU8JGNeYl6/bNsGl/RZ4QMq64Y+RWKjQ
 McGP8XdHaQQM0r5rUsAjmHbt3TFS49xXt5ta1STnVRoSnPx4vHaPDL6Q20A64n5+kF8=
X-Gm-Gg: ATEYQzw8Sxu9cwf3oIX/e/AbL2JgP1PWHglQCee0Y2JVtIkUBbwkDMI3Cdx0+AfqZpN
 vaztVxFRkLq/RDOiVVrTXecL3j40q7CE7d+jF+fb0AeQSkYQ+dyq20Z9y4BWPVbM3V8LTd6b4Yl
 PORZodTouRbYvNgRFPb846YkG3ObPM0WyGVmXGOIMX5OdTkr+E6XlBt5t7uKKSjmYOCdxCpVQrl
 18rc+JAaCx8d2pdtSIzijIf06kt3xfdNrwhhwYv3ichcwXyAJ2Vrsr+fjrS7bxV/GU4wW6s8a9S
 YjtZByZmSK07lc4Ua7k/UVTBzn4pWb3fh8JuWqYTumHFjAP3ccmMr7N8FyayU3sDZXGXulpX7po
 Y5K/HrUPbP/rd3ywVeqpClflnIJLihqOIG3fUn4qayk5A3TAWPgR7PLG8xACgesCOzG7Xvp928V
 JrLcyWzYHeDz1x3WxL7ww4tuniSnfKBTzPXD3kPTv83/8+TaScye2X1feHkNrXa2jAwDaMdOUnD
 LwGNkPv53/ynjAAO3wSU6E7qk/vVdbBLff/IDSSRvlceMM=
X-Received: by 2002:a05:6820:160f:b0:67e:4229:b48 with SMTP id
 006d021491bc7-6822182131bmr1675427eaf.51.1775232571705; 
 Fri, 03 Apr 2026 09:09:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-680a5400a5bsm4002167eaf.3.2026.04.03.09.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 09:09:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Heiko Schocher <hs@nabladev.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Linus Walleij <linusw@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
In-Reply-To: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
References: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
Subject: Re: [PATCH] .mailmap: Fix Jerome's entry
Message-Id: <177523257055.2233070.11506905466392991013.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 10:09:30 -0600
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

On Wed, 01 Apr 2026 08:10:15 +0200, Michal Simek wrote:

> When patman is used email address is composed together with both email
> address from .mailmal file. Having two commit emails is not proper format.
> 
> Error:
> error: unable to extract a valid address from: Jerome Forissier
> <jerome.forissier@arm.comjerome@forissier.org>
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] .mailmap: Fix Jerome's entry
      commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
-- 
Tom


