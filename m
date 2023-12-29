Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F215C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6114A87ADE;
	Fri, 29 Dec 2023 11:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pzkaHct9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED9B87A23; Fri, 29 Dec 2023 11:46:45 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32F287A23
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkb3U085054;
 Fri, 29 Dec 2023 04:46:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846797;
 bh=dPxU5DKcIrTTqTyM+5SvX3u9aifVhQHKUQDdVdck3b8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=pzkaHct9Xq0KcclJgeYzHGwGkUr2XYMbdcnXOIQo1M+vrPQDygfarmSN55K2zgq4D
 HsH3Go/ocNUZ5wtxDfePkV8jisfCJlK6ca8ezlS5FOSpn/1apaTLFJ44ZdL+Ejgec8
 KXYRRexH2PWfGzsvYYWissa/Rh/azBSPm7NA+Lcw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAkbBl065716
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:37 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:37 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7f072641;
 Fri, 29 Dec 2023 04:46:33 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:25 +0530
Subject: [PATCH v7 1/9] dtoc: Change dst to self in debug message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-1-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=1047;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=63IdThCkt/ImmB+LDAzznO3LpZAZH8s2A52LisxTU/k=;
 b=TPpzLsfOVv+r5Eja97nZPdNrFWR16tADaN9PicmC6YgFd0bF7mm1qaba0DtxReQqxpmMeXZzb
 277Gi1E4zXuC7Q/G2dcMfIyORzAYOwdjKx9q9Cu68+avMOPFgKaPDuI
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Fix the error message to not use dst and use self as it is copying the
properties to self.

While using templating if there are no subnodes defined, we end up in
this situation where "dst" isn't defined and it tries to print the error
message and fails.

'UnboundLocalError: local variable 'dst' referenced before assignment'

Fixes: 55e1278d5eca ("dtoc: Allow inserting a list of nodes into another")

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 tools/dtoc/fdt.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
index 5963925146a5..991a36b98796 100644
--- a/tools/dtoc/fdt.py
+++ b/tools/dtoc/fdt.py
@@ -782,7 +782,7 @@ class Node:
             for node in parent.subnodes.__reversed__():
                 dst = self.copy_node(node)
 
-            tout.debug(f'merge props from {parent.path} to {dst.path}')
+            tout.debug(f'merge props from {parent.path} to {self.path}')
             self.merge_props(parent, False)
 
 

-- 
2.43.0

