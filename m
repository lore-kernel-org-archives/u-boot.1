Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB32FC36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 07:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F346C819D2;
	Mon, 31 Mar 2025 09:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N/bQjACm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FFD81E60; Mon, 31 Mar 2025 09:24:24 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFF2817C4
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-051.46.114.pool.telefonica.de
 [46.114.110.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8E6623FFC7; 
 Mon, 31 Mar 2025 07:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743405861;
 bh=GO0Cj1xrl0thzVTDXkkfcZrdKOp49ilil6evMlI7bko=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=N/bQjACmZMujngd6KUOarlxO0vpfTAOhQyqAnKRjDgrbt3HrvMYFcuS891JnIUA9d
 KJN9r8OytllR3nXbSveF0NcxCSXfa98PpNwC2eBEeAPeo7uI+tKNxcjf+QH5OP9KZs
 8iBv/YkvANReCqfGemcWj9OUmYM0MDb7RyER+x6cnuQQMAbv68JW8LxMjcRvhhYYYw
 /ZmRRjVCDF38vSSF2zgKQvqdW0IAOR6+cJrWRcMaAQd65r0SNQswKOlg2YIhWQed4B
 oBhJVQzg7CQGci408U6eF53tYvQbMFiAlkACZcqcYzdJly9O13dIsLaibXMYI+sAoq
 tTBy88F4fQVYQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 2/8] riscv: dts: jh7110: add DeepComputing FML13V01
 device-tree
Date: Mon, 31 Mar 2025 09:24:04 +0200
Message-ID: <20250331072410.8662-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
References: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
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

Add the u-boot device-tree include needed to support the
DeepComputing Framework motherboard (FML13V01).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
v2:
	no change
---
 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
new file mode 100644
index 00000000000..ab882d07f6f
--- /dev/null
+++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
+#include "starfive-visionfive2-binman.dtsi"
-- 
2.48.1

