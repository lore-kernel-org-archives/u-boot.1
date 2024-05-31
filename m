Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F36CC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2EB88805;
	Fri, 31 May 2024 17:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IQrAO8Wx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12389882CD; Fri, 31 May 2024 17:11:02 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCF8887DB
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717168253;
 bh=cnwRhyh4dkIAMEkBfrP7jjL8X8cI/wXM/DQ9/lj67/Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IQrAO8WxGpP05lMVZYgPYnPIWYjAZ4c0Nzsf/YT03O86ltDvqHKDfbmEQH5zOl/QF
 dooRt6cKSEoGdk9z5AKMJmRAqQM1/enfNKAEKper9Q7M3lMA7eOP3f6EfkjyF0+ik8
 oaGGrgvqghuxDqzjtLIn/xY9oID6X3eyduZYBY4GBzoHITqJPDIRrJsjfraNMsV6MS
 3tNxIlRHQVNfKBZ0L3i/CILbJZhSSJMyF9oZ/NKdMX1I+0gUP0h5bIQNvP4/Wla2OG
 l17VoGTTHvKoURdJyIY95q2vN3F5ugY43ON4zZqymlnrBz8P4LzuuBeGGDr464UVif
 WJTyrcGHAzBAw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C9D1137821E0;
 Fri, 31 May 2024 15:10:53 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id E7CC74800D0; Fri, 31 May 2024 17:10:52 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 5/5] MAINTAINERS: add TCPM section
Date: Fri, 31 May 2024 17:08:17 +0200
Message-ID: <20240531151026.84846-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531151026.84846-1-sebastian.reichel@collabora.com>
References: <20240531151026.84846-1-sebastian.reichel@collabora.com>
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
index 638b2fdd442f..dbd81dac7155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1684,6 +1684,14 @@ F:	common/usb_kbd.c
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

