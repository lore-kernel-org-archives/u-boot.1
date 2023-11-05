Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CDFC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 23:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE81686FDD;
	Mon,  6 Nov 2023 00:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="GYitwUYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7625A86FBE; Mon,  6 Nov 2023 00:13:55 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2655E86F02
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 00:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231105231342epoutp015f49421452f609e82909e559aada5291~U3RB9sfTs2725627256epoutp01j
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 23:13:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231105231342epoutp015f49421452f609e82909e559aada5291~U3RB9sfTs2725627256epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699226022;
 bh=FKUVD21KUv1G9lsAp7FuBH8oDdmkN+LYn8664MKos0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GYitwUYR1IQP8K4IRyJd6eQK/+RxbuPiS5FH5o9VH5/3ieVEJVKWGxDdMHxF1qTWL
 H8fHOXz9E9e6xpSN4TIiMa640Sp01r4Mu3KDbfC9LKaXyd2dMzwQcxfBpS6r30TPxT
 AI6W95/HTt4UNeIfA9xKyMrEHmw3wVe2I9twFG+g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231105231342epcas2p49a5a6735201f5809f89fda00b6d814f2~U3RBrKCR_0170501705epcas2p4c;
 Sun,  5 Nov 2023 23:13:42 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.101]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SNqzT4swsz4x9Q8; Sun,  5 Nov
 2023 23:13:41 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 3D.72.08648.5A128456; Mon,  6 Nov 2023 08:13:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231105231341epcas2p330184d6a27cf83d5fe151c1fdfe31c5b~U3RA0nt1R2877028770epcas2p3v;
 Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231105231341epsmtrp2e785d6deb2b18e5eb9484da00f5d2e91~U3RA0A0n91858218582epsmtrp2L;
 Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-69-654821a5ac26
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 18.9B.08817.4A128456; Mon,  6 Nov 2023 08:13:40 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epsmtip25768abf76fd2d8dd2f144102114d5965~U3RAiYAdx1168811688epsmtip2O;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Stefan
 Roese <sr@denx.de>, Yanhong Wang <yanhong.wang@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 4/4] configs: visionfive2: Enable watchdog driver
Date: Mon,  6 Nov 2023 08:13:18 +0900
Message-Id: <20231105231318.992857-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231105231318.992857-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTXHepokeqwb1uGYvL+7Ut3r44y2hx
 ct0HJou3ezvZLRbOOMtk8aPrEaPF40OvmRzYPfacnsXsMW/WCRaPs3d2MHr0bVnF6HH7LG8A
 a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7Iwrrx4xFlxlq7i8aQVrA+Mz1i5GTg4JAROJVWdfMncxcnEICexglFi2fw4ThPOJUeL8tLns
 IFVCAt8YJTo7omE6Dv2YzAZRtJdRYtuBDqiOaUwSn4/0MYNUsQnoSmx5/ooRxBYROMUose6S
 MojNLKAt0fl5CthUYQFHicMn+8FqWARUJf5v2wMW5xWwl2hceQzI5gDaJi+x+IEESJhTwEGi
 d/c2NogSQYmTM5+wQIyUl2jeOhvsBQmBl+wSC17sYIK41EXi2uNOqD+FJV4d38IOYUtJfH63
 lw1ifrnEjmVJEL0tjBLNbXuYIWrsJX7cnMIKUsMsoCmxfpc+RLmyxJFbUGv5JDoO/4W6klei
 o00IolFd4sD26SwQtqxE95zPUAd4SNw4dA4abJMZJd6umMMygVFhFpJvZiH5ZhbC4gWMzKsY
 xVILinPTU5ONCgzh8Zucn7uJEZwmtZx3MF6Z/0/vECMTB+MhRgkOZiURXkdvl1Qh3pTEyqrU
 ovz4otKc1OJDjKbAoJ7ILCWanA9M1Hkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqem
 FqQWwfQxcXBKNTDJuxkq5NTkKss+56x8dOj2mYSzvVXrV4bHTz7IuJBnAVP95/zCKx9k64rY
 7x6V7ZzRseLImcItW9/cn7qM7UZsxzG/CW3dwRLiBVsfX8iYmsz4/ZeTmGXy4j8ZRlGpBWJK
 K28o36zSa/p8u6pg0ya2vyKPfgUbrq3Q6763WHnT1Lji4xavMn7FFxVaBxzRLp9R7Zrj4bPk
 eXJs2hlnvj7DB4LxPb/sdI7fDti2QOfYsnwzwam6G/Lb/hy0nuxx6a6gcbVAaOCCT3r/71l9
 2fDyzPpjFta5srqTotbeyH9YqrlF0WrDrINX7vGpOE82jLfa0NVg9Nuk49zBTu5TIf2CxTxb
 VTZNYOG9pjvp+XQlluKMREMt5qLiRADzA4sZHAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSvO4SRY9Ug5/tVhaX92tbvH1xltHi
 5LoPTBZv93ayWyyccZbJ4kfXI0aLx4deMzmwe+w5PYvZY96sEyweZ+/sYPTo27KK0eP2Wd4A
 1igum5TUnMyy1CJ9uwSujCuvHjEWXGWruLxpBWsD4zPWLkZODgkBE4lDPyazdTFycQgJ7GaU
 WLT8AhtEQlbi2bsd7BC2sMT9liOsEEWTmCRubT0NVsQmoCux5fkrRpCEiMAFRokJO2YxgiSY
 BbQlOj9PAesWFnCUOHyyHyzOIqAq8X/bHrA4r4C9ROPKY0A2B9AGeYnFDyRAwpwCDhK9u7eB
 zRcCKvnx9RAzRLmgxMmZT1ggxstLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL
 9YoTc4tL89L1kvNzNzGCg1pLawfjnlUf9A4xMnEwHmKU4GBWEuF19HZJFeJNSaysSi3Kjy8q
 zUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoHplM4TPTGBu//Z6tPeaN4x388x
 gd+TYf2ZUPFGYbHlB3iOWVjeeLVPaUtVe9cWHrV37jOk/1y9dufm08VLby+dpno75JwJx+ny
 M5+PMB8/e6lud6qHzw3Njkl+808e6tOpmR969l5pT+22sKN/Zjc8bL36OZap3mBP865FtuuZ
 goWSzNdMLXd5xtzcuDU8h2P59jkq/7Xb48PU3Ox2zzLcbLZa7b7q12XzD6o8/HRhKc+vZMn/
 U3XXsJkcX2MYuqlS9GuKZWairuP+g9vZJV8WS4j0srYt51vuVOc5613SFRZbl9Xv/39j2+kx
 ef/UohuvXdUbfY92n/w4IfJ7/gY9I9ub/BIH0q9pKAk0xkk6KrEUZyQaajEXFScCAGSLJ8bZ
 AgAA
X-CMS-MailID: 20231105231341epcas2p330184d6a27cf83d5fe151c1fdfe31c5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231105231341epcas2p330184d6a27cf83d5fe151c1fdfe31c5b
References: <20231105231318.992857-1-chanho61.park@samsung.com>
 <CGME20231105231341epcas2p330184d6a27cf83d5fe151c1fdfe31c5b@epcas2p3.samsung.com>
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

Enables StarFive Watchdog driver and WDT command.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 configs/starfive_visionfive2_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index b15e7d24db19..7b39a63359dc 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -72,6 +72,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
@@ -133,3 +134,7 @@ CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_PCI=y
 CONFIG_USB_KEYBOARD=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_STARFIVE=y
-- 
2.39.2

