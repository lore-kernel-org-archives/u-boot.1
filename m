Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A741AC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 17:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E830E829E4;
	Thu,  8 May 2025 19:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uo5XDCYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDACF829A1; Thu,  8 May 2025 19:44:44 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74754828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 19:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fa6c54cdb2so1058704b6e.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746726281; x=1747331081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zWf4x76Rc/hu9YYEKRSDREYplOO6IjA29SuyhwXAxs=;
 b=uo5XDCYRH4JSD9nIlK1fLxCBd1+vLLJWn/lqYQDO+dlliTkJyK9gJOPbxzFP4mmb4a
 xgGgY4fq9h9fLIiXxE4TEtktj9oeK+dyFIl0sK5NqQcXGjnxWMOv2jPxv2PYlxTz5hO+
 tBsndrFX4wUhapZ24MirQgceogk/4iJP5cHLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746726281; x=1747331081;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zWf4x76Rc/hu9YYEKRSDREYplOO6IjA29SuyhwXAxs=;
 b=So1e4EeeoIu8WRcK3Z8e5VW/mYNW/23bnOMfLQss/oFiBZbfopGeKK/0yUrTRBfz9F
 oE869wP356ZX+Fd27f8zlaKamgXXtGaJnnrfRh+jLW3/f/r1HcF6Jjy6byPXsLz0XJDd
 T6F+d87bOJw8exxdgzILJPU0SYk1Ot77KMrmh1ciwGOtBQmKX4ARyUMLkDeW4TEsV+sQ
 ysyAnlY/0OZz08gFZ6mq8vOJpJlSgexu8rK3QH6BvuPATmVbSU1SQrdqRAwp2rUXvemV
 eB9t9y0hrE+0IKyNNp1yNBaKjjtX/YjdJzfrpR5RJRtPYsTGP6/VK8GrzSAyqbhxId1Q
 QCUg==
X-Gm-Message-State: AOJu0YyTaKKzJ1qywHAWSZN5PY608eWVNZx83uZY1BeowvNPFAKxeVDD
 XvkJshUkMCTYYxItbuIebxN+2tVmXVlazAMPXBoNWMJEdbHGyfUGLiL5xJXkuNhM3iho310NGb9
 r
X-Gm-Gg: ASbGncvDB8efJmU0cDphHS93P7UqaOtYGEG/h+52McbMP0zOyEzMiVG7k+ecR8dPuia
 wht1fGhjyVzmCKKCGJMvMapLvRamn7zN6DKoKIjOOcvnXANNQ6t4o8+ZevPjMe9OHKasaITsCUV
 z5rEKLTFGH2Qsfyw+3BeUaIq//ZePd3A3oVcCPIeO9T6182UOSR6m38GSSh7GBwNHD6EujqCJHj
 O8SP8H0jTJN+QGMfpsktLM6iJSk2zR9/nhaUecRbV0WPvBDXSdbb2/N8SYEhgpSImW1wgI4VhV7
 jleaN6XIWBJvSkYcrB2hvd6BfQv2lb5X+Y5RGIfD6rraGgAc2e2KDBkJbOt3pAAa06iZ/0T4GYR
 F
X-Google-Smtp-Source: AGHT+IGpKyM2OJvZqr/cNiB62X1nAqpMg0rAIfQmCi00/oeorZRJaTj/0vTmqxkdyGj6gLFFkoQ7OQ==
X-Received: by 2002:a05:6808:1525:b0:403:3c87:aa4c with SMTP id
 5614622812f47-4037fcfbddcmr511750b6e.0.1746726281185; 
 Thu, 08 May 2025 10:44:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40380398aecsm50482b6e.43.2025.05.08.10.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 10:44:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250508151311.69585-1-clamor95@gmail.com>
References: <20250508151311.69585-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <174672628043.621629.8995503418496459997.b4-ty@konsulko.com>
Date: Thu, 08 May 2025 11:44:40 -0600
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

On Thu, 08 May 2025 18:13:10 +0300, Svyatoslav Ryhel wrote:

> The following changes since commit 48db49b0977cc1c9c9abf82c0fb704238fcef4fd:
> 
>   Merge patch series "include: env: phytec: k3_net: Remove net_apply_extensions" (2025-05-07 07:59:09 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


