Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F07C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 18:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0DE88C33;
	Fri,  2 Aug 2024 20:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SM2PcYKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2F288C1C; Fri,  2 Aug 2024 20:00:38 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877FF88C01
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1722621629;
 bh=Dyrp6uhLKN0QldW31HmEtkOQpMFZ6hpaOVX26QLwO4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SM2PcYKtlUps2GRvFaK3MdlB+Va4nTUzDm5k4DJZZGAtIuGxW+ak9hQie+gz9Fdhz
 oJeZzPtCvvb7MYxoo1WfkompGXBK98JAOTxCouLgm/fyi4ZIwU9/MsDCHyHLsVcZ1e
 aDK12wERHwKvflu31GDwUJmJeZpaNC9cbDG2LIYDkrhTggoTyxEkhmp5WHiemi46Ib
 Nwf7uBM15m5zsdFuYGGqgJSxq5w5l4U5VBK4eKCmdTL5itJhIirN/jQxRp6Y0sEdXB
 mVq2dlMXVYUStRaC8GBKapkHnte0KlglXgviHafMeiAFCcLGhVFZSmitGE+FTP4Lol
 ZE3OKZS8uZRUg==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id D1D003782220;
 Fri,  2 Aug 2024 18:00:28 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id D700E4800FE; Fri, 02 Aug 2024 20:00:27 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 7/7] MAINTAINERS: add TCPM section
Date: Fri,  2 Aug 2024 19:59:37 +0200
Message-ID: <20240802180027.139193-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802180027.139193-1-sebastian.reichel@collabora.com>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
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
index c2832345ab18..2556f2b9c57a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1712,6 +1712,15 @@ F:	common/usb_kbd.c
 F:	common/usb_storage.c
 F:	include/usb.h
 
+USB TCPM
+M:	Sebastian Reichel <sebastian.reichel@collabora.com>
+S:	Maintained
+F:	cmd/tcpm.c
+F:	drivers/usb/tcpm/
+F:	doc/usage/cmd/tcpm.rst
+F:	include/usb/pd.h
+F:	include/usb/tcpm.h
+
 USB xHCI
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
-- 
2.43.0

