Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A245C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0FA8331C;
	Fri, 30 May 2025 17:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FF38338D; Fri, 30 May 2025 17:38:35 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 491A98331C
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uL1oU-007QGb-1P;
 Fri, 30 May 2025 15:38:30 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 3/5] net: lwip: tftp: add support for setting blocksize at
 runtime
Date: Fri, 30 May 2025 08:38:24 -0700
Message-Id: <20250530153826.1057407-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530153826.1057407-1-tharvey@gateworks.com>
References: <20250530153826.1057407-1-tharvey@gateworks.com>
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

Add support for setting the blocksize at runtime via the tftpblocksize env
variable as such is done with the legacy stack (CONFIG_NET).

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
v2:
 - added tags
---
 net/lwip/tftp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 7495dc077ba5..e7502a0cbab1 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -156,8 +156,10 @@ static void no_response(void *arg)
 static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 		     ip_addr_t srvip, uint16_t srvport)
 {
+	int blksize = CONFIG_TFTP_BLOCKSIZE;
 	struct netif *netif;
 	struct tftp_ctx ctx;
+	const char *ep;
 	err_t err;
 
 	if (!fname || addr == 0)
@@ -186,7 +188,10 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!(err == ERR_OK || err == ERR_USE))
 		log_err("tftp_init_client err: %d\n", err);
 
-	tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
+	ep = env_get("tftpblocksize");
+	if (ep)
+		blksize = simple_strtol(ep, NULL, 10);
+	tftp_client_set_blksize(blksize);
 
 	ctx.start_time = get_timer(0);
 	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
-- 
2.25.1

