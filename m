Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F98CC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 08:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2053682956;
	Sun, 13 Apr 2025 10:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744534702;
	bh=p4gWF3vxZDM410m2BD384Ie0wBcxiBXlcsA4ckGNA2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a5Jke2J9J1EyjIoYYOneUVbfxTJ7mTBWfmXq2loSD8ougakXq0tYSN6TIAL4pgoXZ
	 Y08ngjpCFX7DUfeqd1ktqQPWqjBIGk66MRJ8/7IDhaMeM3S6SeDOv7wG0EDN1asSBE
	 EdQsFZK/65BKRYT4sj3sCTrUKqkKK63VsbQ1eJXuLoGxkU3SS8RNm4NlH0cnZnb1PE
	 rmPkTI2EReBagTmlnRRXANFGIf9C4Q/+le71LuGbEXE1qTXuvRD35EoeKF7nAKa7Yb
	 DsRCZGQLSHUinJVd1qE3f/bUUqpJRtyGS/clzXTPG5Q3+RdHknpq7vUPFrrhMg8VWm
	 P9cJntnqeb3aw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5252D82A27; Sun, 13 Apr 2025 10:58:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4958295C
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 10:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bmaf7Yl5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D711F1007B82A; 
 Sun, 13 Apr 2025 10:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744534697; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=p4gWF3vxZDM410m2BD384Ie0wBcxiBXlcsA4ckGNA2U=;
 b=bmaf7Yl5a2n6T2Yk4nuUOLm9G/0bnU1NZh8+WILDWPK5cEZvvhJxfoi+3TgnST7w1scWQT
 6O1dRJEEXPRUvqsGnXi4wJkIZLUPnIzXCNFdRVKLnKzfxIXcwEJ1Kdaffc9EnvY2SghTBy
 fmvVAG0GH3fv47ll4XO2ci7RTklF5EfX1NVcqUcrXfFTML74W+wOd4ZMgLjHRe9NQio/Jm
 UgMYgvTpHOU32G0gubStDXn78P3Kd38Jr2r2chFDo+JKE2U/+N/9PRvqZ5m6OH4Xm/IiRm
 SZQmwGb6e/bbS3uEfG27iHVA6Ztirsu4sDoe9vDPCoVc+eoPS1YXReazx2I9ZQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/7] fs: exfat: Fix exfat_fs_exists() return value
Date: Sun, 13 Apr 2025 10:55:02 +0200
Message-ID: <20250413085740.5953-4-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250413085740.5953-1-marex@denx.de>
References: <20250413085740.5953-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The exfat_fs_exists() should return 0 in case the path does not exist,
and 1 in case the path does exist. Fix the inverted return value. This
fixes 'test -e' command with exfat.

Fixes: b86a651b646c ("fs: exfat: Add U-Boot porting layer")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/exfat/io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index 004ba5d3e45..43c05713ed0 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -875,11 +875,11 @@ int exfat_fs_exists(const char *filename)
 
 	err = exfat_lookup_realpath(&ctxt.ef, &node, filename);
 	if (err)
-		return err;
+		return 0;
 
 	exfat_put_node(&ctxt.ef, node);
 
-	return 0;
+	return 1;
 }
 
 int exfat_fs_size(const char *filename, loff_t *size)
-- 
2.47.2

