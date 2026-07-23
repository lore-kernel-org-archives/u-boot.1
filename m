Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7105FC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 17:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8951560AA6;
	Thu, 23 Jul 2026 17:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ak8bgAZiRzvc; Thu, 23 Jul 2026 17:37:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B67EF60AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784828242;
	bh=oKoC5EL9E69gy20X5pACLd14c9CWWr3J0zs/nahsdYQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vy77LSAnheaDXpA6IX6ZNY/t6mBzfesrfIeQzhl5yLPbi9L4/g+lTTJSudYq+yw3E
	 YwseXY7PXb7IZ+XDizqfw0AFvVLyg5CmXNL/tUSrdYzEyQ2O93x6NllD4HrR9MhgZv
	 Uou3PZ57iE1ovbmaYjxzsdUTXJE11ZOI4LYbXPly5BemfLOwvs9oIIecaig1bg+Q4f
	 ppGKq94NRg+qS3Y9d0ZnjTqpL1nQZuz8AZE547HGBaIfn5fBmHr1mRnazBfH2r9vhc
	 2yWt1FfvXwoybFefm+9DjbFVPrvayDTpgyjmCdaGBXYEACmNpLJgGWM8YgNihXERA2
	 X60L5vBXmAWGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B67EF60AA7;
	Thu, 23 Jul 2026 17:37:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79E72707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5363940162
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqjwkG0crC6K for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 17:37:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=andreas.zdziarstek@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5EF7340451
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EF7340451
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EF7340451
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:12 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so8086605e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828229; x=1785433029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oKoC5EL9E69gy20X5pACLd14c9CWWr3J0zs/nahsdYQ=;
 b=ZVsZy0t7dLTpxGZM9hmRJM6Tmn+pa6Q6FQpEQf0ZWRKIYdfzIgPZCzMbsQu54pChEV
 NpDFnvPCEygg7hN3Q2fxDj6qtMR0k6iWaH5AFgzK6/J4uiNNudX0LWMJT5UoKqnE0ql/
 oB0YGlS4n+yQSfkEeT78Bx+9qTU5BxAgGH+tFv5rGt7zHp+o7xfLkdMaE5DLrf70VYJW
 xY8IJU59VE6P3ggfaUFfjNPJoRfF11YYM/EtArvcIre881o/w4KwUF0494i18KNFOT3O
 yp/nAcsBuXBfc6duiRVQQ2x8qh0oi5gkk5PKaeKTAeelk9/P/hSukTfNhxkj5dGf26+O
 WO5A==
X-Gm-Message-State: AOJu0Yzk9k9u8OlC0FhB7c7STg8e+4kOZMIufmi9N6YOnSgj/5P7SWJT
 QFhOPXyOMzDksgCmv+VPa/BONvxqFbwf12J1JfkCvhGbtwAGMXh3255lxmlWv9di
X-Gm-Gg: AR+sD12uMWNQlij/cEnjb36l0pSH7wMvAka79d6WLZrt0Wscsp08tTPRumauV7k/23t
 ahAUZ8Wlp/qQzXLE6TPmJgnJhlV3wtKYRdfne2ZPuqYeXxyYkNatJfUGdXGNyqSWLUVT8abGvvA
 4UgBNOxKUX+3vFZVYPRw09kBziVxWm2RLPj1IwMw/k4eHNUhnyy35j1GHUZt21tMw01d2gRDnwG
 hBeLc4/xluD3vygYrNgApj0p9Y5rYRNGljpoWhU7zuFy4/EtYHUBNfuBjQ0mNK671CupikXhqEs
 juTwF1ULMVjrM0kaigFv/yXgIMHiEWzTix17BLhs/Oj1uqPpITWRXhYsBEWPozDB2gaOH+R9bD2
 ijOXIZv4nrEgdsPjtjtrLCwfQLSE2pqTOS7qyHv5UlI+4IrblbCwHMStjuipu/AySk+OUgmNlkN
 6vhi0HWvo3yt/vX9jK8G0VXW5eqk1mqhlmWcqCEWHmBaiZS0F18YnQ
X-Received: by 2002:a05:600c:3b1d:b0:495:7ab0:445b with SMTP id
 5b1f17b1804b1-4957ab0447cmr9499475e9.27.1784828228735; 
 Thu, 23 Jul 2026 10:37:08 -0700 (PDT)
Received: from turbine.fritz.box (p5787a491.dip0.t-ipconnect.de.
 [87.135.164.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af914a9sm8497645e9.15.2026.07.23.10.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:37:07 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v5 0/4] rockchip: odroid-m1/m1s/rk3566 watchdog support
Date: Thu, 23 Jul 2026 19:36:40 +0200
Message-ID: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828229; x=1785433029;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oKoC5EL9E69gy20X5pACLd14c9CWWr3J0zs/nahsdYQ=;
 b=fQlZavOgjuw6/nzjpuY3mzpJoet+kwEm1Vsut8D8FzMWsKzGEngXy9BXmG7Jg3uInG
 Fa4nEe7ZQKVhsOe48Duv1JyRcbR8auf417lQlt+GX8YfXGbHgvsUINAgAs7LFM1oFmxm
 Ocd33+zqmmz1MiNcq9pA18uHm2xSKiqcPtCBiTPsNcMZo4CQBjA4llQrjsKe9IBVJgFA
 Fw8VxQvU1sz1OiQYdSq6ic/CQl1p7RvtQ5QVbmmqElgNDavxFfX2bxuwBiRJZrPdz0vt
 zvZkjAtHxFW2EquihRu0DS5fkA5ybouFZuo1nBxAUGXlrdqr65Q2orLM0+2h68+m0+Gx
 b0LA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fQlZavOg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

New maintainer, new list, new luck :). Here goes:

This series makes the Synopsys DesignWare watchdog usable on rk3566/rk3568
and enables it on the Hardkernel ODROID-M1 and ODROID-M1S.

On current next the dw-wdt driver already probes (d62801d09441), but a
timeout or "wdt expire" still hangs the SoC: CRU_GLB_RST_CON routes the
watchdog to the second global reset by default, which causes a hung SoC.

Patch 1 routes the watchdog to the first global reset instead, same as
the PX30 implementation. Patch 2 does the same for the TSADC, so a
thermal shutdown also resets the whole SoC. Patch 3 makes the dw-wdt
driver the default for the rk3566/rk3568 family. Patch 4 enables the
watchdog (wdt command only, no autostart to be non-breaking) on the
ODROID-M1 and ODROID-M1S.

Verified on the ODROID-M1S (RK3566): a watchdog timeout cleanly reboots
the board.

Changes in v5:
- rebased on current main and resubmitted
- no code change

Changes in v4:
- patch 3 (new): imply DESIGNWARE_WATCHDOG for the rk3568 family instead
  of enabling the driver per board (review comment by Jonas)
- patch 4 (was 3/3): enable the watchdog on both ODROID-M1 and M1S, not
  just M1S (review comment by Jonas); dropped Quentin's Reviewed-by as the
  patch changed

Changes in v3:
- patch 1: keep the glb_rst_con write inside CONFIG_XPL_BUILD (review
  comment by Jonas)
- patch 2: fold the WDT and TSADC bits into a single glb_rst_con
  read-modify-write instead of two separate ones (review comment by Jonas)

Changes in v2:
- patch 1: access CRU_GLB_RST_CON through the rk3568_cru struct, matching
  PX30's arch_cpu_init() (review comment by Quentin)
- patch 2 (new): also route the TSADC to a first global reset (review
  comment by Quentin)

Andreas Zdziarstek (4):
  rockchip: rk3568: make the WDT trigger a first global reset
  rockchip: rk3568: make the TSADC trigger a first global reset
  rockchip: rk3568: imply DESIGNWARE_WATCHDOG
  rockchip: odroid-m1/m1s: enable watchdog support

 arch/arm/mach-rockchip/Kconfig         |  1 +
 arch/arm/mach-rockchip/rk3568/rk3568.c | 11 +++++++++++
 configs/odroid-m1-rk3568_defconfig     |  4 ++++
 configs/odroid-m1s-rk3566_defconfig    |  4 ++++
 4 files changed, 20 insertions(+)

-- 
2.53.0

