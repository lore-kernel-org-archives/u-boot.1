Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9538ED132B5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165AB88D35;
	Mon,  4 Nov 2024 13:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="bmO2I+7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E8B288D90; Mon,  4 Nov 2024 13:23:27 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by phobos.denx.de (Postfix) with ESMTP id 6C58E88D14
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=cw0VM
 2G3ctw96aWxVh8jbPZNbOSuOym+neg/9u5aKEM=; b=bmO2I+7kty8O6mVuBLzD5
 f+PK1yigedd5OGy0NED2eQD2Du2Pvmrp3YRMexZ8hOm6wghKf9sjRYJccY/AGPy7
 Cr0dX8WcV9anK/zzWfyRstm4KbFoT5l3PU5BYXb59W1sOJ6KvkS7TvyQ7aRJrbqm
 6RMdXJ5J5iB+VRR08y7ASs=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDXoOOtvChneoIYBA--.28161S2;
 Mon, 04 Nov 2024 20:23:13 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de,
	jonas@kwiboo.se,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v6 0/3] Add support for Cool Pi GenBook
Date: Mon,  4 Nov 2024 20:22:57 +0800
Message-ID: <20241104122307.439776-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgDXoOOtvChneoIYBA--.28161S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1rKFWUXr1fuFy8KFW8Xrb_yoW8tw1kpw
 4kAr95JFZ7W343trs0qas3urWfu3Z2gFW5C34xXr17trya9r1qywsrWFW3ta4agF9FyF4k
 AFZ3KF10grWDZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsa9cUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwGNXmcotTJ7MwAAsh
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

Support for Cool Pi GenBook is landing Linux 6.12-rc1, so also
add the support for u-boot here.

Changes in v6:
- avoid re-define CFG_EXTRA_ENV_SETTINGS.

Changes in v5:
- Fix document isn't included in any toctree error ini rst doc

Changes in v4:
- Fix a underline too short error in rst doc

Changes in v3:
- Remove upstreamed dt in genbook-u-boot.dtsi
- Remove MMC releated config as there is no SD-card on this machine
- Enable LED config
- Enable rk8xx pmic
- rename defconfig to coolpi-cm5-genbook-rk3588_defconfig
- redefine BOOT_TARGETS

Changes in v2:
- Cherry pick it from https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
- split the dts to a separate commit
- rename to genbook_cm5_rk3588
- move readme to doc/board, and write as reStructuredText format
- alphabetically reorder
- update doc/board/rockchip

Andy Yan (3):
  arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 GenBook
  rockchip: Make it possible to define per board boot_targets
  board: rockchip: Add support for rk3588 GenBook

 .../dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi |  20 +
 arch/arm/mach-rockchip/rk3588/Kconfig         |  19 +
 board/coolpi/genbook_cm5_rk3588/Kconfig       |  12 +
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS   |   7 +
 configs/coolpi-cm5-genbook-rk3588_defconfig   | 101 +++++
 doc/board/coolpi/genbook_cm5_rk3588.rst       |  68 ++++
 doc/board/coolpi/index.rst                    |   9 +
 doc/board/index.rst                           |   1 +
 doc/board/rockchip/rockchip.rst               |   1 +
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 include/configs/genbook-cm5-rk3588.h          |  19 +
 include/configs/rockchip-common.h             |   2 +
 12 files changed, 608 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
 create mode 100644 board/coolpi/genbook_cm5_rk3588/Kconfig
 create mode 100644 board/coolpi/genbook_cm5_rk3588/MAINTAINERS
 create mode 100644 configs/coolpi-cm5-genbook-rk3588_defconfig
 create mode 100644 doc/board/coolpi/genbook_cm5_rk3588.rst
 create mode 100644 doc/board/coolpi/index.rst
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
 create mode 100644 include/configs/genbook-cm5-rk3588.h

-- 
2.34.1

