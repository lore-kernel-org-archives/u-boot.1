Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C2606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xiffkZMc;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=P1KZFkLe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A88A0810A3;
	Tue, 17 Nov 2026 11:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDMGujP19o0w; Tue, 17 Nov 2026 11:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E33A58109F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915457;
	b=P2R3tJ7J7+LpsaaK9J8NjeT0tkIt6f+Er4ipmRMu3hBu62+8cUXE7Kt4SwgOhLt8Vp+R
	 oVN/DDDBCUf+wYBGFK5G4XNPC/RTRYtBNNB1GxUFkMUDRwmzXE+j712vcrSrPkEqXJusM
	 0M4XShJomqYPf4cueSKd/RvlyyhvRYh6deafxSfXffJXRNdxOj7yR/fWmBHdMcb3F21Aw
	 dnKGHmpQcLxOIdtLSlMDwGh04NQaTvi9FQAZf9rlV4mb7gnQpt8+9cj+Otl1KzhUvkkSW
	 0umfgVrUtn44jG4VAYek8L2xlW61eaxTXBfrDgm51hmR/U1tpjLx/rlO3XJpSSg745w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H8jlfsCZcvPh/WZv/vRLt2oniO54Dn4g9O9zr6lhtGk=;
	b=WWsEEoSoxXzx93BZONRHRbB/YRIHBnmRfq9ajRhwJ7RL/Euog43REsRmgFQzMpfjiTaq
	 y5pLftLCBWEAeIeIhX3PBMZqp5nkPIIMC8qyo+/vpKPI5FMerdViuL/osTwDILhx4NneL
	 TSNDfrg4UFtuse96kBe5fXjZBDk3y/zF8A8rOgBtrCUvKq0SllOEIkswo7gDGl/KoCQMg
	 EC2w7LtXLN/462CXlyPjsTG9X4Ino1gwIwxuDg6rhiwaIIfhphY8QhHp/L5IPvUAhOODb
	 9Wi82XQR6x7rl0+tx1La7vc7OoeyS6IXGGmUBaIyxZ5Zq88j9JXCSzZ3tRxTWtrW0IQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915457;
	bh=H8jlfsCZcvPh/WZv/vRLt2oniO54Dn4g9O9zr6lhtGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xiffkZMcinGrxexXnvtsTt40wY4AvteOjvdWDS/8z8N9NqOUTYly/6PbadC8Db/pX
	 xyX/dzqT+5AiikJFgx4h3mz1CDx6rG4ddSzKEPhMiqO+qR+ijRz8UUDp9q9SjrTaMG
	 5IQ4r/BuXYOp+LURIOrCg8iLRXOUzZ/j1WRKEoAViIfBPBebl+ULcXK1FlGkJzWIHy
	 WJILwjtSp+V+AaEURbOPPGiwt7/bnPYk+MKQEFp3pispkmzkZmp+XM7WNwb5mrXxQA
	 MdrBjXmo7MpnyElreOgOsm16uc/Hh9m8+AKmuV2E8AnQI8cofN3YLq7byIIlVLK164
	 R8g8q1TLvjsPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E33A58109F;
	Tue, 17 Nov 2026 11:37:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74A9F49B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7295560861
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYN5nFnoyVWp for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E71A605FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.125.25.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.13;
 helo=smtp-190d.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=P1KZFkLe
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E71A605FF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:31 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4n6ZQlzp6P;
 Tue, 17 Nov 2026 12:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915449;
 bh=H8jlfsCZcvPh/WZv/vRLt2oniO54Dn4g9O9zr6lhtGk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P1KZFkLeYQ1YvuB8fv3qyRDR53YFQ0a3ugK5JGxK52dxhdLrDmNPc/XBEH5Qi5sVO
 SGShdFj/MOLaCcPhEOFq1E74MtIzwvRDAIWS2Ke/883HbWuJ9umBdTjvDHdHMnN8hb
 tujhh+I4FnC2ItyscbZuUFJ6iOlOJOeRBW2eGUlrcaPHrocLht5sN4xMDn4yh43kyv
 q/1WCzcHEguQaQcST5zHLw6LhS2ZYthtNUB/TPxr8IYCgy+twUoymzBpxPTKQSvlOn
 7FCYAf1C0RPyG1wOBKw+3w1erCY86AdfzCyiOZiYXPtMK8jt/LWa2U8oM+XNsNndQ0
 YfYjU/CBfvDDA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4m6XD7z9TV; Tue, 17 Nov 2026 12:37:28 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:14 +0100
Subject: [PATCH next 5/8] clk: rockchip: rk3576: use proper base address
 for SCRU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-5-25521d4e37c3@cherry.de>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
In-Reply-To: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The SECURE_CRU (SCRU) starts at offset 0x27210000, not 0x27214000. The
maths was sound however, so we only need to add the 0x4000 to the other
constants or macros in use with RK3576_SCRU_BASE to keep everything
working.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 5 ++++-
 drivers/clk/rockchip/clk_rk3576.c               | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index c9a4b1a47b6f..6adb532a37b4 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -102,7 +102,7 @@ struct pll_rate_table {
 #define RK3576_LITCORE_CRU_BASE		0x40000
 #define RK3576_CCI_CRU_BASE		0x48000
 #define RK3576_CRU_BASE			0x27200000
-#define RK3576_SCRU_BASE		0x27214000
+#define RK3576_SCRU_BASE		0x27210000
 
 #define RK3576_BIGCORE_GRF_BASE		0x2600C000
 #define RK3576_LITCORE_GRF_BASE		0x2600E000
@@ -147,6 +147,9 @@ struct pll_rate_table {
 #define RK3576_LITCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x800)
 #define RK3576_LITCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0xa00)
 
+#define RK3576_SCRU_SPLL_CON(x)		(0x4220 + (x) * 0x4)
+#define RK3576_SCRU_MODE_CON0		0x4280
+
 enum {
 	/* CRU_CLK_SEL8_CON */
 	PCLK_TOP_SEL_SHIFT		= 7,
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 117bef2eba1e..8fd44138a453 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2449,9 +2449,9 @@ static int rk3576_clk_probe(struct udevice *dev)
 	writel(0x1c001c00, 0x26010010);
 	/* set spll to normal mode */
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-	       RK3576_SCRU_BASE + RK3576_PLL_CON(137));
+	       RK3576_SCRU_BASE + RK3576_SCRU_SPLL_CON(1));
 	writel(BITS_WITH_WMASK(1, 0x3U, 0),
-	       RK3576_SCRU_BASE + RK3576_MODE_CON0);
+	       RK3576_SCRU_BASE + RK3576_SCRU_MODE_CON0);
 	/* fix ppll\aupll\cpll */
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
 	       RK3576_CRU_BASE + RK3576_PHP_PLL_CON(129));

-- 
2.56.1

