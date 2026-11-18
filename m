Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F551606A33F
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ngEeUPyw;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IJXfox2m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 513F580DA9;
	Wed, 18 Nov 2026 13:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9DpqA-vtyQ7w; Wed, 18 Nov 2026 13:18:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92D75811D4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007931;
	b=nqzHaYLMO4zfYlrg05JjJjjbxzgvEfnIMMBcjjG9HleKYfSJ5bgM71P8Gzf4aksmtKMj
	 wS1Syt+lRcje9SH2QZfChN56fMJQuoyPZuvTzz2kdDyY9JBcacckHeh7m031uD/FnnQ1i
	 dI3X1xdHuchAIiFpJtOsKjcmByZeYyHHYOJ0EW8AwDXn9zfT0u2XOLiSBvu+Utb6Dlhsw
	 tABjNANN6V2ZOtw8hsS4+OTlhN7JR/q1XEVZi3bLBFW5pY71AAdq3rc5zXTrWp45rj2kP
	 PGbk/LUZ4FbJtGMIy2SJe1ju615JTXHXG4IdfgRpSt3tYXUeN8OcKFCGFLGQ1sLuJbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sfAzHKLZwLT9+J1EOsT9bdCJta0Yu1AWhyq1ftXoeKI=;
	b=bG9KcQC/fm2m8pNqtW6uyvToiNV6N1VAjsulc83739zyHvobjgtZtrFMFBPbrOy8/C2t
	 TG8IEO6hQuGLSA5MEaEBA+8iHrdC7XL5kjgEfZtQEGdJLVxJa/s/r6G3MFTFdu7Neo6EL
	 eo/IdbDZzztFSQPIzGRNTKsbuhc+9PJ7KLuaECeUAcQpTBpZkgaZglX7qc/ffqpRXFFQj
	 Tqjeoonb9AEmHsnbfz/6MkoD6PzE212nULXDKFFCvrQqkpx1rmQKNUMsdIBit5kdNNYVW
	 Ukn58JHigtobpAxiq0V52QiSYGDkqQHL/gCnuDue3AkbBYOvtpv3VAF7t4I7m2dhGvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007931;
	bh=sfAzHKLZwLT9+J1EOsT9bdCJta0Yu1AWhyq1ftXoeKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ngEeUPywbtDNra9snnrdOMONEsToeoPk9SjafW/h46QIsYuju/lYV+sOfgbvW8nzN
	 VD8PxBIR1FtPQY4BYVhNW+WMph3Tm/sVnvADEVS43HBtUBIK08hZu0IHALNxdGowY3
	 fcGLDUKgB9vmfCkbAPQkIjlRvYCqKm8SBVLBnABoqS2qmbdrpiaIcHPYUihsUQDyYn
	 wTnB6My7KPmsYOKT54PqZjUGwgrA3yO5+noQxdRhflZ4MUDHPp5rc+C3yFZ5s0MePq
	 hKZGrcUKEvL73SNGQ5A9fwL2hiX2q3z0u7d4e1Ax9UJ/9Dd7EHCw2M3bbv5TApnLU7
	 jPqzZwL7Lda0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92D75811D4;
	Wed, 18 Nov 2026 13:18:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 20FCD70B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1291040A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wn-EUJv7CbAa for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20D59409F7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=IJXfox2m
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20D59409F7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D2D6C1A16D4;
 Wed, 18 Nov 2026 13:18:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9D8205FE9B;
 Wed, 18 Nov 2026 13:18:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A47511BC1443; Wed, 18 Nov 2026 14:18:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007925; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=sfAzHKLZwLT9+J1EOsT9bdCJta0Yu1AWhyq1ftXoeKI=;
 b=IJXfox2mC58+ezJXWs6qC/p+m9IpHd4uKpZd6CWIqNKFzwp7/CHZELHsLP6b3uSMjnavxl
 7rHtp3UVtnQMWdOt6XutNWjSgOV+Zw2XgT1gIDT9D5C0/x1qqj2ta4XbGDwXiPs+t8oJfF
 WH4G8Dc7sZWxUcWhN+bKhQiLbAF1onJ+fzAOoC3uDFnSmFbBauc5dqW8O+3/1oova8dg5p
 CgtAn7lx8Zee9BIVVs4/EvDYhn0o96bt14iDS2ukWjQa6BuCZdmn7o8KY9NjMksz6mp2b1
 yXOGZjsn+BSgjqIdqpT/P1oCPsC6vidw/w/0hZVROr2g3rvCDW/GQUSSn6/Z8A==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 06/20] board: mach-k3: r5: common: enable GTC after
 core_resume
Date: Wed, 18 Nov 2026 14:17:53 +0100
Message-ID: <20261118131807.135859-7-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhash Kumar Jha <a-kumar2@ti.com>

The GTC counter values are restored in the resume sequence by TIFS as
part of the core_resume API. Enable GTC counter after it is restored.

Also add a check to make sure that rproc_load only enables the GTC counter
in the case of a cold boot.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/r5/lpm-common.c       | 11 +++++++++++
 drivers/remoteproc/ti_k3_arm64_rproc.c | 10 ++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index f1d16f38157f..f949ff0904ed 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -313,6 +313,7 @@ static void resume_rproc_f(void)
 {
 	struct power_domain rproc_pwrdmn;
 	struct udevice *dev;
+	void *gtc_base;
 	int ret;
 
 	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
@@ -323,6 +324,16 @@ static void resume_rproc_f(void)
 	if (ret)
 		panic("power_domain_get_rproc() failed: %d\n", ret);
 
+	gtc_base = dev_read_addr_ptr(dev);
+	if (!gtc_base)
+		panic("Get GTC address failed\n");
+
+#define GTC_CNTCR_REG	0x0
+#define GTC_CNTR_EN	0x3
+
+	/* GTC counter values have been restored by TIFS, so enable the counter */
+	writel(GTC_CNTR_EN, gtc_base + GTC_CNTCR_REG);
+
 	ret = power_domain_on(&rproc_pwrdmn);
 	if (ret)
 		panic("power_domain_on failed: %d\n", ret);
diff --git a/drivers/remoteproc/ti_k3_arm64_rproc.c b/drivers/remoteproc/ti_k3_arm64_rproc.c
index 403c6bed2e8c..9b8a6b7dc53a 100644
--- a/drivers/remoteproc/ti_k3_arm64_rproc.c
+++ b/drivers/remoteproc/ti_k3_arm64_rproc.c
@@ -17,6 +17,7 @@
 #include <dm/device_compat.h>
 #include <linux/err.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <mach/hardware.h>
 #include "ti_sci_proc.h"
 
 #define INVALID_ID	0xff
@@ -78,8 +79,13 @@ static int k3_arm64_load(struct udevice *dev, ulong addr, ulong size)
 	/* Store the clock frequency down for GTC users to pick  up */
 	writel((u32)gtc_rate, rproc->gtc_base + GTC_CNTFID0_REG);
 
-	/* Enable the timer before starting remote core */
-	writel(GTC_CNTR_EN, rproc->gtc_base + GTC_CNTCR_REG);
+	if (!j7xx_board_is_resuming()) {
+		/*
+		 * In case of a fresh boot, enable the timer before
+		 * starting the remote core.
+		 */
+		writel(GTC_CNTR_EN, rproc->gtc_base + GTC_CNTCR_REG);
+	}
 
 	/*
 	 * Setting the right clock frequency would have taken care by
