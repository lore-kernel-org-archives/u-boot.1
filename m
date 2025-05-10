Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76653C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 18:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A47D8283E;
	Sat, 10 May 2025 20:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDEF82893; Sat, 10 May 2025 20:42:45 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641A7826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 20:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from s2.ai6fs.net (unknown [IPv6:2602:ffc5:20::2:8012])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C4DC0B4C2CC2;
 Sat, 10 May 2025 20:42:41 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: E Shattow <e@freeshell.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Developer List <u-boot@lists.denx.de>,
 Leo Liang <ycliang@andestech.com>
Subject: [PATCH v2] riscv: dts: jh7110: override syscrg assigned clock rates
 with defaults
Date: Sat, 10 May 2025 11:42:27 -0700
Message-ID: <20250510184227.38768-1-e@freeshell.de>
X-Mailer: git-send-email 2.47.2
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

JH7110 drivers are missing support for CPU frequency scaling, so override
upstream device-tree to use default clock rates for syscrg. This override
duplicates a portion of jh7110-common-u-boot.dtsi file planned for removal.

Signed-off-by: E Shattow <e@freeshell.de>
Reviewed-by: Leo Liang <ycliang@andestech.com>
---
 arch/riscv/dts/jh7110-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index a9e318c4a31..4249fee3346 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -107,6 +107,7 @@
 };
 
 &syscrg {
+	assigned-clock-rates = <0>; /* cpufreq not implemented, use defaults */
 	bootph-pre-ram;
 };
 

base-commit: feb55165233623648cb0a74953735b00ec6e322e
-- 
2.25.1

