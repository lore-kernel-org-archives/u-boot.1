Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4606CCDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 11:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB26B86F80;
	Wed, 18 Oct 2023 13:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA8986BB8; Wed, 18 Oct 2023 08:28:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BBD3E86D82
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=qi.feng@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEEA1007;
 Tue, 17 Oct 2023 23:28:41 -0700 (PDT)
Received: from a015967.shanghai.arm.com (a015967.shanghai.arm.com
 [10.169.190.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2F623F64C;
 Tue, 17 Oct 2023 23:27:57 -0700 (PDT)
From: Qi Feng <qi.feng@arm.com>
To: u-boot@lists.denx.de
Cc: liviu.dudau@foss.arm.com, fenghua@phytium.com.cn, linus.walleij@linaro.org,
 Peter.Hoyes@arm.com, wei.chen@arm.com, Robbie.Cao@arm.com, qi.feng@arm.com
Subject: [PATCH 1/2] misc: vexpress_config: Use member .priv_auto to set the
 private data
Date: Wed, 18 Oct 2023 14:27:44 +0800
Message-Id: <20231018062745.3153436-2-qi.feng@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018062745.3153436-1-qi.feng@arm.com>
References: <20231018062745.3153436-1-qi.feng@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Oct 2023 13:30:29 +0200
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

From: Wei Chen <wei.chen@arm.com>

In current vexpress_config_probe code, it sets the uclass private data
directly. This will cause one compilation error:
drivers/misc/vexpress_config.c:114:27: error: lvalue required as left operand of assignment
  114 |  dev_get_uclass_priv(dev) = priv;
      |                           ^

In this patch we set the uclass private data through struct member
.priv_auto, and this compilation error disappears.

Signed-off-by: Wei Chen <wei.chen@arm.com>
Signed-off-by: Qi Feng <qi.feng@arm.com>
---
 drivers/misc/vexpress_config.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/vexpress_config.c b/drivers/misc/vexpress_config.c
index 2baca48109f..99aad1412ae 100644
--- a/drivers/misc/vexpress_config.c
+++ b/drivers/misc/vexpress_config.c
@@ -92,7 +92,7 @@ static struct misc_ops vexpress_config_ops = {
 static int vexpress_config_probe(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
-	struct vexpress_config_sysreg *priv;
+	struct vexpress_config_sysreg *priv = dev_get_priv(dev);
 	const char *prop;
 	int err, prop_size;
 
@@ -105,11 +105,9 @@ static int vexpress_config_probe(struct udevice *dev)
 	if (!prop || (strncmp(prop, "arm,vexpress-sysreg", 19) != 0))
 		return -ENOENT;
 
-	priv = calloc(1, sizeof(*priv));
 	if (!priv)
 		return -ENOMEM;
 
-	dev_get_uclass_priv(dev) = priv;
 	priv->addr = ofnode_get_addr(args.node);
 
 	return dev_read_u32(dev, "arm,vexpress,site", &priv->site);
@@ -127,4 +125,5 @@ U_BOOT_DRIVER(vexpress_config_drv) = {
 	.bind = dm_scan_fdt_dev,
 	.probe = vexpress_config_probe,
 	.ops = &vexpress_config_ops,
+	.priv_auto = sizeof(struct vexpress_config_sysreg),
 };
-- 
2.25.1

