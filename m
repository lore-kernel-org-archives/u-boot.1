Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C39C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D271C82F30;
	Wed, 21 May 2025 14:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hoNgdCSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BFC82E2D; Wed, 21 May 2025 14:29:12 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6525182E31
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 14:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7236647066=antonio.borneo@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L827BX010857;
 Wed, 21 May 2025 14:29:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 +RcbzCogerlOEpMRKpTvwg0vOxTcvBbVUSoSfjfiMwg=; b=hoNgdCScR6nrWmV3
 +Yff+RuWhQI4kit98fUjPCFDvJoAhHY/u6s+H9n9n/Z7oXisTJ1ywb0fTJhSpk0N
 JsCT+r8JxX+jGnKCIlQZIqPx16/VbmHO1Q1yQR6pgQYD1M1sMHzfiuVWpuxH8EmG
 P3vTvOkb1LCPxNPp/xJzndNrMZ9GbPNBq6qSVh+CNQ09epjRWdruqP9HL8AEnp5e
 nA83tVKIvAoXZN8qKLKsP0UMQvAK8QTiVjUDaFCzyMgj6DzUc9hXcM4m41WZ167K
 R92rWFoPOf2NwQCh5qDenanTRvmAnYwNvsOwlvP1cJMCDBW8qKzw4qHU10kUq5nA
 mgmcfg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfc3wjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 14:29:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1113B4004F;
 Wed, 21 May 2025 14:28:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 65059BDE7AD;
 Wed, 21 May 2025 14:28:11 +0200 (CEST)
Received: from localhost (10.252.16.84) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 14:28:11 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
 <clement.legoffic@foss.st.com>
Subject: [PATCH 2/4] watchdog: arm_smc_wdt: get wdt status through
 SMCWD_GET_TIMELEFT
Date: Wed, 21 May 2025 14:27:53 +0200
Message-ID: <20250521122755.265760-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521122755.265760-1-antonio.borneo@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.16.84]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:09 +0200
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

The optional SMCWD_GET_TIMELEFT command can be used to detect if
the watchdog has already been started.
See the implementation in OP-TEE secure OS [1].

At probe time, check if the watchdog is already started and then
call wdt_set_force_autostart(). This will keep U-Boot pinging the
watchdog even when the property 'u-boot,noautostart' is present.

Link: https://github.com/OP-TEE/optee_os/commit/a7f2d4bd8632 [1]

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/arm_smc_wdt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/watchdog/arm_smc_wdt.c b/drivers/watchdog/arm_smc_wdt.c
index 0ea44445700..f6854aa9ac9 100644
--- a/drivers/watchdog/arm_smc_wdt.c
+++ b/drivers/watchdog/arm_smc_wdt.c
@@ -46,6 +46,8 @@ static int smcwd_call(struct udevice *dev, enum smcwd_call call,
 		return -ENODEV;
 	if (res->a0 == PSCI_RET_INVALID_PARAMS)
 		return -EINVAL;
+	if (res->a0 == PSCI_RET_DISABLED)
+		return -ENODATA;
 	if (res->a0 != PSCI_RET_SUCCESS)
 		return -EIO;
 
@@ -99,6 +101,21 @@ static int smcwd_probe(struct udevice *dev)
 	priv->min_timeout = res.a1;
 	priv->max_timeout = res.a2;
 
+	/* If already started, then force u-boot to use it */
+	err = smcwd_call(dev, SMCWD_GET_TIMELEFT, 0, NULL);
+	switch (err) {
+	case 0:
+		dev_dbg(dev, "Already started\n");
+		wdt_set_force_autostart(dev);
+		break;
+	case -ENODATA:
+		dev_dbg(dev, "Not already started\n");
+		break;
+	default:
+		/* Optional SMCWD_GET_TIMELEFT not implemented */
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

