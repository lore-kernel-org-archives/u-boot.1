Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61C2C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C36887C9;
	Fri, 31 May 2024 18:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D4oUUwst";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lb2W2SJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF5D887E6; Fri, 31 May 2024 18:47:57 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375B3882F1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 18:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VrTZL6LB6z9sbC;
 Fri, 31 May 2024 18:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717174074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gX7uLYOloRIe8BrEQX51fis1Y0xP3S8b6RJmcerSvNw=;
 b=D4oUUwstViJZDPPfqN7Jp9cfLg/2loSBn+LsKKl/pMan6t+2H9csUvWm9eQM1HVML8U5Pw
 OvYFZ3hHj5WVg3ecjhQWKBQ9KQCL9cEdneeSWdKF2z24kn3uCw8UND4BBhBq9mWTmFlfBs
 fj1D1COo1nOi7ro1nCzYjmKLpLhheb8YAbgVYAw8V9jL28A5TOw0zMaYTEdrRvBjQKcJwA
 PB6jfv4LLBCMN55IXTr0sJPpnqryL3mEh0GRJKRtoJGKysT1XPB/wuTCoGyP2DXgfde7V+
 lc2MLe7wQubCd7blXe9Ef9BkrSUlbLuiWk+q8413n+VsKIqfhYZyNH7YlwaXZw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717174073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gX7uLYOloRIe8BrEQX51fis1Y0xP3S8b6RJmcerSvNw=;
 b=Lb2W2SJukr8n7386PT8GqIa/WhrBKRTQjj9PJkpJj0J24Ta6OC/RNUO126T7hKaHS+9U6R
 JBV5CDnKt5peC6GhUsL4gte1L1KFxsqm6fprOZLVNiGITdOXMyB+K9D7NPEI/Q7CE6iYom
 Kbr/WB3bqWwmIZyFqbQozqWfxVHzPxkxnlsKQ5PswgBBC2CnMqzBNnrHxy28B4UoVPF8S7
 LJsJFFTzo9uhRza+B7YpVsehN1S68BYM3pGOaRTHxSqvEfe/Q9TTQTxLQ+UEryba20tUgI
 iS3KxVU8jcr7Y+NT3081XZq3/BbjjnQ0ER3lyabJaGQSG2oVMTVR+PRJWK0eqQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] net: phy: Turn default auto-negotiation timeout into
 Kconfig symbol
Date: Fri, 31 May 2024 18:47:16 +0200
Message-ID: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: daa61nb3u3m3iacutbbb77egtysosyhd
X-MBO-RS-ID: 8aa9795fd9821ef23bf
X-Rspamd-Queue-Id: 4VrTZL6LB6z9sbC
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

Let users configure default auto-negotiation timeout via Kconfig
instead of specifying it in board configuration headers. This is
the first step toward converting this to Kconfig fully, so far the
legacy PHY_ANEG_TIMEOUT in configuration headers takes precedence.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/net/phy/Kconfig | 6 ++++++
 include/phy.h           | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3d96938eaba..73064b2af68 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -23,6 +23,12 @@ config PHY_ADDR_ENABLE
 	help
 	  Select this if you want to control which phy address is used
 
+config PHY_ANEG_TIMEOUT
+	int "PHY auto-negotiation timeout"
+	default 4000
+	help
+	  Default PHY auto-negotiation timeout.
+
 if PHY_ADDR_ENABLE
 config PHY_ADDR
 	int "PHY address"
diff --git a/include/phy.h b/include/phy.h
index 90b7e364101..072ed0961f4 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -59,10 +59,9 @@ struct udevice;
 				SUPPORTED_10000baseT_Full)
 
 #ifndef PHY_ANEG_TIMEOUT
-#define PHY_ANEG_TIMEOUT	4000
+#define PHY_ANEG_TIMEOUT	CONFIG_PHY_ANEG_TIMEOUT
 #endif
 
-
 struct phy_device;
 
 #define MDIO_NAME_LEN 32
-- 
2.43.0

