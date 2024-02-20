Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D3BC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B41B87F8A;
	Tue, 20 Feb 2024 11:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rQ8C4e+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA18587D91; Tue, 20 Feb 2024 11:42:24 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAE987DEB
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1708425726; x=1711017726;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2qJQzrK0QmwPQMeAQCSDlVXjKh9RqjrNSI8Jr8cVgsA=;
 b=rQ8C4e+vvzaPTMcBDKEyL1Y1OXEe9cCTMwPkLfNBalavIQsX0D40SNwleN/iPZjP
 TGUZT7NB2WghsQRGNWXEepSzeq1+H9dFcFsBZf7LEQ6ODJlDOu8AxzeP79UJAWgq
 kk+Oc0/fQhJech4nSZViNPL/T7nsa33tmhysGrw6Gr8=;
X-AuditID: ac14000a-fbefe7000000290d-8b-65d481fe4a72
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 26.CF.10509.EF184D56;
 Tue, 20 Feb 2024 11:42:06 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Feb
 2024 11:42:06 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 20 Feb 2024 11:41:43 +0100
Subject: [PATCH 1/3] phycore-imx8mp_defconfig: Enable CONFIG_IMX_TMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-thermal-support-v1-1-f6a97d8d6481@phytec.de>
References: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
In-Reply-To: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708425726; l=631;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=2qJQzrK0QmwPQMeAQCSDlVXjKh9RqjrNSI8Jr8cVgsA=;
 b=ycgh/CnAipe3iwdx3DGfTi52/iN3dJGCyceBQ3BCyB3O012DyLxaKrxBe/Lfp+42P6F5/kSkM
 f6BN6gyhQnYDKZgpCwTw0je8T+hpf1XvnfvcA4zERiTU25hdUXWRYRX
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR/df45VUg13fTSymTtrMbvF2bye7
 Rfc7dQdmj1cHVrF7nL2zg9Gjv7uFNYA5issmJTUnsyy1SN8ugStj3vVG5oKfLBX/Ji9mbGCc
 z9LFyMkhIWAi8XT3PfYuRi4OIYHFTBL/Xyxgg3AeMkp03fzOBFLFJqAmsevNa1YQm0VAVWLW
 5L/MILawgIvE0ulf2EBsXgFBiZMznwBN5eBgFtCUWL9LHyTMLCAvsf3tHGaQMK+Ak8Tr02Ug
 YSEgc3Hvf7ApnALOEv3PloB1igi4SjzdYwgxJEri3cQgEFNCQFhi004tkLskBHYxSVxs+84G
 EU+U2PlaDmKgrMTN81vYIJ6Sl5h27jUzhB0qcWTTaqYJjCKzkFw5C+HKWUiuXMDIvIpRKDcz
 OTu1KDNbryCjsiQ1WS8ldRMjKPBFGLh2MPbN8TjEyMTBeIhRgoNZSYSXpfxKqhBvSmJlVWpR
 fnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZJg5OqQZG5gWvTssrVt8Vu1rTenH3
 zyOv3yt/3tzEt+D/hItK781rN71v9WwRzNXkSXNvN198ds+L/f/XGbImdWvvvmjkqXH0uNeW
 7H35HouCF34WO13hYH6UM9wu78SFJdsYvGTVts/nja3RXl119lekqd2cOKNluceWrFM8+4fT
 4Niaz9uyHsgys60tVGIpzkg01GIuKk4EADbMGbpqAgAA
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

Enable the imx thermal driver to prevent booting when the system is too
hot.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 0f37286d5d99..c95554283903 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -138,6 +138,7 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y

-- 
2.34.1

