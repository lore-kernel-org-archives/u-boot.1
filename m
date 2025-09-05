Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667D9CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 05:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD3E83807;
	Fri,  5 Sep 2025 07:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF028386B; Fri,  5 Sep 2025 07:05:08 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9547837F2
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 07:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6F92DB220345;
 Fri,  5 Sep 2025 07:05:04 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] riscv: dts: starfive: visionfive2 depend on
 SYS_CONFIG_NAME automatic dtsi inclusion
Date: Thu,  4 Sep 2025 22:02:32 -0700
Message-ID: <20250905050301.900528-5-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905050301.900528-1-e@freeshell.de>
References: <20250905050301.900528-1-e@freeshell.de>
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

Rename visionfive2 per-cpu jh7110-u-boot.dtsi to
starfive-visionfive2-u-boot.dtsi for inclusion by search order for whole
starfive_visionfive2 target. There is expected to be support for multiple
CPUs and boards, so let's use the automatic dtsi inclusion that is a
better match for this.

Depends on patch: "scripts/Makefile.lib: add CONFIG_SYS_CONFIG_NAME prefix
to dtsi search" [1].
1: https://lore.kernel.org/u-boot/20250826214708.309271-1-e@freeshell.de/

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi}  | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename arch/riscv/dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi} (100%)

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
similarity index 100%
rename from arch/riscv/dts/jh7110-u-boot.dtsi
rename to arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
-- 
2.50.0

