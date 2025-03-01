Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6250AC021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 13:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6484F81101;
	Sat,  1 Mar 2025 14:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="JglJp5jK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E09B0810ED; Sat,  1 Mar 2025 11:22:21 +0100 (CET)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A79805D7
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 11:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1740824538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XNt5zzdfqi0EOXr5ZsB+Sg6BOem/todNe3TzOf8hsAg=;
 b=JglJp5jKecUH8aiZ6dJhHDlnUWyzQwkmd6jOYD9ZTp3z+Nhdiq0gXmRZeDoA4D/S2scQjm
 4sljfI9tFQEh3DaMBqgs4iJ6EzGms3GWmn/EGI1RBECe1YrX7z7/EWP8gsXp5XvH+AHwXb
 /LijPzc7Mf5esquD0Oa0723OJxwOyk9wgC7jfSQPcVE3IOCpp8Zs/I5dfs5HNqTTooRNWE
 wrlEcrQLQbRRxRhVqYp7sYF6cNWU7Tw2YETNNsCZN38WkOJqrKXpuIgZdee7ftMypUzycA
 qbUj/WS8zkEpOrzkqbDThksEkveXVUPxICsy28Hf2VKvXUdDSa/ZTMSk/Agu/g==
From: Diederik de Haas <didi.debian@cknow.org>
To: Eugene Uriev <eugeneuriev@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] mcheck: Fix SPDX License Identifier to LGPL-2.1-or-later
Date: Sat,  1 Mar 2025 11:14:12 +0100
Message-ID: <20250301102202.289097-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sat, 01 Mar 2025 14:07:30 +0100
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

The GPL-2.1+ SPDX License Identifier doesn't exist, but luckily the full
license text was available which shows that GPL-2.1+ was a typo and it
should have been LGPL-2.1-or-later.
As the '+' in LGPL-2.1+ is deprecated in SPDX 3.0, use the preferred
identifier, which is '-or-later'.

Normally the full license header is removed when switching to SPDX
License Identifiers, so do that now.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 include/mcheck.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/mcheck.h b/include/mcheck.h
index bd506ae6291..4b11751ebcc 100644
--- a/include/mcheck.h
+++ b/include/mcheck.h
@@ -1,18 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.1+ */
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  * Copyright (C) 1996-2024 Free Software Foundation, Inc.
  * This file is part of the GNU C Library.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- * <https://www.gnu.org/licenses/>.
  */
 #ifndef _MCHECK_H
 #define _MCHECK_H       1
-- 
2.47.2

