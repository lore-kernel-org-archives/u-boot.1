Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D5CC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F093480737;
	Tue, 14 Jan 2025 15:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="f+wHITNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C648071F; Tue, 14 Jan 2025 15:46:47 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B66806F4
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=31090870d4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EB644B026608;
 Tue, 14 Jan 2025 15:46:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 MuJCjgoPZIzLjrobpo8gBh1FKKzS9CX9ereIMihSkig=; b=f+wHITNX17gq1Qrq
 q9i1kDVBkLnVUiySOxu9/fpZLzONVWuWBWvL0awnSu0JR61foTnThkPNphe5zXPe
 ysVlZyJbQODo0rFQ1KHltZLG5b3W8vvHtkoHIMrv1dByCU+LL+CGZB0WeZ9ttzsw
 0yQl69iMEASywdze1Z9yNGS6S1zXdp2sqnx91zUVF7XAgYAjPFtBc4O2dBbIA4Vp
 JMWvXrHoXnynUq0ONlfwkQdPfECjDBEsekdOrjy6qH7zF1s3HZ5m6IKMs6Ml5iOS
 6V3Thh6Tl7+Bv7MJTRsYW13FNlh47sLNZ5SX01/bvhNCFrAf8LUouZViM4x36NVD
 Z1h2VQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 445prprusv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 15:46:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6D29A4002D;
 Tue, 14 Jan 2025 15:45:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B48D52A98B7;
 Tue, 14 Jan 2025 15:45:39 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 14 Jan
 2025 15:45:39 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] configs: stih410-b2260: Enable CMD_USB_MASS_STORAGE flag
Date: Tue, 14 Jan 2025 15:45:28 +0100
Message-ID: <20250114144528.1612168-11-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
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

Enable CMD_USB_MASS_STORAGE flag.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Cc: Marek Vasut <marex@denx.de>

---

 configs/stih410-b2260_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stih410-b2260_defconfig b/configs/stih410-b2260_defconfig
index 6fa28c11546..cc77d03d473 100644
--- a/configs/stih410-b2260_defconfig
+++ b/configs/stih410-b2260_defconfig
@@ -25,6 +25,7 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_EXT4_WRITE=y
-- 
2.25.1

