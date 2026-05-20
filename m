Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB80CD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 06:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBE9846AC;
	Wed, 20 May 2026 08:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="R711k1+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6E4843B6; Wed, 20 May 2026 08:05:38 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66DEC846A4
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E+FqWbzYbXPkGBrWFXbnUy99IWTWtAL/4d73usSVpcs=; b=R711k1+I8UTG0HzH8u4QCzVeJ+
 hzaGAHiCWkJgcK6YXnMIssWc8UjtJpn5TEfF3ysBQiZjiOuMH94FANrLuuxoZHVpEFXf61w8GzXE/
 q4paFMM0CWr/EDid3hK5Wgm5pyGS+NQcjH4clry93CuTz7BLlMRIuk7H4+OXAAyCCRx2FI1PUpr5P
 3VAaLtOWJG6D+zQepf22akMGekXmpu8rxztKJOE76Xs4C5tyAKIWOAD8r30NWxGOiy5ulxADqyddx
 n7YYqXILsuGVK9IUBCVJCG4wBI9rhwwCg6FJKBukQP94WF2bi18C9rm2clMMPy2mTZPA0aFA2ttp4
 gy2Nt5FQ==;
Received: from [81.57.40.39] (port=50682 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPa3l-0000000DuY3-2Lkc; Wed, 20 May 2026 08:05:35 +0200
From: Daniele Briguglio <hello@superkali.me>
Date: Wed, 20 May 2026 08:05:30 +0200
Subject: [PATCH v3 4/4] pci: pcie_dw_rockchip: imply CLK_GATED_FIXED and
 switch PHY to imply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-4-58f2cea72030@superkali.me>
References: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
In-Reply-To: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Richard Genoud <richard.genoud@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779257127; l=956;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=Srp3R4XJB9oH3NYTl8BGQKKtQN10bJfn+JL7JI45T/I=;
 b=omhlpRofumrpgvCNO8UchjgELsFcOGMxQEdNm997NtnSPY2dSCZXrTK2HQZVJ5CgngOt/fMf0
 /reP5GZIvVzBCNvn3grGsTv40CsGjIptdFdIy18sFiVSU0IQSmtLtvq
X-Developer-Key: i=hello@superkali.me; a=ed25519;
 pk=5tynRWQdL93CDcapJ73FkcCRY2PeBOJOIAoIhRig53U=
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Switch the PHY_ROCKCHIP_SNPS_PCIE3 dependency from select to
imply, and add imply CLK_GATED_FIXED so that boards using
gated-fixed-clock refclks pick up the driver automatically as
their DT moves to the binding, without each defconfig having to
touch the symbol.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
 drivers/pci/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 39df0e776..77e0f820d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -414,7 +414,8 @@ config PCIE_DW_ROCKCHIP
 	bool "Rockchip DesignWare based PCIe controller"
 	depends on ARCH_ROCKCHIP
 	select PCIE_DW_COMMON
-	select PHY_ROCKCHIP_SNPS_PCIE3
+	imply CLK_GATED_FIXED
+	imply PHY_ROCKCHIP_SNPS_PCIE3
 	help
 	  Say Y here if you want to enable DW PCIe controller support on
 	  Rockchip SoCs.

-- 
2.47.3

