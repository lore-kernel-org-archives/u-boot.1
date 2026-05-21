Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5597CCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD85F847B0;
	Thu, 21 May 2026 17:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="cuEWuR0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7938846DD; Thu, 21 May 2026 15:54:48 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED864846BD
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LD2gbV416785; Thu, 21 May 2026 09:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=DKwEf
 TLRPmNcEacbAgVnqmtASmh5r5jM1V/wY8YbN7U=; b=cuEWuR0lIPXCiKFaglevt
 hRVUbQ66cEOVnbDGRL4S2jzk2SP/S+kdzS3kvW4IF+kJBuPNOvXwDybgHO6ZrhT6
 Kigmqw2zX5e4N6ZPiaOFsPBULzTxW+SKGJh3LLLa0XVn6ONE8y0UEREmVRyyzPZi
 yE7/F9ajQoBoSrmIcM6eCwPJGNyJKMBUn1sFV0+yUD53qwnocpKD62ym7rmzvhIN
 fMQ26b9GMea2SMk4lcRAb4hWoDBKCGW9VL1J7KOJ5Xp+7iK6tdGXMVO47KAC/MIv
 Y34ZoaBOMsdE3ZDV4XohPYL8MJYdVFuxO8AEmHbPRC58PDWD6OyLF2emjLWCrquI
 Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wvkpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsecY046906
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 09:54:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:40 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqj016286;
 Thu, 21 May 2026 09:54:36 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 07/16] mach-sc5xx: Remove preliminary binman support
Date: Thu, 21 May 2026 09:53:18 -0400
Message-ID: <845c5c691f6e1422beabf5337b790785615d2822.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: v_IGMZyO_odk4XbXiNP61pkAu-IV4QGi
X-Proofpoint-ORIG-GUID: v_IGMZyO_odk4XbXiNP61pkAu-IV4QGi
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0f0ea1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=XKbAumcG4DyZrKi18ZMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfXzTHa8iZuaFi/
 PeiE8N6llBtFyjwFqyxrLRHFxU0nh8J38uPT0/zLwhSqU6AVuUKyvex2gTRX4/MFg+DjoIKXWuR
 PwwQh2jKmlosaXy+UGxPuw0UdNu7UHNy/I/AYQT4i/QUwZQ8LL38KHyBhZLyyKPvWZnEcZcR7mH
 Yht2vlbTLo8Dmb2NK2zhd+B+CTfTDJ6VUKHRzdbz5wZlEkjbeIgQdF/2mfJGAlkra755fhK90lN
 /LLDreWQEYGm+kFw/s3glU6uuUpqzOlsczWGB0MCoQ7Yf+Ld7Izz9YWZhdGlmLh8yFie7Aq27sD
 1fyt2pODxdkp601JURJzsqIOwkTIsw/wQeSs+uG3fxRKHZsRehykN2AvRZ4l4Qbdl/3zQUUEEnz
 i3RWy5dN85bGXVmQTJBeACZteS66G5jSBq60+IlO//6ZeqoOaGVIzzB6nLVRvoLrE/QPzASXFcs
 XkOZkV9Wrbns6DsMXJw==
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

Remove preliminary binman support from all sc5xx ADSP boards.
Full support was never added because it was unused.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc5xx.dtsi     | 41 -------------------------------------
 arch/arm/mach-sc5xx/Kconfig | 33 -----------------------------
 2 files changed, 74 deletions(-)

diff --git a/arch/arm/dts/sc5xx.dtsi b/arch/arm/dts/sc5xx.dtsi
index 9d346ae62e0..072631e34f7 100644
--- a/arch/arm/dts/sc5xx.dtsi
+++ b/arch/arm/dts/sc5xx.dtsi
@@ -25,47 +25,6 @@
 		bootph-pre-ram;
 	};
 
-#ifdef CONFIG_SC5XX_USE_BINMAN
-	binman {
-		filename = CONFIG_SC5XX_BINMAN_FILENAME;
-		stage1-boot {
-			offset = <CONFIG_SC5XX_UBOOT_SPL_OFFSET>;
-			type = "blob-ext";
-			filename = "spl/u-boot-spl.ldr";
-		};
-
-		/* since falcon mode can jump from SPL to OS directly
-		 * full u-boot is optional
-		 *
-		 * @todo: review if we can say this given support has
-		 * not yet been upstreamed. Otherwise we might have to
-		 * invoke binman only for full u-boot.
-		 */
-		stage2-boot {
-			offset = <CONFIG_SC5XX_UBOOT_OFFSET>;
-			type = "blob-ext";
-			filename = "u-boot.ldr";
-			optional;
-		};
-
-#ifdef CONFIG_SC5XX_FITIMAGE_NAME
-		fitImage {
-			offset = <CONFIG_SC5XX_FITIMAGE_OFFSET>;
-			type = "blob-ext";
-			filename = CONFIG_SC5XX_FITIMAGE_NAME;
-		};
-#endif
-
-#ifdef CONFIG_SC5XX_ROOTFS_NAME
-		rfs {
-			offset = <CONFIG_SC5XX_ROOTFS_OFFSET>;
-			type = "blob-ext";
-			filename = CONFIG_SC5XX_ROOTFS_NAME;
-		};
-#endif
-	};
-#endif
-
 	clocks {
 		dummy: dummy {
 			compatible = "fixed-clock";
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index cfa7ed46a82..70fab57fb3c 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -146,39 +146,6 @@ config SC5XX_LOADADDR
 	help
 	  The default load address for u-boot.
 
-menu "Binman configuration"
-config SC5XX_USE_BINMAN
-	bool "Use binman for final image"
-	select BINMAN
-	help
-	  If you wish to use binman to assemble an image, say 'Y' here.
-	  This will enable binman-specific sections in the device tree.
-
-config SC5XX_BINMAN_FILENAME
-	string "Image name"
-	default "sc5xx-image.img"
-	depends on SC5XX_USE_BINMAN
-	help
-	  The name of the image that will be created by binman.
-	  This is used to create the final image.
-
-config SC5XX_FITIMAGE_NAME
-	string "FitImage name"
-	default "fitImage"
-	depends on SC5XX_USE_BINMAN
-	help
-	  The name of the fitImage to be packed by binman.
-	  This is used to create the final image.
-
-config SC5XX_ROOTFS_NAME
-	string "RootFS name"
-	default "rootfs"
-	depends on SC5XX_USE_BINMAN
-	help
-	  The name of the rootfs to be packed by binman.
-	  This is used to create the final image.
-endmenu
-
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
-- 
2.34.1

