Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDC7CA5FA6
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6850783B5E;
	Tue, 20 Jan 2026 17:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="DBKcSmy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4AE83A2B; Tue, 20 Jan 2026 16:29:10 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3AC83A8F
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=47332a659=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1768922947; x=1800458947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gJ2ZxQt0ZDdEY0Zj2jIVXC/l62hAI2IGhvnrI8R0GuU=;
 b=DBKcSmy8n9HUNpDkA+0rdWY8jP1NEeuXDkdmhUMXZIRTJ2SLqaZU248O
 t350Xt/EFbO+ixrE52tZf04w4CgKCVO9mRM9IwwGIfLNR1iK7VWAG/ew+
 D92ZEy2G/ULiczjpkqv0lhOnfhZqfrvs4PC5HE3cT9xlsUaLASQ0TQmRF
 Kfl2OUQvqYNe6maAu3IbWwuhNbjGiYpoKeXQsO1o7Kff+ugTZtjz7sVeO
 CbDyVNjWw5VM/CNuxezz0KXprTHCUmBMGvztMe4gGaQd2G8xHuBZkyxV5
 4jLG/dcmvyLAxMkXDNKoScCaU1VETFoAqEmxs9pxPkOENFK0GciJhNiPq Q==;
X-CSE-ConnectionGUID: aoX0kG6qQZyw2MNImWKp+w==
X-CSE-MsgGUID: 0g+F8x6ZRPmBWFZpYAB2rQ==
X-IronPort-AV: E=Sophos;i="6.21,240,1763449200"; d="scan'208";a="283531039"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 08:29:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 20 Jan 2026 08:28:31 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Jan 2026 08:28:29 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Leo <ycliang@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Cyril Jean <cyril.jean@microchip.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH 2/2] configs: microchip_mpfs_generic: fix boot failure
Date: Tue, 20 Jan 2026 15:33:13 +0000
Message-ID: <20260120153314.95091-3-jamie.gibbons@microchip.com>
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

Recent changes to device resource management (DEVRES) increased early
memory requirements during boot. The previous value was insufficient,
resulting in boot failures. Increase CONFIG_SYS_MALLOC_F_LEN to provide
enough early malloc pool for successful boot and device initialisation.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 configs/microchip_mpfs_generic_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip_mpfs_generic_defconfig
index 22f67414a7c..973ed09fa87 100644
--- a/configs/microchip_mpfs_generic_defconfig
+++ b/configs/microchip_mpfs_generic_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SYS_MALLOC_F_LEN=0x2800
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
-- 
2.43.0

