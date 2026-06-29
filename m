Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA9BC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 19:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9536184A6D;
	Mon, 29 Jun 2026 21:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oQ5uXK8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856D384931; Mon, 29 Jun 2026 21:23:45 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9783D84931
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 21:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493b779003fso2145495e9.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782761023; x=1783365823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yPoG4a0XBk+5N8EVx1GTt95/u9qHcDsNiFxOGWyZi9I=;
 b=oQ5uXK8hR0Jj3Y6g+QocGmjLfCl7JtOZsikw6yj4+h0CW2iqNi/8nf89jCwvhY27+N
 Sh9lVvvbeUMEUoJyWsJvCfuMKvkNZ0P6urQG1xpiNPLfZRQy3sRgHJvRA9lKgSPGXQea
 XtdwM3SdFvi3VG4dRX+imDmLXrTJ0HyJ36ofq6cdJG7yOMEiX2LfjSgv6ZBqstvQz3eV
 9xAuXqrpwCRd9w6vhhCx3jq7jIfO6OXjL91y5vWC38r1ahRGIYEurrceo0W4jNjlLgcE
 g4DU06I83BtxbcORwrYdriEbS2t6l4wkEC7VFVIQMLqzN9Ccx1d6CFS3hVDJH/XHxJbv
 L2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782761023; x=1783365823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPoG4a0XBk+5N8EVx1GTt95/u9qHcDsNiFxOGWyZi9I=;
 b=TwPcwKyPyPHodvNy1isgsh9zic2F+0Rt0/SO/MAoakE844EW3RONgGGCNBd/g0mabu
 5FEAsVGKJAwcXQq9i2P9dSA37VWtp6A/L9yS+bfGTuZNpNN+guqj6chfSiHZm7tlUtxH
 62BeEodRtVC0kSIKMdYwfbfXgEDDReKha9Eez9aQJgbsEncEvfktKyk8/TZYcEbmYy92
 RzKUP6SzMFUUbfsOkZ1MO44GDfDr7bVxbeK2m1RmzZdMwm9KWj7DwkPE5UfSlVadlS0b
 n2fME9G1/1OS3qjgr5nmMwSE9riYNajRKnlwiwuu+w+fBxSQ/fR+EZ4F2GIYKPmXnxff
 rruA==
X-Gm-Message-State: AOJu0YyYgMevJ51fhLX9f0u2DEy2qg83BSj9gCDCCq34NXtqy/9HuU5q
 jdqTCyFBKfavPACm6fDJgz+abyNQ+8vyWgLcs51SttGslPE6jjKOzVg5BRwXqgOy
X-Gm-Gg: AfdE7clA43nwxnjeef9LKa6VWtO0+CaMWI7bBQjDnqtmjQvWix9VurDb7NUYVh2OOIL
 JSIp9NGRMRHmG+kZRNoubam4kX949h+Yln/LE0En4T9cGWcMMoSPC5tzXCb+eLKJhCZJ5JSdX7B
 nffOiovg1gGw4x5EwK3CoNZk/uI5/w69Iu0Ru4FpSbVx2LynnxgB/9JtkWz0jqTOW2kqNxZ1Wjc
 6e39Vh80ha+wqNUlsJJQEjYMMVYP+48QTolCyrBbxNbkH+yJzKAbvtBXsQZQLXVr66ZbiKnV1pS
 60+2aoZ8+9/AVmsrr6UVBdw4zOZb4wM1sGV4tuqN/pVHGEkRkQlosuWLnTS5//P0v62D5EdhAu+
 x491BSek249WYnm8tYZLob1Ka892b4iiutxvuxEpTUqLi6uaw4oyLwFLPgAN43tCLdF6LQe4AZ+
 +0M46mprxM+YS7JF6nnd69v85FwJKVKLE0/rnXsyAEx/t8YQWuJLRb2kVqcAbVlE9LJlXbPb+ua
 Q==
X-Received: by 2002:a05:600c:a012:b0:492:4714:2d7e with SMTP id
 5b1f17b1804b1-493b82c15e6mr14107475e9.36.1782761022707; 
 Mon, 29 Jun 2026 12:23:42 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8b1csm8734785e9.9.2026.06.29.12.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:23:42 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v4 0/4] rockchip: odroid-m1/m1s/rk3566 watchdog support
Date: Mon, 29 Jun 2026 21:23:32 +0200
Message-ID: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
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

On the TSADC (patch 2): while checking how the ODROID-M1S comes up, I
noticed the rkbin DDR init (probably, at least I don't know what else
could set it at that stage) already sets the TSADC bit in CRU_GLB_RST_CON
before U-Boot runs. So, on this board the patch is effectively a no-op. It
still seems right to configure it explicitly in U-Boot rather than depend
on the firmware blob, and it matches what PX30 does.

Jonas: Per your note, v4 treats the dw watchdog as a SoC feature. Patch 3
implies the driver for the rk3568 family, and patch 4 enables the command
on both the M1 and the M1S.

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


base-commit: 835a18f80f25731dc818bf9b771bfa111ea3dbeb
-- 
2.53.0

