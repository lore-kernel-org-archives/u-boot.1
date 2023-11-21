Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2255FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A2DC87606;
	Tue, 21 Nov 2023 16:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MQ/QdYQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8748760E; Tue, 21 Nov 2023 16:28:11 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA0787608
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 76DA93FB5B; 
 Tue, 21 Nov 2023 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700580486;
 bh=ykpG/bePU3fSsjflGDsZ98om98V5c34MEHv+5FFQLc0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=MQ/QdYQ0gTkYfwS5w0NwGAHKIn/PIGoFY2EZruIKU6juDgb09McV2+NXnLghxYdi/
 vPZG8g1/aqRjvpIjWpXH5R3ixIo1Us4wclRxqCQqoVjLPNek+zmxmJkUkb7j905TuP
 ZvhvyQNwbOjDrjBwlWAq2ZQ8UhlhZmE/5BzLxhTxrJZturjTAxzTwxHno50UGkZKAk
 /kkXpHRBi2m5nscO6+FYkyoc03kms2AxgwAg+1DrJm6fQKFJhrqvLt9VHgwUuCYBve
 GEj66NuD6oRLIk6KueS+fA9IS36syptY+qa1c31DJtL1nNKYwAY8LhZRDZkRjdy2z4
 HUMZAkjJdlBiQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 6/7] riscv: allow usage of ACPI
Date: Tue, 21 Nov 2023 16:27:39 +0100
Message-Id: <20231121152740.24783-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
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

Select CONFIG_SUPPORT_ACPI to allow usage of ACPI tables with RISC-V.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2e0528d819..c23d57e4c4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -108,6 +108,7 @@ config PPC
 config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
+	select SUPPORT_ACPI
 	select SUPPORT_OF_CONTROL
 	select OF_CONTROL
 	select DM
-- 
2.40.1

