Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83D8C61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E03875F8;
	Thu, 23 Nov 2023 00:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700696294;
	bh=vGT+/Uy8IndJex+M9/j7ku0mY5Fq1rd2/CXDtUmHunE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gn0/8IyvwHhqvDAkOzJLrrSTV4Rer6JocKtBcMz3dwU5qqxTPvXlUIJKmMzjgd0rB
	 Yomeae6xjYVIVC9zhSFUZg0kt1Hf4a0wWVt7y2Tap5FVt47inUVXmyo/Yn67/9Cldp
	 3skGiThx/b1N6I9dCAR/K/dz1BdQDyzBdUjwNpbmy69Bdr68SqYy1epyNtPoLHrsjW
	 jVKeF3FD7n2IALYpQ03bpy6ox+2LfgT8P/xDUNB0lyPckwNFMijk8PbY25XAZXJ32O
	 CUCwR6Fz0eHg3XvAgV/6AyR+OWmU1v62FcyQzPxSFH2Jn+cIFDEN3CnxSMOdLEcQiv
	 DU7yrA8HlwZRA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 911DB863F8;
 Thu, 23 Nov 2023 00:38:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700696293;
 bh=vGT+/Uy8IndJex+M9/j7ku0mY5Fq1rd2/CXDtUmHunE=;
 h=From:To:Cc:Subject:Date:From;
 b=e/O6rz50XKKe5VXCiqBbMIMaO8dYj6v+71ZtK5OUc/iQKm7NEPTID/t9n2cSVmBj/
 WjyBze+gUO4uRMW6+XTTzMVPBfReb6xr3/o8u1hB2LDjd2cokYpamN6KUQFxNTN4P3
 uoKDtPivTE58aBNaSUuRK0dO+kDGG3lUX5QBfkfBy3VwIIFlOybCHYP/wdMgbmIfEn
 /H1lhkZBf4sALhrOJPdx1W8gDyfzhlYj58y8j1Q4LEw9NipPhJfI7uwHf0eUAKfeRG
 Tky7jd88acTn06s6FhhvdCaeJAaU5+Zp8ANCgOCB5XcKuGI0DcKok4rlbhdpw5yWuI
 YUezXrguSjKLQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] arm64: imx8mp: Enable TCP, IPv6,
 wget on Data Modul i.MX8M eDM SBC
Date: Thu, 23 Nov 2023 00:37:38 +0100
Message-ID: <20231122233753.64481-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Enable support for TCP protocol, wget, and IPv6 on this platform.
The former two allow users download payload into the U-Boot from
a web server, which may be more convenient or easier to set up
than TFTP server. The later is enabled to future proof the IP
stack on this platform.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 configs/imx8mm_data_modul_edm_sbc_defconfig | 5 +++++
 configs/imx8mp_data_modul_edm_sbc_defconfig | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index b015707ccec..3b76207227e 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -108,6 +108,9 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_PXE=y
@@ -148,6 +151,8 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
 CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index ae1a48c6812..7ee454076c6 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -114,6 +114,9 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_PXE=y
@@ -155,6 +158,8 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
 CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
-- 
2.42.0

