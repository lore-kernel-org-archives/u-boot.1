Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67516C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 05:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CF782B18;
	Tue, 10 Jun 2025 07:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="a30w56Sc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7091182B07; Tue, 10 Jun 2025 07:39:23 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1498070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=OBHa5dooCLx+KUqL9Na8gTdeDuSIB3gwvx735AV1LMg=;
 b=a30w56SckX4ST8PY5etUGq2Ymipz0N7e2yk8EEl3QU2opsskhVl4bJbdb9hRYA5l2udk3bRAJr4fos0+2uHpPi7DwFIJnPZ9iEj4W+IBpUldmqWmjoiLi6toQQF1ptCrukWr/mbR/3myVsj5nmg0V4kkpQD/6y48j57OmeSjAqQ=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Tue, 10 Jun 2025 07:39:21 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/2] sunxi: setup_environment: do not generate a MAC
 address when one is set using nvmem-cells
Date: Tue, 10 Jun 2025 07:38:54 +0200
Message-Id: <20250610053856.1873969-2-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610053856.1873969-1-lukas.schmid@netcube.li>
References: <20250610053856.1873969-1-lukas.schmid@netcube.li>
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

Boards using MAC addresses stored in EEPROM via the device tree's
`nvmem-cells` mechanism may already have a valid MAC loaded by the
device model. However, setup_environment() currently ignores this
and generates a fallback address from the SoC SID if no environment
variable is set.

This leads to a mismatch warning during boot when the kernel or U-Boot
detects the MAC from nvmem and compares it to the environment.

This patch checks whether the corresponding ethernet device node
has a `nvmem-cells` property and skips generating a fallback MAC
if it does, thus avoiding redundant or incorrect ethaddr setup.

This improves compatibility with nvmem-based MAC provisioning and
aligns U-Boot behavior with Linux.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 board/sunxi/board.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ac9cefc6..41b85c66 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -774,10 +774,23 @@ static void setup_environment(const void *fdt)
 		return;
 
 	for (i = 0; i < 4; i++) {
+		const char *alias;
+		int nodeoffset;
+		int len;
+		const fdt32_t *prop;
+
 		sprintf(ethaddr, "ethernet%d", i);
-		if (!fdt_get_alias(fdt, ethaddr))
+		alias = fdt_get_alias(fdt, ethaddr);
+		if (!alias)
 			continue;
 
+		nodeoffset = fdt_path_offset(fdt, alias);
+		if (nodeoffset >= 0) {
+			prop = fdt_getprop(fdt, nodeoffset, "nvmem-cells", &len);
+			if (prop && len > 0)
+				continue;
+		}
+
 		if (i == 0)
 			strcpy(ethaddr, "ethaddr");
 		else
-- 
2.39.5


