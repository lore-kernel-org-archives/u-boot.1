Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88B606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hXwy/Tm9;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JPwIBVj0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB03581163;
	Wed, 18 Nov 2026 13:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CXmcPmkyutkh; Wed, 18 Nov 2026 13:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CF3181247
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007924;
	b=dRRWm+ZFOuNzvTJSWINhQk79kEmn8fI9RuO8AxGuD3RRuupMb3WOtgaZbGFNLlxa4gpt
	 9jtTqVqkN2g2aG95+aHobhTu3dNqi7KxDhomY38G6QBIjWtahEB9wSkir7z6B832HSFVc
	 OZB2JlZ5zra578HUVCOAvVkLgrIOW8dqZPuSYXHlx5gMNdD3yTM53oHFooD15cpQxPJR0
	 gzZER4GyYwkP9CpPaT9K4uIyFtbB3gv1usgPXu+WYiZZnQziOMVvXQDA+m8rMF4ngXuaa
	 trGq5rkAYYi6vftpKTbWXUkQ8+I/OaegDt55CYZs4RfNEDaxOo7rjZd5+UFvpyvbw5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007924;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xaoATHAHilRTR9o6QKhJDO7yDLrpraYCXGYS9lUmOBg=;
	b=n9wVtt3ekusGl53B/XA58v+JoiD5ZKm2NkOuEWi3DcUo407xx6drjRy7iGGUgY1RKSmm
	 SmCNbnmQVNCgK1JqhNf7iL/8rC3T7KX8iyO6MFLCiO5+3BwoW6OFeW8Phgr2fHlIPmTDL
	 0i16Mce/g+Trfpc2vrJv3u+d26dQR3IAxONZGuWb2LTxB+42MCG6YJg+Iv8PiNKwPtNEx
	 nU77hcZz4pKWpi6OlvP6a3baae8iBhglr9fta/3+zZE1btEEhU6/xqIeC4pqFCCVSGXIk
	 rjIsFhbpqx+p71tdlAQMU9hES/UvBR6LkeYcMGLUWp5pZArtdUI8+01Ejswprtfb7HQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007924;
	bh=xaoATHAHilRTR9o6QKhJDO7yDLrpraYCXGYS9lUmOBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hXwy/Tm9EWHGhAyQZGhcq4YuE5mlE9cWtd3mYO6pQLfTmh6F4hC0PE0uQr8W3aESO
	 c43Ehz9q+LSDwPtcDnf2i5w4vEMmM3CEgaaLb9xIGjfjQ7Hmm44uYT+7I+bjvoCpZ2
	 qKEdiR7IAsfzExjb6MC1KfQYNsoQoWkLyiTK/uGC8HSzFTyaotmUgTQt9YGaZpZamB
	 x0hjqhOV+tpcz85IBgt25zblrOFOfts8QFHx0/qMy+Mlpx8TgJ5YqntFlQstkHEKcM
	 zgBLvWw0Sdtwk4Qg8hiWbd+H7gtwv7e5z7dKdL+WzkKkWYXZYok8wqUkQoFUtPJHbA
	 HnZLyOt1PrnLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CF3181247;
	Wed, 18 Nov 2026 13:18:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F03CC61
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDC03409F7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIH7gGZzlfBy for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B0415409ED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=JPwIBVj0
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0415409ED
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D0F32C4F77E;
 Wed, 18 Nov 2026 13:18:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 084115FE9B;
 Wed, 18 Nov 2026 13:18:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 744FF11BC1D53; Wed, 18 Nov 2026 14:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007912; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=xaoATHAHilRTR9o6QKhJDO7yDLrpraYCXGYS9lUmOBg=;
 b=JPwIBVj0Q9OBmpSC4Qamz6K7mVEtK0sB7yktT9PvDZIvkKUcrUoUzNPOcOgOA2FC9OqSUj
 TvjdhjpotBatxq7kd0rYovxEvbqhHxaLSSAPxQQeeFhLobg41JL4um3e5OsiHl9zkbaeoS
 8U6DBm/qhdmRwX2QFSN+pNxkwiiAKo4ox9T227VnuE9VOhgxRc+LykR8mO8YAKQpqplSPj
 r8Yycy7hSoM10w0mIJDH8H0kXfd4A1Y3x3AHDBs2v+3u9IgCYdQvUzsgz3InQJYDLqdTwL
 7F8fOIYUqZ+3rkd8ixZW+OtBNTI0aNEjnrs/m6NVkjpR8z1i4FR+TIO+CYALTg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 04/20] mach-k3: r5: common: introduce
 j7xx_board_is_resuming()
Date: Wed, 18 Nov 2026 14:17:51 +0100
Message-ID: <20261118131807.135859-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the capability to detect a resume on J7200, J784s4, j722s, j721s2
SoCs.

To detect the resume, SPL searches a magic value (0xBA) in a register
of PMIC.
This value is set by DM-Firmware during the suspend sequence.

NB: Although this is called in board_init_f(), we can use global/static
variables because CONFIG_SPL_EARLY_BSS is selected.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/common.c                |  6 +++
 arch/arm/mach-k3/include/mach/hardware.h |  1 +
 arch/arm/mach-k3/r5/lpm-common.c         | 53 +++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3be..d934f732b330 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -713,3 +713,9 @@ int spl_start_uboot(void)
 	return 0;
 }
 #endif
+
+/* if r5/lpm-common.c is compiled, this will be overridden */
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 2c771a1195f5..c45bd3747163 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -137,6 +137,7 @@ u32 get_boot_device(void);
 const char *get_reset_reason(void);
 enum k3_device_type get_device_type(void);
 int k3_fit_config_match_security_state(const char *name);
+bool j7xx_board_is_resuming(void);
 
 #define writel_verify(val, addr) \
 do { \
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 91707fd19501..5d484f6df037 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -7,17 +7,25 @@
  */
 
 #include <clk.h>
+#include <dm/device.h>
 #include <dm/read.h>
 #include <elf.h>
 #include <linux/printk.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <power-domain.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 #include <mach/security.h>
 
 #include "../common.h"
 #include "../lpm-common.h"
 
+/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
+#define K3_LPM_MAGIC_SUSPEND 0xba
+
+/* PMIC register where the magic value resides */
+#define K3_LPM_SCRATCH_PAD_REG_3 0xcb
+
 #define CONTEXT_SAVE_SZ	0x80000
 #define ATF_CERT_SZ	0x80000
 #define OPTEE_CERT_SZ	0x100000
@@ -32,9 +40,50 @@ struct lpm_addr_info {
 	u32 size;
 };
 
-__weak bool j7xx_board_is_resuming(void)
+enum k3_resume_state {
+	K3_RESUME_STATE_UNKNOWN = 0,
+	K3_RESUME_STATE_BOOTING,
+	K3_RESUME_STATE_RESUMING
+};
+
+bool j7xx_board_is_resuming(void)
 {
-	return false;
+	static enum k3_resume_state k3_resuming;
+	struct udevice *pmic;
+	int ret, magic;
+
+	if (k3_resuming != K3_RESUME_STATE_UNKNOWN)
+		goto end;
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmic);
+	if (ret) {
+		printf("Getting PMIC init failed: %d\n", ret);
+		goto end;
+	}
+	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
+
+	magic = pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG_3);
+
+	if (magic == K3_LPM_MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		k3_resuming = K3_RESUME_STATE_RESUMING;
+
+		/* clean magic suspend */
+		ret = pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG_3, 0);
+
+		if (ret)
+			printf("Failed to clean magic value for suspend detection in PMIC\n");
+		/*
+		 * For robustness, the DM should also clean the magic value at
+		 * startup.
+		 */
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		k3_resuming = K3_RESUME_STATE_BOOTING;
+	}
+end:
+	return k3_resuming == K3_RESUME_STATE_RESUMING;
 }
 
 static const char *lpm_core_compatible;
