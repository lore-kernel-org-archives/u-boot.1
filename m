Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53150F36C51
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CCB83E16;
	Mon, 20 Apr 2026 10:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=secom.com.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=secom.com.pl header.i=@secom.com.pl header.b="QAJm11bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C920C8426E; Mon, 20 Apr 2026 09:46:53 +0200 (CEST)
Received: from mail.secom.com.pl (mail.secom.com.pl [213.216.87.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EF483693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=secom.com.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rafal.hibner@secom.com.pl
From: =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.secom.com.pl 346A943FF65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=secom.com.pl;
 s=default; t=1776671207;
 bh=xORqtN/eo/TCOMmpsDLyJPTyrFpsWAsaEf+WoOwUkxA=;
 h=From:To:Cc:Subject:Date;
 b=QAJm11bN/gFwFDPe9UlfJiNBAU6NXy2yLjO332Nqr5gy7cf5EF7gwKXKz4w1KYx7r
 jxrNVvduWna18Xqw2p7cNAwGZvS6wICqhtKOvTDExgNGrKcB6KSvBZUyO1gajNhM/3
 H10uQpgJxQesLiUZQ1Aul01ik9Zqdg+A6zbsILo0=
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome@forissier.org, trini@konsulko.com, venkatesh.abbarapu@amd.com,
 martin.kaistra@linutronix.de,
 =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>
Subject: [PATCH] net: zynq_gem: Clear stale speed bits in NWCFG before setting
 new ones
Date: Mon, 20 Apr 2026 07:46:40 +0000
Message-ID: <20260420074640.4036119-1-rafal.hibner@secom.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailScanner-ID: 346A943FF65.A1566
X-MailScanner: Found to be clean
X-MailScanner-From: rafal.hibner@secom.com.pl
X-Mailman-Approved-At: Mon, 20 Apr 2026 10:08:02 +0200
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

Commit ecba4380ad26 ("net: zynq_gem: Update the MDC clock divisor in the
probe function") changed zynq_gem_init() from a direct register write to
a read-modify-write pattern in order to preserve MDC clock divider bits.
However, the old speed selection bits (SPEED100/SPEED1000) are never
cleared before OR-ing in the new value.

When the PHY renegotiates at a different speed between successive calls
to zynq_gem_init() (e.g. link flapping from 1 Gbps to 100 Mbps on a
marginal cable), both SPEED100 and SPEED1000 end up set simultaneously
in NWCFG. This confuses the GEM hardware and no frames are received.

Fix by explicitly clearing both speed bits before merging the new
configuration, so only the currently negotiated speed is ever active.

Fixes: ecba4380ad26 ("net: zynq_gem: Update the MDC clock divisor in the probe function")
Signed-off-by: Rafał Hibner <rafal.hibner@secom.com.pl>
---
 drivers/net/zynq_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 407b022508c..f18458aee98 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -612,6 +612,7 @@ static int zynq_gem_init(struct udevice *dev)
 		break;
 	}
 	nwcfg = readl(&regs->nwcfg);
+	nwcfg &= ~(ZYNQ_GEM_NWCFG_SPEED100 | ZYNQ_GEM_NWCFG_SPEED1000);
 	nwcfg |= nwconfig;
 	if (nwcfg)
 		writel(nwcfg, &regs->nwcfg);
-- 
2.43.0

