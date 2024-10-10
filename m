Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB104CF07B8
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 07:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFE988FEC;
	Thu, 10 Oct 2024 09:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ynIz/doZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BF5891CF; Thu, 10 Oct 2024 09:09:24 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA38F88FE1
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 09:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49A79DGA035143;
 Thu, 10 Oct 2024 02:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728544153;
 bh=8OOZ22eKhmFyYKrmbs9q0qiL09XlAbxKNccn8Cn5KQg=;
 h=From:To:CC:Subject:Date;
 b=ynIz/doZkASBsf2CH/TBJErVh3RJ4tYKZgV2EbB/r4I8zjbm/ME0OGI8KsydpWMMW
 UaVB+5Q/QSIbc8LlJUoT9/JyT7exvfTfdWs44qU5NyyTSatYxHWLrZkbuhXTsGxrVr
 HxjAZb66KnKCbeY9KK/wfm2dmkikLzOtwEqo/a9I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49A79DBr094545
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Oct 2024 02:09:13 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 02:09:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 02:09:13 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49A79ACV100369;
 Thu, 10 Oct 2024 02:09:11 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <sjg@chromium.org>, <devarsht@ti.com>, <jonas@kwiboo.se>, <richard@nod.at>,
 <raymond.mao@linaro.org>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] boardf: Modify DRAM message
Date: Thu, 10 Oct 2024 12:39:09 +0530
Message-ID: <20241010070909.288313-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
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
modify the message to show exactly what is meant:

"DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 154675d0e40..b7add8f7d3d 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -254,7 +254,7 @@ static int show_dram_config(void)
 
 	print_size(gd->ram_size, "");
 	if (!sizes_near(gd->ram_size, size)) {
-		printf(" (effective ");
+		printf(" (available for U-Boot out of total ");
 		print_size(size, ")");
 	}
 	board_add_ram_info(0);
-- 
2.34.1

