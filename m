Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAB9CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C02A78483C;
	Thu, 21 May 2026 17:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="HmFqakKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98237846F9; Thu, 21 May 2026 15:54:50 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503E38469F
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9lQBu1703738; Thu, 21 May 2026 09:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=J8NRm
 3YrEjDLFFfzPPI01RQUJSMTsuGi9Nf2paJTaO4=; b=HmFqakKeYdIKx+D+/E1KD
 hlmDFOta6xDwjVjwRBlQjl3lFjtsaDg5xaywsckl3cNylw6ahUl+Wgs3AKnxdaoz
 UI038UvxOikBzQq5Nh4KjiSxO33RBIzrI8xzQjNzXklpvmwCGvyW8xRcftgBFost
 8wMXLAfs65AqRjLUNbUbXouS/Ol/u/GZO9NzNNvP79CVaYDYReBWjGoeTCwJxfEZ
 pemAyPxEX5dKXH6hlh4AtmImKCJBRV99Io1HQyP6nx3SaIKohoMcXanyY+UL9qJ/
 o67D1Mt0G5xkYjE2Uo8OnHu8dIo6TYzXxhidzTRSc9rymx6LzMd50hrUzeSQokAp
 g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9701eb88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsgPs046924
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 09:54:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:42 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqo016286;
 Thu, 21 May 2026 09:54:37 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 12/16] configs: sc5xx: Set default bootcmd to SPI boot
Date: Thu, 21 May 2026 09:53:23 -0400
Message-ID: <999e463b249df772a40ecd54e050eba2c449b33e.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX+ZsuFS/TaL4N
 xyK92jHF+M+W1j0RBTlE2vq126B+oerQNPJTYcarI+DbJm6NvAfhvPZCJzrbuxz+ZEQNBiKTzKs
 vvs5ixxdvDKid6XtdY6imVIPvP/Zue/JT7qIsnffI+USYnrikHZNCRWrNCUqWURbaexWGUNp2ha
 LCl4RLiCtrML3ixVTICuePjiV6KInmsMS5AYsoSacV45JMAXUCLTW6BeQOii+3bG7YsA267JbAk
 kkkt3PNCJDnOuOrcIm0JdddBV8yZrew5IZ8BScVRQjJJYBTrx9HBPqTkQGGW/XikVIs2c1qcwNV
 zZAoeiDaY5VHvGoPQA7mrerWjgK0cbRYHCKXOchUOHGIxjiq3WAAGiVjx8vRyNILU5wYq2Mc7Ia
 s7FV4oip/XtlFACLrXmwRm4rSsG4bg8CxFfnuDRPkj5yAoyDrI/vJx1XEE6yKJfKcdykhY0GJAL
 S4V4Xl1M97tCbVQakSg==
X-Authority-Analysis: v=2.4 cv=CsaPtH4D c=1 sm=1 tr=0 ts=6a0f0ea3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=lG2YbQWnQj7LxBth62EA:9
X-Proofpoint-ORIG-GUID: CBlNaCsbGAKuMYwydA-70rmGbU3qR_yl
X-Proofpoint-GUID: CBlNaCsbGAKuMYwydA-70rmGbU3qR_yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
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

Align configs to use the same default bootcommand. With the environment
no longer stored in the SPI, SPI boot is the intended default boot
method for all sc5xx platforms, with the exception of the sc573, and the
sc584.

The sc59x boards, the sc594 and the sc598, additionally have the option
of using OSPI for boot, but the default boot method for these boards is
still SPI.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc589-ezkit_defconfig          | 2 +-
 configs/sc589-mini_defconfig           | 2 +-
 configs/sc594-som-ezkit-spl_defconfig  | 2 +-
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index a249fe8df7b..d8982f62d82 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -22,7 +22,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 25285695367..78b39b6dd73 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -20,7 +20,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index 89ef08c1a72..23951d0b5f1 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -15,7 +15,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 9e907d31136..b4e71b5d2eb 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 CONFIG_SPL_I2C=y
-- 
2.34.1

