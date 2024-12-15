Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD8EE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A462B80192;
	Mon, 16 Dec 2024 00:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Qj/TR7ea";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lHVcQYKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A530F80050; Mon, 16 Dec 2024 00:58:39 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8422080092
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YBKlx2Dwsz9stH;
 Mon, 16 Dec 2024 00:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734307117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqIwJ5KCP3/3gbmJpvr9na3ykiseTnSTKMMQSbNDH/w=;
 b=Qj/TR7ea8Tq7s9s8XPAnR7ooRh4iJAvKITGYkbx8xO9dDPwJLI7E1Q4hBO+xD6Tea5kFED
 /5QPDAQEh4WIsdPB+THuF/oM4cPoRtwMI9sy1+Tw9kDMGmU9tmKq2uSDpZUEyjDN3fqd4r
 fmFGfGdGlnKfJDUjbnacjXdwGhQKlBrXz3qjMdz28161ufeFW7P3Jm7OZHbp+ql9E2Z1jC
 MqGmYaqb9872qEmsCfNDmggno+hoWF0kIeL5rj3hZMy0LUAC8wmVnLuDYXgnzVmwJGHZ5c
 JZRD47Ullw0VTkOPSgODjNWQZ8t7TTmh4SbC4lAjYEZdBP11B7XORGkcCj+2zA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734307115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqIwJ5KCP3/3gbmJpvr9na3ykiseTnSTKMMQSbNDH/w=;
 b=lHVcQYKhs8Y6S15P34M7w9nw0+Tj36wkZVgo0jWQhWE7JVA0JorU+Gy3wI1H4ra2X9CaAI
 ExDmvk6+aShJB6Izo1zTpKgvmCf0XzIaDW1bVemf7/t+VkOIGlrI4FLXjZBk+DEn14e/8V
 P1h+Ns9uErMPTijRjdsoWSKmjiTM3ZGKalX+TTpGZkKmSMXupz3uucW0/s/6tFKYnL+BC2
 HJrzaR1iZbZWq7Mlptl36izthSL67S40JnZM5ltZKkMR3Mj8U6M5o7zFFNMq94NjlxJVAX
 plIe9TzHrax3in5fBRFrvKS8c86wdw6U+HLaOnmg5f3V4LHVoXrFgKM3gfMciw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] net: rswitch: Fix up macro indent
Date: Mon, 16 Dec 2024 00:57:50 +0100
Message-ID: <20241215235815.572689-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241215235815.572689-1-marek.vasut+renesas@mailbox.org>
References: <20241215235815.572689-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 78d204460ba70eb4656
X-MBO-RS-META: 689uon6y9spmqd8agpjwpx3ge9oqsugh
X-Rspamd-Queue-Id: 4YBKlx2Dwsz9stH
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

Update the macro indent, replace multiple spaces with tabs proper.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 136 +++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index cbc9a413313..91e2c7b7845 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -36,86 +36,86 @@
 #define RSWITCH_MAX_CTAG_PCP	7
 
 /* Registers */
-#define RSWITCH_COMA_OFFSET     0x00009000
-#define RSWITCH_ETHA_OFFSET     0x0000a000      /* with RMAC */
-#define RSWITCH_ETHA_SIZE       0x00002000      /* with RMAC */
+#define RSWITCH_COMA_OFFSET	0x00009000
+#define RSWITCH_ETHA_OFFSET	0x0000a000	/* with RMAC */
+#define RSWITCH_ETHA_SIZE	0x00002000	/* with RMAC */
 #define RSWITCH_GWCA_OFFSET	0x00010000
 #define RSWITCH_GWCA_SIZE	0x00002000
 
-#define FWRO    0
-#define CARO    RSWITCH_COMA_OFFSET
-#define GWRO    0
-#define TARO    0
-#define RMRO    0x1000
+#define FWRO			0
+#define CARO			RSWITCH_COMA_OFFSET
+#define GWRO			0
+#define TARO			0
+#define RMRO			0x1000
 
 /* List of TSNA registers (ETHA) */
-#define EAMC		(TARO + 0x0000)
-#define EAMS		(TARO + 0x0004)
-#define EATDQDCR	(TARO + 0x0060)
-#define EATTFC		(TARO + 0x0138)
-#define EATASRIRM	(TARO + 0x03e4)
+#define EAMC			(TARO + 0x0000)
+#define EAMS			(TARO + 0x0004)
+#define EATDQDCR		(TARO + 0x0060)
+#define EATTFC			(TARO + 0x0138)
+#define EATASRIRM		(TARO + 0x03e4)
 /* Gateway CPU agent block (GWCA) */
-#define GWMC		(GWRO + 0x0000)
-#define GWMS		(GWRO + 0x0004)
-#define GWMTIRM		(GWRO + 0x0100)
-#define GWVCC		(GWRO + 0x0130)
-#define GWTTFC		(GWRO + 0x0138)
-#define GWDCBAC0	(GWRO + 0x0194)
-#define GWDCBAC1	(GWRO + 0x0198)
-#define GWTRCR		(GWRO + 0x0200)
-#define GWARIRM		(GWRO + 0x0380)
-#define GWDCCR		(GWRO + 0x0400)
+#define GWMC			(GWRO + 0x0000)
+#define GWMS			(GWRO + 0x0004)
+#define GWMTIRM			(GWRO + 0x0100)
+#define GWVCC			(GWRO + 0x0130)
+#define GWTTFC			(GWRO + 0x0138)
+#define GWDCBAC0		(GWRO + 0x0194)
+#define GWDCBAC1		(GWRO + 0x0198)
+#define GWTRCR			(GWRO + 0x0200)
+#define GWARIRM			(GWRO + 0x0380)
+#define GWDCCR			(GWRO + 0x0400)
 /* List of Common Agent registers (COMA) */
-#define RRC		(CARO + 0x0004)
-#define RCEC		(CARO + 0x0008)
-#define RCDC		(CARO + 0x000c)
-#define CABPIRM		(CARO + 0x0140)
+#define RRC			(CARO + 0x0004)
+#define RCEC			(CARO + 0x0008)
+#define RCDC			(CARO + 0x000c)
+#define CABPIRM			(CARO + 0x0140)
 /* List of MFWD registers */
-#define FWPC		(FWRO + 0x0100)
-#define FWPBFCR		(FWRO + 0x4a00)
-#define FWPBFCSDCR	(FWRO + 0x4a04)
+#define FWPC			(FWRO + 0x0100)
+#define FWPBFCR			(FWRO + 0x4a00)
+#define FWPBFCSDCR		(FWRO + 0x4a04)
 /* List of RMAC registers (RMAC) */
-#define MPSM		(RMRO + 0x0000)
-#define MPIC		(RMRO + 0x0004)
-#define MRMAC0		(RMRO + 0x0084)
-#define MRMAC1		(RMRO + 0x0088)
-#define MRAFC		(RMRO + 0x008c)
-#define MRSCE		(RMRO + 0x0090)
-#define MRSCP		(RMRO + 0x0094)
-#define MLVC		(RMRO + 0x0180)
-#define MLBC		(RMRO + 0x0188)
-#define MXGMIIC		(RMRO + 0x0190)
-#define MPCH		(RMRO + 0x0194)
-#define MANM		(RMRO + 0x019c)
-#define MMIS0		(RMRO + 0x0210)
-#define MMIS1		(RMRO + 0x0220)
+#define MPSM			(RMRO + 0x0000)
+#define MPIC			(RMRO + 0x0004)
+#define MRMAC0			(RMRO + 0x0084)
+#define MRMAC1			(RMRO + 0x0088)
+#define MRAFC			(RMRO + 0x008c)
+#define MRSCE			(RMRO + 0x0090)
+#define MRSCP			(RMRO + 0x0094)
+#define MLVC			(RMRO + 0x0180)
+#define MLBC			(RMRO + 0x0188)
+#define MXGMIIC			(RMRO + 0x0190)
+#define MPCH			(RMRO + 0x0194)
+#define MANM			(RMRO + 0x019c)
+#define MMIS0			(RMRO + 0x0210)
+#define MMIS1			(RMRO + 0x0220)
 
 /* COMA */
-#define RRC_RR		BIT(0)
-#define RCEC_RCE	BIT(16)
+#define RRC_RR			BIT(0)
+#define RCEC_RCE		BIT(16)
 
-#define CABPIRM_BPIOG	BIT(0)
-#define CABPIRM_BPR	BIT(1)
+#define CABPIRM_BPIOG		BIT(0)
+#define CABPIRM_BPR		BIT(1)
 
 /* MFWD */
-#define FWPC0(i)	(FWPC + (i) * 0x10)
-#define FWPC0_LTHTA     BIT(0)
-#define FWPC0_IP4UE     BIT(3)
-#define FWPC0_IP4TE     BIT(4)
-#define FWPC0_IP4OE     BIT(5)
-#define FWPC0_L2SE      BIT(9)
-#define FWPC0_IP4EA     BIT(10)
-#define FWPC0_IPDSA     BIT(12)
-#define FWPC0_IPHLA     BIT(18)
-#define FWPC0_MACSDA    BIT(20)
-#define FWPC0_MACHLA    BIT(26)
-#define FWPC0_MACHMA    BIT(27)
-#define FWPC0_VLANSA    BIT(28)
-
-#define FWPC0_DEFAULT   (FWPC0_LTHTA | FWPC0_IP4UE | FWPC0_IP4TE | \
-			 FWPC0_IP4OE | FWPC0_L2SE | FWPC0_IP4EA | \
-			 FWPC0_IPDSA | FWPC0_IPHLA | FWPC0_MACSDA | \
-			 FWPC0_MACHLA | FWPC0_MACHMA | FWPC0_VLANSA)
+#define FWPC0(i)		(FWPC + (i) * 0x10)
+#define FWPC0_LTHTA		BIT(0)
+#define FWPC0_IP4UE		BIT(3)
+#define FWPC0_IP4TE		BIT(4)
+#define FWPC0_IP4OE		BIT(5)
+#define FWPC0_L2SE		BIT(9)
+#define FWPC0_IP4EA		BIT(10)
+#define FWPC0_IPDSA		BIT(12)
+#define FWPC0_IPHLA		BIT(18)
+#define FWPC0_MACSDA		BIT(20)
+#define FWPC0_MACHLA		BIT(26)
+#define FWPC0_MACHMA		BIT(27)
+#define FWPC0_VLANSA		BIT(28)
+
+#define FWPC0_DEFAULT		(FWPC0_LTHTA | FWPC0_IP4UE | FWPC0_IP4TE | \
+				 FWPC0_IP4OE | FWPC0_L2SE | FWPC0_IP4EA | \
+				 FWPC0_IPDSA | FWPC0_IPHLA | FWPC0_MACSDA | \
+				 FWPC0_MACHLA | FWPC0_MACHMA | FWPC0_VLANSA)
 
 #define FWPBFC(i)	(FWPBFCR + (i) * 0x10)
 #define FWPBFCSDC(j, i)	(FWPBFCSDCR + (i) * 0x10 + (j) * 0x04)
@@ -148,8 +148,8 @@
 #define MDIO_WRITE_C45		0x01
 #define MDIO_ADDR_C45		0x00
 
-#define MDIO_READ_C22           0x02
-#define MDIO_WRITE_C22          0x01
+#define MDIO_READ_C22		0x02
+#define MDIO_WRITE_C22		0x01
 
 #define MPSM_POP_MASK		(0x03 << 13)
 #define MPSM_PRA_MASK		(0x1f << 8)
-- 
2.45.2

