Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFA5C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8006D87136;
	Wed, 29 Nov 2023 13:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bXIiJueS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D86A587497; Wed, 29 Nov 2023 13:38:00 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321E08706B
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 13:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0697bfc697=etienne.carriere@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3ATAIMYJ005577; Wed, 29 Nov 2023 13:37:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=Rht9mRp
 RqftRkcvjT6lthyWZlm1ao3/SHs6fF+lkx7U=; b=bXIiJueSOkX6acrAQmlrG4C
 NyHeTDDwAK4yaXZXce4jKYJJcbV3xVBRd88A04xotUDykJxx6dZTelclXU/pv9V5
 vCFsknfsY2G+cZO7C4c22DUcXeWi2OJbgVWWSU/No3hTY4Jo/Czz9giCzgvI/4Hu
 VgIDd/IuXS4JRvema0F1rSBLt+oWUAceRGzXHopleeFEoDSdLVMtl9MI8mC7nYLT
 NYRgMU0e/2R2BLfQK0t7IYDgJINFvDPptyVD//bVIz7AmhLGAOjgWMSqWZ5TbQY0
 nXdfhUbHF5a6nJTWhmuJdccmEG42ugE/4joWAIfI+M2566Ma1Y5cUeK3paKEdLg=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3unxcj20fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 13:37:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F1E210002A;
 Wed, 29 Nov 2023 13:37:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 436D221B524;
 Wed, 29 Nov 2023 13:37:56 +0100 (CET)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 29 Nov
 2023 13:37:55 +0100
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Jens Wiklander <jens.wiklander@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Etienne Carriere
 <etienne.carriere@foss.st.com>
Subject: [PATCH 1/2] tee: optee: don't fail on services enumeration failure
Date: Wed, 29 Nov 2023 13:37:52 +0100
Message-ID: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
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

Change optee probe function to only warn when service enumeration
sequence fails instead of reporting an optee driver probe failure.
Indeed U-Boot can still use OP-TEE even if some OP-TEE services are
not discovered.

Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/tee/optee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 9a9b697e91..5308dd58ce 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -841,7 +841,7 @@ static int optee_probe(struct udevice *dev)
 	if (IS_ENABLED(CONFIG_OPTEE_SERVICE_DISCOVERY)) {
 		ret = bind_service_drivers(dev);
 		if (ret)
-			return ret;
+			dev_warn(dev, "optee service enumeration failed: %d\n", ret);
 	} else if (IS_ENABLED(CONFIG_RNG_OPTEE)) {
 		/*
 		 * Discovery of TAs on the TEE bus is not supported in U-Boot:
-- 
2.25.1

