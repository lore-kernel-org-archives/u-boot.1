Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD1BD1D87B
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F4F8899C;
	Tue, 15 Oct 2024 17:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CMhj/T84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D11288902; Tue, 15 Oct 2024 17:27:28 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B6B88A9D
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1729006039;
 bh=u+WFhFSS4OKAd/EZY80LVbhxiSDy33RoT9ma03L3aGs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CMhj/T84Fi0erC69c8g8RPPpFHJi1yIc4qyq/UlkqapqB6GsJA+1N93IVIiw0+D1a
 8Ki1nIHkL4/SBZwGxI2IofmctVH3JG0jC8Duf0Lwgtd4nmFTHpx8jI+Emkzvun++rg
 wpMZKizWezbdVgy5876+EWd1DlM8bqQY7kS6y2jkdSM3I0mQ4PFJOZfinnXZXaT9lD
 3K/a9U6rD8PBbhHYLQ7k7dfeqr4eI/WE69on0tHPx0SIfN8q5lQJiN3dDwPLp7cf53
 h5DOXGzmPGHWzK0u3ysPCfTSrcm0j4L/7RF5NxC30p602Fi9G+yCZVHd+rRq/qWDIe
 EHyh27TCxWsfQ==
Received: from jupiter.universe (dyndsl-091-248-191-104.ewe-ip-backbone.de
 [91.248.191.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A4CDD17E362D;
 Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 240764800FF; Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v7 6/6] MAINTAINERS: add TCPM section
Date: Tue, 15 Oct 2024 17:26:48 +0200
Message-ID: <20241015152719.88678-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015152719.88678-1-sebastian.reichel@collabora.com>
References: <20241015152719.88678-1-sebastian.reichel@collabora.com>
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
index 09298e6bc86c..f2e535901066 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1743,6 +1743,15 @@ F:	common/usb_kbd.c
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

