Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DC2C30653
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 00:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141BB884CD;
	Thu, 27 Jun 2024 02:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719447256;
	bh=YE46e5+Ks7xAnik78cNx1piBkc9AabW1N3uWyBLP/U0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pk826DKaMNfX4KBm11aCkvFo7ytjYpNrxT/4jqMI/N4bb0wHCVQ9IahnClnVYqLI1
	 dPxN3mkTchboYHxlS8GagYjSSNPI620Q6EA3sDped78ntltolTATfp3fCDJIvVrlQz
	 xr26A0C5y2q3kIMzqJrtIg0NZWUT/x+LeGBuYZta7N4/DWYcXNwWDI7pnHU9fpkW7o
	 t6YC32U42D5UOgFMG0QNGsGesuhodQuwmM8mw1rQU3mo893neXHFV4y97YKUdA/rh5
	 HG0yWM01IqNJzkD+MCSQW3KbL9Xz+A8ANKI4FyKwJL+m9b+3UAQ9Iv2+rziLF9Bqs8
	 WDNw4kAg5wx/w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8C159884BE;
 Thu, 27 Jun 2024 02:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719447254;
 bh=YE46e5+Ks7xAnik78cNx1piBkc9AabW1N3uWyBLP/U0=;
 h=From:To:Cc:Subject:Date:From;
 b=bE5NY9XRvi5BTNE0bepf8E1stIhGJcwytDqPKoa3mmxvAMVzUPecDsQkS8DNRnkIN
 jaqmS5MaLgnoB4xO9fVSBYlqtCp1jgYtIJaQ0PC/5tPnToYM51WMYIxDP4HIKTnDYF
 z4esQ9FjrjsaR8nLOf6pKE3waW/QSTTZJxxzjuk5eyVcowFfEJt2q1mDfRXGRqwrGh
 CfZwOj8P2gXArXi2yjnZ0zwQIveSMz8WQ/XQHCpRYmuB+uhcsJzfL6QnowxnBH7h8/
 FlMQ3fixa7xr56WeOGaNQUi7nBJJdl/182RI8p7p5c0i69Tl01BSWXn/4wYC+7zMKX
 xWZ6uk6ZiwDwg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 1/2] ARM: imx: Enable PCA953x driver on DH i.MX8MP DHCOM PDK2
Date: Thu, 27 Jun 2024 02:13:15 +0200
Message-ID: <20240627001403.279340-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Enable PCA953x GPIO expander driver in DH i.MX8MP DHCOM PDK2 configuration.
The PCA9539 GPIO expander is used on production DH i.MX8MP DHCOM SoM rev.200.
This is already enabled in DH i.MX8MP DHCOM PDK3 configuration so align the
two configurations.

Fixes: 9de599ec3d59 ("arm64: dts: imx8mp: Update i.MX8MP DHCOM SoM DT to production rev.200")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/imx8mp_dhcom_pdk2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index cbc608dd912..79b3e96c8e3 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -182,6 +182,7 @@ CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 # CONFIG_INPUT is not set
 CONFIG_LED=y
-- 
2.43.0

