Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA5CE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 08:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44FC801FE;
	Wed, 11 Dec 2024 09:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ae7igk4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFCD080217; Wed, 11 Dec 2024 09:13:00 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00268801F0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 09:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=207521b3fe=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB1VU2V022707;
 Wed, 11 Dec 2024 09:12:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Adl6R6pssOhMXGQY2DvvI4nYWBka8AgpQOdssJUCpcg=; b=ae7igk4/AOhp3zwg
 OBwOPNDxbvIrDoNCyP+77nj17Wfj56XlNEafQa95yDTblHrEoBEbjL9f17cQF2OV
 5Aahjcpa59jWq4wNeBUJGy0n390IcTZeglVHWdKMoSUN3713LdHuwFP9ff79QAef
 3C0YyGbv0RA3DT+WLj34GPF8MFymB/rOqMlSa8l18RynLrN9mZ6rT7ZihugGut8A
 QI8G99C3kcNMZW9rR9RsqQ7ZVtyctrXHgiqVE/M+rBWLTnbgeJ6EjEqQP7I1LDZq
 LMxwEYQH2fzGtDlDjHmgovSWfK2BL1i+oMKB+tswO8zW9WPYH0ELoG36MrNInRl7
 ELi/4w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43d0t5eukg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 09:12:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0B7F8400DA;
 Wed, 11 Dec 2024 09:10:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C83227BCE0;
 Wed, 11 Dec 2024 09:09:42 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Dec
 2024 09:09:42 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] configs: stm32f469-disco: Set CYCLIC_MAX_CPU_TIME_US to
 50000 for stm32f469-disco
Date: Wed, 11 Dec 2024 09:09:36 +0100
Message-ID: <20241211080936.1133105-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211080936.1133105-1-patrice.chotard@foss.st.com>
References: <20241211080936.1133105-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Updating the framebuffer takes quite a long time on this slow patform,
set CYCLIC_MAX_CPU_TIME_US to 50000 for stm32f469-disco to avoid
following cyclic warning:

"cyclic function video_init took too long: 46784us vs 5000us max"

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32f469-discovery_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
index 98399416fa5..b0144763d37 100644
--- a/configs/stm32f469-discovery_defconfig
+++ b/configs/stm32f469-discovery_defconfig
@@ -14,6 +14,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_CYCLIC_MAX_CPU_TIME_US=50000
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot > "
 CONFIG_CMD_IMLS=y
-- 
2.25.1

