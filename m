Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FA2C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 21:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03CF88319F;
	Thu, 29 May 2025 23:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A0D82F8E; Thu, 29 May 2025 23:49:29 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62EE582AFC
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 23:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uKl7t-007IAa-P1;
 Thu, 29 May 2025 21:49:25 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 6/6] net: lwip: wget: use loadaddr env var for default address
Date: Thu, 29 May 2025 14:49:10 -0700
Message-Id: <20250529214910.984024-6-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529214910.984024-1-tharvey@gateworks.com>
References: <20250529214910.984024-1-tharvey@gateworks.com>
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

The loadAddress is optional and defaults to image_load_address
which should be initialized to the 'loadaddr' env variable like the
legacy stack (CONFIG_NET) does.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 net/lwip/wget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 76401991bde6..ff8dbdc08d9b 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -579,7 +579,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 			return CMD_RET_USAGE;
 		url = argv[2];
 	} else {
-		dst_addr = image_load_addr;
+		dst_addr = env_get_ulong("loadaddr", 16, image_load_addr);
 		url = argv[1];
 	}
 
-- 
2.25.1

