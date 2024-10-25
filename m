Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4133D149F6
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 22:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CA288EB9;
	Sat, 26 Oct 2024 00:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729896983;
	bh=TwU0XWDORsQxdXdMnr4+ICwkRo8+CTdM/t+r85DPHRc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DkAD2LzJn7BLLy3Iz16riE3vJKRyNKpCsgRoEg8ytR79J2mBJrCMIpT544wZdvm0M
	 vuqWnZUvSUvapcJhRIf+eS2E+PRc2LHnBRq8F07N80nCS8zoBRUtWMXHUzhei/qLlk
	 cEAQGg3gYcGTxbkhWVQebk6Y3tAULBbGjg0lt600jAclQ8FpKhGLWbOeDlEfqm8bbZ
	 iPF9evcVxjoEpgdrexGENOBvkn8IcrQkjhmOkz/ausRIw/0/y1a2AvJqy5DEJlvbxY
	 bH37W5bMKvWQVtTtzr3GBL2o0rWssnSm4ttvCwt2rPlL1VvtSOr7YGvLaR8F0Yh41x
	 R0TcM5xGKK4Ow==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 487EA88D13;
 Sat, 26 Oct 2024 00:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729896981;
 bh=TwU0XWDORsQxdXdMnr4+ICwkRo8+CTdM/t+r85DPHRc=;
 h=From:To:Cc:Subject:Date:From;
 b=vWMa2OMKGPRYOCH0z/U2eibt3Ezik7BSHEY/2qln+jzZztSIDbg/dChJs64dVOfNM
 Lauczg6XXEhopwf24Rq4WbLfXMvwNZWCQrJ9P04z7FS+LaVGefcO67O1ugovS6rGv8
 Qz70b9TInE2VkVaaqn6N9tr9rDKZ0S0vZ2+U6h/Eee2OAz8OLJOAB96aehQzITqoFN
 QhIHlBKxwdLANPNpgysF5Zc2vPb1Epo9JLJrmv5C7PswkNqRVwD2tjYxG+1SqkcCPn
 JVnwwLfpBtNfJL1GEwikKPTOpf2EnXZyDc5SgiucZ7SR1c3Cc3XoxSSmfFZEwdGAzz
 eudD2H70MJU9Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 1/5] arm64: imx: imx8mp: Enable DM regulator on DH i.MX8MP
 DHCOM SoM on DRC02 board
Date: Sat, 26 Oct 2024 00:55:02 +0200
Message-ID: <20241025225602.114784-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Make sure DM regulator support is enabled on this board, just like on all
the other DH i.MX8MP DHCOM SoM based boards.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: No change
---
 configs/imx8mp_dhcom_drc02_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/imx8mp_dhcom_drc02_defconfig b/configs/imx8mp_dhcom_drc02_defconfig
index d0877ad6f72..ffc9bf0e1c2 100644
--- a/configs/imx8mp_dhcom_drc02_defconfig
+++ b/configs/imx8mp_dhcom_drc02_defconfig
@@ -161,6 +161,8 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_PROT_TCP_SACK=y
 CONFIG_IPV6=y
 CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C40000
 CONFIG_SPL_CLK_COMPOSITE_CCF=y
@@ -231,6 +233,7 @@ CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_SPL_DM_REGULATOR_PCA9450=y
-- 
2.45.2

