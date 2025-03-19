Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDE9C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A5F81D5A;
	Wed, 19 Mar 2025 15:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ns8N3qrx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C581D81DCD; Wed, 19 Mar 2025 15:03:49 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA25D81D5A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JE3aCa2909816
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 09:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742393016;
 bh=BzUhH61pWtKusoqORP8e5OFJ/eEG5SSm1LMkDjV8jbc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ns8N3qrxXCzGR+G1wkpx7ix6aUOnHBFRYnp/O7kw83Xd2PqfwnTgF1csdsjx9EIlP
 HizgJX0uu1gn1wWzigszDOuvpU8+WFqaM5Ag/FPDRJQbwDC2achoFWcMmIaX7aCDL5
 pVvoL5KAHulCs4stntgBvzF+IIaR8AuE9VkPGPYM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JE3a8S086045
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Mar 2025 09:03:36 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 09:03:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 09:03:36 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JE3RD9034958;
 Wed, 19 Mar 2025 09:03:32 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <u-kumar1@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <devarsht@ti.com>,
 <quentin.schulz@cherry.de>, <j-choudhary@ti.com>, <jonas@kwiboo.se>,
 <richard@nod.at>, <raymond.mao@linaro.org>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>
Subject: [PATCH v2 1/2] board_f: Modify DRAM message
Date: Wed, 19 Mar 2025 19:33:26 +0530
Message-ID: <20250319140327.301266-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319140327.301266-1-n-francis@ti.com>
References: <20250319140327.301266-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
modify the message s/effective/total to make it more evident.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 99616fdac80..9bbbf733f54 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -254,7 +254,7 @@ static int show_dram_config(void)
 
 	print_size(gd->ram_size, "");
 	if (!sizes_near(gd->ram_size, size)) {
-		printf(" (effective ");
+		printf(" (total ");
 		print_size(size, ")");
 	}
 	board_add_ram_info(0);
-- 
2.34.1

