Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD613CD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 08:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E0088C94;
	Thu,  5 Sep 2024 10:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2410888C91; Thu,  5 Sep 2024 10:28:56 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 190BD88CC2
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 10:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27174FEC;
 Thu,  5 Sep 2024 01:29:18 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 342363F66E;
 Thu,  5 Sep 2024 01:28:48 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 06/16] add a function to check if an address is in RAM memory
Date: Thu,  5 Sep 2024 13:58:01 +0530
Message-Id: <20240905082811.1585467-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
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

Add a function to check if a given address falls within the RAM
address used by U-Boot. This will be used to notify other modules if
the address gets allocated, so as to not get re-allocated by some
other module.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 common/board_r.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index 4faaa20242..877ea3afd0 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -72,6 +72,11 @@ DECLARE_GLOBAL_DATA_PTR;
 
 ulong monitor_flash_len;
 
+__weak bool __maybe_unused is_addr_in_ram(uintptr_t addr)
+{
+	return addr >= gd->ram_base && addr <= gd->ram_top;
+}
+
 __weak int board_flash_wp_on(void)
 {
 	/*
-- 
2.34.1

