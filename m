Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA700D58D76
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62CBB893D3;
	Mon, 25 Nov 2024 19:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732558165;
	bh=jJ9KfoH7unZ577LkaCT8eqXXfCqp0o+6pUTsjY+al9w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Kcb6uIshYEZv8C7W8ERlOW1HVD7nTnq6X1+2Bz3JpDH9YyYuCwD0T2HJLO79RiseH
	 EfvesCTxaqKFh828dZVwbzZU2MvcBKnroHOh7MJMNPGT3WcpCOaAvwIH9ObcmzBHWx
	 E9HWkj+gu0gmFHl/HWvedEGx4T9G6VHTQooqMq52Z9l3nFmc0XeIjStVypBLcXsZY4
	 wbhZO/cMEwCreuhXMEs2SWZJFS9wVSxHENw8Kn7UZVI3lAea8o17kZETnKSSH7OGUX
	 sTCMNpmQvnOePuVHSRjzTw1/mE66cuuDRSJhtpxrw1dlgdy3UH7EtEQe349Cazlr1Z
	 N5GGb3IWBdtIw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2EC3488FED;
 Mon, 25 Nov 2024 19:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732558164;
 bh=jJ9KfoH7unZ577LkaCT8eqXXfCqp0o+6pUTsjY+al9w=;
 h=From:To:Cc:Subject:Date:From;
 b=J6MN5ZMHG9sjHZZ3wtB2owuNax6TPkkK9JSjzjPR8ogR5X1HyZIH7eP33Dtcnl0mv
 jnA2wWMt8XCyoxl5QXP4LSzO/MyEU1tUPUmfkwbSUh0O70NLkpgYNPhPb676748PEJ
 Pi+Yo50ejrePKYSGA4S1syKUR18Yt2/BgG8c72KP5qE1SokRoY4uTd6octjDmgP43q
 /fTJ/PoTDCKbTOexz+kBUQc2m70nk8WUfHAK6IbcSBB6p39gBzLHMgN8ttDYAqcoEi
 qYXvrKeB4JLXUpQWiaL2xZ/yQVLdWiuiwwrGxho4K+Tl0LK3VJxVUKEhVMaH0zZvwk
 v45/1WBN0SjGA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PULL] u-boot-usb/master
Date: Mon, 25 Nov 2024 19:09:00 +0100
Message-ID: <20241125180907.11213-1-marex@denx.de>
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

The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941c7:

  Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 57e30b09fcfc88da72c310f979b35ed99a9b277c:

  usb: onboard-hub: Bail out if peer hub is already probed (2024-11-25 05:40:49 +0100)

----------------------------------------------------------------
Venkatesh Yadav Abbarapu (5):
      usb: onboard-hub: Add reset-gpio support
      usb: onboard-hub: Fix the return values of regulator APIs
      usb: onboard-hub: add support for Microchip USB5744
      usb: onboard-hub: Add i2c initialization for usb5744 hub
      usb: onboard-hub: Bail out if peer hub is already probed

 common/usb_onboard_hub.c | 195 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 190 insertions(+), 5 deletions(-)
