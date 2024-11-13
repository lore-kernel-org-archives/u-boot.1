Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49CBD637A0
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A318935C;
	Wed, 13 Nov 2024 18:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kBhRQpiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF50891A0; Wed, 13 Nov 2024 18:40:49 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9578B88FFC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3e6010a3bbfso4443998b6e.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731519645; x=1732124445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Su0rgMRreUoocT62piwySmWOgoRMVo5WvstNNxUyS9g=;
 b=kBhRQpiwdfzWCrw013sm/Z48mf+EA+f8I/WbXVpLh+OA3qU1GSqDhj4uFf12lxm8Ha
 LJa+78x1GC+g4FmfS4UeuG3AD3uxV6NcwFgVrjj8TaEaltzxWrHNh2C1P+IGkhI41vyR
 cOR02auZ0in3xVKDOeABG3aFMQ78481HYOjb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731519645; x=1732124445;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Su0rgMRreUoocT62piwySmWOgoRMVo5WvstNNxUyS9g=;
 b=vORy4Jg+KYSwIzhC7+RpdB2U/eMlJSNvwYK0iT/NeYeybfpc0m1xNmhzPyGheW/khF
 o+9o3VldlGnhC9TsGkmM0JXO7wraqPTQvdBy27BBMSqi3tiqhyUH6WJJnYX26vhMm2RS
 2q0v9RCgn2ym5PncLJuZbTNSCrHQ2MkjgZTPydOWEzD8Ib6iBGgUKCBEZFlR2aRHoU0d
 EnTaPSusFAlWnrHoPcPzKYgrp2VW4CfZ5eJC1yqhEKeLxaLs6OAgtkPv3m0kPvUnR6Iz
 wxetnuvmTxY7xzrjR28UCCJ6c41U/L6cvHBwNNqV+ZmBkDH8aSf2DPOM11ap/DxRjwrM
 Y27A==
X-Gm-Message-State: AOJu0YxxEf1ADvFWuLtgUwn0I0lCs6tBmmTPMInFTwD4dy0ihaum2ihA
 muM+C+fNtkCOwG4OsgMiXzSHqNtPOwAerA7tRKj/P9XpovCKQuCYyiimLqur1Gk=
X-Google-Smtp-Source: AGHT+IF+UnXEH8MYvSt1W00QhpKXYvsMiuVrEIwn9jN7H0MCAneHTQefsA34pR2/pcAqljZ0m20cgg==
X-Received: by 2002:a05:6808:23c3:b0:3e5:c89f:8ee1 with SMTP id
 5614622812f47-3e7b0ae254dmr3704584b6e.42.1731519645449; 
 Wed, 13 Nov 2024 09:40:45 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096bdabsm736295b6e.21.2024.11.13.09.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:40:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241106153544.1277835-1-sjg@chromium.org>
References: <20241106153544.1277835-1-sjg@chromium.org>
Subject: Re: [PATCH v2] Makefile: Fake external blob with
 BINMAN_ALLOW_MISSING=1
Message-Id: <173151964358.1299521.15812040581926545931.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 11:40:43 -0600
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

On Wed, 06 Nov 2024 08:35:43 -0700, Simon Glass wrote:

> This flag was lost by a previous change and has never been restored.
> Without it, binman cannot fully handle missing blobs which are
> themselves inputs to mkimage.
> 
> Discussion on this at [1] indicated that this was necessary but the
> patch was not updated.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


