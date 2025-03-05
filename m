Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA93C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 04:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10791807B1;
	Wed,  5 Mar 2025 05:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S2pll8e9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8388A807D9; Wed,  5 Mar 2025 05:34:38 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609E9800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fd80f30ba5so22795307b3.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 20:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741149275; x=1741754075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ77XgmSDmS+sKmCy2gmFF4Ob91Oxg/y24M3P9TWHOE=;
 b=S2pll8e96zpFdjtVcRmI676vgh1IWAR4XUqCRF1UlVh00AVbYlBLqVbSl2elK6PxcR
 tFZPH2z8uS0irFeSCpqiSkqRswL8wyWdEhkgxqsRS2tjwod5BL33inZt+5G3gufY6yLF
 VNyFtbLiZgVi1uYheJC4tBOcltsO8GEEDLJLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741149275; x=1741754075;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZ77XgmSDmS+sKmCy2gmFF4Ob91Oxg/y24M3P9TWHOE=;
 b=Oa8pK3f3DknWbR44udLkpR8a40ObU23dSLeCUKzpBaebun0IdXqAmhtH0KIKKEjBBj
 o99H6m1z8JYgloVlhP3VUe2xESIWWwxwoaW1mmvNYxfafh6+zAaFVHe//a2DFMb6pwBo
 c/QYBaNvh6aGCEzPTRwdccnNR0BlFC8OSchu3LKf8gy9/9Cd4fkcoTvbycXpJqxJ50LW
 fwGdUUluEgiwTMaqUTCDJ1uK6TazluywGiS7WBHL933f2i7rs3Rg6UiyhyE7Fuu4sm4g
 VKAPXP9qb9PJcd/d597yOCwKQq/zCAvL80277SoEltNcSWHxgNfV75L3r/v7mA+hOb/4
 0FwA==
X-Gm-Message-State: AOJu0Yycb48chvPwsoUXGsBgNuiWJRpt8XY9bfGM0JPbUS2YEBCHw8hb
 u/NkPjvbb3Rog1nKksctQSmOpsih9zEX73q3HC8R4A/NAgJeggygpp66qqjAhbc=
X-Gm-Gg: ASbGncsPAP3maF49xTEiaJEiIJrsk0025rH+YUOwado4tzbUTns2yxvGfaImGbeUq2r
 ukar/tJc5EBrAGN8sta45KTRShgR3qIDmatG25k+MFaFgYT+9LUcNg95ffZSHyGhZbz6fqWnHuQ
 v+SXY1HzYezaIr4wiuJYElHuJx7kf7FmAQGhHXDBpEmgkoiQQazFeWR/Sv+8B80gGsFUDBgaePo
 ppDbY8mftogIN1L2oemMoGc9M2b1BySJfea/u25D+iRjGPiF1mQUz+fP6GNvpzISt2/pIdOdeo9
 Vjjfn+ePoH/NhmNSvv3H03svpCPciinp+MQZH0WNnw==
X-Google-Smtp-Source: AGHT+IGRJttkKpdle5wDrpdMTkZuCVMctaY9036VwmYKmTAXQwVv1iOsZwIewGLsrzXqCpa5e84CBg==
X-Received: by 2002:a05:690c:6aca:b0:6f6:d0a8:8d65 with SMTP id
 00721157ae682-6fda30308famr25239527b3.28.1741149275305; 
 Tue, 04 Mar 2025 20:34:35 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca43b87sm27429897b3.41.2025.03.04.20.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 20:34:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250203162704.627469-1-sjg@chromium.org>
References: <20250203162704.627469-1-sjg@chromium.org>
Subject: Re: [PATCH 0/4] tools: Minor clean-ups for the command library
Message-Id: <174114927305.2897093.9623652494367906888.b4-ty@konsulko.com>
Date: Tue, 04 Mar 2025 22:34:33 -0600
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

On Mon, 03 Feb 2025 09:26:41 -0700, Simon Glass wrote:

> This series adds comments and fixes pylint warnings in the command
> library. It also introduces a new, simpler way of running a single
> command.
> 
> 
> Simon Glass (4):
>   u_boot_pylib: Correct case for test_result
>   u_boot_pylib: Add an exception-class for errors
>   u_boot_pylib: Fix pylint warnings in command
>   u_boot_pylib: Add a function to run a single command
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


