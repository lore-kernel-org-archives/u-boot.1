Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28ACC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFDE782F85;
	Mon,  7 Apr 2025 19:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66D882F85; Mon,  7 Apr 2025 19:05:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 47AA882E76
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1C6D1424;
 Mon,  7 Apr 2025 10:05:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.17.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3664B3F59E;
 Mon,  7 Apr 2025 10:05:47 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] fwu: developerbox: fix dfu alt buffer clearing
Date: Mon,  7 Apr 2025 19:05:25 +0200
Message-ID: <20250407170529.893307-2-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250407170529.893307-1-vincent.stehle@arm.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
macro to declare a `buf' variable pointer into an array allocated on the
stack. It then calls the memset() function to clear the useable portion
of the array using the idiomatic expression `sizeof(buf)'.

While this would indeed work fine for an array, in the present case we
end up clearing only the size of a pointer.
Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.

Fixes: 6b403ca4dcf4 ("fwu: DeveloperBox: add support for FWU")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
---
 board/socionext/developerbox/fwu_plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/socionext/developerbox/fwu_plat.c b/board/socionext/developerbox/fwu_plat.c
index 26031795b09..a8b111477ef 100644
--- a/board/socionext/developerbox/fwu_plat.c
+++ b/board/socionext/developerbox/fwu_plat.c
@@ -18,7 +18,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	struct mtd_info *mtd;
 	int ret;
 
-	memset(buf, 0, sizeof(buf));
+	memset(buf, 0, DFU_ALT_BUF_LEN);
 
 	mtd_probe_devices();
 
-- 
2.47.2

