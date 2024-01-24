Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F80C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 20:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F4D87C69;
	Wed, 24 Jan 2024 21:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GB5L6uc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF24987C32; Wed, 24 Jan 2024 21:04:42 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19448793F
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 21:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 178693F6E1; 
 Wed, 24 Jan 2024 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706126679;
 bh=XFzpOZosk0UyWJc9V9suh4+UooUXVLFTeIMp6WJvUzM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GB5L6uc52oatbuK6xSupFpykzodTIVjXM7qulJ/vU7A7SOK48oUzDba7MAkUlm2p/
 m6GHSJcmhAHzbEkqAulH31fc6rRIwyVeH0m3O54/WZDxnkcZJAzYdd3VmHhdtn6Kyv
 cLHydc1FH8G+IlNOseqQRHjjTGWBEBezCUSfvDx7v/rS6i9hfjVH9fse8Klv1G0e9X
 d4vN4v2apotwuD+AF/S0m10A3recq59h3aNZOAoXFbx3PUNHCHubRQL4FANN/IU1po
 hht7lF9SanFgKFbtt1GTP7ou0FyKl/5zgCAc2SutRkmYkwr9/4MHakdcwZa6oBr73I
 nlQXkX6cRYCdw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: add missing line feed in
 efi_selftest_miniapp_exit
Date: Wed, 24 Jan 2024 21:04:32 +0100
Message-ID: <20240124200433.23543-1-heinrich.schuchardt@canonical.com>
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

If an error occurs we may see an output like:

    EFI application calling Exit

    Could not open loaded image protocolLoaded image protocol missing

Add the missing line feed.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_miniapp_exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_miniapp_exit.c b/lib/efi_selftest/efi_selftest_miniapp_exit.c
index 8b2e60cc711..0909a5ca748 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exit.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exit.c
@@ -39,7 +39,7 @@ static efi_status_t EFIAPI check_loaded_image_protocol
 				  NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
 	if (ret != EFI_SUCCESS) {
 		cout->output_string(cout,
-				    u"Could not open loaded image protocol");
+				    u"Could not open loaded image protocol\n");
 		return ret;
 	}
 	if ((void *)check_loaded_image_protocol <
-- 
2.43.0

