Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49003C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 21:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB1B800B3;
	Mon,  3 Feb 2025 22:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="exKdJea/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E41800CF; Mon,  3 Feb 2025 22:26:30 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B66E80087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 22:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46783d44db0so46176091cf.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738617986; x=1739222786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sp0Vf77AyiSJP8ISS5NhZsPfsSckeXittXkh9/3Cb+g=;
 b=exKdJea/KwD58We1uTT/X8Fi6gdX3pkMyTO0O7TiGdkMUZI/W2CO+3YfWtWpRyeeXK
 UubWF1rcOAdnlDf/Gg0UsdhUJQfqasjiAcSHGPbPih7yCgsniX1n9KI3RrV26/q0xOpt
 pxJzXKzkfy0PtBdas+xOOvos5XJ0JQ6kEU74Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738617986; x=1739222786;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sp0Vf77AyiSJP8ISS5NhZsPfsSckeXittXkh9/3Cb+g=;
 b=Iz6Uc39XxlnDUhUocg7Tc59VR8bLgMIfts60vQmEVnVbhWJW8yyvyZTZQFjPXjfIil
 xIbvfM9x2e6p0hWB3+0DI42L/iXqqN0RhYw0OKYoWpIZHRa6utkTWsFCKW77ldtWhDGL
 fPDAJWxHPr86qhyEpu5p4FSQbb5kGLfKGh1zbfDwREOsnvwJyWMMCI8DfN/8VXgE4aD0
 MiXwwDpJt6DCgR5V/zI4MzxnMPVAr5mnVFlx5P7Vjv59ahiB/FljNJImf5vQGcXCg1oO
 fVFG2en1RByZhFBNz8J9Eblni2oRvq00pm4HzRuliqn+TpIgspvzyJ9Ht1z1nPj1kWFb
 PB0g==
X-Gm-Message-State: AOJu0YyyYkYMxqLIFc+xm+hyTSHEK6+Zm52OtJK+85a7ps9QcceQg3Qv
 FzSkw5G0+gPHijDdApY2iOQXXhnOUOCzfBkXxmv/xQeIZzVd/YJBIDQeguVM1ijpict1sPl7nc0
 c
X-Gm-Gg: ASbGnctFuX8siB933UmRxdPdCsHxo2RVZ9MUnAAvqpjTAuOJjOKcecUjDKusqQJZNdE
 zCW4DkwPRABAQ0MrlFQTBgyaCKTkVYSwr38UXADm6B/uyNQ6uS26CrWZZ4/k5XGLc7Dt4D08Ga4
 zBEMrDd67fclB0XHMK0DctLdU0nzOfZXW96nmCk6vk/Jcp6RxCvN1qC0G6Uu1LSfLm7xZrvAsnN
 OKCc9FPyq3sTTVrIviuUREodMWMInQK0Y1NLrZkBpquJwuAZDrTLpj88akVHdDxsXPrW6kiJ4RY
 lrTGtnEg6hn0Ag==
X-Google-Smtp-Source: AGHT+IFzHw4mPJ3CGd5E02MRpdO4trGqjAvqvic6o9lZbh77IXsYSsaIwho2FQhvqW0VCXN5jr2GwA==
X-Received: by 2002:ac8:5a4a:0:b0:467:6e45:218d with SMTP id
 d75a77b69052e-46fd0a8072fmr357522681cf.3.1738617986341; 
 Mon, 03 Feb 2025 13:26:26 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e0c20sm54209441cf.42.2025.02.03.13.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 13:26:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
In-Reply-To: <Z6B7qShmjJNSfrfL@swlinux02>
References: <Z6B7qShmjJNSfrfL@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-Id: <173861798481.358028.3415091339438420926.b4-ty@konsulko.com>
Date: Mon, 03 Feb 2025 15:26:24 -0600
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

On Mon, 03 Feb 2025 16:17:45 +0800, Leo Liang wrote:

> The following changes since commit 2b1c8d3b2da46ce0f7108f279f04bc66f1d8d09a:
> 
>   cmd: Fix Kconfig coding style (2025-01-31 11:29:05 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


