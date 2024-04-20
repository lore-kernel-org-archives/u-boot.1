Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13677C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 14:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73705880F4;
	Sat, 20 Apr 2024 16:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cxesVHee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512C2880F9; Sat, 20 Apr 2024 16:06:20 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643DA880F1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 16:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C68923F93D; 
 Sat, 20 Apr 2024 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713621978;
 bh=wMdk9HhDyXa5B+sSGNLF9Fq7Gr9sPYYd8gud9r7nKsM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cxesVHeeKBV/O9rFVAOkzCtlfzsc3OD7ZhGgYCNsOZxnFYk0NMOaIywghFLvimnCG
 vUFbsdCoN8xKaOV0AISlfKt//8/MlWPRAXb0UgMMGXCoQJfwMZp/1Gk5YporRx31w1
 mVfK+2hH3Lq97s7nRBnyP4GOyuHqbCkuBcFGYWwgIDgVGoDE0jsEAH9Y0yq3pnD4+X
 OfM9zpuTbaSmfw6G1dHaLX2espOsxNy56y2ai1AYtKAZb89w5bfr0olfXEjBT1g6My
 6RADXoWvX9lBMxtzXHmpz7EAwYVp1aFO8nnuQIX06svfJormIYmKMMlN96Vu1RbeGv
 ZpZp/6N0QeF/g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] cmd: terminate efidebug test bootmgr early on error
Date: Sat, 20 Apr 2024 16:06:16 +0200
Message-ID: <20240420140616.121072-1-heinrich.schuchardt@canonical.com>
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

If efi_bootmgr_load() fails, there is no point in trying to start an image
that has not been loaded.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/efidebug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index a587860e2a5..5103ada29a5 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1397,6 +1397,8 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 
 	ret = efi_bootmgr_load(&image, &load_options);
 	printf("efi_bootmgr_load() returned: %ld\n", ret & ~EFI_ERROR_MASK);
+	if (ret != EFI_SUCCESS)
+		return CMD_RET_SUCCESS;
 
 	/* We call efi_start_image() even if error for test purpose. */
 	ret = EFI_CALL(efi_start_image(image, &exit_data_size, &exit_data));
-- 
2.43.0

