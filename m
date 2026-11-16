Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77236606A884
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v2lBS+5C;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lafUl5wn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4396C4060F;
	Mon, 16 Nov 2026 03:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0BBPfu_6SlIE; Mon, 16 Nov 2026 03:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29AC240602
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799809;
	b=h765tIA91gL2RZPomiPoPqX2KInzDmOBjMRiAuvELXTU+u4fFxtJCY5su39hSFPvnl6d
	 e2im6EHbQ7SiAWbJ6x6dSORQWwQkYU1HdfS5ezYfUHwzAvt3JsEyKSD0gUDkL0zKctfef
	 tiMVMdXiW08CfJLswZh8ez2jFIbpGPX0pVykltRGT6tHspJQdTk6pVtPc/eG9B8Uxdjav
	 1bMElH6R0x1ql8UsKvWEMcQM69UKvEbxEEJZp8yzMPgBKopcctq9TV9Dna0Bt7hdGC9X5
	 4XnhRKiQ/DN+3ji9i+VWjxTAShtpgWixQMVmmD+invJK5MhaUsRlX8RC3k+YVSLJn2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oCz/BJHmHjbARqmDi5vo/uI6Hn2Rxo9L+HHnEq7l3/Y=;
	b=TDPgxbvYqC0TRwRvgMlH193Pr2e7WTNavIlCqrSOih/H7UQeMPPJD1FhvdGO7jhZjCS6
	 /azOkQJkZoKGrvtxtdk6Pq4znqfv7OItbpcrKvdaa8qiJ6bpB4QhkzjhNPu12SdMIX+XS
	 9b3ykBzC23eeKiF10qWy948Qod/S9DCz24ZdXD4szXXI/Os21KRGfPq8mjQAyJ2pO355L
	 0AkRWjXOAhjuXy/Os0WHhOcFQU1cDSxz8GmoqIO8Gpdjj82k0jSLYO7dzLkN3nPx9/1lc
	 y79jLm7XROSJP7Fg/YbzZB2O1BIEZuhkMWXjQGDXhgm0UOP/bpRNGtvvmPS2tgtLutQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794799809;
	bh=oCz/BJHmHjbARqmDi5vo/uI6Hn2Rxo9L+HHnEq7l3/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v2lBS+5CDzTvGXFOLksYx4pspyQclM/b1e9lI6bPV72F67zdZ9TqO+2lc+1gO7+Ut
	 OHjenE+JOIID6hDblL9e7EBzw0gMYhw1JNCO/UL/2zd6azN05GFfQS/ulJIn2S374/
	 NL7Pz0J57Hc2oygSsiqmN9Kl2S9AGAAgEzaCtRcEiOJvT9qO5pCZbA0D657E2x0nXl
	 Wju8J2tXEt1Wlbaaf/EKI6rKKNIzwchKeIhOL897tcS+1kCtRSQUq/zKI7ukyO/Xr4
	 KMC66TATtSJMKsq7+5mv2M0vxgu7REaNrMG2B0lxkvxlORy9XSXqa51sD/ptE8BbfD
	 i6a8dtQFv6ueA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29AC240602;
	Mon, 16 Nov 2026 03:30:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14F40D7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF68A605F1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EC6qwrrCx7mp for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABA0D605DF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=lafUl5wn
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABA0D605DF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:00 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSYJj5QFkzMlF6;
 Mon, 16 Nov 2026 04:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794799797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCz/BJHmHjbARqmDi5vo/uI6Hn2Rxo9L+HHnEq7l3/Y=;
 b=lafUl5wndQt1Q6Wp/UO/jOUN0Lk8Ytea2aQsGTQiucgYFAFfCg5ppxEBHBx1VUPHDRIhRC
 wDeJkaVriCR6SA0hiuiq6pUv6AJcueRy0/I1PRhHU897Rubvnc7Vh3J9zCqz4T7LUT9kyZ
 TEPXkvbZennPkUcgfVDT4hTxCgcZc4vxkrWRI83P5Q3jt2KIUmoa5LYXNSaKVmlD/wJKvR
 9RWD1UEGGfcWYUJrrpNPvZeKRhK0mht6lMOm3OEoPn8pxeG0s/TZGNQ5gDMgOSmAPmwFCx
 JJ3/kjiUU+EuE+j53qlroPrnTseRECQ44PjjSwesWkwEvnZuWoqH4MmfVGw/6w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] remoteproc: renesas: Add Cortex-A76 management suppport
Date: Mon, 16 Nov 2026 04:29:08 +0100
Message-ID: <20261116032949.3145053-4-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
References: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: db4fe470d5fed967652
X-MBO-RS-META: m1zqk9j88rsy9edzrc564jssswh5ep4b
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Cortex-A76 core load, start, stop, restart, is_running support
for up to four CPU cores present on R-Car Gen4, in addition to the
existing Cortex-R52 support.

The Cortex-A76 remoteproc behavior is almost identical to the
Cortex-R52, except there are up to four cores and the 'rproc stop'
of a Cortex-A76 core requires cooperation from the stopped core.
The stopped core must set its CPUPWRCTRL register bit 0 and enter
WFI to power down.

Example code which must run on the remote core that is powering off:
"
core_n_power_off_core:
  mov x0, #1
  msr S3_0_C15_C2_7, x0
  wfi
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_apmu.c | 267 +++++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/renesas_apmu.c b/drivers/remoteproc/renesas_apmu.c
index aa07e0901e7..3fd7f325fff 100644
--- a/drivers/remoteproc/renesas_apmu.c
+++ b/drivers/remoteproc/renesas_apmu.c
@@ -14,8 +14,11 @@
 #include <malloc.h>
 #include <remoteproc.h>
 
-/* R-Car V4H/V4M contain 3 clusters / 3 cores */
+#define RCAR_APMU_TIMEOUT_US		1000000
+
+/* R-Car V4H/V4M contain 3 lockstep Cortex-R52 and 4 Cortex-A76 cores. */
 #define RCAR4_CR52_CORES		3
+#define RCAR4_CA76_CORES		4
 
 /* Reset Control Register for Cortex-R52 #n */
 #define APMU_CRRSTCTRL(n)		(0x304 + ((n) * 0x40))
@@ -28,6 +31,28 @@
 #define APMU_CRBARP_CR_RBAR_MASK	0xfffc0000
 #define APMU_CRBARP_CR_RBAR_ALIGN	0x40000
 
+/* Base Address Register for Cortex-A76 #n */
+#define APMU_CL_BASE(n)			(0x400 + (((n) & 0x3) * 0x40))
+#define APMU_CL_PWRCTRL(n)		APMU_CL_BASE(n)
+#define APMU_CL_PWRCTRL_PCHPDNEN	BIT(17)
+#define APMU_CA_BASE(n)			(0x800 + (((n) & 0x6) * 0x100) + (((n) & 0x1) * 0x40))
+#define APMU_CA_PWRCTRL(n)		APMU_CA_BASE(n)
+#define APMU_CA_PWRCTRL_WUP_REQ		BIT(0)
+#define APMU_CA_PWRCTRL_IWUP_EN		BIT(4)
+#define APMU_CA_PWRCTRL_PCHPDNEN	BIT(17)
+#define APMU_CA_FSMSTSR(n)		(APMU_CA_BASE(n) + 0x18)
+#define APMU_CA_SAFECTRL(n)		(APMU_CA_BASE(n) + 0x20)
+#define APMU_CA_SAFECTRL_DBGGEN		BIT(13)
+#define APMU_CA_RVBARPL(n)		(APMU_CA_BASE(n) + 0x38)
+#define APMU_CA_RVBARPL_MASK		0xFFFFFFFC
+#define APMU_CA_RVBARPL_VLD		BIT(0)
+#define APMU_CA_RVBARPH(n)		(APMU_CA_BASE(n) + 0x3c)
+
+/* Cortex-A76 APSREG */
+#define CA76_APSREG_BASE		0xe6280000
+#define CA76_APSREG_AP_CLUSTER_AUX(n)	(0x10 + (((n) & 0x3) * 0x1000))
+#define CA76_APSREG_AP_CLUSTER_AUX_INIT	0x3
+
 /**
  * struct renesas_apmu_rproc_cr52_privdata - remote processor private data
  * @regs:		controller registers
@@ -40,6 +65,18 @@ struct renesas_apmu_rproc_cr52_privdata {
 	u32		*trampoline;
 };
 
+/**
+ * struct renesas_apmu_rproc_ca76_privdata - remote processor private data
+ * @regs:		controller registers
+ * @core_id:		CPU core id
+ * @trampoline:		jump trampoline code
+ */
+struct renesas_apmu_rproc_ca76_privdata {
+	void __iomem	*regs;
+	ulong		core_id;
+	u32		*trampoline;
+};
+
 /*
  * CRBARP address is aligned to 0x40000 / 256 kiB , this trampoline
  * allows arbitrary address alignment at instruction granularity.
@@ -51,6 +88,17 @@ static const u32 renesas_apmu_rproc_cr52_trampoline[4] = {
 	0xabcd1234	/* jump target (rewritten on load) */
 };
 
+/*
+ * CRBARP address is aligned to 0x40000 / 256 kiB , this trampoline
+ * allows arbitrary address alignment at instruction granularity.
+ */
+static const u32 renesas_apmu_rproc_ca76_trampoline[4] = {
+	0x58000040,	/* ldr x0, 8 */
+	0xd61f0000,	/* br x0 */
+	0x567890ef,	/* jump target LSB (rewritten on load) */
+	0x1234abcd,	/* jump target MSB (rewritten on load) */
+};
+
 /**
  * renesas_apmu_rproc_cr52_load() - Load the remote processor
  * @dev:	corresponding remote processor device
@@ -230,6 +278,209 @@ U_BOOT_DRIVER(renesas_apmu_cr52) = {
 	.priv_auto	= sizeof(struct renesas_apmu_rproc_cr52_privdata),
 };
 
+/**
+ * renesas_apmu_rproc_ca76_load() - Load the remote processor
+ * @dev:	corresponding remote processor device
+ * @addr:	Address in memory where image is stored
+ * @size:	Size in bytes of the image
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_ca76_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct renesas_apmu_rproc_ca76_privdata *priv = dev_get_priv(dev);
+	u32 trampolineaddr = (u32)(uintptr_t)(priv->trampoline);
+
+	priv->trampoline[2] = lower_32_bits(addr);
+	priv->trampoline[3] = upper_32_bits(addr);
+	flush_dcache_range(trampolineaddr,
+			   trampolineaddr +
+			   sizeof(renesas_apmu_rproc_ca76_trampoline));
+	invalidate_dcache_range(trampolineaddr,
+				trampolineaddr +
+				sizeof(renesas_apmu_rproc_ca76_trampoline));
+	flush_dcache_range(addr, addr + size);
+	invalidate_dcache_range(addr, addr + size);
+	asm volatile("dsb sy\n");
+	asm volatile("isb sy\n");
+
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_ca76_cluster() - Return cluster ID for core ID
+ * @core:	core ID
+ *
+ * Return: cluster ID
+ */
+static int renesas_apmu_rproc_ca76_cluster(int core)
+{
+	/* R-Car V4M has 4 cores per cluster */
+	if (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A779H0)
+		return core / 4;
+	else
+		return core / 2;
+}
+
+/**
+ * renesas_apmu_rproc_ca76_start() - Start the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_ca76_start(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_ca76_privdata *priv = dev_get_priv(dev);
+	u32 val, trampolineaddr = (u32)(uintptr_t)(priv->trampoline);
+	int cluster = renesas_apmu_rproc_ca76_cluster(priv->core_id);
+	int ret;
+
+	/* CA76 boot address and valid flags set */
+	trampolineaddr &= APMU_CA_RVBARPL_MASK;
+	trampolineaddr |= APMU_CA_RVBARPL_VLD;
+
+	writel(upper_32_bits(trampolineaddr),
+	       priv->regs + APMU_CA_RVBARPH(priv->core_id));
+	writel(lower_32_bits(trampolineaddr),
+	       priv->regs + APMU_CA_RVBARPL(priv->core_id));
+
+	/* Clear Cluster OFF bit */
+	clrbits_le32(priv->regs + APMU_CL_PWRCTRL(cluster),
+		     APMU_CL_PWRCTRL_PCHPDNEN);
+
+	/* Clear Core OFF bit */
+	clrbits_le32(priv->regs + APMU_CA_PWRCTRL(priv->core_id),
+		     APMU_CA_PWRCTRL_PCHPDNEN);
+	ret = readl_poll_timeout(priv->regs + APMU_CA_PWRCTRL(priv->core_id),
+				 val, !(val & APMU_CA_PWRCTRL_PCHPDNEN),
+				 RCAR_APMU_TIMEOUT_US);
+	if (ret)
+		return -ETIMEDOUT;
+
+	setbits_le32(priv->regs + APMU_CA_PWRCTRL(priv->core_id),
+		     APMU_CA_PWRCTRL_WUP_REQ);
+
+	/* Wait until CAXX wake up sequence finishes */
+	return readl_poll_timeout(priv->regs + APMU_CA_PWRCTRL(priv->core_id),
+				  val, !(val & APMU_CA_PWRCTRL_WUP_REQ),
+				  RCAR_APMU_TIMEOUT_US);
+}
+
+/**
+ * renesas_apmu_rproc_ca76_stop() - Stop the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_ca76_stop(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_ca76_privdata *priv = dev_get_priv(dev);
+
+	/* Clear DBGGEN_PPDN bit for core down to 'OFF' mode */
+	clrbits_le32(priv->regs + APMU_CA_SAFECTRL(priv->core_id),
+		     APMU_CA_SAFECTRL_DBGGEN);
+
+	/* For Core OFF */
+	setbits_le32(priv->regs + APMU_CA_PWRCTRL(priv->core_id),
+		     APMU_CA_PWRCTRL_PCHPDNEN);
+
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_ca76_reset() - Reset the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_ca76_reset(struct udevice *dev)
+{
+	renesas_apmu_rproc_ca76_stop(dev);
+	renesas_apmu_rproc_ca76_start(dev);
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_ca76_is_running() - Is the remote processor running
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if the remote processor is running, 1 otherwise
+ */
+static int renesas_apmu_rproc_ca76_is_running(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_ca76_privdata *priv = dev_get_priv(dev);
+
+	return !readl(priv->regs + APMU_CA_FSMSTSR(priv->core_id));
+}
+
+/**
+ * renesas_apmu_rproc_ca76_init() - Initialize the remote processor APSREG register
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_ca76_init(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_ca76_privdata *priv = dev_get_priv(dev);
+	int cluster = renesas_apmu_rproc_ca76_cluster(priv->core_id);
+
+	/* If the core is running already, do nothing. */
+	if (renesas_apmu_rproc_ca76_is_running(dev))
+		return 0;
+
+	/* Disable AC TEST */
+	setbits_le32(((void __iomem *)CA76_APSREG_BASE) +
+		     CA76_APSREG_AP_CLUSTER_AUX(cluster),
+		     CA76_APSREG_AP_CLUSTER_AUX_INIT);
+
+	return 0;
+}
+
+static const struct dm_rproc_ops renesas_apmu_rproc_ca76_ops = {
+	.init		= renesas_apmu_rproc_ca76_init,
+	.load		= renesas_apmu_rproc_ca76_load,
+	.start		= renesas_apmu_rproc_ca76_start,
+	.stop		= renesas_apmu_rproc_ca76_stop,
+	.reset		= renesas_apmu_rproc_ca76_reset,
+	.is_running	= renesas_apmu_rproc_ca76_is_running,
+	.device_to_virt	= renesas_apmu_rproc_device_to_virt,
+};
+
+/**
+ * renesas_apmu_rproc_ca76_of_to_plat() - Convert OF data to platform data
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_ca76_of_to_plat(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_ca76_privdata *priv = dev_get_priv(dev);
+
+	priv->core_id = dev_get_driver_data(dev);
+
+	priv->regs = dev_read_addr_ptr(dev);
+	if (!priv->regs)
+		return -EINVAL;
+
+	priv->trampoline = memalign(APMU_CRBARP_CR_RBAR_ALIGN,
+				    sizeof(renesas_apmu_rproc_ca76_trampoline));
+	if (!priv->trampoline)
+		return -ENOMEM;
+
+	memcpy(priv->trampoline, renesas_apmu_rproc_ca76_trampoline,
+	       sizeof(renesas_apmu_rproc_ca76_trampoline));
+
+	return 0;
+}
+
+U_BOOT_DRIVER(renesas_apmu_ca76) = {
+	.name		= "rcar-apmu-ca76",
+	.id		= UCLASS_REMOTEPROC,
+	.ops		= &renesas_apmu_rproc_ca76_ops,
+	.of_to_plat	= renesas_apmu_rproc_ca76_of_to_plat,
+	.priv_auto	= sizeof(struct renesas_apmu_rproc_ca76_privdata),
+};
+
 /**
  * renesas_apmu_rproc_bind() - Bind rproc driver to each core control
  * @dev:	corresponding remote processor parent device
@@ -239,7 +490,7 @@ U_BOOT_DRIVER(renesas_apmu_cr52) = {
 static int renesas_apmu_rproc_bind(struct udevice *parent)
 {
 	ofnode pnode = dev_ofnode(parent);
-	struct driver *cdrvr52;
+	struct driver *cdrvr52, *cdrva76;
 	struct udevice *cdev;
 	char name[32];
 	ulong i;
@@ -249,6 +500,10 @@ static int renesas_apmu_rproc_bind(struct udevice *parent)
 	if (!cdrvr52)
 		return -ENOENT;
 
+	cdrva76 = lists_driver_lookup_name("rcar-apmu-ca76");
+	if (!cdrva76)
+		return -ENOENT;
+
 	for (i = 0; i < RCAR4_CR52_CORES; i++) {
 		snprintf(name, sizeof(name), "rcar-apmu-cr52.%ld", i);
 		ret = device_bind_with_driver_data(parent, cdrvr52, strdup(name),
@@ -257,6 +512,14 @@ static int renesas_apmu_rproc_bind(struct udevice *parent)
 			return ret;
 	}
 
+	for (i = 0; i < RCAR4_CA76_CORES; i++) {
+		snprintf(name, sizeof(name), "rcar-apmu-ca76.%ld", i);
+		ret = device_bind_with_driver_data(parent, cdrva76, strdup(name),
+						   i, pnode, &cdev);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

