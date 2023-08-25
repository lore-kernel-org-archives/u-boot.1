Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C0DC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 08:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F3085E73;
	Fri, 25 Aug 2023 10:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692953876;
	bh=fVOb3gDxsCWfa4c3cej4L7jbPS1LoK/AsRwZlRjDlUI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QHkdo2J+ccM6iv7YECs2SMBNw0/y9YyNdjMIUFQn59LH83JBgg4UetDnh1F5esU+7
	 oxyd6tJgOIvajeYc2UW6CWKgp1P7qrOhLWj1UAIcsa0kJiO5ECVwpM0gUZpgRyYo73
	 AArVkbV7Pt0iG1JRF9HNa94wvXVCYuJ9I6VQH6vdx5z2hYA9AX69fH2HuiviKT8P0m
	 LY7xwgWKrHTJAhswAP6hEnvXYnU6nYtk8vVLc4DE6rpABdbA/lMZBWJJeuKRBnOI9A
	 RlHdEWTp9iyn9Uzed0d9ycp2BuNbHZP+O44zjZHoyDubKjM8CBoAsScVeVPP7BPM0d
	 TM0K4TDJpLzuA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CBA048063E;
 Fri, 25 Aug 2023 10:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692953875;
 bh=fVOb3gDxsCWfa4c3cej4L7jbPS1LoK/AsRwZlRjDlUI=;
 h=From:To:Cc:Subject:Date:From;
 b=bzAbPMMD2dNxsrxKdipCDHAdqvpijInRnFESY4Vpl8ZCNNtIuDazaiSNoIR6ABNwc
 JDyj9EbPJKl/a5qpOGnLROC8iIO+Fdlz7BKX8Bd0Iyga1iaK9eFFy+aQZO1t6abPtg
 a4FsG1psPX/lwk++zPqdrU4DwVyBWjV8oS36ytvutc++WopsjO+Oe47CfIRFtQoY5/
 d9XBqOFWk9Ldo6XXAda7FMgeBIZN2FwLGqXi1JmAmLsiF38tB8jGMLXB+teeIEnshp
 Fc28jHTDEEz8Do86c3/RwYTNbVHsQcEymXTDDYXEch+DZ1zXQfOngqZIQYv4+zrA+F
 Ug0JiKQIMCgEw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
Subject: [PULL] u-boot-usb/master
Date: Fri, 25 Aug 2023 10:57:40 +0200
Message-Id: <20230825085740.8172-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

The following changes since commit 291055efee4e1ae4ad0b62393256514a4e76cb1e:

  Merge tag 'doc-2023-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi (2023-08-23 11:03:46 -0400)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to e3380e1c1a88af454c1a41b6b63a8822e57f9a45:

  phy: phy-imx8mq-usb: clean up clock code (2023-08-25 02:36:19 +0200)

----------------------------------------------------------------
Tim Harvey (2):
      phy: phy-imx8mq-usb: add vbus regulator support
      phy: phy-imx8mq-usb: clean up clock code

Venkatesh Yadav Abbarapu (1):
      usb: dwc3: Fix remove function if there is no ulpi_reset gpio

 drivers/phy/phy-imx8mq-usb.c    | 69 +++++++++++++++++++++++++++++------------
 drivers/usb/dwc3/dwc3-generic.c |  3 +-
 2 files changed, 51 insertions(+), 21 deletions(-)
