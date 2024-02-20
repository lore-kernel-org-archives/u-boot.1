Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49618C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624F087B3D;
	Tue, 20 Feb 2024 09:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708418169;
	bh=ECfNEPqBeTTRUpe2x96+N7/a+BCrpsUbVJyo19i+DSM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ae68csNPjHsdx8EOzw4tH5nuWwRP/h0PpZn7dRI6xV0toshA52ITtesi9zRnKPrKq
	 PfwbhwVEKCbSRICKIKoaWKmnZ3d19Wv/7Jbsj8/rI1ltMfjX7AvrACLlUUfjS8w7F6
	 PqO/De4eltPDWvShhMYYahGHi6UEnHcewT7fdl+mlX6mPxcrpmw+20koj2q175jV/6
	 5GblZqEIJ4/gODw0NIvDoMnSTfIpPkJvakDzeUzTc5JShgQoakGzMcPO/X7V0g1gYJ
	 xWXkhP7qlcybI2JH6uU8HBoT48WWRcLo/GEDH5X1xZWtavI+9vHEcSPgIBF/UnJoN8
	 o9FY+wlSx4JSQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 493BD87F7B;
 Tue, 20 Feb 2024 09:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708418167;
 bh=ECfNEPqBeTTRUpe2x96+N7/a+BCrpsUbVJyo19i+DSM=;
 h=From:To:Cc:Subject:Date:From;
 b=l7Nifz82HT+bzckGdMrhM4kS6LOfZ4KyiJoOTAAJLTiY3Txt4Bx0fR7fEuKSzCxaS
 GjcaYfimkgPSZQoT2yt5DGhyjiEhozeCVfE30+1+tWirYDNLL2xx97+/r6k0LnX2+v
 bo6z0EXciYD3Xc4cioHcE/7NKNmMlozNvePQyYDgJExhq1c7Z0IE+RhR9mhyGX79aR
 DLFjg3mjoYoLHMuSKAb4NxIJaqnQwySo3tho4/MggokKAMmqxwIFDB4LKmG5w5nUE/
 9f30fsJBF0aJECMKoLXgpMvv6FiiQcLiWZsBMFoki9x6RGK5nvmyhGt1zEDHJ2p5gD
 vsKzMSRCJtgIw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>,
 Shantur Rathore <i@shantur.com>
Subject: [PULL] u-boot-usb/master
Date: Tue, 20 Feb 2024 09:35:43 +0100
Message-ID: <20240220083555.34347-1-marex@denx.de>
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

The following changes since commit 3e6f2a94bfc25f1782ce2d45db27f47ec781feb1:

  Merge tag 'u-boot-imx-master-20240219' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-02-19 08:55:17 -0500)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to d9a20fea2ba53db3a999827d3e50e181d5513e09:

  usb: ehci-mx6: Add i.MX93 support (2024-02-19 20:08:51 +0100)

----------------------------------------------------------------
Mathieu Othacehe (1):
      usb: ehci-mx6: Add i.MX93 support

Shantur Rathore (1):
      common: usb-hub: Reset USB 3.0 hubs only

 common/usb_hub.c            | 6 ++++--
 drivers/usb/host/Kconfig    | 6 +++---
 drivers/usb/host/ehci-mx6.c | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)
