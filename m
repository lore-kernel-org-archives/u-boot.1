Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BC8C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D22984942;
	Mon, 29 Jun 2026 20:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IH7/WTXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3981284A5D; Mon, 29 Jun 2026 20:20:44 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449048490A
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso19075285e9.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782757242; x=1783362042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ErMRO2HmD5LOz2UVDYSZ7VRmPMSWanPg6NEJM3GMjE=;
 b=IH7/WTXt4wbZQLm5u8yKOyp3Lisn5G2ByR55ZFQ1ExDFphmtqPKRtKn6+wG+4BNYMk
 Jo0VbJKxEmNVTwUNtEgdtBJHDJTuMMCRhbwoSXgkVdCH+J76DXXY10vjyTD4HvAn7tYN
 vqqHFFYdGTrSH7TkwPJpHkxoXuaEaUzWf561Zx57/iD1I6Is+3j/Ajb/m3erAcY7v/dC
 DhJVV0iv/qM8y1y62sM7olnOFYYs+G5D3iVrnu0X+IeAwaCn96aI+aFkg+PXC+oIqZSU
 yfcNZEIv5OMaKpxpoqvQJIQ4LM6wZq3nwbinMGM4em5KCPGdd+n7z5Bp4ChczR/+TqpT
 lr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782757242; x=1783362042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ErMRO2HmD5LOz2UVDYSZ7VRmPMSWanPg6NEJM3GMjE=;
 b=s2smoZk2aAn7u/ytAmRbPNqPV1rp3BOxplYwpI8z7neTAGp6P2B/b2R1npfhvHn6+d
 meaXL9SYOi99YAHs/VLnAiijXZKcoLOTVqwSlIC9vsw89pNXsF/x4ztqup6FSS3+UM5r
 5Px1yvBSpPWrukRshcl9rKYLnr7+O0pQ7A+3VqO71KaAAteXAzIWX8aVi2mRfyyI+FWh
 hgWg4U55drBs22Fh/eFzSDbHyAc/O//YJklCl4E8fm9pBwczd+090ncuiCEEztAL4boJ
 hRCd3pUvczFBdPLVD1cNsxoQ09Z1QWa/SaX9VtPoC0L/tE90BUSEWG+yUkIUSKXaVXyR
 6/ew==
X-Gm-Message-State: AOJu0YxQIhusuNEj0L4/mDcq70KTRRVk96SrrtUus9kgxOOUOpafsOsi
 L7Gzya7cVT1QryXPqu3e5X/KDxLnwsRjdt1TjjijM9XzI+dU/kGTbfWazKuk11IW
X-Gm-Gg: AfdE7cmz/JiXifS7hVRM+jnK44Rk5/1tsm6RTHvBJfyK4F5Cm20323ViF14V0vBzIxl
 eRmOWRPTHsJp1nVfZoBkSimRdxLAE7zBL+uWkmydzhHeQJw71DADmU4sLWi0TbGaN7Jw+QlTac5
 d+V6To8XW4dqUrurilcTrAZcaam3JDJXauJMlwp9b5OfI1/sbkl5qekx6tgZ7QugTOV+P9DWJ1r
 ahfrFlXjVoqXVztyTGQbTmsHP4pePUS/v3PWqDHyRanp6x/mI8WxRB+uH8Vfvd47ba51K5+R0Sn
 /wMV5e+HiLpMTiSBHHBZPxLyWPaazq40Ufa/8aN9i0AQ3fgWnjyenTPfVPKbcwassYWC49vNsOm
 RwdWtr/m5/yQ2czLEaDTBZJ8DuZfORN0n8FUiZGg1jDdA1Tl1+QrxiTdz9i0Gc9AVXSIx0VHr3U
 dapOVzC/W37V185jTn29z151MO0U7FFIMubnsHjNpC+sq81VLGN4bxp6SbRmw3R80=
X-Received: by 2002:a05:600c:3f10:b0:493:b2e8:6378 with SMTP id
 5b1f17b1804b1-493b827c754mr12023595e9.4.1782757241409; 
 Mon, 29 Jun 2026 11:20:41 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c2954efsm219567015e9.2.2026.06.29.11.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 11:20:40 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v3 0/3] rockchip: odroid-m1s/rk3566 watchdog support
Date: Mon, 29 Jun 2026 20:20:09 +0200
Message-ID: <20260629182012.1508336-1-andreas.zdziarstek@gmail.com>
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
- patch 3 (was 2/2): unchanged

On the TSADC (patch 2): while checking how the ODROID-M1S comes up, I
noticed the rkbin DDR init (probably, at least I don't know what else
could set it at that stage) already sets the TSADC bit in CRU_GLB_RST_CON
before U-Boot runs. So, on this board the patch is effectively a no-op. It
still seems right to configure it explicitly in U-Boot rather than depend
on the firmware blob, and it matches what PX30 does.

Andreas Zdziarstek (3):
  rockchip: rk3568: make the WDT trigger a first global reset
  rockchip: rk3568: make the TSADC trigger a first global reset
  rockchip: odroid-m1s: enable watchdog support

 arch/arm/mach-rockchip/rk3568/rk3568.c | 11 +++++++++++
 configs/odroid-m1s-rk3566_defconfig    |  5 +++++
 2 files changed, 16 insertions(+)


base-commit: 835a18f80f25731dc818bf9b771bfa111ea3dbeb
-- 
2.53.0

