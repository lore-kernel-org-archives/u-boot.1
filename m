Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A378C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A32C88554;
	Tue,  4 Jun 2024 18:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PerkrJxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38A188520; Tue,  4 Jun 2024 18:35:57 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF058852E
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717518949;
 bh=i6+3s90dSBjA0spECnP3tgEPF7uHfXAYYh6qlGNwcWQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PerkrJxjl3unY4XuqolaV3R+ZboFe3SaxZl21SVlIwUMz1nMQGN5zcM1WcBp6YyAd
 b0I8puDb+3zdJGqUcSznMvr2sXZmMWpG4O348dD0U4j8V2O5djCflitI2q0l9/CGCk
 zEQMrh9XsNI/PMVlcTMYwulhGXOLJmBA/ZDh0zae8P+W1pPlJnrd+sQpDWlv8f+7Pb
 0ANY05s1mfdhiHMIgXh3WZwLKyU68TyGvZ6W8cdkQBCQJwAqSNplN2ggnOPtSkW/+O
 akWg7wFWtrmaZ0PCTIxCEGG4j0rIrWqQbfTZp73BbgRPaaA/HzF0ljmI4ka81inNvY
 Gk9VUX2upGbGw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3523A3781104;
 Tue,  4 Jun 2024 16:35:49 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 56FB84800D0; Tue, 04 Jun 2024 18:35:48 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 5/5] MAINTAINERS: add TCPM section
Date: Tue,  4 Jun 2024 18:33:57 +0200
Message-ID: <20240604163546.60225-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604163546.60225-1-sebastian.reichel@collabora.com>
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
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
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8afd7d51e2e..dc9e7112aebf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1679,6 +1679,14 @@ F:	common/usb_kbd.c
 F:	common/usb_storage.c
 F:	include/usb.h
 
+USB TCPM
+M:	Sebastian Reichel <sebastian.reichel@collabora.com>
+S:	Maintained
+F:	cmd/tcpm.c
+F:	drivers/usb/tcpm/
+F:	include/usb/pd.h
+F:	include/usb/tcpm.h
+
 USB xHCI
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
-- 
2.43.0

