Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10398CEF17E
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 20:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CDD88FA0;
	Tue,  8 Oct 2024 22:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QwJiGXeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCB388FA8; Tue,  8 Oct 2024 22:46:24 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58BF688F73
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 22:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 24BA83F391; 
 Tue,  8 Oct 2024 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728420381;
 bh=Naz1ayENvWnASgC+9Kw96sZdQLbyaFFL01qpASyFbNw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=QwJiGXeXlSbvhKaMcBMuJVukQ4uIvFVPBot9UvNADczeAl9Ge2ft6HuCLudP0vftv
 CcuAniNbC7GQ0zx/6UNxymzxdKZJBpqmuPDT04g/fX8+gpJf2FfK4rWjUXMjT0eQMg
 1/gbIqLbHH2ICgVDjAWohL6EEdhZw476j3ABANSQEoKOB1AJDI1ApWqE92hgeZlcx3
 6HnwxcenCJg4uLIAbFky86otMGqSo6hLtoLPgz7XL8LU/6lSEVIMEBvgScz4+0UMrm
 cW5IyUb2I6qo9y4OCmsqH7InKydkN2G+BmeHDvsQl86C4ixwHVyPh0223yrBAiR6NO
 8pKzrBg3uYpvA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: type boormethod
Date: Tue,  8 Oct 2024 22:46:14 +0200
Message-ID: <20241008204614.56215-1-heinrich.schuchardt@canonical.com>
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

%s/boormethod/bootmethod/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootstd-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 5de8efce19a..fdb8d69e320 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -122,7 +122,7 @@ static int bootstd_probe(struct udevice *dev)
 	return 0;
 }
 
-/* For now, bind the boormethod device if none are found in the devicetree */
+/* For now, bind the bootmethod device if none are found in the devicetree */
 int dm_scan_other(bool pre_reloc_only)
 {
 	struct driver *drv = ll_entry_start(struct driver, driver);
-- 
2.45.2

