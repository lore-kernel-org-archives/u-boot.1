Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E198CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 23:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7659E82E67;
	Thu, 21 Aug 2025 01:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e78pq9el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF7882F03; Thu, 21 Aug 2025 01:17:21 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AF582E37
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 01:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-108-215.46.114.pool.telefonica.de
 [46.114.108.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BD9C23F7BD; 
 Wed, 20 Aug 2025 23:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755731837;
 bh=aJ2T3WZgcCTiRstqePfV1hyHqcpK2spz5YUZN9j7WYE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=e78pq9elQmQg77sTf+h8afrbb4MB6xacbXdtM4wWqO4xz0d+Vf5MDo0Q/i5EdNmx+
 r0zZKCHdjBPMQ0SJyeG50jC+viRVVByIwyvLk7XN3+HqtoFDGkS/5IsybQMj+AN97y
 t1okAnlzLxHlqMFuxVlXK1jSbiZjThbSrJVpDikjOqFXYg7F4wUHLAEQYLKF5jt1cM
 rL2ShJZog9/M6sskf5mfxztBjuT7y3fF/+w5MMnnnUMCrC9oESSZcr5JTp2p2OXBQ2
 QWVgK0Av1h3N+7bHQMfCLsCCL9VxJ3/yQoJ4duD2riqVBbCXUyvYbhJJGzfMG8iDW0
 Xev0/QLVA7OKg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: use utf-8 as encoding for C includes
Date: Thu, 21 Aug 2025 01:17:11 +0200
Message-ID: <20250820231711.45677-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

Correct spelling of name 'Joan Lled√≥' in copyright comments.

This avoids warnings in CI:

    Skipping file './lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h'
    due to unicode error

    Skipping file
    './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/sockets.h'
    due to unicode error

    Skipping file
    './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h'
    due to unicode error

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h  | 2 +-
 .../lwip/contrib/ports/unix/posixlib/include/posix/sockets.h    | 2 +-
 lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h b/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h
index c7bc124916d..d5776f47efd 100644
--- a/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h
+++ b/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2023 Joan LledÛ <jlledom@member.fsf.org>
+ * Copyright (C) 2023 Joan Lled√≥ <jlledom@member.fsf.org>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
diff --git a/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/sockets.h b/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/sockets.h
index f390066616a..0c166e4dabd 100644
--- a/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/sockets.h
+++ b/lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/sockets.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2023 Joan LledÛ <jlledom@member.fsf.org>
+ * Copyright (C) 2023 Joan Lled√≥ <jlledom@member.fsf.org>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
diff --git a/lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h b/lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h
index 1b38aa3aef1..1c43d6f22f6 100644
--- a/lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h
+++ b/lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2023 Joan LledÛ <jlledom@member.fsf.org>
+ * Copyright (C) 2023 Joan Lled√≥ <jlledom@member.fsf.org>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
-- 
2.50.0

