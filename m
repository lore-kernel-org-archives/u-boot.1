Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7115EE49AB
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E8D864CB;
	Wed, 23 Aug 2023 02:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uCWO/I9T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P6joEx14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68BC5864B8; Wed, 23 Aug 2023 02:18:48 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FAEE864B8
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RVmz82C7Pz9sbC;
 Wed, 23 Aug 2023 02:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UF8WoDXGsZKl2NEMNmi7C3y6yvZoZJKKXfxn5EDifq0=;
 b=uCWO/I9TGu1HEbInogQ7MROYpUrfw5SHBj0j9jaV+bfUoAdmKlo3ilPWJqgND2DmCfeqkz
 NzbS0fGGbJDFMiGlJc5SYNqPtNJrugJ2U6iZWbq92FPFp2T9RDQVPrP5hiUnPC/cCkRYwu
 YCB4WeHsQMEbmhbfV7NoLJpuxzmfBTB1SkAP/Syhzc4bJWZKTU4Ud+aLB+pQqKKArfVT+J
 JX3YS6le4FOI5u3ThWCliEgIQZCEfxBxQA+Y0f0IPBITQOKEb3bUQFB2UYJgOMlUb/8Wb1
 3WuXESdWjfr1n1a2BI2YEk9zvPntKWjEKv9N8dtfmMlZ0ZAxnZUCMBu2Y0JL+Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UF8WoDXGsZKl2NEMNmi7C3y6yvZoZJKKXfxn5EDifq0=;
 b=P6joEx14L52hq05ra3eMIBUP4xLoAs8k6EduvaTb++lEcUO+MmFIb7zhKZpYKa1nO5MXKz
 mih3thQ0TY/iiNMHE7kP1db73KMZMFDjEa+aLQi04biYziyPs/XEGBac3vkAVTTDJp+BMn
 20onaehl1kovO/ZyGdTr+SVFonz/TTYpnYIlOrxPNmoNs+XJ831XhQXZQddoszmE+soZAf
 bYkZ/s5SRKMT6YyMBgQUnuzF2foKgQ8m+acXQXV/2cpeERShqixJi9gRsrRo9Hl7Wu4bPr
 G9tVlovitok/FJJe9wfjySPWATHTAU2yuRyvEIc0sly0XwqziLXTvWWhWDnpSQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/5] drivers/mtd/nvmxip: Print phys_addr_t without warnings
 on both 32bit and 64bit systems
Date: Wed, 23 Aug 2023 02:18:19 +0200
Message-Id: <20230823001821.266578-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: x78nggqpkgnydh7btwzf4gek734xb6q3
X-MBO-RS-ID: c3bc17dd0df7b909a48
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

Cast the address such that it can be printed without warnings
on both 32bit and 64bit systems. This really should use some
better print formatter, but for the lack of it, do it this way.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: New patch
---
 drivers/mtd/nvmxip/nvmxip_qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
index 1bf0d311fe3..4d7471118a4 100644
--- a/drivers/mtd/nvmxip/nvmxip_qspi.c
+++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
@@ -50,8 +50,8 @@ static int nvmxip_qspi_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	log_debug("[%s]: XIP device base addr: 0x%llx , lba_shift: %d , lbas: %lu\n",
-		  dev->name, plat->phys_base, plat->lba_shift, plat->lba);
+	log_debug("[%s]: XIP device base addr: 0x%p , lba_shift: %d , lbas: %lu\n",
+		  dev->name, (void *)(uintptr_t)plat->phys_base, plat->lba_shift, plat->lba);
 
 	return 0;
 }
-- 
2.40.1

