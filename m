Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20B6CFD2F6
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 23:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2319A83CD3;
	Sun, 23 Nov 2025 23:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mo1+Sjda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E16383CEE; Sun, 23 Nov 2025 23:59:00 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F5083B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 783ED4497E; 
 Sun, 23 Nov 2025 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938697;
 bh=KpB1rMbRnVdFgc9Zfc5dJ5i6RqrMYqm80/e3D5Vi4fo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mo1+Sjda+LQooPvC168eXEiTv/v7oMITgZG7/NiNxqQinY4bllKYstt7OXp2c8BYS
 mrUtL4IkvtV69LC4+YzZTAUNTtiI0vYVgJ0BwyvRXLQbat94GpiK92/HtvF6rrscfv
 ylAmF9Gkj7xbHmYDLUoFt5XIWNSr8L5SfPscWOO4NLiA8Hyhnw/KnQENiq1Qp1GF11
 ryj+u3I3K6bhj4wEkxfqJitJ46/Hkd5jZQB1e2uIVoce59I1dqbxC5TeIFYM9w35Wu
 R+KlkVTYIEvyi6f+Qd0ZfOhSl6M9wIJ8NUX+zzhsurkY7lSiDmG9JF/A2Rmo0r45sh
 QXAnrYbM/G9d5S/8FstHfzCba09Tfi8d8nZIHfIt3i3Byf6fQa0/5Yq/5iQHsWYPya
 vLszZy4J9nfWn0jrMr4uo2vZETHP8SlifzlGM593B6c7dxJyd/YmArD8JEy7rcxon1
 /8IXgg0KSXfcS+mXLGO5OVPAPauFrnhrbxvitGUlmPbHgl4ORh0xWudyXGn4P2iRap
 8vqVKvVZlMkdYa+B1EKy+AqX3ddRBWrjNMmrZgZzzTpRornHpmYOnT0yDa43lUjEwC
 622vlmeOCabGLnaTHrRT8y8tsg0aE+c2puS4H+5muXWmapRuKDXn/KLKf5ufoxRPjw
 IHenjKgfKBHjOxoeu35nE7lE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 18/19] cmd: fix 'fdt get value'
Date: Sun, 23 Nov 2025 23:57:10 +0100
Message-ID: <20251123225711.227016-19-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

The 32bit cells of a device-tree property are big-endian. When printing
them via 0x08x we must first convert to the host endianness.

Remove the restriction to 20 bytes length. This would not allow to read an
SHA256 value.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/fdt.c      | 26 +++++++++++++++-----------
 test/cmd/fdt.c |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/cmd/fdt.c b/cmd/fdt.c
index a67c30b21d5..d6d5b9fdfd2 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -9,14 +9,15 @@
 
 #include <command.h>
 #include <env.h>
+#include <fdt_support.h>
 #include <image.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
-#include <fdt_support.h>
-#include <mapmem.h>
-#include <asm/io.h>
 
 #define MAX_LEVEL	32		/* how deeply nested we will go */
 #define SCRATCHPAD	1024		/* bytes of scratchpad memory */
@@ -91,18 +92,21 @@ static int fdt_value_env_set(const void *nodep, int len,
 
 		sprintf(buf, "0x%08X", fdt32_to_cpu(*(nodec + index)));
 		env_set(var, buf);
-	} else if (len % 4 == 0 && len <= 20) {
+	} else {
 		/* Needed to print things like sha1 hashes. */
-		char buf[41];
+		char *buf;
+		const unsigned int *nodec = (const unsigned int *)nodep;
 		int i;
 
-		for (i = 0; i < len; i += sizeof(unsigned int))
+		buf = malloc(2 * len + 7);
+		if (!buf)
+			return CMD_RET_FAILURE;
+		for (i = 0; i < len; i += 4)
 			sprintf(buf + (i * 2), "%08x",
-				*(unsigned int *)(nodep + i));
+				fdt32_to_cpu(*nodec++));
+		buf[2 * len] = 0;
 		env_set(var, buf);
-	} else {
-		printf("error: unprintable value\n");
-		return 1;
+		free(buf);
 	}
 	return 0;
 }
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 4c3c6308ab4..8ce888770ac 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -494,7 +494,7 @@ static int fdt_test_get_value_common(struct unit_test_state *uts,
 	 * longer is an error. This is a special case for handling hashes.
 	 */
 	ut_assertok(fdt_test_get_value_string(uts, node, "regs", NULL,
-					      "3412000000100000", 0));
+					      "0000123400001000", 0));
 
 	/* Test getting 0th element of $node node regs property */
 	ut_assertok(fdt_test_get_value_string(uts, node, "regs", "0", NULL,
-- 
2.51.0

