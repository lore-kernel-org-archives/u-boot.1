Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC3C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3EA81E5A;
	Thu, 27 Mar 2025 16:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4BD81DDF; Thu, 27 Mar 2025 16:33:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B324981E92
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF80176C;
 Thu, 27 Mar 2025 08:33:40 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D2A3F694;
 Thu, 27 Mar 2025 08:33:33 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 07/18] net: sun8i-emac: annotate fallthrough
Date: Thu, 27 Mar 2025 15:33:02 +0000
Message-Id: <20250327153313.2105227-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
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

The Allwinner sun8i EMAC driver uses an implicit switch/case fallthrough
when setting up the MAC/PHY communication protocol, to handle the case
when RMII is requested, but would not be supported by the hardware.

Add our "fallthrough;" statement-like macro before the default branch in
sun8i_emac_set_syscon(), to avoid a warning when GCC's
-Wimplicit-fallthrough warning option is enabled.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/sun8i_emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 0da182d9f4c..8433e7db265 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -335,6 +335,7 @@ static int sun8i_emac_set_syscon(struct sun8i_eth_pdata *pdata,
 			reg |= SC_RMII_EN | SC_ETCS_EXT_GMII;
 			break;
 		}
+		fallthrough;
 	default:
 		debug("%s: Invalid PHY interface\n", __func__);
 		return -EINVAL;
-- 
2.25.1

