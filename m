Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB291D3C907
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 10:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0D88929A;
	Sat, 19 Oct 2024 12:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BUGTFnhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5E5892AA; Sat, 19 Oct 2024 12:48:07 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by phobos.denx.de (Postfix) with ESMTP id 16A93891A4
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 12:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=UV6HQ
 vHcahpf1EhNU9beLulGI1CW7rsTRyPJKzJM3FY=; b=BUGTFnhTWfHtILyHctccs
 T5gb2KhR8jERyN3l9dL+uoXX27bU0WXLDJkLuOqQ9D9w7G1GLExojaw/+I0xCyaP
 VGNeB6H+Ho/7+RuXfnFerQDlaRz5vIpsYBu65aJUB5tFShy7U4ExUJLINpgjz9Zm
 7spQXYwDkeAif7Bh5VLFvg=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzsmtp4 (Coremail) with SMTP id PygvCgB3rSFYjhNnVFBeAg--.30214S2;
 Sat, 19 Oct 2024 18:47:56 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, dsimic@manjaro.org,
 Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 0/2] Add support for Cool Pi GenBook
Date: Sat, 19 Oct 2024 18:47:27 +0800
Message-ID: <20241019104749.47301-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgB3rSFYjhNnVFBeAg--.30214S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1rGF43uw4DKF15GF43trb_yoW8Ar45pw
 4DZr95GFZ7W347trsIq3Z3urWfu3s29Fy5Cw1xXr1UtrWavr1qywsrWF1fta4agFnrtF4k
 AFs3KF10gr4DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pikRhAUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gF9XmcTenrzUAAAsn
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

Changes in v2:
- Cherry pick it from https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
- split the dts to a separate commit
- rename to genbook_cm5_rk3588
- move readme to doc/board, and write as reStructuredText format
- alphabetically reorder
- update doc/board/rockchip

Andy Yan (2):
  arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 GenBook
  board: rockchip: Add support for rk3588 GenBook

 .../dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi |  70 ++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |  19 +
 board/coolpi/genbook_cm5_rk3588/Kconfig       |  12 +
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS   |   7 +
 configs/coolpi-genbook-cm5-rk3588_defconfig   | 104 ++++++
 doc/board/coolpi/genbook_cm5_rk3588.rst       |  69 ++++
 doc/board/coolpi/index.rst                    |   9 +
 doc/board/rockchip/rockchip.rst               |   1 +
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 include/configs/genbook-cm5-rk3588.h          |  28 ++
 10 files changed, 668 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
 create mode 100644 board/coolpi/genbook_cm5_rk3588/Kconfig
 create mode 100644 board/coolpi/genbook_cm5_rk3588/MAINTAINERS
 create mode 100644 configs/coolpi-genbook-cm5-rk3588_defconfig
 create mode 100644 doc/board/coolpi/genbook_cm5_rk3588.rst
 create mode 100644 doc/board/coolpi/index.rst
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
 create mode 100644 include/configs/genbook-cm5-rk3588.h

-- 
2.34.1

