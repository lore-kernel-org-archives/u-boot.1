Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB8C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F6E8129B;
	Thu,  6 Mar 2025 13:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="P+yKv3fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A67A480F4C; Thu,  6 Mar 2025 11:57:53 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651628122F
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 11:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=51608305cc=cheick.traore@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526AejCt011567;
 Thu, 6 Mar 2025 11:57:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 WlgpDeafdcsQESauTGLxVYWjEnZ+ivNB8Z3rngO3oT4=; b=P+yKv3famI5oYdkZ
 8GZ7QkVGCGNKWGEE1nDUHiZrxpZa2x+RF3bby8ByfDg/wtLBK+iDVJGeZUNDICAO
 Z4pUwJMFAcLL/Zpm3KGCQtEyQZZqsz9YQJzN/iGt6na1yvzU86IPM8B0ay2jmWsN
 bYuMVzWfjFgSqy3YAkt9hpVO7gqP7ssaE3qhHmemXKgHwrOaDwCm48d3HzQ0RSAI
 4ZDmEJZUbSA7ah5XDLAMbPVvRZQE1/I+A/gAxC5pnx49MCzW58fm04uBW+Hi4QTl
 64jPcd6x3NaV1220i6h+BG6jK4r28yUR1pMEbdYZFoAY3II6lifVEAynaeSxmiTt
 VV3wDA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 457a5pg4gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 11:57:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9F5F640044;
 Thu,  6 Mar 2025 11:57:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D80EC5027CA;
 Thu,  6 Mar 2025 11:56:44 +0100 (CET)
Received: from localhost (10.48.86.119) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 11:56:44 +0100
From: Cheick Traore <cheick.traore@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] dm: pwm: Check if duty_ns is lower than period_ns
Date: Thu, 6 Mar 2025 11:56:16 +0100
Message-ID: <20250306115558.1.I060a56226e03cddfd4a6d6b98bc86c91435710cc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306105620.624760-1-cheick.traore@foss.st.com>
References: <20250306105620.624760-1-cheick.traore@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.119]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Mailman-Approved-At: Thu, 06 Mar 2025 13:45:14 +0100
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

It was possible to provide a duty_ns greater than period_ns to
"pwm config" command. The framework must check the values before
providing them to drivers.

Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
---

 drivers/pwm/pwm-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-uclass.c b/drivers/pwm/pwm-uclass.c
index 6543db1d623..b4491f7dcd4 100644
--- a/drivers/pwm/pwm-uclass.c
+++ b/drivers/pwm/pwm-uclass.c
@@ -27,6 +27,9 @@ int pwm_set_config(struct udevice *dev, uint channel, uint period_ns,
 	if (!ops->set_config)
 		return -ENOSYS;
 
+	if (duty_ns > period_ns)
+		return -EINVAL;
+
 	return ops->set_config(dev, channel, period_ns, duty_ns);
 }
 
-- 
2.34.1

