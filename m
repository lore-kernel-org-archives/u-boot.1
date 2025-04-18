Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42107C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C185983212;
	Fri, 18 Apr 2025 16:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JeHZgLtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F7C83276; Fri, 18 Apr 2025 16:22:23 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3CF81B4B
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6041e84715eso1331808eaf.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744986140; x=1745590940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xo5wbnTAyafEbGQbBbHX+YtO5vBQEl/pbbTEsFIgpM=;
 b=JeHZgLtWFHGUCDmKN93sGV2jucGZDJwMuI6KpjkDhrRHLtNkNxDyqlbCZWTmELXoRd
 nC4cO0bsLYaxE0iW9gViLO+jxUfB9io4+31DRja1iyas7VmUh7ijV+9bGs5F0MCBZkNA
 fgI8ivH77+x6tNUI94Ppsr9UGBY9zJRpgNisw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744986140; x=1745590940;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xo5wbnTAyafEbGQbBbHX+YtO5vBQEl/pbbTEsFIgpM=;
 b=xGRnsxjBpw/sbQv5ETsoHQM2EahfJzME6IfB3ZRCCGjjDEjw07VEDbdt7i9sGn/g4m
 KfCF3GZsoCw7Pn/e/nNATzj8jYXZ90oV/4flvLzQKiUuDd4nJ6Gei3H+3LODjRLO9Wlv
 PT1p/fTPV6mhlNdfFVCWN5YVNuhCAev3t1zJLSwYBEvGAbNtzxS1olvPp0V1YzMpB12m
 A6h47IDzRKGSKQngPdaSB1rE2yaiV1H62K6x/YDx/jZ9zNIYS8ygYPwXj7gXPuPRtSYQ
 aMA2I83cBfOsVUIzmwqvMvVT1JMgU8ex8CtkycfkxO9ccDevh3Ky8dRtwIe/hdmGsCYQ
 5NSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJF+j8V6vla3zVybNcdm+ggWhF32n44BRjl06lE059agwYpm9+LkKR30n9G1SQ57uDL2FM1ME=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7BIRSvXJDT7mHaGdl113znrU7/Z2nQQJXI734JyC54lX5nAgk
 Bh9fatjem6oDL8CaKyVxaYFzmn41Xm/tohlGYwK2FyGR3FHuBr5GX6LpmDvuyQ8=
X-Gm-Gg: ASbGnct0hy8dwJuAB7qLVybkQwMQeMM9hYCCWwqsucfy0ZQUjQ66vp1WmeVqnmMu/XI
 u2L9LogV7M9RUJBypMH3dDJbvMq/YO9fPAYVmzKyja4PJwSIOVR2kxIrDtpUdKA5EmYZqvEehkX
 Vp9S1hxRe0PMhNi9rlU0ARPa0I12O1tm/v7F+3zHijkOB1AOUORpZBa1yKPl6Ngjzgv0rmyANVw
 VwvuCPWc+nwgdD5eavGDRw+74vTwCKu7nQMkkioEvQMTlw51coB0OaXCYlAiFGyt4KonkG27BSc
 PqC7zff0Twy3/W1/AnxAxaAIZ007cJHTAGjNYlwSDewHBYg02fMvVPi885bCwOQnv9aen6Nj/YL
 P
X-Google-Smtp-Source: AGHT+IG7owYOuu5UXTyvlvWAXPT646IT6S4UmWbEPnC+xYTU5fxPGwstq/xWwv+KT3Q91QHTJ1MP/g==
X-Received: by 2002:a05:6820:2226:b0:604:d2b:c585 with SMTP id
 006d021491bc7-60600547740mr1719532eaf.3.1744986140490; 
 Fri, 18 Apr 2025 07:22:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff5f778bsm384787eaf.17.2025.04.18.07.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:22:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Parth Pancholi <parth105105@gmail.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de, 
 Bryan Brattlof <bb@ti.com>
In-Reply-To: <20250408161211.3165588-1-parth105105@gmail.com>
References: <20250408161211.3165588-1-parth105105@gmail.com>
Subject: Re: [PATCH v1] arm: mach-k3: am62px: Fix MCU_CLKOUT0 parent clock mux
Message-Id: <174498613955.3131457.17634436145993123949.b4-ty@konsulko.com>
Date: Fri, 18 Apr 2025 08:22:19 -0600
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

On Tue, 08 Apr 2025 18:12:11 +0200, Parth Pancholi wrote:

> CU_CLKOUT0 can be driven by two input clocks: a 25 MHz and a 50 MHz source.
> Currently, the 25 MHz option is not selectable due to an incorrect mux
> configuration where the 50 MHz clock is duplicated in the parent list.
> 
> This patch fixes the mux setup, allowing proper selection of the 25 MHz
> clock source for MCU_CLKOUT0.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: am62px: Fix MCU_CLKOUT0 parent clock mux
      commit: 5e94661e465f1929e0dc3c27fa949b82b1ebddd2
-- 
Tom


