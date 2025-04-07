Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A38C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B4183020;
	Mon,  7 Apr 2025 19:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2E083019; Mon,  7 Apr 2025 19:05:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3875582CF5
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C8312FC;
 Mon,  7 Apr 2025 10:05:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.17.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22EDF3F59E;
 Mon,  7 Apr 2025 10:05:50 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] arm64: versal: fix dfu alt buffer clearing
Date: Mon,  7 Apr 2025 19:05:27 +0200
Message-ID: <20250407170529.893307-4-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250407170529.893307-1-vincent.stehle@arm.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
macro to declare a `buf' variable pointer into an array allocated on the
stack. It then calls the memset() function to clear the useable portion
of the array using the idiomatic expression `sizeof(buf)'.

While this would indeed work fine for an array, in the present case we
end up clearing only the size of a pointer.
Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.

Fixes: 064c8978b44f ("arm64: versal: Enable capsule update (SD)")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>
---
 board/xilinx/versal/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index b4483d00ad1..3edccc979d8 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -396,7 +396,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	if (env_get("dfu_alt_info"))
 		return;
 
-	memset(buf, 0, sizeof(buf));
+	memset(buf, 0, DFU_ALT_BUF_LEN);
 
 	multiboot = env_get_hex("multiboot", multiboot);
 
-- 
2.47.2

