Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491AEC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 10:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887CE807AE;
	Thu, 20 Mar 2025 11:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="k89z/ziG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92E280F0E; Thu, 20 Mar 2025 11:34:37 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id A10B78001F
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 11:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1742466865;
 bh=d/vKs1ouUug6VIR5sMkiAL5/gCKdyIzX5ihwLnmJUYs=;
 h=From:To:CC:Subject:Date:From;
 b=k89z/ziG3sfgBIiUwcHjlCJvam6OrxZ1xsWzib41WcNj2MnNdjT8rOgDwy4rm3dm7
 Beo7SJ7ATJ2395xBgfApnpgDHYj/b70GWARPc20uv0OuYXaxJiKr56jMJ3qAK03Pxl
 pcFljhHTP4K7lvSSGcUKq0WFc6Q3S3/8lyGw6FACTNP2ndug/9hp6FV4binC42RCVx
 mIbIqBlkW5hr9E+U/LQhQCAbrCY8W+rTH7AiPBlF3IoyoFuJKoqklX6zB5XJPBT8Op
 OLAzQYIJ5LAEaeoR8B/gANuDskiSV73GR8X1Kw4NmKjhygq6pZ9ye/TMvtYhjTbnP/
 XIwMr7zikf6Nw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: env: select: Add output for available evironment targets
Date: Thu, 20 Mar 2025 11:32:57 +0100
Message-ID: <20250320103257.14185-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

If "env select" is called without a target parameter the result is
"Select Environment on <NULL>: driver not found". Improve the output
by showing a list of available evironment targets, where the active
target is marked with an asterisk.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Cc: Marek Vasut <marex@denx.de>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Tom Rini <trini@konsulko.com>
---
 env/env.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/env/env.c b/env/env.c
index bcc189e14db..999c2031c40 100644
--- a/env/env.c
+++ b/env/env.c
@@ -355,6 +355,18 @@ int env_select(const char *name)
 	int prio;
 	bool found = false;
 
+	if (!name) {
+		printf("Available Environment targets:\n");
+		for (prio = 0; (drv = env_driver_lookup(ENVOP_INIT, prio)); prio++) {
+			if (gd->env_load_prio == prio)
+				printf("* ");
+			else
+				printf("  ");
+			printf("%s\n", drv->name);
+		}
+		return 0;
+	}
+
 	printf("Select Environment on %s: ", name);
 
 	/* search ENV driver by name */
-- 
2.30.2

