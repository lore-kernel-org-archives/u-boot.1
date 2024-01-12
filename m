Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EADC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BD4879B0;
	Fri, 12 Jan 2024 09:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NH5oEAUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDDF887985; Fri, 12 Jan 2024 09:53:23 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C8CA879A4
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705049598;
 bh=Yf7WKBT8WQBO+qp5nxBimPO/fDLJ2uJY2V6HMkP1xHY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NH5oEAUIuU70mJlEYzsefLOJYZSV8tXELX+jmgteEu2hhMXwaHu4bACAtdyQmkBdk
 u0HwPF0BL/XB11AGgUYbnybJxkRQcLK+l+hm9piDf9u/8HYw/Al5wPlpSfN759FHFW
 nS405YaK8F8CWgDLAVMisT5x7q6fpyvTdfpgoIYZtR7IA3IGAERzI4slLKzQYKFSCK
 jfAmGPN7F2Nm4nJU+n/hnK04hRWXIThEL+7XlU+UKmbu0+8nGKQr+6OL/HNTWNWoS+
 qfUglJJPCl259EgbM3ZI7cKiLcuz1Njlw6JBg8cyhyhaSk0a0cySKYn3Pn1wEva/Pf
 Lxbgs9+7ctqOg==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 62739378202D;
 Fri, 12 Jan 2024 08:53:18 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id F09619ED7CCE; Fri, 12 Jan 2024 09:53:17 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v4 3/7] board: ti: am62x: am62x: include env for DFU
Date: Fri, 12 Jan 2024 09:52:18 +0100
Message-ID: <20240112085317.1866449-4-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112085317.1866449-1-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
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

Include standard TI K3 dfu environment

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

(no changes since v3)

Changes in v3:
- Add dfu via environment rather then config headers

Changes in v2:
- Minimize config changes to just DFU configuration

 board/ti/am62x/am62x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index e53a55c38fb..0651b9cd7cb 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -1,6 +1,7 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/default_findfdt.env>
 #include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
 
 name_kern=Image
 console=ttyS2,115200n8
-- 
2.43.0

