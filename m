Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85E606A33E
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d+5Sj08B;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=vLcgAzT4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05C0180DDD;
	Mon, 16 Nov 2026 03:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id es-XCB3cdgf0; Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 332DC80CBF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799802;
	b=abo5yfJ6oz4LQznusTfjNluXOQ7KlK3Z7qoQAxe93hEqEnlFF2j8QnGNAqoMPtGywxf5
	 MmQ6JhWF+gX0ANxSp1/SIBiUL3OtN+ezleeVO3SxHkqALSnBJNEXRPGNLku1V05kGZbEd
	 Gnw1U9ug2sHWdHKRrc9D/VeK0a/ZKQBxnJ/JvS6giMpc+JdbgKSRuH+Vdwyq0Y5nNENSu
	 yL+PNstfWtSq0MEdIo3fJ/w3T8OTAWPfsgyxVM2NkeOuGz4jBC0Y0VQ2jx+QataSPYdgq
	 z1ITzTnhLmrWLX/gmzweyJHOmfOHA8mbCJ4vEfS5GVYaj6VqWOMdWkJjwbv9+BXl5hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QuZJ+dmjMPSiMI8BMFdUCvooBJM27XCoZORTXc3elOE=;
	b=ARXEU59jhmjKTRojUsS0aph3HYwjFfOCMjv/bfoRjATYprD0eBwfyXgmHWXbJfS3dL4F
	 bYDF1DVU4pETAgaMnUNhU05dABeGzgsbT5qQEm6KLxvyIwNqebjWFAjjZ9EUoCs7man9p
	 EXYHuGWzxGL16gq6CB9gBdZG+8Jow+175qW8GtWUi85woe2pOrRMgmlJI0Taebpfxnhje
	 GMZeMDBKHUkkFwZsqpCMSzjwOSXLTHj+XwEF6GWPyMfKDzsmFOnTzlWp9IWbgYwJ3TGAM
	 DtAJVXM0TQTiZPvX1Fsy//grXqcXGio9H7hvOYxvrwBG49VaSm8Z7wlw+SnJawx/LJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794799802;
	bh=QuZJ+dmjMPSiMI8BMFdUCvooBJM27XCoZORTXc3elOE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d+5Sj08BCvd254oFb2n0I4pa98RWI9XvU6kvDVMcnNCI2CiVcK7qZxqxrKxRI1HB+
	 AjNeGEZUst7/MV7p6lYIcYfLGgUO8duiEX4FiPanrM1+Z68aQCCsu/9f5+HuVPvy1V
	 DVgjgp+FBsdxt8aZ8sMslNQ39/XhzlOAP7u1lYqyk3poL7XkTadIzyoF9aYU/Ry6br
	 iu7xwRzA/m8xo++7y8+XMzzNf5QtQZo4tNicMp391TwoHA2xRlr8dK5IXQ5+FY7XjW
	 xOO90rCEiNFqcwTTMbZh8WtZ0JsLxyHROJgaRxORW6NldR+GZwxW7SqaqcO29Spryw
	 Uy6HTzeLpGkSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 332DC80CBF;
	Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0113D7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBAEB605F1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjFNwb9kMdSz for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 03:30:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6006605DF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vLcgAzT4
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6006605DF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:29:59 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSYJg5gJYz8v4B;
 Mon, 16 Nov 2026 04:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794799795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QuZJ+dmjMPSiMI8BMFdUCvooBJM27XCoZORTXc3elOE=;
 b=vLcgAzT4cirsXoJKoPxtNGX1UAiEMVP+OHd0+/hrgeD13MrXqG/tBFu+XbKKjRWQYbPHRL
 id+V/eEsaG95UMLarLKyN9dhy0NVgXZqFo4Oh3Iekta6bLcRqYfK0WQI6vD3awc3sMLBz2
 CXRodVZzmxNmVW3iwxz//UbF9RzKVbhzahEFbEozjjwJvXvLBRIbytxcoluHCMSJbrTBGq
 ybKDYk/3qN6+MfNXODnDnoMarYEvGpOwfOnPkdsY5OC/ShLdGuIXps7X9mo9UxCN+u9rUm
 T7VR+rbMomBUAhbmvqln8BHR0D/8OIVZcf+7Wi4cAG4QBQDNEGnNRY5EVDh5ZQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] remoteproc: renesas: Set valid Cortex-R52 BAR flags only
 in .start callback
Date: Mon, 16 Nov 2026 04:29:05 +0100
Message-ID: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0e4a70f532466f159d8
X-MBO-RS-META: b1cmjoesphiej5k9jesow11j4eyi8x7t
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

Set valid Cortex-R52 BAR flags only in .start callback to prevent early start
of Cortex-R52 core 0 in .load callback.

In case the Cortex-R52 is the boot core, then the Cortex-R52 core is spinning
on a spin table implemented in arch/arm/mach-renesas/include/mach/boot0.h ,
which polls for valid flags in BAR register before allowing the core to
proceed with a jump to its entry point. Those valid flags in BAR register
must therefore be set only in .start callback to prevent the core from
jumping early, right after the .load callback.

Cortex-R52 cores 1 and 2 are not affected by this, neither is core 0 in case
it is not a boot core.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_apmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/renesas_apmu.c b/drivers/remoteproc/renesas_apmu.c
index 91586a99e0d..d5a28c663ce 100644
--- a/drivers/remoteproc/renesas_apmu.c
+++ b/drivers/remoteproc/renesas_apmu.c
@@ -76,12 +76,6 @@ static int renesas_apmu_rproc_load(struct udevice *dev, ulong addr, ulong size)
 	asm volatile("dsb sy\n");
 	asm volatile("isb sy\n");
 
-	/* CR52 boot address set */
-	writel(trampolineaddr | APMU_CRBARP_CR_VLD_BARP,
-	       priv->regs + APMU_CRBARP(priv->core_id));
-	writel(trampolineaddr | APMU_CRBARP_CR_VLD_BARP | APMU_CRBARP_CR_BAREN_VALID,
-	       priv->regs + APMU_CRBARP(priv->core_id));
-
 	return 0;
 }
 
@@ -94,6 +88,13 @@ static int renesas_apmu_rproc_load(struct udevice *dev, ulong addr, ulong size)
 static int renesas_apmu_rproc_start(struct udevice *dev)
 {
 	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	u32 trampolineaddr = (u32)(uintptr_t)(priv->trampoline);
+
+	/* CR52 boot address and valid flags set */
+	writel(trampolineaddr | APMU_CRBARP_CR_VLD_BARP,
+	       priv->regs + APMU_CRBARP(priv->core_id));
+	writel(trampolineaddr | APMU_CRBARP_CR_VLD_BARP | APMU_CRBARP_CR_BAREN_VALID,
+	       priv->regs + APMU_CRBARP(priv->core_id));
 
 	/* Clear APMU_CRRSTCTRL_CR52RST, the only bit in this register */
 	writel(0, priv->regs + APMU_CRRSTCTRL(priv->core_id));
-- 
2.53.0

