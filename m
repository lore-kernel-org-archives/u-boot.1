Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1ACC52D7F
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 21:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E781B87DB6;
	Sun, 11 Aug 2024 23:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723412440;
	bh=HJsLX+yVyuyk9sr47TkLQLjOLgjQoK/OixWVRJNj+2M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=shkkCd0Qe5VqH/+yRolL4p7bVUf/XeosxZn80Be2f2wR4XmGRZXUM/2UAvzFs8OLH
	 ruWm6HdIn/A6wdkIiE2jsk4Kvk2MmTWzLnf3UDyjbZZj+zTgIPJHxdtTD9uu0ZrPKX
	 PZWaftS5eDV9Lcn7p/R8oJWnTd1xD5qUJw6p3WYy6T8tnYczwcN/iLmvtI1Zd0vxIA
	 dULTe4mWS25J1KFFnussEfK+WHgTaEMA2HYWLZUAUWRLZe0WxcoUFFpLatV7ay4jyK
	 GguMPWr/PPu+n0OjubSG2krLcNcS7vHpWRhmrCdR2dySfU+oMHvGaIhq9SbXuMCzGQ
	 DvOcfcGcMywhg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C110F87A09;
 Sun, 11 Aug 2024 23:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723412440;
 bh=HJsLX+yVyuyk9sr47TkLQLjOLgjQoK/OixWVRJNj+2M=;
 h=From:To:Cc:Subject:Date:From;
 b=PPPDe079VzsfPAKOoti8WH7+O8oo492vYmZBucRj9PVhqt3XT9eMjIjp0FQaawG+X
 LNdxqOzHKzgpZUHsUKotR4g0xx2+0o/pL16bPC0MvrGNswtFnBR11iEm5ANB95yu8z
 w7azU2+kDpIAHn0MeKWfAiFcMKLR10JuQgqaq55cA1W/F5/dwZpqvDfg/mMloELjQD
 JxIriP9HAU9FI8ZyoGSv26xscDILJrIKK7VrbKVBL1o/b5Vb59165pm3yxk3EhtRve
 +aN3joyMB2rvB/VOQqhM9O0LIPHSXnrYbbLtdyI3gCuUc7hFWgu94KCrRzf6QX0Ku2
 bGqsvKQB2JURQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] u-boot-usb/master
Date: Sun, 11 Aug 2024 23:40:04 +0200
Message-ID: <20240811214017.73267-1-marex@denx.de>
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

The following changes since commit 7bd2559cb30a4e800db519e88a22a25f13c753ec:

  Merge tag 'tpm-master-09082024' of https://source.denx.de/u-boot/custodians/u-boot-tpm.git (2024-08-09 14:00:04 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to ef1e322f3e1d9a221a1ee6109f6571429ee9fb4a:

  usb: dwc3: support USB 3.1 controllers (2024-08-11 19:45:36 +0200)

----------------------------------------------------------------
Caleb Connolly (1):
      usb: dwc3: support USB 3.1 controllers

 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
