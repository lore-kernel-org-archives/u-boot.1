Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E3606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d/Yydjkf;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=mloM7iHe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83ED381826;
	Sat,  7 Nov 2026 12:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SzAo5Z3tO_3g; Sat,  7 Nov 2026 12:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EF8281836
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055870;
	b=USCVNB+X5fStEh0nKflbAiywElRDaikg/yHUSYaigXVakWHgcrYjoBa1mppk7aGN7KoM
	 eaWaJ1F+GdFHdMASds0b7URMY1afSAq9hZ0WhVie4TyHMtippM5oRNFL7rzHdAh7pzJsQ
	 SXU5uWTqE44H7xqtkrKISu6OwGw6zwP/XAjuVY8ehC3XHtV5bxtjO/aCVxSOXq0s7tuzi
	 lnAYThY+xSsYw1PJIbhqXmbWeF7B8sbVr7sjK0Q5PCWBzI+BCxF5zTOXOjorgzm2qXcrn
	 Fl1wwicJE/nlPYakHzXa/ofyyIzDCi3tnfDSNHBdVPldnibHWwPjBoGfnyjfbEWqjcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HnzP+jkt9OuWpF84SzdipUvTuKRX0DYCM+b2SrjJxj0=;
	b=Zx0lysimgL7YxNh7IRi4F4Zl9IZwMLgKx446nPIiVX5bDDfRxEeIAcRYsWuLaUg2dFZ4
	 CSEyUrEO9CRSwoMp7F96nm7EwvlvAXjBvSROzQjpOENP5oGYTLsZE9n80NLeJanRPlfEW
	 a1wAxN9o8qbA2N4jewCJwT9LjoGnIM1t0VqDfsTSrsoWH1+EAnXhNeTVg+Hr3lQRs3J8X
	 5WB8f+l3hmRlrBQBjIqkHyFMoM+iRvHC30BvyeitXHIzbzntaTxO32N06gvoGsDwRaouR
	 dCZwAGM3YnRM41gWT4gNLrHH/s7y90DjBS+M5OjqzLmlWUWqrQziyWPybNIVtpdSJNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055870;
	bh=HnzP+jkt9OuWpF84SzdipUvTuKRX0DYCM+b2SrjJxj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/Yydjkf7q7w8L7z0/cBai4W6nuVS4l0ZNs0m5xWwzh3aQrGi9JKC127erw4TBIBh
	 MO36a47+vmxF8PUJtMpps2xJRUz5XQdgWXw4wthC8nBokfQkTbm5eWoyTPgh26Rlf4
	 A9SNCIgWpnUMVEhYhAYrJIyunAhLSFYOiO/fQr3VOvivPBLm3Atz4qqTFLaCZxcQSX
	 gn1k7a/TwlWEiOqMsQm14xB6tMbZrbJ5daP/AGRmk6G5EPibs/IgOHO76aEHGzSYfd
	 k5JPS6yVz+JxEpAaiK5/cjDEAyGbR4IQ0r2y0iqKOlohRNMwQ6efdLkYTFo21kkXto
	 booFmQ4nVNfsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EF8281836;
	Sat,  7 Nov 2026 12:51:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C971C2E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAD6F400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fDK7IMH1-nTC for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7896B4009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=mloM7iHe
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7896B4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:32 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmr711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:07 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmr711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051907;
 bh=HnzP+jkt9OuWpF84SzdipUvTuKRX0DYCM+b2SrjJxj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mloM7iHenuGwhgE3Gak+1TjQhGhYaQmYfgwqcfpDV2s1wuaTa3p5hrWaC6gxQAA4U
 D01T4ciEot4BGgCmirRTKSudVtrv8O5cWQev9pWbXkA0EWYluvWyMtePgoIZis3doi
 K9gP5RScSYFchE2bReC5TPQgRca8HN8EzAhargoY=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 02/10] dt-bindings: clock: add STM32L4 RCC clock and reset
 identifiers
Date: Sat,  7 Nov 2026 12:44:47 +0100
Message-ID: <20261107114455.304896-3-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:50:14 +0000
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

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Add identifiers for the STM32L4/L4+ RCC. Peripheral clock gates and
reset lines are both encoded as (register offset * 8 + bit), the
encoding the generic stm32_rcc_reset driver already decodes, plus four
bus clocks (SYSCLK, HCLK, PCLK1, PCLK2).

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 include/dt-bindings/clock/stm32l4-clock.h | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 include/dt-bindings/clock/stm32l4-clock.h

diff --git a/include/dt-bindings/clock/stm32l4-clock.h b/include/dt-bindings/clock/stm32l4-clock.h
new file mode 100644
index 00000000..e2fc2565
--- /dev/null
+++ b/include/dt-bindings/clock/stm32l4-clock.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ *
+ * Clock and reset identifiers for the STM32L4/L4+ RCC (U-Boot local
+ * binding). Reference: RM0432 section 6.4 "RCC registers".
+ *
+ * Peripheral clock gates and reset lines are both encoded as
+ * (register byte offset * 8 + bit), so that the generic stm32_rcc_reset
+ * driver and the clk-stm32l4 driver can decode them the same way.
+ *
+ *   clocks = <&rcc STM32L4_APB1ENR2(0)>;	LPUART1EN
+ *   resets = <&rcc STM32L4_APB1RSTR2(0)>;	LPUART1RST
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_STM32L4_H
+#define _DT_BINDINGS_CLOCK_STM32L4_H
+
+#define STM32L4_RCC_ID(off, bit)	(((off) * 8) + (bit))
+
+/* Reset registers */
+#define STM32L4_AHB1RSTR(bit)		STM32L4_RCC_ID(0x28, bit)
+#define STM32L4_AHB2RSTR(bit)		STM32L4_RCC_ID(0x2c, bit)
+#define STM32L4_AHB3RSTR(bit)		STM32L4_RCC_ID(0x30, bit)
+#define STM32L4_APB1RSTR1(bit)		STM32L4_RCC_ID(0x38, bit)
+#define STM32L4_APB1RSTR2(bit)		STM32L4_RCC_ID(0x3c, bit)
+#define STM32L4_APB2RSTR(bit)		STM32L4_RCC_ID(0x40, bit)
+
+/* Clock enable registers */
+#define STM32L4_AHB1ENR(bit)		STM32L4_RCC_ID(0x48, bit)
+#define STM32L4_AHB2ENR(bit)		STM32L4_RCC_ID(0x4c, bit)
+#define STM32L4_AHB3ENR(bit)		STM32L4_RCC_ID(0x50, bit)
+#define STM32L4_APB1ENR1(bit)		STM32L4_RCC_ID(0x58, bit)
+#define STM32L4_APB1ENR2(bit)		STM32L4_RCC_ID(0x5c, bit)
+#define STM32L4_APB2ENR(bit)		STM32L4_RCC_ID(0x60, bit)
+
+/* Bus clocks (no gate); placed above the register space */
+#define STM32L4_CLK_SYSCLK		0x1000
+#define STM32L4_CLK_HCLK		0x1001
+#define STM32L4_CLK_PCLK1		0x1002
+#define STM32L4_CLK_PCLK2		0x1003
+
+#endif /* _DT_BINDINGS_CLOCK_STM32L4_H */
-- 
2.56.0

