Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E119C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A502D820FE;
	Tue,  1 Apr 2025 15:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="x6VvENW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF8B8171B; Tue,  1 Apr 2025 15:53:10 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB79081F7E
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6186c34923=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531BI6LM010841;
 Tue, 1 Apr 2025 15:53:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 UlcsXsuwblkoOomLchk+YH+O0O2yiDRaDQ1SVXWefR0=; b=x6VvENW7ZReuS00X
 tgshBHojK1OfRCiCj3bx+vzh+FdJyWCNv6hLyVARPAv+OpBmVrLRRytgQU/FDVB4
 Jp0mvxvZdatFPBHYBGM33l1FLKpOhgysXNItSU4SCGvypZYDCB7XZR4/9UQQspzd
 YkC6yrSpX/dwD67ndWiRqijh4t3xma5IWD4dfKgHbhCYaLBu3gkhjxN9JF12rw2g
 fmPS6mUK1YdUNs7LEkLu4KgyfoaNQTV9ra/O0/bEB6MzHGdaK21B7A2lB0EpSV/N
 LjG4/O0irgbDpY/MYX6Kvchtkqsf+nzCMUzUDwFE2mhluGPwN3ckD5Or/GqvoA7r
 I4KRCQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45pua7u7wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 15:53:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 83EA04004A;
 Tue,  1 Apr 2025 15:52:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37E2F8B601D;
 Tue,  1 Apr 2025 15:51:46 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 15:51:45 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] configs: stm32746-eval: Fix console cmdline
Date: Tue, 1 Apr 2025 15:51:32 +0200
Message-ID: <20250401135132.395518-7-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250401135132.395518-1-patrice.chotard@foss.st.com>
References: <20250401135132.395518-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
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

The Linux cmdline encoded in the defconfig is wrong, the
STM32 USART driver registers as ttySTM0 not ttyS0.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

 configs/stm32746g-eval_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/stm32746g-eval_defconfig b/configs/stm32746g-eval_defconfig
index c95cb60b0fb..5ffe1c1661a 100644
--- a/configs/stm32746g-eval_defconfig
+++ b/configs/stm32746g-eval_defconfig
@@ -18,7 +18,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
+CONFIG_BOOTARGS="console=ttySTM0,115200 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 CONFIG_DEFAULT_FDT_FILE="stm32746g-eval"
 # CONFIG_DISPLAY_CPUINFO is not set
-- 
2.25.1

