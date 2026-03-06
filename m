Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DC8F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4712183FC6;
	Fri,  6 Mar 2026 03:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtIZln+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6491C83FC5; Fri,  6 Mar 2026 03:37:16 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF4083F98
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-89a14be4733so43577226d6.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764631; x=1773369431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hdRNQ7jwwWicdDS9QF2IiTFByTOHEuFqGDUaHuYK0s=;
 b=TtIZln+n/evRpE3sK4UlRUvPYiZg+Ofvv805/AI1gBzNp2iwjT6Ybn4D5vqBjAqlge
 2Upq77vX1V4r1zHnFYNLcYs+5O+0NcfST0jBOyQe7+P+edBEf3nEKB1NK/xerufemS8j
 9WWB1AnUGcYjHkUbPP839iJYpwSon88WzTAAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764631; x=1773369431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8hdRNQ7jwwWicdDS9QF2IiTFByTOHEuFqGDUaHuYK0s=;
 b=cJbwt2XhqBHUEAn3xs56fVzVx1XopcXPaHzbZ8xPQqwTCWqNXHdN2OzXtovt+qTZw0
 fk9+MF8emGy28k5APfRGrvMZrW2YQsIAzGJgCHZs4WKq7pDUH+x7hvSMyY3nsfOATiqF
 BAUob31E6ay1Gj2yNfPgVPc8zTKq/BoWilRNn1iW6qfI159Tm5gNP4C2xawic/bvNwFm
 C4fYVRabEyZCO38BuCpXVxubSUvesPpKPSYBxczbsEaD1v0LQbYG8uh9jWlQpEy9HSxc
 l+JVj60AeBcb8/o/DUABFSn5Nk7s8TW6lVmZtPt5OGLgfthX/8ErKq1OnuZrxXExVoIt
 9XeA==
X-Gm-Message-State: AOJu0Yzr8DnALTP56rcf3xQkR5H171jYxWbyaGM32YFjAGS+mU7wy8Qx
 04Oy7F4VVcK/tr7W6ze7G8ru+ggkqkMvCZX4Syuc4GCOaZFQC1FfeFySaRv+lDXfkw5K1AQKXce
 y2Cw=
X-Gm-Gg: ATEYQzzyiLP9heVtfOXUfUuWqttJ1cValxxTWN0hCI3JLF04ewg10TG8bCg9qq9wc60
 AobL1sMk6BlPhEjCFU1MqXilNW4OmOkvcyUG7RCRUaTOxgPlh/AxrIOt2gNH7BVpxje7yk/PN20
 Qws2nMRk5SlVZ0BF21H+rJXC2lSvYJfVwSqGdyNFDS3vgKjSgzbjKF3eMAeJL52p62KHjanAVWk
 pVJQ/NmYJ3knWAQWHnn9IR7gCxGsYSVNRKm0V/yq23c14lqCiSBo9Zd0yac7yvYy1GrvhKTg8TJ
 RkKPyc8d9A07tm3fkcEa204goyb96CqFa0ny6QINtDhgrFljT/a6qlN+8rgB6WwXFvfAV8o30kn
 xXKa6BT7L4VG5uwDyrsnFeIp9bGb26xaCGlpcQo7Ep3wIA/Ox5TsNRH8ZKzfr2txLdhj5JqKIeo
 l9YEV9+j7cuN4v5s/edA==
X-Received: by 2002:ad4:5aeb:0:b0:89a:b37:6b20 with SMTP id
 6a1803df08f44-89a30a2a62cmr6695476d6.1.1772764631353; 
 Thu, 05 Mar 2026 18:37:11 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v4 06/17] riscv: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:15 -0700
Message-ID: <20260306023638.2678886-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The RISC-V announce_and_cleanup() duplicates the common pre-boot
steps. Replace it with a call to bootm_final().

Move board_quiesce_devices() into bootm_final() so it is available to
all architectures. Drop the RISC-V weak definition and header
declaration since the generic one in bootm.h is used instead.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v4:
- Drop announce_and_cleanup(), inline the two calls

Changes in v3:
- Drop udc_disconnect()
- Move board_quiesce_devices() into bootm_final() instead of dropping it
- Squash with the previous riscv patches

 arch/riscv/include/asm/u-boot-riscv.h |  1 -
 arch/riscv/lib/bootm.c                | 39 +++------------------------
 boot/bootm.c                          |  2 ++
 3 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/include/asm/u-boot-riscv.h b/arch/riscv/include/asm/u-boot-riscv.h
index 543a1688db8..3a8fdb57136 100644
--- a/arch/riscv/include/asm/u-boot-riscv.h
+++ b/arch/riscv/include/asm/u-boot-riscv.h
@@ -16,7 +16,6 @@ int cleanup_before_linux(void);
 
 /* board/.../... */
 int board_init(void);
-void board_quiesce_devices(void);
 int riscv_board_reserved_mem_fixup(void *fdt);
 int riscv_fdt_copy_resv_mem_node(const void *src_fdt, void *dest_fdt);
 
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 9544907ab1e..69c9ca5c487 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -25,39 +25,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-__weak void board_quiesce_devices(void)
-{
-}
-
-/**
- * announce_and_cleanup() - Print message and prepare for kernel boot
- *
- * @fake: non-zero to do everything except actually boot
- */
-static void announce_and_cleanup(int fake)
-{
-	printf("\nStarting kernel ...%s\n\n", fake ?
-		"(fake run for tracing)" : "");
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
-#ifdef CONFIG_BOOTSTAGE_FDT
-	bootstage_fdt_add_report();
-#endif
-#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
-
-	board_quiesce_devices();
-
-	/*
-	 * Call remove function of all devices with a removal flag set.
-	 * This may be useful for last-stage operations, like cancelling
-	 * of DMA operation or releasing device internal buffers.
-	 */
-	dm_remove_devices_active();
-
-	cleanup_before_linux();
-}
-
 static void boot_prep_linux(struct bootm_headers *images)
 {
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && IS_ENABLED(CONFIG_LMB) && images->ft_len) {
@@ -75,7 +42,6 @@ static void boot_prep_linux(struct bootm_headers *images)
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	void (*kernel)(ulong hart, void *dtb);
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
 #ifdef CONFIG_SMP
 	int ret;
 #endif
@@ -87,9 +53,10 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	debug("## Transferring control to kernel (at address %08lx) ...\n",
 	      (ulong)kernel);
 
-	announce_and_cleanup(fake);
+	bootm_final(flag);
+	cleanup_before_linux();
 
-	if (!fake) {
+	if (!(flag & BOOTM_STATE_OS_FAKE_GO)) {
 		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
 #ifdef CONFIG_SMP
 			ret = smp_call_function(images->ep,
diff --git a/boot/bootm.c b/boot/bootm.c
index cba10b5dce7..e553497192c 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1208,6 +1208,8 @@ void bootm_final(int flag)
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
 		bootstage_report();
 
+	board_quiesce_devices();
+
 	/*
 	 * Call remove function of all devices with a removal flag set.
 	 * This may be useful for last-stage operations, like cancelling
-- 
2.43.0

