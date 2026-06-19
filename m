Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFC1CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F34084A0E;
	Fri, 19 Jun 2026 14:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="tRwiCju7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5567B8005D; Fri, 19 Jun 2026 14:53:33 +0200 (CEST)
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [178.154.239.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C65C84A27
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:99a0:0:640:85e0:0])
 by forward101d.mail.yandex.net (Yandex) with ESMTPS id 9CF0AC02CF;
 Fri, 19 Jun 2026 15:53:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id HrSguQJd9Gk0-fPZjFbSZ; 
 Fri, 19 Jun 2026 15:53:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1781873609; bh=ekFiqYRxAvThfLZRTtB8yWm0skBeTjLPVGcA77AdHOw=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=tRwiCju7ELRIlqi2FGVjlPNf59DorjX7eDGJvrS8IvSgA9ylnsxm6adoPD2fYl0/Y
 2mBpte3RsjxCrhq/6nTGLs3JFstwooYYohxHtKYg4KGIG6MBOPOUkaka5DvvVhnXBx
 1QoTOpqcAPfndArfAa3qPTKiDjp+BFiY0LXnkjl0=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 19 Jun 2026 15:52:58 +0300
Subject: [PATCH RFC 2/2] spl: opensbi: fix OS image address retrieval from FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-riscv-full-fit-image-support-v1-2-c6477cf4f410@maquefel.me>
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
In-Reply-To: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>, 
 Michael Walle <mwalle@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781873599; l=4719;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=n0GqHkWCeJglfgcsjSv6SJaLSfgxzPmvs5PLfG1GpOE=;
 b=ePRJVXV2xWB0dy3EGiqYoAxLVWXJVMHIqnGjwMp5AyQPMJVTieESCmw8aR7MTaqscdGEUnr6y
 hc2J8B3dre6AhRRW383qc/FbPXfmnEK1hQX2/qpkNdVoG78tZ3C3SjB
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

The current implementation of spl_invoke_opensbi() attempts to locate
the next-stage OS (U-Boot proper or Linux) by parsing the FDT blob
pointed to by spl_image->fdt_addr. This FDT, however, is the one that
will be passed to the OS (e.g. a kernel device tree), not the FIT image
itself. As a result, when a FIT image containing multiple components
(firmware, loadables, fdt) is loaded, U-Boot SPL cannot find the OS node
because it searches in the wrong FDT.

Fix this by storing the load addresses of U-Boot and Linux in
spl_image_info during the loadables phase (spl_load_fit_image()).
In spl_invoke_opensbi(), use these stored addresses if they are
non-zero, and fall back to parsing the FDT only if no address is stored,
maintaining backward compatibility.

This ensures that the correct entry point is passed to OpenSBI,
allowing proper boot flow with FIT images.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_fit.c     |  8 ++++++++
 common/spl/spl_opensbi.c | 33 +++++++++++++++++++--------------
 include/spl.h            |  8 ++++++++
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe56a..3da1533c791 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -1031,6 +1031,14 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 				     &img_data, &img_len);
 		if (ret < 0)
 			return ret;
+
+#if CONFIG_IS_ENABLED(OPENSBI)
+		if (fit_image_check_os((const void *)header, ret, IH_OS_LINUX))
+			spl_image->kernel_addr = img_data;
+
+		if (fit_image_check_os((const void *)header, ret, IH_OS_U_BOOT))
+			spl_image->uboot_addr = img_data;
+#endif
 	}
 	spl_image->flags |= SPL_FIT_FOUND;
 
diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index 0ed6afeacc6..f7bef67bd89 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -46,8 +46,8 @@ static int spl_opensbi_find_os_node(void *blob, int *uboot_node, int os_type)
 
 void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 {
-	int ret, os_node;
-	ulong os_entry;
+	int ret = 0, os_node;
+	ulong os_entry = 0;
 	int os_type;
 	typedef void __noreturn (*opensbi_entry_t)(ulong hartid, ulong dtb, ulong info);
 	opensbi_entry_t opensbi_entry;
@@ -81,22 +81,27 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 	 * The next os image default is u-boot proper, once enable
 	 * OpenSBI OS boot mode, the OS image should be linux.
 	 */
-	if (CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT))
+	if (CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT)) {
 		os_type = IH_OS_LINUX;
-	else
+		os_entry = spl_image->kernel_addr;
+	} else {
 		os_type = IH_OS_U_BOOT;
-
-	ret = spl_opensbi_find_os_node(spl_image->fdt_addr, &os_node, os_type);
-	if (ret) {
-		pr_err("Can't find %s node for opensbi, %d\n",
-		       genimg_get_os_name(os_type), ret);
-		hang();
+		os_entry = spl_image->uboot_addr;
 	}
 
-	/* Get U-Boot entry point */
-	ret = fit_image_get_entry(spl_image->fdt_addr, os_node, &os_entry);
-	if (ret)
-		ret = fit_image_get_load(spl_image->fdt_addr, os_node, &os_entry);
+	if (!os_entry) {
+		ret = spl_opensbi_find_os_node(spl_image->fdt_addr, &os_node, os_type);
+		if (ret) {
+			pr_err("Can't find %s node for opensbi, %d\n",
+				genimg_get_os_name(os_type), ret);
+			hang();
+		}
+
+		/* Get U-Boot entry point */
+		ret = fit_image_get_entry(spl_image->fdt_addr, os_node, &os_entry);
+		if (ret)
+			ret = fit_image_get_load(spl_image->fdt_addr, os_node, &os_entry);
+	}
 
 	/* Prepare opensbi_info object */
 	opensbi_info.magic = FW_DYNAMIC_INFO_MAGIC_VALUE;
diff --git a/include/spl.h b/include/spl.h
index 5078d7525ab..3f4bfc35941 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -275,6 +275,10 @@ enum spl_sandbox_flags {
  *	if @fdt_size is non-zero
  * @fdt_start: Pointer to the FDT to be copied (must be set up before calling
  *	spl_reloc_jump()
+ * @uboot_addr: Store U-Boot proper addr during "loadables" phase
+ *  (RISC-V only)
+ * @kernel_addr: Store Linux addr during "loadables" phase
+ *  (RISC-V only)
  * @rcode_buf: Buffer to hold the relocating-jump code
  * @stack_prot: Pointer to the stack-protection value, used to ensure the stack
  *	does not overflow
@@ -288,6 +292,10 @@ struct spl_image_info {
 	ulong entry_point;
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
 	void *fdt_addr;
+#if CONFIG_IS_ENABLED(OPENSBI)
+	ulong uboot_addr;
+	ulong kernel_addr;
+#endif
 #endif
 #if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	ulong optee_addr;

-- 
2.52.0

