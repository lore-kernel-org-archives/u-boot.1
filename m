Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF341C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE7682905;
	Thu,  8 May 2025 14:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="YfKo9vCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF9E8283E; Thu,  8 May 2025 14:08:03 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7805482153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 14:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=X/QKKRbxeB8RAiWkq5On9yW5uoFRWCrVLFQTeAda/qI=;
 b=YfKo9vCeNW38DCa6jhMgLK4sgiryH7YsiXfOzRNqmvb2Wzx/ocUwCAG3mA6C+k3dtxJlDJGLhgJ3bH53Nx9jIfpfb702ulInDix0XYHgYvP3mGwUOqwhjYdnzqZwycO5v4ekDw7JxYTv0vpftiyfAn8ZMnZRHn4nOT19Gzzy7wMeiTN97aXmhSiwUXjvNoiRsxBnDrsvSnkyo4NCYmpRc39Vjlk8baIXaYdSFqXaJ21ZcPV7UkylisPEJI
 MxR5T84fIUX/MyaWlhX9V4kB7hw8mcngCppoFcT8BWbWiLDd2HtPqv8GlP6osbJ8RkJ5M+6PqZZRwJVHuhW5qRud+N9w==
Received: from TkB (188-24-195-180.rdsnet.ro [188.24.195.180])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Thu, 8 May 2025 12:07:56 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH] EXT4: add CRC16 dependency
Date: Thu,  8 May 2025 12:05:19 +0000
Message-ID: <20250508120518.1489-2-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 May 2025 14:50:08 +0200
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

CRC16 is used in ext4_common.c. Build fails without it.

PS:
This is my first patch sent to a mailing list.
If there is anything wrong with it (email format, whitespace, etc.)
please let me know.

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
---
 fs/ext4/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 1a913d2b6d2..8ddaebebd48 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -1,5 +1,6 @@
 config FS_EXT4
 	bool "Enable ext4 filesystem support"
+	select CRC16
 	help
 	  This provides support for reading images from the ext4 filesystem.
 	  ext4 is a widely used general-purpose filesystem for Linux.
-- 
2.49.0


