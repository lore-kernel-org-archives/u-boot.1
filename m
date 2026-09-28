Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59508C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DD2180CEB;
	Mon, 28 Sep 2026 10:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7HZM__ovluS; Mon, 28 Sep 2026 10:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6F6E380CF8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590657;
	b=Gbwst22vGsN9xHNTXocGz8MCs9mija5OsL6P1+V295XChzdfIlk8wF7eYuX72QbPa9UK
	 z7YrMsrVvmJfZt//8Y0EsyJvVlez5EaH0/aStZBaTf+y4kYYd+0TCZqP4/ybfDtKJBfyq
	 2BiO15qglkT7vSD2+rOABxwMpW+SlqvzqePBn7ATe9wBf7attO5yyaMLfeOmFl6SsZ0T8
	 4MR1ShrVfWrTBT/213V6Q7wBrg8rddgK85I5vIVf9eWamNm50Bdy6+q7oXNSgjXlZXchH
	 ZbJ3MeWpnaFYA4pMJkOunSqrZDVsLC3eaxDG5YFlPXSPIvlEuSXr+jyVx8OL8zVKdWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YpezrG5kNtgTOiZ1Xisv6H/SzwhdEVOA+8oec19zaw8=;
	b=aXBeOy6Q+w0StsE9F6jdUL+faq9tq0DSZz4pvK365h3ZqKd2c5v5EGMVy5agyEqKmnZh
	 misAlAykbw0QgJGnOSlKPS9hDSwr2L0q0xV6ZkBznLvslP/S48usWVRbGXbs79teZ2gUz
	 YuPCccTyuNXYtbTmEYuAkL3FsBBlAAJOqh10xnm8dJOlAnaEUsd3Xziaz9TeE2axaEUJg
	 ImkD1g3ov9hiBMdeph5VPx6C6M07M5aGV2AcuZ9s+WxQoeu0n1RGd4C1X5Atspfuo+NWh
	 j85QkU4OFwy2AtzRerN0kMdk6zl26U6gGw48BOMb0O3M/DkzmhSIlzyrI2GLsEqm0kA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590657;
	bh=YpezrG5kNtgTOiZ1Xisv6H/SzwhdEVOA+8oec19zaw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OyUx7Rfgic4kTSarOFAI36UTdPUIHhyQos1X+i6QDyG48O6dlsNPU0a16EPKKyTBl
	 b8Qvrs9f0FuO1wBcGvqcpB6mK8X2zHF1h2DowEPjIIxm+a/7pTTBXTnPvjA5nvgq0E
	 DwqXNPLtFMvlcnimlrLiEgS7P9g/P7O473+rMXQm5gAB7hY4PmgrtfPrz7ImedeZvA
	 rb0F/cu6f87jSv6SDHVmoDThp2jhu0fryY3+j1KIk5lEa/Qfx+7QROZFWSrfP9G/zS
	 Gg1XWwNbwqOrpr9mbIrD9/3iizMwmYL7Fbsqeo5EmFf4ylcu9ceziS5nFt7auzpWLO
	 PkoQ6m4eJymvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F6E380CF8;
	Mon, 28 Sep 2026 10:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F18B324E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF67A405A9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vRU0NvZX2XU for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 54A4240598
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590655;
 b=XHDEsWy0VubC474Qtw+wtKKN3DQJnH7v/uRLSJaTyn103L8kZIBW8RYtAOh8QXAJAWM/
 Igp7fwyu2Mfn6Tn6IvK5EostpdVnfsMZ0IWoAQbut5iLxYvP62MKRtGOlopRvf1BUsRMR
 cFvyOKCLy8ihkIkIGXzRZ7MgssxMtdzmbonpInFaSb6bbx8EZbB5pPR8mKhLm9XdF7ePf
 +vfEMmcmWFUqUhe1xUih33koIOex0YkU5kQ6z/8jUktgLmcwQ6gYZB0VDSgCLs77CkANZ
 Fup88CjJ1Fx6UPVvJ6ky/jDseJnLKrHuDQuIX+3nnxKaBsfFwa1OoXQCPWIuME5R7IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590655;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YpezrG5kNtgTOiZ1Xisv6H/SzwhdEVOA+8oec19zaw8=;
 b=XKuh7GQJrXzkVQCly05e9Ee4kBuYONDasnka9FyZZDpNza7j4db1ic7Q4AneP6t2AY3q
 u3pira7WmRp2v0BDMR96tzRgEz4vrk5nUITRy3A7rdSbq7rFOipAmsqBKomXMh7MMl1On
 P8jTPxxibxYahl4HukAqEP+aCNiFQNK+7I0tFbuoINXXpzyuxU0uFreNeBDQGIYXkBbF9
 Mjr7PWrpxAllRL0MqamTEr0mRUf+DFG0ZhWbZ2EKgqDUpyoYFhyoJ9xoLekVP9jhgrp/T
 n3Te6Gn56OHJECV00WNWkp7Mm20L6Xvq7uJry6vpSc0E7b1Cxl8s1tk0/WBAvKU8G1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="I/fU2277"; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=I/fU2277
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54A4240598
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2852EB0051B;
 Mon, 28 Sep 2026 12:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590653;
 bh=WiBOMGn64ytEJeePMUqU8pvnDGQ+p6fVdZ5oJ3x0IIQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I/fU2277YIvvRYx29qdzvISDOtEeUZ4khA4Er5LlgaFdqER9Lfflhf5nhqhiKvgIG
 4H9qzkpxwN1SEhZsoF9VsGwzrgxbul01R6yHHKmS6N7ok7+nf4n8HLfo+vSPWyUi9Y
 pdVRyukxrlQq0dtexM79A5oqJmTBDlUkqfdrc5hHG3/hPj40kGsuy/UO+tMvhXJwmm
 64SvSVCaDONhSOIE9WH1nBhh9IYL8R1wCpqx2F6XEbd/jLY614x1p9VG+hg7VUOcIO
 p33kJEPGWPXtOu9WiN0FAmLxkEY0GXRC0ORKv72LvQCfAeAZqXZATu77GW2XU5e1aM
 0fItsZuTagqJQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 10/10] board: nbxv3: apply sd1 hwconfig before MC starts
Date: Mon, 28 Sep 2026 12:13:29 +0200
Message-ID: <20260928101330.881662-11-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
References: <20260928101330.881662-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Apply this feature to the nbxv3 board too.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- New patch

 board/nxp/lx2160a/nbxv3/eth_nbxv3.c | 3 +++
 doc/README.fsl-hwconfig             | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
index a8d249c5cac..69873909733 100644
--- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -15,6 +15,7 @@
 #include <fsl-mc/fsl_mc.h>
 
 #include "carrier.h"
+#include "../serdes_split.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -34,6 +35,8 @@ void reset_phy(void)
 	 */
 	nbxv3_carrier_env_init();
 
+	lx2160a_serdes_apply_hwconfig();
+
 	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
 		mc_env_boot();
 }
diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
index 3f9d2ddad75..dab24009f0f 100644
--- a/doc/README.fsl-hwconfig
+++ b/doc/README.fsl-hwconfig
@@ -47,7 +47,8 @@ usb
 
 serdes1
 	Specific to the LX2160A boards whose reset_phy() calls
-	lx2160a_serdes_apply_hwconfig() before mc_env_boot(): lx2160aqds.
+	lx2160a_serdes_apply_hwconfig() before mc_env_boot(): lx2160aqds,
+	nbxv3.
 
 	SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
 	can still be configured before the DPAA2 management complex (MC) starts.
-- 
2.43.0

