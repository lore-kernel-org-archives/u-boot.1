Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BAAE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D3680216;
	Tue, 10 Dec 2024 23:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="VwUeLUIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A156380223; Tue, 10 Dec 2024 23:40:17 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED368020B
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8A45912000E;
 Wed, 11 Dec 2024 01:40:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8A45912000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733870414;
 bh=QCENFHXQmtJVkD1v5XYFnGvPemHF5JYN0hGJoXR0gP0=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=VwUeLUIUgoAFNQBf2jmv2P+FaQVjThuteOYGFwpryY7HG8b13Kxsbj7d2a8yuhjvR
 tr/QxcbuWVUC4g/bn8PcPyjCQ+qf/rDCokoIlLExlH/34ge8+6knRonEL8d3kkMGJe
 SCB2FbhTi42gOw9pdULJBqeYq5VrN2X/dpexEhJ82SX7dZEtYbEmfUnJQi86lUSxCZ
 badm1YbMYde/4M86SBtemmXXvGO4p5AYYJxo9w4KgL4Sey4tyBkz/S+pfQYnsKi+vD
 84g/iqBT9lRvKlSyCME+pqSDeJ7/gXucU1+ZdmF+6GKFFNcN9ZQcnHXgMh0vjIeM8O
 4yDWVz2jXNGLw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 11 Dec 2024 01:40:14 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Wed, 11 Dec 2024 01:39:57 +0300
Subject: [PATCH 1/2] fdtdec: encapsulate dtb_dt_embedded() within
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241211-dtb_dt_embedded_within_fdtdec-v1-1-7840469f0084@salutedevices.com>
References: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
In-Reply-To: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>, "Lad
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, Evgeny Bachinin
 <EABachinin@salutedevices.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
 <u-boot@lists.denx.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.224.238]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189752 [Dec 10 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/10 16:39:00 #26956987
X-KSMG-AntiVirus-Status: Clean, skipped
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

  Patch keeps the access to dtb_dt_embedded() within fdtdec API,
by means of new API function introduction. This new function is a
common place for updating appropriate global_data fields for
OF_EMBED case.

  Also, the consequence of the patch is movement of '___dtb_dt_*begin'
symbols' declaration from header file, because nobody used symbols
outside the lib/fdtdec.c.

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
Suggested-by: Simon Glass <sjg@chromium.org>
---
 common/board_r.c |  4 ++--
 include/fdtdec.h | 24 +++++++-----------------
 lib/fdtdec.c     | 26 ++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 88dc756b2a5e5a44f55f9b0fd012adc798a8afdb..3c6a4c1f5df80d5f5bf86ed4047fccf981dbc244 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -155,11 +155,11 @@ static int initr_reloc_global_data(void)
 
 	/*
 	 * For CONFIG_OF_EMBED case the FDT is embedded into ELF, available by
-	 * __dtb_dt_begin. After U-boot ELF self-relocation to RAM top address
+	 * __dtb_dt_begin. After U-Boot ELF self-relocation to RAM top address
 	 * it is worth to update fdt_blob in global_data
 	 */
 	if (IS_ENABLED(CONFIG_OF_EMBED))
-		gd->fdt_blob = dtb_dt_embedded();
+		fdtdec_setup_embed();
 
 #ifdef CONFIG_EFI_LOADER
 	/*
diff --git a/include/fdtdec.h b/include/fdtdec.h
index 555c952037964e6b1d9419156171f7ef4b35f448..88eeb5129780878a6fa4ac7a357e4e704347ab43 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -136,23 +136,6 @@ struct fdt_pci_addr {
 	u32	phys_lo;
 };
 
-extern u8 __dtb_dt_begin[];	/* embedded device tree blob */
-extern u8 __dtb_dt_spl_begin[];	/* embedded device tree blob for SPL/TPL */
-
-/* Get a pointer to the embedded devicetree, if there is one, else NULL */
-static inline u8 *dtb_dt_embedded(void)
-{
-#ifdef CONFIG_OF_EMBED
-# ifdef CONFIG_XPL_BUILD
-	return __dtb_dt_spl_begin;
-# else
-	return __dtb_dt_begin;
-# endif
-#else
-	return NULL;
-#endif
-}
-
 /**
  * Compute the size of a resource.
  *
@@ -1155,6 +1138,13 @@ int fdtdec_set_carveout(void *blob, const char *node, const char *prop_name,
 			const char *name, const char **compatibles,
 			unsigned int count, unsigned long flags);
 
+/**
+ * fdtdec_setup_embed - pick up embedded DTS
+ *
+ * Should be invoked under CONFIG_OF_EMBED guard.
+ */
+void fdtdec_setup_embed(void);
+
 /**
  * Set up the device tree ready for use
  */
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b06559880296276bebd434e9d1de6d2fa923fa98..9cb94a158441cfd291a0f173c321a722e896bcb2 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -93,6 +93,23 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BLOBLIST] = "bloblist",
 };
 
+extern u8 __dtb_dt_begin[];	/* embedded device tree blob */
+extern u8 __dtb_dt_spl_begin[];	/* embedded device tree blob for SPL/TPL */
+
+/* Get a pointer to the embedded devicetree, if there is one, else NULL */
+static u8 *dtb_dt_embedded(void)
+{
+#ifdef CONFIG_OF_EMBED
+# ifdef CONFIG_XPL_BUILD
+	return __dtb_dt_spl_begin;
+# else
+	return __dtb_dt_begin;
+# endif
+#else
+	return NULL;
+#endif
+}
+
 const char *fdtdec_get_srcname(void)
 {
 	return fdt_src_name[gd->fdt_src];
@@ -1664,6 +1681,12 @@ static void setup_multi_dtb_fit(void)
 	}
 }
 
+void fdtdec_setup_embed(void)
+{
+	gd->fdt_blob = dtb_dt_embedded();
+	gd->fdt_src = FDTSRC_EMBED;
+}
+
 int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
@@ -1699,8 +1722,7 @@ int fdtdec_setup(void)
 			gd->fdt_blob = fdt_find_separate();
 			gd->fdt_src = FDTSRC_SEPARATE;
 		} else { /* embed dtb in ELF file for testing / development */
-			gd->fdt_blob = dtb_dt_embedded();
-			gd->fdt_src = FDTSRC_EMBED;
+			fdtdec_setup_embed();
 		}
 	}
 

-- 
2.34.1

