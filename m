Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A4FC624D4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 00:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 747656083C;
	Thu,  3 Sep 2026 00:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HOF7ZCt3pHv; Thu,  3 Sep 2026 00:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98D1E607F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788394066;
	b=P0XlBorJfSGZO4yokpeUszcA36YmW/kh8foZBJIiAwOqsV0iVRZLRnP+J3oU8v8TZhE2
	 XDzev5wsbvWqtljuO2WN2Evy6ictS0IRcS9Lav8lp+XqiHH1yv2B3uwTcgVJQVoSZYt+L
	 FdV/UxuEvAFU2v9k50+SBFwtpf8/tDERjnC1WziiqYypIgoGaO+n16yzNXv/JSi/svI0A
	 fhx5s7YVZ9sqSZ1BBDt5qwmY4hW7eW9YkGC4mZmYIV4OM0YyCSJiTQsyoCRaBdWU1MxhK
	 slmIpmLPLjUnTM1ZZ66Kt/QisJiehEG4ABrMULbC/odlTsT+NmMib+ezZRreLW/41hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788394066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=boncnfoxiia96Vj6zMA+m0Hf7WXckTnjgmLxJawoRKQ=;
	b=P/yQanGq+UK3NVE7kfTdtJgkWFzZFCcG2kUvlJhH/sviqWsnM5G/3mlX2A3/sc3iMflh
	 58p1MZzJzO/tuSgBhz8ocQFjqx1azNZhtAruL40Qd4TpUwCzZNO5/RnfVaFtTAPxlfITS
	 eNIEa9sIuVP4MiiqmrfXxlc19PdULspoBSFuiVb5944GlC9I0IRi6YNW30mQ1wu3COV86
	 QJtBonmq5B1LEhOTgALzE3kstEQRaIqxmIy+iToFX72U2fle2oULEGtGLLI66O6bJjWj9
	 JHT/Ax4x8pKwKC/T+Wc6oo0ZI1Xg3cUrW+Hqq7OCLsQfAdFaU1XLhzn2KLkTGha2jvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788394066;
	bh=boncnfoxiia96Vj6zMA+m0Hf7WXckTnjgmLxJawoRKQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PMKOYz9VRIhCf1ZKOtwXggzMkThszyT7FWHzjvqMwV+9EF+dGT+ol4EapkC2Ea+wz
	 gZz3NGbMu+CA4UpmIeu1XKQtcQrUhqDQv68no733JKE6GoEpsygTI5pjhV3IjNgZoO
	 hbR6c2q0Z6hN1QKF6ukK2FSHE2xhn4koAJRMa5Kznq5RIoyYuHKK/uIAlX+kz4iiLl
	 f1D0pdVIeudplEes8CNmZAQbaYdqa4opcJ1SM2xWmqST+yxkAWIgC+zId1wPZotIkP
	 B4UlVjT2/1AN4RmAI6akzWDfLvWB55z/oxWWIaO0gZtoZxH8mEUIfmUXFjCilDwN9U
	 X/87cxVw5Qx4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98D1E607F5;
	Thu,  3 Sep 2026 00:07:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A22E2FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 00:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C1D840177
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 00:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YREQ_Zw_AuzR for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 00:07:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3FAD640063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788394064;
 b=Tkty6JOi7c3DKVTTWbRPyTbQnnqAeG0ruF1prYGPUdU97gRpi2HIQsO94/E3WG7UpuBP
 EE3sP52MbPpCWnlBp6YTXVuSzcziIyqEQwvoLH/4CojjdIzmUWAKF0yZbaeJiXU0pagu8
 icHxybPVkIzYRAO17q5v3s8IbQIX2YtE9/CiJzNe3Q3oNjvXGCjueLV02g2EfRr653EN7
 oPcD9cGJOP2v+njyn7bgUdOGbU6G1gJifMpfL+QQMb03g5ggOYmObmgmoCi/B1zD1BA/3
 fYc3R5NTVxn5D64C5hF1gF+54G4pstYTZNq0AO/EFI9+Rt6fa8aBFJQ3QINRcdCVhvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788394064;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=boncnfoxiia96Vj6zMA+m0Hf7WXckTnjgmLxJawoRKQ=;
 b=i4IEFyhybXFJ2dwrtAJqKeZOwf0cveH5lxMeEUNPJLJSByeriNtkx6IGh9+GyA3s/uiz
 fwOafmYd0srUJI3V+y02rTfd867b6oqx+lKfzDsvvaE/DSd+EkrefoB00iSvWXmjySpI4
 +yZL26cp8HKKLdFViOeeLeJljnRxzL7xwdduYqgvfTnl4theTITIwIJAc3sAmGn6X+A1X
 r81ISX4hDn+9FDK7hL945GuXTqC7MDC8OKuHeQ2AuYCVVsvIIZPFSYX1ZH668AAlh3nRB
 50PxqvVTperacJHai7egfizOZ+TFQRYU5bQeiAMKm/l2ZP+iYRcbotJPydfllZA2+Yg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=LYvAXBPe; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=LYvAXBPe
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FAD640063
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 00:07:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D0D3711D581; Thu, 03 Sep 2026 02:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1788394057; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=boncnfoxiia96Vj6zMA+m0Hf7WXckTnjgmLxJawoRKQ=;
 b=LYvAXBPeAO3FTBJjgAWzKM6Ro9HWqlHv2p4Usvpl3oidS4cSdphwJaMP8Y26nqQ7TokWfx
 x946j0R78a1oRHhwPB0fzxDIvQ70PCxMJgL+L54vwghnwvkY3HdEtDcVPi0FPy3lm9oq0l
 dWePAqaWilNZl1prG+lju0qwfb/xcuNvcsB+lmZB+gPe7eKPoOz6+fGUIzE+A3aTqpBk2M
 d+ucwrLZ0/JzxSeBukhTVmpkYi+brxeeQt3+0LF0ewv/vEcZxkixwMaIp9yIlhz2x1garE
 LcCkSwSRpv4LJ/nQHNc+6CcW13iecDROkn55rgOUNaKYWquknUcKyh2/Wp3ANQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] imx: imx8mm_evk: Indent the config with tabs
Date: Thu,  3 Sep 2026 02:07:08 +0200
Message-ID: <20260903000731.1091341-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Consistently indent the config header with tabs instead of a mix
of tabs and spaces. No functional change.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 include/configs/imx8mm_evk.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/configs/imx8mm_evk.h b/include/configs/imx8mm_evk.h
index 957d9c05083..36ee39746bd 100644
--- a/include/configs/imx8mm_evk.h
+++ b/include/configs/imx8mm_evk.h
@@ -11,33 +11,33 @@
 #include <asm/arch/imx-regs.h>
 
 #define UBOOT_ITB_OFFSET			0x57C00
-#define FSPI_CONF_BLOCK_SIZE		0x1000
-#define UBOOT_ITB_OFFSET_FSPI  \
+#define FSPI_CONF_BLOCK_SIZE			0x1000
+#define UBOOT_ITB_OFFSET_FSPI			\
 	(UBOOT_ITB_OFFSET + FSPI_CONF_BLOCK_SIZE)
 #ifdef CONFIG_FSPI_CONF_HEADER
-#define CFG_SYS_UBOOT_BASE  \
+#define CFG_SYS_UBOOT_BASE			\
 	(QSPI0_AMBA_BASE + UBOOT_ITB_OFFSET_FSPI)
 #else
-#define CFG_SYS_UBOOT_BASE	\
+#define CFG_SYS_UBOOT_BASE			\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 #endif
 
 #ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
-#define CFG_MALLOC_F_ADDR		0x930000
+#define CFG_MALLOC_F_ADDR			0x930000
 /* For RAW image gives a error info not panic */
 
 #endif
 
 /* Link Definitions */
 
-#define CFG_SYS_INIT_RAM_ADDR        0x40000000
-#define CFG_SYS_INIT_RAM_SIZE        0x200000
+#define CFG_SYS_INIT_RAM_ADDR			0x40000000
+#define CFG_SYS_INIT_RAM_SIZE			0x200000
 
-#define CFG_SYS_SDRAM_BASE           0x40000000
-#define PHYS_SDRAM                      0x40000000
-#define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
+#define CFG_SYS_SDRAM_BASE			0x40000000
+#define PHYS_SDRAM				0x40000000
+#define PHYS_SDRAM_SIZE				0x80000000	/* 2GB DDR */
 
-#define CFG_FEC_MXC_PHYADDR          0
+#define CFG_FEC_MXC_PHYADDR			0
 
 #endif
-- 
2.53.0

