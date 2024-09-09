Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C454EECE587
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 20:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F291E88E1F;
	Mon,  9 Sep 2024 22:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725913282;
	bh=/UYLR301kifXvUyMbup+0AQu+gqioBnQvqpQQhw3gRw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kfmLCZXSTwlmdgPgHp6ak3NjINWbPTNt6rnvR5lfZidKI4nL8f1xa5PpN/4v6uNtX
	 rI8ZsXocIP0oWXU8I6DI/VGMe9fMKSZVzuZSYADTv6IbaOUGOJqDQGApUFUnUmUOC6
	 gpevJ1RxZPOyxFC5QAwA/qH3iYJq9Gsg987tsPd0B6JEl5XNToZ6hn5AF/d4IyojLJ
	 rcRE6l/yn0f4INScucI2zIaVMhDCpUbWv2FDlLTI0pgcTM7MVK0Cw9RVh7h/6VR6DN
	 2hkAagYWBaC487roFF480Q9GKkdjuG6BtBC+oVkyODfzqXAMrdLCLrjBHzEFAepcZd
	 rmkIrPwR/jtkw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C238288A1C;
 Mon,  9 Sep 2024 22:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725913280;
 bh=/UYLR301kifXvUyMbup+0AQu+gqioBnQvqpQQhw3gRw=;
 h=From:To:Cc:Subject:Date:From;
 b=L7jeTDD3T+z8Xydw7ovOJMAlfHvAzVRavH+mNWnzmETdnH8adSSWLVa0nm+qMyWcG
 RCQFwH1m2eJafB3M+mQSyC7d1YT+XygdsinlGXHf5ZlDP6LX2UrXMMGNet8NFhwezP
 Idrzj5nlh5lv0lQinfwZzWXduR9dgWzF37QFj5tZmZ4ux4eISZxMX/L0sDsQKVW2FL
 Zqe1/P+90g8R9CkmuVZqj2h6W+C72KhpqXXEhjAyfCYZfb0AJmbLcdaXGuMiGpf3Jx
 oNVoAXr2+RgCxkY6zGYrECy+e65YzAYiv60mESjvABPWy9nx+ZRc7rtWJcbhsWGN9x
 HX3E4aKdDEW5A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
Subject: [PULL] u-boot-usb/next
Date: Mon,  9 Sep 2024 22:20:28 +0200
Message-ID: <20240909202054.73857-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The following changes since commit d0f74bd417daf6492975ce346843ba0767caf51c:

  buildman: Support building within a Python venv (2024-09-06 12:45:54 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git next

for you to fetch changes up to e72e683e36a83214dbb2547d88d553b5fd816dc8:

  phy: test: Implement sandbox PHY .set_mode and DM test (2024-09-09 17:18:04 +0200)

----------------------------------------------------------------
Marek Vasut (3):
      phy: Extend generic_setup_phy() with PHY mode and submode
      phy: rcar: Split init and set_mode operations
      phy: test: Implement sandbox PHY .set_mode and DM test

 drivers/phy/phy-rcar-gen3.c     | 90 ++++++++++++++++++++++++++++++++++++++---
 drivers/phy/phy-uclass.c        | 13 +++++-
 drivers/phy/sandbox-phy.c       | 13 ++++++
 drivers/usb/host/ehci-generic.c |  2 +-
 drivers/usb/host/ehci-msm.c     |  2 +-
 drivers/usb/host/ehci-mx6.c     |  2 +-
 drivers/usb/host/ehci-pci.c     |  2 +-
 drivers/usb/host/ohci-generic.c |  2 +-
 include/generic-phy.h           |  8 +++-
 test/dm/phy.c                   | 15 +++++--
 10 files changed, 131 insertions(+), 18 deletions(-)
