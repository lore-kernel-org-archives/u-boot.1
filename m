Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD03CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF8B83AEC;
	Fri, 31 Oct 2025 20:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UM3jT2rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B04783AF6; Fri, 31 Oct 2025 20:59:39 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D72E83AED
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B775540969; 
 Fri, 31 Oct 2025 19:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761940776;
 bh=cEGAL5vidKERfh+oR6O1JtMZ/0rK5GexRaBT8xo+M0o=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UM3jT2rqheFirnDgOqEhmHhoF89klI1jx8C6iwfb1XnYmZ/TZ2ooV6nFgpoBvUMB9
 jpeGWo72GJWo9xctwIOtnHW6f2lGdXHcoOApGvibShcslP4K8zsslRI4tAD9EIH4Fx
 nztnuDeUp8wdEUAh3PqYwZdMqOLxFeJ5rit7gSHmEtpNKNj71/cA/vZCSGqhWAxXpH
 6IjLkConCR90iudBJ60kd7m68hl+E9k3xsZtrkQmBZK6+NG71OYGUXh94Bdfpvhcuz
 GEjzOl1+T2n+eYj8nMBYytbEk20Fvb55F8M8U6CxcczdqNu02bh5SKYNQZ49IC8B/T
 3m18Jq7CVRnaCb5HA4qG7LD+nytwjaZteAvWVJnsUa4yrmNzGpsvk+WcyBDh3YwNGi
 dswrt68grP7EHx7jUpcwWy4lzusWJx/SyGq64Ge7a0Gn+QnHgFxfw2V0Qd0cn0yAEq
 gT+eERgqyt4ZJ5DRb9r87mwBYpJPpLUKq6aT4ubDAvxVlcM7qofPOgQYlYqNZysCkT
 P9ur/HZVBiYTgWCbZHp9o4taUb/iuKto81i5du/M4tWtzOkF/2aiKz6aMxfhFcw39N
 tXd6FACP61T5b80HDoMs++mJPicMbDcgdo5z2OZN1t3hYjHp4R860w+Aws2eO5DvZI
 se6uhQKomkc2U4JqQEQC/XuU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] configs: CONFIG_CONSOLE_RECORD=y on
 qemu-riscv64_smode_acpi
Date: Fri, 31 Oct 2025 20:59:31 +0100
Message-ID: <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
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

