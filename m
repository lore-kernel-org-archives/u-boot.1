Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3405C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB0287B5D;
	Wed, 31 Jan 2024 09:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZKdMRxOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477DC879B0; Wed, 31 Jan 2024 09:46:04 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A671877D0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706690761; x=1709282761;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=66wu5iCpR5V9B+yZDGebAS7T5hnFrcQF5HYX7OS5zWM=;
 b=ZKdMRxOl9uN+RUkNKtk4N7S0SD/VZ3NPKM9bw9n6GxXZN0ttUqWi8vFAHsqR4GkC
 N31gXKk4T5+BbW82zGdCX0gi06sFNyLcRv24lddoT6fJ0VFFJBqe5xzCHmlXndOr
 1X9TjrEHFMAP0BOPW6V+7O4TIx8dxQ2BRIFYMstmLeY=;
X-AuditID: ac14000a-fbefe7000000290d-a5-65ba08c8d072
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3A.0E.10509.8C80AB56;
 Wed, 31 Jan 2024 09:46:01 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jan
 2024 09:46:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH v2 0/4] phycore-imx8mp: Add USB support
Date: Wed, 31 Jan 2024 09:45:36 +0100
Message-ID: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAIumUC/1XMQQ7CIBRF0a00fywGEG115D5MYwp8hEkhQIlNw
 97FJg4c3pe8s0HC6DDBrdsgYnHJ+bkFP3Sg7DS/kDjdGjjlgjJ+IUuSz7SE4GMmgp6M6HXPJsW
 gPUJE49679hhbW5eyj+uOF/Zdf871zymMUDJIzQ0OgtKzvAe7ZlRHjTDWWj/LIv9jpgAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706690760; l=1149;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=66wu5iCpR5V9B+yZDGebAS7T5hnFrcQF5HYX7OS5zWM=;
 b=FjDxt0ZNR6UHGRkP8LzsUWJss1Tqx2ZhhUcQpY0f72OuOf4YQ3XQ0IBiyVUh233/xod5kSMbn
 Advy0J/3QrRAvfNE2u8veVRWdf/2Nd76QT6LQFBG2TBG/G2v9JSCUnO
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWyRpKBR/ckx65Ug50+Fg+v+lu0n/KxmDpp
 M7vF272d7BZTHq9nt+h+p+7A5jFv1gkWj52z7rJ7vDqwit3j7J0djB793S2sHhvf7WAKYIvi
 sklJzcksSy3St0vgyph29TFjwX+Oit5DSxgbGKexdzFyckgImEjcOdoNZHNxCAksZpK41PqV
 BSQhJPCQUeL4cVUQm01ATWLXm9esILawgLnEmqknGUFsFgFViRP3zoPV8wrYSfRNOsIIYQtK
 nJz5BCjOwcEsoCmxfpc+SJhZQF5i+9s5zCC7JASeMErcOXULbLGIwHZGiWuLfzFCNERJvJsY
 BGJKCAhLbNqpBVG/m0li2d8mZoh4osTO13IQZ8pK3Dy/hQ3iF3mJaedeM0PYoRJHNq1mmsAo
 PAvJRbMQLpqF5KIFjMyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYKiQ4SBawdj3xyPQ4xMHIyH
 GCU4mJVEeFfK7UwV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzru6IzhVSCA9sSQ1OzW1ILUIJsvE
 wSnVwDglvVyyJnLZNv5ok+/cfmc/Tm5buWDzH+tWxUh97oeHbx60LGe6cyTz9wSW9duzLVeY
 cjo0avKUezaKSe3VdT09M0H1edPFbbIL5FdcVA28H1104NOm9EXJrNcCTh7gE94kf6VqQvn6
 DxV5DyqC7CelXrpz7C3XM81jG7iSjsjqVDqyHQ1KsFBiKc5INNRiLipOBAAVEMoGfAIAAA==
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
base-commit: e7f9e5eb584dd0b5d1b1ff82fe607d6da9940cc6
change-id: 20240126-usb_support-403f47d71ac1

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

