Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C773C83F17
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 06:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66F183666;
	Sat, 26 Jul 2025 08:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eR0KrCSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE33983951; Sat, 26 Jul 2025 08:31:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A11835D8
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 08:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-128.46.114.pool.telefonica.de
 [46.114.109.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B8F8B40190; 
 Sat, 26 Jul 2025 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1753511490;
 bh=NRCsKVmqT87n9CxERSdo5gDpqNcHjtED2a1zez++z3w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=eR0KrCSfzoY2xfGUP1FckPwNf3goos+OJTeAJijonSnyPo/PV5ycbHo3SbyO218Ss
 USp/GTBg1UMaCBetNUZNjQAqw8GB1PxckVHSeZ160/FrOzGDCFxJOkWf5vrEz4aSzZ
 yRZ0CrdUZd72sW9gdAxd3pzchQh0M26VxZl06ouxMNN0uCC5o8hWiYJK1ELIKebJaE
 U+vQ5YXbReKzjVoB7j7Z3ruweS3XlCdf2icfi9oceGt+8yPxf79og2tvT/iorpb2CA
 0J7A64hYyu7jsRGuCFuIYoMxOOctbStYofIyXTHgYSEhbKD5WL+QV1qGwkcnX58lI8
 GfldZWGLuvDjg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: mkeficapsule: resource leak in read_bin_file()
Date: Sat, 26 Jul 2025 08:31:23 +0200
Message-ID: <20250726063123.104092-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

Free the allocated buffer in case of an error.

Fixes: 9e63786e2b4b ("tools: mkeficapsule: rework the code a little bit")
Addresses-Coverity-ID: 345917 Resource leak
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/mkeficapsule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index fb6c57f77c1..0f41cdb64f5 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -168,6 +168,7 @@ static int read_bin_file(char *bin, uint8_t **data, off_t *bin_size)
 	if (size < bin_stat.st_size) {
 		fprintf(stderr, "read failed (%zx)\n", size);
 		ret = -1;
+		free(buf);
 		goto err;
 	}
 
-- 
2.50.0

