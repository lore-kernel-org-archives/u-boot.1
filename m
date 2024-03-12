Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58981C54E67
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A167D87F2F;
	Tue, 12 Mar 2024 10:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="X/F1r/FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985CE87DE8; Tue, 12 Mar 2024 10:00:11 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6558E87DE6
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710234007; x=1712826007;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=60KNEfVbJ3wM0OC//eNfdGtlcC0QMJQaUhmdtSnKIFY=;
 b=X/F1r/FMx5Ey4e0p0lN4nsqT9YRJ+0i6nzasoVJXlmGhJGyTy2yNZHlQd4c+XlzH
 MJB4071G2gjv9tcKQI5wYUcERm9bFcjdm1wliJwtsK9KFkL+GS8GA+jM+J9GFUYB
 GrceH4+6bpYynRu+wGY9h5oiTTi/n+aoLEvLGsNon1U=;
X-AuditID: ac14000a-fadff7000000290d-fb-65f019978c03
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 14.97.10509.79910F56;
 Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 10:00:06 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 2/5] phycore_imx8mp: Move default bootcmd to board env
Date: Tue, 12 Mar 2024 09:59:54 +0100
Message-ID: <20240312085957.902398-3-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312085957.902398-1-l.anderweit@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR3e65IdUg94/PBYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgybt54zlpw
 nbvi6bHvjA2Mnzm7GDk5JARMJNat38rYxcjFISSwmEni9NQNLBDOY0aJjp832UCq2AT0JVa+
 XMQCYosIuEj8WroHyObgYBYwk5jwORkkLCzgKbH5az8jiM0ioCqx8GwHK4jNK2AtMe3TCRaI
 ZfISMy99Zwdp5RSwkVg90RHEFAIqOXojCqJaUOLkzCdg1cxA1c1bZzND2BISB1+8ALOFBJQk
 7pz6xQYzcdq518wQdqjEkU2rmSYwCs1CMmoWklGzkIxawMi8ilEoNzM5O7UoM1uvIKOyJDVZ
 LyV1EyMowEUYuHYw9s3xOMTIxMF4iFGCg1lJhPe1zttUId6UxMqq1KL8+KLSnNTiQ4zSHCxK
 4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYzZZdFrQp3XPbOpaXZ8c8HnGU/mI+vaMEGJE6ob
 7WzyuuIbjc18nmq71Akn5flG+i14OD/+ZCR7Wf3GbZcaxYV8m3rdozmqnDd7P3r6q2f2U4m2
 T4eT+qbdb+lRtX3k/27mx/+TV3X2bd0fZbv4o9pKrzN5T4ND6m6JO2xoWr9YaV3Ntnks75RY
 ijMSDbWYi4oTAWTU/tleAgAA
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

Move the default bootcmd from the defconfig to the board environment.
No change in functionality.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 12 ++++++++++++
 configs/phycore-imx8mp_defconfig               |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 6d15b7f3dc9f..73202c3b129a 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,3 +1,15 @@
+bootcmd=
+	if test ${dofastboot} = 1; then
+		fastboot 0;
+	fi;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
 console=ttymxc0,115200
 dofastboot=0
 emmc_dev=2
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index b3a7bbd79bb6..fd492eba3c10 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -25,8 +25,6 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="if test ${dofastboot} = 1; then fastboot 0; fi; mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-- 
2.25.1

