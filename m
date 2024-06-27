Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19222C30653
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 00:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C7E884C3;
	Thu, 27 Jun 2024 02:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719446506;
	bh=AaOxgV7SRCB8SOqI+xnvP96asLYuZdNs81aIFg/JXr0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dXhRFVXBuLUBgo5/wfizCs4MGpH7EhoKGMaym1rtqqb9dqgAd5zpd8FLHsXz1d5oB
	 BlauK76tX4H0EMpZlatjwM6b5x4KvDGJvDmqun3XZxLwB4354QLOoKAQJsm9DIaJoI
	 X2Wok66t5ZBYOZ8C+bVstNJdtEELVRXjV8kVBjFSy5C+8rkDyYE4nSDcYiWRgD8qqX
	 VM2eTCuV5r8j9vO0u3bdvLDMrYgIqovEfqh8jlK3eaWxzRilJznKb9qfqK9h0ZMfBk
	 /JDKQ95AfNP91aNY9FSiYvIcVGzm0hh6CiZy/4O9V9Te3cZQCE9XoP/6/V6iYiswxM
	 ZFcKGdoLphhQw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3B01F88495;
 Thu, 27 Jun 2024 02:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719446504;
 bh=AaOxgV7SRCB8SOqI+xnvP96asLYuZdNs81aIFg/JXr0=;
 h=From:To:Cc:Subject:Date:From;
 b=hZlWVZPQcHHdnx4PMpvWgXtmfVFsg3ELAk8kS6MNBNd/vhgYQbfuxfOVZkIk8k953
 gL7qSLorwGeo5SCM07ODCp+PWb3YXqdWIxO0WvnyxWoI1Jc5C5/lv9HYOB1Wl7+8ZX
 f36IqT0O8MJL9l7t2OOUANIfOLEJYEe/xF3G1t7Jq8MOdjMptBDB+27dBDvmqkbbmQ
 HxsSHTxZN/hhFuLGS3knxJdJLSvVvnBDfzOlT+ts+scsK2ZMOtY+K51hkLuLpEhhKl
 okQ1OaKkNyVUeCj1hHbNWS7UE6O/uRMjmoO8JW0oHMlYGTuaj3+EYxVDT+Ck7gaI4A
 GLEI4IA2/tHWw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Enable cat and xxd commands on DH i.MX8M Plus DHCOM
Date: Thu, 27 Jun 2024 02:01:21 +0200
Message-ID: <20240627000133.274037-1-marex@denx.de>
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

Enable 'cat' command to print file from filesystem to stdout.
Enable 'xxd' command to hexdump file from filesystem to stdout.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/imx8mp_dhcom_pdk2_defconfig | 2 ++
 configs/imx8mp_dhcom_pdk3_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index 7fde7ad769d..79b3e96c8e3 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -108,6 +108,8 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_DHCP6=y
 CONFIG_CMD_TFTPPUT=y
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 7b3dae504f8..6c7ee7ba3fa 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -111,6 +111,8 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_DHCP6=y
 CONFIG_CMD_TFTPPUT=y
-- 
2.43.0

