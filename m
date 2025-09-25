Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED09CAC5AA
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 05:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C1A836C8;
	Thu, 25 Sep 2025 07:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FE183700; Thu, 25 Sep 2025 07:34:20 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB3C835C9
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C324DB2203DB;
 Thu, 25 Sep 2025 07:34:16 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [RFC v1 3/4] riscv: dts: Add placeholder files for pending upstream
 Milk-V Mars CM and Mars CM Lite
Date: Wed, 24 Sep 2025 22:32:07 -0700
Message-ID: <20250925053233.1874027-4-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250925053233.1874027-1-e@freeshell.de>
References: <20250925053233.1874027-1-e@freeshell.de>
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

Create placeholder files for Milk-V Mars CM and Mars CM Lite in
dts/upstream to placate the build system. Required when building on dts
that have not yet landed in devicetree-rebasing, adopted as dtsi includes.

These files are empty and should be superseded when devicetree-rebasing
release candidate for Linux 6.18 is sync'ed.

Signed-off-by: E Shattow <e@freeshell.de>
---
 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts | 0
 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts
new file mode 100644
index 00000000000..e69de29bb2d
-- 
2.50.0

