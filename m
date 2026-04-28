Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C3DFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DBD84682;
	Tue, 28 Apr 2026 22:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="OEK2MzXq";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="lCL4F+s1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD0F846BC; Tue, 28 Apr 2026 22:25:30 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81268465C
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407928; 
 b=luB6F7T9gWjqiq9nRyXlKCYdDsDCpZxI6n+F7XKGdqwlk/g7/v16dOG6QsrUVXs9kVuekyPrHq
 HOz7VKGXaSR/n86PphkIBaCPEL3qt1sn1k7NXi5Jzdl+JUjUTRpBVZHec1q4L+duFObh75Qxk2
 obTkkhHvGBI98NynOG+ci4e0+4V8p3QaOJBNtevDvzwijsVvergfiuhEbkWJyY/m5L8EaHEnro
 JYDkEWCQLfM2rzN4GARPJAcE6/KyS8PbZLT7dtYAGZmMtKsWGb7CpjD+9Z0hJKU591381G8d7M
 /r+xcZ4XgdUpA2XnQV1ZTpJizRPcGPFa+qUdKiU85Nq57w==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407928; 
 bh=7jl6wuuvBNtHRl1osbqgAZB6XUghFOi5rsEqPct86PE=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=JlcEAS7flm0SznNGd+xLbY8oH20AoIxr5n0I19hDFnfn5vRY4SFRILCJGAY+HQVe0/MyJeABZ3
 AJKCXgFSgZ9it0ItaNgDLwgPkFLpQUR2CU5GU8Cu6mprS4X/p4xSc6j3JsKN+SRSqqCNSH5wLC
 9+PcCSb7cJ3QPIlqIPuOFDFEOvuQkBen+FVNEFlGX0o+ClVMBMlgkEH+nsxcPTrpYbQItFwh1e
 lksYNagPTrBrcIMDEbvYetFL5rjWjWsgGjp/VBEq4k307QDWysl9bYGrixkRKZiIV006BMiLi0
 da4BJXcnY11MHabQ8PSK+8DiCMOfkk0zxZ8NYROGOcnzzQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=qine4bsizd6qgVWpc9yu2DWG1eJFo1TYw9XAwalci6A=; b=OEK2MzXq6C0Q7FQYGPREAnD/b7
 nHgqDjHZ/x9XFVi+iBlbzNXCUU6d55QxN5snuTBqWc9RLEpAr631T1ozCIChNuhmqa6FysUYg1Wpf
 6C2RGcMfoGmm/ol+aI5aBEpBNzLFUZSq8sQxg2VAwSpKTonova47oqj9ILaC7yvVG7Wo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wHozm-00000002IlQ-02wf
 for u-boot@lists.denx.de; Tue, 28 Apr 2026 20:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=qine4bsizd6qgVWpc9yu2DWG1eJFo1TYw9XAwalci6A=; b=lCL4F+s1QBlW30eB1ciqS49WQV
 HEHtqjkZ6OMJV2lgw6AkW8DrJXqZtak49XJm4aoKee307UGQR1Mj4lgQHtsk+jm03EAbsr3RyYaEW
 C0A4jjv/Vz/+QM3SBx0JjzagApdQ9c42rYyqDl6rAQcZ6913qFK65Ajo/hNe+n1BN74Y=;
Received: from [95.248.129.24] (port=64167 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wHozO-000000002Bh-2Ypt; Tue, 28 Apr 2026 20:25:02 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 28 Apr 2026 22:24:46 +0200
Subject: [PATCH 5/5] spl: fit: add ramdisk load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-spl_fit_full-v1-5-dde63beeaab1@valla.it>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>, 
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Michael Walle <mwalle@kernel.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 David Lechner <dlechner@baylibre.com>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4418; i=francesco@valla.it;
 h=from:subject:message-id; bh=7jl6wuuvBNtHRl1osbqgAZB6XUghFOi5rsEqPct86PE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkfxafvdn+Wv5Zd4YuHy3rxfUWyAYcvbivya7n84nDzv
 Od5GndmdZSyMIhxMciKKbKErLtxb89c829pGxgfwcxhZQIZwsDFKQATmW/F8D+zaO4l9dnd5x+9
 eyPDcpBt1UrtHdqO6S2vW8wkDVNYePYw/C/W0y5avzerP6XfQv9B5ez902Uq/Wyu8eoHtk05uFa
 lkBUA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 78b31f77ed268317455fe91c9c9b3285
X-AntiAbuse: ID - 78b31f77ed268317455fe91c9c9b3285
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wHozm-00000002IlQ-02wf-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Add ramdisk loading logic to the "full" SPL FIT loader, as well as the
corresponding FDT fixup. This is required for proper support of falcon
boot using FIT images, but is useless for a U-Boot launch, so make it
depend on SPL_OS_BOOT.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 common/spl/spl.c     | 17 ++++++++++++++---
 common/spl/spl_fit.c | 18 ++++++++++++++++--
 include/spl.h        | 20 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index a09ebac62c2a..b4890ba9ae83 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -130,7 +130,7 @@ void __weak spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 }
 
-void spl_fixup_fdt(void *fdt_blob)
+void spl_fixup_fdt(void *fdt_blob, ulong initrd_start, ulong initrd_end)
 {
 #if defined(CONFIG_SPL_OF_LIBFDT)
 	int err;
@@ -172,6 +172,14 @@ void spl_fixup_fdt(void *fdt_blob)
 			return;
 		}
 	}
+
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT)
+	err = fdt_initrd(fdt_blob, initrd_start, initrd_end);
+	if (err) {
+		printf(PHASE_PROMPT "fdt_initrd err - %d\n", err);
+		return;
+	}
+#endif
 #endif
 }
 
@@ -789,7 +797,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		debug("Jumping to %s...\n", xpl_name(xpl_next_phase()));
 	} else if (CONFIG_IS_ENABLED(ATF) && os == IH_OS_ARM_TRUSTED_FIRMWARE) {
 		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
-		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
+		spl_fixup_fdt(spl_image_fdt_addr(&spl_image),
+			      spl_image_ramdisk_start(&spl_image),
+			      spl_image_ramdisk_end(&spl_image));
 		jumper = &spl_invoke_atf;
 	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os == IH_OS_TEE) {
 		debug("Jumping to U-Boot via OP-TEE\n");
@@ -804,7 +814,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			fdt = (void *)SPL_PAYLOAD_ARGS_ADDR;
 		else
 			fdt = spl_image_fdt_addr(&spl_image);
-		spl_fixup_fdt(fdt);
+		spl_fixup_fdt(fdt, spl_image_ramdisk_start(&spl_image),
+			      spl_image_ramdisk_end(&spl_image));
 		spl_board_prepare_for_linux();
 		spl_image.arg = fdt;
 		jumper = &jump_to_image_linux;
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe56a1..51933ba7bebf 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -950,8 +950,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	const char *fit_uname_config = NULL;
 	ulong fdt_hack;
 	const char *uname;
-	ulong fw_data = 0, dt_data = 0, img_data = 0;
-	ulong fw_len = 0, dt_len = 0, img_len = 0;
+	ulong fw_data = 0, dt_data = 0, img_data = 0, rd_data = 0;
+	ulong fw_len = 0, dt_len = 0, img_len = 0, rd_len = 0;
 	int idx, conf_noffset;
 	int ret;
 
@@ -1011,6 +1011,20 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		}
 	}
 
+	if (spl_image->os != IH_OS_U_BOOT) {
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+		images.verify = 1;
+#endif
+		ret = fit_image_load(&images, virt_to_phys((void *)header), NULL,
+				     &fit_uname_config, IH_ARCH_DEFAULT,
+				     IH_TYPE_RAMDISK, -1, FIT_LOAD_OPTIONAL,
+				     &rd_data, &rd_len);
+		if (ret >= 0) {
+			spl_image->ramdisk_addr = rd_data;
+			spl_image->ramdisk_size = rd_len;
+		}
+	}
+
 	conf_noffset = fit_conf_get_node((const void *)header,
 					 fit_uname_config);
 	if (conf_noffset < 0)
diff --git a/include/spl.h b/include/spl.h
index 5078d7525abb..a390cdd841b9 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -288,6 +288,8 @@ struct spl_image_info {
 	ulong entry_point;
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
 	void *fdt_addr;
+	ulong ramdisk_addr;
+	ulong ramdisk_size;
 #endif
 #if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	ulong optee_addr;
@@ -325,6 +327,24 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
 #endif
 }
 
+static inline ulong spl_image_ramdisk_start(struct spl_image_info *info)
+{
+#if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
+	return info->ramdisk_addr;
+#else
+	return 0;
+#endif
+}
+
+static inline ulong spl_image_ramdisk_end(struct spl_image_info *info)
+{
+#if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
+	return info->ramdisk_addr + info->ramdisk_size;
+#else
+	return 0;
+#endif
+}
+
 struct spl_load_info;
 
 /**

-- 
2.54.0

