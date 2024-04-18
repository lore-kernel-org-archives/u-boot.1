Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC9C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 02:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9070688532;
	Thu, 18 Apr 2024 04:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y1hZMOhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3525988524; Thu, 18 Apr 2024 04:31:09 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBB58853D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 04:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3FB883F0B9; 
 Thu, 18 Apr 2024 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713407466;
 bh=/iuE6/kD3v9XGzZmtWNUujsn+K1Zu/JSPWYubuud62k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y1hZMOhzW1mrr4Np11HTju8jDoZoxbtEgU7sc/nMff4fg1dZmkOkH03Ojez6xpxh3
 ZmUGLDDtaDxAfZa/BiPDqv7oNdhF/m4vSsZnmU15aV+MH3PZ4mPyrso0XUCa2+XplI
 jbudaTXcX1DHJuqN1PN/lSfzXIVL8Yu5Fp2O6JOmjJRmOCriH9Q3n662M5JLLhRRcf
 noO0+6Takws51T/wuyrw9FlHXlQq7ZKJmXO2EN3Fx50zGmnrGcA0WP1zyLn7+h/fhg
 Bg1Pkb0GPeZWwncaASx7x98c1hxrLO4qy817P3EnYvhyxSqvnFsXEk+KQ0jolFK7vL
 P43oebIdrQa4w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Reported-by : E Shattow" <lucent@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: typo mstching
Date: Thu, 18 Apr 2024 04:30:49 +0200
Message-ID: <20240418023049.11207-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

%s/mstching/matching/

Reported-by: Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_var_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index aa8feffd3ec..ed53bcf3939 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -419,7 +419,7 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)
 }
 
 /**
- * efi_var_collect() - Copy EFI variables mstching attributes mask
+ * efi_var_collect() - Copy EFI variables matching attributes mask
  *
  * @bufp:	buffer containing variable collection
  * @lenp:	buffer length
-- 
2.43.0

