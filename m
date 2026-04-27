Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43A2FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F9184258;
	Mon, 27 Apr 2026 21:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XclfeebL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DCB83693; Mon, 27 Apr 2026 21:42:35 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C2784119
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de5badb627so2068952a34.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777318951; x=1777923751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0ME88Gz4nAq23BDApkfpBC2DK+gtaKg29/wF8G2sys=;
 b=XclfeebLHnSEECexJnuw2ABPWzEL54lLHy05YXV+vElqGGwR+Pp7wx4c8v8qdRpNKq
 lXt0LVaDUsSzQjtawWkXIed3EBRRE5pEF4/Jj55okrDfszrARTD51DxEssb8xRk3NV9X
 ysiJ14tbnyErEJRUL+FdM01AnEo8dBlDfp2wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318951; x=1777923751;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A0ME88Gz4nAq23BDApkfpBC2DK+gtaKg29/wF8G2sys=;
 b=NsjmbdWnVWmdGIv21qXO0u4NTwXFZRYiICEeT4kMeawRW0hmeze1OMSosOw7QSxfQe
 4Vk6+y9V5PrOg6kGMPeqQmd9t7dRDe4nR6uoc7GHAxEMeZIkCLmxgS4AEGipT68OFkaV
 e+1uziscMECZyeDOGHkfiZk6uidpW/VLHPtAaFomGyzajpYlAvDvD8p/WMo7M4U3hw5h
 cZdomO/LNzE4sAYjTJb85QoJLim1c5oGIkKzNQsL68bsUbbbxITlB8ijEufkB5QwAXep
 kYyturtUKI7J0AS4ier4YtbWgVmEUJxZB5OJevFFUT460uOVe9Yu4g1WtYJ0AJTClBHu
 MKHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ957iKv0aZPPuyt49riIq1lPhgduKg1n24rVckJk7nY7mDutWW7J0Ms6jf3ykagwA3HxsUom2c=@lists.denx.de
X-Gm-Message-State: AOJu0YyZ/uhg9zxm1iE4mTV0lizNugWLWQFpLy220yy6ZAeC49aJHZpp
 WLz0Ps77mWZ2BYH2hGmmr1+FoOpE2zD9dBTIozERbdkTj0kZ/zcqkVKpxj9A9H/clu4=
X-Gm-Gg: AeBDiethCFK1tbhYQev7lAG13LsCxgJ9M+0rO+js9KfRugj0glMo9kohWd6riL5HD6L
 K8BFGw3+aSZX63/PMoh6JW8YdR3kP8RPIWpsTtOU38sauqn8iZ4QN7SG6MFlkAfNX7Mu3gqi99R
 bY++c2gI/6ShNvx/WOaUn6StoDktLzmbK/DxbBJr2pXjHqcyqVGaRQ4RJQa0Wx6CanxS6RVhUeU
 FRPjCPp2isNI4fdDXWy61I+qWoEEexJs/mpWmE3sRlm2vbkEe501izstaM5gL1UUB/ugYUkcMgj
 TKEgXv27DhBTxF9+tP49MIr8Ee1mB4DBbeurQtBb01Tw3UQU385OSNrNO5vUpWYz/H2iXsrc7Hl
 Xb8x2Ky/Jsx5sKRsXd5HXgePHLy9rVVYlrEiA7sXttm124FydAZfPKGf/OcG3fnVR4J5qkCsbMW
 8nnqYOcxmIxgbGz4bvA9XUJpkjojM6yVPPVvaW4CVoH6E9lBozlu0j/5Aj5MqOLxB074uGUw3/B
 dOEMuxr9094G33x3XtbxLkoVV9XiVylLIxvaaX273k5zhhk0UIat1kwGecexaud8vQ+Zl5Y6mri
 KPFzJA==
X-Received: by 2002:a05:6820:8c3:b0:696:1ef9:e08d with SMTP id
 006d021491bc7-6965b9876c1mr210177eaf.25.1777318950995; 
 Mon, 27 Apr 2026 12:42:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965b94aa0esm187247eaf.6.2026.04.27.12.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:42:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
References: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1 0/2] board: toradex: aquila-am69: Fix 16GB dual-rank
 DDR cfg and memory size detection
Message-Id: <177731895033.3526444.14231664569615597743.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 13:42:30 -0600
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

On Tue, 21 Apr 2026 17:15:54 +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> This patch series:
>  - fix an oversight in 16GB dual-rank DDR configuration
>  - fix the memory size setup logic
> 
> Emanuele Ghidoli (2):
>   board: toradex: aquila-am69: Fix 16GB dual-rank DDR configuration
>   board: toradex: aquila-am69: Fix memory size setup logic
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] board: toradex: aquila-am69: Fix 16GB dual-rank DDR configuration
      commit: 31c5d4f18094754b9e8e823184267bf42e59b7a9
[2/2] board: toradex: aquila-am69: Fix memory size setup logic
      commit: 550101b487ff2b3c9d4f9057bc21dca9ab90b49a
-- 
Tom


