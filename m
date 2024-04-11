Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0061ACD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 05:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75921881C8;
	Thu, 11 Apr 2024 07:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="QHL2oh3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CCE87150; Thu, 11 Apr 2024 07:06:06 +0200 (CEST)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com
 [95.215.58.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34801881CA
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 07:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712811963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IUUYXVN3mzwX8BxGblUquqcQSrzKJLL2OveASMu8FrA=;
 b=QHL2oh3dgI60JHhgKBng1u8v/1O/4ROd/vVyEBez1xprlEzO/yOUNqxTXwTcmqYyF5x7YC
 b5NjrwXpFZlKJ8Bj9G2ZDolhKo3D/ClsGn3fT0H6oF0E86GrKfI9PYCH7rBK0PpCR/WQc9
 bH7nmW53lq1tAp/X+p5EAcBQOVx4FxEYJPuXLSaSpwrGBIVEzdUvedTWEGFF7TWeQFsXru
 +GHalIsM0HqslcgZlIQmqy0yzccKacBSw8cJQ4n1W5+vrwhybIbZYzICBFsy1T0DG3Z0Wt
 C00i2FAERLaaLO1iKmpeJP3QuEDH8BGtFZqgzgW129eocVasjcjWjbq/x2gsyw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 15:05:48 +1000
Subject: [PATCH] ubi: Depend on MTD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
X-B4-Tracking: v=1; b=H4sIAKtvF2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ND3dySFN0Uo1QLQ8NUQ/PkZAsloMqCotS0zAqwKdGxtbUAuXCeXVU
 AAAA=
To: Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712811949; l=851;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=w7S4ACvp0R03h7fSTwESarFfxxs2LkGLi2y5LsVOtuo=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABALE+dHJ+657x2hDU8H++8kmg
 hh8bYApAPK8fcg0NDXNbDsci8xOraBLIprh1BEVzbmvUQ8mSBbxPTxYzPljJ9DQUAAOmW
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

UBI required MTD to build correctly, add it as a Kconfig dependency.

Signed-off-by: John Watts <contact@jookia.org>
---
While working with UBI on my SPI NAND patch series I found it was
possible to enable it without enabling the MTD subsystem.
Add a Kconfig option to solve this.
---
 drivers/mtd/ubi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index 5783d36c04..fd446d6efb 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -9,6 +9,7 @@ config UBI_SILENCE_MSG
 
 config MTD_UBI
 	bool "Enable UBI - Unsorted block images"
+	depends on MTD
 	select RBTREE
 	select MTD_PARTITIONS
 	help

---
base-commit: 777c28460947371ada40868dc994dfe8537d7115
change-id: 20240411-mtd-d2e811e17cc8

Best regards,
-- 
John Watts <contact@jookia.org>

