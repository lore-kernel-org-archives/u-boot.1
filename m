Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA9AC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E8D788EC9;
	Mon, 16 Sep 2024 17:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDA688EA8; Mon, 16 Sep 2024 17:20:42 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 498FA88D53
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20B4411FB;
 Mon, 16 Sep 2024 08:21:09 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DDDE3F66E;
 Mon, 16 Sep 2024 08:20:37 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/2] tftp: rework the logic to validate the load address
Date: Mon, 16 Sep 2024 20:50:24 +0530
Message-Id: <20240916152025.75789-2-sughosh.ganu@linaro.org>
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
region of memory to load data from a tftp command. The current logic
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

 net/tftp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index b5d227d8bc..d6744bc24e 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -82,7 +82,6 @@ static ulong	tftp_block_wrap;
 static ulong	tftp_block_wrap_offset;
 static int	tftp_state;
 static ulong	tftp_load_addr;
-static ulong	tftp_load_size;
 #ifdef CONFIG_TFTP_TSIZE
 /* The file size reported by the server */
 static int	tftp_tsize;
@@ -159,13 +158,8 @@ static inline int store_block(int block, uchar *src, unsigned int len)
 	void *ptr;
 
 	if (CONFIG_IS_ENABLED(LMB)) {
-		ulong end_addr = tftp_load_addr + tftp_load_size;
-
-		if (!end_addr)
-			end_addr = ULONG_MAX;
-
 		if (store_addr < tftp_load_addr ||
-		    store_addr + len > end_addr) {
+		    lmb_read_check(store_addr, len)) {
 			puts("\nTFTP error: ");
 			puts("trying to overwrite reserved memory...\n");
 			return -1;
@@ -712,19 +706,8 @@ static void tftp_timeout_handler(void)
 	}
 }
 
-/* Initialize tftp_load_addr and tftp_load_size from image_load_addr and lmb */
 static int tftp_init_load_addr(void)
 {
-	if (CONFIG_IS_ENABLED(LMB)) {
-		phys_size_t max_size;
-
-		max_size = lmb_get_free_size(image_load_addr);
-		if (!max_size)
-			return -1;
-
-		tftp_load_size = max_size;
-	}
-
 	tftp_load_addr = image_load_addr;
 	return 0;
 }
-- 
2.34.1

