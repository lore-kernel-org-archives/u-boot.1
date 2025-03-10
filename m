Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85F7C282EC
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CC2814B6;
	Mon, 10 Mar 2025 14:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456E18129F; Mon, 10 Mar 2025 13:36:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0E500811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADB13152B;
 Mon, 10 Mar 2025 05:36:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.34.128.27])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD78E3F5A1;
 Mon, 10 Mar 2025 05:36:25 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8m: soc: cope with existing optee node
Date: Mon, 10 Mar 2025 13:36:21 +0100
Message-ID: <20250310123621.389594-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Mar 2025 14:51:01 +0100
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

On i.MX8M SoCs, the /firmware/optee Devicetree node is created just before
booting the OS when OP-TEE is found running. If the node already exists,
this results in an error, which prevents the OS to boot:

  Could not create optee node.
  ERROR: system-specific fdt fixup failed: FDT_ERR_EXISTS
   - must RESET the board to recover.

  failed to process device tree

On the i.MX8M systems where CONFIG_OF_SYSTEM_SETUP is defined, the
ft_add_optee_node() function is called before booting the OS. It will
create the OP-TEE Devicetree node and populate it with reserved memory
informations gathered at runtime.

On on most i.MX8M systems the Devicetree is built with an optee node if
CONFIG_OPTEE is defined. This node is indeed necessary for commands and
drivers communicating with OP-TEE, even before attempting OS boot.

The aforementioned issue can happen on the Compulab IOT-GATE-iMX8, which is
the only in-tree i.MX8M system where both CONFIG_OPTEE and
CONFIG_OF_SYSTEM_SETUP are defined (see the imx8mm-cl-iot-gate*
defconfigs).

Deal with an existing optee node gracefully at runtime to fix this issue.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 85dc8b51a14..567e8e9e81a 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1270,8 +1270,9 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 		}
 	}
 
+	/* Locate the optee node if it exists or create it. */
 	subpath = "optee";
-	offs = fdt_add_subnode(fdt, offs, subpath);
+	offs = fdt_find_or_add_subnode(fdt, offs, subpath);
 	if (offs < 0) {
 		printf("Could not create %s node.\n", subpath);
 		return offs;
-- 
2.47.2

