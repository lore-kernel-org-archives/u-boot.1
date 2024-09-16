Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93594C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D528388EE8;
	Mon, 16 Sep 2024 17:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E69988EE0; Mon, 16 Sep 2024 17:20:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C6AB388D53
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF75211FB;
 Mon, 16 Sep 2024 08:21:11 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C2B63F66E;
 Mon, 16 Sep 2024 08:20:39 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 2/2] wget: rework the logic to validate the load address
Date: Mon, 16 Sep 2024 20:50:25 +0530
Message-Id: <20240916152025.75789-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916152025.75789-1-sughosh.ganu@linaro.org>
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
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

Use the lmb_read_check() function to verify if it is safe to use a
region of memory to load data from the wget command. The current logic
checks the amount of free memory available, starting from the 'load
address'. This call fails if the same region of memory has been used
earlier. This used to work earlier as the LMB memory map had a local
scope and was not persistent. Fix this issue by using the
lmb_read_check() call instead which only returns an error in case the
memory region has been marked for not allowing re-use.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Note: To be applied on next, on top of
https://patchwork.ozlabs.org/project/uboot/patch/20240913073251.2286529-2-prasad.kummari@amd.com/

 net/wget.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 4a168641c6..a88c31f236 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -64,26 +64,6 @@ static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
 static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
 static int retry_len;			/* TCP retry length */
 
-static ulong wget_load_size;
-
-/**
- * wget_init_max_size() - initialize maximum load size
- *
- * Return:	0 if success, -1 if fails
- */
-static int wget_init_load_size(void)
-{
-	phys_size_t max_size;
-
-	max_size = lmb_get_free_size(image_load_addr);
-	if (!max_size)
-		return -1;
-
-	wget_load_size = max_size;
-
-	return 0;
-}
-
 /**
  * store_block() - store block in memory
  * @src: source of data
@@ -97,13 +77,8 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	uchar *ptr;
 
 	if (CONFIG_IS_ENABLED(LMB)) {
-		ulong end_addr = image_load_addr + wget_load_size;
-
-		if (!end_addr)
-			end_addr = ULONG_MAX;
-
 		if (store_addr < image_load_addr ||
-		    store_addr + len > end_addr) {
+		    lmb_read_check(store_addr, len)) {
 			printf("\nwget error: ");
 			printf("trying to overwrite reserved memory...\n");
 			return -1;
@@ -493,15 +468,6 @@ void wget_start(void)
 	debug_cond(DEBUG_WGET,
 		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
 
-	if (CONFIG_IS_ENABLED(LMB)) {
-		if (wget_init_load_size()) {
-			printf("\nwget error: ");
-			printf("trying to overwrite reserved memory...\n");
-			net_set_state(NETLOOP_FAIL);
-			return;
-		}
-	}
-
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	tcp_set_tcp_handler(wget_handler);
 
-- 
2.34.1

