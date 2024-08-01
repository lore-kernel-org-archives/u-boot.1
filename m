Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAB5C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 03:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AAFF88AEE;
	Thu,  1 Aug 2024 05:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E4B88AEE; Thu,  1 Aug 2024 05:39:31 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E9C8881B
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 05:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EBD01A06FC;
 Thu,  1 Aug 2024 05:39:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 483881A0658;
 Thu,  1 Aug 2024 05:39:29 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 53E371820F57; Thu,  1 Aug 2024 11:39:27 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org, marex@denx.de, lukma@denx.de,
 seanga2@gmail.com, xypron.glpk@gmx.de
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 03/14] cpu: sandbox: implement release_core callback
Date: Thu,  1 Aug 2024 11:59:48 +0800
Message-Id: <20240801035959.43115-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240801035959.43115-1-Zhiqiang.Hou@nxp.com>
References: <20240801035959.43115-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add empty release CPU core function for testing.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V5:
 - No change.

 drivers/cpu/cpu_sandbox.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpu/cpu_sandbox.c b/drivers/cpu/cpu_sandbox.c
index e65e1bdc51..b152795783 100644
--- a/drivers/cpu/cpu_sandbox.c
+++ b/drivers/cpu/cpu_sandbox.c
@@ -44,6 +44,11 @@ void cpu_sandbox_set_current(const char *name)
 	cpu_current = name;
 }
 
+static int cpu_sandbox_release_core(const struct udevice *dev, phys_addr_t addr)
+{
+	return 0;
+}
+
 static int cpu_sandbox_is_current(struct udevice *dev)
 {
 	if (!strcmp(dev->name, cpu_current))
@@ -58,6 +63,7 @@ static const struct cpu_ops cpu_sandbox_ops = {
 	.get_count = cpu_sandbox_get_count,
 	.get_vendor = cpu_sandbox_get_vendor,
 	.is_current = cpu_sandbox_is_current,
+	.release_core = cpu_sandbox_release_core,
 };
 
 static int cpu_sandbox_bind(struct udevice *dev)
-- 
2.17.1

