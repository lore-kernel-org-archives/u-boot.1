Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11738C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE98482B18;
	Sat,  7 Jun 2025 14:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X4BvkfI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD1881F0D; Sat,  7 Jun 2025 14:03:34 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4240481F0D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 14:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6449F4B66C; 
 Sat,  7 Jun 2025 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749297811;
 bh=CESkNIe1xIzpMv76k8Lbwa9JcW8V3fAoxIyg1DjjCxM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=X4BvkfI2JDfz0f049xkDn8rkoOZPZkxw+mFqVlyQHFXK2u3/MfwJeWA6EoDEQOuiF
 9JrtgLc+n1GVpO574r/jQvm1v8gDLRMXZNysOr3pdwCD7KNqQR1mNQqtTSSM0JzPwb
 QyDfMux2AW/ZjyySXs++m3CUrukghVTdctikqvad3fKE7wYNZeDmFTjslPGyuOOGF+
 6pkCLnO7c8Naw3ItvnZboo36XRRJM8WW4oxcUKJchuecdzRR7Rv0Vp6Ms1xUS+FGB7
 RQor0bKp5vI2zRVAMyiqvOCD2tG+S5fd2gn9Z6XcMes+Wo7D7rbdiujLaBRtzQvIcn
 ZDs/4ngix1E4Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] cmd: remove duplicate DHCPv6 Kconfig definitions
Date: Sat,  7 Jun 2025 14:03:02 +0200
Message-ID: <20250607120303.210990-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
References: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
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

Remove duplicate definition of

* DHCP6_PXE_CLIENTARCH
* DHCP6_PXE_DHCP_OPTION
* DHCP6_ENTERPRISE_ID

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ed741d43cea..c335eceea63 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2004,23 +2004,6 @@ config BOOTP_RANDOM_XID
 	  Selecting this will allow for a random transaction ID to get
 	  selected for each BOOTP/DHCPv4 exchange.
 
-if CMD_DHCP6
-
-config DHCP6_PXE_CLIENTARCH
-	hex
-	default 0x16 if ARM64
-	default 0x15 if ARM
-	default 0xFF
-
-config DHCP6_PXE_DHCP_OPTION
-	bool "Request & store 'pxe_configfile' from DHCP6 server"
-
-config DHCP6_ENTERPRISE_ID
-	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
-	default 0
-
-endif
-
 config CMD_TFTPPUT
 	bool "tftp put"
 	depends on CMD_TFTPBOOT
-- 
2.48.1

