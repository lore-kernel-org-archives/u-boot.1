Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13713C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0AA8856F;
	Fri,  7 Jun 2024 20:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43BE088445; Fri,  7 Jun 2024 20:55:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 96C6888445
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 804EB1480;
 Fri,  7 Jun 2024 11:55:27 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 556C93F792;
 Fri,  7 Jun 2024 11:55:00 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 28/31] cmd: bdinfo: only dump the current LMB memory
Date: Sat,  8 Jun 2024 00:22:37 +0530
Message-Id: <20240607185240.1892031-29-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The LMB memory map is now persistent and global. There is therefore no
need to add memory to the LMB memory map as part of the bdinfo
command. Only dump the current available and reserved memory as part
of the bdinfo command.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 cmd/bdinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index fc408e9820..0f343203ef 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -163,7 +163,6 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
 #endif
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
-		lmb_add_memory(gd->bd);
 		lmb_dump_all_force();
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			printf("devicetree  = %s\n", fdtdec_get_srcname());
-- 
2.34.1

