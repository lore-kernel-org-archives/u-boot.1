Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCF4C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 08:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5A588A16;
	Thu, 15 Aug 2024 10:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723710277;
	bh=75GRQ8E8S/GcKsZaCsttoWWjk7OzCFbNQN2p0SMa5p8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zGyoFNrkVkk1js1EHPsjS0mG9rggM21IwxAwHly9uFQ0e7q+stnelZLMYecqVsK+C
	 WLITdx5oGO/g46ZVa62he58KJTSMTxd5StWIpidkvzk4HpzJp9WLNOQWI7hsGUJzhN
	 jpwaf5Z1bsgJcJ4E8HmJ4Yi9PrpZ1ZH3pPgjGIvb18ldzYs++bkiiKMOHofyXdmzjg
	 W87CLDEZFrRSrZqhgthYqjlqJ59cXUj7IpUtuURacvWbPPsSZ+gT+KBPNcq+L1rRI7
	 LsoMQ/8zMRJja/5FRA6d7LOyb+g1a9Ld3cWoR6BW4QSoW0fXkZL8hsi1wZgOqc1ySt
	 +ZayBsMOahZBg==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 233B2889C9;
 Thu, 15 Aug 2024 10:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723710275;
 bh=75GRQ8E8S/GcKsZaCsttoWWjk7OzCFbNQN2p0SMa5p8=;
 h=From:To:Cc:Subject:Date:From;
 b=mFJ9GvmV454I/84tMzgy3wIK+sIetdK7aK1cwGapPOuFgVdu8xJtmazoDpDfoXwG3
 KcaeXkzgni5QSnRbp1A3hqI8XOdsQ8FzdR5B429tzGXrJF+NMRW4//eh/FYsayl5Yc
 flj+6sKavyTfxw1zmImbAwI017/Krsvj6d+5MgariXnihl0fmu6hg8x2OwVGmayJrf
 UxH6E3AxxrHamwj7zrofnbm81Dz2hnHUr6hoeW7O1yKMPZHHXWrBEIobqa/MNz2nVC
 fEjWAkDlTw/VQjZuQZIZFVvD86SAnmARY4ulWAy42W33nLLuof2r/eD4VIuenZRM2k
 OG5xmUXZqRNoA==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Cem Tenruh <c.tenruh@phytec.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] dts: imx: Enable USB support in
 imx8mm-phyboard-polis-rdk-u-boot.dtsi
Date: Thu, 15 Aug 2024 10:24:22 +0200
Message-Id: <20240815082422.470790-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

The Phytec's imx8mm-phyboard-polis-rdk-u-boot.dtsi u-boot specific file
can be extended to support SDP gadget operation in SPL.

It is especially useful when one wants to flash the module via USB with
uuu program (USB ROM booting enabled).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
index 516e52e1f5..4d452d6006 100644
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
@@ -34,6 +34,18 @@
 	bootph-pre-ram;
 };
 
+&usbmisc1 {
+	bootph-pre-ram;
+};
+
+&usbotg1 {
+	bootph-pre-ram;
+};
+
+&usbphynop1 {
+	bootph-pre-ram;
+};
+
 &gpio1 {
 	bootph-pre-ram;
 };
-- 
2.39.2

