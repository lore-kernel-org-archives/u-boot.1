Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F75EC369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 09:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA528206E;
	Sun, 20 Apr 2025 10:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="U+Xh/qeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1743C820B7; Sun, 20 Apr 2025 10:59:56 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326D382075
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 10:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-177.46.114.pool.telefonica.de
 [46.114.111.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3DE2E40442; 
 Sun, 20 Apr 2025 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745139592;
 bh=m23fMOs2Ka/CXqJ82zt6lQsvgEDSNYpYMpsKfeo/sOU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=U+Xh/qeRMjHXgYB9Cw8nz5BjgL9pq3jrYeJ/yE8HsKGdaLXh+vCcX38qQf4VeLVq9
 9i48DpfPz+5FR/6BTxhTVFdDf2MQF8RJUT3Bg85qymnbPeNRVNI01kltE6rUovge4D
 FHKl23D4V2pejkfWho/onM1P11rYhJ8dg46XdjkwCockNdhAhYgVEfW03Xu7I9yq34
 D8CTw3TCaOLj/K+97RNc8RXvFMEvoeSZSygW9OesMqB5BNcTBv53BtjZLk+q3GQmM/
 3nLHBZ6JoZaZzcwDs/LWzvS7XVLmjZqksQ/cKDqs55+5RRNieMjXHciED0+fRsMR+D
 oeNCMuxuhsTqw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] configs: add qemu_arm64_acpi_defconfig
Date: Sun, 20 Apr 2025 10:59:26 +0200
Message-ID: <20250420085929.36226-2-heinrich.schuchardt@canonical.com>
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

Add a qemu_arm64 variant that supports ACPI.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/qemu_arm64_acpi_defconfig | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 configs/qemu_arm64_acpi_defconfig

diff --git a/configs/qemu_arm64_acpi_defconfig b/configs/qemu_arm64_acpi_defconfig
new file mode 100644
index 00000000000..f85f2913530
--- /dev/null
+++ b/configs/qemu_arm64_acpi_defconfig
@@ -0,0 +1,2 @@
+#include <configs/qemu_arm64_defconfig>
+#include <board/emulation/configs/acpi.config>
-- 
2.48.1

