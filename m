Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB073E6748D
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 01:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A827583956;
	Sun, 21 Dec 2025 02:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nxV+UmIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3E88391B; Sun, 21 Dec 2025 02:59:14 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F04078334F
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D1D7E409D6; 
 Sun, 21 Dec 2025 01:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282352;
 bh=4QmREwYIeCXXG8gWoAxcWre39ABPyHmvMeiFNyS4k6w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nxV+UmIHWBFpTRN/Sl0TGisyaHEnU3KMZdBJBXb3lgKxeDBMqHAjh0xPo4elyXRI2
 NqEPL6Jj/aVJJAPSJm0B1/ouqgEF2GzXYx1ziOeW0YubU6tHRjIDwGacTLVoF0NpUa
 Q2WmPmMPWBcNPPWP3FtAZTKPcPtHBmhUxC0kGzdhN2WnWLtn84poumRxs13kQCBFJA
 ZO/OP72noP5E0ezP50ndHI/pUB74BmCE/8jttMezZUxJ1Q370xbbOVfoa3363JUo0x
 4KKn/XMJz48HlR2BAfuExR5OnQaAOgSOmUUACrPKUXDkEPdp2teBpFAYMwGwaZnmqV
 +ZVCwD7HQ4Y7NpWYNYbf2DZGXhWMgsjwRWjeO6cRDyMhNQR7NR2/tSlc/GHB7DN45R
 tcuSSM0AP8t99KoQfTjHC+utwWURWxC72v9/6lFg4fEfua7qbj8VRjqCB972M2IKrL
 +bGMmeEgxFw7tpk2EC4m+lmI1AhqU4uclgxj87PumC0VsyPbO7G9J7AN7lmlb1xU5+
 tp5dJ9FFP7CArX1dh/3nMIh5r7caRaw6E0i+Y91xJdLi1+byveUelkelh/CVcwO3fO
 tp/9Tmgd9xNEHPf1d2GjrsH5HUY0boysv2p2dCD/rJbS+iTE8tscyenlhwPqCfg/ey
 +Z1ubq8j6Ja1LMQBdkxt/wtY=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 5/8] cmd/meminfo: display of addresses above 4 GiB
Date: Sun, 21 Dec 2025 02:58:56 +0100
Message-ID: <20251221015859.738112-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
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

Addresses above 4 GiB don't fit into 8 digits.
Use 13 digits which encompass up to 15 TiB.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/meminfo.c      | 8 ++++----
 test/cmd/meminfo.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index aa3b5bafe17..b731280d106 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -23,9 +23,9 @@ static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
 {
 	ulong end = base + size;
 
-	printf("%-12s %8lx %8lx %8lx", name, base, size, end);
+	printf("%-12s %13lx %13lx %13lx", name, base, size, end);
 	if (*uptop)
-		printf(" %8lx", *uptop - end);
+		printf(" %13lx", *uptop - end);
 	putc('\n');
 	*uptop = base;
 }
@@ -64,9 +64,9 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	arch_dump_mem_attrs();
 
-	printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
+	printf("\n%-12s %13s %13s %13s %13s\n", "Region", "Base", "Size", "End",
 	       "Gap");
-	printf("------------------------------------------------\n");
+	printf("--------------------------------------------------------------------\n");
 	upto = 0;
 	if (IS_ENABLED(CONFIG_VIDEO))
 		print_region("video", gd_video_bottom(),
diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
index 40c3520496e..9224b9589f3 100644
--- a/test/cmd/meminfo.c
+++ b/test/cmd/meminfo.c
@@ -17,7 +17,7 @@ static int cmd_test_meminfo(struct unit_test_state *uts)
 	ut_assert_nextlinen("DRAM:  ");
 	ut_assert_nextline_empty();
 
-	ut_assert_nextline("Region           Base     Size      End      Gap");
+	ut_assert_nextline("Region                Base          Size           End           Gap");
 	ut_assert_nextlinen("-");
 
 	/* For now we don't worry about checking the values */
-- 
2.51.0

