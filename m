Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCDDD10374
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 20:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F7188FFB;
	Thu, 24 Oct 2024 22:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dudiUQ7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CB488F1E; Thu, 24 Oct 2024 22:43:05 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DBA089003
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so100994285a.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729802577; x=1730407377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNEq/BKIJEcLug4Mq6sp+Yd+lEztw/Kw1VtjrK7mYN4=;
 b=dudiUQ7ANV574aa54s/VMKx6UfqVE9EgdSWT6vpIYeZX5Lz6CgSfCojPUerU6/10kz
 XZKad4z0SzEkYMnGaNhRIo32gdXEpxLhh34tJ/9u1CqCpluT0u4ox0uVEEeeSiOrQAnR
 Uz8VbfXPWsn7dQInAB0oL9Ijbq1nknVYQjz1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729802577; x=1730407377;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNEq/BKIJEcLug4Mq6sp+Yd+lEztw/Kw1VtjrK7mYN4=;
 b=neRYbEVUUAeH7Dy+ZdGeDZzQHSlo30IjblbeYSqvx5+F3UQwckpf3jqbnIHdIGqm8T
 tlpf4CZRIvQSygl4ven+VBrHANGKJILQaVCsxREsvOZx8lg2jaucyQYNJUdEGmj6WBRo
 vkuxkRw2gbvhOOqcSvGYjAdtvXFj2yp/mCNyvq69kQrYmFB0owHSOTxJIcOYmRZLhcjs
 dwvR7uZrfsNEVQu+ZWnmRlokVky3hOIPrhHSPDVWtbM7un9FHFop6s31/OtkygFHZa02
 m7b2Slv+djfSe5lfwlj3S30nLUMH9zqpir/WR1o8Y3wileloKppK4hLDxIGjeF4UHnGT
 BgjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwG6M2itdGnajEuyQF2meR4jqZ/S9RsoIKwRLFzvsF25ezyqhp7Ra7V6V5cN+P2Wm9Mre1hyA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+9kYNRvfpE2wjcCjMvN9UnUdCXSNv0sqLLHow2t3baqASpkcg
 S9Fao9dVxPl4XZ5XDctTYduS8uI32jiydpOtCfVYWnDiCWuaC+EMeTmOZMtdyzJZFkKG6HNq8HD
 JeB1bAg==
X-Google-Smtp-Source: AGHT+IEQFtQ8j75d20s0+NbyAhTWK5lVuCyhmV9zx6dS1H3qMQKOhngL7f1r/nIR5jMVYJL/nGamWA==
X-Received: by 2002:a05:620a:2688:b0:7b1:1cf6:cfb9 with SMTP id
 af79cd13be357-7b186d0b8cbmr330994585a.55.1729802577376; 
 Thu, 24 Oct 2024 13:42:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659c0361sm521428985a.19.2024.10.24.13.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:42:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
In-Reply-To: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
Subject: Re: (subset) [PATCH 0/3] block: make blk_create_device() static
Message-Id: <172980257582.160410.369325579049390219.b4-ty@konsulko.com>
Date: Thu, 24 Oct 2024 14:42:55 -0600
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

On Fri, 18 Oct 2024 03:30:12 +0200, Heinrich Schuchardt wrote:

> There should be a defined interface between block devices drivers and the
> block class layer. Most drivers already use blk_create_devicef() to
> generate block devices. The EFI block device driver and the Rockchip
> rkmtd driver are the exceptions.
> 
> * Convert the remaining drivers to use blk_create_devicef().
> * Make blk_create_device() a static function.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


