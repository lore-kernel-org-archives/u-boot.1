Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF88C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D8283447;
	Fri, 23 May 2025 18:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TsaDdL4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F208324C; Fri, 23 May 2025 11:48:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AD8830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7238a91f03=antonio.borneo@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N822O8022871;
 Fri, 23 May 2025 11:48:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 +RcbzCogerlOEpMRKpTvwg0vOxTcvBbVUSoSfjfiMwg=; b=TsaDdL4gTEE67DNf
 5mnEzfwMkbcqlvm6imCguF9NP8TwbS8zLngKXAqzUV5OKoDLiHDX3JanLMKwpznj
 EN+43M3iuH1aDXKY9HYCA3wkxHO41Ml88n7h+vpfsjr2gKF4cI7iU6WCmPBDvBTw
 r5Q74GRLAtOx/QE7QKegnRRRUmn7hg2sfBj+mfpd6EKF+WLBxrsrZmvfTdg3YgAg
 Z+0+zlfiIWfMHtRhIXGyZa80GV9J2k/3NE8zz9Q6A9zCUg+zRzydYsruyU6KBaZP
 54lQjVNg9aSm4ajUmpjHP7d1Z3o4hMCLoDlYlL1SxgZrL/Yvty1huXi2H4oBZC+l
 q/CvMQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwf4dgq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 11:48:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3D2B84004D;
 Fri, 23 May 2025 11:47:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D106ADC0CA;
 Fri, 23 May 2025 11:47:12 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 11:47:12 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
 <clement.legoffic@foss.st.com>
Subject: [PATCH v2 2/4] watchdog: arm_smc_wdt: get wdt status through
 SMCWD_GET_TIMELEFT
Date: Fri, 23 May 2025 11:46:56 +0200
Message-ID: <20250523094658.299730-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521122755.265760-1-antonio.borneo@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.132]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Mailman-Approved-At: Fri, 23 May 2025 18:55:43 +0200
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

