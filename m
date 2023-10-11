Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B57CD6E67
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AD886E43;
	Wed, 11 Oct 2023 15:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA3D86DE7; Wed, 11 Oct 2023 15:16:56 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB1886DD8
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp83t1697030169t9l1jorp
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:16:08 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: LE7C6P2vL8QwiBBgtCla3gYf8KdtW6moC5eXrLaWdQqGKSy0lyJ684LgEvOoE
 QHN6pm4Jyi3dCoifXzAKSU+Jd1x4/Rb4+r7kKMqHmZVEpH3SX0P84QxR3lHZNdwcZ9Xbdnd
 7ryQ8CZmbOlB2zo4avtkawC11BztKPHlPSHoaublZIhVWRy71MjAAUpQTl68AayhMMMi4ns
 haesTn3P4eGxJyh+2Gww+eYPpH8T271aK2I3tYDd61kzh27R5GcdyClY4uSzbb90NTi5VEf
 pi/G2PvOULxLjZTQQHJygs9XwYJ4WaLAB1RNejisdAuHySNFcFmrlFLxApyk/6Qdopc0xqh
 RMK8Xuk2hCyKz5U4UMSs6QtLtf9PpV0AVp3WnQNM5IXmsu8qSHH2MEfiCtK4w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17083439545190332072
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 5/9] pci_ids: Add Red Hat vendor and device IDs
Date: Wed, 11 Oct 2023 21:15:48 +0800
Message-Id: <20231011131552.14665-6-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011131552.14665-1-bmeng@tinylab.org>
References: <20231011131552.14665-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

Red Hat, Inc. donates a part of its device ID range [1] to QEMU,
to be used for virtual devices. This commit adds several typical
devices that are useful in U-Boot.

[1] https://www.qemu.org/docs/master/specs/pci-ids.html

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 include/pci_ids.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/pci_ids.h b/include/pci_ids.h
index 88b0a64045..b63bf45168 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -1363,6 +1363,13 @@
 #define PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP 0x3fc5
 #define PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP_MADI 0x3fc6
 
+/* Per https://www.qemu.org/docs/master/specs/pci-ids.html */
+#define PCI_VENDOR_ID_REDHAT            0x1b36
+#define PCI_DEVICE_ID_REDHAT_SDHCI      0x0007
+#define PCI_DEVICE_ID_REDHAT_XHCI       0x000d
+#define PCI_DEVICE_ID_REDHAT_NVME       0x0010
+#define PCI_DEVICE_ID_REDHAT_UFS        0x0013
+
 #define PCI_VENDOR_ID_INIT		0x1101
 
 #define PCI_VENDOR_ID_CREATIVE		0x1102 /* duplicate: ECTIVA */
-- 
2.34.1

