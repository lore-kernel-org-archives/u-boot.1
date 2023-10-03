Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A0CE776E5
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 01:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C1C870D3;
	Tue,  3 Oct 2023 02:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pTaPDr/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2870E870EB; Tue,  3 Oct 2023 02:59:58 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B29786D5A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 02:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5836C3F2A0; 
 Tue,  3 Oct 2023 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696294794;
 bh=tbgbUztb01cRQ8HOhnzXJ9lsMO9oxvxej1SYfPlVe+Y=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=pTaPDr/rzX8GwDvWeoxchUeVDdofQokqUlwHRGG9Rojz/NinRVOs0LPsXtq+f6+Je
 sYzK9QrHexQ+YTU5D9ngtoIR4rVYtYq3SypaegnBiH51Woy5s9ms1ZdSoM7+ZdnNSv
 HVFlF6FXR1MzYCf2TkClVwTIZPxm4rC0pfL66Uqg5wwbAanbPkTVBFIUDQFqu7Yvlj
 gfaxCQ/LKKlpRvWK8fK8K7uVMIuwnhIpSPxcEdm5k7ZO/xTUgg22WuCS8azkEPW2YF
 fjqeuKgYpsIpeZrg2vPPKr+WkqcD08aN16+vdiRhlBu6Grh5pJEUdD6jqbJhTN3psL
 AlWfjgdaouzpA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: fix spl_board_init
Date: Tue,  3 Oct 2023 02:59:46 +0200
Message-Id: <20231003005946.97653-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

sandbox_spl_defconfig with CONFIG_SPL_UNIT_TEST=n fails to build.

    in function `spl_board_init':
    arch/sandbox/cpu/spl.c:134:(.text.spl_board_init+0x4a):
    undefined reference to `ut_run_list'

Add the missing configuration check.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/cpu/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 09e3d10d6a..7590f1b80a 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -126,6 +126,9 @@ void spl_board_init(void)
 {
 	struct sandbox_state *state = state_get_current();
 
+	if (!CONFIG_IS_ENABLED(UNIT_TEST))
+		return;
+
 	if (state->run_unittests) {
 		struct unit_test *tests = UNIT_TEST_ALL_START();
 		const int count = UNIT_TEST_ALL_COUNT();
-- 
2.40.1

