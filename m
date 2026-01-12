Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94A7CF45BB
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 18:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CBF8382A;
	Mon, 12 Jan 2026 19:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F4083885; Mon, 12 Jan 2026 19:13:25 +0100 (CET)
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs
 [93.87.244.166]) by phobos.denx.de (Postfix) with ESMTP id A8CCA83759
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 19:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from om.arvanta.net (mbp.arvanta.net [10.5.1.19])
 by fx.arvanta.net (Postfix) with ESMTP id 16FA810EE;
 Mon, 12 Jan 2026 19:13:23 +0100 (CET)
From: =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v1] tools: fix format string in tools/imx8image.c
Date: Mon, 12 Jan 2026 19:12:37 +0100
Message-ID: <20260112181304.2112-1-mps@arvanta.net>
X-Mailer: git-send-email 2.52.0
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

on 32bit systems with musl libc compiler emits
warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]

to fix this use format length modifier 'z' (size_t) instead of 'l'

Signed-off-by: Milan P. Stanić <mps@arvanta.net>
---
 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 3cea536b8e8..84f46bcaf37 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -815,7 +815,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align, u
 
 	p = calloc(1, size);
 	if (!p) {
-		fprintf(stderr, "Fail to alloc %lx memory\n", size);
+		fprintf(stderr, "Fail to alloc %zx memory\n", size);
 		exit(EXIT_FAILURE);
 	}
 
-- 
2.52.0

