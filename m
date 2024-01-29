Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F2BC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1706087C44;
	Mon, 29 Jan 2024 13:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KGyS+bz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B129487CD5; Mon, 29 Jan 2024 08:56:07 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A328876FC
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 08:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706514964; x=1709106964;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bC0KJTSryHOwkpnB5Ef2IotH8HzEdqxbXSOra4sARKo=;
 b=KGyS+bz903hLqqry8S5wKj3/WhZErlPeUoOgockQ3rnwwxLcwQcKdMTHG1J+rJpT
 Ho8Fdw9nThYrOmtQgVLl9Umf/VwMFXdeKEpjgWmKMgLkehR9k9OBTvclaNFL1DH6
 Y9qqxEm/+iGIaC7v926Zo0/XxArC5kpn/DdcjdrVdDY=;
X-AuditID: ac14000a-fadff7000000290d-cc-65b75a149e7a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 35.E1.10509.41A57B56;
 Mon, 29 Jan 2024 08:56:04 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 29 Jan
 2024 08:56:04 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH 0/3] phycore-imx8mp: Add USB support
Date: Mon, 29 Jan 2024 08:55:50 +0100
Message-ID: <20240129-usb_support-v1-0-8bd2fe84005b@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZat2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyMz3dLipPji0oKC/KISXRMD4zQT8xRzw8RkQyWgjoKi1LTMCrBp0bG
 1tQBfQxKbXQAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706514964; l=862;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=bC0KJTSryHOwkpnB5Ef2IotH8HzEdqxbXSOra4sARKo=;
 b=t6Gp10PXgyLhTPfsP3ilkBiptKySlNEzFcTRvci5nhBONBmq6oP8R1kgtKPYNuoBYssbOJBrC
 AIhICtWq+fSAt0VYu38QnPSVk/hMwhxYH6Io7crvv+aVg/DMgEplFmT
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWyRpKBR1ckanuqwaILBhYPr/pbtJ/ysZg6
 aTO7xdu9newWUx6vZ3dg9Zg36wSLx85Zd9k9Xh1Yxe5x9s4ORo+N73YwBbBGcdmkpOZklqUW
 6dslcGVcfnuNreABW8XrhltMDYxrWbsYOTkkBEwkDq/7wA5iCwksZpL4ODmui5ELyH7IKPFi
 1TOwBJuAmsSuN6/BGoSBGnYfucoGYrMIqEpcn/ieCcTmFbCTeL/wNiOELShxcuYTli5GDg5m
 AU2J9bv0QcLMAvIS29/OYQaZLyGwhlGiZe9nVhBHRGA7o8S1xb8YIRpsJKYfDQAxJQSEJTbt
 1IKo38UksWrxL1aIeKLEztdyEDfLStw8v4UN4hd5iWnnXjND2KESW79sZ5rAKDwLyUWzEC6a
 heSiBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCokGEgWsHY98cj0OMTByMhxglOJiVRHh/
 am5NFeJNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cCY/1jl
 5IcbahIpOyfpWJ/sjTX5Zx9oot/+1Gitkfam/Ww7Zn6a8u/ig/ov7z5s8g1jWJ53qPlANO+l
 b02XqqdHmjysFV9n9r713j/ttRNLPrSFJhdkrjFXEkia8b/q+sRa/zla1zsWT+U+WN3bec6Z
 61A0c+mjlW19IgfXnevbW+4/w39a8molJZbijERDLeai4kQA85sZTnQCAAA=
X-Mailman-Approved-At: Mon, 29 Jan 2024 13:53:59 +0100
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
Benjamin Hahn (3):
      phycore-imx8mp: add USB host support
      phycore-imx8mp: add USB mass storage support
      phycore-imx8mp: add support for booting and flashing emmc via UUU

 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 26 +++++++++++++++++
 board/phytec/phycore_imx8mp/phycore-imx8mp.c       |  4 +++
 configs/phycore-imx8mp_defconfig                   | 33 +++++++++++++++++++++-
 include/configs/phycore_imx8mp.h                   |  5 ++++
 4 files changed, 67 insertions(+), 1 deletion(-)
---
base-commit: e7f9e5eb584dd0b5d1b1ff82fe607d6da9940cc6
change-id: 20240126-usb_support-403f47d71ac1

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

