Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95358D1358C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B10E88F0A;
	Mon, 28 Oct 2024 07:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WNtTMO/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CAA88F2A; Mon, 28 Oct 2024 07:21:48 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B80988360
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 02D9E3FD2D; 
 Mon, 28 Oct 2024 06:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730096506;
 bh=BhseiKZZHt7kfpVWmG20C2t7g5FRNKnN4gn8hcakMKE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=WNtTMO/J50zGq455G+yLNeafq5+TQK6EpFGpYFDqywpUG/FoHHZ95cEewnDudjn4n
 EC+m5bHTdJOK39vAb6czpYwj9gmTXopbFn3+uTKeewgk8zMq4ORZEXlpJxyetIeKAV
 HBSRNFZ0UjrHO/4nC/A7/6JIURUJ3R5JsNMPj8jfXBrSseuqSAzg94h5Vs3iEpgN9E
 SRjG9TGKm6jCRCr7r0OsH2nqTzG5mnkpwKnSh/s5svNpDPsbnDPSdvv57AHiox6Z95
 E6oSx4mfaIPVAaRhyFAZBxmmDTvL+NgwscHVBk66KdGgWV997+nI/e5j+khGngF8yh
 sBUQO9WZY0oDQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lmb: remove __maybe_unused from lmb_map_update_notify
Date: Mon, 28 Oct 2024 07:21:36 +0100
Message-ID: <20241028062136.10742-1-heinrich.schuchardt@canonical.com>
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

Function lmb_map_update_notify() is always referenced.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/lmb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index eec99c185ee..802fdb84489 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -38,9 +38,7 @@ static bool lmb_should_notify(enum lmb_flags flags)
 		CONFIG_IS_ENABLED(EFI_LOADER);
 }
 
-static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
-						phys_size_t size,
-						u8 op)
+static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op)
 {
 	u64 efi_addr;
 	u64 pages;
-- 
2.45.2

