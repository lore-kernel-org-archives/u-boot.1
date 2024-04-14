Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F0C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 18:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA384880FE;
	Sun, 14 Apr 2024 20:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713120370;
	bh=8SwtFoQdPp3WVoT6YMraTMBi8dZNs8+MAX529Uj160k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BkTKW30SotzwvTUStF7pBBk4IebJobdK9i2cqTc8SirpIpvspFcgvFhIFFHQNlaSQ
	 isb7yhqWZlSQ3D1uopzlpQ/sTAtXOu/oY0ImAQ5ug1+UbFjA/Xvd+BTRQxFamkq2fB
	 TE6uJi6ZRnKCLuIXGCSdaj6q9PKYozPEZtdJAfPzj9ksSmeX5eElZSmycWCLMKu496
	 OcM6opfrhSsoBZj0y6urEkwbZA/THafLLRjygTisuLR3gz6iSK2cgjinLPBPNtOg7j
	 DXkV/MAcSLQfKFhB4K5dSB4pitjdxgCwJ3tTIzpWiKRpq93hvi14xkDIeDbq4OVP0r
	 QWDIUJtCoK9pQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8561287FC1;
 Sun, 14 Apr 2024 20:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713120368;
 bh=8SwtFoQdPp3WVoT6YMraTMBi8dZNs8+MAX529Uj160k=;
 h=From:To:Cc:Subject:Date:From;
 b=UF3TtgUT04EDzkeQMiABy2LUjq8nWEOfh4LJ3b3HgknzfWdFEpnpTxoCShQ2TJbmI
 R5ABMMcXRhZBd+BBChHGyuTYpiLMPxMZgDr6kUN8b9A59/bWjDBUwYQOsHr4s6fsFa
 Tv2IUW0ytIyANgvfBbauw361i1Yp5rNAH35To42tMtz2MW8+yT+4vzKtrCUgIO4RGG
 8qd2JYvaW8Odr+xaiZDvWYc1rvqigLN66ZQEghVdJvAgSciDOVB20eI2CmHS74VW3q
 FhaIrFjC8P5sImX2T09SE3QK40XmO6oIYTPskU+E3Ri9dMrTxy8D48vjJcbJHlEFPY
 oR7zSoHStO9Vg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Janne Grunau <j@jannau.net>
Subject: [PULL] u-boot-usb/master
Date: Sun, 14 Apr 2024 20:45:17 +0200
Message-ID: <20240414184549.147802-1-marex@denx.de>
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

The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea1a:

  Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-04-02 22:37:23 -0400)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 63f6a449bffe46beca89580d3efa48e5d041025c:

  usb: kbd: Add probe quirk for Apple and Keychron keyboards (2024-04-12 14:53:13 +0200)

----------------------------------------------------------------
Janne Grunau (6):
      usb: xhci: refactor xhci_set_configuration
      usb: xhci: Set up endpoints for the first 2 interfaces
      usb: xhci: Abort transfers with unallocated rings
      usb: Add environment based device ignorelist
      usb: kbd: support Apple Magic Keyboards (2021)
      usb: kbd: Add probe quirk for Apple and Keychron keyboards

 common/usb.c                 |  70 ++++++++++++++++++++++++
 common/usb_kbd.c             |  59 ++++++++++++++++++--
 doc/usage/environment.rst    |  13 +++++
 drivers/usb/host/xhci-ring.c |   5 ++
 drivers/usb/host/xhci.c      | 126 +++++++++++++++++++++++++++----------------
 include/env_default.h        |  11 ++++
 include/usb.h                |   6 +++
 7 files changed, 241 insertions(+), 49 deletions(-)
