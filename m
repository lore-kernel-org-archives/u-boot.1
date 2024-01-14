Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30741C4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 13:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88A687873;
	Sun, 14 Jan 2024 14:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SlUlOTYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BC287985; Sun, 14 Jan 2024 14:18:42 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96148785F
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 14:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 21762416CD; 
 Sun, 14 Jan 2024 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705238318;
 bh=E3XIUUH4UMe10eBclJ4wO+Va+AP8V33SCxE1LM07c+U=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SlUlOTYOeAvP6GQ0PC1TJrnKtm8Mwn5Dqbo11ll8dvFrI758T0GEXpCrLb7U0k3PM
 E8/UboDdnQpBuexS1wTRh1M2sahQZ2aprDGYojuGKxN8TUon07/vK2KD+tfS4fEGFM
 4FW1YqYPVqrfvqfDWtfzI1hlgi5OHJgAhJmq5M2m+5xi7x6C/aCYTM1E4FTLJyZSaB
 vGyuTu3iFdR34uffCd7LI0YJKO22D21yPz3myleLCje4plp47Pm7+9Bt4o9XcQJQl2
 xFBIb8i2oRUh8IjZKOBOltErIoQqsYgAsIYPvlL6J99NOrqptYbwyf/xgZPTxuSLmY
 QMNYVSXrFQFiw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Faso <erer1243@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/5] doc: update requirements.txt
Date: Sun, 14 Jan 2024 14:18:18 +0100
Message-ID: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
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

Update all Python requirements to there newest version.

Update the CSS overrides from Linux.

Apply prerequisite changes:

* convert Sphinx paths to str (patch copied from Linux)
* add sphinx_rtd_theme to the array of extensions instead of setting
  html_theme_path
* include Sphinx theme.css and pygments.css in our CSS override

Heinrich Schuchardt (4):
  doc: add sphinx_rtd_theme extension
  doc: update theme_overrides.css
  doc: import Sphinx theme.css and pygments.css
  doc: update requirements.txt

Oliver Faso (1):
  docs/sphinx: Explicitly convert Sphinx paths to str

 doc/conf.py                           |  2 +-
 doc/sphinx-static/theme_overrides.css | 47 ++++++++++++++++++++++++---
 doc/sphinx/kerneldoc.py               |  2 +-
 doc/sphinx/kfigure.py                 |  2 +-
 doc/sphinx/requirements.txt           | 43 ++++++++++++------------
 5 files changed, 67 insertions(+), 29 deletions(-)

-- 
2.43.0

