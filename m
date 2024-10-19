Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74018D3C904
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 08:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D541788E7B;
	Sat, 19 Oct 2024 10:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QTpKXUNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D5988E81; Sat, 19 Oct 2024 10:50:39 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB2588E33
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 10:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-156.46.114.pool.telefonica.de
 [46.114.105.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5AB5A3F5FF; 
 Sat, 19 Oct 2024 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729327836;
 bh=49BpQDiCPJhL5XzHmjCCuUbQi/0Ov6rfCtEZ0utAIzM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=QTpKXUNX1I2tUJArnTonXnB/xiiuO5DybaLjkMM1aa9/SyHYYtY7lrQK1z6Qp/DKD
 +/Wf2L9pS4fQODGGpUuWRg83JtKeyrc/yk5b9e5eSdZSDjccAnJbJi4bC0SvhX3bcI
 zug/hZTSa67SQR4wmJgLMY0DBygKcBvG0thjDNbF9XX6j3N4hH0OuIAPw4zlohDmEF
 98BFwiYdWshT01m/M/5P/boiexAhPUvdFaF2I08FkenNxIzCBlrLQuhy1nlv0igq87
 AF7+cwMxEpX1ZCeHZV7mqRGOdGQoQNeXDs/iS0uX/RWSktjUjQ3zNc+ozHrA+la2BU
 cQE8RdwMM9o+Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: fix typo 'got languages' in HII test
Date: Sat, 19 Oct 2024 10:50:29 +0200
Message-ID: <20241019085029.22151-1-heinrich.schuchardt@canonical.com>
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

%s/got languages are/Available languages:/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_hii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_hii.c b/lib/efi_selftest/efi_selftest_hii.c
index f219c0120a3..c363df466dc 100644
--- a/lib/efi_selftest/efi_selftest_hii.c
+++ b/lib/efi_selftest/efi_selftest_hii.c
@@ -913,7 +913,7 @@ static int test_hii_string_get_languages(void)
 		goto out;
 	}
 
-	efi_st_printf("got languages are %s\n", languages);
+	efi_st_printf("Available languages: %s\n", languages);
 
 	result = EFI_ST_SUCCESS;
 
-- 
2.45.2

