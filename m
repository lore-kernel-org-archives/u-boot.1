Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D75E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A0A80756;
	Wed,  8 Jan 2025 16:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="4e2FZ238";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF3A805E2; Wed,  8 Jan 2025 16:11:20 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5C18001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 16:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3103c48948=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508DL6jr031319;
 Wed, 8 Jan 2025 16:11:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 y3ugovgx3/crfOpHOM7gSffG9ugsV6EMYICkymUoR4E=; b=4e2FZ238rfxZNYN8
 nGuPkDvKK92zyP61kHU4jGM9CEYZe4JzkprnSyAYZqRZ0bnaD65Zaq2TeojTvcWd
 tojMfOaOQMm8TWrPb180vj90pAROjvww03WjbHi2Bo0adv3VoC44fiAkEvgDVU2z
 MzZU3uXniuc38eXOAQfzh6hgcM4BX/kpUOYMXCQevOICRk+REqNY/+UC2TrbZTpb
 Pjee2mt2SjbnuLwDOrSvAi3MM8Q8uVs3uMuM55A0fk+MOV0yoX/cYs29OLE7zQhi
 Hf7TZSL5gbeEn//7wE8ll67D8pEIXQCosRO8ZcGNR8hUawkTDlYWJXYU9heT4oJB
 hGBPNA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441pu4seuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 16:11:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BC9F54004C;
 Wed,  8 Jan 2025 16:10:13 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9259128163B;
 Wed,  8 Jan 2025 16:09:43 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 8 Jan
 2025 16:09:43 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Devarsh Thakkar
 <devarsht@ti.com>, Rasmus Villemoes <ravi@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] cyclic: Fix typo in struct cyclic_info description
Date: Wed, 8 Jan 2025 16:09:40 +0100
Message-ID: <20250108150940.558671-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108150940.558671-1-patrice.chotard@foss.st.com>
References: <20250108150940.558671-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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

Replace delay_ns by delay_us which is the field name used into
struct cyclic_info.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 include/cyclic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cyclic.h b/include/cyclic.h
index c6c463d68e9..56190db0599 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -20,7 +20,7 @@
  *
  * @func: Function to call periodically
  * @name: Name of the cyclic function, e.g. shown in the commands
- * @delay_ns: Delay is ns after which this function shall get executed
+ * @delay_us: Delay is ns after which this function shall get executed
  * @start_time_us: Start time in us, when this function started its execution
  * @cpu_time_us: Total CPU time of this function
  * @run_cnt: Counter of executions occurances
-- 
2.25.1

