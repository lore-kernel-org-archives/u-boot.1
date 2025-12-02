Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC6D116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 15:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3E183CAA;
	Tue,  2 Dec 2025 16:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cyberdimension.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cyberdimension.org header.i=@cyberdimension.org header.b="Kmtp5U6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BFC83E70; Tue,  2 Dec 2025 16:21:05 +0100 (CET)
Received: from rockpro64.cyberdimension.org (cyberdimension.org
 [IPv6:2001:678:938:3ff::36])
 (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA2483B7E
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 16:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=cyberdimension.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=GNUtoo@cyberdimension.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=dkim; bh=n976bZ/8jeqbzvb
 1XMdVXIXYEPG8J7KBFH21MbPqYGs=;
 h=references:in-reply-to:date:subject:
 cc:to:from; d=cyberdimension.org; b=Kmtp5U6HOrVwD59f0hedDVNYA5kh8BRMP/
 pY0vluGP95g8mekACNMFCEnfoWweJSPbotwUiSZx+1wkA3/ZufVh0rae8eo4AuO6JZ4FpG
 aT1tVEdmaZcbKpqpwHvqcLJDolCl6zkpf+trSoidvKNrDsivES/aVB2/z9Jl616ezLaT3b
 vaOeNSQgpd9Ppx2ec2p4uRIYgps3tmnujgIvyRWsac0hu/7NEXclnEtb1o4k5cIKjofkQN
 kjYu+Z/3cQkXy7DcqVN50ieJSITKgSgm2NuZpdgSLlKyw9uQP+Fyqj7HRuRYWXbv73ttmY
 A5fxKUtAUzIqqWpMBsD5kj6NXlAw==
Received: from primarylaptop.localdomain (localhost [127.0.0.1])
 by rockpro64.cyberdimension.org (OpenSMTPD) with ESMTP id c5b44937;
 Tue, 2 Dec 2025 15:21:00 +0000 (UTC)
From: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Leah Rowe <leah@libreboot.org>,
 Sean Anderson <seanga2@gmail.com>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Subject: [PATCH v2] test: correct strlcat license information
Date: Tue,  2 Dec 2025 16:20:55 +0100
Message-ID: <20251202152055.12467-1-GNUtoo@cyberdimension.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251124194556.GM2125796@bill-the-cat>
References: <20251124194556.GM2125796@bill-the-cat>
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

The GPL-2.1 isn't a valid license.

The copyright header says that "These tests adapted from glibc's
string/test-strncat.c" and test-strncat.c is under the
LGPL-2.1-or-later.

This was reported to us by Leah Rowe.

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
---
ChangeLog v1->v2:
* Fixed the SPDX license identifier (LGPL-2.1+ like names are used
  Guix and I'm used to that, sorry for not spoting the issue).
  I've updated the commit message accordingly.
* Rebased on the 'next' branch.
---
 test/lib/strlcat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/lib/strlcat.c b/test/lib/strlcat.c
index d1a0293271b..dead1dfc70e 100644
--- a/test/lib/strlcat.c
+++ b/test/lib/strlcat.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.1+
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2021 Sean Anderson <seanga2@gmail.com>
  * Copyright (C) 2011-2021 Free Software Foundation, Inc.

base-commit: 42a4ff5f63baacc414b564c02541cd1f5c0862ee
-- 
2.51.2

