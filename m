Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B2FC2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 06:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED0088403;
	Tue, 18 Jun 2024 08:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="swdim9OP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9932A88403; Tue, 18 Jun 2024 08:32:31 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62439883C2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 82F384087C; 
 Tue, 18 Jun 2024 06:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718692348;
 bh=/0QniR1dT27L4vg6djoUwg+/EWvLwF4s/zlG50n+OE0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=swdim9OPsHAXK7AiLPcY7f1FyfMngbODT8dtDkoQptLVwoNKC39IWhFGoq469HQnk
 HnXpAQH29KN9o5gxbJC/LwEnLzcoHFJ6yfe6ZjVO2EnmZamM4qpyRDFz/5NxmHVGne
 PhSOcjbF4w1Spw1v8asMyE5wbc37qpxP5XLumrHWZa8mcqQh2uLQdOiI1ukhqJYSXW
 R07sdNhxHACxTUchUghoMtFmv1XVOB5wDc5SLSQYAWPGjdO5fOP205xVGiwCfojg9b
 j45eG0CkS9IFUwuwarAGsbaqWJNRF4OOCHrd/LlIeE8W0d6M4IBX6HOcbZZ1FjnECE
 sEv7ahjjyMwuA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] spl: correct link to FIT specification
Date: Tue, 18 Jun 2024 08:32:30 +0200
Message-ID: <20240618063230.24478-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Replace the invalid link to the FIT file format specification.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
SPL is tightly size constrained.

Shouldn't we remove the message with the link which is only of interest
to developers.
---
 common/spl/spl_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 988125be008..2a097f4464c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -587,7 +587,7 @@ __weak void *spl_load_simple_fit_fix_load(const void *fit)
 static void warn_deprecated(const char *msg)
 {
 	printf("DEPRECATED: %s\n", msg);
-	printf("\tSee doc/uImage.FIT/source_file_format.txt\n");
+	printf("\tSee https://fitspec.osfw.foundation/\n");
 }
 
 static int spl_fit_upload_fpga(struct spl_fit_info *ctx, int node,
-- 
2.43.0

