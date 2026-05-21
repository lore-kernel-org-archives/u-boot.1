Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEB7CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 520FD84867;
	Thu, 21 May 2026 17:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="s42dVpme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22EF7844CF; Thu, 21 May 2026 15:54:53 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5E2846FD
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9nTLR602487; Thu, 21 May 2026 09:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=lL+uH
 HGtLqZrmHkRhnRA5B5XN9OUncdlzWnc25peTo0=; b=s42dVpmed9hwcFF2aOlrY
 DOUbISComkQpK2HvK41ScjBz6TrB4FYbyBwhB0/KleMGPJHi11RlFxREaktoWs0W
 xHcGl59/BznRcFgzYX11jRsbjZiQqCE6LiJhOteTYcOLNY7N5miiaoRlN73pfdA8
 MQ02LckODrSwdFC8hqE5i91pDJOSNFE1CgXm9VJwWTa3nTFSS/MxNmLoZ6IcPpFy
 M2lD7rrWpB3qC1KVSydW6BjYpZo3bk2IM8ZEXdXUYYQWaF2SRow2Y++oAsXtONmQ
 x8JyTqBhhFwJ0osGF/3sto4iF/2BU5a13h2HLarW08/S3C+r6L9Xyhkjf9TO8+0N
 A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e96srxa7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsjjo046939
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:45 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqq016286;
 Thu, 21 May 2026 09:54:38 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>, Ozan Durgut
 <ozndrgt@gmail.com>, Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v6 14/16] arm: sc5xx: add missing boot env selectors
Date: Thu, 21 May 2026 09:53:25 -0400
Message-ID: <e4b7a0e4af178e39a1840eb820e9fd27d0d97e66.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Ap_9PRbW-Q4w-tWtT0-eBql1Fr8cQj3B
X-Proofpoint-GUID: Ap_9PRbW-Q4w-tWtT0-eBql1Fr8cQj3B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX6jMb3Vhcw5PM
 9dqa+ZUF467NTbGUfflOz55QF4gvh7rRoCOcohBnA6twrUTxs/BgAivY0Y1Wk4yIQAe/tSUDgCE
 xC/e+cLt0xe2HIlC1pL2DSOINrRMm+J1cDW0aG+zGlXczoSf+hq7XQwhsol0vF/iSETr+JiN6CI
 RAWNX/bPcb/JVY7awiO37EE0weTiziuyLYlcO2r0M16z0S2gc7DLdaXvLbbS5VGrCnWgtGM6/N1
 qQL1QQVS3RDfp0eqQrqCuBJgZNcdM/OMIN/eF//OBv94F9vh71ynuJJzWYwNtyJR4sLk0u9MUh3
 3JcSi0fzKHRePbXp4u7em9KzJ7JGzuPpFWRHSKjuTABe6FDEFH7ryCqbovL6gz5Jdg8ilxFc0+2
 62cBLU6q1YXJrgdbikinYrOKOV4FDLrwbZjgRXO8HMSBD23+8dMEGGvFw3rfWa0nPNi4V9pE8fD
 mqR2oubUYAg3bu7frlQ==
X-Authority-Analysis: v=2.4 cv=CZs4Irrl c=1 sm=1 tr=0 ts=6a0f0ea6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=5ZdL69oFoyqz5cmp9P4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210140
X-Mailman-Approved-At: Thu, 21 May 2026 17:19:00 +0200
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

From: Ozan Durgut <ozndrgt@gmail.com>

Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
environment includes the expected boot commands for this board.

SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
environment, but it does not define any of the USE_* boot mode selectors.
Without those selectors, the shared env does not generate the board boot
commands such as `spiboot`. This leaves the default `bootcmd=run spiboot`
without a matching environment command and breaks autoboot.

Fixes: c9e893d6266d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index fbb0565dac4..ab1acabef53 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,5 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
-- 
2.34.1

