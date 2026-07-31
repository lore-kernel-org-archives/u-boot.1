Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA42CC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB7414116B;
	Fri, 31 Jul 2026 17:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XhYu1cKM_Bn; Fri, 31 Jul 2026 17:18:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF81741142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518333;
	bh=swV8e59iPE7GTfdQsOA/sc3zrTDT5EHLABT8i6cOX3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rEBglMrHvva2UQiE5iNNfLrHLRfurQP5ZDYJcfB9ep9oVOOb+6hYTheLU/leoAu1t
	 vX5vtnocNo0phRFZBote4oTN5uHLa6cLQ4wodTM0crglEErxL5FKx5e5kg0DmmsX3S
	 i9O2302jGfewX9yxfntELmF+Ys6e3sdvFQVk1MqmpreotzXBsdpsR4aZkYoZsg13mo
	 8MjNIvXiBJf+PjKJoPSl88+IE469ZZvN6WS6a91gK4VQigVRUknE72UvMiK7TlgFLN
	 YPwbGhLmM/Mr4qZN0omSteSLKXnvCotRvBfk57iui6WQ0TOcMT38lMPlFoezaUZuAN
	 lt/cmF9G2jNcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF81741142;
	Fri, 31 Jul 2026 17:18:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6A353B6
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A46E1400AB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ovi24e0BPZf1 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 782EA40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 782EA40025
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 782EA40025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:19 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so196355266b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517877; x=1786122677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swV8e59iPE7GTfdQsOA/sc3zrTDT5EHLABT8i6cOX3c=;
 b=PfUaiJH/4CJ/b+NpQdehDmrQNRhwLwjyYBCUfoVlViQKU+4zJivobhq0ztuOcscvck
 J6Am72W5Ff/lKEVVVC4x2HXxh+fl0Gj45mGe9t0h2AXe9qcWz2BpRTlC7q3HfUiQF3Zt
 L9EzrXxkZ+PVddIa7Fg7+qCCAazKJyhI4ubS42cFznyO+c/yDlmkixIo1ddORdUd+aIZ
 4h1oN2DwUk8ySorkxF7aHKvn8k8VQQ5T4IqkyQneVNTREahq8TQOG87RVNvS7NfT6wJb
 TQk9tvinppQ3pvz8wWa7k+xNyWXbMWeRbsLeD11o1yv7DWLRfUcVmxBQErPFHRBbLxZD
 hg8A==
X-Gm-Message-State: AOJu0YwsL9Q4noFhGikY4mYZBhQW+wJ70HqjG3PvjEC1KBaTpOmVRwPb
 umzbCKqscoSWnzaeaGwcJ8DXv+B7URYyGyc8G2yKwHSXnpPsApba+bHlnblIoSO7uns=
X-Gm-Gg: AR+sD10Pw6z9HvduAXql1O3AqqRKZ2ndjnrwx/HKGTEoLZXk5tTNOIhfpfOAbURuOgs
 uNp7c90TuYLVjYKQL8+JTDeOUPWFNmyhu2MpSdCn4WT0bylKrG8NO+iv2E5bQvHAKKTYLJ+OKG9
 VLJaHGtuboKrDuare/x+g5FaEIat5LkxnELQXjWwVEWcZlGuYi65e80fefvagcq+0f5ibE3WWH0
 yRkQo8ulL1u0gSirAqEB3RH5SlaVswbprAsgmrcxfWhoTsC2O51+AtOuJ5OqMTQ63zW3T8co9xO
 hkqrqB2MwusQTvQGaF+ttFTgyUlAmXDhpyfERqHXmoE1wLRwiCLViN+NWsEO7O6GE2n7mD3SddE
 2IdFb9SU5DVorE6WLzkMxZxcLvtvef/ERKQbdzuhsk9HhLd7tUYYA+Xm8zuTLG2RpawfjRQZv4o
 /Pz9D9xjidu97EWAQ8iTo1kt/FK/DpYrwJqRH39BisDJlHvPrxe0bYhJy7m+6XG+KCqorEeqPCA
 NYDk7ASJfDCEm2Ry9DFks45ohS+Gvp6zltt0I3oLw==
X-Received: by 2002:a17:907:d59c:b0:c19:473b:dc8f with SMTP id
 a640c23a62f3a-c1fe7ea80ccmr34799766b.3.1785517877205; 
 Fri, 31 Jul 2026 10:11:17 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:46 +0400
Subject: [PATCH v2 02/10] spl: atf: support Linux as BL33 with TFA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-2-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6887; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QLfR5Tkf1eCa/5DITgqr5FsnCrp/dtGkRaoSqfLyvXY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFdqTp25oW37pX3T8zsWRLCsj3i9Y4WI8xzjU9uSP
 szdvszgWcdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTvWImw//An1HCSu+O332j5SM7Z+szy9ijYodbl9RNOfl066O9281SGRnanjD
 90ZvaGxV32bFXaQJD8MXVx4OUzy5JXSkn13tp815+AA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517877; x=1786122677;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=swV8e59iPE7GTfdQsOA/sc3zrTDT5EHLABT8i6cOX3c=;
 b=XxpKq10OcPaPCD6qLLxVCHgHDqrYWHPcjGo5l/Q3JL8W1IhEAgjMqYyJ0SRKcbfwWP
 wSCo16j/gJyYHOJ1E4yN5Tx9aF8imk0MkfUZQalG11x9padZS9Cok7RzpjeAv5u/lJmW
 /xV6zpQSSV5mlgB2/F3NFOrch8wBtJ2vJYtXhgzawLJ+kiUvWJKBZE+6eRUw9PCS4kx8
 BnH+uFyZK3ShBnS9DDqXtQE5L+rIZqxWKFigoCouFMTmQ+V01g9SQjkBRipQmC7cHCvu
 /sE5RZekmin51fvL4gAXaOQVzhqt4kP4jos/nHx0b8vOjGFBcmR/qnQ+RS3egVKafpmJ
 9qDw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=XxpKq10O
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Modern SoCs such as Rockchip RK3576 need TFA to be running to provide
firmware services to the OS.

Enable the TFA boot flow to allow using Linux as BL33 (including its
calling convention) to facilitate Falcon mode boot on such SoCs.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/Kconfig   | 22 ++++++++++++++++++++--
 common/spl/spl_atf.c | 49 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c9410..7c639ed8f763 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1230,22 +1230,40 @@ config SPL_BOOTZ
 	help
 	  Boot a linux zimage from memory in falcon boot.
 
+	  This provides an entry path which is unused when the OS is entered
+	  through TF-A, since SPL then only places the kernel in memory and
+	  BL31 is what enters it. It remains selectable: SPL can still enter
+	  a kernel itself on such a platform, dropping to EL2 without TF-A
+	  resident, just without any firmware services being available to the
+	  OS afterwards.
+
 config SPL_BOOTI
 	bool "Allow booting an Image style Linux kernel from SPL"
 	depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
-	default y if ARM64 || RISCV
+	default y if (ARM64 || RISCV) && !SPL_ATF
 	select SPL_LIB_BOOTI
 	help
 	  Boot an uncompressed linux kernel image from memory in falcon boot.
 
+	  This provides an entry path which is unused when the OS is entered
+	  through TF-A, since SPL then only places the kernel in memory and
+	  BL31 is what enters it, so it does not default to y in that case. It
+	  remains selectable: SPL can still enter a kernel itself on such a
+	  platform, dropping to EL2 without TF-A resident, just without any
+	  firmware services being available to the OS afterwards.
+
 config SPL_OS_BOOT_ARGS
 	bool "Allow SPL to load args for kernel in falcon mode"
 	depends on (SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT) && !SPL_OS_BOOT_SECURE
-	default y if !SPL_OS_BOOT_SECURE
+	default y if !SPL_OS_BOOT_SECURE && !SPL_ATF
 	help
 	  This option enables the SPL to load an args file (usually the FDT)
 	  alongside the kernel image in falcon boot mode.
 
+	  This is not needed when the OS is entered through TF-A, since the
+	  device tree is then taken from the same FIT as the kernel, which is
+	  why it does not default to y in that case.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT_ARGS
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 17acd3665dfa..0cec5d8d46fe 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -15,6 +15,7 @@
 #include <image.h>
 #include <log.h>
 #include <spl.h>
+#include <vsprintf.h>
 #include <asm/cache.h>
 
 /* Holds all the structures we need for bl31 parameter passing */
@@ -87,8 +88,8 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
 		       ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
+	/* Pass the FDT address in x0, per the TF-A BL33 / Linux boot protocol. */
+	bl33_ep_info->args.arg0 = fdt_addr;
 	bl33_ep_info->pc = bl33_entry;
 	bl33_ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 				     DISABLE_ALL_EXECPTIONS);
@@ -162,8 +163,8 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl_params_node->ep_info, ATF_PARAM_EP,
 		       ATF_VERSION_2, ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
+	/* Pass the FDT address in x0, per the TF-A BL33 / Linux boot protocol. */
+	bl_params_node->ep_info->args.arg0 = fdt_addr;
 	bl_params_node->ep_info->pc = bl33_entry;
 	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 						DISABLE_ALL_EXECPTIONS);
@@ -189,7 +190,8 @@ static inline void raw_write_daif(unsigned int daif)
 typedef void __noreturn (*atf_entry_t)(struct bl31_params *params, void *plat_params);
 
 static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
-				  ulong bl33_entry, ulong fdt_addr)
+				  ulong bl33_entry, ulong fdt_addr,
+				  ulong plat_param)
 {
 	atf_entry_t  atf_entry = (atf_entry_t)bl31_entry;
 	void *bl31_params;
@@ -206,7 +208,7 @@ static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
 	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		dcache_disable();
 
-	atf_entry(bl31_params, (void *)fdt_addr);
+	atf_entry(bl31_params, (void *)plat_param);
 }
 
 static int spl_fit_images_find(void *blob, int os)
@@ -267,10 +269,11 @@ ulong spl_fit_images_get_entry(void *blob, int node)
 
 void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 {
-	ulong  bl32_entry = 0;
-	ulong  bl33_entry = CONFIG_TEXT_BASE;
-	void *blob = spl_image->fdt_addr;
+	bool falcon = CONFIG_IS_ENABLED(OS_BOOT) && spl_falcon_boot();
+	void *blob = spl_image_fdt_addr(spl_image);
+	ulong bl33_entry = CONFIG_TEXT_BASE;
 	ulong platform_param = (ulong)blob;
+	ulong bl32_entry = 0;
 	int node;
 
 	/*
@@ -283,15 +286,29 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 		bl32_entry = spl_fit_images_get_entry(blob, node);
 
 	/*
-	 * Find the U-Boot binary (in /fit-images) load addreess or
-	 * entry point (if different) and pass it as the BL3-3 entry
-	 * point.
-	 * This will need to be extended to support Falcon mode.
+	 * Find BL33 entry point. In Falcon mode, prefer Linux when requested.
+	 * Fall back to U-Boot if Linux cannot be resolved, unless secure Falcon
+	 * mode is in effect, in which case an unsigned fallback is not allowed.
 	 */
+	node = -FDT_ERR_NOTFOUND;
+	if (falcon)
+		node = spl_fit_images_find(blob, IH_OS_LINUX);
 
-	node = spl_fit_images_find(blob, IH_OS_U_BOOT);
-	if (node >= 0)
+	if (node < 0) {
+		if (falcon && CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			panic("SPL: TF-A: no Linux BL33 image for secure Falcon boot");
+		node = spl_fit_images_find(blob, IH_OS_U_BOOT);
+	}
+
+	if (node >= 0) {
 		bl33_entry = spl_fit_images_get_entry(blob, node);
+	} else if (falcon) {
+		/*
+		 * Falcon mode was requested, so U-Boot proper was never loaded
+		 * and CONFIG_TEXT_BASE holds nothing we could enter.
+		 */
+		panic("SPL: TF-A: no BL33 image to boot");
+	}
 
 	/*
 	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform
@@ -307,5 +324,5 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 	 * using similar logic.
 	 */
 	bl31_entry(spl_image->entry_point, bl32_entry,
-		   bl33_entry, platform_param);
+		   bl33_entry, (ulong)blob, platform_param);
 }

-- 
2.54.0

