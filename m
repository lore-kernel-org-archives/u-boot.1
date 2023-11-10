Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C22AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 21:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7247F871E6;
	Fri, 10 Nov 2023 22:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oKWCtLJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7B68721A; Fri, 10 Nov 2023 22:10:35 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FCA8718C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 22:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-da0344eb3fdso2503445276.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699650631; x=1700255431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWO4I9p+L1BGX6aPU/Y6VpQtFuCojicP2+7pVEBzaTE=;
 b=oKWCtLJdjdDl+210yr5RybIpHkax4H2+n2eSpa2T2BBI/XSGXo8ZbXglDmLieIs+gy
 nfWaiwBHeyS7oCvcNojG46nNdTUqR4hWnQgyumFDXMCLdndWTD+NsFygXTrMrk7C++40
 w5fHk7q3V6E5XRrI0yRW6aE14EdiHELDnih9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699650631; x=1700255431;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWO4I9p+L1BGX6aPU/Y6VpQtFuCojicP2+7pVEBzaTE=;
 b=R1WjKNeYUcKM0SJeymRq4UZHjFfdUeWS9EadGlDXG7m+wrod3uSFUpDsFOBmr0Xv6H
 En8uhmFqNMX/2Ztos8VKMzZv/OuwVswIELg3/ucC/L7bc5i7d+294Ci5bcVYuVsHpexk
 6DFMTa/64nh5DCiYMeH5M8BRh9UDPQqYckYImmg44qXorw5vQRoCu+Lb7/rHQ42NSY+c
 CmnlM9rDltITaO9Jfa5adUqiGlcCOJURZWKMWkJVWreT7VeF1nJuHwCnAO+1SDKX41rI
 QiU4vZgChM0qajomW/8h/blLzhJVW7f1sjLKkVp1PWyqDAyTRcM5BSGmgwNPwOk2FfVY
 S2jg==
X-Gm-Message-State: AOJu0YwQ+kiZSo8Z4GGmbDBtejeqTfQacjumyr1t5Rol5ldWnuqh6QnK
 YaNNVx/Ruayj1c5gFuOsp9ueMqso5/l0+tuVjgN4AA==
X-Google-Smtp-Source: AGHT+IE16ATDlpBzQ7iAZZaNV7ZgxTCr3C5r6Zk4T8sqpsRY1QOmmIuaZXqImq/K+Lk3xdfJOab8Jw==
X-Received: by 2002:a25:4c9:0:b0:d9f:16a0:2770 with SMTP id
 192-20020a2504c9000000b00d9f16a02770mr320971ybe.7.1699650631361; 
 Fri, 10 Nov 2023 13:10:31 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-8290-1a12-bb4e-bdf4.res6.spectrum.com.
 [2603:6081:7b00:6400:8290:1a12:bb4e:bdf4])
 by smtp.gmail.com with ESMTPSA id
 g2-20020ad45422000000b00655d6d31470sm118363qvt.43.2023.11.10.13.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 13:10:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: nm@ti.com, Roger Quadros <rogerq@kernel.org>
Cc: s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, 
 marcel.ziswiler@toradex.com, u-boot@lists.denx.de
In-Reply-To: <20231028173603.24338-1-rogerq@kernel.org>
References: <20231028173603.24338-1-rogerq@kernel.org>
Subject: Re: [PATCH v2 0/3] arm: dts: k3-am6: Fix Ethernet/DMA
Message-Id: <169965063013.105053.5061914814638780201.b4-ty@konsulko.com>
Date: Fri, 10 Nov 2023 16:10:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
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

On Sat, 28 Oct 2023 20:36:00 +0300, Roger Quadros wrote:

> Since commit [1], Ethernet is broken on TI AM62 and AM64 platforms.
> 
> The commit [1] is not the culprit. It just unearths the problem by fixing
> the error check in k3-udma.c. This issue was silently being ignored earlier
> due to wrong error check. [NULL instead of FDT_ADDR_T_NONE].
> 
> Fix the issue by adding the necessary register spaces for the u-boot K3-UDMA
> driver for AM62 and AM64 platforms.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


