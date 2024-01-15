Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E216AC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3828780A;
	Mon, 15 Jan 2024 15:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="wN2cvTCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00DEB86C39; Mon, 15 Jan 2024 15:07:26 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2243686C39
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FDbu8I030023; Mon, 15 Jan 2024 15:07:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=US4s9blWcp7fHZqx5MKnwEtSOcrI9euAc4qUVWtZwO0=; b=wN
 2cvTCcyDqrKUhRuPj+TZwCEjq6rvRruER8V5fR8wxHtkcObVcnRHqWLTDIjB9Hdy
 kvXA46V5lvOtGW2tsUo8d8k3+ZqM5M23URb1khfu5emAMddsuxR2C5JaVaKNFwnn
 m2gIdIJC7Vzy9E7rRkd39SSbLvDCoe2Ymhui/SH5+1er0tihzpxGn7EryDOfysKV
 rlFl6JfTAYMtr1eQAoY4BkmupcTKfYUyBgGkpA/VMNl/pffEibprKCu3BO00I21j
 abTLrzQIhnfbWy6LKE+bT44LeIgxmwgqEyYgZELSrRQVJIh3fksz5/iAPVLrBVuK
 8E35ix1/rqVkRSpT2SfQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmbh0uw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 15:07:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA03410002A;
 Mon, 15 Jan 2024 15:07:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C319A298667;
 Mon, 15 Jan 2024 15:07:22 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 15:07:22 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 09/14] stm32mp: stm32prog: add support of stm32mp25
Date: Mon, 15 Jan 2024 15:05:52 +0100
Message-ID: <20240115150451.v2.9.Iad107c8eaf11680ad8debbedc8d48327f31fd866@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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

Change OTP number to 364 for STM32MP25 as it is done in bsec driver.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
index ae4bd8842f53..eda98eb61d76 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
@@ -28,7 +28,15 @@
 #else
 #define OTP_SIZE_SMC		0
 #endif
-#define OTP_SIZE_TA		776
+/* size of the OTP struct in NVMEM PTA */
+#define _OTP_SIZE_TA(otp)	(((otp) * 2 + 2) * 4)
+#if defined(CONFIG_STM32MP13x) || defined(CONFIG_STM32MP15x)
+/* STM32MP1 with BSEC2 */
+#define OTP_SIZE_TA		_OTP_SIZE_TA(96)
+#else
+/* STM32MP2 with BSEC3 */
+#define OTP_SIZE_TA		_OTP_SIZE_TA(368)
+#endif
 #define PMIC_SIZE		8
 
 enum stm32prog_target {
-- 
2.25.1

