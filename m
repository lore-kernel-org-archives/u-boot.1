Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45C5C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF70D87086;
	Sat,  4 Nov 2023 17:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699115573;
	bh=1plNeaffWD7uQVzevvtFkwj3p/V0NidqBNgZSmxR/9I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wCyNtEZBRkhBk+m8CjEvTBFG6Rjo1tGPpatO7OdSOakgZaTwJ8Vk+mfSblhOR2cOp
	 /DblzJmDQQqYYo/AvjdQGc4aVISsrRnV3wKvZ8n+XH3IymG9tcRf7Qqa3fZ00ZMQAr
	 LzcoPiJjDYjlIFCFi664IWj0YhwP9soXS8sFMqdBcTwnkn8cECExtT88X4N8GkaFuI
	 oTkDYxnBUIyLIMPdjG8fHMfBAlb+lsoMmTbGAZsqwcQdaCZuaTTF/SMGsKVLKfXeeW
	 AJJc7jUcXTVvopFqohB1WBadBsO0il0UJemlAP0AuM2SD4/c2gOmZQldPvfRF5mP2N
	 mpQU2/bRP6fpA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6652A86E05;
 Sat,  4 Nov 2023 17:32:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699115572;
 bh=1plNeaffWD7uQVzevvtFkwj3p/V0NidqBNgZSmxR/9I=;
 h=From:To:Cc:Subject:Date:From;
 b=lQ1AqgYxvL34vYPM/efqb7xOUYtN4JrFiTOm8djmgl515fKpfQUXALTOIm5exGk+0
 f229nIrbotFnaqP3UpGYkea/otiDrhTKGnL6FbHwK5oU1IJrnXolSwgpdYQ4XGtqRK
 CbgMuQU+fWFJwpZxFhf5FM30rRqdodjNGn4V6naYMMkeE60f1LaYSvj6SNYp1RRb0k
 htrgWzY8CUk67EPqOt5rHbc/1khPSfKmpDqmh7D/fx5WLy50pTKmn6z8/RjLGmKcCC
 lq7VPuDYHyMUYt0DvQUwsEZmNiJ7xfUiIJoQS8j3ctOWL815eRTVhgGsnjvKcknlXG
 Jh4KxVzpRQLMw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 1/2] arm: imx6: Enable TCP, IPv6, wget on DH i.MX6 DHCOM
Date: Sat,  4 Nov 2023 17:32:20 +0100
Message-ID: <20231104163243.117404-1-marex@denx.de>
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
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 configs/dh_imx6_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
index 5a83b6a08a2..8d2d46ab659 100644
--- a/configs/dh_imx6_defconfig
+++ b/configs/dh_imx6_defconfig
@@ -55,6 +55,9 @@ CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_WDT=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
@@ -71,6 +74,10 @@ CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_VERSION_VARIABLE=y
 CONFIG_ARP_TIMEOUT=200
+CONFIG_IP_DEFRAG=y
+CONFIG_TFTP_TSIZE=y
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
-- 
2.42.0

