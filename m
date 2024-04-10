Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAACACD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C996881F4;
	Wed, 10 Apr 2024 19:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f6+Y5rlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E17881ED; Wed, 10 Apr 2024 19:43:31 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A3C2881DE
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ea128e4079so2562847a34.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771007; x=1713375807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAHPoO58COpXBk0tgXnXqJ6otBLoqVN1GZRILaxjD0M=;
 b=f6+Y5rlpRm3+Cc8O03Pdw9OMMYnT13+4UP0J+ehSNnBEclIjz47dXULx2CIH0I7PQB
 mExldsKHMfNzvtA5HWUYwqWQyz1IiXcyQFTd8aesdJ5699M5XX0fR+QANBN0oCddXkUj
 Um15twDSU4Ob40kACP8u0H3ZyGnPcNUs9z/jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771007; x=1713375807;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAHPoO58COpXBk0tgXnXqJ6otBLoqVN1GZRILaxjD0M=;
 b=mHJO8IEsSiSQmK+rTJmhduIpNskYsRkPHSXJmrK9aNkD+u4NvVgQ3nxmXuzUY+ZCWr
 7WC9D3OQR26xBB3eDptl/azvbxmC5Qphc5n2wgwEhqTiubSM8V8rjIWM3dkenMXSYKHq
 TY+7o34GjKq1v9E6j5L0s6cibXPx59G+mGlp9o/eszguFtgSn9fYvZAt9aL+ri1Rb/Kd
 CUsCM+qyB8AKhVG8hRNOpApi9a1Zglo3dQLMNAZokW7SB18/gwzRbu/NaYbBYew1k4H6
 YPG1D7x7HBRO/06k3rCTaDTSMSjUgGZzNMwdJ2aHPmwW2yC4Mf4Ue5NPogl2pv2DRzj5
 iuLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC5BnH+U1tGVO+R2KfCxW62nCkI+BNKCy4U7ZeThbqz824X0odORS5I3fc/WlKwnlvVb+UUV0EEXinFw96njKGSQOpzA==
X-Gm-Message-State: AOJu0YzVRKbimbJXf5mSUHqXCIoHNyYS6nmBYeN+efpy5IouFrQ9NjXR
 SoFVCFjEfxgoRGBJ+wWE9iuTY7fpqAYbv4ZtCiHG1B6reiDRWWGmu+4QnCnr3Z6FzI8XKNNrYAw
 wX1718g==
X-Google-Smtp-Source: AGHT+IG2eXb8F5cPr9vO6gVEpc0sP0TMRMUruT+8etWmIAreD5btqQ6YKiWSkkoWGRPqY9oogg2ckA==
X-Received: by 2002:a9d:6f8d:0:b0:6ea:3869:f3b4 with SMTP id
 h13-20020a9d6f8d000000b006ea3869f3b4mr1359911otq.22.1712771007660; 
 Wed, 10 Apr 2024 10:43:27 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, u-boot@lists.denx.de, xypron.glpk@gmx.de, 
 Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
In-Reply-To: <20240330111121.5935-1-Maxim.Moskalets@kaspersky.com>
References: <20240330111121.5935-1-Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH] lib: add missing line breaks in debug messages
Message-Id: <171277100634.98421.14759390696653100346.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:26 -0600
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

On Sat, 30 Mar 2024 14:11:21 +0300, Maxim Moskalets wrote:

> Add missing line breaks to improve debug log readability.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


