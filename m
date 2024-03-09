Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EE5C54798
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 16:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F58887D46;
	Sat,  9 Mar 2024 17:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710000574;
	bh=cKXLrbp6FQzKKZs5IRQZoYmExzCZhUueAQ9pjBqZ798=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PTZdkDnG2sX9tBNntt44oBvAusHDa1qnGxxnGW3WWnZHxofEWmee75dAzS5STHZP8
	 0v8rZgkQPqmelFrgpzh5QTpw6GBYDOUQtQu66pL1wgXkDFMaNb8xHkouX/5PIUwxZW
	 x+DSWgBcFqkvxtPzTVw/JfYh8jvQjeeNxbvr6hINkyjbJ0iwm/3WVviSEG0hapMMQH
	 fPL7x6rbte0w7CF/n0x6CXW0oMpWuTEN65nqBE3rv/CE/LdbYsAJ4B1fRgKIHsZWGD
	 OWrr5yMcD26E04IO4LQHXvfq1pHUsucNHEmZ7GlN+XsVpNe4R+4YdmPT7qYj4SZsmw
	 Ty3PksKnLn/Tw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2C653876D3;
 Sat,  9 Mar 2024 17:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710000573;
 bh=cKXLrbp6FQzKKZs5IRQZoYmExzCZhUueAQ9pjBqZ798=;
 h=From:To:Cc:Subject:Date:From;
 b=Tt6Whc0BVhMzWIsWsGujnq7oS+Ta7Oh9GOBDwKMmfDAY7aIC106g3bVbv827bnm9o
 S924V05i2UeXPHXOR7at4tN1r1Ok/5VfpG9zgeAoxmrfIq9/uqFwEVe3GUaFaHnb/f
 DXpS3rqK93INTudQQ1gQ0XJ3DreR/AqJ440YwV8MBt1OgsBZrvPoSt4RBctbIogXXp
 uvpE24FhZGYI73oQFg/AHiTbT6KAkcCCJoeN3MbF/r/ukBSV8/jX7BZnegqkoZz4Bm
 xzrp6AEllfbVXDUaBm0gpkKnlc4km5DwHfGej5kurwCZg9Hu4RevGKrefi+lGH5FlG
 /sRXD8G5YngWg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PULL] u-boot-usb/master
Date: Sat,  9 Mar 2024 17:08:37 +0100
Message-ID: <20240309160912.11194-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Singular quirk DT property rename. Fix for master branch.

The following changes since commit eac52e4be4e234d563d6911737ee7ccdc0ada1f1:

  Merge patch series "ARM: renesas: Rename R-Mobile to Renesas" (2024-03-02 14:30:25 -0500)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 52378ba4963f5f4ab2786f3d0b4e929cd6cebe22:

  usb: xhci-dwc3: Fix support for dis_enblslpm_quirk (2024-03-05 01:04:21 +0100)

----------------------------------------------------------------
Jonas Karlman (1):
      usb: xhci-dwc3: Fix support for dis_enblslpm_quirk

 drivers/usb/host/xhci-dwc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
