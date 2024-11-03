Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ED1D1118E
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 19:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A7B88EF5;
	Sun,  3 Nov 2024 20:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Td1WHZGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A7C588EAF; Sun,  3 Nov 2024 20:01:21 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAD288A4C
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 20:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1C4C63F9DA; 
 Sun,  3 Nov 2024 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730660478;
 bh=Ya0Euwq58uKg5YYmLHOVCLSmEI/RUsaI+EU1jbTV64Y=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Td1WHZGmDLupqcIld3p2+tGQH3dyw6CdFNn/iK/4g6Tv50m9pW5XgHs74yGWdDyu8
 dcIXNg1Oizj2qHOAnPlJCY0SGtYTAtyL5Je/6UZ3w3T4+ovbrSFoAUI5uikyqJjA7Z
 juyy+3hIEzRWzZ1Ffm5kHu8/T8Fz7XFnM8r1TrXbenCIy2Y3tFyNkde+pPUpxyhRXw
 F8mm/6oB3TLRnS8f0eVjk9GYxnJoMG0JieJZgdl+RZawdAOrs06lV19cLTupsUFIZq
 885uJ7RhHGn+eQEo2pUkvaf3jvS479zcatcVRdzlZNWym16Wi5pu6hcv3xzH3JgP5x
 a4AcZWd/6CYmA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mips: malta: set MIPS_RELOCATION_TABLE_SIZE=0xc000
Date: Sun,  3 Nov 2024 20:01:13 +0100
Message-ID: <20241103190113.161289-1-heinrich.schuchardt@canonical.com>
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

MIPS_RELOCATION_TABLE_SIZE=0x8000 is too small to enable UNIT_TEST.
Increase it by 50 % (16 KiB).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b2d0aaadb2a..fce56cb332e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -319,6 +319,7 @@ config MIPS_CACHE_DISABLE
 config MIPS_RELOCATION_TABLE_SIZE
 	hex "Relocation table size"
 	range 0x100 0x10000
+	default "0xc000" if TARGET_MALTA
 	default "0x8000"
 	---help---
 	  A table of relocation data will be appended to the U-Boot binary
-- 
2.45.2

