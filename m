Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E9CC47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3F3879C3;
	Sun, 21 Jan 2024 18:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T8GcZTqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61E8878FA; Sun, 21 Jan 2024 18:44:09 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E455B878FA
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TJ11f12Knz9sQH;
 Sun, 21 Jan 2024 18:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705859046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDAHFfrrb+0/Nk0iOFYQoT6MYkOkCVcT2okPkcgJKUU=;
 b=T8GcZTqUJG1ZlqtSU6A+cK4j0igY0HA/0Rv4OafLKQAQ7W85dx88QnhHOKHe/7fQ3fljnw
 p+BwWazfxZc+yyOpvMZtdnU02tvsyIIVADr4Ltw5Lel7Z81Y7eQi+lIITSx9hday0zbvdK
 QuzhaA8n9iB5wpC2YUbXj2/dxTHeEteElql55ffYvq1BfxMLrh/A/y/WfXaL/PSNELqi2O
 fR9gXRTDGgfwwbF+qO8pbR7oWNn5moL/bIBtb40AKLbIGNrzl4k5YECVb0yk6FB56F9/wC
 CC9fR+7A/bn6FdV5OdG98nlUTX85nL4PmCCvlGXX5sCtTqWv1EfSyfsypUfH5Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 06/11] mtd: spi: renesas: Add R8A779H0 V4M support
Date: Sun, 21 Jan 2024 18:41:09 +0100
Message-ID: <20240121174340.279465-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3dnpzirk4h99udwgborygbiq186iaq55
X-MBO-RS-ID: a283f812f399d09c62e
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

From: Hai Pham <hai.pham.ud@renesas.com>

Support RPC SPI on R8A779H0 V4M SoC.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/spi/renesas_rpc_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 51c37d72eb6..3eb14061c81 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -215,7 +215,8 @@ static u32 rpc_spi_get_strobe_delay(void)
 	if (cpu_type == RMOBILE_CPU_TYPE_R8A7796 && rmobile_get_cpu_rev_integer() == 1)
 		return RPC_PHYCNT_STRTIM(6);
 	else if (cpu_type == RMOBILE_CPU_TYPE_R8A779F0 ||
-		 cpu_type == RMOBILE_CPU_TYPE_R8A779G0)
+		 cpu_type == RMOBILE_CPU_TYPE_R8A779G0 ||
+		 cpu_type == RMOBILE_CPU_TYPE_R8A779H0)
 		return RPC_PHYCNT_STRTIM2(15);
 	else
 #endif
-- 
2.43.0

