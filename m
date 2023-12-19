Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCBAC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 15:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729A6876B4;
	Tue, 19 Dec 2023 16:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bQQLmDFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1537C876A4; Tue, 19 Dec 2023 16:04:28 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29F1875A0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 16:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8828C42F70; 
 Tue, 19 Dec 2023 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702998263;
 bh=Yp6bYq0c0OZ0c8leQyHz4odVnkByqT1nE6PQGLL/ois=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=bQQLmDFM8d4JjoYeaNhCS9fJzD+SDSVCUfDcf1/QrvL1XwMYoMBMt6Val7D2j9adB
 C+u09cfooK7xE0oB0pYJ2w6P0pdrFREbgRlWRhh0hoLB1qLNCHRROiLYhi6NbOhkDB
 btiew0+BLSGroZPSFTzqysaHU1qUGPCApNWi6MCai2r2rYiSJpYRsvvZ2+owoNnguI
 w+OyCZmPN0iXgQ97Eq9ZHlpJseblc7IYUbUYZdueP2xuGhKWn1JcFazhK/aOzSmBen
 JVR4kmV3Yp2+QD16K087SBo8PxYuHU9jLtGHybiYLY1mSunCCBHretCpdxfdDVdVFY
 ZWIbfMB+MxOaw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 4/9] riscv: add ACPI fields to global data
Date: Tue, 19 Dec 2023 16:04:03 +0100
Message-Id: <20231219150408.10949-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
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

Add fields for the location of ACPI tables to the global data.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
v4:
	no change
v3:
	let tables in global data depend on CONFIG_(SPL_)ACPI
v2:
	no change
---
 arch/riscv/include/asm/global_data.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 937fa4d154..0f7c08a49d 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -32,6 +32,12 @@ struct arch_global_data {
 	ulong available_harts;
 #endif
 #endif
+#if CONFIG_IS_ENABLED(ACPI)
+	ulong table_start;		/* Start address of ACPI tables */
+	ulong table_end;		/* End address of ACPI tables */
+	ulong table_start_high;		/* Start address of high ACPI tables */
+	ulong table_end_high;		/* End address of high ACPI tables */
+#endif
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-- 
2.40.1

