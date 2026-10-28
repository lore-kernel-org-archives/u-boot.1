Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F168606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mQRHGU6b;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=Pg2zjJHf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1003A80E21;
	Wed, 28 Oct 2026 10:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bUnNWJHaJymv; Wed, 28 Oct 2026 10:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3E3580CEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793181802;
	b=fnP6rjTvDsD+Wk8rN3dasA4rp4CgrPq/8gOeDf6J20C/U2351JLU1jZRjUvpF0FfCLfG
	 qfSp6WHHOkwQr4uZsQMq/ckCc/I7lI8JuVykpU0i4RBA971O0psGSO1PRfbtGYRN0s1DB
	 3FAe0cvoED5lQHekrd2t5xBnDBFyKYWYaobVG9Mcs/J5n6yUpQnc0G5ZmUkqV8Lh0Rzhp
	 ix1XrDQxT3f2HtUpOc/aw7326pqXVvXDWB6qiexeKpG7IP5T7EuK/QLmsVDo2WI7eBgff
	 3gSyUoO5dAK2JmxCyjiqVgsA9skmESw0CrFRQvh4nY4E58oewdRCtsT0YPpHbNEi4Yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793181802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SpCOmkHcNEoLA9sMfyVTHP8eHR9OgE6lRpKBmbycYtI=;
	b=Av1G43oVI5fy+7J9dbmVSx3YjT67AyjzSGA4vR1feDjZQUD+TxURsoSjfFQVvA0WZz+w
	 kxdYwt9G3ulWUG7x7iUPFMCDt9P2CEPoydv4lKmWVW5AOPxdtiakgFHDCdrbq0VY5Zo1K
	 1BeyLcLIZBLFmBL50zI+hB8lXuZ6PeLoy4ZYyci9jn7kdwcngSA4+1IwS2xcUij9Cgxtz
	 6w1sIL8VabZiS4QlDMj0aoHfdrSvsMWs5v46Xu35iDNHJ7fArp9uSC8xbQiZlI593Ls44
	 7ybFNGAFIEx/PhL1OprOqkqu/ePL1rPlEek/PEDNVyASyrpBjS37CdhZbNehksN948Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793181802;
	bh=SpCOmkHcNEoLA9sMfyVTHP8eHR9OgE6lRpKBmbycYtI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQRHGU6bjuMyCsNrzTls1qdblao1LZ/LphY4lriePcSvV0N3JI/j1b7FN7pITpDpS
	 tIlBaQari5VYm6YEFZCvHYXuUCtGCPEpUd5JQtJoNnY2Zqh/M+Sm2o+y9xKtLbtFHk
	 poKp/8+KZyx1iu8LE7XHeM0Nh2LBlSUnHce42vOCufgWGYEvXcc8c3Xm/cADLPMxWI
	 OsjNcR0UPHnnB8QZmpyZt/fhvvow5WD0a/jgoumHQkOjbsbzyJJj+YgdWjDahprZOq
	 bsrQ2vRrB7htlFHF4U1Lf9kJRbmBqKvbQUo78TZszOg+NV5i/it2pxV4E26yvxE6zL
	 8aGd9zbwhOx5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3E3580CEC;
	Wed, 28 Oct 2026 10:03:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2F1B2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4A8F605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bEDTn0BH_D7P for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81D12605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793181798;
 b=TV9IHZR6VrUz2emKtsGePAo3n/T0dktWfQAvMvUsp/eTnCvKaNefxsJLdRDuce+INEuM
 X9DJy/SxYSdGz+0zaTBoVOLvLwMBQbxgyLxqx/vetKcdeU7HzlUYSVkz2bCi+5IRQ414S
 5AZLm6BnunZ9cQs6AnkF6c6eFTldevuKJZTxCfPDb1us1sh3nL9wQ4PgizOJhhd8IjggF
 o99bTqdawAZH1PMLvhXkgD0HoHQZsLPdyJRA+GwrEX0Sc/roUsmG69y+Tw3gEPv5AsjP8
 e5hsdHXOvJ0E9tRoAfDIBopwAUVIjoIut2fwZFozEfBPu2dkhsvSanS85xid9XXdWHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793181798;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version;
 bh=SpCOmkHcNEoLA9sMfyVTHP8eHR9OgE6lRpKBmbycYtI=;
 b=kP6pDp4M6o3tLwDi/Kr357jbZD1yl9rz7g06wAfFqdUwuRP7AjjZVL7VtSrpar7NQhZB
 h2ueAWjqYFFD3PPxBXxqKGwilaGO9Di/0hu24yUImnDLfiSlchJzpaOoDLtuZ622YIAaQ
 cG5We5lUJihlQyXk9+yuJtJtmUdpmKedBpXu9cIBbp54oloh8ao3IcRf6bBvBoPZT/ztm
 NjadETHGn6yUEB5iNDEdM11/o5NiCyRt9FJQEVFJMEKeNsn5fZtQ3NQlDWEY/ih4bKAj3
 0jiOawSkch8Y4nIZ8KuPa/TOyCDUyiBVOqb5cnwpuhigaJch3CvOd20MjBp+TFeg4vw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=marvell.com;
 dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=Pg2zjJHf; 
 arc=none smtp.remote-ip=67.231.156.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.156.173;
 helo=mx0b-0016f401.pphosted.com;
 envelope-from=prvs=2761532eb6=akashn@marvell.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=marvell.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=Pg2zjJHf
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81D12605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:17 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SA2W9x243633; Wed, 28 Oct 2026 03:03:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 pCOmkHcNEoLA9sMfyVTHP8eHR9OgE6lRpKBmbycYtI=; b=Pg2zjJHfypdEkLqdx
 xXdCI4M7SWZGj+krTcnaLoMnSq1uQ+Wkk0BdNEf0GpBjS7VgEVLgsUnNlfESuAW6
 OBl9GsX1o8Ev+VQw/qn3fYDLl7qNlp4auDbWvjFcSsHQccRbPr68mBFHBcfFi9bZ
 zzO2VWPAMDTZomiF+giHBBBrcsPUIJuSI9qm+Uhcyt3nCptQn3Idk8GDN/eK1i32
 Dmiy8YVqnZNTnolW9UoeabQc7lfjqDuI0S4gUN39Iu5gnAGVWIElnJb965VMVbKC
 9c5GUesr+atxrLKa02eo3+lF6/PnQQI0V16Q3/r49vPyQndgLrrpO7BLQpppCw2x
 PKriw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hk1a3uh2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 03:03:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 Oct 2026 03:03:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 28 Oct 2026 03:03:11 -0700
Received: from hyd1-dt91330.caveonetworks.com (unknown [10.29.36.146])
 by maili.marvell.com (Postfix) with ESMTP id 69BE93F70D0;
 Wed, 28 Oct 2026 03:03:09 -0700 (PDT)
From: Akash Nair <akashn@marvell.com>
To: <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <jerome.forissier@arm.com>, <akashn@marvell.com>,
 <rkannoth@marvell.com>, <naveenm@marvell.com>
Subject: [PATCH RFC 2/2] net: pcs: Add Synopsys DesignWare XPCS driver
Date: Wed, 28 Oct 2026 10:02:58 +0000
Message-ID: <20261028100259.2491887-3-akashn@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028100259.2491887-1-akashn@marvell.com>
References: <20261028100259.2491887-1-akashn@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cLh1IVeN c=1 sm=1 tr=0 ts=6ae1c860 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8wHPafHRbnoY6VNe9yMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: H-yRBiUP2qfKwdC1Izp-gOt9suG8jE7t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfXxlQiwSTTiZ7l
 Zn8BmSDLiYhpmIuLJ8hAJ06t2Nym8J+jyPhnnk9krVfdiyTpPvNBJqexiIK5jtcac6zTVFvc8Lt
 VUWsrae/3g+LIA6MGjzi/gF83JkVnxM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfX3KFIJEPWHdcI
 XpuUjWCQA1XkTBapvdeT79MFdmi28qgSfQuSmpohctxnVLnZVVJdv866dpyauT6ipOVFO4YH8vM
 GEIC6a4j7J1V4JR6+rJi+MZQcjYWtAJx3O+mgDp3KMRz9YcYPMc4vWDwQorQAfVMD8cf/Tjl9Sp
 znOo163PAkq1a0XQGZfCwdPDs9i6TWSGZJ8E/gnSeaxGgn2aingW+jDjAvkQE0BXj376dO90vnG
 nZz77PPgdGplcaa3yKsk+OqE7GjeIJURkheurNCnxbRQZW6X3rQCAC10UTwtxLHCSqTI4hrOIT1
 5Q4emxqTkP8T451RykHMDHd6CUD0vOZ+ZNZwBB9IXMOqMGmZM4cOEzdJHnZb2fJNg5ncGSX3aSE
 3nkE1GgSnylFd8ohcpW4Ftw9NmwbZHyELn1zoFvyZRfQcwV8uWDluq+xEYhHFx3A+DUQXNcAKfR
 IzEgG+zDHQQoiWur4qQ==
X-Proofpoint-ORIG-GUID: H-yRBiUP2qfKwdC1Izp-gOt9suG8jE7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a driver for the (DW XPCS) that implements the interface in <pcs.h>.
It matches the existing "snps,dw-xpcs" binding.

The Clause 45 registers are accessed through the memory mapped
indirect window ("indirect" reg, reg-io-width = <4>). The driver
selects the page of each register and caches it.

Supported modes:
- 1000BASE-KX with Clause 37 auto-negotiation
- 10GBASE-R at fixed speed, without auto-negotiation
- 10GBASE-KR with Clause 73 auto-negotiation

The PCS is only probed. The MAC driver configures it with
pcs_set_config(). The driver has no in-tree user yet, the MAC driver
will follow.

Signed-off-by: Akash Nair <akashn@marvell.com>
---
 drivers/net/Kconfig        |   1 +
 drivers/net/Makefile       |   1 +
 drivers/net/pcs/Kconfig    |  12 +
 drivers/net/pcs/Makefile   |   1 +
 drivers/net/pcs/pcs-xpcs.c | 881 +++++++++++++++++++++++++++++++++++++
 5 files changed, 896 insertions(+)
 create mode 100644 drivers/net/pcs/Kconfig
 create mode 100644 drivers/net/pcs/Makefile
 create mode 100644 drivers/net/pcs/pcs-xpcs.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ae45bef53f5..552d66ed4de 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1146,6 +1146,7 @@ config MDIO_MUX_MESON_GXL
 	  This driver is used for the MDIO mux found on the Amlogic GXL & compatible
 	  SoCs.
 
+source "drivers/net/pcs/Kconfig"
 source "drivers/net/phy/Kconfig"
 source "drivers/net/pfe_eth/Kconfig"
 source "drivers/net/fsl-mc/Kconfig"
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index e5b3e59e536..4474fe515dd 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_OCTEONTX2_CGX_INTF) += octeontx2/cgx_intf.o
 obj-$(CONFIG_OCTEONTX_SMI) += octeontx/smi.o
 obj-$(CONFIG_PCH_GBE) += pch_gbe.o
 obj-$(CONFIG_PCNET) += pcnet.o
+obj-$(CONFIG_PCS_XPCS) += pcs/
 obj-$(CONFIG_PIC32_ETH) += pic32_mdio.o pic32_eth.o
 obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch.o
 obj-$(CONFIG_RENESAS_RAVB) += ravb.o
diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
new file mode 100644
index 00000000000..f5221cfa5d9
--- /dev/null
+++ b/drivers/net/pcs/Kconfig
@@ -0,0 +1,12 @@
+config PCS_XPCS
+	bool "Synopsys DesignWare Ethernet PCS (XPCS)"
+	depends on MISC
+	help
+	  Support the Synopsys DesignWare Ethernet PCS (DWC XPCS), accessed
+	  through its memory-mapped indirect register window.
+
+	  Supported modes are 1000BASE-KX, 10GBASE-R and 10GBASE-KR. The PCS
+	  is configured by the MAC driver through the generic interface in
+	  <pcs.h>.
+
+	  Enable this if the board has a "snps,dw-xpcs" device.
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
new file mode 100644
index 00000000000..6963ad9d1f8
--- /dev/null
+++ b/drivers/net/pcs/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PCS_XPCS) += pcs-xpcs.o
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
new file mode 100644
index 00000000000..0b20003b48a
--- /dev/null
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -0,0 +1,881 @@
+/*
+ * Synopsys DesignWare Ethernet PCS (XPCS) driver
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <pcs.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+/**
+ * struct dw_xpcs - XPCS controller state
+ * @dev: owning device, used for debug messages
+ * @base: mapped XPCS register window
+ * @cur_page: currently selected indirect-access page
+ * @iface: interface mode programmed by the last xpcs_set_config(), or
+ *	PHY_INTERFACE_MODE_NA when not configured
+ * @an_mode: AN mode programmed by the last xpcs_set_config()
+ * @speed_mbps: speed of @iface, 0 when not configured
+ * @powered_down: the PCS is in power-down.
+ * @an_done: AN completed (Clause 37 or 73), latched from the AN interrupt
+ *	status
+ * @an_err: Clause 73 AN failed, latched from the link partner base page
+ */
+struct dw_xpcs {
+	struct udevice		*dev;
+	void __iomem		*base;
+	u32			cur_page;
+	phy_interface_t		iface;
+	enum pcs_an_mode	an_mode;
+	int			speed_mbps;
+	bool			powered_down;
+	bool			an_done;
+	int			an_err;
+};
+
+/* Driver constants */
+#define DW_XPCS_PAGE_INVALID	0xFFFFFFFFu
+#define DW_XPCS_SPEED_1G	1000
+#define DW_XPCS_SPEED_10G	10000
+
+/*
+ * Power transitions.
+ */
+#define DW_XPCS_PDOWN_DELAY_MS	1
+#define DW_XPCS_PUP_DELAY_MS	10
+#define DW_XPCS_PUP_TMO_US	100000
+#define DW_XPCS_RST_TMO_US	100000
+#define DW_XPCS_POLL_INTERVAL_US	100
+
+/*
+ * Indirect access: MMD and register number to window offset.
+ */
+#define DW_XPCS_REG_MASK		GENMASK(15, 0)
+#define DW_XPCS_MMD_SHIFT		16
+#define DW_XPCS_REG_STRIDE_SHIFT	2
+#define DW_XPCS_REG_IO_WIDTH		4
+#define DW_XPCS_REG_IO_WIDTH_DEFAULT	2
+#define DW_XPCS_MIN_REG_SZ		SZ_1K
+
+#define DW_XPCS_CANON(mmd, reg)	(((u32)(mmd) << DW_XPCS_MMD_SHIFT) | \
+				 ((reg) & DW_XPCS_REG_MASK))
+#define DW_XPCS_IND_SENTINEL	0x3FCu
+#define DW_XPCS_IND_PAGE_SHIFT	10
+#define DW_XPCS_IND_PAGE_MASK	GENMASK(12, 0)
+#define DW_XPCS_IND_OFF_MASK	GENMASK(9, 0)
+#define DW_XPCS_IND_PAGE(byte)	(((byte) >> DW_XPCS_IND_PAGE_SHIFT) & \
+				 DW_XPCS_IND_PAGE_MASK)
+#define DW_XPCS_IND_OFF(byte)	((byte) & DW_XPCS_IND_OFF_MASK)
+
+/* MMD (Clause 45 device) numbers */
+#define DW_XPCS_MMD_PMA_PMD	0x01
+#define DW_XPCS_MMD_PCS		0x03
+#define DW_XPCS_MMD_AN		0x07
+#define DW_XPCS_MMD_VEND2	0x1F
+
+/*
+ * Clause 45 device identifier registers, the same in every MMD.
+ */
+#define DW_XPCS_DEV_ID1		0x0002
+#define DW_XPCS_DEV_ID2		0x0003
+#define DW_XPCS_DEV_ID1_SHIFT	16
+#define DW_XPCS_DEV_ID		0x7996ced0u
+
+/*
+ * Speed selection bits.
+ */
+#define DW_XPCS_CTRL1_SS13			BIT(13)
+#define DW_XPCS_CTRL1_SS6			BIT(6)
+#define DW_XPCS_CTRL1_SS_MASK			(DW_XPCS_CTRL1_SS13 | \
+						 DW_XPCS_CTRL1_SS6)
+#define DW_XPCS_CTRL1_SS_1G			DW_XPCS_CTRL1_SS6
+#define DW_XPCS_CTRL1_SS_10G			(DW_XPCS_CTRL1_SS13 | \
+						 DW_XPCS_CTRL1_SS6)
+
+/* ---- PMA/PMD MMD (device 1) ---- */
+#define DW_XPCS_SR_PMA_CTRL1			0x0000
+
+#define DW_XPCS_VR_PMA_DIG_CTRL1		0x8000
+#define DW_XPCS_VR_PMA_DIG_CTRL1_CL72_AUTO	BIT(0)
+
+/* ---- PCS / XS-PCS MMD (device 3) ---- */
+#define DW_XPCS_SR_XS_PCS_CTRL1			0x0000
+#define DW_XPCS_SR_XS_PCS_CTRL1_RST		BIT(15)
+#define DW_XPCS_SR_XS_PCS_CTRL1_LPM		BIT(11)
+
+#define DW_XPCS_SR_XS_PCS_STS1			0x0001
+#define DW_XPCS_SR_XS_PCS_STS1_LSTATUS		BIT(2)
+
+#define DW_XPCS_SR_XS_PCS_CTRL2			0x0007
+#define DW_XPCS_SR_XS_PCS_CTRL2_TYPE_MASK	GENMASK(3, 0)
+
+#define DW_XPCS_SR_XS_PCS_CTRL2_TYPE_10GBASEX	0x1
+#define DW_XPCS_SR_XS_PCS_CTRL2_TYPE_10GBASER	0x0
+
+#define DW_XPCS_VR_XS_PCS_DIG_CTRL1		0x8000
+#define DW_XPCS_VR_XS_PCS_DIG_CTRL1_CL37_BP	BIT(12)
+
+/* ---- AN MMD (device 7) ---- */
+#define DW_XPCS_SR_AN_CTRL			0x0000
+#define DW_XPCS_SR_AN_CTRL_AN_EN		BIT(12)
+#define DW_XPCS_SR_AN_CTRL_RSTRT_AN		BIT(9)
+
+#define DW_XPCS_SR_AN_ADV1			0x0010
+#define DW_XPCS_SR_AN_ADV1_SELECTOR		0x0001
+#define DW_XPCS_SR_AN_ADV1_NP			BIT(15)
+
+#define DW_XPCS_SR_AN_ADV2			0x0011
+#define DW_XPCS_SR_AN_ADV2_10GKR		BIT(7)
+
+#define DW_XPCS_SR_AN_ADV3			0x0012
+
+#define DW_XPCS_SR_AN_LP_ABL1			0x0013
+#define DW_XPCS_SR_AN_LP_ABL1_NP		BIT(15)
+
+#define DW_XPCS_SR_AN_LP_ABL2			0x0014
+#define DW_XPCS_SR_AN_LP_ABL2_10GKR		BIT(7)
+
+#define DW_XPCS_VR_AN_INTR			0x8002
+#define DW_XPCS_VR_AN_INTR_CMPLT		BIT(0)
+#define DW_XPCS_VR_AN_INTR_INC_LINK		BIT(1)
+#define DW_XPCS_VR_AN_INTR_PG_RCV		BIT(2)
+#define DW_XPCS_VR_AN_INTR_ALL			(DW_XPCS_VR_AN_INTR_CMPLT | \
+						 DW_XPCS_VR_AN_INTR_INC_LINK | \
+						 DW_XPCS_VR_AN_INTR_PG_RCV)
+
+#define DW_XPCS_SR_MII_CTRL			0x0000
+#define DW_XPCS_SR_MII_CTRL_AN_ENABLE		BIT(12)
+
+#define DW_XPCS_SR_MII_STS			0x0001
+#define DW_XPCS_SR_MII_STS_LSTATUS		BIT(2)
+
+#define DW_XPCS_VR_MII_AN_CTRL			0x8001
+#define DW_XPCS_VR_MII_AN_CTRL_MII_AN_INTR_EN	BIT(0)
+#define DW_XPCS_VR_MII_AN_CTRL_PCS_MODE_MASK	GENMASK(2, 1)
+#define DW_XPCS_VR_MII_AN_CTRL_PCS_MODE_1000X	0x0
+
+#define DW_XPCS_VR_MII_AN_INTR_STS		0x8002
+#define DW_XPCS_VR_MII_AN_INTR_STS_CL37_ANCMPLT	BIT(0)
+
+static void xpcs_set_page(struct dw_xpcs *xpcs, u32 byteaddr)
+{
+	u32 page = DW_XPCS_IND_PAGE(byteaddr);
+
+	if (page != xpcs->cur_page) {
+		writel(page, xpcs->base + DW_XPCS_IND_SENTINEL);
+		xpcs->cur_page = page;
+	}
+}
+
+static int xpcs_read(struct dw_xpcs *xpcs, u8 mmd, u16 reg)
+{
+	u32 byteaddr = DW_XPCS_CANON(mmd, reg) << DW_XPCS_REG_STRIDE_SHIFT;
+
+	xpcs_set_page(xpcs, byteaddr);
+
+	return readl(xpcs->base + DW_XPCS_IND_OFF(byteaddr)) & DW_XPCS_REG_MASK;
+}
+
+static int xpcs_write(struct dw_xpcs *xpcs, u8 mmd, u16 reg, u16 val)
+{
+	u32 byteaddr = DW_XPCS_CANON(mmd, reg) << DW_XPCS_REG_STRIDE_SHIFT;
+
+	xpcs_set_page(xpcs, byteaddr);
+	writel(val, xpcs->base + DW_XPCS_IND_OFF(byteaddr));
+
+	return 0;
+}
+
+static int xpcs_modify(struct dw_xpcs *xpcs, u8 mmd, u16 reg, u16 mask, u16 set)
+{
+	int val;
+
+	val = xpcs_read(xpcs, mmd, reg);
+	if (val < 0)
+		return val;
+
+	return xpcs_write(xpcs, mmd, reg, (val & ~mask) | (set & mask));
+}
+
+static int xpcs_wait_reset_done(struct dw_xpcs *xpcs)
+{
+	int val, ret;
+
+	ret = read_poll_timeout(xpcs_read, val,
+				val < 0 || !(val & DW_XPCS_SR_XS_PCS_CTRL1_RST),
+				DW_XPCS_POLL_INTERVAL_US,
+				DW_XPCS_RST_TMO_US, xpcs,
+				DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1);
+	if (ret)
+		return ret;
+
+	return val < 0 ? val : 0;
+}
+
+/*
+ * Wait for the PCS to leave power-down.
+ */
+static int xpcs_wait_power_up_done(struct dw_xpcs *xpcs)
+{
+	int val, ret;
+
+	mdelay(DW_XPCS_PUP_DELAY_MS);
+
+	ret = read_poll_timeout(xpcs_read, val,
+				val < 0 ||
+				!(val & (DW_XPCS_SR_XS_PCS_CTRL1_LPM |
+					 DW_XPCS_SR_XS_PCS_CTRL1_RST)),
+				DW_XPCS_POLL_INTERVAL_US,
+				DW_XPCS_PUP_TMO_US, xpcs,
+				DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1);
+	if (ret) {
+		dev_dbg(xpcs->dev, "PCS not ready after power-up, CTRL1 %#x\n",
+			val);
+		return ret;
+	}
+
+	return val < 0 ? val : 0;
+}
+
+/*
+ * Switch off every auto-negotiation and drop what a previous mode left in
+ * the registers.
+ */
+static int xpcs_an_stop(struct dw_xpcs *xpcs)
+{
+	int ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_CTRL,
+			  DW_XPCS_SR_AN_CTRL_AN_EN, 0);
+	if (ret)
+		return ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_VEND2, DW_XPCS_SR_MII_CTRL,
+			  DW_XPCS_SR_MII_CTRL_AN_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_VR_XS_PCS_DIG_CTRL1,
+			  DW_XPCS_VR_XS_PCS_DIG_CTRL1_CL37_BP, 0);
+	if (ret)
+		return ret;
+
+	return xpcs_modify(xpcs, DW_XPCS_MMD_PMA_PMD, DW_XPCS_VR_PMA_DIG_CTRL1,
+			   DW_XPCS_VR_PMA_DIG_CTRL1_CL72_AUTO, 0);
+}
+
+/*
+ * Select the speed bits in the PMA/PMD and the PCS control regs.
+ */
+static int xpcs_set_speed_sel(struct dw_xpcs *xpcs, u16 ss)
+{
+	int ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_PMA_PMD, DW_XPCS_SR_PMA_CTRL1,
+			  DW_XPCS_CTRL1_SS_MASK, ss);
+	if (ret)
+		return ret;
+
+	return xpcs_modify(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1,
+			   DW_XPCS_CTRL1_SS_MASK, ss);
+}
+
+static int xpcs_set_mode_1g_kx(struct dw_xpcs *xpcs)
+{
+	int ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL2,
+			  DW_XPCS_SR_XS_PCS_CTRL2_TYPE_MASK,
+			  DW_XPCS_SR_XS_PCS_CTRL2_TYPE_10GBASEX);
+	if (ret)
+		return ret;
+
+	return xpcs_set_speed_sel(xpcs, DW_XPCS_CTRL1_SS_1G);
+}
+
+static int xpcs_set_mode_10g(struct dw_xpcs *xpcs)
+{
+	int ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL2,
+			  DW_XPCS_SR_XS_PCS_CTRL2_TYPE_MASK,
+			  DW_XPCS_SR_XS_PCS_CTRL2_TYPE_10GBASER);
+	if (ret)
+		return ret;
+
+	return xpcs_set_speed_sel(xpcs, DW_XPCS_CTRL1_SS_10G);
+}
+
+/*
+ * Put the PCS in low-power, wait, then bring it back up.
+ * powered_down is cleared only once the PCS is ready again. If that fails
+ * the PCS stays marked as powered down, and the next xpcs_set_config() powers
+ * it up first.
+ */
+static int xpcs_power_cycle(struct dw_xpcs *xpcs)
+{
+	int val, ret;
+
+	val = xpcs_read(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1);
+	if (val < 0)
+		return val;
+
+	val &= ~DW_XPCS_SR_XS_PCS_CTRL1_RST;
+
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1,
+			 val | DW_XPCS_SR_XS_PCS_CTRL1_LPM);
+	if (ret)
+		return ret;
+	xpcs->powered_down = true;
+
+	mdelay(DW_XPCS_PDOWN_DELAY_MS);
+
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1,
+			 val & ~DW_XPCS_SR_XS_PCS_CTRL1_LPM);
+	if (ret)
+		return ret;
+
+	ret = xpcs_wait_power_up_done(xpcs);
+	if (ret)
+		return ret;
+
+	xpcs->powered_down = false;
+
+	return 0;
+}
+
+/* Wake the PCS from power-down and wait until it is ready. */
+static int xpcs_power_up(struct dw_xpcs *xpcs)
+{
+	int ret;
+
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1, 0);
+	if (ret)
+		return ret;
+
+	ret = xpcs_wait_power_up_done(xpcs);
+	if (ret)
+		return ret;
+
+	xpcs->powered_down = false;
+
+	return 0;
+}
+
+/* Start Clause 37 AN. Completion is reported by xpcs_get_state(). */
+static int xpcs_config_an_c37(struct dw_xpcs *xpcs)
+{
+	int ret;
+
+	/* Clear stale status before AN starts; the poll/result keep it. */
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_VEND2, DW_XPCS_VR_MII_AN_INTR_STS,
+			 0);
+	if (ret)
+		return ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_VR_XS_PCS_DIG_CTRL1,
+			  DW_XPCS_VR_XS_PCS_DIG_CTRL1_CL37_BP,
+			  DW_XPCS_VR_XS_PCS_DIG_CTRL1_CL37_BP);
+	if (ret)
+		return ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_VEND2, DW_XPCS_VR_MII_AN_CTRL,
+			  DW_XPCS_VR_MII_AN_CTRL_PCS_MODE_MASK |
+			  DW_XPCS_VR_MII_AN_CTRL_MII_AN_INTR_EN,
+			  FIELD_PREP(DW_XPCS_VR_MII_AN_CTRL_PCS_MODE_MASK,
+				     DW_XPCS_VR_MII_AN_CTRL_PCS_MODE_1000X) |
+			  DW_XPCS_VR_MII_AN_CTRL_MII_AN_INTR_EN);
+	if (ret)
+		return ret;
+
+	return xpcs_modify(xpcs, DW_XPCS_MMD_VEND2, DW_XPCS_SR_MII_CTRL,
+			   DW_XPCS_SR_MII_CTRL_AN_ENABLE,
+			   DW_XPCS_SR_MII_CTRL_AN_ENABLE);
+}
+
+/* Start Clause 73 AN. Completion is reported by xpcs_get_state(). */
+static int xpcs_config_an_c73_10gkr(struct dw_xpcs *xpcs)
+{
+	int ret;
+
+	ret = xpcs_modify(xpcs, DW_XPCS_MMD_PMA_PMD, DW_XPCS_VR_PMA_DIG_CTRL1,
+			  DW_XPCS_VR_PMA_DIG_CTRL1_CL72_AUTO,
+			  DW_XPCS_VR_PMA_DIG_CTRL1_CL72_AUTO);
+	if (ret)
+		return ret;
+
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_AN, DW_XPCS_VR_AN_INTR, 0);
+	if (ret)
+		return ret;
+
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_ADV3, 0);
+	if (ret)
+		return ret;
+
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_ADV2,
+			 DW_XPCS_SR_AN_ADV2_10GKR);
+	if (ret)
+		return ret;
+
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_ADV1,
+			 DW_XPCS_SR_AN_ADV1_SELECTOR);
+	if (ret)
+		return ret;
+
+	return xpcs_modify(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_CTRL,
+			   DW_XPCS_SR_AN_CTRL_AN_EN |
+			   DW_XPCS_SR_AN_CTRL_RSTRT_AN,
+			   DW_XPCS_SR_AN_CTRL_AN_EN |
+			   DW_XPCS_SR_AN_CTRL_RSTRT_AN);
+}
+
+/*
+ * Read a latched link bit. The bit stays low after a link drop until it is
+ * read, so read twice and report the second value.
+ */
+static int xpcs_read_link_bit(struct dw_xpcs *xpcs, u8 mmd, u16 reg, u16 mask,
+			      bool *up)
+{
+	int val;
+
+	val = xpcs_read(xpcs, mmd, reg);
+	if (val < 0)
+		return val;
+
+	val = xpcs_read(xpcs, mmd, reg);
+	if (val < 0)
+		return val;
+
+	*up = val & mask;
+
+	return 0;
+}
+
+static int xpcs_kx_link_up(struct dw_xpcs *xpcs, bool *up)
+{
+	return xpcs_read_link_bit(xpcs, DW_XPCS_MMD_VEND2, DW_XPCS_SR_MII_STS,
+				  DW_XPCS_SR_MII_STS_LSTATUS, up);
+}
+
+static int xpcs_10g_link_up(struct dw_xpcs *xpcs, bool *up)
+{
+	return xpcs_read_link_bit(xpcs, DW_XPCS_MMD_PCS,
+				  DW_XPCS_SR_XS_PCS_STS1,
+				  DW_XPCS_SR_XS_PCS_STS1_LSTATUS, up);
+}
+
+static int xpcs_get_link(struct dw_xpcs *xpcs, bool *up)
+{
+	if (xpcs->iface == PHY_INTERFACE_MODE_1000BASEKX)
+		return xpcs_kx_link_up(xpcs, up);
+
+	return xpcs_10g_link_up(xpcs, up);
+}
+
+/*
+ * Report Clause 37 AN completion.
+ */
+static int xpcs_read_an_state_c37(struct dw_xpcs *xpcs,
+				  struct pcs_state *state, bool link)
+{
+	int sts, ret;
+
+	sts = xpcs_read(xpcs, DW_XPCS_MMD_VEND2, DW_XPCS_VR_MII_AN_INTR_STS);
+	if (sts < 0)
+		return sts;
+
+	if (sts & DW_XPCS_VR_MII_AN_INTR_STS_CL37_ANCMPLT) {
+		ret = xpcs_write(xpcs, DW_XPCS_MMD_VEND2,
+				 DW_XPCS_VR_MII_AN_INTR_STS,
+				 sts & ~DW_XPCS_VR_MII_AN_INTR_STS_CL37_ANCMPLT);
+		if (ret)
+			return ret;
+
+		xpcs->an_done = true;
+	} else if (!link) {
+		xpcs->an_done = false;
+	}
+
+	state->an_complete = xpcs->an_done;
+
+	return 0;
+}
+
+/*
+ * Check the base page of the link partner: 0 if it can do 10GBASE-KR
+ * without Next Pages, a negative error otherwise.
+ */
+static int xpcs_check_lp_c73(struct dw_xpcs *xpcs)
+{
+	int adv1, lp1, lp2;
+
+	lp2 = xpcs_read(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_LP_ABL2);
+	if (lp2 < 0)
+		return lp2;
+	if (!(lp2 & DW_XPCS_SR_AN_LP_ABL2_10GKR))
+		return -EPROTONOSUPPORT;
+
+	adv1 = xpcs_read(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_ADV1);
+	if (adv1 < 0)
+		return adv1;
+
+	lp1 = xpcs_read(xpcs, DW_XPCS_MMD_AN, DW_XPCS_SR_AN_LP_ABL1);
+	if (lp1 < 0)
+		return lp1;
+
+	if ((adv1 & DW_XPCS_SR_AN_ADV1_NP) ||
+	    (lp1 & DW_XPCS_SR_AN_LP_ABL1_NP))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+/*
+ * Clause 73 AN (10GBASE-KR). Returns a negative error if the link
+ * partner cannot do 10GBASE-KR, so a failed negotiation is reported
+ * instead of looking like "not complete yet".
+ */
+static int xpcs_read_an_state_c73(struct dw_xpcs *xpcs,
+				  struct pcs_state *state)
+{
+	int intr, ret;
+
+	intr = xpcs_read(xpcs, DW_XPCS_MMD_AN, DW_XPCS_VR_AN_INTR);
+	if (intr < 0)
+		return intr;
+
+	intr &= DW_XPCS_VR_AN_INTR_ALL;
+	if (intr) {
+		/*
+		 * A received page restarts negotiation, so drop the old result.
+		 * Return register errors before clearing the event so it is
+		 * seen again.
+		 */
+		if (intr & DW_XPCS_VR_AN_INTR_PG_RCV) {
+			ret = xpcs_check_lp_c73(xpcs);
+			if (ret && ret != -EPROTONOSUPPORT &&
+			    ret != -EOPNOTSUPP)
+				return ret;
+
+			xpcs->an_done = false;
+			xpcs->an_err = ret;
+		}
+
+		ret = xpcs_write(xpcs, DW_XPCS_MMD_AN, DW_XPCS_VR_AN_INTR,
+				 ~intr & DW_XPCS_VR_AN_INTR_ALL);
+		if (ret)
+			return ret;
+
+		if (intr & DW_XPCS_VR_AN_INTR_CMPLT)
+			xpcs->an_done = true;
+	}
+
+	if (xpcs->an_err)
+		return xpcs->an_err;
+
+	state->an_complete = xpcs->an_done;
+
+	return 0;
+}
+
+static int xpcs_get_state(struct udevice *dev, struct pcs_state *state)
+{
+	struct dw_xpcs *xpcs = dev_get_priv(dev);
+	int ret = 0;
+	bool link;
+
+	/*
+	 * A powered down or not configured PCS has nothing to report, so
+	 * leave the state cleared.
+	 */
+	if (xpcs->powered_down || xpcs->iface == PHY_INTERFACE_MODE_NA)
+		return 0;
+
+	state->speed_mbps = xpcs->speed_mbps;
+
+	ret = xpcs_get_link(xpcs, &link);
+	if (ret)
+		return ret;
+
+	switch (xpcs->an_mode) {
+	case PCS_AN_C37:
+		ret = xpcs_read_an_state_c37(xpcs, state, link);
+		break;
+	case PCS_AN_C73:
+		ret = xpcs_read_an_state_c73(xpcs, state);
+		break;
+	case PCS_AN_FORCED:
+	default:
+		break;
+	}
+	if (ret)
+		return ret;
+
+	state->link = link;
+
+	return 0;
+}
+
+/*
+ * Check the whole config before touching the hardware, so a bad request
+ * never leaves the PCS half-configured.
+ */
+static int xpcs_validate_cfg(const struct pcs_config *cfg)
+{
+	if (!cfg)
+		return -EINVAL;
+
+	switch (cfg->iface) {
+	case PHY_INTERFACE_MODE_1000BASEKX:
+		if (cfg->an_mode != PCS_AN_C37)
+			return -EOPNOTSUPP;
+		if (cfg->speed_mbps && cfg->speed_mbps != DW_XPCS_SPEED_1G)
+			return -EINVAL;
+		return 0;
+	case PHY_INTERFACE_MODE_10GBASER:
+		if (cfg->an_mode != PCS_AN_FORCED)
+			return -EOPNOTSUPP;
+		if (cfg->speed_mbps != DW_XPCS_SPEED_10G)
+			return -EINVAL;
+		return 0;
+	case PHY_INTERFACE_MODE_10GKR:
+		if (cfg->an_mode != PCS_AN_C73)
+			return -EOPNOTSUPP;
+		if (cfg->speed_mbps && cfg->speed_mbps != DW_XPCS_SPEED_10G)
+			return -EINVAL;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Mark the PCS as not configured, and drop the latched AN events */
+static void xpcs_clear_state(struct dw_xpcs *xpcs)
+{
+	xpcs->iface = PHY_INTERFACE_MODE_NA;
+	xpcs->an_mode = PCS_AN_FORCED;
+	xpcs->speed_mbps = 0;
+	xpcs->an_done = false;
+	xpcs->an_err = 0;
+}
+
+/*
+ * Configure the PCS safely: disable any current AN, program the new mode,
+ * power-cycle to latch it, then re-enable AN if the mode requires it.
+ */
+static int xpcs_set_config(struct udevice *dev, const struct pcs_config *cfg)
+{
+	struct dw_xpcs *xpcs = dev_get_priv(dev);
+	int ret;
+
+	ret = xpcs_validate_cfg(cfg);
+	if (ret)
+		return ret;
+
+	dev_dbg(xpcs->dev, "configure %s, AN mode %d\n",
+		phy_string_for_interface(cfg->iface), cfg->an_mode);
+
+	if (xpcs->powered_down) {
+		ret = xpcs_power_up(xpcs);
+		if (ret)
+			return ret;
+	}
+
+	xpcs_clear_state(xpcs);
+
+	ret = xpcs_an_stop(xpcs);
+	if (ret)
+		return ret;
+
+	if (cfg->iface == PHY_INTERFACE_MODE_1000BASEKX)
+		ret = xpcs_set_mode_1g_kx(xpcs);
+	else
+		ret = xpcs_set_mode_10g(xpcs);
+	if (ret)
+		return ret;
+
+	ret = xpcs_power_cycle(xpcs);
+	if (ret)
+		return ret;
+
+	switch (cfg->iface) {
+	case PHY_INTERFACE_MODE_1000BASEKX:
+		ret = xpcs_config_an_c37(xpcs);
+		break;
+	case PHY_INTERFACE_MODE_10GKR:
+		ret = xpcs_config_an_c73_10gkr(xpcs);
+		break;
+	default:
+		/* 10GBASE-R: fixed speed, AN stays off */
+		ret = 0;
+		break;
+	}
+	if (ret)
+		return ret;
+
+	xpcs->iface = cfg->iface;
+	xpcs->an_mode = cfg->an_mode;
+	xpcs->speed_mbps = cfg->iface == PHY_INTERFACE_MODE_1000BASEKX ?
+			   DW_XPCS_SPEED_1G : DW_XPCS_SPEED_10G;
+
+	return 0;
+}
+
+/*
+ * Stop AN and put the PCS in low-power.
+ */
+static int xpcs_disable(struct udevice *dev)
+{
+	struct dw_xpcs *xpcs = dev_get_priv(dev);
+	int ctrl1, ret;
+
+	if (xpcs->powered_down)
+		return 0;
+
+	ret = xpcs_an_stop(xpcs);
+	if (ret)
+		return ret;
+
+	xpcs_clear_state(xpcs);
+
+	ctrl1 = xpcs_read(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1);
+	if (ctrl1 < 0)
+		return ctrl1;
+
+	ctrl1 &= ~DW_XPCS_SR_XS_PCS_CTRL1_RST;
+	ret = xpcs_write(xpcs, DW_XPCS_MMD_PCS, DW_XPCS_SR_XS_PCS_CTRL1,
+			 ctrl1 | DW_XPCS_SR_XS_PCS_CTRL1_LPM);
+	if (ret)
+		return ret;
+	xpcs->powered_down = true;
+
+	mdelay(DW_XPCS_PDOWN_DELAY_MS);
+
+	return 0;
+}
+
+static int xpcs_of_to_plat(struct udevice *dev)
+{
+	fdt_size_t size;
+	u32 io_width;
+
+	if (dev_read_addr_size_name(dev, "indirect", &size) ==
+	    FDT_ADDR_T_NONE) {
+		dev_err(dev, "missing reg, or reg-names is not \"indirect\"\n");
+		return -EINVAL;
+	}
+
+	if (size < DW_XPCS_MIN_REG_SZ) {
+		dev_err(dev, "reg window too small (%#llx)\n",
+			(unsigned long long)size);
+		return -EINVAL;
+	}
+
+	io_width = dev_read_u32_default(dev, "reg-io-width",
+					DW_XPCS_REG_IO_WIDTH_DEFAULT);
+	if (io_width != DW_XPCS_REG_IO_WIDTH) {
+		dev_err(dev, "unsupported reg-io-width %u (need %u)\n",
+			io_width, DW_XPCS_REG_IO_WIDTH);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int xpcs_get_dev_id(struct dw_xpcs *xpcs, u8 mmd, u32 *id)
+{
+	int id1, id2;
+
+	id1 = xpcs_read(xpcs, mmd, DW_XPCS_DEV_ID1);
+	if (id1 < 0)
+		return id1;
+
+	id2 = xpcs_read(xpcs, mmd, DW_XPCS_DEV_ID2);
+	if (id2 < 0)
+		return id2;
+
+	*id = ((u32)id1 << DW_XPCS_DEV_ID1_SHIFT) | id2;
+
+	return 0;
+}
+
+static int xpcs_check_dev_id(struct dw_xpcs *xpcs)
+{
+	int ret;
+	u32 id;
+
+	ret = xpcs_get_dev_id(xpcs, DW_XPCS_MMD_PMA_PMD, &id);
+	if (ret) {
+		dev_err(xpcs->dev, "failed to read XPCS device ID (%d)\n", ret);
+		return ret;
+	}
+
+	if (id != DW_XPCS_DEV_ID) {
+		dev_err(xpcs->dev,
+			"unexpected XPCS device ID %#010x, expected %#010x\n",
+			id, DW_XPCS_DEV_ID);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int xpcs_probe(struct udevice *dev)
+{
+	struct dw_xpcs *xpcs = dev_get_priv(dev);
+	int ret;
+
+	xpcs->base = dev_remap_addr_name(dev, "indirect");
+	if (!xpcs->base) {
+		dev_err(dev, "failed to map XPCS register window\n");
+		return -ENOMEM;
+	}
+
+	xpcs->dev = dev;
+	xpcs->cur_page = DW_XPCS_PAGE_INVALID;
+	xpcs_clear_state(xpcs);
+
+	/* PCS ready check */
+	ret = xpcs_wait_reset_done(xpcs);
+	if (ret) {
+		dev_err(dev, "XPCS did not come out of reset\n");
+		return ret;
+	}
+
+	ret = xpcs_check_dev_id(xpcs);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "XPCS present at %p; awaiting MAC-driven speed config\n",
+		xpcs->base);
+
+	return 0;
+}
+
+static const struct pcs_ops xpcs_ops = {
+	.set_config	= xpcs_set_config,
+	.get_state	= xpcs_get_state,
+	.disable	= xpcs_disable,
+};
+
+static const struct udevice_id xpcs_ids[] = {
+	{ .compatible = "snps,dw-xpcs" },
+	{ }
+};
+
+U_BOOT_DRIVER(snps_dw_xpcs) = {
+	.name		= "snps_dw_xpcs",
+	.id		= UCLASS_MISC,
+	.of_match	= xpcs_ids,
+	.of_to_plat	= xpcs_of_to_plat,
+	.probe		= xpcs_probe,
+	.ops		= &xpcs_ops,
+	.priv_auto	= sizeof(struct dw_xpcs),
+};
-- 
2.43.0

