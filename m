Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0096DE67493
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 10:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFB0895AF;
	Tue,  3 Dec 2024 11:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="eXHpse6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A8F88E32; Tue,  3 Dec 2024 11:10:35 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E45895AF
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 11:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2067566437=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37eLis023399;
 Tue, 3 Dec 2024 11:10:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 VgsGTq4f8/AZSroMeDtF1lp7HfSG253czErrSYy2/hI=; b=eXHpse6O4z0RAPnC
 UQ0zuNQMQGi4hu3QEtnmP7sKEGZYuZrDrN3oCpjItpCUcIQs7gqvcYV++agCUbqF
 7asJP/DdX78Cz/18nSW6SB1JUrPqaprG+SgzA5FLqfL8GfWQz1HITiJLGZa6k8jC
 HEE+k90gc1eTGgTDdVcJFSnqKXdcrikFNXPp3fmyhOw8ZfF9hAPE3EY2czg5JGTR
 rFrmc2QEVVv1i6A2uxV/hgmU6NT+xQ0602N4cKcZStbL6IY50s2E4OQVRLlRfNNM
 pUCyl+L7G96XPfB89a03Ea9iGj+cl+TKJpGgxskzAYvRP415zlCFFtn1Qhx0LerK
 cDs9Rw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437tfgc807-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Dec 2024 11:10:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2E7CB4005E;
 Tue,  3 Dec 2024 11:09:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7B04267CB3;
 Tue,  3 Dec 2024 11:06:14 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Dec
 2024 11:06:14 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>, Marek Vasut
 <marex@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] power: regulator: replace dev_dbg() by dev_err() in
 regulator_post_bind()
Date: Tue, 3 Dec 2024 11:06:11 +0100
Message-ID: <20241203100611.354468-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203100611.354468-1-patrice.chotard@foss.st.com>
References: <20241203100611.354468-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

To ease debugging, use dev_err() instead of dev_dbg() for
alerting when regulator has nonunique value.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
  - split initial patch into 2 commits to separate dev_dbg() and
    dev_err() migration.

 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 80ea5e65d48..09567eb9dbb 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -446,7 +446,7 @@ static int regulator_post_bind(struct udevice *dev)
 	}
 
 	if (!regulator_name_is_unique(dev, uc_pdata->name)) {
-		dev_dbg(dev, "'%s' has nonunique value: '%s\n",
+		dev_err(dev, "'%s' has nonunique value: '%s\n",
 			property, uc_pdata->name);
 		return -EINVAL;
 	}
-- 
2.25.1

