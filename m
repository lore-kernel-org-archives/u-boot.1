Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AB5C98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B38E340D16;
	Thu, 24 Sep 2026 12:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWCFRzGNBkuM; Thu, 24 Sep 2026 12:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D406240853
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253395;
	b=F+BbsnDJrcPY71o4Re72J1k9+J+9blMYNvyXmtc06yUwcQMuCYQLx08hoiFBZIzh3dKb
	 yxciDJEREGusSi9qmH2itvDS5YkExwdcf7O2MbxGheWqseVbTiiPTGOTe52V9rs7jqe5n
	 kZKPJMKPookFmQVIuQZeb6PDxxCAHhZICJ4HKkXugdP3Vtbz9JrKLMcl7Rk+4R6CYfZLU
	 c2stuWSNBGZ7Yin5xsFhriEUCI4dMw/pPD7bVB3GTa/oXlG5aYozM7gtDZT/a5T5uSkD6
	 xm61ExDDMebww3ri3lb4t094m1YG6AY85wjOjf3xqjgsyNiPj3z4c8K4kmJK2QH00qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HZHntcANR1tfwmsH1EX3l/i2KA6e6brRE/uT0yGiv7k=;
	b=V7MpKafm10GwxpIl6c1O39x20FUw10ZkEUXHrIQ9nCvKrssedSFVeFvYRcHcIWL0vz8p
	 yVbtc4+lTb7xpmpRKI+3llJeXmsXEHkdYMJ2Itgk9kzii7U0uFm/Z0jE6RNe9xRKwNtAs
	 39EDXzdMtAofL2QiPMuFk+qdprqXivfFHz2yfFJy464P1t38vYk2A9K+1nM6J+QADJBH3
	 jQYashGGgmts2nWcsSesnpekXwHNY9OuNLZzw0sHTzOoMAMVJoTzZ/mPnvIyH8pT0twPy
	 1VphpJzbNKlQKd70hii3AOr7w9UoaX2DOnLUCKmcjfnBH/mLTugwGTpo1w3NpLZRqEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253395;
	bh=HZHntcANR1tfwmsH1EX3l/i2KA6e6brRE/uT0yGiv7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UEJumY9XMZIhQ0MsmPeN3jui0cECDxKjfk1wH++696gVg7gZ/MVpY+rLshBmGVmti
	 CFa+ZhFxKYHKhXtOPuYf+K0W1h8OZxsP6q3/m7nlrULY2IvDeFcnryo0EiNnvX67ia
	 CvIYevoQilH4pu6chx6uLLVmy5qDehhfVopF0ciPk0quOTK9c0nm9sYtT/XfAr1wQs
	 pqzEsofCrTODD57zmsdjYTP6YQKkuxDywOss1ot7zD+5IvAfpED66qiggm60CwiMU9
	 +F1gX7Kc0Fx0rPiC5ylqvHu034QuLQVt6ZaDR4LATzMCyqj3ZVoyQ6AJjkxn1Nc0aP
	 T8Mry1s+qkatg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D406240853;
	Thu, 24 Sep 2026 12:36:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30E70194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AC7881D67
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0X66RcH3VyRt for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5614C81D5A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253392;
 b=YtqL0XSKiLhdtJUfddvwuMXRE5gKOyCGTFt+njDDLV1ETCI6pkGMTKvOztcIjTTvhvzY
 aGx1EDnKBAMPPLJ4SS25d6EXj0i2pUhZAyPwTDqGL1VPQJgzDdOmYUxxieICv0x9cW3UQ
 KD8bG2I6IBVPggnEU+WYvUGLFvF0RVMsesdnGYclYQmDXJ4syryKq1z/MuBP78mp9/hny
 +lAeGs5GypFg+VshSMD4Vu2bWZmDDd9M0499fZlFfFZpbv97qNVjp6Y1ws1DtxjUnR1pk
 KZbRY9pfVpjO2KqF/wgAwvY1jxu5F+cBVXuHPVTSQ2aX8PNar1ItzgajO4faolO4pcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253392;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=HZHntcANR1tfwmsH1EX3l/i2KA6e6brRE/uT0yGiv7k=;
 b=CVTdytssgw/DbLkyPK1QTagzOZB9tOXac/lRV1YFIlrD+E4og25nWX9ZAFaSe9xYZWv/
 7PxAl7tjZqCwq50qWq/JhAl4Z664tTo8wIoGAGC9a062EKpuoO1zeY5ss8olj6HY9WZKF
 aXZbOFt0bcpKfBdViEV4aQb4sxgCilWDmZX5oYXQHfebKBDLm35f/stoZGv21qciTEWxi
 0OFF9YoUG4fjl3sF+/jVj438ppf/jIfHbXwJCvnCL/TBgR8wbGW7GFBPuAI3XMziOjbjh
 tX9jTTbjjztkE9vV6HhsIhLHoC1KKt44ioD3oQxkml/TKrKbC5M4vPDOv7euSO8mpsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=cJYVCjrX; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=cJYVCjrX
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5614C81D5A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5ABA81A1000;
 Thu, 24 Sep 2026 12:36:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2687B60341;
 Thu, 24 Sep 2026 12:36:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5CC4610329407; 
 Thu, 24 Sep 2026 14:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253388; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=HZHntcANR1tfwmsH1EX3l/i2KA6e6brRE/uT0yGiv7k=;
 b=cJYVCjrXFs52vd4b2Cv/bd1vOuGSZK4FWCuRc/BT81OyRY+0PL/B/UbvbWBB5LUTZmbII4
 BKojIBBjVybwaovE7fDrSagUq3yjhhNlwdLEgVMmiBqFIMDZPB1ORG9U5WNVqPeTE8X+lY
 EY+C5H5McdHXY5zaROy7XXQsIrS0U9cmCwUmaigHNVLMrCFfSpXrkNt79uADSPPUPr5CBd
 AKWZJqrmXztwH1e1e0XvUKARQAndX6wC6JxW/AcdZJuHuUhZ/RJn7A+H55Ki7ilEjU6bOj
 feePPMAzMOpcSeTofF3hp5TC0SZGjq1uGEeTyxcTeX33+OBKFS4ES2fmzz7cwQ==
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
Subject: [PATCH v6 08/22] board: mach-k3: r5: common: enable GTC after
 core_resume
Date: Thu, 24 Sep 2026 14:35:19 +0200
Message-ID: <20260924123533.2599438-9-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abhash Kumar Jha <a-kumar2@ti.com>

The GTC counter values are restored in the resume sequence by TIFS as
part of the core_resume API. Enable GTC counter after it is restored.

Also add a check to make sure that rproc_load only enables the GTC counter
in the case of a cold boot.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
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
-- 
2.55.0

