Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485B2CCFA13
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 15:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A397848B0;
	Wed, 29 Apr 2026 17:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sImViJkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688E7848B6; Wed, 29 Apr 2026 17:54:26 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D8F848A7
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 17:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D83BD3F281
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777478063;
 bh=pQkw2u/ja27zXeOX3rf5QgUGqeDazdoiOC+616s5b+0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sImViJklAlxnTkVxBsh02+qS9On7AV21LbDxeeeHxLz/7qLzEaixbMTUkimFfz+B8
 IecD1xZY/DDF22Z+H/BQLlpJlauHWNKQOfMl+PGZ1BqtVJqzTkcR4eoFwnFBQMoejj
 ULpckWCMFG8ox+Re2A2WSWYep5ThrLCE71u/kDQhzft3h5zlXbh4TuPcVDDllyjpJ/
 cyWCZtL7VPaoZqER05BPoL4llGvXiqRxTA+U4wMIbM1mRCBnDIfRsVMOtHDdmhqYbE
 hktjFZvehA7K9YxNzJRinDOrCkZbXyP0VTERRanuVCONzTgOmBHBCAwmJ6veaBDxEw
 1rX2hMnmVNS8ogUG7V0pt2L4ShMnzfFPUGxwCbQSoPS20uWhSwGIR4Ki076PbbAPKw
 6wghvq1foFzGvAr56+eA1ae0gX2cuvMqr3+IaK4bbF/CwRl6Tg06qTSsKGYYAtoF3u
 A0Gf+Y2M5OQjKXM+lt6J8LSur5B2edULadnexIsaoNa0yyMSq9uHMIMJZSPZdPquw7
 eF9YjqXVCz+hPu7V0LGfzjE+A7uFPjrQjlSrq4TWnc30bhf4076jdinQVoaX86QpdG
 716+us2skOclyfWoMZ7lUrvG+zGjEzlf818e9U2bPERGhtaLWDTQmrjBQF8thd6Hy9
 XuMzdR+JQsV23tfsGFIYoGsg=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48919890a95so74799025e9.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777478063; x=1778082863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQkw2u/ja27zXeOX3rf5QgUGqeDazdoiOC+616s5b+0=;
 b=CvNM16UHdcCUAeJ0182XzT8x79zq503mz3IL+WwpMedo4I1uqDK/KuHDAFDizCv3Vt
 W4nqWLnfS5sAhB60O/vSkWaL7MAqzEAlfsLwFOGQI8bwWmINuM/L+YF3Eg21vFMA19bJ
 IhUY+a+2f7L18Dk1cXr4rrOEhskUzeRF3azlL/4N7PjMS6xdkSVXmLuRrKQ9PZBLgX0c
 jRvXX87iobi597qpHKs7oVALV4MYtHI8PH1hMJiUVrTsCNq4j0X77JWoBNhBWOyIohBw
 XIWZDvPAeyWX4nOc6YFfJoQnKWx4IjUyzHxZTVMO1GNINxJxyya6NkYlVfokCNDMMCLR
 6D8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9y8QkOUmU8p35Anwhyzgpfmla21prkrFHaTo0IfkAVBTFXONrvlAlRPPeiuckhQlUQioT/hfk=@lists.denx.de
X-Gm-Message-State: AOJu0YwH6b0uhXm0sCNz1t+bN9Cpxt5923dvkLGB+dlIu3U678hnrFl1
 3v05uX4aLBUniHLZUDxkMueXwg+T2i+KyU3xVpABGHROS5UtOu2gyBDXmF1R5+2lPrjbPM02yUV
 qKJG91VzCrTi9sMJ5ltjbpQcHgkVe+462ucCkuwqWKTTbphdruLuD0IGlqHx8WCISf1wXUIA=
X-Gm-Gg: AeBDieuEXKd94SMXj3Lbkx2wUCtrYcCPXd9ErLfzoyYSo0o37MSnWhnvi5koMLAsqRr
 7aQH8DdWM9Ie4bA4V15G4SO5XuH6bnPaDKDgi5RIMprHBww8su844QK3l8HVEUacmCMj7HKorRa
 +JF9h44R937T+5lwQ+0bUh3RG+Mxg2bD9pPzDvGJw41Em3tu64mW/1I7fFe9phkkjGIlbHGhupS
 ZyEGPc9t/7r8PkOkUxF2gVJrWEqQVHNp7erq5oNqnwV2RSWGTGFrqZFVyCEnQXZRCfN8/AtzyPg
 zqtJEf/WIS0pckX8hne0G6scBq4eD9RRQRLp+rh7gdRuTHbPEgMi7oximeQkcSixqPLD+9zpqaW
 q+QQ1X6Z+bg07PutK6FqiWaf70zVoImYBN40U/CsMeF3lEWrgcPAwiUPo+YR460Kz4Ch4qOEweL
 /Px7GokQUp27aqcW6BH0HSOzev+M97WC7YsSSDJ8fe7cSNBZ576MkNkZr/soMj
X-Received: by 2002:a05:600c:859a:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48a7b519560mr56694455e9.11.1777478063443; 
 Wed, 29 Apr 2026 08:54:23 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48a7b519560mr56694075e9.11.1777478062950; 
 Wed, 29 Apr 2026 08:54:22 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed659dsm1353335e9.2.2026.04.29.08.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:54:22 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Daniel Palmer <daniel@thingy.jp>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fat: initialize ret in disk_rw()
Date: Wed, 29 Apr 2026 17:54:18 +0200
Message-ID: <20260429155418.75429-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

If fat_sect_size = 0 and nr_sect = 0, the value of ret is never intialized.
A random return value is returned.

Initialize ret to 0.

Addresses-Coverity-ID: - 645495 Uninitialized scalar variable
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 31c136e3b9e..c1ccf30771a 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -71,7 +71,7 @@ static inline __u32 sect_to_block(__u32 sect, __u32 *off)
 
 static int disk_rw(__u32 sect, __u32 nr_sect, void *buf, bool read)
 {
-	int ret;
+	int ret = 0;
 	__u8 *block = NULL;
 	__u32 rem, size, s, n;
 	const ulong blksz = cur_part_info.blksz;
-- 
2.53.0

