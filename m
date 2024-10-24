Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF277D0BB7B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 09:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C088931A;
	Thu, 24 Oct 2024 11:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fbg0yS69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA8E89347; Thu, 24 Oct 2024 11:15:42 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6268931A
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 11:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.CtrlMice (43-114-103-145.static.glaslokaal.nl
 [145.103.114.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9043A4239A; 
 Thu, 24 Oct 2024 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729761332;
 bh=a0vvQJ/BKN1rS/MIiF+wW7W7PyqYk2b1SxfS3ORnjAE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Fbg0yS69hWapI/OTX0zaBhmhBcVmcncLi7ICgQTly7QM5/Av7a8OO5OrEQj5MEqaL
 i4WquICwMPX1k5jwXE0CcIUnt6G7MUVxzFs3WQcUnkB23+6vTybZw+w25oYeExftQu
 pbBtZjyyMW3frZ6mgO68nFQjw+RHvTsoDfr76Q86Yl70KCdVm9OMkeNsJyWeYcmItd
 ygCuNEIRGjfVA65QpvdBTxaCFWpcxuFQpR5ea1P0t+ys3SeIZSBgx4531lT8XhPCXJ
 beTIgjixjtSBwUul1qfXciHmrF3Kk9VxK0e3kGeZcXEg9KJKm5MYjF3gQ7ueh8ccBu
 smDqPe6xlk06g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rob Clark <robdclark@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] doc: include file-system API into HTML docs
Date: Thu, 24 Oct 2024 11:15:29 +0200
Message-ID: <20241024091529.31136-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024091529.31136-1-heinrich.schuchardt@canonical.com>
References: <20241024091529.31136-1-heinrich.schuchardt@canonical.com>
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

Add include/fs.h to the API documentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/api/fs.rst    | 7 +++++++
 doc/api/index.rst | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 doc/api/fs.rst

diff --git a/doc/api/fs.rst b/doc/api/fs.rst
new file mode 100644
index 00000000000..38c8b0dea30
--- /dev/null
+++ b/doc/api/fs.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+File system API
+===============
+
+.. kernel-doc:: include/fs.h
+   :internal:
diff --git a/doc/api/index.rst b/doc/api/index.rst
index 9f7f23f868f..a108718ea99 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -12,6 +12,7 @@ U-Boot API documentation
    dm
    efi
    event
+   fs
    getopt
    interrupt
    led
-- 
2.45.2

