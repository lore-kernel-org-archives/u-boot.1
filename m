Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEBAC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6ACF87BF6;
	Fri, 19 Jan 2024 14:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iCSVm5WJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46EFA87BF6; Fri, 19 Jan 2024 14:36:22 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B12C87BB8
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 23EB7B81BA3;
 Fri, 19 Jan 2024 13:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D84C433F1;
 Fri, 19 Jan 2024 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705671379;
 bh=b/ezMBrRZOKdzKkgZrLW/5ffFDCspf5wBj9+fMStnQ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=iCSVm5WJ6CpKfb0A3RMNcHpDCzcWCBI+O0ThlalLwKoOY+r+CtH4FvhNgtpJfatQ0
 3rbwuFRm5EBwY9H8teVVQnsQZmHc5yNL7ZGRLwGi00BzKLX4ELY1nUNRnQkvkOWJPh
 Kpe4r1uXxtewAwfbhkXI569Jh2NTzvPY1uOpN8s021TkjCh2p4XRl1vK5Z5GQZUt3Y
 Iz+mM+O1KrGAu3JJH5smfo2XzDIlT6eHHWpg0TJnpH5exJKXI7vMy8XdfA+pWiYOmI
 AP9e1lXshtNkBDEZoYpvcp6QbTNF8cQy/9/8+ArHoAvb51oHgG2+To/1KQjiKX7WdR
 LXpRUj6D7cl6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 71DDFC47DAF;
 Fri, 19 Jan 2024 13:36:19 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 19 Jan 2024 21:36:18 +0800
Subject: [PATCH RFC 1/2] clk: ccf: Export clk_register_mux_table() in
 linux/clk-provider.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-b4-hisi-clk-v1-1-279e38c95ca2@outlook.com>
References: <20240119-b4-hisi-clk-v1-0-279e38c95ca2@outlook.com>
In-Reply-To: <20240119-b4-hisi-clk-v1-0-279e38c95ca2@outlook.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, David Yang <mmyangfl@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705671378; l=885;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=3h8ikq29d5+Bqo7gJ0S7vR42AqQoXFXCNTI5MuvSkgs=;
 b=xsOhPYufSxrFiMYn7gjeOHUb1f+3T6uMSeYd3U+sO0WmChoAL7NK9ygCfRher8b5RCI3SkknO
 9LPjZe85e2MDNxCXb7Qz5uKvOpU4Um1i3ceSCwOKP0jwz0+EN6AeJUK
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

This function is used by HiSilicon Clock Framework.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 include/linux/clk-provider.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b8acacd49e..952439ad39 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -247,6 +247,12 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags);
 
+struct clk *clk_register_mux_table(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags,
+		void __iomem *reg, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table);
+
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 				    ulong rate);
 

-- 
2.43.0

