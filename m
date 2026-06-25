Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3C6CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327B184A39;
	Thu, 25 Jun 2026 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="cfXTQ9f6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12ADA847C8; Thu, 25 Jun 2026 14:20:08 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89508460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782390004; x=1813926004;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BCPyKf0a5E8GS56KCBLpxkJMy48QMojsvo6MulKxmoE=;
 b=cfXTQ9f6kwBTaU0opNxeEGQbIwjpvIuHQ23mQYEdcj/kK8anv3B9tmNk
 ftpLv5kZxnOzfvZJdib1GuGa0z+DQXlEb8zssYF0+2WAgBGkvGgWsmjDr
 p97wo7I4GuZpMGqEzCt1xTCXa15n7RIQSX5o+Auccj3YJeQf+9iKgXjjn
 VBkftvnIaZWMLcqZATEc6fyr4oQMJTsRvcrDWhpl8+AFcMmRojpW5E2V9
 GMdOaWJy+n6XqKtnTIVP6l/zXde7GRYuZx7T80ES/hMYkiiXDovSUa4D/
 puoQPGdKVaVy6J4B+oPbw+8GH5jHTzlrmwtilIZU1pSxH51chFpy5g/37 w==;
X-CSE-ConnectionGUID: IIb9EFA5SgGtrBiDZ+UabA==
X-CSE-MsgGUID: ZbzoVgV+RcmBVqcAIWEeKQ==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="226851793"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Jun 2026 05:20:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 25 Jun 2026 05:20:02 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:19:59 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 3/8] misc: mpfs_syscontroller: bind RNG sub-device
Date: Thu, 25 Jun 2026 13:23:20 +0100
Message-ID: <20260625122325.834568-4-jamie.gibbons@microchip.com>
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

The MPFS RNG driver is not described by the device tree and is instead
registered dynamically by the system controller. Explicitly bind the
MPFS RNG driver as a child device during system controller probe.

This ensures the RNG device is instantiated and available via UCLASS_RNG
without requiring a device tree node.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/misc/mpfs_syscontroller.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index 61d6780f0b9..79dc43f085f 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -11,6 +11,7 @@
 #include <asm/system.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <dm/lists.h>
 #include <env.h>
 #include <errno.h>
 #include <linux/compat.h>
@@ -332,6 +333,7 @@ EXPORT_SYMBOL(mpfs_syscontroller_process_dtbo);
 static int mpfs_syscontroller_probe(struct udevice *dev)
 {
 	struct mpfs_syscontroller_priv *sys_controller = dev_get_priv(dev);
+	struct udevice *rng_dev;
 	int ret;
 
 	ret = mbox_get_by_index(dev, 0, &sys_controller->chan);
@@ -341,6 +343,10 @@ static int mpfs_syscontroller_probe(struct udevice *dev)
 		return ret;
 	}
 
+	ret = device_bind_driver(dev, "mpfs_rng", "mpfs-rng", &rng_dev);
+	if (ret)
+		dev_err(dev, "Failed to bind mpfs_rng: %d\n", ret);
+
 	init_completion(&sys_controller->c);
 	dev_info(dev, "Registered MPFS system controller\n");
 
-- 
2.43.0

