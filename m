Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF28E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498408005B;
	Mon, 16 Dec 2024 00:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qOgQnOx8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fp3ZTZnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A936280137; Mon, 16 Dec 2024 00:58:38 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79FBD80050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YBKlw1PCpz9sdW;
 Mon, 16 Dec 2024 00:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734307116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mEvTAhkV+b7USbzFm7yD1Uzyrcyd4zG+0MVFJZMfcOY=;
 b=qOgQnOx8R4cISbYF0fQlOWNnyUZl6C1b79rmGCoNQuX+tL02IhD+s11x3db71beU84k2vm
 32N87umc6Ss/ZJqZd0HIobGkZmqIt7eNNvfL1ymdTPYXoxw0RhzB5Uck3sxNa01CQrGhVC
 Tnh+Q7XVqBfSaZpjBuGCwRftWsiWjUZojE3IfjGZHRZclZmDNum3hEZg3JOMALvCvl7j3p
 rHCpu1KzgL0VkH4WDoMz08B4ylYh18Afr4KP6Y5bSoyAZ5fJZvb9zzWlfn6OC/HCy66bmb
 B5/KD9CotAwqq9cjkmLs6T+fG8Qvz+ygpOAOlDMQUB3J+yG+XBvXS1TWcbtS7w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734307114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mEvTAhkV+b7USbzFm7yD1Uzyrcyd4zG+0MVFJZMfcOY=;
 b=fp3ZTZnwETWur1JHuJVN8LIeCKx9NeJh6BY0nJVcdP9rSdgeiTvl/zYlipu7yg31xohVpC
 sqnTYPfPo5Eg5yblROyLcASenqKq/ELmxQav400d13ER7nysxZRGmTKqwOybYxhJGBamBO
 bhby7tHSCKWBa6JVApsgKyU0Lq3wmyvPUMDUlKzxVgGrZSSIlZxoX4GXVt4DZ6GswtFsax
 La3cpJhC+2+3SEQowr6R16M2SjP5aFdZEzWaWnshW2TacALp5DtLAAIjmW0Ue8z/4BmlvT
 wAJwxEEe5HZfGJQEs7R9KM6Ln0e5/t64dfu34WdMNJdaW/9ECbeXUH6fF5E5gg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] net: rswitch: Replace enum rswitch_reg with plain macros
Date: Mon, 16 Dec 2024 00:57:49 +0100
Message-ID: <20241215235815.572689-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5715e71e0626c7467f7
X-MBO-RS-META: 78fpjt4amepxq8smeff8mms388q38rgw
X-Rspamd-Queue-Id: 4YBKlw1PCpz9sdW
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

Replace enum rswitch_reg with plain #define REGISTER OFFSET macros.
The enum rswitch_reg was not referenced anywhere, so there was no
benefit of keeping it around. Include register block labels. Turn
all register offsets into lowercase hex values. No functional change.

Rename EATDQDC to EATDQDCR, GWTRC to GWTRCR, GWDCC to GWDCCR, FWPC0
to FWPC, FWPBFC to FWPBFCR, FWPBFCSDC to FWPBFCSDCR because there
are both register names which used to be part of this enum and also
macros with the same name, each used for slightly different purpose.
Make sure there is no collission.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 95 +++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 8e1b6e2f6f6..cbc9a413313 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -48,48 +48,47 @@
 #define TARO    0
 #define RMRO    0x1000
 
-enum rswitch_reg {
-	EAMC		= TARO + 0x0000,
-	EAMS		= TARO + 0x0004,
-	EATDQDC		= TARO + 0x0060,
-	EATTFC          = TARO + 0x0138,
-	EATASRIRM	= TARO + 0x03E4,
-
-	GWMC		= GWRO + 0x0000,
-	GWMS		= GWRO + 0x0004,
-	GWMTIRM		= GWRO + 0x0100,
-	GWVCC		= GWRO + 0x0130,
-	GWTTFC		= GWRO + 0x0138,
-	GWDCBAC0	= GWRO + 0x0194,
-	GWDCBAC1	= GWRO + 0x0198,
-	GWTRC		= GWRO + 0x0200,
-	GWARIRM		= GWRO + 0x0380,
-	GWDCC		= GWRO + 0x0400,
-
-	RRC		= CARO + 0x0004,
-	RCEC		= CARO + 0x0008,
-	RCDC		= CARO + 0x000C,
-	CABPIRM		= CARO + 0x0140,
-
-	FWPC0		= FWRO + 0x0100,
-	FWPBFC		= FWRO + 0x4A00,
-	FWPBFCSDC	= FWRO + 0x4A04,
-
-	MPSM		= RMRO + 0x0000,
-	MPIC		= RMRO + 0x0004,
-	MRMAC0		= RMRO + 0x0084,
-	MRMAC1		= RMRO + 0x0088,
-	MRAFC		= RMRO + 0x008C,
-	MRSCE		= RMRO + 0x0090,
-	MRSCP		= RMRO + 0x0094,
-	MLVC		= RMRO + 0x0180,
-	MLBC		= RMRO + 0x0188,
-	MXGMIIC		= RMRO + 0x0190,
-	MPCH		= RMRO + 0x0194,
-	MANM		= RMRO + 0x019C,
-	MMIS0		= RMRO + 0x0210,
-	MMIS1		= RMRO + 0x0220,
-};
+/* List of TSNA registers (ETHA) */
+#define EAMC		(TARO + 0x0000)
+#define EAMS		(TARO + 0x0004)
+#define EATDQDCR	(TARO + 0x0060)
+#define EATTFC		(TARO + 0x0138)
+#define EATASRIRM	(TARO + 0x03e4)
+/* Gateway CPU agent block (GWCA) */
+#define GWMC		(GWRO + 0x0000)
+#define GWMS		(GWRO + 0x0004)
+#define GWMTIRM		(GWRO + 0x0100)
+#define GWVCC		(GWRO + 0x0130)
+#define GWTTFC		(GWRO + 0x0138)
+#define GWDCBAC0	(GWRO + 0x0194)
+#define GWDCBAC1	(GWRO + 0x0198)
+#define GWTRCR		(GWRO + 0x0200)
+#define GWARIRM		(GWRO + 0x0380)
+#define GWDCCR		(GWRO + 0x0400)
+/* List of Common Agent registers (COMA) */
+#define RRC		(CARO + 0x0004)
+#define RCEC		(CARO + 0x0008)
+#define RCDC		(CARO + 0x000c)
+#define CABPIRM		(CARO + 0x0140)
+/* List of MFWD registers */
+#define FWPC		(FWRO + 0x0100)
+#define FWPBFCR		(FWRO + 0x4a00)
+#define FWPBFCSDCR	(FWRO + 0x4a04)
+/* List of RMAC registers (RMAC) */
+#define MPSM		(RMRO + 0x0000)
+#define MPIC		(RMRO + 0x0004)
+#define MRMAC0		(RMRO + 0x0084)
+#define MRMAC1		(RMRO + 0x0088)
+#define MRAFC		(RMRO + 0x008c)
+#define MRSCE		(RMRO + 0x0090)
+#define MRSCP		(RMRO + 0x0094)
+#define MLVC		(RMRO + 0x0180)
+#define MLBC		(RMRO + 0x0188)
+#define MXGMIIC		(RMRO + 0x0190)
+#define MPCH		(RMRO + 0x0194)
+#define MANM		(RMRO + 0x019c)
+#define MMIS0		(RMRO + 0x0210)
+#define MMIS1		(RMRO + 0x0220)
 
 /* COMA */
 #define RRC_RR		BIT(0)
@@ -99,7 +98,7 @@ enum rswitch_reg {
 #define CABPIRM_BPR	BIT(1)
 
 /* MFWD */
-#define FWPC0(i)	(FWPC0 + (i) * 0x10)
+#define FWPC0(i)	(FWPC + (i) * 0x10)
 #define FWPC0_LTHTA     BIT(0)
 #define FWPC0_IP4UE     BIT(3)
 #define FWPC0_IP4TE     BIT(4)
@@ -118,13 +117,13 @@ enum rswitch_reg {
 			 FWPC0_IPDSA | FWPC0_IPHLA | FWPC0_MACSDA | \
 			 FWPC0_MACHLA | FWPC0_MACHMA | FWPC0_VLANSA)
 
-#define FWPBFC(i)	(FWPBFC + (i) * 0x10)
-#define FWPBFCSDC(j, i)	(FWPBFCSDC + (i) * 0x10 + (j) * 0x04)
+#define FWPBFC(i)	(FWPBFCR + (i) * 0x10)
+#define FWPBFCSDC(j, i)	(FWPBFCSDCR + (i) * 0x10 + (j) * 0x04)
 
 /* ETHA */
 #define EATASRIRM_TASRIOG	BIT(0)
 #define EATASRIRM_TASRR		BIT(1)
-#define EATDQDC(q)		(EATDQDC + (q) * 0x04)
+#define EATDQDC(q)		(EATDQDCR + (q) * 0x04)
 #define EATDQDC_DQD		(0xff)
 
 /* RMAC */
@@ -189,8 +188,8 @@ enum rswitch_gwca_mode {
 #define GWARIRM_ARR		BIT(1)
 #define GWVCC_VEM_SC_TAG	(0x3 << 16)
 #define GWDCBAC0_DCBAUP		(0xff)
-#define GWTRC(i)		(GWTRC + (i) * 0x04)
-#define GWDCC(i)		(GWDCC + (i) * 0x04)
+#define GWTRC(i)		(GWTRCR + (i) * 0x04)
+#define GWDCC(i)		(GWDCCR + (i) * 0x04)
 #define	GWDCC_DQT		BIT(11)
 #define GWDCC_BALR		BIT(24)
 
-- 
2.45.2

