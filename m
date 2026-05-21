Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09F5CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7BB847E8;
	Thu, 21 May 2026 17:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="seib/fOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC02B846BD; Thu, 21 May 2026 15:54:48 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EDF846E2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L8TlRm263030; Thu, 21 May 2026 09:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=fcIWc
 bkoRP9ZPTxrSwz7VVC95b40k6o3IPuqBUR9nJc=; b=seib/fOkR1N7BoQ8tbsP3
 LNr5ZQCjDfCNC7rVD4PCD7mSWSIdvsZgPpblFXFqSpuFFLFAtPwsxBijGiKesIl+
 khkaBnPyTFpIsUf/neHvDqNvN4RLezS3shZwqHLk9uIPaptoE8KJqtyF4VFIih1A
 bBO5UaylgxlMEC5UBJAvd/kz4sHTre3VHxtBBspZk1+BKZ40N6CDNgKnG2qfvOdc
 v1A3NZCYW6vSprk5yAZti5HVJlMhmYft8/A8Aqbif2QMfrwcjzrjxdhoviZTyoJU
 KVh/dUwphMG5B9o65JGyW0syj1dUYwCB5Njvwg6O7rRW35lRR0twJQFJq+5Pa2El
 g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e95e2ek4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsfe3046918
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 09:54:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:41 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqf016286;
 Thu, 21 May 2026 09:54:34 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 03/16] mach-sc59x: Add CONFIG_SC5XX_LOADADDR
Date: Thu, 21 May 2026 09:53:14 -0400
Message-ID: <c4bd20940038e16b746737046044db74d3a83658.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4Tf-aQA9XVa2kx497q-M_fm86WygPCzS
X-Authority-Analysis: v=2.4 cv=Fd0HAp+6 c=1 sm=1 tr=0 ts=6a0f0ea2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=EXzWB5GfX3S1BOBHpcQA:9
X-Proofpoint-GUID: 4Tf-aQA9XVa2kx497q-M_fm86WygPCzS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX7uzvv34vR5dp
 CQJFBpNLBvVZ7HWiMSsBK6syX6bMecZXtaYlpw2JP/xVIPBf7dT6zCr4KYB/oiihzFWkY++StVF
 fmHAkvybNi53/MZSz5uF+MO1OKuzFvFUfPk7f/AR1RezyXOWD/Rqg7KPJw1X8rTuZvWXYr0MgDX
 fOgwrps77e+p2b2T2pLN08lgkMDVA8nY8VXeBmzHIN1znxa5602ARk7Bn/uvKbHXaJsk7Ysj6Eb
 BG5xuMXpg6yw2GAsK29TeDFFL2bSbvouNdD6en/e5O+D/XvkbqC2gNkqYOyPGIClty4KLnLI/ZM
 4bI9LFqUCQCaJxUlaxJrUf62Bw3MG+GmpUIFF5dT5HmSOlt9EGlqHS8aoiwYZVt5LMCw58QPoUN
 wmOoyeY7OMvxWtPW7ulW7h8v5z4MM2SvZazaaBjTxZv6q4yExVvd4IAe3+E+E/qB/PgQNbXtjJv
 aSKtqJJlM9Evqciw5CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Add CONFIG_SC5XX_LOADADDR to the sc59x family of
boards to set the default load address for the
loaded fit image. This value is autopopulated into
the environment variable loadaddr.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc594-som-ezkit-spl_defconfig  | 1 +
 configs/sc594-som-ezlite-spl_defconfig | 1 +
 configs/sc598-som-ezkit-spl_defconfig  | 1 +
 configs/sc598-som-ezlite-spl_defconfig | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index c379de2c146..89ef08c1a72 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -74,3 +74,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
+CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 54b26ed85c2..9e907d31136 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -83,3 +83,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index 98256517b87..cd1bafd7486 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -107,3 +107,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0x90000000
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 1c4f9309daa..e4a975eedfc 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -105,3 +105,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0x90000000
-- 
2.34.1

