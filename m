Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F43E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 11:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB08583DA9;
	Mon, 29 Dec 2025 12:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="agdskvrb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340B183DB6; Mon, 29 Dec 2025 12:43:43 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B8283DA9
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 12:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 61A6043578;
 Mon, 29 Dec 2025 11:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6B8C19422;
 Mon, 29 Dec 2025 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767008619;
 bh=FAUA4QBL3dJ6+mozl7wciV4Rq1kV7lEzRX0THjm7TWU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=agdskvrbBAR1UZ8/HSog9CZCIr/stWkHQL/p0iIMojnkZWtRJhfp3Wv5ZVBcU5Tew
 +bu+NzSjMRBW2Brv/NurLwquU4cc0JR5wYCSpestDTsVjSOfHqhxh4Nyh3Y8/HwQ5G
 l4ISQbCtUev1sG6D0hr0r8mE7HW2RA13Fm+D8YWJI+8NzYejO4kc5RvUhjz7wlpXP5
 ylZvK7gV8SZtfoO8WgU4oReIpRXzXfwgmjPU45vyWgyKXRIpCwtzGZ7FNHaJZtvfxl
 QZAjUVyrSBMtWR6YjotgYY87fNm4XiFVJ/Exvg2C0aTAvC36VE9voNwXSqJzSErSZd
 yueGFqirH4wwQ==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
Date: Mon, 29 Dec 2025 17:13:12 +0530
Message-ID: <20251229114312.668068-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229114312.668068-1-sumit.garg@kernel.org>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Recently upstream TF-A/OP-TEE has started gaining support for Qcom
platforms. RB3Gen2 being the first one and more to come. U-Boot in
corresponding boot flow is packaged as a position independent executable.

So, lets add a generic U-Boot defconfig for Qcom platforms to support
TF-A/OP-TEE based TrustZone stack. Build command:

$ make qcom_tfa_optee_defconfig
$ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2

For more information refer here:
https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 configs/qcom_tfa_optee_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 configs/qcom_tfa_optee_defconfig

diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
new file mode 100644
index 00000000000..c398521770f
--- /dev/null
+++ b/configs/qcom_tfa_optee_defconfig
@@ -0,0 +1,7 @@
+# Configuration for building a generic U-Boot image
+# with support for TF-A/OP-TEE based Arm TrustZone stack.
+
+#include "qcom_defconfig"
+
+CONFIG_TEE=y
+CONFIG_OPTEE=y
-- 
2.51.0

