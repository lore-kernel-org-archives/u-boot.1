Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C581C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0D686F6F;
	Mon, 15 Jan 2024 14:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vmtwg/Rc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7433286FC9; Mon, 15 Jan 2024 14:30:59 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937BF86F02
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 14:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FD9OjM009290; Mon, 15 Jan 2024 14:30:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=hUjMVqV
 bhQoZba8mis2X1SReVzFXs+BKdYRUk/48iyk=; b=vmtwg/RcSiAv9aPvKbSDGBc
 ka5xHZgS62OtVnvBxXWDxkFW7FT+Htxx3UyNWMQW1Ix56LfcAY6T6t02mVcJxEAe
 NBwJ3hXoSb8hvMMQ3m1rjeowlY1rs7IyZEDkOJCHJbC5p7ls0r4SxSz8UcPISlQS
 r6SieR9CgCI3If4NrQXtbVm+SLifYdYSBlG/wCcIS5d7AH1LJ6IR/3DZz+R1BEDj
 SfIn34hhylmrjisgFsUQs+zHCiB1vdOEYYE5KafjFm02ju0Ude6RLDnu7SktMPW7
 fp2xRMEHpGE5p790MCxSL6QvqH6HkFQqAvXb61s78uLg467PkGxp1+OjMEbYtKA=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfy8u68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 14:30:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1AD810002A;
 Mon, 15 Jan 2024 14:30:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A0B5286703;
 Mon, 15 Jan 2024 14:30:56 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 14:30:56 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] smt32mp: Add dependencies on CMDLINE for command stm32key
Date: Mon, 15 Jan 2024 14:30:54 +0100
Message-ID: <20240115143048.1.I808ca7780ec7f1ca146b47adae52ef1060a276c9@changeid>
X-Mailer: git-send-email 2.25.1
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

We cannot use stm32key commands without CONFIG_CMDLINE so add the
required condition.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/mach-stm32mp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index 5fc92d07fe6d..c6c89883f2b0 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -144,6 +144,7 @@ config STM32_ECDSA_VERIFY
 
 config CMD_STM32KEY
 	bool "command stm32key to fuse public key hash"
+	depends on CMDLINE
 	help
 		fuse public key hash in corresponding fuse used to authenticate
 		binary.
-- 
2.25.1

