Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F2ACF042B
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 22:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C23388E65;
	Wed,  9 Oct 2024 00:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UT59JOwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C88B88E65; Wed,  9 Oct 2024 00:52:37 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266AC88C0F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 00:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-109-097.46.114.pool.telefonica.de
 [46.114.109.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1038F40A54; 
 Tue,  8 Oct 2024 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728427954;
 bh=bpnhHrMuwmgj0aZZiNgAqoYDWKA4CvVA0NtF0HR1Jms=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UT59JOwgr9A7g/0LL1rm1bT+H5CJLQQqJasOU8yGIQ8ku1NiyhbGoocPBufKWm+nX
 jXrPjfc6v5SIgqX1WC+nQnL4G7iP8fqe1LQECnx2T1JUTbmruCWSzfRd7RFOeld/9j
 rzyHmtBTYu/6FdJJD7dh5xOGJjWmUzXZNxjl6zhB9ij2+XU2IMFH1zieUo1/M88REO
 pGamx3+krRNB83WZ2FPseGsVln2+OdAWw7gQ6o6FudGsKUn5iGoruKaz7UYSLeeZ8w
 oFnn5bLydcD1y+20+ZC/Wcv5caZ4kmDHgiuCswH7p0AXrKVS6eefgFAsKG8Fbip7oO
 +n0OYoCcay8Og==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net/wget: set filesize
Date: Wed,  9 Oct 2024 00:52:28 +0200
Message-ID: <20241008225228.107491-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Environment variable filesize is needed for man use cased, e.g.

* write file to device
* calculate hash

Let wget set the variable.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/wget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wget.c b/net/wget.c
index f978adc9f0a..635f82efbb3 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -400,6 +400,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 		efi_set_bootdev("Net", "", image_url,
 				map_sysmem(image_load_addr, 0),
 				net_boot_file_size);
+		env_set_hex("filesize", net_boot_file_size);
 		break;
 	}
 }
-- 
2.45.2

