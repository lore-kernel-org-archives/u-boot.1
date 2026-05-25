Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96059CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98106848B0;
	Mon, 25 May 2026 16:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MQtUi/OA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93A38460E; Mon, 25 May 2026 15:26:53 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D558E846DE
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 837643F6C9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779715611;
 bh=6pia1c/Eou93payyOx7LlRr8R4DgoVgA2NmohgRi/jk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MQtUi/OA+p/In3bCbx8mzdTn8P0JQCBzee67ZA3N5+EmX639B0VM99Gc2ZxJpBFQq
 HIvJUdTYCSjgYdFGWucRHjzjm6lJAuDq5rmTGmqpeHRFRm4BWurYP3ujSBBA9Uo77V
 WZBUuFbosy5OiIdfpU9QpJko/Ki5cDc5ESLLk2lBWWv47oJbZ7MS3Yb2j9XiDYVjmc
 QwJXSDE2VsFC8mgMZJIKdjPOfBXMh6GoHlni1+d1W8DFbESHNpjf/oc8QVJAGb2rcp
 NQswtvJkz9d8uWJt6hH9kM8TQiDnktfbYYCywYapeVcOxQMLfJh09bYqLk6flD2Z9/
 Ngf8ihiEKDMu3BFYpclAajSUNDiv+yEY3ii0u87Oryhhwqq2SWzyPFCg/LBp338l3b
 0a9DIY4ua7hNgrrO3dMui/3wFtAoFrXWBOmNIWAKtzFqg0j0e3wRN2JUMhUpewaoPU
 twE8j17VU9i4XkIJY0pkblt1l7ONrZgjXBjiMPy+Cj8yqEnlkqxCSfsv+IrfFATmqD
 ZFQZH2tZXYLb//k4YhVGEYq9KCg+TrYkEg1PKv5ACWx6CLMxhT7LNQMrm0fvAA/QOk
 738j4YoBcAOvZZzEiAja7ZdTRVTli8gq3wnSQ0NmKxkfR4E+7zrOdVu1n9ZCKecxWW
 w0wqdBJ7PZVSah6drXf2cKOc=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8354503d9acso11650768b3a.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 06:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715610; x=1780320410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6pia1c/Eou93payyOx7LlRr8R4DgoVgA2NmohgRi/jk=;
 b=kFvgbRA7HL85H/4nk2oqm3Ch/gJe2BVmGuiimGR2a29CsO6byB3t1BzEZM0jyQ//ce
 9tqU83vQMEvG4E+MfBBGMXN7qFCUb5bRyLpeP2o6tWD8VP49pEshry2dyX8k/udiwoBC
 p1KZdjwtmV2iuEf0x/b4q2CNdS+rNTHmL86ebQKSRL7r4nV8mcOKVEBAcroLehp8cDkr
 93llLWa4SAFBLzg0AKgo0Nikjb5xGbZBQGZhWtfRw0PKOh/Zkrlv+HgcJmeF965+TTfZ
 xHO8AcZnT/uECGjEIbMACRVK+rYvLUjJLOV6boRTpjXeDXFlCRKt0iTlgq+ZkW7eixoI
 pbOA==
X-Gm-Message-State: AOJu0YwYWERKSUEYbR5bI3vbXJceQPScL4/S38Z3NK555bkrmD5Mqhj4
 25ffM6+gQB+6bHklfy8R2XJcBbvRcU7QJbKaOEIZmmGX2NDrMy1XoRsi5B/oeFgRQ3H7mz5h61L
 SLmdJEI+4NzfZmpWaI8facLxKclX/LZjs7Fi71RUDvAnMt8Kt9/Is10FW12aaLtSNBvV7ijJBE4
 KN78FLyQ==
X-Gm-Gg: Acq92OGSm9kDwNNvnTUoDnh4hd1vRPpAG2rwNkzDw+jW1auVARtDBl4Aa3nGbqGOQMj
 NSJym0BCabxO1aiRWQVMyK09+SwWha90guM/IFvmpkFemdBpEIA/bAtquIXb4JBBqcNb+Sl284W
 mGsFRJFTacD/3/+KQlA+dhymKyFsL6xNGOlize3g3dXUiVo6xGO2kRSTvExionZxiOJKJvRtmOq
 I+pcX8r8p60Mub9+B1yuq0qOvRu0nbP29lEUAlhtQU5LEmcQclNcSiLG2YrcE6x39DP0H5DfwU2
 88ybzNvCvGfNiXVwCWZnkSkbTe2Zwltn1utK+gQyS9RlgmCrzUSZAWn5IcLfrbgYpC1GnrseNXp
 rZnPWBpalJGM2fiuLb5DVuTisqjNfJn/IDAQg2pqqGAMVhB6UFGHIqojS4BktT0LszUwSmPoyas
 JbsgExGFoPGmJpDaIb0CSVtlIJIg==
X-Received: by 2002:a05:6a00:12cd:b0:82f:a6bf:bee7 with SMTP id
 d2e1a72fcca58-8415f68cb16mr14177768b3a.49.1779715610024; 
 Mon, 25 May 2026 06:26:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:12cd:b0:82f:a6bf:bee7 with SMTP id
 d2e1a72fcca58-8415f68cb16mr14177753b3a.49.1779715609579; 
 Mon, 25 May 2026 06:26:49 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841648a2bf2sm8806449b3a.0.2026.05.25.06.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:26:49 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Richard Weinberger <richard@nod.at>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v1 3/3] fdt_support: prefer __func__ over __FUNCTION__
Date: Mon, 25 May 2026 13:26:25 +0000
Message-ID: <20260525132628.755148-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525132628.755148-1-aristo.chen@canonical.com>
References: <20260525132628.755148-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 16:46:18 +0200
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

A handful of printf call sites in fdt_fixup_memory_banks,
__of_translate_address and fdt_get_dma_range still use the
gcc-specific __FUNCTION__ identifier. checkpatch.pl prefers the
C99-standard __func__ for new code, and the rest of this file already
uses __func__, so convert the remaining occurrences for consistency.

While in __of_translate_address, also re-align the continuation line
of the inner Bad cell count printf so the second argument lines up
with the open parenthesis of its printf instead of being one column
off, silencing the alignment check that scripts/checkpatch.pl reports
on the cleanup hunk. No behavioural change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/fdt_support.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index c4c2a5d02f6..14a24d6f641 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -551,13 +551,13 @@ int fdt_fixup_memory_banks(void *blob, u64 start[], u64 size[], int banks)
 	if (banks > MEMORY_BANKS_MAX) {
 		printf("%s: num banks %d exceeds hardcoded limit %d."
 		       " Recompile with higher MEMORY_BANKS_MAX?\n",
-		       __FUNCTION__, banks, MEMORY_BANKS_MAX);
+		       __func__, banks, MEMORY_BANKS_MAX);
 		return -1;
 	}
 
 	err = fdt_check_header(blob);
 	if (err < 0) {
-		printf("%s: %s\n", __FUNCTION__, fdt_strerror(err));
+		printf("%s: %s\n", __func__, fdt_strerror(err));
 		return err;
 	}
 
@@ -1503,7 +1503,7 @@ static u64 __of_translate_address(const void *blob, int node_offset,
 	/* Cound address cells & copy address locally */
 	bus->count_cells(blob, parent, &na, &ns);
 	if (!OF_CHECK_COUNTS(na, ns)) {
-		printf("%s: Bad cell count for %s\n", __FUNCTION__,
+		printf("%s: Bad cell count for %s\n", __func__,
 		       fdt_get_name(blob, node_offset, NULL));
 		goto bail;
 	}
@@ -1530,8 +1530,8 @@ static u64 __of_translate_address(const void *blob, int node_offset,
 		pbus = of_match_bus(blob, parent);
 		pbus->count_cells(blob, parent, &pna, &pns);
 		if (!OF_CHECK_COUNTS(pna, pns)) {
-			printf("%s: Bad cell count for %s\n", __FUNCTION__,
-				fdt_get_name(blob, node_offset, NULL));
+			printf("%s: Bad cell count for %s\n", __func__,
+			       fdt_get_name(blob, node_offset, NULL));
 			break;
 		}
 
@@ -1618,7 +1618,7 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
 	bus_node = of_match_bus(blob, node);
 	bus_node->count_cells(blob, node, &na, &ns);
 	if (!OF_CHECK_COUNTS(na, ns)) {
-		printf("%s: Bad cell count for %s\n", __FUNCTION__,
+		printf("%s: Bad cell count for %s\n", __func__,
 		       fdt_get_name(blob, node, NULL));
 		return -EINVAL;
 		goto out;
@@ -1627,7 +1627,7 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
 	bus_node = of_match_bus(blob, parent);
 	bus_node->count_cells(blob, parent, &pna, &pns);
 	if (!OF_CHECK_COUNTS(pna, pns)) {
-		printf("%s: Bad cell count for %s\n", __FUNCTION__,
+		printf("%s: Bad cell count for %s\n", __func__,
 		       fdt_get_name(blob, parent, NULL));
 		return -EINVAL;
 		goto out;
-- 
2.43.0

