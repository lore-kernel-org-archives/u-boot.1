Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE90CD1297
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B62083F4D;
	Sun,  9 Nov 2025 11:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WxfWDL/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C76D283F37; Sun,  9 Nov 2025 11:10:46 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1E183E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2B67B409F3; 
 Sun,  9 Nov 2025 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683035;
 bh=bUtYWfpfPm2R9wDVYOOgYWFUGyXyAkIcKT9q6k9qONA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=WxfWDL/cTm21d1z+/H0su6L/Z0cmnOWLzDLqCJnahU32usVM7kS8WDLKczEiyGMDU
 5TJ8syGVRgkSplkFnjY78NMpqREz6V9lcZzaEweRezNcih5g3GTyUbofvB5ujY7Zvv
 BpPdUMCXXj9ExaN2FwEt6sRRQ2J4N5hnyFjpJwnUPNbDw8bVLC7VrIxMcBllHKNi5c
 xktYPA9CBQmNNkc9skv2FTNVSoNdxFe5pQlF0mdRJgHS0YjYt+WevUhSnV50s2/njJ
 SzI2Q5NPNNx8qms/eq5v2hmB+P9n1e3dbE+Gfn4r6XLms8Z0Tpddb/LEconv1NrFQZ
 EwZw6VJYIhttaI0uDs+fT9E0erSh4rDSXZwk0ZyDGJsnpkwF7bulCoB516HVTtZ9zC
 nzcsD9SIbSaeaeBnZbvTThYzTsXkCCdBiU0acacznGdq5LKGvP6sLmZHOngjmEN0WW
 qV2reSZP8I02O3FTT5lFNIdj4CZnZuAftEC79gfNhzlyI/UQC37TLQr5znCku8wbfV
 2uve4tL4AXWLlb5OeMExt/U9iIjkbRsds45vXLh/IsnY+AFzc4pRhz86O/zCUz/KUQ
 X7BIxufeNm1YrXJyfFw1rCjvjvg++o+SjlI8DIMfiPw0492eNWHFvAioidojJ+gcji
 4wQYJvZR3EZAp2MmYJwldqJ4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 8/9] configs: CONFIG_CONSOLE_RECORD=y on
 qemu-riscv64_smode_acpi
Date: Sun,  9 Nov 2025 11:10:09 +0100
Message-ID: <20251109101010.306268-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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

For testing ACPI on QEMU we need a defconfig that supports acpi command
test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 configs/qemu-riscv64_smode_acpi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu-riscv64_smode_acpi_defconfig b/configs/qemu-riscv64_smode_acpi_defconfig
index e78e5ffb390..11592091443 100644
--- a/configs/qemu-riscv64_smode_acpi_defconfig
+++ b/configs/qemu-riscv64_smode_acpi_defconfig
@@ -1,2 +1,3 @@
 #include <configs/qemu-riscv64_smode_defconfig>
 #include <board/emulation/configs/acpi.config>
+CONFIG_CONSOLE_RECORD=y
-- 
2.51.0

