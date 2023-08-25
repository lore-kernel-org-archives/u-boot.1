Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5CBC6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE7686B0E;
	Fri, 25 Aug 2023 20:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IHfwCcqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 053F086AF6; Fri, 25 Aug 2023 20:03:20 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6C286AB5
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI37tZ114042;
 Fri, 25 Aug 2023 13:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986587;
 bh=tOKUcJOM4vYHAb/ewlezx1TPD03a1gsndnD2ovvlUTk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IHfwCcqPdYsFG/yX9Kd1kjfIhlNXOBHltFyAvJW1J8oCfqJ/LIv7f1I+hXNZGkDA0
 0jWoPLOLa6wvtXgRz2RmqXMdJ95iNyjI0vL9qTTXKekYNq1tlFSU/FCWHSMXA+8isN
 Ow4xOdk5HM6On5c8tL+sqlOZhMBSuOO7JBdw/mds=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI37CB066166
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:07 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36xc125087;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 10/20] include: env: ti: Add a generic default_findfdt.env
Date: Fri, 25 Aug 2023 13:02:55 -0500
Message-ID: <20230825180305.69515-11-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

ti_mmc bootmethod uses a findfdt routine that is expected to be
implemented by all platforms.

Define a default findfdt based on configured DEFAULT_DEVICE_TREE option
for u-boot. This saves duplication across multiple boards and handles
architecture folder location changes centrally.

TI ARMV7 platforms will need to override default_device_tree_subarch
in the env file to point to the appropriate platform. Note: default
"omap" is used to cater to "most common" default.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes:
* Made it as default_findfdt as discussed in review.

V5: https://lore.kernel.org/r/20230824031101.3460411-9-nm@ti.com
 include/env/ti/default_findfdt.env | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 include/env/ti/default_findfdt.env

diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_findfdt.env
new file mode 100644
index 000000000000..a2b51dd923bb
--- /dev/null
+++ b/include/env/ti/default_findfdt.env
@@ -0,0 +1,12 @@
+default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
+default_device_tree_arch=ti
+#ifdef CONFIG_ARM64
+findfdt=
+	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
+	setenv fdtfile ${name_fdt}
+#else
+default_device_tree_subarch=omap
+findfdt=
+	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
+	setenv fdtfile ${name_fdt}
+#endif
-- 
2.40.0

