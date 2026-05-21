Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D15CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489DE8484F;
	Thu, 21 May 2026 17:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="wQdf2zYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA36844CF; Thu, 21 May 2026 15:54:51 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DBC844CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LDj8Nd417075; Thu, 21 May 2026 09:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=bMtHE
 znGqjZWiEc/CtI/iZjiis2N+yUIqPeh0dMuVtA=; b=wQdf2zYYTo57UZVgllDYM
 U68F9pVjJ1vOQN+L1sNEe0pbWh65OG2NCduYVQOlirRbWzSIfJ3PgS6EosKlBVRD
 BhCBBVYqkCVUJCvSL3cNP50M2xd5thwC9i4Syq6RizJYSe1DY5dOsc7KNEinT+rL
 pcFqDNzSEI9Q50SUPmgzVQWqOA01joVM8KGZIomf+REs9x+nBClV4cfRcBR9IapR
 ZTrq8XqRRrux0dQLmyxkzOjvvlBD33nbaZcypRk0NhQHo2uwgWcQiQ5a18W/TgNg
 4c+1XpmLPKSvVSb573H8rynCvad/4EGAJ+pyxXdIkGEB9HiRMZXvMsfFkRRriPVk
 A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wvkq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsiVv046930
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:44 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:44 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqn016286;
 Thu, 21 May 2026 09:54:37 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 11/16] mach-sc5xx: Update SPI bootargs for ubifs
Date: Thu, 21 May 2026 09:53:22 -0400
Message-ID: <34ed2aba407d3c393ac99a8930b0bf6ba6b20ec0.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: qo_pOzh8B4S4wCwBC9Ymq3PVx2weAasz
X-Proofpoint-ORIG-GUID: qo_pOzh8B4S4wCwBC9Ymq3PVx2weAasz
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0f0ea5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=A-jwrmUu0vru52BW3FgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX87C+pcOW/Rcs
 xBLscKgpG34fQ6eqS7F1YLn8rxKvl2PR0P3fjDgnUpSqDXXVY3aY3AF9sDZgFkhKU0iiwlSQbX4
 l+7cpBLHSbdBvujjmIJGVVNItU8QECHJGJWlcQ6zZ/ln/5wucdjpmPEEjKm7r90ZQVZrmbqUuxH
 i+k9TlVi0kyh+ddP3T9vShitbsRsBmsem/eYCxintCR3IEVqFcmWZxkSKWmPoJ0jq1Nxvlc5LkJ
 SoJDfak48anbUcZMmzKuQ1TYYugvvj8ZpjACsSvuJZiD+A5zPf2rdZtML6T4Vo+LePUheAhfmbP
 NE27aRzpwenD1CZ4n++LHfuGFuMctadTr05k+UNYdxnlVDD8GVApORB0rNpHUEYtI+AYgUEPncw
 KxiJeWPnsOK5yXTfQLYiNeR3jnASjSkufvtfnW4xEsoyadeEukHqt/+BgueZ27p0BpsLKBUYhH8
 jWATGtw3agv1sx+9xog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210140
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

Update the bootargs used in SPI/OSPI bootmode
to reflect change from jffs2 to ubifs for the
SPI's filesystem, and remove the jffs2file variable
from the environment as it is now unused.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 include/env/adi/adi_boot.env | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index 00757fe7c99..b75baabdca6 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -47,7 +47,7 @@ mmcboot=mmc rescan;
 #endif
 
 #if defined(USE_SPI)
-spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
+spiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
 spiboot=run spiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xf00000;
@@ -55,7 +55,7 @@ spiboot=run spiargs;
 #endif
 
 #if defined(USE_OSPI)
-ospiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
+ospiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
 ospiboot=run ospiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xf00000;
-- 
2.34.1

