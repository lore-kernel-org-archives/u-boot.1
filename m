Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A47C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 08:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A7CC8706B;
	Tue,  9 Jan 2024 09:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="supuvG4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89FEC86FBF; Tue,  9 Jan 2024 09:53:51 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A551876FF
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EEAFB42115; 
 Tue,  9 Jan 2024 08:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704790429;
 bh=IapfW79luGG7JJIpcVSAvT0VH7BIQI4uuuV8xCPeSlo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=supuvG4NN7ru7c+FIt50yrKSfP4Za0vSV+yfqRMzkQxrL4ge6aYW+Aoa4FhJOhvKf
 rSYdfMFKWCg8RXMjrRkShtZo6VEbW2TVEGRO5emb7ldsvQXV2KlxAA/qZoWnc1zJTQ
 AarYEFAaqBTovFeIcostLCsv2yjb8VUdG3C3JtsoTwp7FF0wAAA1CoWCirbaAAnZaK
 EK5xRBdt5lDlifdyxIdKo11hJUcBLUm6lA+KIks2rPQNJMeNECLAvUvv/F5MTK0UaS
 3ObqtOJq39j/x78MM6uhPXzIXtdXWGIbfrgYPCwW42ReMr0mPR6CXwmkgDJEndTWkV
 Uz9W2Mmndvj+A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] lib: make table_compute_checksum() arguments const
Date: Tue,  9 Jan 2024 09:53:33 +0100
Message-ID: <20240109085334.41481-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109085334.41481-1-heinrich.schuchardt@canonical.com>
References: <20240109085334.41481-1-heinrich.schuchardt@canonical.com>
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

table_compute_checksum() does neither changes the content of the
checksummed buffer nor the buffer length. Adding const to the
definition makes the function wider usable.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 include/tables_csum.h | 2 +-
 lib/tables_csum.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tables_csum.h b/include/tables_csum.h
index 4812333093..9207e85f91 100644
--- a/include/tables_csum.h
+++ b/include/tables_csum.h
@@ -17,6 +17,6 @@
  * @len:	configuration table size
  * @return:	the 8-bit checksum
  */
-u8 table_compute_checksum(void *v, int len);
+u8 table_compute_checksum(const void *v, const int len);
 
 #endif
diff --git a/lib/tables_csum.c b/lib/tables_csum.c
index 636aa59676..305b1ec31c 100644
--- a/lib/tables_csum.c
+++ b/lib/tables_csum.c
@@ -5,9 +5,9 @@
 
 #include <linux/types.h>
 
-u8 table_compute_checksum(void *v, int len)
+u8 table_compute_checksum(const void *v, const int len)
 {
-	u8 *bytes = v;
+	const u8 *bytes = v;
 	u8 checksum = 0;
 	int i;
 
-- 
2.43.0

