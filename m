Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0497CC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E54A1875BF;
	Tue, 19 Dec 2023 13:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mH/Yssjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C9487630; Tue, 19 Dec 2023 13:24:59 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F7E8758C
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AF74E420F1; 
 Tue, 19 Dec 2023 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702988695;
 bh=PUIP02YLri1HP5P8JWek9lT6etMzxTlpx9bNCZRbY3I=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=mH/Yssjw9F+s6Wv1uZZHWPKHUBj8Zurspo/eM8GtV2Ca79D8f9b6/0iWH6NuUr9Qu
 OiYmilWR3AYataUTk+tT+9snWnDt3Lj5QPwdZOlczjnjqJ2AF4eFwcZ9fipNLmiRAP
 Wy09edjfLNP3Vbq+1KxFq9eVAz+jlUJ5ZtfYShZNgWyw1PFGJHtwCArjKPonwlrykp
 O76h2MVok/cA4w6mYMQSjm3yV89MoXS5Rg0W+lrt8iprpURWOgsPFH8XfAQQL676++
 xQADSjBr7TYb9gNgKjDSVktCJI2AmhqhkT0XT1J7F4lyWjcobe+xsb7CwmIKlBdYmU
 zZeW+QyitcPgQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 5/9] acpi: enable writing ACPI tables on QEMU
Date: Tue, 19 Dec 2023 13:24:35 +0100
Message-Id: <20231219122439.31983-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
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

Invoke write_acpi_tables() via EVT_LAST_STAGE_INIT on QEMU except on X86.
X86 calls write_acpi_tables() in write_tables().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v3:
	no change
v2:
	new patch
---
 drivers/misc/qfw_acpi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
index 6e14b2a504..7ffed1e8c0 100644
--- a/drivers/misc/qfw_acpi.c
+++ b/drivers/misc/qfw_acpi.c
@@ -9,9 +9,11 @@
 #include <acpi/acpi_table.h>
 #include <errno.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <qfw.h>
 #include <tables_csum.h>
 #include <stdio.h>
+#include <linux/sizes.h>
 #include <asm/byteorder.h>
 #include <asm/global_data.h>
 
@@ -254,3 +256,26 @@ ulong acpi_get_rsdp_addr(void)
 	file = qfw_find_file(dev, "etc/acpi/rsdp");
 	return file->addr;
 }
+
+#ifndef CONFIG_X86
+static int evt_write_acpi_tables(void)
+{
+	ulong addr, end;
+	void *ptr;
+
+	/* Reserve 64K for ACPI tables, aligned to a 4K boundary */
+	ptr = memalign(SZ_4K, SZ_64K);
+	if (!ptr)
+		return -ENOMEM;
+	addr = map_to_sysmem(ptr);
+
+	/* Generate ACPI tables */
+	end = write_acpi_tables(addr);
+	gd->arch.table_start = addr;
+	gd->arch.table_end = addr;
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, evt_write_acpi_tables);
+#endif
-- 
2.40.1

