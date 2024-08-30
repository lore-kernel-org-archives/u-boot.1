Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FBCCA0EFD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 18:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07BCF88D39;
	Fri, 30 Aug 2024 20:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UYL0W1o4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C2588CE1; Fri, 30 Aug 2024 20:23:38 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C42C488D0F
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 20:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1725042211;
 bh=l4Xv+BpciSynhuTx8UEne0BTouVROBqh6qBZSM+vxDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UYL0W1o4NZhlaBtYLODbdfSwh7XtIGgedRniT3h3Guxsx5nvkdGDv89PNipbkiZAj
 RCoGes7HeksvXiW5Oh2BIkCA7ofBrUL/QfoyeqDhmQbGhJozWAkjoFAIeIJJr2cBYf
 vd9CTFyH6K+Co7O6c04kmqNa7JmyvEC5zWTPFWgQ28t2Uy+DIDOE074kt20ZKAeeHY
 R35HpvriYTx7UXdoemLnlge5fLQSeQPvFApBdqgQwch2yANg0K6I8+ZnfoUGdpGk6S
 4ABYvSyUwCInRGu6x63SSLabLR26rhCK5pPUZBUajy3J5sL7ChYYIkG4jFNCJbjnVt
 QmtLFKRFxpnNw==
Received: from jupiter.universe (dyndsl-091-248-208-243.ewe-ip-backbone.de
 [91.248.208.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 36CD917E10DF;
 Fri, 30 Aug 2024 20:23:31 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id A542A480100; Fri, 30 Aug 2024 20:23:30 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 6/6] MAINTAINERS: add TCPM section
Date: Fri, 30 Aug 2024 20:22:20 +0200
Message-ID: <20240830182330.49528-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830182330.49528-1-sebastian.reichel@collabora.com>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
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

Add new section for USB TypeC Port Manager (TCPM) support, which
is needed to figure out cable orientation of USB-C plus and to do
USB PD communication.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2050ae24df82..f3cf84d20dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1721,6 +1721,15 @@ F:	common/usb_kbd.c
 F:	common/usb_storage.c
 F:	include/usb.h
 
+USB TCPM
+M:	Sebastian Reichel <sebastian.reichel@collabora.com>
+S:	Maintained
+F:	cmd/tcpm.c
+F:	doc/usage/cmd/tcpm.rst
+F:	drivers/usb/tcpm/
+F:	include/usb/pd.h
+F:	include/usb/tcpm.h
+
 USB xHCI
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
-- 
2.45.2

