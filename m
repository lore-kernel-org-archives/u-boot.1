Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF10C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A16E8770F;
	Mon, 15 Jan 2024 15:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="DUs7A+cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102DE87669; Mon, 15 Jan 2024 15:06:10 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F6B870B7
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FDlWXb008575; Mon, 15 Jan 2024 15:06:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=Mtk/9GRvWf/0HZ/+W7M8vvy6luDCiJBeey5BGPrMFKA=; b=DU
 s7A+cVLEiKjFjICZuiEP9NHQ0fMuu7mPt0VLo/P6opOqlfi0dybRwE3/ol9S7wR2
 FyBrMNud3dmLZ+qpYOIirGQxDrMbVs9kjSM1euEBbPp996BqbZiFj5Z7SSXR3Hu3
 TQEYgECJaBwTQbVa6CY6mGWwvf2rulMIrWEX2pIDuL8nXphxPR9C9kE41PmFW6E6
 RRuBBxx9bN1AKLOhGDj7l8ORtmyjfyFoZ6rCZdjtVylaWWnJE5m5d23pNe3IOg/0
 xc7EsJCU8VPOR+/jqUF+VIQmYAKfAz4QnpKG88Hr6rsxSbUNCivgkCXy+XAghBEv
 vz4im/CdmT8KJDQkEM+w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y4pnq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 15:06:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F0C0100057;
 Mon, 15 Jan 2024 15:06:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37D4029865B;
 Mon, 15 Jan 2024 15:06:06 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 15:06:05 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Yann Gautier <yann.gautier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 02/14] arm: stm32mp: add Rev.B support for STM32MP25
Date: Mon, 15 Jan 2024 15:05:45 +0100
Message-ID: <20240115150451.v2.2.I98f906c5860d42cc6f0c38219ff8391e7f537efb@changeid>
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

From: Yann Gautier <yann.gautier@foss.st.com>

Add chip revision B support for STM32MP25, for displaying it in trace.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
index 4b2f70af9cc6..7f896a0d65d2 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
@@ -167,6 +167,9 @@ void get_soc_name(char name[SOC_NAME_SIZE])
 		case CPU_REV1:
 			cpu_r = "A";
 			break;
+		case CPU_REV2:
+			cpu_r = "B";
+			break;
 		default:
 			break;
 		}
-- 
2.25.1

