Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD88E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 22:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A6C38007A;
	Sat, 14 Dec 2024 23:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="madv6ppV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="geMNCy1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6808280073; Sat, 14 Dec 2024 23:44:06 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB4A80073
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y9h8N0G2yz9slj;
 Sat, 14 Dec 2024 23:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd7MuP+QnIlZtZhUapzkKDJ3K7DsY/44QfyfYcy1VVQ=;
 b=madv6ppVU80jiP7Z+7SQgTQLb4thDvVsAbz7Cj1Ez06GeCXGtBzpSDO/kPhtxXUhobq44s
 3yGQbpcc0SDmGUgEDW4W8oAApUbNmdkwTRwydX881lAf4FgSUic+QHGU2pWxm6hsmnptup
 7PaX6lM3D/b4OVAjMLinpwPGxk3fv+/9v+MBEWM4dyhP1c3MxQq04NlVPU9OAnjubsJ74M
 PX4JEoFsvN+U9CsMCNZBGGwakAYXSwYN5m5K6dJsAMgbh/uhV8yoJJfJ/vQEB5Jm5tsCxW
 Ui0RSNB7GBKGbBsjgpkKha7bnNsSDo8Tohm9z4prNZcBktNkoesQHYeTmE8xvg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd7MuP+QnIlZtZhUapzkKDJ3K7DsY/44QfyfYcy1VVQ=;
 b=geMNCy1W0MlQysak5hUzz0zMRc0vYvKwqp42Z+PeIXF119q3cF+k6XV87EBwfZJaNJ/HJL
 /jy/BpYvDTOSJWjTkbrLAres5c5GXLOVVeEslRvOIVHHZCeLrEdf9AjS5VgV0Vjkt20Bru
 /7qqi6yteWx/Az7EA5NrvIH6InD6wTeAWTlxbPCTKCtiJZzPyCauBEI/DQE5DlH74+lHJt
 cX2kZvyRSQEm3e7Bet3VfIluH1/CApY6xxK86dUoUXVs9GWrLJ47w2A/c5XNEd7qYVa4ve
 SZlnZ+7QNLVCJKLGuiVhEUy+hqAh94TQHCrsv2LCTb2E27zNoN2Fx30qLSg5qg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: Add MIDR entries for Cortex-A57 and Cortex-A76
Date: Sat, 14 Dec 2024 23:42:47 +0100
Message-ID: <20241214224344.303452-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
References: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: atwii5xy17kn7q3hba397c7p3w33xp35
X-MBO-RS-ID: 8039dedcd57a37da9f4
X-Rspamd-Queue-Id: 4Y9h8N0G2yz9slj
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

Add MIDR entries for Cortex-A57 and Cortex-A76 cores.
Those are used on R-Car Gen3 and Gen4 SoCs respectively.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/armv8/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv8/cpu.h
index aa1470bb72d..4dbb589aab8 100644
--- a/arch/arm/include/asm/armv8/cpu.h
+++ b/arch/arm/include/asm/armv8/cpu.h
@@ -5,7 +5,9 @@
 
 #define MIDR_PARTNUM_CORTEX_A35		0xD04
 #define MIDR_PARTNUM_CORTEX_A53		0xD03
+#define MIDR_PARTNUM_CORTEX_A57		0xD07
 #define MIDR_PARTNUM_CORTEX_A72		0xD08
+#define MIDR_PARTNUM_CORTEX_A76		0xD0B
 #define MIDR_PARTNUM_SHIFT		0x4
 #define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
 
@@ -29,4 +31,6 @@ static inline unsigned int read_midr(void)
 
 is_cortex_a(35)
 is_cortex_a(53)
+is_cortex_a(57)
 is_cortex_a(72)
+is_cortex_a(76)
-- 
2.45.2

