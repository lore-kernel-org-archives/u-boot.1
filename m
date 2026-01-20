Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CEECA5FA0
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C5483B71;
	Tue, 20 Jan 2026 17:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="TpIuOPJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6555583A8F; Tue, 20 Jan 2026 16:29:43 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12FB883A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=47332a659=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1768922981; x=1800458981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kH4yQrAyGm6NzFCxrT1Afc8NBjX//8r2REpUVo4Oulw=;
 b=TpIuOPJ++twZ9beRBc6NVQZg5VLCigKTevbENyoHejD6WMd13xTFKyTI
 oUg0mNY7TbFGVNved8mkyZggKWQkgh3SMfdpU8TAHufj4fuMZZVfbp7BF
 1llAkJ4WOsSLoEzjKF0snm8pdfcm6A6ZlQKAtOmuorQnw1ZOOaFB7u+3O
 PawPPyjJBZX8tsoSXRIgBgjWSQWLeWp3wo50a8BdJg6CxUjZcdwipZ9iA
 Rg6+P7evVZ1jFkB3VmvdwAjdfEp1t/Nirviyn86Sa1XsTXX0RrWOHRtAf
 8wm5ADaMMb7tGZ8qcx0ZndYNcBABr8xp+vT0AI6FRYaHdUvIQ4K/PToVy g==;
X-CSE-ConnectionGUID: iuQXoqc9RnGYj0B0Zp4BxQ==
X-CSE-MsgGUID: LPWufkU5Qe2Lxd+HlrdC0A==
X-IronPort-AV: E=Sophos;i="6.21,240,1763449200"; d="scan'208";a="52602087"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 08:29:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 20 Jan 2026 08:28:28 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Jan 2026 08:28:26 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Leo <ycliang@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Cyril Jean <cyril.jean@microchip.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH 1/2] boot: Fix dtbo application by ensuring overlay alignment
Date: Tue, 20 Jan 2026 15:33:12 +0000
Message-ID: <20260120153314.95091-2-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120153314.95091-1-jamie.gibbons@microchip.com>
References: <20260120153314.95091-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 20 Jan 2026 17:15:29 +0100
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

After U-Boot's DTC/libfdt update, device tree overlay application could
fail with FDT_ERR_ALIGNMENT due to the overlay DTBO being loaded at a
misaligned address. Change the FIT image loader option in image-fit.c
from FIT_LOAD_IGNORED to FIT_LOAD_OPTIONAL_NON_ZERO, to ensure overlays
are loaded at properly aligned addresses and any alignment errors are
resolved.

Tested on: PolarFire SoC Icicle Kit

Fixes: 0535e46d55d ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d040e38d97..3a327d07784 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2481,7 +2481,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 			addr, &uname, &uconfig,
 			arch, IH_TYPE_FLATDT,
 			BOOTSTAGE_ID_FIT_FDT_START,
-			FIT_LOAD_IGNORED, &ovload, &ovlen);
+			FIT_LOAD_OPTIONAL_NON_ZERO, &ovload, &ovlen);
 		if (ov_noffset < 0) {
 			printf("load of %s failed\n", uname);
 			continue;
-- 
2.43.0

