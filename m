Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFAEC369D2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 09:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595798214A;
	Sun, 20 Apr 2025 10:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BNjshjwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB36A82119; Sun, 20 Apr 2025 10:59:58 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D444582105
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 10:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-177.46.114.pool.telefonica.de
 [46.114.111.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4F4BC40445; 
 Sun, 20 Apr 2025 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745139594;
 bh=cayPxbPcy3PPDYFxWeLPbCgHfQT6SnsfIdsjiz0Utzs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BNjshjwA02XwJvArfzS1yoYrmANOt6pl4Uao1ooZ3c97ChqBvuNtzvdDE5lf1G7NN
 HRjH8VVpvCLHtw/bf8Nm8WVOTosl9rsYuYzz00zVUUOrI5HWjPQZWlw4W6pmS6Uor1
 +Q/wS7jb5EBLuGgP35x1RAevFuo2o9ja9BtLRshJMOmLzXrlNMDwqnlu5vnWeMZn7U
 SZLKqjQhnJ+lX/i4K8rXsmmR7E/sHIUxV2aBTdV5KpiP7ZGNc93yKVs+EDgvk+tKar
 Iq9gPU1Z/uwerAGSWVkDmv9wvRsV/W2yJ0Ju4NyN15v/HmZH/ckzmCxFfzCIX5RZcq
 6Fk3eNOiI8HxQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] MAINTAINERS: add qemu-riscv* defconfigs to QEMU RISC-V
 'VIRT' BOARD
Date: Sun, 20 Apr 2025 10:59:29 +0200
Message-ID: <20250420085929.36226-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
References: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
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

Add the follow board to VIRT which otherwise would be unmaintained:

* qemu-riscv64_smode_acpi_defconfig

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-riscv/MAINTAINERS | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/board/emulation/qemu-riscv/MAINTAINERS b/board/emulation/qemu-riscv/MAINTAINERS
index 3d7453f1b43..d75d1b5f190 100644
--- a/board/emulation/qemu-riscv/MAINTAINERS
+++ b/board/emulation/qemu-riscv/MAINTAINERS
@@ -4,9 +4,4 @@ S:	Maintained
 F:	board/emulation/qemu-riscv/
 F:	board/emulation/common/
 F:	include/configs/qemu-riscv.h
-F:	configs/qemu-riscv32_defconfig
-F:	configs/qemu-riscv32_smode_defconfig
-F:	configs/qemu-riscv32_spl_defconfig
-F:	configs/qemu-riscv64_defconfig
-F:	configs/qemu-riscv64_smode_defconfig
-F:	configs/qemu-riscv64_spl_defconfig
+F:	configs/qemu-riscv*
-- 
2.48.1

