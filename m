Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77119C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE80849FB;
	Mon, 29 Jun 2026 19:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PciLayt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71B384A45; Mon, 29 Jun 2026 19:05:27 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94229849FB
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so31392635e9.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782752725; x=1783357525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1vKH9oMaHmEo6y4uAr8HbGL637rVLTm3yuoBKIOts6w=;
 b=PciLayt97Z6glAmxjGJQ7ALldpmPq6hNApu66UaxvY0CxRiuWSdvHE4BugY/q8HN29
 EWcUAr293mGWmhQaPDrA41+yGPm+FjhHex5h9KxM+ifbDTO7T2DFjUo8BLQWF2ePfK3V
 ne1qy+4hgha9IWWQhK5vh4XRgYJ51/RYXMGuduoXFwnOGOVXYJPo4Ip4GKThDWoYSAc7
 hPn7RkxaYCDpCI1kpY3ktYvPGPgMTugX8dlKB9gzsWcFFDIpmnNFuRgkmZvibpLk/Wjo
 uDvQT1abTeGATOpuFHiLwY5pWFGRatPC9Cj2lYWuYKjjhmSREnbfIApAXQEvYEO///2J
 fSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782752725; x=1783357525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vKH9oMaHmEo6y4uAr8HbGL637rVLTm3yuoBKIOts6w=;
 b=noKT4t3n8eeu+nyeLmWXeA8EZcgO/j7UugPhzOmIDuqll2vqP7rMTfVzPY0pqZHPHf
 kHuqWDoG1l6UMnlu2bFOmXZ4n1xIG62/8uIrrw2U5A7fGJPcLcfLtPjOKEsNUXe0p4BR
 Tm9EG6sxPF9A5U8ZYCEtMmQHjC0V5pj7PvJI1ViV12LNrg2S92r8YfV0hBTWP5T1rED6
 PjxGKrXbQD0CxhjwLVC+R9r2gZCqmiMheJWYlPtPh4DGUobixf2qrzsarrSFxd0R40qG
 Eab7Nh5IQvb39CDtKc5qoEP4giq+MENKBX0TDgCuyujwo2mYxw4uJFmbCHn8MZXv9sV6
 Xavw==
X-Gm-Message-State: AOJu0YxV9Kmew/Ipbb2FXoZ3ffV7AFYLazSFJRoPKep/DmNDrcDES+Jc
 czWp6JxruO8CJg6+FTh7tVlFFkkb434M4XiqJcTsOmsdm/5o9UCk9US0ogQU44/L
X-Gm-Gg: AfdE7clzDsl6hoHx2LSv/iCJv7onWEpPJuy/cbAIb0k+L++Pd0PNxqAOZfn4oQvmoDe
 7B3Eaf+k6kPQB25Gheu3nh1vY2DWYCj/+K1mtXqdLhbFxOjEeizIE5DO/UqH4l/l1kvMg9djxlc
 yhemqFBIthLPtmL8GdI2hlrLRNfgy3tNVK2feBp/8jqKEYBPDeUmp17on86VgBSjJa6AyQJOtmV
 NELcTal5S/2iJReBKNCk1I1wrVYP2PG28nFV+Z5MStkAQkv4zwYnxHQHBMmzZAggc2z+SJuoeBV
 XrEOYHXlHtGN62XWK1yb0Frws02yjizPbQ1kqAMJb32rFlKwz8CJYTSaiyB8loE4/oqrB3kG+mY
 mFTfRqUc9PLBykmfWINETkjHYF6Iao881i7GJuJK0WPEjjQ3nZbWH/Rmq91tt5zBTXCm+TiOlCY
 bYuepsG5waO44waCgMvjX55jiRxJeUZlxrM4EDqburW7y08xhTXhR/xDSImeRKZS4=
X-Received: by 2002:a05:600c:4455:b0:493:b549:3be0 with SMTP id
 5b1f17b1804b1-493b82acc19mr7986695e9.17.1782752724671; 
 Mon, 29 Jun 2026 10:05:24 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46cf775a4f0sm41791121f8f.17.2026.06.29.10.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:05:24 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v2 0/3] rockchip: odroid-m1s/rk3566 watchdog support
Date: Mon, 29 Jun 2026 19:05:14 +0200
Message-ID: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series makes the Synopsys DesignWare watchdog usable on rk3566/rk3568
and enables it on the Hardkernel ODROID-M1S.

On current next the dw-wdt driver already probes (d62801d09441), but a
timeout or "wdt expire" still hangs the SoC: CRU_GLB_RST_CON routes the
watchdog to the second global reset by default, which causes a hung SoC.

Patch 1 routes the watchdog to the first global reset instead, same as
the PX30 implementation. Patch 2 does the same for the TSADC, so a
thermal shutdown also resets the whole SoC. Patch 3 enables the watchdog
(wdt command only, no autostart to be non-breaking) on the ODROID-M1S.

Verified on the ODROID-M1S (RK3566): a watchdog timeout cleanly reboots
the board.

Changes in v2:
- patch 1: access CRU_GLB_RST_CON through the rk3568_cru struct, matching
  PX30's arch_cpu_init() (review comment by Quentin)
- patch 2 (new): also route the TSADC to a first global reset (review
  comment by Quentin)
- patch 3 (was 2/2): unchanged

On the TSADC (patch 2): while checking how the ODROID-M1S comes up, I
noticed the rkbin DDR init (probably, at least I don't know what else
could set it at that stage) already sets the TSADC bit in CRU_GLB_RST_CON
before U-Boot runs. So, on this board the patch is effectively a no-op. It
still seems right to configure it explicitly in U-Boot rather than depend
on the firmware blob, and it matches what PX30 does.

Jonas: on v1 you raised two points on patch 1 - guarding the write on
XPL_BUILD, and clearing SOC_CON1 so the watchdog reset behaves like the
TF-A/PSCI reset. I replied on the thread [2]: I kept the write
unconditional to match PX30 (and because U-Boot proper can be entered
without our SPL having run, e.g. using an rkbin miniloader), and I posed
the question if the watchdog actually *should* drop BOOT_MODE_REG for a
clean recovery rather than preserve it.

I've left both as they were in v2, for now. Happy to do a v3, however,
if you disagree on these points.

[2] https://lists.denx.de/pipermail/u-boot/2026-June/622663.html

Andreas Zdziarstek (3):
  rockchip: rk3568: make the WDT trigger a first global reset
  rockchip: rk3568: make the TSADC trigger a first global reset
  rockchip: odroid-m1s: enable watchdog support

 arch/arm/mach-rockchip/rk3568/rk3568.c | 14 ++++++++++++++
 configs/odroid-m1s-rk3566_defconfig    |  5 +++++
 2 files changed, 19 insertions(+)


base-commit: 835a18f80f25731dc818bf9b771bfa111ea3dbeb
-- 
2.53.0

