Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3BBC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85AD87BDA;
	Fri, 15 Dec 2023 14:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GcpTfFaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F04387BD6; Fri, 15 Dec 2023 14:32:57 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60EBB87BA7
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4648C401CB; 
 Fri, 15 Dec 2023 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702647174;
 bh=vMVoYmp5WOHeBxoRJpVCCugWSdkffVUKYX1VKS2DdAc=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=GcpTfFaXic+UlxkDoYVkSfS2zregOf5LLqS4ETW95+YP8GEwRoAUzKL3gji11GAks
 Lmv1JNnTvo+429oAdmX1ZIVL1jb7HMb6MixGUAs948SY3/ObAi5EolAc8SjUmRVEwv
 RyZGzkSN5WtvEattIIDyjq+WWdSYsGuYr9rn382nl/o3jkvGIYkPa+Y9SzzhNuBPSO
 p3xVUQNQNYQD8NIOT5vbEt55HvY2+Biwes/luruOBizlTkfha44uR43Ayh3tFTwQeS
 xwohaj8dSojqJcbtlkEY16nCzeoEJGlcyD3ktwL4kzS3dA7m6cBLvN9wanI10kgbKs
 PBSxHCLG8pgtA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/9] risc-v: add ACPI fields to global data
Date: Fri, 15 Dec 2023 14:32:40 +0100
Message-Id: <20231215133245.7923-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	no change
---
 arch/riscv/include/asm/global_data.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 937fa4d154..a8f6a217f1 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -32,6 +32,10 @@ struct arch_global_data {
 	ulong available_harts;
 #endif
 #endif
+	ulong table_start;		/* Start address of ACPI tables */
+	ulong table_end;		/* End address of ACPI tables */
+	ulong table_start_high;		/* Start address of high ACPI tables */
+	ulong table_end_high;		/* End address of high ACPI tables */
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-- 
2.40.1

