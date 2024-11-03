Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D6CE67807
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 05:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144A38911A;
	Sun,  3 Nov 2024 06:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UcRxEQse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C7989118; Sun,  3 Nov 2024 06:36:18 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841E589102
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 06:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E28E73FE13; 
 Sun,  3 Nov 2024 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730612175;
 bh=TkoEEXGK2LuXwccpDmWRryd3I8xhrougmWMnXKRzkk8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UcRxEQseBrQK/rjmi9oSZBX/RNSM4FCC7i5LLhvh+9kc2bO5KDs23gp1kWorFzfq6
 ZozA6+DL24C5vq4vdSVBD0l7omSFvER9VS2ycJYGKDQqYZpcQmNqMnBNXN/H21NMfR
 wWcqCDlebWAJEJS9lo1XTLjnVsi0IoEO3mbbl84eic8c/JiaNV+cTvnN8f/aLj+PxJ
 dNHlPCqLsXpS23geWRy2Z5Uou1qABG8oQnkVvV5pu0oczr4V+lh+vY6mJDDNETppw1
 Qsyh09RZMZ0oUkcBkodehz2DNjpN0kXDFbjb1+qMgsLFx5xy+8fZ2U+6fnCBcvxKIl
 D3JnNKCS4AF3g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] examples: make glue and demo code compatible with 64-bit
Date: Sun,  3 Nov 2024 06:35:51 +0100
Message-ID: <20241103053551.52715-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
References: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
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

Commit f9886bc60f42 ("Added arm64 assembly for examples/api crt0")
added a 64-bit target for the examples but did not adjust the demo
code to be 64-bit compatible.

Change variable size for pointers.
Use %p to print pointers.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/demo.c | 9 ++++-----
 examples/api/glue.c | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/examples/api/demo.c b/examples/api/demo.c
index 677d13b307a..9a55f76c504 100644
--- a/examples/api/demo.c
+++ b/examples/api/demo.c
@@ -43,12 +43,11 @@ int main(int argc, char *const argv[])
 	if (sig->version > API_SIG_VERSION)
 		return -3;
 
-	printf("API signature found @%x\n", (unsigned int)sig);
+	printf("API signature found @%p\n", sig);
 	test_dump_sig(sig);
 
 	printf("\n*** Consumer API test ***\n");
-	printf("syscall ptr 0x%08x@%08x\n", (unsigned int)syscall_ptr,
-		(unsigned int)&syscall_ptr);
+	printf("syscall ptr 0x%p@%p\n", syscall_ptr, &syscall_ptr);
 
 	/* console activities */
 	ub_putc('B');
@@ -203,7 +202,7 @@ void test_dump_sig(struct api_signature *sig)
 	printf("signature:\n");
 	printf("  version\t= %d\n", sig->version);
 	printf("  checksum\t= 0x%08x\n", sig->checksum);
-	printf("  sc entry\t= 0x%08x\n", (unsigned int)sig->syscall);
+	printf("  sc entry\t= 0x%p\n", sig->syscall);
 }
 
 void test_dump_si(struct sys_info *si)
@@ -296,7 +295,7 @@ void test_dump_di(int handle)
 	struct device_info *di = ub_dev_get(handle);
 
 	printf("device info (%d):\n", handle);
-	printf("  cookie\t= 0x%08x\n", (uint32_t)di->cookie);
+	printf("  cookie\t= 0x%p\n", di->cookie);
 	printf("  type\t\t= 0x%08x\n", di->type);
 
 	if (di->type == DEV_TYP_NET) {
diff --git a/examples/api/glue.c b/examples/api/glue.c
index 0aaa82bccb2..478f7b6cfb4 100644
--- a/examples/api/glue.c
+++ b/examples/api/glue.c
@@ -41,8 +41,8 @@ static int valid_sig(struct api_signature *sig)
 int api_search_sig(struct api_signature **sig)
 {
 	unsigned char *sp;
-	uint32_t search_start = 0;
-	uint32_t search_end = 0;
+	uintptr_t search_start = 0;
+	uintptr_t search_end = 0;
 
 	if (sig == NULL)
 		return 0;
-- 
2.45.2

