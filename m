Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EB6CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7736583DAE;
	Fri,  7 Nov 2025 15:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nAxYEmGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB10D83DE4; Fri,  7 Nov 2025 15:17:12 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C518183DD7
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c2948b774cso455181a34.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525029; x=1763129829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymyug/ob56zc2RUMxwfGMAwDuJnCW5+U3yqaxQqOAIo=;
 b=nAxYEmGSCtsaYnrHyd72l+THx2rhOc4bu1R7mp0xboiSbSyu3mGrP9Hhv6BkUarKJI
 mujNxGlf9vL7DQP2i4iN1unquusYeNAJi4lub5EVkyaWbKK/4YV7IymaggxjOODiaHjT
 wy3U8UoLPfK1GcPuOFVpTS9yn7LAxCx5er7R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525029; x=1763129829;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ymyug/ob56zc2RUMxwfGMAwDuJnCW5+U3yqaxQqOAIo=;
 b=ZEVdm8gG3wfKL4ThlzhFHvqF2HfIFA0NOUNFOY+5Ohz/67pofmTUieH6p+e+L1mvqe
 K1RIKonAICYUwm6f5uXaemCBL5hhNEb7SFUbvhxGzcpCpZgofSPZWyYGr80aZ7LWwHYa
 u5Y8IUK3F84a9Un60i/ReuiuQXcVH55nyoz6DP9BnLirGoS/2a4PZivwhWWRTaUDmWEc
 imC6DXKuPCf3REvipDTT8MGIP+j0A20TMsmEIjJgxWjXYakw/M5dOFYggKQjWhTm7zoZ
 sp/4q0fyKL8l8Km4s7kKyF7HN4dRUaiaA/rN7q+D8Ygn67qN3zxJ3qDGCDTPWHWRA3Yy
 vy1w==
X-Gm-Message-State: AOJu0YxWW36ZltTLv/GUorhw31UFcXZmp41ztdnB2dBIq0xVlFvxgpXf
 30zBfePTrCdQ9O9ui3RwhCghjnnJY7ULHohKyKPy/XuKii5A9sk8BdMiex9Wo6y2l/M=
X-Gm-Gg: ASbGncu927PdoHsdNLDCraypKyQodFCN85rA6NhCKXvyWDwNZ/acdC2Vtg8IYVNKDBz
 C9oom0OGjhpEkPmbmr2u9zmJRN03Wqx+3abB1hnIJjFdZx4IGQOUyaws5QkAi5Jg6PWaj3RTQV7
 yj5wurYsYUsPlCuleeEH5/pKvlxsZieKJkkF+PZLFUSzbE77YPWaX/Kr4/kIa2H7jMrhd7olW+Y
 rogkcHqdLaMePMv4RXHzpzCj6sjwClXGIOIxz55tORCVGCuvpvTMA6t/o4Bip5Z3xVvhUdYWdiN
 1HOy0RUZWxanepGlPJXKDKY1iGiy3lf+mPR548juSBWX1Pipg6xQTCKYDe1F8DhIUW2Ea5jkF2k
 UPCRl/9YtUHrbiehnDMBO7Zw5im6g4MnVWr3aB/dj6S5eDOAZT/okqhF5S0XTMVNFneGior90KG
 hm0sW16LQmhWxCOikTRkZURvf9mxaxtQ1ZiQ9Fo2FSnUwhYuc3
X-Google-Smtp-Source: AGHT+IEq9TdI0T1gHEIYRgWp3sWbFXGQlYpimzS1caT0HlNdfQ3qmMLxuoGuXxfNtywKXDf8i1/e2Q==
X-Received: by 2002:a05:6830:440f:b0:7c6:d0f6:3ec2 with SMTP id
 46e09a7af769-7c6efd991f1mr2651423a34.12.1762525029522; 
 Fri, 07 Nov 2025 06:17:09 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com, n-francis@ti.com, 
 b-liu@ti.com, nm@ti.com, bb@ti.com
In-Reply-To: <20251024081408.1610102-1-anshuld@ti.com>
References: <20251024081408.1610102-1-anshuld@ti.com>
Subject: Re: [PATCH v3 0/4] Allow falcon boot from A-core SPL on K3 devices
Message-Id: <176252502828.3410992.10542629954479341091.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:08 -0600
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

On Fri, 24 Oct 2025 13:44:03 +0530, Anshul Dalal wrote:

> With the addition of secure falcon mode since commit 7674ac9c820f ("Merge patch
> series "Add support for secure falcon mode: disable args file""), this series now
> adds support for the same to TI's K3 devices and documents the feature taking
> AM62x EVM as an example.
> 
> With secure falcon mode from A-Core SPL, the boot flow changes as follows:
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] spl: Kconfig: allow falcon mode for TI secure devices
      commit: 16f412679005e539401308bb075d4cdf87f01cb2
[2/4] board: ti: common: Kconfig: add CMD_SPL
      commit: d99688d26e697a52ceccea8231e085a79ee63771
[3/4] arm: mach-k3: enable support for falcon mode
      commit: f5119b38ff0d13f58a9af4d9f7f48dbc3f6f6a93
[4/4] doc: develop: add docs for secure falcon mode
      commit: 20fe0f5dadb70c24163c2c5f1ecd27c569ddd13c
-- 
Tom


