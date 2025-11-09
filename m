Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3CFCCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2531883E8A;
	Sun,  9 Nov 2025 08:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Kqk3rFVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3944983EA0; Sun,  9 Nov 2025 08:05:29 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E77A683E7F
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C9562403F8; 
 Sun,  9 Nov 2025 07:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762671926;
 bh=GTUCPSpEAx8etcAe31AbSzuTg/zINNFmHJI3M8zN8lg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Kqk3rFVYqoUFuYK2id17+B7MnzLVjTElwIuSBf5+pkGvVAbGz4Xfrtv1TKS6nTUwI
 q5JZRllvirhmEHI19x5t325p25ddtyK8p0FNMhoAYNKbJigOb0amkcL+4oVR0j4nlK
 ReX/LNATqQT7gf6Cv1VdlQLI+6tfp+eZ/lxOCbFba45TMSD8XoSVuF4B1hoI6PXKka
 Vt4rwvLugXMaXi3J4MGQSHTZhPjC4qx78fHM7mKOqUeqaK8K9CDlcuymB90vK44oqR
 8PQZ2QTobIppv7S9Mj4R9FhVQs3Cr9kIixd/xWDM9GLtfYh6WDwLXlmHY0gTcpA9xw
 haeb8v4Q8hqNnE4Can0V2+7LnI2fQb/DrMDwL0KKw0XiQ84ZFn/F2IGOnZ+5TzQ4Hu
 DxCuGoo2DPNCwlItz8Gi1o0Q0MyCxFYw3J/FmCzwPAs5iu7khfz0D2cnWExiwuMF1y
 OckoYnTifPp15ZQja+1vmeGOQBlF5TLhUFlU0lfx2u9U+wYUniJl7M6r6TLQclOyIZ
 By4CvnJRWy/lHX0L/yHoVeD5OD8kdkC8qSnfeFrOR0/7WKYjFr8pLbeBK8qIw/jUNo
 UXcl8ucjKHGz76GT64RkoZsx+nPy/psEQSrNdGHLU9E2p0YmkrEA/eG4CpgkOUnRg9
 Mc4SEeBRI8CzYy/Fu4UNPH40=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Janne Grunau <j@jannau.net>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dm: typo programmaticaly
Date: Sun,  9 Nov 2025 08:05:21 +0100
Message-ID: <20251109070521.142477-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

%s/programmaticaly/programmatically/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/dm/root.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dm/root.h b/include/dm/root.h
index 286bd9a2ddd..61a61e1ce46 100644
--- a/include/dm/root.h
+++ b/include/dm/root.h
@@ -114,7 +114,7 @@ int dm_extended_scan(bool pre_reloc_only);
  *
  * Some devices may not be visible to Driver Model. This weak function can
  * be provided by boards which wish to create their own devices
- * programmaticaly. They should do this by calling device_bind() on each
+ * programmatically. They should do this by calling device_bind() on each
  * device.
  *
  * @pre_reloc_only: If true, bind only nodes with special devicetree properties,
-- 
2.51.0

