Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F498C61DD3
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE18080F4D;
	Fri, 28 Aug 2026 13:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pXNaVMuo2RD; Fri, 28 Aug 2026 13:58:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925492;
	bh=dWex8iUEAEMjrmiWY7gwQFF+Rfx81FwT+DSNiHvR/hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1HbioA/cAhyc8bCliR0TCTd/niUbiKKkMCQElhiB0f3QRpEz48hDt5pZRDP3M6m6i
	 zHreGPsEkSdYyi2jaaFqL63GFAtRmwjbhtsdoZlHctxbXdreBulq3wbmtjeRB5NuJi
	 O3Bu28/kXzCQ+cL3nypamtAiEgeLxJqsV4msFH9yn43doOPDhRCXYUDujB6NicvbcF
	 qjBLL21QEu4m90KRO3X8D4AeEFDKac2k9Moek8e63P5FhmDwM1Y60TlvkOi/8FO8nd
	 f/JJJUyrgCKgTOSTW7G0QPiXn1lsSbso4UYNKsYaiHN5eTNUQq270V4Mtb2v/zm4S4
	 fqlS3ZjEgS1/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45E6180F29;
	Fri, 28 Aug 2026 13:58:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D65C2334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D469040867
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZpzi39i9yv9 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=nM4JNvn1
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CBC7E407E7
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E32934E41401;
 Fri, 28 Aug 2026 13:58:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B5FBE60537;
 Fri, 28 Aug 2026 13:58:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1FA6011C78247; 
 Fri, 28 Aug 2026 15:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925486; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=dWex8iUEAEMjrmiWY7gwQFF+Rfx81FwT+DSNiHvR/hs=;
 b=nM4JNvn19kVXxdRv/+VDc+P22iQs022UiTdeGDUWzLb0XSgtaqP/l28keVTAeRwC96nsA2
 /6CKoOE6TV3/9oyqwG4SDkD/tIq5S4WoKWMXifPUP4NoHeZ58LDFZhAUZiLbINTUUatTRj
 6Mi661r571fftB2yvyOKb1NOvnX1LBac7hdspKgeLE5U8g5X9RifRXkuUbYQkBJ17U8ZID
 NoxIE9NvVn9EquYdc8lTJHpHmpXwGzwLATLfRfbjX2Qhju96dFrzk9nB5d8W12DBs6n1Pr
 /xh4LPF6JO9wYS9INYFtnK9jLfTbsUPhwCNS0ERWhVyTR6+i1NETgvcJ+Q7jHg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 05/21] global: k3: use gd to store the resume state
Date: Fri, 28 Aug 2026 15:57:14 +0200
Message-ID: <20260828135730.1565643-6-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
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

For J7200, J784s4, J721e, j722s, j721s2 SoCs, the everything is shutdown
at suspend but the PMIC and the DDR.
In order for U-Boot SPL to know that it is resuming from suspend and not
booting, a flag is set in a PMIC register.
So, at startup, U-Boot will read the PMIC register and deduce if the
board is resuming from suspend or not.

This state (resuming or not) is consulted at several places (in
board_init_f() and in k3_ddrss_probe().
As it takes some time to read a i2c register, it's best to cache the
information.
But, as stated by the README, in board_init_f(), the BSS is not
available, so we cannot use global/static variables, only stack
variables and global_data.

Thus, we use gd to store the resume state of the board.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/include/asm/global_data.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index b2ec450f9002..a146206fdff9 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -14,6 +14,14 @@
 #include <linux/types.h>
 #include <asm/u-boot.h>
 
+#if IS_ENABLED(CONFIG_ARCH_K3)
+enum k3_resume_state {
+	K3_RESUME_STATE_UNKNOWN = 0,
+	K3_RESUME_STATE_BOOTING,
+	K3_RESUME_STATE_RESUMING
+};
+#endif
+
 /* Architecture-specific global data */
 struct arch_global_data {
 #if defined(CONFIG_FSL_ESDHC) || defined(CONFIG_FSL_ESDHC_IMX)
@@ -108,8 +116,19 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
+	enum k3_resume_state k3_resuming;
+#endif
 };
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
+#define gd_k3_resuming() gd->arch.k3_resuming
+#define gd_set_k3_resuming(state) gd->arch.k3_resuming = (state)
+#else
+#define gd_k3_resuming() 0
+#define gd_set_k3_resuming(state)
+#endif
+
 #include <asm-generic/global_data.h>
 
 #if defined(__clang__) || defined(LTO_ENABLE)
