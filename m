Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01B2CD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCCC849EE;
	Fri, 19 Jun 2026 13:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ID1fyDtp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZbQ4POB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E77E849EB; Fri, 19 Jun 2026 13:11:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3168847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7Q8Vc4184989
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qlcxa3UGWsPcmKkaLY7AI2zXBeYfcrlZRe57XZc4fDc=; b=ID1fyDtpjinruHcL
 Oekq+dVCDwoiuICAFTBBYmnqFR+IKfEOCzbySe0n+Z5SFZl8S0zX7DdSzAPFLdIO
 ITH7AF/tWGvSN1HgkiyWxSG6JkeMppX1MWZMAiMc+CbI2mFhhZMCQW4f0tP4MoXJ
 mn7Y8LSKDjorgl/IPAsLOMUtWtKUxrVdc3jEYMQiF9xf8vHKXcBMvaadM+S9Ewn+
 P9MuTL6WU81us7CanaRDo5tCMxYbzL3ldLsuz95wnflEVH/CdfkijDY9cdgKxITk
 H9wS+GLgVl5z1QfM7LzR9J8RROBL13NGE5vodmP9ySnEWglleY0+ZmuenNOZeIAE
 km0t5w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sb1xr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so39023535ad.3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867473; x=1782472273; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qlcxa3UGWsPcmKkaLY7AI2zXBeYfcrlZRe57XZc4fDc=;
 b=LZbQ4POBSGro65A9g7UU3YmT0mkJ3li9cDPHzARv9eSdV6vkMugCxNd/C0SEvHstoj
 EmacNodvQ59s8wctmnOhGfTPhMVw2QPMFxoS1CGJM/UPZ10PCAg6o+IowdEEbt70BaO3
 BwF1L9r9mgLKMk04WbI/E1GrdT3WTsk1BOg4L7xKkJrXXsYJqy4ks8Ux1nLdBDT9a7gC
 JBm8HbMbwKEsio2IbANe5puHlwvKpXlMA1ZlotEfBTP/xSefMivbHoqvZSy5SPDYDv0E
 N933N8mXNV18rjCk9TEXlF5pamVefHqNmj4YvXDEVtz1g82jzaZgiKZUzGD5R7q4JQ7J
 f8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867473; x=1782472273;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qlcxa3UGWsPcmKkaLY7AI2zXBeYfcrlZRe57XZc4fDc=;
 b=sNbwWkwG5FKEpvyJSliUajiUbZBhRjOHZT4mIMHhfOiBrpBMF29NuZt2alBC217v2/
 YbEMROUeAUFJXgGxgPRzNtiYEVvmqCxa/IHRdvYH4L1sda8TmhBv26JZAFbD1rbjjjse
 bs/1M2YkhevfF5N9QXuRqu48CTCsRapZSSYEZHrQlsEjDudjloL0XQte51w0p8KkMBH2
 A33H8IvRrxS75mf6qQmlTKY029PnVkrWYaE1HoHeQQkH7/iZ7k6arKHr6eT1x+fi/nqj
 QEOW/mTnG8tqfnWR9/sakaqXHIlaO/NJpAyshsUfg8qwJ4ULG3LiOhmhqrym/wDcOgAr
 kgWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WtPH+ALZQfGMaTvCveUkQfIbC7oLMWZGPE0opn+wvJ5YHLWLRoqLUhuRecmqo/avEKIll9ag=@lists.denx.de
X-Gm-Message-State: AOJu0YxpPKRV5ypLrFH6/hHK2cH942Z/CzTQRuRfX6rkRsjSSt2BZLZt
 I1bRD1w1KfDnSH3miWvrGg2O64M0btky1njinUeCHNjryFVuOeGTjxOlRRJs7X8YlU9KoF2nrGc
 jFX609mX/MKrMPdLkIdAGsQeDCav2N1zbYgLgxIrSAzSWiLEHuxaYxnmB
X-Gm-Gg: AfdE7cl5w2jxN3zvBrRcnvhTRxhnkG5VcSyI9nGyDPSx8TXiqUV1Dd5razrQQRWN7dA
 QyVpiLZlOhNSLZBBtn7fCr8XIPooiBxq5a+FnHFc9Tk2WgQ25Gq/lifgGnisXqKHO1KcK1UB3+2
 /HRbc2sHnmEDrFUf4mejlbfB/FxmxmbAXGz6tTVdk4OkgIWvQ5wiJj1Qh6gU55LEzsaPKf3GqYB
 Lp5cquMyGxRCCAF6/AdA1lh8WDlDAGx2HCvU4fAkUq1EIucW+HpKKFPEFZ4J9eNiwDkupAY4y71
 oljodFVcN6EObSMGcndQ1GIhvgwZu4VvN7vRPPLjbwLd6bsYNL3N9akUhIg3T3ym/uNRxhCQE7z
 hNtKJtpR4OxTv1IQZM1MIRsxblQa1UQHqgf2qdWTKizpWmSdwo984akLttobywSaOV0c5aept1X
 Y6arqY8btoHYTN58jWYSzytzdSS6exflYroQNJP0g=
X-Received: by 2002:a17:902:d586:b0:2c2:27be:39aa with SMTP id
 d9443c01a7336-2c725d7d58dmr24626295ad.17.1781867473300; 
 Fri, 19 Jun 2026 04:11:13 -0700 (PDT)
X-Received: by 2002:a17:902:d586:b0:2c2:27be:39aa with SMTP id
 d9443c01a7336-2c725d7d58dmr24625865ad.17.1781867472841; 
 Fri, 19 Jun 2026 04:11:12 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:11:12 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:28 +0530
Subject: [PATCH v4 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-5-385497442db2@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
In-Reply-To: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=3021;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=5b8WpMYrwSb8TwRsOkcbgF4JImGmf9JswKvk7NxaxU0=;
 b=Qop/TC/HhC0iGiDOcUj8ZmFGK8IvLCEVjgSvjtwGe+VsGTdUsFIqCJJz8hhnqSUODmnuFtabK
 iTGKacUQ4FTAvCy8GU1NNOB6N547Z6BNGaUGJRa3KfG5ZqBq95B0B4V
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: gIxYhdnGkQFeA8jToDxpkzqIvgtONS3e
X-Proofpoint-ORIG-GUID: gIxYhdnGkQFeA8jToDxpkzqIvgtONS3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfXzYxvXMUMqhP+
 O/29bkO81upCCP6IDRLK+7/Wiz9Lnj/sby7LcG4TU2ag5SRib1pc1uxrLFtQ/xViXKZkACrkmfI
 24RYzDmT/10KLLt0/7gG7j+pfR0W8uoNjlSALcsz8oBi3L2AR5U4w4cUFDkCLUfPM5zf2fyOIO7
 h5VcuVvZrta3C295kohiyVpu1c00h9R9KN8RNEkwuhJHUy5UWFYM28HM2NGj8p6/HQFhbANJLEW
 Gu63r21EYEKEJGUms0r0hpbNCPBXk4KRhvn0K4l59OmmnjmR1L00XSuDL5ZdIGhuPpH34JsyYHz
 JH8/IjqwKbSRC9yfNK3tsf9okU+MsMZrCjzY/WwGUc9eLzb5Wejk73IgUTqnma4OgeG4mk8rx6L
 1B5nYMlQRJUchPtXXiOBB+ZGEpVD1o5YhGijph2KAbuK8kD14V9+odrbDk8SmtrTU8KkjBjPtMv
 KmWsqnz/QzfhuapeE+g==
X-Authority-Analysis: v=2.4 cv=H6LrBeYi c=1 sm=1 tr=0 ts=6a3523d2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XB4NcWlKhgOPFm8pp8QA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX0sYSGat0A1JT
 8Ert9pldHxQHuWa18NZK+4wkUmE6UiAP8WbIUlgCvVM2uRBRqETgr12WAutJpaB8jiXeKzYXzt/
 R8ezta3LF+EBKaG7OLpIHJuZEgji7cs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190104
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

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
enabled and CMD DB data is present, we log a warning.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Drop these warnings if snagboot mode is enabled since that's the
  expected case
- Log a warning if snagboot is enabled and we do have a valid cmd-db,
  since that isn't an expected usecase

 Changes in v3:
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef

Changes in v2:
- No changes
---
 drivers/soc/qcom/Kconfig  | 18 ++++++++++++++++++
 drivers/soc/qcom/cmd-db.c | 15 +++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index cdd9e30f43e..987719bb925 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -18,6 +18,24 @@ config QCOM_COMMAND_DB
 	  resource on a RPM-hardened platform must use this database to get
 	  SoC specific identifier and information for the shared resources.
 
+config QCOM_COMMAND_DB_OPTIONAL
+	bool "Allow operation without Command DB data"
+	depends on QCOM_COMMAND_DB
+	help
+	  Allow the Command DB driver to bind successfully even when CMD DB
+	  data is not populated or has an invalid magic number.
+
+	  This is useful for platforms where CMD DB is not populated by the
+	  previous bootloader (e.g., snagboot mode where XBL loads U-Boot
+	  directly without initializing CMD DB).
+
+	  When enabled, missing CMD DB will generate warnings but allow boot
+	  to continue. Consumer drivers must handle cmd_db API failures
+	  gracefully by checking return values.
+
+	  If unsure, say N. Most production Qualcomm platforms require
+	  valid CMD DB data.
+
 config QCOM_RPMH
 	bool "Qualcomm RPMh support"
 	depends on QCOM_COMMAND_DB
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..c94a90a2903 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,19 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		log_err("%s: Invalid Command DB Magic\n", __func__);
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+			/* Missing CMD DB is expected in snagboot mode */
+			cmd_db_header = NULL;
+			return 0;
+		} else {
+			log_err("%s: Invalid Command DB Magic\n", __func__);
+			return -EINVAL;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+		log_warning("%s: CMD DB found in snagboot mode - this is unexpected\n",
+			    __func__);
 	}
 
 	return 0;

-- 
2.34.1

