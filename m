Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7222C5B552
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 10:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F6D6830D9;
	Fri, 30 May 2025 12:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="bupsSr0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08565831F5; Fri, 30 May 2025 12:56:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47DA82B3D
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7762226123;
 Fri, 30 May 2025 12:56:38 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBsa3UHz5EAQ; Fri, 30 May 2025 12:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748602597; bh=s/r4MfSgpnvRhshnuFvCcvz3LgqyfY7NR3gx8CVD5U8=;
 h=From:To:Cc:Subject:Date;
 b=bupsSr0wFN0aa0ZddHJWnPXW8AcKlvG5bre+An/c5jLzXbTJftOh/Mocvc/XdVKFH
 CNzgEaU2rCRm5vXdKYtTiu/d44s2HqQPO9Liuh/CckXPU8I22kNRXpMD2jx/kG2F3m
 Gl7FtQoD8ZWTgTOqZXRtuDACJ9r2yBStLRImhsTyh0pgslurpll88ERE+obZ2OM8lJ
 x3ee22MDDNaDGVeUgLemTiP/zL4d5nlo5dSlKMVpdPmCoqaBLDW2Ds21lc4nxdNt70
 lXC0+pxhRh6qTf5R/GSU1IzTUeUDQetbK+oQpAfFbC5X2vnZkksdQwEFF2SXuudahr
 kWmuczGsnY1Ow==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer
Date: Fri, 30 May 2025 10:56:22 +0000
Message-ID: <20250530105622.58634-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Assign myself to develop U-Boot port of T-Head TH1520 SoC, and help
maintain related code and review patches.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..4d79fa457c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1569,6 +1569,13 @@ F:	drivers/clk/clk_k210.c
 F:	drivers/pinctrl/pinctrl-k210.c
 F:	include/k210/
 
+RISC-V T-HEAD TH1520
+M:	Yao Zi <ziyao@disroot.org>
+S:	Maintained
+F:	arch/riscv/cpu/th1520/
+F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/ram/thead/th1520_ddr.c
+
 RNG
 M:	Sughosh Ganu <sughosh.ganu@linaro.org>
 R:	Heinrich Schuchardt <xypron.glpk@gmx.de>
-- 
2.49.0

