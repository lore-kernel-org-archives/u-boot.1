Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02BAC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3ED87BBA;
	Thu,  8 Feb 2024 13:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="A4DykS8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F81877D0; Thu,  8 Feb 2024 13:03:23 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7126E87BBA
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1707393800; x=1709985800;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AkqP7CL8MQTQkyJn6VvPZFJL+4FjgzjfIaCNsDC+rOY=;
 b=A4DykS8qebmQrhx7b4vw/+a4UI5rD5XlqEwy7wwumWHv4k+8pQ304VSok1AXrbP2
 rqakvgkZDoJ6b44MEMBrYR5TimLd0o7i56bdMv2qwmStwbih9En96ghNstwZvlRX
 jaRPyDZpNiEUjFwZ0NBKKrUfNzbmdtod1B+H5HXDvjM=;
X-AuditID: ac14000a-fbefe7000000290d-7a-65c4c3073dd2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AD.80.10509.703C4C56;
 Thu,  8 Feb 2024 13:03:19 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Feb 2024
 13:03:19 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH v3 0/4] phycore-imx8mp: Add USB support
Date: Thu, 8 Feb 2024 13:03:07 +0100
Message-ID: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPvCxGUC/1XM0QqDIBiG4VsJj+fwN521o93HGCP1b3lSoiWL6
 N5nwaAOvw/eZyERg8NI7sVCAiYX3dDnUV4KYrqm/yB1Nm/CGRcM+I1OUb/j5P0QRipY2QplFTQ
 GSC58wNZ9d+35yrtzcRzCvOMJtvfv1CcnAWW00pa3WAnGpH74bh7RXC2SzUn80JZwbnluleRgp
 BRa1urYruv6A8noE7viAAAA
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707393799; l=1325;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=AkqP7CL8MQTQkyJn6VvPZFJL+4FjgzjfIaCNsDC+rOY=;
 b=tcytmP1z1+HE/1N2a+CipIu3c72CfzyBcwLY8ohMfnwL0F7uQwhxPGOUFhEFTBjPdIZ/wCtcB
 qFygKG+pZohAQ6AqY7Yi3jGcNYFb1jWKa/QHNugoDIf4qCk7mDLalD+
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWyRpKBR5fj8JFUg23LuS0+zGtlt3h41d+i
 /ZSPxdRJm9kt3u7tZLeY8ng9u0X3O3UHdo95s06weOycdZfd49WBVewed67tYfM4e2cHo0d/
 dwurx8Z3O5gC2KO4bFJSczLLUov07RK4MjYffcxSsJ6rYvetXsYGxnUcXYycHBICJhJdLTuZ
 uhi5OIQEFjNJPNhyhAkkISTwgFFizj1/EJtNQE1i15vXrCC2sIC5xLmr08BsFgEVic+fpoHV
 8wrYSTxaNZENwhaUODnzCUsXIwcHs4CmxPpd+iBhZgF5ie1v5zCD7JIQ+M8osfLKMjBHRGA7
 o8S1xb8YQRxmgRZGiUn/uxhBuiUEhCU27dSC6NjNJDFx5mMmiHiixM7XchCHykrcPL+FDeIb
 eYlp514zQ9ihElu/bGeawCg8C8lNsxBumoXkpgWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcx
 guJGhIFrB2PfHI9DjEwcjIcYJTiYlUR4Q5YcSRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOu7oj
 OFVIID2xJDU7NbUgtQgmy8TBKdXAKPD5SOv65X+L1yZ+qxZ4mZH2Ud6Fff5p9eOPzsrZf3c2
 Nf3aNfnhC+47rbvVQ401prUm9+3crtHOs0HVYfehSQfZKiaseVI/3T2U69SfdFOjDd/vHJ0U
 yOexhOf7E40fHzeueb81/lzS8Y5fQqduyAn1TO8/9ezrxSu6yoy2n/Pv+q1ROPGbw0mJpTgj
 0VCLuag4EQA3sSyxiQIAAA==
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

add support for various USB features like USB storage, USB mass storage
as well as booting and flashing emmc via UUU.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v3:
- add patch description for the sync with kernel devicetree commit
- Link to v2: https://lore.kernel.org/r/20240131-usb_support-v2-0-7521c554b597@phytec.de

Changes in v2:
- sync kernel devicetree before making changes
- Link to v1: https://lore.kernel.org/r/20240129-usb_support-v1-0-8bd2fe84005b@phytec.de

---
Benjamin Hahn (4):
      imx8mp-phyboard-pollux-rdk: sync with kernel devicetree from v6.8-rc2
      phycore-imx8mp: add USB host support
      phycore-imx8mp: add USB mass storage support
      phycore-imx8mp: add support for booting and flashing emmc via UUU

 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi |   4 +
 arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts        | 162 ++++++++++++++++++++-
 board/phytec/phycore_imx8mp/phycore-imx8mp.c       |   4 +
 configs/phycore-imx8mp_defconfig                   |  33 ++++-
 include/configs/phycore_imx8mp.h                   |   5 +
 5 files changed, 204 insertions(+), 4 deletions(-)
---
base-commit: 0101a2ffe125911ebf89172b495f5ff14f2fd058
change-id: 20240126-usb_support-403f47d71ac1

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

