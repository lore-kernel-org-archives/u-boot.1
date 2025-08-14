Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D90CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 15:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165218398D;
	Thu, 14 Aug 2025 17:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="hKjnXTxa";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ct0oKe9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4876E838C5; Thu, 14 Aug 2025 14:03:49 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B91838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1755173026; x=1786709026;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q5RbodzSKeP7MO2b+omBLxYWYReTFZxwsPOf4IsDHTU=;
 b=hKjnXTxaSASjDOFlppC88l+0g2wBy7vb8cbQ0cyoPmsy7wotY1LYd3/a
 EeXqhpmmbpAxEBpLjPRr7GLyjYRQC+9/FJVFciZ/2pBzVtuZ0pfuQoIb0
 tiSlhOKpfmC8FQWBzi7KaePzr2ygI7wGKcYOgEktlrUBj3D6lnR7TdiSk
 tVij+KYF1RcScLOL4yICxXgJl416qwjAUlSWppC4OKrHtWj6pooiFTNXj
 VUm0NIipmYiAVUJt/KsDAYx5kjRJ4P7lcv5ioc21qDGOU0WYZUx8Qxj9H
 PyQjzRdKsVW3gxgKAn+RRLxlJF05Wl8qc49FiRg0kC05ht/S5j6K+/qkp A==;
X-CSE-ConnectionGUID: WeI20ejzRuqsa7v6I7VyNg==
X-CSE-MsgGUID: o4iSv+E4Ry2JI6jrKOh+Bw==
X-IronPort-AV: E=Sophos;i="6.17,287,1747692000"; d="scan'208";a="45742127"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 14 Aug 2025 14:03:45 +0200
X-CheckPoint: {689DD0A1-4-410E8DD8-CEA8F0F8}
X-MAIL-CPID: 367739D9EB49AA9F51A71040715DC448_3
X-Control-Analysis: str=0001.0A00210A.689DD09C.0010, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A0BEF16C3D7; Thu, 14 Aug 2025 14:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1755173021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q5RbodzSKeP7MO2b+omBLxYWYReTFZxwsPOf4IsDHTU=;
 b=Ct0oKe9e3Baj4DEOl6qBMWx+s+M1W5pxiqkwc57W1C8jplqu92aPHUf0xfhPoeevA90v4c
 dSnQt5s3LgYCXM8i8n2ghJmZkRTebj/+NvCC/R7egOcgi0HgONG2NsL14XGR0YRjftUuKW
 Sab38JACX3wOoGHB9D07zR8jsh1AedURRK11i2NpVZCir444NMB1Fk+UyzCc8neDfBbUd7
 KC8DVeA9NcYp76NKf3FFNqJ2zAa8bcDe2EEsnfPJtAizABZ3oOcjdnXz19+5xCYJzRZ07s
 MsSlQr/B5+WHECXkTB72J185tNYXLi6I9jRz0kbZygDrUdux0VZSo4jyIPrdvw==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH] bloblist: fix missing OR between licenses in the
 SPDX-License-Identifier
Date: Thu, 14 Aug 2025 14:00:11 +0200
Message-ID: <20250814120029.234237-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 14 Aug 2025 17:15:25 +0200
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

Currently, the conditions of both licenses (GPL 2.0 and BSD-3-Clause) must
be met. However, the original commit message states that the BSD-3-Clause
was added to allow use of the files under a less restrictive license than
GPL 2.0. Therefore, the required OR between the licenses has been added.

While at it update the SPDX-License-Identifier to SPDX version 3.

Fixes: 6c9e3d1f ("bloblist: Relicense to allow BSD-3-Clause")
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 common/bloblist.c  | 2 +-
 include/bloblist.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..5d9cf0725d9 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 /*
  * Copyright 2018 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..695111014f1 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
 /*
  * This provides a standard way of passing information between boot phases
  * (TPL -> SPL -> U-Boot proper.)
-- 
2.43.0

