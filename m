Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8623D10DB4
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 07:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04FEF89413;
	Mon,  2 Dec 2024 08:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="AA+F4YQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2D289287; Mon,  2 Dec 2024 08:48:35 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CA989287
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 08:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2066b4005c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B213pUS008519;
 Mon, 2 Dec 2024 08:48:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=1HxZEGY/C2ndMOiZESewFY
 g9/oaQufO+kOoHFO53Bx4=; b=AA+F4YQxp54hEnswQsMdWy9Okljd/dJomj8DeU
 xxcTzJrRv68kF+t/xrrKcGKDj2aZ3FUk4VoGwLcAqAzAcIs9N1J3bMvVjmft4Cux
 0/5ZQvgA42ZGg1v+ey+FBcI/M67osymMgecm5GVs+r01S8L9Mo3/cUQhKmdIajpJ
 iTzO+dRb91Mc+ldUWbXJSJRnxV9PXXZllAKNpuAOcyjeOT7z7I6iGrvmk+uxIz8W
 C6VFR4gwURLGzWE+6HWrlSKM/QnuGcxvAwpAAwfSFbXMn2rVdDbtgSncuQBq8U/y
 JMW9cLmovDthRqVvWTydTQTLpEJp1iHnGyGuh3M7hBCMHgSg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437tx1xdjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 08:48:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9BB0040045;
 Mon,  2 Dec 2024 08:47:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DB73A20E1F6;
 Mon,  2 Dec 2024 08:46:46 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 2 Dec
 2024 08:46:46 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
Date: Mon, 2 Dec 2024 08:46:44 +0100
Message-ID: <20241202074644.5380-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

In case "ums" command is used on platforms which don't implement
g_dnl_board_usb_cable_connected() and USB cable is not connected,
we stay inside sleep_thread() forever and watchdog is triggered.

Add schedule() call to avoid this issue.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
  - move schedule() right before dm_usb_gadget_handle_interrupts()

 drivers/usb/gadget/f_mass_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index ffe1ae6eb73..d3fc4acb401 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -682,6 +682,7 @@ static int sleep_thread(struct fsg_common *common)
 			k = 0;
 		}
 
+		schedule();
 		dm_usb_gadget_handle_interrupts(udcdev);
 	}
 	common->thread_wakeup_needed = 0;
-- 
2.25.1

