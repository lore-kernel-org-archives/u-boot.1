Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00721C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 22:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F1E660816;
	Wed, 29 Jul 2026 22:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3Gccrzdz9Do; Wed, 29 Jul 2026 22:21:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3B7B607D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785363711;
	bh=u7UCDF0wicqIOuDn8DkjaVC3d5h1AghA7XPHnzqvhlE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RVaXWKM8H7pkd8USGXY/B8BfzPHWYKHc+QmEW7i20u6sOH6zeRGRblFm7uRitlOKF
	 GqAqAfRs4sQEhoyyBvMEsjY+jGeOA7BWfcygUAYOEppWmN91nF2knFOZ2wu8uu53kr
	 mXuaf1daT9brSrGDO2X6nBeo585GHdqUr9mUvwv/F7u4wr5yTKOb+RIPhiYq8y7ota
	 yuFKQQRxl8HvrZtL9MI3QR45RKaWdKSKwXPFakolWKuz4f4ZYeh5HssRAPheuQHw1V
	 kp2VoEPhFpgf7296JIP1LRw3DCfT3Hw/1JcZedqEuJXIJNNHAkjX/H8pZ61cocrKUo
	 jywtRXfzezQiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3B7B607D5;
	Wed, 29 Jul 2026 22:21:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B06D28E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 793E7607D5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_fREclZJ1wF for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 22:21:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B5400607D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5400607D2
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5400607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:21:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2C2EAB0057C;
 Thu, 30 Jul 2026 00:21:39 +0200 (CEST)
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Vincent Jardin <vjardin@free.fr>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pci: layerscape: fix pci_iommu_extra hotplug
Date: Thu, 30 Jul 2026 00:21:17 +0200
Message-ID: <20260729222118.242013-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=free.fr; s=smtp-20201208; t=1785363706;
 bh=SXWFFCb5qoje/Y5q9GoCtfBdqI5RAnGgiPXJMimSAL0=;
 h=From:To:Cc:Subject:Date:From;
 b=IDTHfmcn141AUlXd7XN1Q/Zakw5ObgTlKizbwflv7DXf3U2PrDEvlDZmgSYufLths
 w1LEDXcP26oVLKCf/GW0kAsW/um5ghizvdCZpQeekREM3Epa+7I6V6Th3alHG8i7Rr
 ztIfm/8Vc43uztHzuXaWcK7vr/00v6H2SHR9KFXY8f78MqqD9y5fTO6m3Sl1lEp2Lq
 oL1XR2tMsEjvAISHAZCs/DBxTJaS1eoRlDJgQDSeSvDXgIoG/8Fw1CJyCZk9wMUyVN
 ezxfXUi8tYqYVmvCypm2VXOh9E/dLrhYczXNSLSJnjy6xD7bBEC3mmXLU2U8UqOA3w
 uuhdE/7hNRoOQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=free.fr
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=IDTHfmcn
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

We can have many pci hotplug groups, each introduced
by a "pci@<addr>" token such as,

  pci_iommu_extra=pci@0x3600000,1.0.0,hp,pci@0x3700000,1.0.0,hp,
                  pci@0x3800000,1.0.0,hp,pci@0x3900000,1.0.0,hp

Without this fix, we have the error:
  Added iommu map for hotplug 1.0.0
  ERROR: invalid action in extra iommu entry
  ERROR: invalid action in extra iommu entry
  ERROR: invalid action in extra iommu entry

Fixes: 2a5bbb13cc39 ("pci: layerscape: add a way of specifying additional iommu mappings")
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/pci/pcie_layerscape_fixup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie_layerscape_fixup.c b/drivers/pci/pcie_layerscape_fixup.c
index 97c38c0bfa7..5299aee63db 100644
--- a/drivers/pci/pcie_layerscape_fixup.c
+++ b/drivers/pci/pcie_layerscape_fixup.c
@@ -319,6 +319,11 @@ static struct extra_iommu_entry *get_extra_iommu_ents(void *blob,
 			/* Hot-plug entry */
 			entries[i].action = EXTRA_IOMMU_ENTRY_HOTPLUG;
 			p += 2;
+			/* Skip the comma separator so it check the
+			 * next "pci@" group.
+			 */
+			if (*p == ',')
+				p++;
 		} else if (!strncmp(p, "vfs", 3) ||
 			   !strncmp(p, "noari_vfs", 9)) {
 			/* VFs or VFs with ARI disabled entry */
---
base-commit: 616c3d79f01cf9204e38738857c4647a730dcb3b
branch: for-upstream/pci-layerscape-iommu-extra-v1

-- 
2.43.0

