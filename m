Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBB1D2502F
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 07:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6637183AEE;
	Sun, 11 Jan 2026 08:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WeXi8FS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BF683C29; Sun, 11 Jan 2026 08:33:46 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C0E83A26
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso11343301a12.1
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768116824; x=1768721624;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1DWtB0NMZERFgO7txKyF3IFmC6378Zhy2ofmBH5qUjA=;
 b=WeXi8FS6g0dCRjM95oWtArXM5/JeCBTxdmJ5TbAUbRyubJjXrHTe02fXRMvuMvtNtm
 MiNXRTIXLsQz/3UQdHAt5FIMzvDO0RPfcKIz7gv1hFNZMJzGS6pC+rgMJvjLqk1bIMSi
 KdRW3mqD+BbndFE/PGNfuKNYG+Oo+iIFsJIog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768116824; x=1768721624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DWtB0NMZERFgO7txKyF3IFmC6378Zhy2ofmBH5qUjA=;
 b=VpVpEXvJsQUUq1jGMu2t6P228u4oXdxoV0dg5mobdiioPl68Pp1lWrEgcls/7HFnjA
 yqk+EKYJVawIPDEBLfNysLp7j6Bs2YNB6Fvo2QNW216zw8egb90vDIiAuvAqF6pZ32Kk
 fEIzfttTIV3ILgtaNxH6fvouf2wHDiXevxFD5e/vEDsWAlktggCx/mdjGhmvypjRM5Wf
 Xs6cFOHzr5kTHA4lJt3RkYyC36NOg6BOt4X5MwUCtmEmB9O+ndL5x4r+dEhxGwX3RnQT
 dfr6kxNrXPwWSzzPua5YfAWMKnJJqSZpNGn83AtyGBHDlRB/a0UeTbDO6hCBu390y45f
 l8cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3R9fC9pIpW9guNjhk2HqFM1jIT44lwaiBywU8XpVvVYeJBZ6WERbpLgYl+ct++HdNoAcOeb8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+t1OCvbRYJXPZq2wBwu0wMfObfGQyrPuBhinqAv6h1gCuSlUn
 C9JWsmY8+fUuUxbGbVGWi+M7tBjM0eyS9QegoTXJnr02SylEFKwxVXG8sG0jdcP2JAY=
X-Gm-Gg: AY/fxX60jxJIpn2aqrzyFu49jY8Xh9wSYk1AMUFsBvtTuhPpCJ64/A0tmp+1J9CQHfH
 yxIfrgAb2COVoy6wwwV7gG0pY70on9cJRmxl6bTsuwwP0peEMuxzknxDt/eO5OmKF7mH2L/Wv/b
 9V9rsNM3RwwlC/ZOSA09T8G9UfUrBk/z2XgHcQeel60N/Xn0Gb0gFMGYxyY37vTvtt+tv0irpJR
 LyRdBRb5/fhtQgFgDq2vbtb2pOJ3oP4AQemkpsVzOqCAUB9w4u7B3JIQ4m9u6V0W+KzVhdSOAHd
 B9V6iah7SD342QFr8nKCRTdTnqh8FV61ihUc4pp8Mc0T2auo16M5OQtjTb4s3jN+S271JuO56iC
 q7dRmVwkbiqyM46fjCuP1xYfoKr9XB+4RVXYPh2I83KXbKfOI7JdVyqRTFPvAhis4KDL1WTDRUg
 2C3hfKL7ReXOsv6txv+dRU8jrWlx67FE6UB7PK22u9epvLt4z/TGuRqAhp3jq3wR/pQpFRSQVJn
 VmR+ozjF7dGo8Cz6Xk963EwZH0Mj7NLx7h/oNnVxatm7NSXT6w/b4+7ZA==
X-Google-Smtp-Source: AGHT+IFEe2bCdZTxnXwG1Im9xXHM4UbgRpEAeGUuT4byk71EkQKYt/efiF28/5IF8ARikrePF7zrrQ==
X-Received: by 2002:a05:6402:1801:b0:64b:82da:abb7 with SMTP id
 4fb4d7f45d1cf-65097e4daa8mr10159068a12.18.1768116824024; 
 Sat, 10 Jan 2026 23:33:44 -0800 (PST)
Received: from panicking.homenet.telecomitalia.it
 (host-87-5-117-220.retail.telecomitalia.it. [87.5.117.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d683sm14548782a12.34.2026.01.10.23.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 23:33:43 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 0/2] power: regulator: pfuze100: Fix voltage calculation and
 support high-range
Date: Sun, 11 Jan 2026 08:33:37 +0100
Message-ID: <20260111073339.1297089-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series addresses two significant issues in the pfuze100 regulator driver
regarding voltage calculation accuracy.

The first patch fixes the handling of the "high range" bit. PFUZE chips support
two voltage ranges (controlled by a register bit) with different step sizes
and base voltages. Previously, the driver assumed the low range, leading to
incorrect voltage settings on boards configured for the high range.

The second patch corrects the interpretation of min_uV. The driver was
incorrectly using the device tree's regulator-min-microvolt constraint as the
mathematical base (zero-index) for voltage calculations. This caused offset
errors whenever the DTS constraint differed from the hardware's absolute minimum.
The patch introduces physical minimums in the driver descriptors to ensure
calculations are based on the datasheet specifications, treating the DTS value
strictly as a safety constraint.

Together, these changes align the U-Boot driver logic with the Linux kernel
implementation and ensure correct voltage output.

Michael Trimarchi (2):
  power: regulator: pfuze100: support high voltage range bit
  power: regulator: pfuze100: Decouple hardware base voltage from DTS
    constraints

 drivers/power/regulator/pfuze100.c | 138 ++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 50 deletions(-)

-- 
2.51.0

