Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63764C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 592D38763D;
	Thu, 30 Nov 2023 21:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ljch7vCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5381D87656; Thu, 30 Nov 2023 21:13:56 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8C0875FE
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1fad7d0575bso341306fac.2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375233; x=1701980033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nPmQfIrJ4bT4l+z9Oyv1Yv4cGuGx7g4UZJRkiAt10YY=;
 b=ljch7vCfnyhQJWZLBfn9ibyY8bs/Rwced8B5AySLoUObfWR6Abzf86xjB1dHw0ZDaX
 sLBrQ0SC0w3ejwge7oQzYCQVKfeWO/oNdoq2h3yBHnl0bmnzCD7KP9B5RD5pkI7Iz7vu
 PqMo0hLi1rv/WtkD4pAvJ3CI/L4ECdiiokJV6ONb6cIyFyPTK3bg/DQVIeIvFJLbCYWI
 Jqmx07e+nigYH0tpz4H0JBb9J5N/AASXcQO/hHj26bUyhVSqNfovKJV0inyYrGy6ecG+
 QuUhBWc98N+yV4UoYuj2g1k7hadLgkfcNMgeD2aaJhVXxnnDr2T4ox04PEnXgxvdoFXE
 461w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375233; x=1701980033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nPmQfIrJ4bT4l+z9Oyv1Yv4cGuGx7g4UZJRkiAt10YY=;
 b=TkXiTX0+YItA7Bue2bC6TQ/5EOTmN2ugdg96eQmvsmORD4dkxEDcZKfLgE6ntFtGgq
 QKSDcXAkNSzPYRptjlrMSGa9F5GlGMNlj4rXMNrnC9tY6nQ5s5FjCnqgxlx68SYciK1d
 iSFX5yHisCRB5BqA3cvXY9ikdDK1oh7DBKeFxyxLA3MkJ24+num3hJuZw0s79QngeAtd
 T3Ee4uw7qv5c5L4Mc6sP/4gn0PulubiXP06g06VKXzqQFy4SUq6uYuumYty7E3ZLbEE0
 bKtnQ/LAcPTdjHyRMjV4TdsSGkaNnzoXr1P/GSqlJXeAra0o3Lkh/ONuj+MEBzITd1Bw
 7TZw==
X-Gm-Message-State: AOJu0YzCTL3GIiU8xr+R6CgFVf7d/nCynNhs4p07K2sQnGC+/g0+m7M1
 Q3Sw7ul8AOxBleim4tZH3xuzVQ==
X-Google-Smtp-Source: AGHT+IFGIoGAB2luNMnwM8FtrEbh3uOqMEPPKPBG8IFp5ycW4HnAFhjFmAhhbEXGZb2js2daYzS4Qw==
X-Received: by 2002:a05:6870:d88d:b0:1fa:25df:4031 with SMTP id
 oe13-20020a056870d88d00b001fa25df4031mr24867628oac.4.1701375232833; 
 Thu, 30 Nov 2023 12:13:52 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 gr12-20020a056870aa8c00b001f9e0871eafsm424672oab.21.2023.11.30.12.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:52 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 0/7] pinctrl: exynos: Prepare for other SoCs support
Date: Thu, 30 Nov 2023 14:13:45 -0600
Message-Id: <20231130201352.6379-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Some Exynos SoCs (not supported by pinctrl-exynos driver yet) have
different offsets and widths of pin bank registers (i.e. PIN_CON,
PIN_PUD and PIN_DRV registers). Rework pinctrl-exynos driver so it
allows for different offsets and widths of those registers by adding
the corresponding API. That makes it possible to add the support for
new Exynos SoCs in pinctrl-exynos driver.

The main patch in this series is:

  pinctrl: exynos: Support different register types in pin banks

Other patches are just related cleanups and refactoring commits,
required for the clean implementation of the main patch.

Sam Protsenko (7):
  pinctrl: exynos: Improve coding style
  pinctrl: exynos: Extract pin parsing code into a separate function
  pinctrl: exynos: Rework pin_to_bank_base() to obtain data by name
  pinctrl: exynos: Support different register types in pin banks
  pinctrl: exynos: Refactor handling the pin related dt properties
  pinctrl: exynos: Reduce variables scope
  pinctrl: exynos: Convert to use livetree API for fdt access

 drivers/pinctrl/exynos/pinctrl-exynos.c     | 125 ++++++++++++--------
 drivers/pinctrl/exynos/pinctrl-exynos.h     |  36 +++++-
 drivers/pinctrl/exynos/pinctrl-exynos7420.c |   2 +
 3 files changed, 108 insertions(+), 55 deletions(-)

-- 
2.39.2

