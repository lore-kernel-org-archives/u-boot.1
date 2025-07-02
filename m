Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340A5C77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 20:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEB982103;
	Wed,  2 Jul 2025 22:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nf/Z3eNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EAD5822D7; Wed,  2 Jul 2025 22:58:27 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348F581FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 22:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.. (dynamic-046-114-109-154.46.114.pool.telefonica.de
 [46.114.109.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8B09A3FF2B; 
 Wed,  2 Jul 2025 20:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751489904;
 bh=wpuH544ImJDfjSQeYxkTzYo5zH51Rtcoih9yZCUg5Pw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=nf/Z3eNkpblyaEX+RSrmlMz4OWkbKOa4Nna3xvLLjnYPdk2YjHRbEzMF/gcNzcBiP
 Gg6jd/04o+nSzy9XCFdKzOlkTc7qnjpe5SxUKS60DvS3Jjwb3F3ftKpVL9o6/xVHBC
 zAC4EES3Gan0TLhYatreU4eZPLJ8zTOPGpqD7qVMT2PvrZL9m89IBLeBjMNMyzurCG
 SLiThpGn3sjcDNZ3dCHa3M3KmGE4xU+DvAPrjKpG01+eet9uAJ92hyhDvxmhwSkcyS
 hgPieAonjx7GeFipMq8MJNLXQ2pDxCPGa6plgKt2SKqNCPaMBCKkutfdxsd/Mjc+qX
 MCxWeQIScHsMA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/exception: missing include string.h
Date: Wed,  2 Jul 2025 22:58:18 +0200
Message-ID: <20250702205818.44188-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occurs:

    In file included from cmd/arm/exception64.c:87:
    include/exception.h: In function ‘exception_complete’:
    include/exception.h:41:23: error: implicit declaration of
    function ‘strlen’ [-Wimplicit-function-declaration]
       41 |                 len = strlen(argv[1]);
          |                       ^~~~~~

Add the missing include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
This patch is for the next branch.
---
 include/exception.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exception.h b/include/exception.h
index a7f21e73d75..0d4dff49954 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -6,6 +6,7 @@
  */
 
 #include <command.h>
+#include <string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
-- 
2.48.1

