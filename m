Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52441E6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E4B89423;
	Sat, 23 Nov 2024 17:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380805;
	bh=Y++89W2deesAdM4JJagzmQ4x9G4Z7WPYXhTYsQG0VfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=coPjZxQYX/WKu5ytcu5GkFGy4NcmDRnN4C4EpBD2APl7DlwrVyeyfCysE6KZ7YWTH
	 ExrA1ocaPWjDEOIUgvRdHPycMySHOljfvKNNVyiZaTVu73M26Gs/T9ChXB0sTConQs
	 2pe+crK3/LQBCVaoCAmtGxY5sRiksACpPBEBkd5Ao6Qi0C6sl0tKpnIOr8SOE7TWX2
	 1pcQ96QDlX2Ybj08TKbn8nR8IMyXYdd3byrMhKh27vV9BeemPqiEK3v7VcT8cWHhMH
	 EnFVxAoQWaPGo4MOgH8fuYUDTEafQFpIsMZUx8jWlsFTA01R/S6WBo+AWYZN268OPY
	 dPz+WKI2Czn7g==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A3FCF885F5;
 Sat, 23 Nov 2024 17:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380803;
 bh=Y++89W2deesAdM4JJagzmQ4x9G4Z7WPYXhTYsQG0VfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CRuBzRq3MSGwN5+26P/tD2plf/6jALK0xxTFgQKZx9x1uajNMexKlAlE/ezcf5iZC
 WZ6FKdCdtg5y4vBIctLydog3Vf/S8VrgPzC2Y8Px80FjDS45D3LFekBrdesDxO+DQd
 6rKeU5Qf9mIFi6Rq6my5dYgMMJtz/hK6ViBkUUEo4QBqBCTnXj+tbOTOk4r7Uwffb0
 GuwqicbT+kBJwKJQNesa4RAnnlFHm1mxYLw305T2ernBPttxEKLg30tbFaksPU2NQk
 rDhgCjPJZ0G0Xx0wfTY3LZ/A3cXNdjGzQ2rUZ6hJDNyHRivMNTz6cQkK+VZH7vzbMQ
 jC371OLMBe8kQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 13/20] siemens: imx8-capricorn.dtsi: add wdt device
Date: Sat, 23 Nov 2024 17:52:57 +0100
Message-Id: <20241123165304.100538-14-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

add wdt device

Signed-off-by: Heiko Schocher <hs@denx.de>

---

(no changes since v2)

Changes in v2:
- add comments rom Fabio and Enrico
  do not remove DMA for console
  remove u-boot specific property addition, instead
  add it in arch/arm/dts/imx8qxp-u-boot.dtsi

 arch/arm/dts/imx8-capricorn.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index 4918bf8f567..3734a9d21f1 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -17,6 +17,11 @@
 		stdout-path = &lpuart2;
 	};
 
+	/* create device for u-boot wdt command */
+	scu-wdt {
+		compatible = "siemens,scu-wdt";
+	};
+
 };
 
 &iomuxc {
-- 
2.20.1

