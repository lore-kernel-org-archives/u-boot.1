Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22537C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE04885D9;
	Wed, 29 May 2024 08:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zWSccFoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2EA885D9; Wed, 29 May 2024 08:06:11 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15FBF883A0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T663uF050980;
 Wed, 29 May 2024 01:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716962763;
 bh=m5ZPGf6kB9J8IJXIFQn//SSfcKfslDYZMDR+EJbKCbA=;
 h=From:To:CC:Subject:Date;
 b=zWSccFoXoLHstX+YiKLac5EH6hv+k1Ow/N/LGt7VWRlCVAs/6IBL9ODKHkUkJR4iP
 ZK/G0s/1pUHAEZg+eRZMD8oV4vbsP9T6rQKRdxYyc+jt7+wMyM1UhxgxPPu792Dl0f
 o4n6gF0ybu1NqQV37HDU3VBNWJZOhcLKYTItZRgQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T663gr093889
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 01:06:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 01:06:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 01:06:03 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T660Pe123370;
 Wed, 29 May 2024 01:06:01 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <joe.hershberger@ni.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <bmeng.cn@gmail.com>,
 <andriy.shevchenko@linux.intel.com>, <masami.hiramatsu@linaro.org>,
 <sjg@chromium.org>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] env: ti: k3_dfu: Drup mmcpart for rootfs
Date: Wed, 29 May 2024 11:35:59 +0530
Message-ID: <20240529060559.301132-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

According to [0], raw access to mmc should not have mmcpart in the
entry. This was fixed in k3_dfu_combined.env but k3_dfu.env had been
overlooked.

[0] doc/usage/dfu.rst

Fixes: 53b406369e9d ("DFU: Check the number of arguments and argument string strictly")
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Boot Logs:
https://gist.github.com/nehamalcom/163122d2b9d63607cbb383475978364a

 include/env/ti/k3_dfu.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/k3_dfu.env b/include/env/ti/k3_dfu.env
index 201529636cc..b42cf21d986 100644
--- a/include/env/ti/k3_dfu.env
+++ b/include/env/ti/k3_dfu.env
@@ -9,7 +9,7 @@ dfu_alt_info_mmc=
 
 dfu_alt_info_emmc=
 	rawemmc raw 0 0x800000 mmcpart 1;
-	rootfs part 0 1 mmcpart 0;
+	rootfs part 0 1;
 	tiboot3.bin.raw raw 0x0 0x400 mmcpart 1;
 	tispl.bin.raw raw 0x400 0x1000 mmcpart 1;
 	u-boot.img.raw raw 0x1400 0x2000 mmcpart 1;
-- 
2.34.1

