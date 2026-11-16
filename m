Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA35606A883
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Em0e2/LS;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=I+lEPFJ9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ACC9605DF;
	Mon, 16 Nov 2026 03:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCBTvnfyPt3L; Mon, 16 Nov 2026 03:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25D38605F1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799807;
	b=MVn4y4/IxP3YykZnXMj5GeHnuSCd/J5F+XYzOR3tlA2kEwu6qjZnXLOYfBIMlaHttpl8
	 /HXYPlACoK8FKf4LqjX5jfbEkBFXw2/6gCNe6rhHB3z4Em5nTjTTNWfDP/Aba+JpOx+gU
	 K4qx7iU/e2pCH5F1offChjfose1VfZDEtQVcYi7GOHsVAoNhG/t4BoaG/tkqElMBScWPo
	 gexO35jLP2b7215eKv6P9mQuMedyteQ5AiErgtAeFC+5rHM9Fnye7WhTz9zQuoRLBlL7Y
	 c+g1Zi9Yr18x81H7fTsAJhaUeJBu2RFsxnThT2WOH81iBueACV58ZRVErPrVf/qPSRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QdD5zV83d88+IzVKmWVU8Uetnt7Ud9wZagIsRkofgOM=;
	b=FMhbDUjpW4UnXsOloPUJH/ZZS7MR2I3NmkuW2aPQytd0qFFjXQrb/lZ1j/CFw/hntQ2G
	 faZKOP/AjOiqvfIjNfDazCtQcDXzG1roFKXPwp14r+T+kCqJq03qbsm/O1hZFsHKBCGUq
	 bji5TXPKBROFoxDzT8DfFh29S2SJ+gLbcJUExMHzV5SlyN2AzpvRbVOIffXsi+FvW4u53
	 MqBr9KbfLkeCJjfMtGXNCuW07VQWAgt4GaqcE80vn/63pL7+/IvKM1SzCaTY+K6rdUIn1
	 FMjW+my+vSAx6UoO5Rj+Wyh8pCGdmaCRPPWnRh9g5ae4tUNyR7FZUQuJPMKHlJbrXuw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794799807;
	bh=QdD5zV83d88+IzVKmWVU8Uetnt7Ud9wZagIsRkofgOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Em0e2/LSXolN4SJpNQR6Mwx8LNIO7iVN1N8P24V1BYJL89uMwF8adleGlpYjTJURx
	 FPoe7ooIN3ty7d9V8IBkejI+tOc4y7OGnmKSRB5meds4o6BvEabTnqbN0nRH2yFnGC
	 7HOd5EeAmAwYM5cw6f1t457SGPkQ0MhekadrynS1lqgTu6zQ7VZ9LvXjhVK/Ig0Hto
	 JgqkaKhey50KnhBbzS9iM1p7LSxtfh4uw0LttwIs2qzZLVaUU8h6kUoO3ZDIOexSR6
	 r+iULgN6v7556SvUg4IhQFNPs0pN/S731i0zIdVkyEKgE/D4nP5PxZLG0Eo1agjNa8
	 pqmhQZuw4yxTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25D38605F1;
	Mon, 16 Nov 2026 03:30:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F5D51A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80B52400AA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwOTYqVZf6vf for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 03:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 465EE4008B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=I+lEPFJ9
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 465EE4008B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:00 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSYJj2GTTzKr6K;
 Mon, 16 Nov 2026 04:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794799797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdD5zV83d88+IzVKmWVU8Uetnt7Ud9wZagIsRkofgOM=;
 b=I+lEPFJ93IYyz7ougzAwKl9WAKKal879YQy4Dj6AlyUabVLsFfPXM7NoPw/L6mSBCzxmJ+
 DqtpUEUvpiikXmGD8a3bBEA2Iyg0yI5EhTTSkVaah6eRZCucsk9FCtw+0eh4xty7VsOTgs
 nvm6ix98+jwLEwoPt7reEfoj9SEqlzPDOt1SvOmiyJDo9ZYmuwSgdc3L4GxsmNmZv5Yq9K
 igFoCngY88OynpE5RN7wZ646B70xzCsoaiCNyG4v0BYhiiTzXRIfJcIZ1tSunfPIjocUBM
 GX3AF2UrnCEHRuhaDma4B6BkdXb5XCSnYedYpvF1YuW1hgc7tphwQ5pHarykRw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] remoteproc: renesas: Rename Cortex-R52 specific functions
Date: Mon, 16 Nov 2026 04:29:07 +0100
Message-ID: <20261116032949.3145053-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
References: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7534cd79f3d603e57f2
X-MBO-RS-META: rrk3jafnjij1jhtcf5duymub3sa9rcmb
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

Add _cr52 into the name of all Cortex-R52 specific functions
in the APMU remoteproc driver to clearly describe their purpose
and separate them from upcoming Cortex-A76 specific functions.
This is a preparatory change, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_apmu.c | 93 +++++++++++++++----------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/drivers/remoteproc/renesas_apmu.c b/drivers/remoteproc/renesas_apmu.c
index d5a28c663ce..aa07e0901e7 100644
--- a/drivers/remoteproc/renesas_apmu.c
+++ b/drivers/remoteproc/renesas_apmu.c
@@ -29,12 +29,12 @@
 #define APMU_CRBARP_CR_RBAR_ALIGN	0x40000
 
 /**
- * struct renesas_apmu_rproc_privdata - remote processor private data
+ * struct renesas_apmu_rproc_cr52_privdata - remote processor private data
  * @regs:		controller registers
  * @core_id:		CPU core id
  * @trampoline:		jump trampoline code
  */
-struct renesas_apmu_rproc_privdata {
+struct renesas_apmu_rproc_cr52_privdata {
 	void __iomem	*regs;
 	ulong		core_id;
 	u32		*trampoline;
@@ -44,7 +44,7 @@ struct renesas_apmu_rproc_privdata {
  * CRBARP address is aligned to 0x40000 / 256 kiB , this trampoline
  * allows arbitrary address alignment at instruction granularity.
  */
-static const u32 renesas_apmu_rproc_trampoline[4] = {
+static const u32 renesas_apmu_rproc_cr52_trampoline[4] = {
 	0xe59f0004,	/* ldr r0, [pc, #4] */
 	0xe1a0f000,	/* mov pc, r0 */
 	0xeafffffe,	/* 1: b 1b */
@@ -52,25 +52,25 @@ static const u32 renesas_apmu_rproc_trampoline[4] = {
 };
 
 /**
- * renesas_apmu_rproc_load() - Load the remote processor
+ * renesas_apmu_rproc_cr52_load() - Load the remote processor
  * @dev:	corresponding remote processor device
  * @addr:	Address in memory where image is stored
  * @size:	Size in bytes of the image
  *
  * Return: 0 if all went ok, else corresponding -ve error
  */
-static int renesas_apmu_rproc_load(struct udevice *dev, ulong addr, ulong size)
+static int renesas_apmu_rproc_cr52_load(struct udevice *dev, ulong addr, ulong size)
 {
-	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	struct renesas_apmu_rproc_cr52_privdata *priv = dev_get_priv(dev);
 	u32 trampolineaddr = (u32)(uintptr_t)(priv->trampoline);
 
 	priv->trampoline[3] = addr;
 	flush_dcache_range(trampolineaddr,
 			   trampolineaddr +
-			   sizeof(renesas_apmu_rproc_trampoline));
+			   sizeof(renesas_apmu_rproc_cr52_trampoline));
 	invalidate_dcache_range(trampolineaddr,
 				trampolineaddr +
-				sizeof(renesas_apmu_rproc_trampoline));
+				sizeof(renesas_apmu_rproc_cr52_trampoline));
 	flush_dcache_range(addr, addr + size);
 	invalidate_dcache_range(addr, addr + size);
 	asm volatile("dsb sy\n");
@@ -80,14 +80,14 @@ static int renesas_apmu_rproc_load(struct udevice *dev, ulong addr, ulong size)
 }
 
 /**
- * renesas_apmu_rproc_start() - Start the remote processor
+ * renesas_apmu_rproc_cr52_start() - Start the remote processor
  * @dev:	corresponding remote processor device
  *
  * Return: 0 if all went ok, else corresponding -ve error
  */
-static int renesas_apmu_rproc_start(struct udevice *dev)
+static int renesas_apmu_rproc_cr52_start(struct udevice *dev)
 {
-	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	struct renesas_apmu_rproc_cr52_privdata *priv = dev_get_priv(dev);
 	u32 trampolineaddr = (u32)(uintptr_t)(priv->trampoline);
 
 	/* CR52 boot address and valid flags set */
@@ -103,14 +103,14 @@ static int renesas_apmu_rproc_start(struct udevice *dev)
 }
 
 /**
- * renesas_apmu_rproc_stop() - Stop the remote processor
+ * renesas_apmu_rproc_cr52_stop() - Stop the remote processor
  * @dev:	corresponding remote processor device
  *
  * Return: 0 if all went ok, else corresponding -ve error
  */
-static int renesas_apmu_rproc_stop(struct udevice *dev)
+static int renesas_apmu_rproc_cr52_stop(struct udevice *dev)
 {
-	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	struct renesas_apmu_rproc_cr52_privdata *priv = dev_get_priv(dev);
 
 	/* Set APMU_CRRSTCTRL_CR52RST, the only bit in this register */
 	writel(APMU_CRRSTCTRL_CR52RST,
@@ -120,44 +120,44 @@ static int renesas_apmu_rproc_stop(struct udevice *dev)
 }
 
 /**
- * renesas_apmu_rproc_reset() - Reset the remote processor
+ * renesas_apmu_rproc_cr52_reset() - Reset the remote processor
  * @dev:	corresponding remote processor device
  *
  * Return: 0 if all went ok, else corresponding -ve error
  */
-static int renesas_apmu_rproc_reset(struct udevice *dev)
+static int renesas_apmu_rproc_cr52_reset(struct udevice *dev)
 {
-	renesas_apmu_rproc_stop(dev);
-	renesas_apmu_rproc_start(dev);
+	renesas_apmu_rproc_cr52_stop(dev);
+	renesas_apmu_rproc_cr52_start(dev);
 	return 0;
 }
 
 /**
- * renesas_apmu_rproc_is_running() - Is the remote processor running
+ * renesas_apmu_rproc_cr52_is_running() - Is the remote processor running
  * @dev:	corresponding remote processor device
  *
  * Return: 0 if the remote processor is running, 1 otherwise
  */
-static int renesas_apmu_rproc_is_running(struct udevice *dev)
+static int renesas_apmu_rproc_cr52_is_running(struct udevice *dev)
 {
-	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	struct renesas_apmu_rproc_cr52_privdata *priv = dev_get_priv(dev);
 
 	return readl(priv->regs + APMU_CRRSTCTRL(priv->core_id)) &
 	       APMU_CRRSTCTRL_CR52RST;
 }
 
 /**
- * renesas_apmu_rproc_init() - Initialize the remote processor CRBAR registers
+ * renesas_apmu_rproc_cr52_init() - Initialize the remote processor CRBAR registers
  * @dev:	corresponding remote processor device
  *
  * Return: 0 if all went ok, else corresponding -ve error
  */
-static int renesas_apmu_rproc_init(struct udevice *dev)
+static int renesas_apmu_rproc_cr52_init(struct udevice *dev)
 {
-	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	struct renesas_apmu_rproc_cr52_privdata *priv = dev_get_priv(dev);
 
 	/* If the core is running already, do nothing. */
-	if (renesas_apmu_rproc_is_running(dev))
+	if (renesas_apmu_rproc_cr52_is_running(dev))
 		return 0;
 
 	/* Clear and invalidate CRBARP content */
@@ -185,25 +185,25 @@ static void *renesas_apmu_rproc_device_to_virt(struct udevice *dev, ulong da,
 	return (void *)da;
 }
 
-static const struct dm_rproc_ops renesas_apmu_rproc_ops = {
-	.init		= renesas_apmu_rproc_init,
-	.load		= renesas_apmu_rproc_load,
-	.start		= renesas_apmu_rproc_start,
-	.stop		= renesas_apmu_rproc_stop,
-	.reset		= renesas_apmu_rproc_reset,
-	.is_running	= renesas_apmu_rproc_is_running,
+static const struct dm_rproc_ops renesas_apmu_rproc_cr52_ops = {
+	.init		= renesas_apmu_rproc_cr52_init,
+	.load		= renesas_apmu_rproc_cr52_load,
+	.start		= renesas_apmu_rproc_cr52_start,
+	.stop		= renesas_apmu_rproc_cr52_stop,
+	.reset		= renesas_apmu_rproc_cr52_reset,
+	.is_running	= renesas_apmu_rproc_cr52_is_running,
 	.device_to_virt	= renesas_apmu_rproc_device_to_virt,
 };
 
 /**
- * renesas_apmu_rproc_of_to_plat() - Convert OF data to platform data
+ * renesas_apmu_rproc_cr52_of_to_plat() - Convert OF data to platform data
  * @dev:	corresponding remote processor device
  *
  * Return: 0 if all went ok, else corresponding -ve error
  */
-static int renesas_apmu_rproc_of_to_plat(struct udevice *dev)
+static int renesas_apmu_rproc_cr52_of_to_plat(struct udevice *dev)
 {
-	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	struct renesas_apmu_rproc_cr52_privdata *priv = dev_get_priv(dev);
 
 	priv->core_id = dev_get_driver_data(dev);
 
@@ -212,12 +212,12 @@ static int renesas_apmu_rproc_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 
 	priv->trampoline = memalign(APMU_CRBARP_CR_RBAR_ALIGN,
-				    sizeof(renesas_apmu_rproc_trampoline));
+				    sizeof(renesas_apmu_rproc_cr52_trampoline));
 	if (!priv->trampoline)
 		return -ENOMEM;
 
-	memcpy(priv->trampoline, renesas_apmu_rproc_trampoline,
-	       sizeof(renesas_apmu_rproc_trampoline));
+	memcpy(priv->trampoline, renesas_apmu_rproc_cr52_trampoline,
+	       sizeof(renesas_apmu_rproc_cr52_trampoline));
 
 	return 0;
 }
@@ -225,9 +225,9 @@ static int renesas_apmu_rproc_of_to_plat(struct udevice *dev)
 U_BOOT_DRIVER(renesas_apmu_cr52) = {
 	.name		= "rcar-apmu-cr52",
 	.id		= UCLASS_REMOTEPROC,
-	.ops		= &renesas_apmu_rproc_ops,
-	.of_to_plat	= renesas_apmu_rproc_of_to_plat,
-	.priv_auto	= sizeof(struct renesas_apmu_rproc_privdata),
+	.ops		= &renesas_apmu_rproc_cr52_ops,
+	.of_to_plat	= renesas_apmu_rproc_cr52_of_to_plat,
+	.priv_auto	= sizeof(struct renesas_apmu_rproc_cr52_privdata),
 };
 
 /**
@@ -238,21 +238,20 @@ U_BOOT_DRIVER(renesas_apmu_cr52) = {
  */
 static int renesas_apmu_rproc_bind(struct udevice *parent)
 {
-	const ulong cr52cores = RCAR4_CR52_CORES;
 	ofnode pnode = dev_ofnode(parent);
+	struct driver *cdrvr52;
 	struct udevice *cdev;
-	struct driver *cdrv;
 	char name[32];
 	ulong i;
 	int ret;
 
-	cdrv = lists_driver_lookup_name("rcar-apmu-cr52");
-	if (!cdrv)
+	cdrvr52 = lists_driver_lookup_name("rcar-apmu-cr52");
+	if (!cdrvr52)
 		return -ENOENT;
 
-	for (i = 0; i < cr52cores; i++) {
+	for (i = 0; i < RCAR4_CR52_CORES; i++) {
 		snprintf(name, sizeof(name), "rcar-apmu-cr52.%ld", i);
-		ret = device_bind_with_driver_data(parent, cdrv, strdup(name),
+		ret = device_bind_with_driver_data(parent, cdrvr52, strdup(name),
 						   i, pnode, &cdev);
 		if (ret)
 			return ret;
-- 
2.53.0

