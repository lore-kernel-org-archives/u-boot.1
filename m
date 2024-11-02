Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE3E677EC
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 06:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73F588EC6;
	Sat,  2 Nov 2024 07:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FEIerhpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2833A88EFB; Sat,  2 Nov 2024 07:32:34 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A2F88A4C
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 07:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 679903F136; 
 Sat,  2 Nov 2024 06:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730529151;
 bh=T+x/dcBmvWg+sVHAg9kY3HQyFv5uyuPo3/ZEbA+NrHA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FEIerhpUOAPRE3UbpTGvbn/EZY3veLFgCatDUxfdHzRMsUIICNzJmgex/yV1SZMnM
 6p9DQocLLG9c0Bqrxi+qqBG7RnK63Mz/YbYHDsg43LKpj+U35DGecKgr+xYxAK9iSX
 MAljmx+iUcaPZgt6oKqBEysq39DULffgT4glUr1qwxd8G2pWJM1xZ9oHhCihrbJZYa
 sEnehRFqs0k/6tw4swJUs8zT12qFHREQjCY1J/xtbajI560fH7NhstnnuiGDSLDC7h
 IvVAaMWl74G8xH2RaFXbf9kGBprA4BSsF8tYO8OudvKaurWZAixYDEm6Pky4suFBt8
 CI4vNladerI2A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lmb: do not panic in lmb_print_region_flags
Date: Sat,  2 Nov 2024 07:32:26 +0100
Message-ID: <20241102063226.39388-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Commit c3cf0dc64f1c ("lmb: add a check to prevent memory overrun")
addressed a possible buffer overrun using assert_noisy().

Resetting via panic() in lmb_print_region() while allowing invalid
lmb flags elsewhere is not reasonable.

Instead of panicking print a message indicating the problem.

fls() returns an int. Using a u64 for bitpos does not match.
Use int instead.

fls() takes an int as argument. Using 1ull << bitpos generates a u64.
Use 1u << bitpos instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/lmb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 96a055f951e..00c8888936a 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -72,16 +72,22 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
 
 static void lmb_print_region_flags(enum lmb_flags flags)
 {
-	u64 bitpos;
 	const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
+	unsigned int pflags = flags &
+			      (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
+
+	if (flags != pflags) {
+		printf("invalid %#x\n", flags);
+		return;
+	}

 	do {
-		bitpos = flags ? fls(flags) - 1 : 0;
-		assert_noisy(bitpos < ARRAY_SIZE(flag_str));
+		int bitpos = pflags ? fls(pflags) - 1 : 0;
+
 		printf("%s", flag_str[bitpos]);
-		flags &= ~(1ull << bitpos);
-		puts(flags ? ", " : "\n");
-	} while (flags);
+		pflags &= ~(1u << bitpos);
+		puts(pflags ? ", " : "\n");
+	} while (pflags);
 }
 
 static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
-- 
2.45.2

