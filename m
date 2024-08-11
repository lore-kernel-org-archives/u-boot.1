Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B99C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 10:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A413F88580;
	Sun, 11 Aug 2024 12:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="C76DFRQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D3D88216; Sun, 11 Aug 2024 12:03:12 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by phobos.denx.de (Postfix) with ESMTP id 1821A882EF
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 12:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OdGcA
 oFk/PShFTyJDF/uU7cZ+1xGq+50aYUaSxoG5Gs=; b=C76DFRQ/zERL5KcS3r6FL
 g4oi+2nfhTu6xXDXsynPTf7l6pDp5HTnpvNIDG7xpbujrPFuZB/f15ponq1wV8KH
 q8TXSERCb++7E4EqEStl9pzIhcz9XcfsoknPTZfDLJAX/rxvhxJxZIDPjI7wL2Ie
 yNiTAgGTBjN/VrpZPZiUF4=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDXXxdQjLhm4hIOBQ--.43417S2;
 Sun, 11 Aug 2024 18:02:59 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: jonas@kwiboo.se,
	u-boot@lists.denx.de,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 0/1]     Add support for Cool Pi GenBook
Date: Sun, 11 Aug 2024 18:02:54 +0800
Message-Id: <20240811100255.1664095-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXXxdQjLhm4hIOBQ--.43417S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFyDWF1xAr1UKrW3CFyxuFg_yoW8JF15pw
 4kAr1rGFZ7W347trWaga43Cr4ru3Z2qFW5u34xXryxArySvr1DA3WqgFy7tayaqr9F9F48
 Arnagr1jgrWUZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRxR6OUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hU4XmWXzovLFgABsK
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

    Support for Cool Pi GenBook is landing linux-rockchip[], so also
add the support for u-boot here.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.12-armsoc/dts64&id=4a8c1161b843c366776fc872a6fe45b743b2983e


Andy Yan (1):
  board: rockchip: Add support for rk3588 GenBook

 .../dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi |  70 ++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |   7 +
 board/coolpi/genbook/Kconfig                  |  12 +
 board/coolpi/genbook/MAINTAINERS              |   7 +
 board/coolpi/genbook/README                   |  23 ++
 configs/coolpi-genbook-rk3588_defconfig       | 104 ++++++
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 include/configs/genbook-rk3588.h              |  28 ++
 8 files changed, 600 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
 create mode 100644 board/coolpi/genbook/Kconfig
 create mode 100644 board/coolpi/genbook/MAINTAINERS
 create mode 100644 board/coolpi/genbook/README
 create mode 100644 configs/coolpi-genbook-rk3588_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
 create mode 100644 include/configs/genbook-rk3588.h

-- 
2.34.1

