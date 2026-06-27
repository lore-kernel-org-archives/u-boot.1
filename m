Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D9DC43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 20:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95187841F2;
	Sat, 27 Jun 2026 22:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="a7JPGC1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5567D842FC; Sat, 27 Jun 2026 22:49:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 034C083FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 22:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9abc=EY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1782593342;
 bh=2QbbzIdpjSRq8qKkj9wam8GqqgerT9CUCcsCaQ8+D9k=;
 b=a7JPGC1CJulAILY8ZiEjogQo57/VDn6XYwSBGFxmFvemuaQxiV5bfcInm6TcvEbSzrN9MHCv+
 QC4c8DDVapVwivPCGq18+Dcn9ZgO0XaPr3AyFw9PQ0i25M79OxVjotfDnejVR0FssQe8OfnrmMV
 UZkDB9zDRMmLu9J9o5R3YOQ9DCs/X/4Id1hk4QMxxrzastny2rHrMMdPeX83paXA0F70ZJq1ypp
 o2asAdInrBlO/Qr8eLC5NC2JOpv9LkvUoFK1SyXXeGqxHE2AX8FC2ZmOPRjxbphJJClW99GF1r7
 DktHe6JPOvdkhsF3zh191FtWapDk8rlGNMQZl8kPyTMw==
X-Forward-Email-ID: 6a40373b2a0eaa57395fb8c1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.9.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH] boot: image-fdt: Restore suppression of irrelevant ERROR
 message
Date: Sat, 27 Jun 2026 20:48:51 +0000
Message-ID: <20260627204851.1151419-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
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

The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
removed the suppression of ERROR messages when -EINVAL is returned due
to the memory region not being part of the LMB memory map.

This causes an irrelevant ERROR message during boot, e.g.:

  Model: Radxa ROCK 3B
  [...]
  ERROR: reserving fdt memory region failed (addr=10f000 size=100 flags=2): -22

or

  Model: Rockchip RK3288 Asus Tinker Board S
  [...]
  ERROR: reserving fdt memory region failed (addr=fe000000 size=1000000 flags=4): -22

FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boot
correctly does not make these regions available in the LMB memory map:

  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
  memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: none

or

  memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none

Ignore -EINVAL errors to restore suppression of this irrelevant ERROR
message when memory region is not part of the LMB memory map.

Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 boot/image-fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9e0e0f93edd3..603294215b89 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
 		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      free ? "freed" : "reserved", (unsigned long long)addr,
 		      (unsigned long long)size, flags);
-	} else {
+	} else if (free || ret != -EINVAL) {
 		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
 		       free ? "freeing" : "reserving", (unsigned long long)addr,
 		       (unsigned long long)size, flags, ret);
-- 
2.54.0

