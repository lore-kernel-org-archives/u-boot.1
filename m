Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EB2E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 08:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761BA8021D;
	Wed, 18 Dec 2024 09:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bk7Zm7Z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF648022B; Wed, 18 Dec 2024 09:01:25 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53BC80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082afbf55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7p705007672;
 Wed, 18 Dec 2024 09:01:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=gWnEle8p754J3KvxotGKeK
 C8oXorZejqmPYBtHlpjRo=; b=bk7Zm7Z0147RRy1xb0Xtk7+12Nhc5I2O+2+nnE
 5mzWK+22mMsYiRaJA90Vf/j18iyq29LpjQNnsKoK1Di5HSNfS9+QdyiHn+pQaqD3
 2UzfQ4h/M2gzjHG8ZwvEO7aS3cDzJG36Qr3o1LrRqL4FQpUO4t+7lCu+vJulKmvn
 MYdjnEcsm4pGDFx/pYxd0zDuIR7nxEGwulXsNQychQiFG55V9q/We3yZdNyZQZ/G
 B4EtE/aw37XHXfMC0qEO4kC4fMcht1VStvbTBARmUj/tLIK4DddB+Fo7WjWS6+c7
 Qovl24QCz/rW4jhqDWyDVYsgrZc2WqrOemXcfkiquPIpuoRQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ktca015f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 09:01:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A651740057;
 Wed, 18 Dec 2024 08:59:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A553224F0B7;
 Wed, 18 Dec 2024 08:58:40 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 08:58:40 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Greg Malysa
 <greg.malysa@timesys.com>, Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] Kconfig: Set STACK_SIZE to 16KB for STM32 MCUs
Date: Wed, 18 Dec 2024 08:58:33 +0100
Message-ID: <20241218075833.2049241-1-patrice.chotard@foss.st.com>
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

Since commit 6534d26ee9a5 ("lmb: do away with arch_lmb_reserve()"),
STM32F746-disco hangs when loading device tree just before starting
kernel:

Retrieving file: /stm32f746-disco.dtb
Kernel image @ 0xc0008000 [ 0x000000 - 0x19ae00 ]
Flattened Device Tree blob at c0408000
   Booting using the fdt blob at 0xc0408000
Working FDT set to c0408000
   Loading Device Tree to c05f8000, end c05ff71c ...

Adjust STACK_SIZE to 16KB for STM32 MCUs (F4/F7 and H7) boards
to fix kernel boot process as some of these boards embeds a limited
amount of memory.

Fixes: 6534d26ee9a5 ("lmb: do away with arch_lmb_reserve()")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 1f5b0f1972d..c087a420a24 100644
--- a/Kconfig
+++ b/Kconfig
@@ -578,6 +578,7 @@ config STACK_SIZE
 	hex "Define max stack size that can be used by U-Boot"
 	default 0x4000000 if ARCH_VERSAL_NET || ARCH_VERSAL || ARCH_ZYNQMP
 	default 0x200000 if MICROBLAZE
+	default 0x4000 if ARCH_STM32
 	default 0x1000000
 	help
 	  Define Max stack size that can be used by U-Boot. This value is used
-- 
2.25.1

