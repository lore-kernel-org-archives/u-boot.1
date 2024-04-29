Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC41EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2713A889AF;
	Tue, 30 Apr 2024 01:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aiBHxrWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5262A889AF; Tue, 30 Apr 2024 01:04:03 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1308A889A7
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ea1a55b0c0so2607626a34.3
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431839; x=1715036639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7ESxRF4yPe9oPgVPFvkE79JycxKn18mQM1sczKv/Ws=;
 b=aiBHxrWlXtl0stYx2x1Hy79djC8SE++MGrkYsg+hOTkPH7ciIq7DrBJ1dU9A4ZSgES
 LAwJ6pvL6B3EaC9dqSydESAGYJjU40ADuAVz0aZ2RWdzTTVtm/X79ENZqSOxRhNQY22V
 E62lqBVSPAN9pl/Q1vi0wbyXctRHDzOyR7g6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431839; x=1715036639;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7ESxRF4yPe9oPgVPFvkE79JycxKn18mQM1sczKv/Ws=;
 b=a1cAZdG5z4YAFJ0DIly5AYEshmBTP5e7j/6MG/DuKgzzLn50M5xgryI2SiW+/Txgwo
 W7rXCfD5FFgYj374dLjicj2tOK6JmYfqPyhuXpjJDpaii1aIli5KWG0x4COejc5IVdNK
 4/X+wX0whwj3Lw+A+T9v6FGhTVWCBs6x4UvpTet2lY8m/nUAa7lxTIoT+18FVFrSDNAb
 Sf9ZCZFwqv0V/iffLBWhUivGPMqv41HW8dO0EdTbx5Z8ACC2ZVVQISwWYGc2B2NBAnol
 2XcyXREtcfzv+FRKfmJEfKQ5Yr6swjGQWv9Nu9uE8Uq6HEPZ1CVmTy/WQe22nz8/EaBk
 VRVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWGK45cPetPt/kqLWAzfIekmKo+StzxZ1rWXipVhAVWZqDCyF6mUY3WECclUaaWvLWQvH5PtnmYwjYLJ3dHLxT6ycJzQ==
X-Gm-Message-State: AOJu0YyFnLO2iuEWu2HuBNcgZ0p8ClUwVZFFk8lIiwD4iG7yvDeE8goG
 /0wOuagoRF+puG37XO7XvyKiU2DW8Edo2v6DYDV3jVvd+pRVMfcQU8qwti6rIO0=
X-Google-Smtp-Source: AGHT+IE62ep15yJXj60yoHL/VagGeMYmJr7oVhFNtGs11vGUz9Ih559bTrCG7mMiLy46ivBm9Guz5w==
X-Received: by 2002:a05:6830:1e8d:b0:6ee:1cc6:6af with SMTP id
 n13-20020a0568301e8d00b006ee1cc606afmr1267096otr.17.1714431839707; 
 Mon, 29 Apr 2024 16:03:59 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:03:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de
In-Reply-To: <20240416073524.25764-1-heinrich.schuchardt@canonical.com>
References: <20240416073524.25764-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Makefile: don't add -Wno-maybe-uninitialized twice
Message-Id: <171443183836.1749944.16997198303507908886.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:03:58 -0600
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

On Tue, 16 Apr 2024 09:35:24 +0200, Heinrich Schuchardt wrote:

> Avoid adding the same flag to KBUILD_CFLAGS twice.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


