Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D6ACD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077C084666;
	Tue, 12 May 2026 21:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rboSZV7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC58838BB; Tue, 12 May 2026 21:31:54 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C265838BB
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso5065384a34.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614311; x=1779219111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8zetSUv78Tw+z6Ha7roQuo1sYr29MIPXlI6LjgFOoY=;
 b=rboSZV7tp1jedyFW7mOV9Yr4CUovJ8gw0Uft48IN+Z4Q157iD5w4BZsaBQ4nt+Gt22
 YxLW8HJkz8tA1KkIO05+PZqv+9Rw627S3OlR2LRs75YOQDV4ztPqZq48VWvk2nzcAs8I
 xxsAQ+pYCtl6ibIv9G0xVc6ELrwenlMr6pU+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614311; x=1779219111;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b8zetSUv78Tw+z6Ha7roQuo1sYr29MIPXlI6LjgFOoY=;
 b=s/AZtFcYnHr3s8ww62KXQi5T6+XVbuACMJTdJ3OcclLUMd6t8T/TqIFB6pHek/nz96
 4/vF8LLEobMSRYkMSB354bKQI0u7+/tAwgNYmwcR6pR1CL98oUyD3uLB5NJvl3m1yXgN
 AZFihdE+W2Tm662IWQu8t0rCCZp2Ec5vlzgHybpU3X5TiY+rMdLuh4OhstZ6mXnLr2a8
 dHaf94v+xHdpW/3cDTyB+JIc/BitQ/xeN/ksVE6IFBS4zKkgsjb1tBnHLCdjwSglBM7h
 zmIzTOh9ZokleutLylrTF9kufH2CpkZaoTahWBYWl7LocvSX19IuVB6HANcnvv//iZL8
 SF2w==
X-Gm-Message-State: AOJu0Yz9PxQb+/tD+Q5JFH+QhozM8ROEm9+WldNfsEIciklQOoK1kVl/
 R4eyTvEQ2iDkHCloxnpiliMv4FPqGy5iNdFHnFxKi3lFqrI5GbMjRTRGZqsrdfHY15rV0rnK9XG
 o6A8kR00zW697
X-Gm-Gg: Acq92OEki+HXOVmqd+GWy0DqEF+Xq8/85OIOURQnfeg3jWlEnkNXhGqtu+EG+DEz1Rx
 lIRfT375cefFAYHF2LwK6hhEhQJDNjXsx91bPQSRnlXnypVubkyNQ0MG77Sd76WuMNZhKIM6Hnm
 m0jPYvicXYRUXbhb01ayVHhnpCxQOnaCCP43NOFW7RUhQI+Xg5RLOxQJIxgl0Uk2T5qKga0qWx2
 OJXi31zIlefYsh70V8+BZIiIlCyUfprTCnQQMaVGcSP/f4c1kXLGf42K/idbqWmJn1NCrNNuLQr
 Aqj8t/5EckhSCdMKcFmjvM3E3aK+tL+PaQx1icnf8EudT8Ahn78VA1x1W0xO+ufo7ImydAMkSvz
 SOwd5K53nzSeoi3+6rRBCWui/vltS6Yd22lb1mz18loV2Hp2zAYNOw4N2qIZl3heWsdmh4wl68P
 gEzgn6CRWeNW/DAS+uBdqOJ8HeTpCnXopws703S2eDXj4RIvsyHm7AlE32WrLwQqQlCiK08B/eX
 ThnOw/5GmUHBHkY6gLXLsYdl9PD7AYAqBZ40IPTKnMFXTIz1Q==
X-Received: by 2002:a05:6830:d0a:b0:7d7:4aa5:5210 with SMTP id
 46e09a7af769-7e3da4a0744mr30576a34.19.1778614310907; 
 Tue, 12 May 2026 12:31:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
In-Reply-To: <20260501-apple-board-env-text-v1-1-ea3730cb4037@jannau.net>
References: <20260501-apple-board-env-text-v1-1-ea3730cb4037@jannau.net>
Subject: Re: [PATCH] arm: apple: Switch to board based text env
Message-Id: <177861431030.3279584.18043362184816367956.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:50 -0600
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

On Fri, 01 May 2026 00:31:16 +0200, Janne Grunau wrote:

> The main use case for u-boot on Apple silicon based devices is to
> provide an EFI based bootloader for operating systems. This uses a
> generic u-boot image with DTBs passed from an earlier boot loader
> (m1n1). Use the generic board name "mac" for this purpose.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: apple: Switch to board based text env
      commit: 0f0ff73bac5dc43f8fe336f2828900035e260f1a
-- 
Tom


