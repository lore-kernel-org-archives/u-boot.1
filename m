Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF5C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FBA875A7;
	Wed, 29 Nov 2023 13:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TGfVRv2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67BD88706B; Wed, 29 Nov 2023 13:38:02 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB60687136
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 13:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0697bfc697=etienne.carriere@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AT997v4030936; Wed, 29 Nov 2023 13:37:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=hEqOF7ItJgIzC3xqosPW00RZLZ/IFBj5P9Fod2zj7Qo=; b=TG
 fVRv2zyeHdo0fsIRkUKBIH0u9e/c3f1IdYZy6sGtYSVs6Efy3MfXf8dR1wH2rwLP
 HPFJsY5STHRwPlm+XJH49RXmSQt/mQypWW6vjlVKMwEtYTgsWaO0SFKzUCnuYQSW
 l+ue99bhl4MuOYhMx0fiR8hXRobT6WdfYGUsy/k5BOjjxAbCmKEDiHT7W1RDjQjA
 GvJmgDMEOKPUmbbH0Vr56B8bNnUTVs61PBh2gAd5Q0tqhiOqkvCyEg+0GSDjdBB3
 XXZeiwrmojlAEMfEBFgyazN3Q1/T+2+N4Z4XMmhzYopvfeMlMOWh6GoSJduuoM2B
 yy9sY30yXxyJofzUH1ZA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk952185n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 13:37:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20C3A10005A;
 Wed, 29 Nov 2023 13:37:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A07921B524;
 Wed, 29 Nov 2023 13:37:57 +0100 (CET)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 29 Nov
 2023 13:37:56 +0100
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Jens Wiklander <jens.wiklander@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Etienne Carriere
 <etienne.carriere@foss.st.com>
Subject: [PATCH 2/2] tee: optee: don't enumerate services if there ain't any
Date: Wed, 29 Nov 2023 13:37:53 +0100
Message-ID: <20231129123753.1906956-2-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
References: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
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

Change optee driver service enumeration to not enumerate (and
allocate a zero sized shared memory buffer) when OP-TEE
reports that there is no service to enumerate.

This change fixes an existing issue that occurs when the such zero
sized shared memory buffer allocated from malloc() has a physical
address of offset 0 of a physical 4kB page. In such case, OP-TEE
secure world refuses to register the zero-sized shared memory
area and makes U-Boot optee service enumeration to fail.

Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/tee/optee/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5308dd58ce..47f845cffe 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -139,6 +139,11 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
 	if (ret)
 		return ret;
 
+	if (!shm_size) {
+		*count = 0;
+		return 0;
+	}
+
 	ret = tee_shm_alloc(dev, shm_size, 0, shm);
 	if (ret) {
 		dev_err(dev, "Failed to allocated shared memory: %d\n", ret);
@@ -185,14 +190,15 @@ static int bind_service_drivers(struct udevice *dev)
 
 	ret = enum_services(dev, &service_list, &service_count, tee_sess,
 			    PTA_CMD_GET_DEVICES);
-	if (!ret)
+	if (!ret && service_count)
 		ret = bind_service_list(dev, service_list, service_count);
 
 	tee_shm_free(service_list);
+	service_list = NULL;
 
 	ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
 			     PTA_CMD_GET_DEVICES_SUPP);
-	if (!ret2)
+	if (!ret2 && service_count)
 		ret2 = bind_service_list(dev, service_list, service_count);
 
 	tee_shm_free(service_list);
-- 
2.25.1

