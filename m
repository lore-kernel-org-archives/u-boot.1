Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D23C44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDF6C40A13;
	Thu, 23 Jul 2026 00:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eCKq1sS5Ln9r; Thu, 23 Jul 2026 00:52:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85AA740A0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767945;
	bh=Cr3wbwQWcp8OIBtL1rjuMpcKBQyJFjE3Im0Jdvlwn/k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GjdgB6YMma/V2b6qOKJrzfwW1yUmAVh5wuEfNgZw+PYsg8ECZJ+/79EfW9wSnvLvI
	 fnX8XwRADAbRX0+MSNUxXHzePDT6YL6JV/ojlQfp3nja3PJwMg20Ju/Xuhc0fG9lre
	 ugbs6iTRScUGZWpFYmLqNfJ4u9u4HUxlI7d6gUWnLyRjHWEHRvSKGcrj/iuxtO8lDu
	 N0A9FecAhPql5zuyPwYY1B0pdLJZqhWTf9sBhjP9gakBv+NUZ83T9MMjb6zeAQXn4S
	 kuZEz2mnBCpAcHxjfxTdhFjrUpSTi+kdpMST77xIxXyxlQr8OKS1ZzM2er60/pz4cv
	 RnVK/BrdPfHhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85AA740A0A;
	Thu, 23 Jul 2026 00:52:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08F101093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06FF4605CF
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2zeQlngDUut for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:43:08 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=656eedf95=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ABA6D60602
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABA6D60602
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABA6D60602
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE8D8494B; Wed, 22 Jul 2026 17:43:06 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1050848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:43:03 +0200 (CEST)
X-CSE-ConnectionGUID: 39/6cmF5T2+3+bR5UHrrDg==
X-CSE-MsgGUID: jETJIlfHRC2fujChCN+qMw==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="228157532"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 08:43:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 22 Jul 2026 08:43:01 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 08:42:59 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin
 Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2 2/6] misc: mpfs_syscontroller: bind RNG sub-device
Date: Wed, 22 Jul 2026 16:45:45 +0100
Message-ID: <20260722154602.3373184-3-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784734983; x=1816270983;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vQpL5V18XD+Qk8MafntFCE/TVtuNYm6wdYG0mZLRJxQ=;
 b=iAR8eJfTgb8E3G21dyEOQRTgxpEEpgj4SHJzJUqDjZ3s3yymTNg1dyWx
 InY+eVp/fUxj+IRwIpnCmAZxHI1DcPfg3pV5c9CLLkz5MFKj8HfyXQX/W
 6CMNI/IWKaxUvFdi8AnsEZdGYNqOPn4LDQ/bVTRZ3GolSTIyPiCxUr5GS
 pzWccxeePIEsfJCUBPq6/mqgLzoUqOUXGheHeGaDVfosZ6lOhNgEs6+GD
 xAsb2YBCubiQ75anziAb55xrGM+UcXbORlyG6IgyRpFO0mCbJsCczTR5y
 3K2q1nLZkyNnv7DiSenVUaLMwqhXS1+Y8QkWa3BIFqR2KIP1ZdAy7iBjU
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=iAR8eJfT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=656eedf95=Jamie.Gibbons@microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="iAR8eJfT"; 
 dkim-atps=neutral
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

The MPFS RNG driver is not described by the device tree and is instead
registered dynamically by the system controller. Explicitly bind the
MPFS RNG driver as a child device during system controller probe.

This ensures the RNG device is instantiated and available via UCLASS_RNG
without requiring a device tree node.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/misc/mpfs_syscontroller.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index 8803263ca4c..e20f183be3b 100644
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
@@ -334,6 +335,7 @@ EXPORT_SYMBOL(mpfs_syscontroller_process_dtbo);
 static int mpfs_syscontroller_probe(struct udevice *dev)
 {
 	struct mpfs_syscontroller_priv *sys_controller = dev_get_priv(dev);
+	struct udevice *rng_dev;
 	int ret;
 
 	ret = mbox_get_by_index(dev, 0, &sys_controller->chan);
@@ -343,6 +345,10 @@ static int mpfs_syscontroller_probe(struct udevice *dev)
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

