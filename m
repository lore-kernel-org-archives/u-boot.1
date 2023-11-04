Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91722C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC0B87163;
	Sat,  4 Nov 2023 17:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699115574;
	bh=zqDoll3z10AWJcbeNLynSZb9e4LGpcqknlt+RD9tCC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJ4ptLgb0oBQdjvQQx+g2qD9vSDEZk9kDCUxST8Djzyi4smSctHxddPsqpISBpspl
	 lnWze4qJvW2n5IURajh4xap4/FiwxiRO6L43fMC7tA+qxQQ6t5t4nbtDN0VxPvusf1
	 Ep/wXdh+c6jqMUN//TQVWMHqV68uB/Gt9oW4D0nEAkVaXL3wKQC5D5rEldid1/EIDa
	 I9NIBK4FgocQxfp7JtkZVIEE2H3/R8YcE5ysv1y+PS86h4s3CQsCl2ZszPf/gECBuK
	 kGzORQXVcX5eVmSyJbZSXe+2i5I+LBBjukRRr0bk6TrX1k4EDKDgcPvrjUtK/QSduQ
	 OHiiEnbPXXPwg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D1E7E86F63;
 Sat,  4 Nov 2023 17:32:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699115573;
 bh=zqDoll3z10AWJcbeNLynSZb9e4LGpcqknlt+RD9tCC0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sMoPgpwvdKNkpkB8ScoFHW5us25NuNLymVwNZ/+JNbHzvanzYlFelllFiseo3Vbbn
 ObDkUAcwyM8yeCa/4P/M0RPN+1Vg3gv10aRF/y/lVFyBedrcTVSGYXjiHVc5YjMGDN
 kDQrG70QKaWJlbCcieyDFyXin5WXnkaR2+3gj/EqmZIzbzrFrwoBO2bHnd+nAjbAaq
 jlWY2QyXt4fJ2IsMg15ePr2MgJisPeI/bYBjdA4piguoPCAdrmfuF6S20wCN7WVm87
 7HGsZcexgt2f4Wx6QdkhfOHaFwHxNu+f+tw69Y2zXJvog04ibjysvK+dWZO+OHx0JF
 aLJ73fSxpMcmw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 2/2] arm64: imx8mp: Enable TCP, IPv6, wget on DH i.MX8MP DHCOM
Date: Sat,  4 Nov 2023 17:32:21 +0100
Message-ID: <20231104163243.117404-2-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104163243.117404-1-marex@denx.de>
References: <20231104163243.117404-1-marex@denx.de>
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
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 configs/imx8mp_dhcom_pdk2_defconfig | 5 +++++
 configs/imx8mp_dhcom_pdk3_defconfig | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index a77139ab06a..54c02dfd7ab 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -109,6 +109,9 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_PXE=y
@@ -151,6 +154,8 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
 CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index c1f8fbd3ec3..6799f0c8b73 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -111,6 +111,9 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_PXE=y
@@ -153,6 +156,8 @@ CONFIG_NET_RANDOM_ETHADDR=y
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

