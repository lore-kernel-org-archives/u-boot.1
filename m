Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010F7C31D97
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 23:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E1388896;
	Thu,  4 Jul 2024 01:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X3GOaQOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF168888F; Thu,  4 Jul 2024 01:22:23 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F7688874
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 01:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-700cc388839so39963a34.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 16:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720048940; x=1720653740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8ynFUjf507Tt8SqDLUg+1LE4KK5Q5kqehkyjRT9oCM=;
 b=X3GOaQOm/Zpy9l21sZ07ZW9DyeLIF/iiRm8+AaODrvqxdB0IVkjIzDHxG2f39btmlu
 MusAlduc8beEwVXw+0DWOk1C850iff3GQSTH9F/QBYOTELYFhzumEmFvKyRqWUtgaZ5g
 gHm11VNyVRwoq1nKfPbGKTRXJyYTDwpbiDLJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720048940; x=1720653740;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8ynFUjf507Tt8SqDLUg+1LE4KK5Q5kqehkyjRT9oCM=;
 b=I5gq1TemoGoxVDf3Vtu0qL6gYTUOumSbk1WT8fqR9poveKaVGX7MpF9Nil8R9iIHpm
 LonMJBY/NY+5q5AzDv9muZYcY/GYEJWIEfvHm5hfU/aGRNgELpLA9q6QUAWnl+B/ySQ6
 pPWJ3DQioQ8VV8FyKOEUufyC5G/7Z9mlHMkgo6x8VRKjMYdOV3Yfevw4MTdV/YoVaYE/
 exXsx71/vNxuWxN6boRq2D2tx2cWH3GZgLmrXq1kVXvYAK7zxpUj7hq4HmQqE6fdQ1LE
 H0/kVGsa2JAqfoHOaV9q/Nyp1ofLSVtkQOGaJPT8iQnAbcxNOpEVMMyJzXYLIaUP3MgY
 7GUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdAKVWYPnkrt8l+0DbB3VGTiOv3WIxFI1GQ1TrT/4uLsLfouZXKCRZZMlnkfiePUOeG6c8cH/tBbTJEbznqUvZ8xrZJw==
X-Gm-Message-State: AOJu0Yw4laQKC2OUBkWD/F1M5oowZUWpfXVE49LMtqummuz3vsOup3Li
 Oxt7Z5a7QLp1fZ2iexak19nRT2d6o03Zk4zBB5e5IQEKhFdFnsvzm2G+jUwiIW8=
X-Google-Smtp-Source: AGHT+IHNIv9ZCDtHIFJEil5d26/vGuSdrT/gcLNeL5mZl4LqMCuAhxson2N2Y+OQEGZiCSBn+Kb8ug==
X-Received: by 2002:a05:6830:104f:b0:702:21e0:fa8f with SMTP id
 46e09a7af769-7034a7ef8f4mr75444a34.27.1720048940244; 
 Wed, 03 Jul 2024 16:22:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b20212sm2145030a34.61.2024.07.03.16.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 16:22:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
Subject: Re: (subset) [PATCH 0/3] cmd: avoid duplicate weak functions
Message-Id: <172004893863.1443950.15063283925158304623.b4-ty@konsulko.com>
Date: Wed, 03 Jul 2024 17:22:18 -0600
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

On Sun, 16 Jun 2024 19:31:02 +0200, Heinrich Schuchardt wrote:

> If we have multiple weak implementations of functions, the linker might
> choose any of these.
> 
> ARM and RISC-V already provide a weak implementation of flush_dcache_all()
> but cmd/cache.c provides another implementation. Add an #ifdef to avoid
> the duplication.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


