Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CA4CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9081F84A51;
	Thu, 25 Jun 2026 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="UHrxplxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740D2846F4; Thu, 25 Jun 2026 14:20:21 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0946784704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782390019; x=1813926019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aHTNRcGnE+LZLf6XAzR9NprREpE8XdYw6WBPjtkyHqU=;
 b=UHrxplxYgZ8DxWqDTGnh13+r0e3EptxnVykwkXFoUTeDJU7sQApdLAgR
 rMyNv6tiMMNB7BIadg+DhAO9ku2WFuifSlG+pG8o3dR3B4b+GNhpDtQcA
 vtWzOLroY5qyUE6JQsHjJXZI3R3Fn8rfFTKjdaxOImVW5t5g9PoGEiZBO
 80hH4QB0g9f5CqapVpBHUgbXdoYi7pS2TYhx9uvGn0r5Y3212foMM3Lr0
 xQr47PC/9877X1ZIVYAVaSFjQ0qTT6XAwrf3GAK/mF0mPTRwkSVkTN2GB
 eKurUSBP9flyxr3WMm+1yNHEcWczuP2U7ZxNVc6Odc9OIDp7JJvMzaG0b A==;
X-CSE-ConnectionGUID: O3qjgmziQ/CErDCvEBXE/A==
X-CSE-MsgGUID: bHGwY/mcRBin2ljaEsteOw==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="58824230"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Jun 2026 05:20:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 25 Jun 2026 05:20:17 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:20:14 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 8/8] boot: fdt: downgrade KASLR RNG failure to warning
Date: Thu, 25 Jun 2026 13:23:25 +0100
Message-ID: <20260625122325.834568-9-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625122325.834568-1-jamie.gibbons@microchip.com>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

During early boot, dm_rng_read() may fail if the underlying RNG
is temporarily unavailable. This causes KASLR seeding to fail,
but does not affect boot correctness.

Currently, fdt_kaslrseed() treats this condition as a hard error
and logs an error message, even though the system continues to
boot normally.

Downgrade the failure to a warning and continue booting without
KASLR, making the behaviour explicit without implying a fatal
error.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 boot/fdt_support.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 1c215e548db..aba1841a9f5 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -308,9 +308,16 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
 		return err;
 	}
 	err = dm_rng_read(dev, &data, sizeof(data));
-	if (err) {
-		dev_err(dev, "dm_rng_read failed: %d\n", err);
-		return err;
+	if (err < 0) {
+		/*
+		* RNG may be unavailable during early boot.
+		* KASLR is best-effort in this case; warn and continue.
+		*/
+		dev_warn(dev, "KASLR seed unavailable (RNG error %d), continuing without KASLR\n", err);
+		return 0;
+	} else if (err != sizeof(data)) {
+		dev_warn(dev, "KASLR seed unavailable (no entropy), continuing without KASLR\n");
+		return 0;
 	}
 	err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
 	if (err < 0)
-- 
2.43.0

