Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAECC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 11:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE5881F0D;
	Sat,  7 Jun 2025 13:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cEclL8o7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2102A807B1; Sat,  7 Jun 2025 13:49:38 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE59382A65
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 13:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 710504B65C; 
 Sat,  7 Jun 2025 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749296971;
 bh=YocOdDhRQzqT6kfS4xeLQ7Py6KBeLJrPhTpmvvUYNMw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cEclL8o71xzwR5gSRJifTIcRcnqP+TmT+a8IywCoCQcAw3dtIYxePd3nftU75pyIc
 rD5teRadoysgbq/ZLDibG6ipmFBuRq12C5n35RQv3ZwqUZdRVNEHIhfKPJeMjCK4tA
 y06n0AS/O0iuY4Uh6rI9yhdWKq/u9P9WCXwZE6QdW4jHcfCrF896XMhwXnY5MyZMyv
 YmAqMSw0Os4ayFQqii7FhgAh+bOU51xcFjLsB/KIa1gC+WaQxf22tos3kezw3K8bae
 JPuym8AiZ8Zp9Xobo5I9TKBP8bfEJAQ6BRMQELWp8XKMsnnmfOwAyYxDhjx0XI3RAR
 QxLRQZmildH8A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] sandbox: align LMB memory
Date: Sat,  7 Jun 2025 13:49:04 +0200
Message-ID: <20250607114906.209959-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
References: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
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

To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
memory.

On the sandbox LMB uses addresses relative to the start of a page aligned
RAM buffer allocated with mmap(). This leads to a mismatch of alignment
between EFI which uses pointers and LMB which uses phys_addr_t.

Ensure that the RAM buffer used for LMB is 4 MiB aligned.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/cpu/state.c         | 6 ++++--
 arch/sandbox/include/asm/state.h | 1 +
 include/configs/sandbox.h        | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index 49236db99c2..1d6e04d0327 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -480,7 +480,9 @@ int state_init(void)
 	state = &main_state;
 
 	state->ram_size = CFG_SYS_SDRAM_SIZE;
-	state->ram_buf = os_malloc(state->ram_size);
+	state->mmap_addr = os_malloc(state->ram_size + CFG_SYS_SDRAM_ALIGN);
+	state->ram_buf = (uint8_t *)ALIGN((uintptr_t)state->mmap_addr,
+					  CFG_SYS_SDRAM_ALIGN);
 	if (!state->ram_buf) {
 		printf("Out of memory\n");
 		os_exit(1);
@@ -533,7 +535,7 @@ int state_uninit(void)
 		trace_set_enabled(0);
 
 	os_free(state->state_fdt);
-	os_free(state->ram_buf);
+	os_free(state->mmap_addr);
 	memset(state, '\0', sizeof(*state));
 
 	return 0;
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index dc21a623106..9dea0980bfc 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -75,6 +75,7 @@ struct sandbox_state {
 	char **argv;			/* Command line arguments */
 	const char *jumped_fname;	/* Jumped from previous U-Boot */
 	const char *prog_fname;		/* U-Boot executable filename */
+	uint8_t *mmap_addr;		/* Memory allocated via mmap */
 	uint8_t *ram_buf;		/* Emulated RAM buffer */
 	unsigned long ram_size;		/* Size of RAM buffer */
 	const char *ram_buf_fname;	/* Filename to use for RAM buffer */
diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
index db2ac7f83bb..ee1ad21fd8d 100644
--- a/include/configs/sandbox.h
+++ b/include/configs/sandbox.h
@@ -14,6 +14,8 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define CFG_SYS_SDRAM_SIZE \
 		(SB_TO_UL(CONFIG_SANDBOX_RAM_SIZE_MB) << 20)
+/** define CFG_SYS_SDRAM_ALIGN - Alignment of emulated RAM */
+#define CFG_SYS_SDRAM_ALIGN		0x400000
 
 #define CFG_SYS_BAUDRATE_TABLE	{4800, 9600, 19200, 38400, 57600,\
 					115200}
-- 
2.48.1

