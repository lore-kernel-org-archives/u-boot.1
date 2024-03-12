Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F403DC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 23:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9812887F7F;
	Wed, 13 Mar 2024 00:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XAs0oPtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0597887F65; Wed, 13 Mar 2024 00:37:13 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6CA87F0E
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710286615; bh=Zbu3U9h69SULTvKlQ5q5oLhzvLp1tbS+3gMbeW8yjIw=;
 b=XAs0oPtTJAzIML91aGlS2C17InmKalIp4oN5JgaM6pwo5HOYpatbLxHQuaPLZ2enrAL03kmcl
 YhLtoBU9dSVDPL9lM5Mnq1wmtBiRqCt+Ft/4vq9K3yCeFm23OQ/+Imvy+NVK9ldJ52G8ySM9SJe
 KYCCth8kqxZ8o3zYPMI+fVmOITmeAgdwKjzyiVtTXoOIkAdHjcY6oGA/8hCC3ktpXd4QZrfz0Mh
 mJEGXNrqHErD99xfFhKma1sKahT77yGh1N8gQwEpKhmDxIek5gQfOFwAq/SBeTwrZEVf35/RloV
 I90bPc9Y1yJZi8rJBvr/5GIxL1XUQZ0dkc+Hgsh4PDyQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 02/12] board: rockchip: rk3399: Add myself as reviewer to
 MAINTAINERS
Date: Tue, 12 Mar 2024 23:36:12 +0000
Message-ID: <20240312233636.1428749-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240312233636.1428749-1-jonas@kwiboo.se>
References: <20240312233636.1428749-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f0e716e6c04c5b3059360c
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

Add myself as a reviewer for RK3399 boards that I have and can help with
review and testing of defconfig and device tree changes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Collect r-b tag
---
 board/pine64/pinebook-pro-rk3399/MAINTAINERS | 1 +
 board/pine64/rockpro64_rk3399/MAINTAINERS    | 1 +
 board/rockchip/evb_rk3399/MAINTAINERS        | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/board/pine64/pinebook-pro-rk3399/MAINTAINERS b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
index 287ed4346050..2cafd1a41e58 100644
--- a/board/pine64/pinebook-pro-rk3399/MAINTAINERS
+++ b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
@@ -1,5 +1,6 @@
 PINEBOOK_PRO
 M:	Peter Robinson <pbrobinson@gmail.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	board/pine64/pinebook-pro-rk3399/
 F:	include/configs/pinebook-pro-rk3399.h
diff --git a/board/pine64/rockpro64_rk3399/MAINTAINERS b/board/pine64/rockpro64_rk3399/MAINTAINERS
index d9e11f4bab34..42084aef0ebd 100644
--- a/board/pine64/rockpro64_rk3399/MAINTAINERS
+++ b/board/pine64/rockpro64_rk3399/MAINTAINERS
@@ -1,5 +1,6 @@
 ROCKPRO64
 M:	Jagan Teki <jagan@amarulasolutions.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	board/pine64/rockpro64_rk3399
 F:	include/configs/rockpro64_rk3399.h
diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
index f45f81623a3a..7815ea9ff07e 100644
--- a/board/rockchip/evb_rk3399/MAINTAINERS
+++ b/board/rockchip/evb_rk3399/MAINTAINERS
@@ -86,18 +86,21 @@ F:	arch/arm/dts/rk3399-orangepi*
 
 ROCK-4C+
 M:	FUKAUMI Naoki <naoki@radxa.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/rock-4c-plus-rk3399_defconfig
 F:	arch/arm/dts/rk3399-rock-4c-plus*
 
 ROCK-4SE
 M:	Christopher Obbard <chris.obbard@collabora.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/rock-4se-rk3399_defconfig
 F:	arch/arm/dts/rk3399-rock-4se*
 
 ROCK-PI-4
 M:	Jagan Teki <jagan@amarulasolutions.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/rock-pi-4-rk3399_defconfig
 F:	configs/rock-pi-4c-rk3399_defconfig
-- 
2.43.2

