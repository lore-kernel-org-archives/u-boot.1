Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15131C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 08:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56B88293C;
	Sun, 13 Apr 2025 10:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744534701;
	bh=wi/uwn7zTgRFsndEG9ctoNajxNmXgNTXmpbRO/8ufjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ezKVAYeO5vCHoLHV93WgtLAOJy47koQ29Xgr5q1LztUb+Ez1GgOQ9GTO6qDPo8CiJ
	 okJGtko/Wzseqyln4Ce5VGN6/rop4vD14HA3cJiYR009IKvKXINWtj6Yqj6hmBFMbg
	 3+e/jaJhKa0CvHTQr/zbN+y+mtTANu1+dCeyZn3GvrFdSzpkxHfCmuWDvxlusLcka1
	 vmCIEA4/q8IJoW/Ud6VpTDxEdIx7dWa9hHQ0rHIBFDOnVSPOVVuLibESClFDRYT71O
	 Hk/iFAELIKaZBLhjJY4gfDlq0dYqvAyk8tpNih715Qwr7JiXxHJ6dv+UPIdEi8teYt
	 FkcjI6q4tz8hw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B88829A1; Sun, 13 Apr 2025 10:58:18 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB11E82944
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 10:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="F5CGUa3y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 694561007B825; 
 Sun, 13 Apr 2025 10:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744534695; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=wi/uwn7zTgRFsndEG9ctoNajxNmXgNTXmpbRO/8ufjg=;
 b=F5CGUa3ypbzSIJL9eGczoP3KVNLyeFY/KiyoYL5jUX3g70HiUGBsv3xAPqi0XHS//i4eE+
 iuMhug2/Y8OGqq+eM7K/VSV00MjBZE40MinpeOkxvLvgZbeQVuQpt2ygZ7Fz1MTydjj3yP
 wOiMst4A0cYqrRvZy7txDkZyknyReyzgYO3j+26x8z3Se/R4WsB7NJ72dPQ4Qh6k+otqUg
 2FzRMLbzpRySEvu42OOOcoH9rxbN2buWZJaai6UXmjH6x1RNU8hXxq+QQ1GhchBOgXlSTL
 cyCTZUG9/52p0XIA+QLu1bY/0c4kf5wAgp8PDB6vk2REf378G472uc+ISVyOPQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/7] fs: exfat: Inhibit "impossible" print on write to bogus
 file
Date: Sun, 13 Apr 2025 10:55:00 +0200
Message-ID: <20250413085740.5953-2-marex@denx.de>
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

Write into a bogus file, like '/.', triggers an "impossible"
print from the exfat core code. That should not be printed
in U-Boot, because U-Boot prints its own error message sooner.
Inhibit this error message.

The following command triggers the bogus print:
"
=> save host 0:0 1000008 /. 0x10
"

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
 fs/exfat/lookup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/lookup.c b/fs/exfat/lookup.c
index 9867aab95f3..1d9aae9e036 100644
--- a/fs/exfat/lookup.c
+++ b/fs/exfat/lookup.c
@@ -218,8 +218,9 @@ int exfat_split(struct exfat* ef, struct exfat_node** parent,
 		exfat_put_node(ef, *parent);
 		*parent = *node;
 	}
+#ifndef __UBOOT__
 	exfat_bug("impossible");
-#ifdef __UBOOT__
+#else
 	return 0;
 #endif
 }
-- 
2.47.2

