Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC5ED3C92D
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 17:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F62288901;
	Mon, 21 Oct 2024 19:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F438897F; Mon, 21 Oct 2024 19:18:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 717EB88549
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937A1DA7;
 Mon, 21 Oct 2024 10:19:25 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94BEA3F528;
 Mon, 21 Oct 2024 10:18:54 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] lmb: add a check to prevent memory overrun
Date: Mon, 21 Oct 2024 22:48:20 +0530
Message-Id: <20241021171820.625003-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

When printing the LMB flags for a memory region, there is a need to
check that the array index that is computed is a sane value. Put a
noisy assert in case this check fails, as that implies something with
the LMB code is not working as expected.

Reported-by: Coverity (CID 510463)
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/lmb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lmb.c b/lib/lmb.c
index 7e90f178763..a7298dfd673 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -76,6 +76,7 @@ static void lmb_print_region_flags(enum lmb_flags flags)
 
 	do {
 		bitpos = flags ? fls(flags) - 1 : 0;
+		assert_noisy(bitpos < ARRAY_SIZE(flag_str));
 		printf("%s", flag_str[bitpos]);
 		flags &= ~(1ull << bitpos);
 		puts(flags ? ", " : "\n");
-- 
2.34.1

