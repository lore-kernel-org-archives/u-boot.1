Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E0C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19819833AD;
	Fri, 30 May 2025 17:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BA38331C; Fri, 30 May 2025 17:38:35 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D3C801BE
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uL1oV-007QGb-Ik;
 Fri, 30 May 2025 15:38:31 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 5/5] net: lwip: wget: initialize dns if a hostname is used
 in a URL
Date: Fri, 30 May 2025 08:38:26 -0700
Message-Id: <20250530153826.1057407-5-tharvey@gateworks.com>
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

Initialize dns servers if a hostname (vs ipaddr) is used in a URL.
Otherwise the wget will fail without displaying an error due to
dns_gethostbyname failing silently when no DNS servers are set unless
you have previously performed a 'dns <arg>' command.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
---
v2:
 - added tags
---
 net/lwip/wget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index fcaf684e61da..2ca369db65a1 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -460,6 +460,10 @@ int wget_do_request(ulong dst_addr, char *uri)
 	if (!netif)
 		return -1;
 
+	/* if URL with hostname init dns */
+	if (!ipaddr_aton(ctx.server_name, NULL) && net_lwip_dns_init())
+		return CMD_RET_FAILURE;
+
 	memset(&conn, 0, sizeof(conn));
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	if (is_https) {
-- 
2.25.1

