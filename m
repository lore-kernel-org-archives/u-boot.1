Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED964C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D429876DB;
	Tue, 19 Dec 2023 13:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aQwQ8ebr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1233A876B4; Tue, 19 Dec 2023 13:25:01 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E602D875B5
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2A310420F2; 
 Tue, 19 Dec 2023 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702988696;
 bh=pv+X1F127iY9iYgfogypPXLVh5tq5KbQBHOiFbbJmXo=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=aQwQ8ebri7DQJn0uTYdUXBHwRcv4uk9zA6uc67aPfy8tZjgvhxs1VLoraVn/FEl0+
 qSn176si0jl1hkZTAGZfPzL4ngAIqLXt0Lo1dw0VNwnD10RHLHFJabslOZBMm+MAsG
 BvDPsU2cfn9bI4Wj/+Fj0mTsjVF0UmTtkSznx9ZkGQUw8mEIIrjg11nbpvszDECOIQ
 OX34MSEm29e33ow5HW1IfEbZVmxYMwUMtHWegpCuAWms+39RiqFcCSuHykxHwYeC9y
 o1owDchRhtsh3PQLKyqPB9ER0C9iff0+Sb8KXb8naw+xSVKsyNjl9V6QjUXMmcWLxj
 BjfY81c4PCxcQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 6/9] risc-v: add support for QEMU firmware tables
Date: Tue, 19 Dec 2023 13:24:36 +0100
Message-Id: <20231219122439.31983-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
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

Enable the QEMU firmware interface if ACPI tables are to be supported on
the QEMU platform.

Enable the QFW MMIO interface if the QEMU firmware interface is enabled.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	no change
v2:
	no change
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index cdd0d0d95f..d5f302ffda 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select GENERIC_RISCV
 	select SUPPORT_SPL
+	select QFW if ACPI
+	select QFW_MMIO if QFW
 	imply AHCI
 	imply SMP
 	imply BOARD_LATE_INIT
-- 
2.40.1

