Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA4606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VfUqODA5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yrnJomhL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FB9460623;
	Sun,  1 Nov 2026 21:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1a3qPtKBU0et; Sun,  1 Nov 2026 21:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DBAB60684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567145;
	b=dpbGAi/PNSxjPZzEGJ7hwgiSRKalYarYx56pdmYxp9KhfWAWbMCMNuwFXKlTREZPCFCo
	 mIwBqlcun3hRKMhgkFByI61gn5ZPhgD7ramaVePXAUy+3YeX24DaF35RjPiFuLnUrWmEe
	 4UrdX5WqJi9zkHjoeG0G36Syc5ptirgMNLoHgRlBCkaJrMcY2yXjcV+s8P0qqLSKJMVoe
	 39J1AWnCG9DSNyzhqCpdbMw79nY0qaFMG1359xUja4+YangpK5myCls+EaATIDnVwq7u6
	 tG3ZA90YgltuoNcfNi3HBBErT//dKTZmtEEzpyf24nx1dCxvqEO6MLH+M3sRBIeFfCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rW9jApSx6mY1TtyDqTks3Yd2vuKPcLVrzWPu5ggBFfU=;
	b=nA6JQOPfKRWBM5GRkhCNNLeunUOTxQ4Td7n6RA9RpjKd7Tp9W1IksOIvT99cj4tjhqK1
	 vSjJiuV/dV5KB+8ym38sSHhvOJkP5y3dR1I4V1Df+Kh8fz+YiCAm2W88nqJ5SPgk+6tAq
	 djoZ7XfDFTLislNunD6BdJ53hHlZYm02+R+Y9IMPnY31/AjuLkwO3HdruSwreRSxqGLOI
	 b993Ph42TqRhf7kcMXFf/XUnvs3Bx7O6cHNTrpz0SwFdEv4SzWmhsqRgCjNEQGNLEkPBH
	 jpMSqcb6BrOmqO0JC+Ddj9xjw3ktyfOTWbXRLOAIGYYHm7Ak+WuGULjRq6aQJrrWO9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567145;
	bh=rW9jApSx6mY1TtyDqTks3Yd2vuKPcLVrzWPu5ggBFfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VfUqODA5jVNznFQn0Rt8df+Ca5886yTtOTN8Xn3DsAq8fIlkP23p/DP6WUlRNNIY6
	 azNzn6LjgyOITtCu8A2qQbEUt8M2oOlJnMiMpjZ/qRohfFkdX1Qn/YjLYdsibyeLZK
	 7pUidS0e46McRNHPDNE7RpeUCXB/aZ8NsUDeRterNY0J1wfuxjfVxMhT5R7HAbeBW+
	 B6Tebst6y7t0RdTK/cEZNvbDmgiVlOH65ZGqoFujFMkB68m6exztFR07NE00AbFHYr
	 avYQjQbME2xmV0PbMnDKHx3XtiCdmQVELTmIjmshDsJ0pdNven3fdZYgKCLUG03Vg2
	 RgWzpUqlWnCrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DBAB60684;
	Sun,  1 Nov 2026 21:05:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67EE134D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E61A80D7D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FrOG4EDQDMcO for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0758380DB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567142;
 b=Lk5z1B2uQ/2Tckh1e7i5werwLrsNXVvYNCyWIKJIU9Go+02Q48V2YhI2tokrFl/Kqt3r
 AIULCFd60GHmsN8H5S0gOcNnAg1pO5r5YOv5vRonAQvL0DSCN/0107spj9aPWiY8YPVHb
 YDhrRZvGgq3OGLcX1ctYTpV+j6XAV0ZYoFokiXnH0PE+uY3F/WuAiaMxkH6SazDV4POn4
 zZqdO5cQ3AdPMCkY7hRTVDIaj5mxjTCLwe5HXd5JhH/RpkaniLq10+1uae4lHFqjo5FX/
 H7JJbu/S2vrOvs8EEa0KAEFGruArBCjjOTfDH/OXgdhLuyJgYAwxa9zrqGyKvb2BC+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567142;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rW9jApSx6mY1TtyDqTks3Yd2vuKPcLVrzWPu5ggBFfU=;
 b=J5dB1jJPt8rtkZsQM082isxxC1q7r09dCLt/6Ns6hgyrN65t7Zh6acWk3/3FI0R/c6MC
 jHYO7gueujNHo0WC6AnH/tonWjOKPPr1AJvVbv5qgMDa4p4LiXkny9HuWR5B3B/AVSa7x
 Uu3KbPIbRg3ZcLxcAehbm9PdgKn684mmi76x/Zr+WdzUHpV3wZvPnx5a7L2ntLYippP2/
 nxWXq5oZcdZMF9AQu5BXi9LlRzf4fr7rgBx0WoJPZiQh5kIBGIR5uSPCO06hevrUViBsv
 QnC/fa76bws5WiK9p1HJdsYLcdsw18VO0Kwxl2V2OLJsKdFZBcw5gbcjCOT8LG0Rirg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=yrnJomhL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yrnJomhL
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0758380DB2
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:41 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3ac65e845a8so27489271fa.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567139; x=1794171939;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rW9jApSx6mY1TtyDqTks3Yd2vuKPcLVrzWPu5ggBFfU=;
 b=yrnJomhLWOADx7X6ryKrcfU2oO7ttvY9meXfmIYzrhWgFpPNH2r5+BS7/Hhy3zMQh+
 U+rbmKaXQhJogYm4Pas8x0iOCRJFVabmoIE5HjQt+Fhy6iqvDzFu7mrXpekTDy6Vz3VD
 Ky+8QS9YIi8dRWn/cbXvSVP52Q7plBHX8SNvB6r4BT9S6zATdPaEOyJTFMTC298qaVqZ
 JDTXK46PXlvakBg9vVOwEoJ4D7t8Kfa6WXUHVWpvDZVMXFBg/wfWk/xKKS0+iUVTze7q
 H3YR+Pi3no0o4lsa8p0LXMgSTmXH+gJMNJ/TzcLg71dI9oTaOqqxXWypflL/4GwvJ60A
 z8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567139; x=1794171939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rW9jApSx6mY1TtyDqTks3Yd2vuKPcLVrzWPu5ggBFfU=;
 b=rcOaLxyV9+faLx2PPuW93LnCMWF79Pk1aDLPlMGRwWw463tgxUmvn5QKL9HWbx4VLM
 YJIvYqJRBHrHaKsqCvODRRdIBYGoq1G1YjG/eYBcJsQff0Qan76scPspV2uHfailI4P1
 FkVJN1ysaJ4CzaOVH1ZY1LfIMJO06Zj06dxbm8U/cnx+tJtdElaJeRYJlIbIO9XGK3+o
 5KO91bivmPnHJZXhzjhkk3QscsPudvVvlppAKWAauvR36cO8TnXOjOFsdVBgfKgyVw26
 F2VMb9yJ1Hein9tZbRStJ7YHUuUpyE1dYYQuCtH7cSqtYiz7Stmt9f/CThF7WnUnHn7X
 oyUA==
X-Gm-Message-State: APuU4Z9rL0eOFuKCEpIz2RzyVOTXzuxp97RvdqEJOtfnvt3Emac1jvRf
 ce3Ec3LSbM6xgxVGRKi1GC15zV1X2rmZ+eXCRQ1uPQvyoyLpgBCgzstyrsd2tWyv
X-Gm-Gg: AYBFou0R+rdyhVILys16IT9cx+RwSZGov3k/YwEIW10jYri5yzUnASJ4aycbzrz7I+A
 l3FuFUhclx64BnWIDZztePldU6w0SkdsmSYa8JyoLf7vHisJd7FXs0C77GBv9esTlk5yXQveA8O
 pxMqoXC4FUuNXZtKelihzY03QYVjds4yIwpUtG1nTxBgaeMNY9G4fyYiZfETGk88rV7xTy/qYGo
 Xb0KTGOlQLwFHj/ToqksIjaiY3JgrZZkrRBPlZRDxrnYTu1F9x9KJX+IT846c0ChlkaRoWp4Y0P
 Fj8XbzHHn5XA6dVc9JlRiksBBc5PaIKSkKcER03nIpFjIFrWOLNun8qy57GZWBJ3yUlW6dhWCFJ
 /Gff+l5kwoFCzCL21guqT1Z2vEOejcvRwxHQjpkLGIQu040mQz092icn8k5qv33Mk24Cm/O9iaX
 hJ016dQywhPFkr58yQJLUPCCpihfaCLXp8L8J/mNFi0yGAF+cxkohtmF00wU58rYzcCYr/WvMdN
 T75iDnxm4bNX5GzWBYXhmeN8AVR1ozzNKWxQfvYmVe1Mz/Ll11cs3U2LCONb6FwN1fqysgl1PoX
 00LysZU3hAPzz53p/F4HNw1Se+8+2bQY8cEsPkrvE36Fn7Xj3+un+X9FNgoIj6imje4=
X-Received: by 2002:a05:651c:1474:b0:3aa:e5df:f852 with SMTP id
 38308e7fff4ca-3acb7abba3fmr16001521fa.14.1793567138870; 
 Sun, 01 Nov 2026 13:05:38 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:36 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 04/10] sunxi: dram: fix integer-pointer conversions in the D1
 DRAM driver
Date: Sun,  1 Nov 2026 23:04:43 +0200
Message-ID: <20261101210449.1235102-5-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix readl()/writel() address types for GCC 15+

Use typed base address macros and cast remaining register addresses
to void __iomem * to satisfy GCC 15's stricter type checking.

No functional change.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 drivers/ram/sunxi/dram_sun20i_d1.c | 383 ++++++++++++++++-------------
 1 file changed, 209 insertions(+), 174 deletions(-)

diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index 79cf0a51e47..68697fb2fa9 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -12,6 +12,7 @@
  * [1] https://github.com/szemzoa/awboot.git
  */
 
+#include <asm/arch/cpu.h>
 #include <asm/io.h>
 #include <config.h>
 #ifdef CONFIG_RAM
@@ -22,19 +23,25 @@
 
 #include "dram_sun20i_d1.h"
 
-#ifndef SUNXI_SID_BASE
-#define SUNXI_SID_BASE	0x3006200
-#endif
+/*
+ * Typed views of the register block bases: GCC 15 and later reject the plain
+ * integers this file used to pass to readl() and writel(). The CCU and SID
+ * bases come from the arch header, which has them for the ARM build of this
+ * driver as well; the DRAM controller and PHY blocks are private to it.
+ */
+#define SUNXI_CCM_BASE_PTR		((void __iomem *)SUNXI_CCM_BASE)
+#define SUNXI_SID_BASE_PTR		((void __iomem *)SUNXI_SID_BASE)
+
+#define SUNXI_DRAM_COM_BASE_PTR		((u8 __iomem *)0x3102000)
+#define SUNXI_DRAM_COM_BASE2_PTR	((u8 __iomem *)0x3202000)
+#define SUNXI_DRAM_PHY_BASE_PTR		((u8 __iomem *)0x3103000)
 
-#ifndef SUNXI_CCM_BASE
-#define SUNXI_CCM_BASE	0x2001000
-#endif
 
 static void sid_read_ldoB_cal(const dram_para_t *para)
 {
 	uint32_t reg;
 
-	reg = (readl(SUNXI_SID_BASE + 0x1c) & 0xff00) >> 8;
+	reg = (readl(SUNXI_SID_BASE_PTR + 0x1c) & 0xff00) >> 8;
 
 	if (reg == 0)
 		return;
@@ -51,12 +58,12 @@ static void sid_read_ldoB_cal(const dram_para_t *para)
 		break;
 	}
 
-	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
+	clrsetbits_le32((void __iomem *)0x3000150, 0xff00, reg << 8);
 }
 
 static uint32_t sid_read_soc_chipid(void)
 {
-	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
+	return readl(SUNXI_SID_BASE_PTR + 0x00) & 0xffff;
 }
 
 static void dram_voltage_set(const dram_para_t *para)
@@ -75,7 +82,7 @@ static void dram_voltage_set(const dram_para_t *para)
 		break;
 	}
 
-	clrsetbits_le32(0x3000150, 0x20ff00, vol << 8);
+	clrsetbits_le32((void __iomem *)0x3000150, 0x20ff00, vol << 8);
 
 	udelay(1);
 
@@ -84,70 +91,79 @@ static void dram_voltage_set(const dram_para_t *para)
 
 static void dram_enable_all_master(void)
 {
-	writel(~0, 0x3102020);
-	writel(0xff, 0x3102024);
-	writel(0xffff, 0x3102028);
+	writel(~0, SUNXI_DRAM_COM_BASE_PTR + 0x20);
+	writel(0xff, SUNXI_DRAM_COM_BASE_PTR + 0x24);
+	writel(0xffff, SUNXI_DRAM_COM_BASE_PTR + 0x28);
 	udelay(10);
 }
 
 static void dram_disable_all_master(void)
 {
-	writel(1, 0x3102020);
-	writel(0, 0x3102024);
-	writel(0, 0x3102028);
+	writel(1, SUNXI_DRAM_COM_BASE_PTR + 0x20);
+	writel(0, SUNXI_DRAM_COM_BASE_PTR + 0x24);
+	writel(0, SUNXI_DRAM_COM_BASE_PTR + 0x28);
 	udelay(10);
 }
 
 static void eye_delay_compensation(const dram_para_t *para)
 {
 	uint32_t delay;
-	unsigned long ptr;
+	u8 __iomem *ptr;
 
 	// DATn0IOCR, n =  0...7
 	delay = (para->dram_tpr11 & 0xf) << 9;
 	delay |= (para->dram_tpr12 & 0xf) << 1;
-	for (ptr = 0x3103310; ptr < 0x3103334; ptr += 4)
+	for (ptr = SUNXI_DRAM_PHY_BASE_PTR + 0x310;
+	     ptr < SUNXI_DRAM_PHY_BASE_PTR + 0x334; ptr += 4)
 		setbits_le32(ptr, delay);
 
 	// DATn1IOCR, n =  0...7
 	delay = (para->dram_tpr11 & 0xf0) << 5;
 	delay |= (para->dram_tpr12 & 0xf0) >> 3;
-	for (ptr = 0x3103390; ptr != 0x31033b4; ptr += 4)
+	for (ptr = SUNXI_DRAM_PHY_BASE_PTR + 0x390;
+	     ptr != SUNXI_DRAM_PHY_BASE_PTR + 0x3b4; ptr += 4)
 		setbits_le32(ptr, delay);
 
 	// PGCR0: assert AC loopback FIFO reset
-	clrbits_le32(0x3103100, 0x04000000);
+	clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x100, 0x04000000);
 
 	// ??
 
 	delay = (para->dram_tpr11 & 0xf0000) >> 7;
 	delay |= (para->dram_tpr12 & 0xf0000) >> 15;
-	setbits_le32(0x3103334, delay);
-	setbits_le32(0x3103338, delay);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x334, delay);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x338, delay);
 
 	delay = (para->dram_tpr11 & 0xf00000) >> 11;
 	delay |= (para->dram_tpr12 & 0xf00000) >> 19;
-	setbits_le32(0x31033b4, delay);
-	setbits_le32(0x31033b8, delay);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x3b4, delay);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x3b8, delay);
 
-	setbits_le32(0x310333c, (para->dram_tpr11 & 0xf0000) << 9);
-	setbits_le32(0x31033bc, (para->dram_tpr11 & 0xf00000) << 5);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x33c,
+		     (para->dram_tpr11 & 0xf0000) << 9);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x3bc,
+		     (para->dram_tpr11 & 0xf00000) << 5);
 
 	// PGCR0: release AC loopback FIFO reset
-	setbits_le32(0x3103100, BIT(26));
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x100, BIT(26));
 
 	udelay(1);
 
 	delay = (para->dram_tpr10 & 0xf0) << 4;
-	for (ptr = 0x3103240; ptr != 0x310327c; ptr += 4)
+	for (ptr = SUNXI_DRAM_PHY_BASE_PTR + 0x240;
+	     ptr != SUNXI_DRAM_PHY_BASE_PTR + 0x27c; ptr += 4)
 		setbits_le32(ptr, delay);
-	for (ptr = 0x3103228; ptr != 0x3103240; ptr += 4)
+	for (ptr = SUNXI_DRAM_PHY_BASE_PTR + 0x228;
+	     ptr != SUNXI_DRAM_PHY_BASE_PTR + 0x240; ptr += 4)
 		setbits_le32(ptr, delay);
 
-	setbits_le32(0x3103218, (para->dram_tpr10 & 0x0f) << 8);
-	setbits_le32(0x310321c, (para->dram_tpr10 & 0x0f) << 8);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x218,
+		     (para->dram_tpr10 & 0x0f) << 8);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x21c,
+		     (para->dram_tpr10 & 0x0f) << 8);
 
-	setbits_le32(0x3103280, (para->dram_tpr10 & 0xf00) >> 4);
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x280,
+		     (para->dram_tpr10 & 0xf00) >> 4);
 }
 
 /*
@@ -447,40 +463,42 @@ static void mctl_set_timing_params(const dram_para_t *para,
 	}
 
 	/* Set mode registers */
-	writel(mr0, 0x3103030);
-	writel(mr1, 0x3103034);
-	writel(mr2, 0x3103038);
-	writel(mr3, 0x310303c);
+	writel(mr0, SUNXI_DRAM_PHY_BASE_PTR + 0x30);
+	writel(mr1, SUNXI_DRAM_PHY_BASE_PTR + 0x34);
+	writel(mr2, SUNXI_DRAM_PHY_BASE_PTR + 0x38);
+	writel(mr3, SUNXI_DRAM_PHY_BASE_PTR + 0x3c);
 	/* TODO: dram_odt_en is either 0x0 or 0x1, so right shift looks weird */
-	writel((para->dram_odt_en >> 4) & 0x3, 0x310302c);
+	writel((para->dram_odt_en >> 4) & 0x3, SUNXI_DRAM_PHY_BASE_PTR + 0x2c);
 
 	/* Set dram timing DRAMTMG0 - DRAMTMG5 */
 	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | (tras << 0),
-		0x3103058);
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x58);
 	writel((txp << 16) | (trtp << 8) | (trc << 0),
-		0x310305c);
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x5c);
 	writel((tcwl << 24) | (tcl << 16) | (trd2wr << 8) | (twr2rd << 0),
-		0x3103060);
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x60);
 	writel((tmrw << 16) | (tmrd << 12) | (tmod << 0),
-		0x3103064);
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x64);
 	writel((trcd << 24) | (tccd << 16) | (trrd << 8) | (trp << 0),
-		0x3103068);
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x68);
 	writel((tcksrx << 24) | (tcksrx << 16) | (tckesr << 8) | (tcke << 0),
-		0x310306c);
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x6c);
 
 	/* Set dual rank timing */
-	clrsetbits_le32(0x3103078, 0xf000ffff,
+	clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x78, 0xf000ffff,
 			(CONFIG_DRAM_CLK < 800) ? 0xf0006610 : 0xf0007610);
 
 	/* Set phy interface time PITMG0, PTR3, PTR4 */
 	writel((0x2 << 24) | (t_rdata_en << 16) | BIT(8) | (wr_latency << 0),
-		0x3103080);
-	writel(((tdinit0 << 0) | (tdinit1 << 20)), 0x3103050);
-	writel(((tdinit2 << 0) | (tdinit3 << 20)), 0x3103054);
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x80);
+	writel(((tdinit0 << 0) | (tdinit1 << 20)),
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x50);
+	writel(((tdinit2 << 0) | (tdinit3 << 20)),
+	       SUNXI_DRAM_PHY_BASE_PTR + 0x54);
 
 	/* Set refresh timing and mode */
-	writel((trefi << 16) | (trfc << 0), 0x3103090);
-	writel((trefi << 15) & 0x0fff0000, 0x3103094);
+	writel((trefi << 16) | (trfc << 0), SUNXI_DRAM_PHY_BASE_PTR + 0x90);
+	writel((trefi << 15) & 0x0fff0000, SUNXI_DRAM_PHY_BASE_PTR + 0x94);
 }
 
 // Purpose of this routine seems to be to initialize the PLL driving
@@ -499,26 +517,26 @@ static int ccu_set_pll_ddr_clk(int index, const dram_para_t *para,
 	// set VCO clock divider
 	n = (clk * 2) / 24;
 
-	val = readl(SUNXI_CCM_BASE + 0x10);
+	val = readl(SUNXI_CCM_BASE_PTR + 0x10);
 	val &= ~0x0007ff03;			// clear dividers
 	val |= (n - 1) << 8;			// set PLL division
 	val |= BIT(31) | BIT(30);		// enable PLL and LDO
-	writel(val | BIT(29), SUNXI_CCM_BASE + 0x10);
+	writel(val | BIT(29), SUNXI_CCM_BASE_PTR + 0x10);
 
 	// wait for PLL to lock
-	while ((readl(SUNXI_CCM_BASE + 0x10) & BIT(28)) == 0)
+	while ((readl(SUNXI_CCM_BASE_PTR + 0x10) & BIT(28)) == 0)
 		;
 
 	udelay(20);
 
 	// enable PLL output
-	setbits_le32(SUNXI_CCM_BASE + 0x0, BIT(27));
+	setbits_le32(SUNXI_CCM_BASE_PTR + 0x0, BIT(27));
 
 	// turn clock gate on
-	val = readl(SUNXI_CCM_BASE + 0x800);
+	val = readl(SUNXI_CCM_BASE_PTR + 0x800);
 	val &= ~0x03000303;		// select DDR clk source, n=1, m=1
 	val |= BIT(31);			// turn clock on
-	writel(val, SUNXI_CCM_BASE + 0x800);
+	writel(val, SUNXI_CCM_BASE_PTR + 0x800);
 
 	return n * 24;
 }
@@ -527,11 +545,11 @@ static int ccu_set_pll_ddr_clk(int index, const dram_para_t *para,
 static void mctl_sys_init(const dram_para_t *para, const dram_config_t *config)
 {
 	// assert MBUS reset
-	clrbits_le32(SUNXI_CCM_BASE + 0x540, BIT(30));
+	clrbits_le32(SUNXI_CCM_BASE_PTR + 0x540, BIT(30));
 
 	// turn off sdram clock gate, assert sdram reset
-	clrbits_le32(SUNXI_CCM_BASE + 0x80c, 0x10001);
-	clrsetbits_le32(SUNXI_CCM_BASE + 0x800, BIT(31) | BIT(30), BIT(27));
+	clrbits_le32(SUNXI_CCM_BASE_PTR + 0x80c, 0x10001);
+	clrsetbits_le32(SUNXI_CCM_BASE_PTR + 0x800, BIT(31) | BIT(30), BIT(27));
 	udelay(10);
 
 	// set ddr pll clock
@@ -540,23 +558,23 @@ static void mctl_sys_init(const dram_para_t *para, const dram_config_t *config)
 	dram_disable_all_master();
 
 	// release sdram reset
-	setbits_le32(SUNXI_CCM_BASE + 0x80c, BIT(16));
+	setbits_le32(SUNXI_CCM_BASE_PTR + 0x80c, BIT(16));
 
 	// release MBUS reset
-	setbits_le32(SUNXI_CCM_BASE + 0x540, BIT(30));
-	setbits_le32(SUNXI_CCM_BASE + 0x800, BIT(30));
+	setbits_le32(SUNXI_CCM_BASE_PTR + 0x540, BIT(30));
+	setbits_le32(SUNXI_CCM_BASE_PTR + 0x800, BIT(30));
 
 	udelay(5);
 
 	// turn on sdram clock gate
-	setbits_le32(SUNXI_CCM_BASE + 0x80c, BIT(0));
+	setbits_le32(SUNXI_CCM_BASE_PTR + 0x80c, BIT(0));
 
 	// turn dram clock gate on, trigger sdr clock update
-	setbits_le32(SUNXI_CCM_BASE + 0x800, BIT(31) | BIT(27));
+	setbits_le32(SUNXI_CCM_BASE_PTR + 0x800, BIT(31) | BIT(27));
 	udelay(5);
 
 	// mCTL clock enable
-	writel(0x8000, 0x310300c);
+	writel(0x8000, SUNXI_DRAM_PHY_BASE_PTR + 0xc);
 	udelay(10);
 }
 
@@ -567,14 +585,14 @@ static void mctl_sys_init(const dram_para_t *para, const dram_config_t *config)
 static void mctl_com_init(const dram_para_t *para, const dram_config_t *config)
 {
 	uint32_t val, width;
-	unsigned long ptr;
+	u8 __iomem *ptr;
 	int i;
 
 	// purpose ??
-	clrsetbits_le32(0x3102008, 0x3f00, 0x2000);
+	clrsetbits_le32(SUNXI_DRAM_COM_BASE_PTR + 0x8, 0x3f00, 0x2000);
 
 	// set SDRAM type and word width
-	val  = readl(0x3102000) & ~0x00fff000;
+	val  = readl(SUNXI_DRAM_COM_BASE_PTR) & ~0x00fff000;
 	val |= (para->dram_type & 0x7) << 16;		// DRAM type
 	val |= (~config->dram_para2 & 0x1) << 12;		// DQ width
 	val |= BIT(22);					// ??
@@ -585,7 +603,7 @@ static void mctl_com_init(const dram_para_t *para, const dram_config_t *config)
 		if (config->dram_tpr13 & BIT(5))
 			val |= BIT(19);
 	}
-	writel(val, 0x3102000);
+	writel(val, SUNXI_DRAM_COM_BASE_PTR);
 
 	// init rank / bank / row for single/dual or two different ranks
 	if ((config->dram_para2 & BIT(8)) &&
@@ -594,7 +612,7 @@ static void mctl_com_init(const dram_para_t *para, const dram_config_t *config)
 	else
 		width = 16;
 
-	ptr = 0x3102000;
+	ptr = SUNXI_DRAM_COM_BASE_PTR;
 	for (i = 0; i < width; i += 16) {
 		val = readl(ptr) & 0xfffff000;
 
@@ -615,17 +633,19 @@ static void mctl_com_init(const dram_para_t *para, const dram_config_t *config)
 	}
 
 	// set ODTMAP based on number of ranks in use
-	val = (readl(0x3102000) & 0x1) ? 0x303 : 0x201;
-	writel(val, 0x3103120);
+	val = (readl(SUNXI_DRAM_COM_BASE_PTR) & 0x1) ? 0x303 : 0x201;
+	writel(val, SUNXI_DRAM_PHY_BASE_PTR + 0x120);
 
 	// set mctl reg 3c4 to zero when using half DQ
 	if (config->dram_para2 & BIT(0))
-		writel(0, 0x31033c4);
+		writel(0, SUNXI_DRAM_PHY_BASE_PTR + 0x3c4);
 
 	// purpose ??
 	if (para->dram_tpr4) {
-                setbits_le32(0x3102000, (para->dram_tpr4 & 0x3) << 25);
-                setbits_le32(0x3102004, (para->dram_tpr4 & 0x7fc) << 10);
+		setbits_le32(SUNXI_DRAM_COM_BASE_PTR,
+			     (para->dram_tpr4 & 0x3) << 25);
+		setbits_le32(SUNXI_DRAM_COM_BASE_PTR + 0x4,
+			     (para->dram_tpr4 & 0x7fc) << 10);
 	}
 }
 
@@ -666,7 +686,7 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
 	    para->dram_type != SUNXI_DRAM_TYPE_DDR3)
 		return;
 
-	fuse = (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
+	fuse = (readl(SUNXI_SID_BASE_PTR + 0x28) & 0xf00) >> 8;
 	debug("DDR efuse: 0x%x\n", fuse);
 	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
 
@@ -697,23 +717,23 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
 
 	val = (cfg[4] << 25) | (cfg[3] << 20) | (cfg[2] << 15) |
 	      (cfg[1] << 10) | (cfg[0] << 5);
-	writel(val, 0x3102500);
+	writel(val, SUNXI_DRAM_COM_BASE_PTR + 0x500);
 
 	val = (cfg[10] << 25) | (cfg[9] << 20) | (cfg[8] << 15) |
 	      (cfg[ 7] << 10) | (cfg[6] <<  5) | cfg[5];
-	writel(val, 0x3102504);
+	writel(val, SUNXI_DRAM_COM_BASE_PTR + 0x504);
 
 	val = (cfg[15] << 20) | (cfg[14] << 15) | (cfg[13] << 10) |
 	      (cfg[12] <<  5) | cfg[11];
-	writel(val, 0x3102508);
+	writel(val, SUNXI_DRAM_COM_BASE_PTR + 0x508);
 
 	val = (cfg[21] << 25) | (cfg[20] << 20) | (cfg[19] << 15) |
 	      (cfg[18] << 10) | (cfg[17] <<  5) | cfg[16];
-	writel(val, 0x310250c);
+	writel(val, SUNXI_DRAM_COM_BASE_PTR + 0x50c);
 
 	val = (cfg[4] << 25) | (cfg[3] << 20) | (cfg[2] << 15) |
 	      (cfg[1] << 10) | (cfg[0] <<  5) | 1;
-	writel(val, 0x3102500);
+	writel(val, SUNXI_DRAM_COM_BASE_PTR + 0x500);
 }
 
 // Init the controller channel. The key part is placing commands in the main
@@ -728,10 +748,11 @@ static unsigned int mctl_channel_init(unsigned int ch_index,
 	dqs_gating_mode = (config->dram_tpr13 & 0xc) >> 2;
 
 	// set DDR clock to half of CPU clock
-	clrsetbits_le32(0x310200c, 0xfff, (para->dram_clk / 2) - 1);
+	clrsetbits_le32(SUNXI_DRAM_COM_BASE_PTR + 0xc,
+			0xfff, (para->dram_clk / 2) - 1);
 
 	// MRCTRL0 nibble 3 undocumented
-	clrsetbits_le32(0x3103108, 0xf00, 0x300);
+	clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, 0xf00, 0x300);
 
 	if (para->dram_odt_en)
 		val = 0;
@@ -740,144 +761,149 @@ static unsigned int mctl_channel_init(unsigned int ch_index,
 
 	// DX0GCR0
 	if (para->dram_clk > 672)
-		clrsetbits_le32(0x3103344, 0xf63e, val);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x344, 0xf63e, val);
 	else
-		clrsetbits_le32(0x3103344, 0xf03e, val);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x344, 0xf03e, val);
 
 	// DX1GCR0
 	if (para->dram_clk > 672) {
-                setbits_le32(0x3103344, 0x400);
-		clrsetbits_le32(0x31033c4, 0xf63e, val);
+		setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x344, 0x400);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x3c4, 0xf63e, val);
 	} else {
-		clrsetbits_le32(0x31033c4, 0xf03e, val);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x3c4, 0xf03e, val);
 	}
 
 	// 0x3103208 undocumented
-	setbits_le32(0x3103208, BIT(1));
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x208, BIT(1));
 
 	eye_delay_compensation(para);
 
 	// set PLL SSCG ?
-	val = readl(0x3103108);
+	val = readl(SUNXI_DRAM_PHY_BASE_PTR + 0x108);
 	if (dqs_gating_mode == 1) {
-		clrsetbits_le32(0x3103108, 0xc0, 0);
-		clrbits_le32(0x31030bc, 0x107);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, 0xc0, 0);
+		clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0xbc, 0x107);
 	} else if (dqs_gating_mode == 2) {
-		clrsetbits_le32(0x3103108, 0xc0, 0x80);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, 0xc0, 0x80);
 
-		clrsetbits_le32(0x31030bc, 0x107,
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0xbc, 0x107,
 				(((config->dram_tpr13 >> 16) & 0x1f) - 2) | 0x100);
-		clrsetbits_le32(0x310311c, BIT(31), BIT(27));
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x11c,
+				BIT(31), BIT(27));
 	} else {
-		clrbits_le32(0x3103108, 0x40);
+		clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, 0x40);
 		udelay(10);
-		setbits_le32(0x3103108, 0xc0);
+		setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, 0xc0);
 	}
 
 	if (para->dram_type == SUNXI_DRAM_TYPE_LPDDR2 ||
 	    para->dram_type == SUNXI_DRAM_TYPE_LPDDR3) {
 		if (dqs_gating_mode == 1)
-			clrsetbits_le32(0x310311c, 0x080000c0, 0x80000000);
+			clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x11c,
+					0x080000c0, 0x80000000);
 		else
-			clrsetbits_le32(0x310311c, 0x77000000, 0x22000000);
+			clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x11c,
+					0x77000000, 0x22000000);
 	}
 
-	clrsetbits_le32(0x31030c0, 0x0fffffff,
+	clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0xc0, 0x0fffffff,
 			(config->dram_para2 & BIT(12)) ? 0x03000001 : 0x01000007);
 
-	if (readl(0x70005d4) & BIT(16)) {
-		clrbits_le32(0x7010250, 0x2);
+	if (readl((void __iomem *)0x70005d4) & BIT(16)) {
+		clrbits_le32((void __iomem *)0x7010250, 0x2);
 		udelay(10);
 	}
 
 	// Set ZQ config
-	clrsetbits_le32(0x3103140, 0x3ffffff,
+	clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x140, 0x3ffffff,
 			(para->dram_zq & 0x00ffffff) | BIT(25));
 
 	// Initialise DRAM controller
 	if (dqs_gating_mode == 1) {
-		//writel(0x52, 0x3103000); // prep PHY reset + PLL init + z-cal
-		writel(0x53, 0x3103000); // Go
+		//writel(0x52, SUNXI_DRAM_PHY_BASE_PTR); // prep PHY reset + PLL init + z-cal
+		writel(0x53, SUNXI_DRAM_PHY_BASE_PTR); // Go
 
-		while ((readl(0x3103010) & 0x1) == 0) {
+		while ((readl(SUNXI_DRAM_PHY_BASE_PTR + 0x10) & 0x1) == 0) {
 		} // wait for IDONE
 		udelay(10);
 
 		// 0x520 = prep DQS gating + DRAM init + d-cal
 		if (para->dram_type == SUNXI_DRAM_TYPE_DDR3)
-			writel(0x5a0, 0x3103000);		// + DRAM reset
+			writel(0x5a0, SUNXI_DRAM_PHY_BASE_PTR); // + DRAM reset
 		else
-			writel(0x520, 0x3103000);
+			writel(0x520, SUNXI_DRAM_PHY_BASE_PTR);
 	} else {
-		if ((readl(0x70005d4) & (1 << 16)) == 0) {
+		if ((readl((void __iomem *)0x70005d4) & (1 << 16)) == 0) {
 			// prep DRAM init + PHY reset + d-cal + PLL init + z-cal
 			if (para->dram_type == SUNXI_DRAM_TYPE_DDR3)
-				writel(0x1f2, 0x3103000);	// + DRAM reset
+				writel(0x1f2, SUNXI_DRAM_PHY_BASE_PTR); // + DRAM reset
 			else
-				writel(0x172, 0x3103000);
+				writel(0x172, SUNXI_DRAM_PHY_BASE_PTR);
 		} else {
 			// prep PHY reset + d-cal + z-cal
-			writel(0x62, 0x3103000);
+			writel(0x62, SUNXI_DRAM_PHY_BASE_PTR);
 		}
 	}
 
-	setbits_le32(0x3103000, 0x1);		 // GO
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR, 0x1);		 // GO
 
 	udelay(10);
-	while ((readl(0x3103010) & 0x1) == 0) {
+	while ((readl(SUNXI_DRAM_PHY_BASE_PTR + 0x10) & 0x1) == 0) {
 	} // wait for IDONE
 
-	if (readl(0x70005d4) & BIT(16)) {
-		clrsetbits_le32(0x310310c, 0x06000000, 0x04000000);
+	if (readl((void __iomem *)0x70005d4) & BIT(16)) {
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x10c,
+				0x06000000, 0x04000000);
 		udelay(10);
 
-		setbits_le32(0x3103004, 0x1);
+		setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x4, 0x1);
 
-		while ((readl(0x3103018) & 0x7) != 0x3) {
+		while ((readl(SUNXI_DRAM_PHY_BASE_PTR + 0x18) & 0x7) != 0x3) {
 		}
 
-		clrbits_le32(0x7010250, 0x1);
+		clrbits_le32((void __iomem *)0x7010250, 0x1);
 		udelay(10);
 
-		clrbits_le32(0x3103004, 0x1);
+		clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x4, 0x1);
 
-		while ((readl(0x3103018) & 0x7) != 0x1) {
+		while ((readl(SUNXI_DRAM_PHY_BASE_PTR + 0x18) & 0x7) != 0x1) {
 		}
 
 		udelay(15);
 
 		if (dqs_gating_mode == 1) {
-			clrbits_le32(0x3103108, 0xc0);
-			clrsetbits_le32(0x310310c, 0x06000000, 0x02000000);
+			clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, 0xc0);
+			clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x10c,
+					0x06000000, 0x02000000);
 			udelay(1);
-			writel(0x401, 0x3103000);
+			writel(0x401, SUNXI_DRAM_PHY_BASE_PTR);
 
-			while ((readl(0x3103010) & 0x1) == 0) {
+			while ((readl(SUNXI_DRAM_PHY_BASE_PTR + 0x10) & 0x1) == 0) {
 			}
 		}
 	}
 
 	// Check for training error
-	if (readl(0x3103010) & BIT(20)) {
+	if (readl(SUNXI_DRAM_PHY_BASE_PTR + 0x10) & BIT(20)) {
 		printf("ZQ calibration error, check external 240 ohm resistor\n");
 		return 0;
 	}
 
 	// STATR = Zynq STAT? Wait for status 'normal'?
-	while ((readl(0x3103018) & 0x1) == 0) {
+	while ((readl(SUNXI_DRAM_PHY_BASE_PTR + 0x18) & 0x1) == 0) {
 	}
 
-	setbits_le32(0x310308c, BIT(31));
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x8c, BIT(31));
 	udelay(10);
-	clrbits_le32(0x310308c, BIT(31));
+	clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x8c, BIT(31));
 	udelay(10);
-	setbits_le32(0x3102014, BIT(31));
+	setbits_le32(SUNXI_DRAM_COM_BASE_PTR + 0x14, BIT(31));
 	udelay(10);
 
-	clrbits_le32(0x310310c, 0x06000000);
+	clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x10c, 0x06000000);
 
 	if (dqs_gating_mode == 1)
-		clrsetbits_le32(0x310311c, 0xc0, 0x40);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x11c, 0xc0, 0x40);
 
 	return 1;
 }
@@ -904,12 +930,12 @@ static unsigned int DRAMC_get_dram_size(void)
 	uint32_t val;
 	unsigned int size;
 
-	val = readl(0x3102000);		/* MC_WORK_MODE0 */
+	val = readl(SUNXI_DRAM_COM_BASE_PTR);		/* MC_WORK_MODE0 */
 	size = calculate_rank_size(val);
 	if ((val & 0x3) == 0)		/* single rank? */
 		return size;
 
-	val = readl(0x3102004);		/* MC_WORK_MODE1 */
+	val = readl(SUNXI_DRAM_COM_BASE_PTR + 0x4); /* MC_WORK_MODE1 */
 	if ((val & 0x3) == 0)		/* two identical ranks? */
 		return size * 2;
 
@@ -928,14 +954,14 @@ static int dqs_gate_detect(dram_config_t *config)
 {
 	uint32_t dx0, dx1;
 
-	if ((readl(0x3103010) & BIT(22)) == 0) {
+	if ((readl(SUNXI_DRAM_PHY_BASE_PTR + 0x10) & BIT(22)) == 0) {
 		config->dram_para2 = (config->dram_para2 & ~0xf) | BIT(12);
 		debug("dual rank and full DQ\n");
 
 		return 1;
 	}
 
-	dx0 = (readl(0x3103348) & 0x3000000) >> 24;
+	dx0 = (readl(SUNXI_DRAM_PHY_BASE_PTR + 0x348) & 0x3000000) >> 24;
 	if (dx0 == 0) {
 		config->dram_para2 = (config->dram_para2 & ~0xf) | 0x1001;
 		debug("dual rank and half DQ\n");
@@ -944,7 +970,7 @@ static int dqs_gate_detect(dram_config_t *config)
 	}
 
 	if (dx0 == 2) {
-		dx1 = (readl(0x31033c8) & 0x3000000) >> 24;
+		dx1 = (readl(SUNXI_DRAM_PHY_BASE_PTR + 0x3c8) & 0x3000000) >> 24;
 		if (dx1 == 2) {
 			config->dram_para2 = config->dram_para2 & ~0xf00f;
 			debug("single rank and full DQ\n");
@@ -974,20 +1000,20 @@ static int dramc_simple_wr_test(unsigned int mem_mb, int len)
 
 	addr = (unsigned int *)CFG_SYS_SDRAM_BASE;
 	for (i = 0; i != len; i++, addr++) {
-		writel(patt1 + i, (unsigned long)addr);
-		writel(patt2 + i, (unsigned long)(addr + offs));
+		writel(patt1 + i, (void __iomem *)addr);
+		writel(patt2 + i, (void __iomem *)(addr + offs));
 	}
 
 	addr = (unsigned int *)CFG_SYS_SDRAM_BASE;
 	for (i = 0; i != len; i++) {
-		v1 = readl((unsigned long)(addr + i));
+		v1 = readl((void __iomem *)(addr + i));
 		v2 = patt1 + i;
 		if (v1 != v2) {
 			printf("DRAM: simple test FAIL\n");
 			printf("%x != %x at address %p\n", v1, v2, addr + i);
 			return 1;
 		}
-		v1 = readl((unsigned long)(addr + offs + i));
+		v1 = readl((void __iomem *)(addr + offs + i));
 		v2 = patt2 + i;
 		if (v1 != v2) {
 			printf("DRAM: simple test FAIL\n");
@@ -1002,16 +1028,19 @@ static int dramc_simple_wr_test(unsigned int mem_mb, int len)
 
 // Set the Vref mode for the controller
 //
-static void mctl_vrefzq_init(const dram_para_t *para, const dram_config_t *config)
+static void mctl_vrefzq_init(const dram_para_t *para,
+			     const dram_config_t *config)
 {
 	if (config->dram_tpr13 & BIT(17))
 		return;
 
-	clrsetbits_le32(0x3103110, 0x7f7f7f7f, para->dram_tpr5);
+	clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x110,
+			0x7f7f7f7f, para->dram_tpr5);
 
 	// IOCVR1
 	if ((config->dram_tpr13 & BIT(16)) == 0)
-		clrsetbits_le32(0x3103114, 0x7f, para->dram_tpr6 & 0x7f);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x114,
+				0x7f, para->dram_tpr6 & 0x7f);
 }
 
 // Perform an init of the controller. This is actually done 3 times. The first
@@ -1058,7 +1087,8 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 {
 	unsigned int rval, i, j, rank, maxrank, offs;
 	unsigned int shft;
-	unsigned long ptr, mc_work_mode, chk;
+	unsigned long ptr, chk;
+	u8 __iomem *mc_work_mode;
 
 	if (mctl_core_init(para, config) == 0) {
 		printf("DRAM initialisation error : 0\n");
@@ -1066,12 +1096,12 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 	}
 
 	maxrank	= (config->dram_para2 & 0xf000) ? 2 : 1;
-	mc_work_mode = 0x3102000;
+	mc_work_mode = SUNXI_DRAM_COM_BASE_PTR;
 	offs = 0;
 
 	/* write test pattern */
 	for (i = 0, ptr = CFG_SYS_SDRAM_BASE; i < 64; i++, ptr += 4)
-		writel(get_payload(i & 0x1, ptr), ptr);
+		writel(get_payload(i & 0x1, ptr), (void __iomem *)ptr);
 
 	for (rank = 0; rank < maxrank;) {
 		/* set row mode */
@@ -1083,7 +1113,7 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 			chk = CFG_SYS_SDRAM_BASE + (1U << (i + 11));
 			ptr = CFG_SYS_SDRAM_BASE;
 			for (j = 0; j < 64; j++) {
-				if (readl(chk) != get_payload(j & 0x1, ptr))
+				if (readl((void __iomem *)chk) != get_payload(j & 0x1, ptr))
 					break;
 				ptr += 4;
 				chk += 4;
@@ -1103,7 +1133,7 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 		config->dram_para1 = rval;
 
 		if (rank == 1)		/* Set bank mode for rank0 */
-			clrsetbits_le32(0x3102000, 0xffc, 0x6a4);
+			clrsetbits_le32(SUNXI_DRAM_COM_BASE_PTR, 0xffc, 0x6a4);
 
 		/* Set bank mode for current rank */
 		clrsetbits_le32(mc_work_mode, 0xffc, 0x6a4);
@@ -1113,7 +1143,7 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 		chk = CFG_SYS_SDRAM_BASE + (1U << 22);
 		ptr = CFG_SYS_SDRAM_BASE;
 		for (i = 0, j = 0; i < 64; i++) {
-			if (readl(chk) != get_payload(i & 1, ptr)) {
+			if (readl((void __iomem *)chk) != get_payload(i & 1, ptr)) {
 				j = 1;
 				break;
 			}
@@ -1131,7 +1161,7 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 		config->dram_para1 = rval;
 
 		if (rank == 1)		/* Set page mode for rank0 */
-			clrsetbits_le32(0x3102000, 0xffc, 0xaa0);
+			clrsetbits_le32(SUNXI_DRAM_COM_BASE_PTR, 0xffc, 0xaa0);
 
 		/* Set page mode for current rank */
 		clrsetbits_le32(mc_work_mode, 0xffc, 0xaa0);
@@ -1142,7 +1172,7 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 			chk = CFG_SYS_SDRAM_BASE + (1U << i);
 			ptr = CFG_SYS_SDRAM_BASE;
 			for (j = 0; j < 64; j++) {
-				if (readl(chk) != get_payload(j & 1, ptr))
+				if (readl((void __iomem *)chk) != get_payload(j & 1, ptr))
 					break;
 				ptr += 4;
 				chk += 4;
@@ -1168,10 +1198,12 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 		if (rank != maxrank) {
 			if (rank == 1) {
 				/* MC_WORK_MODE */
-				clrsetbits_le32(0x3202000, 0xffc, 0x6f0);
+				clrsetbits_le32(SUNXI_DRAM_COM_BASE2_PTR,
+						0xffc, 0x6f0);
 
 				/* MC_WORK_MODE2 */
-				clrsetbits_le32(0x3202004, 0xffc, 0x6f0);
+				clrsetbits_le32(SUNXI_DRAM_COM_BASE2_PTR + 0x4,
+						0xffc, 0x6f0);
 			}
 			/* store rank1 config in upper half of para1 */
 			offs += 16;
@@ -1212,7 +1244,7 @@ static int auto_scan_dram_rank_width(const dram_para_t *para,
 
 	mctl_core_init(para, config);
 
-	if (readl(0x3103010) & BIT(20))
+	if (readl(SUNXI_DRAM_PHY_BASE_PTR + 0x10) & BIT(20))
 		return 0;
 
 	if (dqs_gate_detect(config) == 0)
@@ -1271,18 +1303,18 @@ static int init_DRAM(int type, const dram_para_t *para)
 	/* Test ZQ status */
 	if (config.dram_tpr13 & BIT(16)) {
 		debug("DRAM only have internal ZQ\n");
-		setbits_le32(0x3000160, BIT(8));
-		writel(0, 0x3000168);
+		setbits_le32((void __iomem *)0x3000160, BIT(8));
+		writel(0, (void __iomem *)0x3000168);
 		udelay(10);
 	} else {
-		clrbits_le32(0x3000160, 0x3);
-		writel(config.dram_tpr13 & BIT(16), 0x7010254);
+		clrbits_le32((void __iomem *)0x3000160, 0x3);
+		writel(config.dram_tpr13 & BIT(16), (void __iomem *)0x7010254);
 		udelay(10);
-		clrsetbits_le32(0x3000160, 0x108, BIT(1));
+		clrsetbits_le32((void __iomem *)0x3000160, 0x108, BIT(1));
 		udelay(10);
-		setbits_le32(0x3000160, BIT(0));
+		setbits_le32((void __iomem *)0x3000160, BIT(0));
 		udelay(20);
-		debug("ZQ value = 0x%x\n", readl(0x300016c));
+		debug("ZQ value = 0x%x\n", readl((void __iomem *)0x300016c));
 	}
 
 	dram_voltage_set(para);
@@ -1325,41 +1357,44 @@ static int init_DRAM(int type, const dram_para_t *para)
 		rc = para->dram_tpr8;
 		if (rc == 0)
 			rc = 0x10000200;
-		writel(rc, 0x31030a0);
-		writel(0x40a, 0x310309c);
-		setbits_le32(0x3103004, BIT(0));
+		writel(rc, SUNXI_DRAM_PHY_BASE_PTR + 0xa0);
+		writel(0x40a, SUNXI_DRAM_PHY_BASE_PTR + 0x9c);
+		setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x4, BIT(0));
 		debug("Enable Auto SR\n");
 	} else {
-		clrbits_le32(0x31030a0, 0xffff);
-		clrbits_le32(0x3103004, 0x1);
+		clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0xa0, 0xffff);
+		clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x4, 0x1);
 	}
 
 	/* Purpose ?? */
 	if (config.dram_tpr13 & BIT(9)) {
-		clrsetbits_le32(0x3103100, 0xf000, 0x5000);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x100,
+				0xf000, 0x5000);
 	} else {
 		if (para->dram_type != SUNXI_DRAM_TYPE_LPDDR2)
-			clrbits_le32(0x3103100, 0xf000);
+			clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x100, 0xf000);
 	}
 
-	setbits_le32(0x3103140, BIT(31));
+	setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x140, BIT(31));
 
 	/* CHECK: is that really writing to a different register? */
 	if (config.dram_tpr13 & BIT(8))
-		writel(readl(0x3103140) | 0x300, 0x31030b8);
+		writel(readl(SUNXI_DRAM_PHY_BASE_PTR + 0x140) | 0x300,
+		       SUNXI_DRAM_PHY_BASE_PTR + 0xb8);
 
 	if (config.dram_tpr13 & BIT(16))
-		clrbits_le32(0x3103108, BIT(13));
+		clrbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, BIT(13));
 	else
-		setbits_le32(0x3103108, BIT(13));
+		setbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x108, BIT(13));
 
 	/* Purpose ?? */
 	if (para->dram_type == SUNXI_DRAM_TYPE_LPDDR3)
-		clrsetbits_le32(0x310307c, 0xf0000, 0x1000);
+		clrsetbits_le32(SUNXI_DRAM_PHY_BASE_PTR + 0x7c,
+				0xf0000, 0x1000);
 
 	dram_enable_all_master();
 	if (config.dram_tpr13 & BIT(28)) {
-		if ((readl(0x70005d4) & BIT(16)) ||
+		if ((readl((void __iomem *)0x70005d4) & BIT(16)) ||
 		    dramc_simple_wr_test(mem_size_mb, 4096))
 			return 0;
 	}
-- 
2.43.0

