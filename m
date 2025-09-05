Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA49CA1010
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 05:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDEA983807;
	Fri,  5 Sep 2025 07:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FAB8385B; Fri,  5 Sep 2025 07:03:52 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37AE2837F2
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 07:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id AFF83B220355;
 Fri,  5 Sep 2025 07:03:47 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: 
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] riscv: dts: starfive: prune redundant jh7110-common
 overrides
Date: Thu,  4 Sep 2025 22:02:28 -0700
Message-ID: <20250905050301.900528-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

There are more than a few additional JH7110 CPU boards that may soon be
upstreamed. Each new variant supported by U-Boot has the burden of adding
a per-dts stub file for automatic dtsi inclusion by the build system. Also
i.e. the JH7110S CPU board introduced by StarFive is to be supported by the
same U-Boot starfive_visionfive2 target. Let's prepare for and clean out
(remove) per-dts file -u-boot.dtsi automatic inclusion stubs for all dts
that exist in dts/upstream/src subtree.

The (optional) last patch in this series anticipates additional CPU models
for starfive_visionfive2 target and depends on adding
CONFIG_SYS_CONFIG_NAME to automatic dtsi inclusion order [1].
1: https://lore.kernel.org/u-boot/20250826214708.309271-1-e@freeshell.de/

Changes since v1:
- PATCH 1/1 "prune redundant jh7110-common overrides" update commit message
- Add patch "sync visionfive2 overrides with upstream Linux for-next"
- Add patch "visionfive2 depend on SYS_CPU automatic dtsi inclusion"
- Add patch "add CONFIG_SYS_CONFIG_NAME prefix to dtsi search"
- Add (optional) patch "visionfive2 depend on SYS_CONFIG_NAME automatic
dtsi inclusion"

E Shattow (4):
  riscv: dts: starfive: prune redundant jh7110-common overrides
  riscv: dts: starfive: sync visionfive2 overrides with upstream Linux
    for-next
  riscv: dts: starfive: visionfive2 depend on SYS_CPU automatic dtsi
    inclusion
  riscv: dts: starfive: visionfive2 depend on SYS_CONFIG_NAME automatic
    dtsi inclusion

 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 99 -------------------
 .../jh7110-deepcomputing-fml13v01-u-boot.dtsi |  7 --
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  7 --
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |  7 --
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |  7 --
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  7 --
 ....dtsi => starfive-visionfive2-u-boot.dtsi} | 82 ++++++---------
 7 files changed, 32 insertions(+), 184 deletions(-)
 delete mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 rename arch/riscv/dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi} (54%)


base-commit: 76b8edbc732e327d1e56f08c641f51fdefdbff06
-- 
2.50.0

