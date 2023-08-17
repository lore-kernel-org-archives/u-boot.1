Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7ACC3DA61
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB9386BB9;
	Thu, 17 Aug 2023 19:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FyjdG3X1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C7786BA1; Thu, 17 Aug 2023 19:04:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CAC86B9A
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF9361F16;
 Thu, 17 Aug 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AECA0C433C9;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692291853;
 bh=cKIj3uvlO/l+tZDUra4lHfkBYvbFh7g655JGfg8+a4A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=FyjdG3X1Tq9GdesgWbY/m0tfihw5+ILQo4ugf3VsNyo4duztGQYyHXa52K+yrgS5W
 LCgHgv1If792B+Prmd8p61NYrZZcq0C3MEXXtU9KWtHbZxbzYllUDnM7Yzlo8t3EzJ
 tPBuxg2nGBLjxF90K2bDN6o3Sur4oJdj1GFDkgdVGP8GlVXngqXmC6IT9bcsATaV8p
 UmP2Q+sDIgTOsAKyWGNh6lMX2xttmR22XCFtHbWStq3oMNJmH3duSPmRPS+iwIjAEw
 ZavKvDjZI7FVQktBw+M0g1yLXBeauB2C7jczNNrMfacTDuuMdHkxa4LcHqF8gHrcUw
 0rLsp7Pwbu4FA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6A6C3DA58;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 18 Aug 2023 01:04:00 +0800
Subject: [PATCH RESEND 1/5] clk: export clk_register_mux_table()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-clk-fix-v1-1-49ec18f820bf@outlook.com>
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
In-Reply-To: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692291852; l=922;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rrxWAZujevzzupl/nb4QWkR3QDVpqMIWdYkkWfQ6VWg=;
 b=p+Dym4mN6QSYD5cD/WWkx0ItGmcKQP+RF00a0c3G0z85VcPDKFNNGExqXyUKTqsghT5lyVEnk
 3MVA6fdSqeYC2xQVXWMzVzalgygVemwDIgfl/78ukSb/vsE6TGxpJVZ
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

It's already implemented in clk-mux.c, export it in the header file.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 include/linux/clk-provider.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b8acacd49e..801404480b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -247,6 +247,12 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags);
 
+struct clk *clk_register_mux_table(struct device *dev, const char *name,
+				   const char * const *parent_names, u8 num_parents,
+				   unsigned long flags,
+				   void __iomem *reg, u8 shift, u32 mask,
+				   u8 clk_mux_flags, u32 *table);
+
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 				    ulong rate);
 

-- 
2.34.1

