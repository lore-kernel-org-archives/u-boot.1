Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369E2D2CDFD
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124A288D97;
	Tue, 22 Oct 2024 18:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n0CZk/b3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE1D88FA7; Tue, 22 Oct 2024 18:27:13 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5D188216
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b14df8f821so495340085a.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729614429; x=1730219229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brAIHzJPrUOcr+tOVqG3CU7OQkmj+O6vqlLrW2jpOS8=;
 b=n0CZk/b3hwCykz0tuGHy36kcro+pA/PUToiD+tWAsRDzjaF2jocKrThDo5hqlw6urY
 68y+8/+aQy6/E+Twl0oWz5UxfmityuDq/U8939gKF6O6htoEpGhXbhkT4uFTvvZBT+dQ
 HWZDN1AE+oWQ9LmK+SI6v07pfTVp3+xZFg5M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729614429; x=1730219229;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brAIHzJPrUOcr+tOVqG3CU7OQkmj+O6vqlLrW2jpOS8=;
 b=UFldGLMPMUHAxq2cALMZcIPCyd9cYk1r42ig2I4VsCME7zVBV9jTGesvG/JGqA51eS
 pKqpssOzqQsJYO9uEk4j6UD9oEPUau+agqfx+FuAnrTucxOV2YdI2LCvGRwTxMYTbKry
 38V+cUqWIrPPkjU13LKlYu6b8IslX0Z1bh9a23zwhiXak2HzmEJcBRASQ153rzKJgtcS
 vNxOJOflUeR2w+/5KF9u33KcUsc+X1jkYQKWVHkln1gAios+s4iCqXpU5Ogr6UG38eG7
 7cmff00EeDkLZkkUmOg8NsHFkbn7/Y/sh0q2uTj4JmYqxA261s6UZSWmmefb280NIn+T
 yimw==
X-Gm-Message-State: AOJu0YzxddiujFdQbuZxdOIguPlbrvtDi6HPKIP39F5mq/aPNtDkuWXO
 K+MHafHd0jWUXkA7Ed69XqMNZFsBHCki+g8VplKdmqX9dM/xY+w/3OI/WAcjKho=
X-Google-Smtp-Source: AGHT+IGlOmdECqxDgfGE5nunsj9llFd7yfLVyuIZlJ8KxdsaKBD/nf4MC072WjqArhT2yrnZC8YoEQ==
X-Received: by 2002:a05:6214:2f85:b0:6cc:37cf:5dc8 with SMTP id
 6a1803df08f44-6cde1528766mr237645766d6.21.1729614429735; 
 Tue, 22 Oct 2024 09:27:09 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008b2be4sm30344046d6.2.2024.10.22.09.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:27:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Keerthy J <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Aniket Limaye <a-limaye@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
Subject: Re: [PATCH v5 0/7] Add AVS support for J721S2
Message-Id: <172961442811.3127138.639160786960070139.b4-ty@konsulko.com>
Date: Tue, 22 Oct 2024 10:27:08 -0600
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

On Tue, 15 Oct 2024 16:22:16 +0530, Manorit Chawdhry wrote:

> This series adds support for Adaptive voltage scaling on J721S2 device [0].
> 
> [0]: https://www.ti.com/lit/pdf/spruj28 (Section 5.2.4.1 AVS Support)
> 
> AVS Test for J721S2: https://gist.github.com/manorit2001/b2fd9f6764a863294d4aa0755c83c84f
> Boot Test results: https://gist.github.com/manorit2001/d44e035552cb19aadeb0d928d5cb5f26
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


