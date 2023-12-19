Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A33C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 15:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E3A876C0;
	Tue, 19 Dec 2023 16:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mBO8Z5SR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8943687695; Tue, 19 Dec 2023 16:04:26 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B964687508
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 16:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DEB7242F66; 
 Tue, 19 Dec 2023 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702998262;
 bh=MzopbwjGiEFun8q4EPmgVNudrXbt+SGO+F8n/e3J++w=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=mBO8Z5SRv889aRKu3MXZ2svNVmRnVLLihe43KrZPMP1zydctA1fBnOM/FX8BXimR/
 Z/XDH4rBwiFCJEq6+cJz7403JxjZQ/9LhBbjkH5QJvqPzfNKpa4l2JcWhc9/yLyTa4
 JKyc9wun7ACHKHkDEHd/vURkC0tsAZSoL0QzT8FeNtzetm4kuGYN7TMg461MrYXtbk
 QENFJOShg2Kqzk1gn1lAbw6otJhC8C+3tpHeJpt/O4xMrM/kDb789KOVjJbmTr9vP7
 BUVo2YXhbTslrZILlsCNhglINkHGshQwQhlTHGV0+vk02c5/OfuBc5RhwjHnmljvUr
 Z+g5e72HKgn3Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 3/9] arm: add ACPI fields to global data
Date: Tue, 19 Dec 2023 16:04:02 +0100
Message-Id: <20231219150408.10949-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
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

Add fields for the location of ACPI tables to the global data.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	let tables in global data depend on CONFIG_(SPL_)ACPI
v2:
	new patch
---
 arch/arm/include/asm/global_data.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 75bd9d56f8..c3d87caa0b 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -19,7 +19,12 @@ struct arch_global_data {
 #if defined(CONFIG_FSL_ESDHC) || defined(CONFIG_FSL_ESDHC_IMX)
 	u32 sdhc_clk;
 #endif
-
+#if CONFIG_IS_ENABLED(ACPI)
+	ulong table_start;		/* Start address of ACPI tables */
+	ulong table_end;		/* End address of ACPI tables */
+	ulong table_start_high;		/* Start address of high ACPI tables */
+	ulong table_end_high;		/* End address of high ACPI tables */
+#endif
 #if defined(CONFIG_FSL_ESDHC)
 	u32 sdhc_per_clk;
 #endif
-- 
2.40.1

