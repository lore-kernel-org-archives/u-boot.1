Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1CDCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7932284688;
	Mon, 18 May 2026 23:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="OvRuVcKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3D084694; Mon, 18 May 2026 23:04:42 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8AF483FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PdzBOCVYPsaPV8sFrrwJucN62OzlP+hxRoxxmaKWiPw=; b=OvRuVcKqN/dBMYD8wG1PVM2Mo2
 MsEIlZNP6QHpHAJYY0jmGKprCpGFXUf77riv4pg7W69iKjrTqoZKOQHnvO/SFdVR/zy42TW7jSFxm
 bJZCgZWuPPxHH8W2f8oWXJEM4rvKzKIMscP3qePIAUGVkl08PfVthnxGoL36O6MumDTCLgAr8zAgN
 k7QYB7HaNmnTowz0zzA9XWjuxiPQJ5EYslAZV5CmLNGy1Y5zoLdn4uW8+gmzIXqgEDKZVF5NE3fAg
 6fDOnmKpq+zPT6wlCiYzv2hhfhvArAdvvQWVGB9cOxmSdTe/2bcNJrTRZ5k4kge/oBdYhhqXTTtg4
 YynGCWXQ==;
Received: from [81.57.40.39] (port=35612 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wP58g-0000000CoV8-3VuZ; Mon, 18 May 2026 23:04:37 +0200
From: Daniele Briguglio <hello@superkali.me>
Date: Mon, 18 May 2026 23:04:36 +0200
Subject: [PATCH] arm: dts: rockchip: rock-5-itx: drop pcie3 refclk from
 u-boot dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-rock-5-itx-pcie-refclk-dtsi-v1-1-faf8626039fc@superkali.me>
X-B4-Tracking: v=1; b=H4sIAON+C2oC/yXM0QqCUAyA4VeRXTdwhzTpVaIL3aZNQ+XsFIL47
 p3q8uOHfwfXaOpwLXaI+ja3Zc6gUwH8aOdB0SQbQhnqsqIG48ITVmhpw5VNMWrPzwkluSFdWjl
 3gaQngXxYc7Ttd7/d//ZXNyqn7xKO4wOAiX1qfwAAAA==
X-Change-ID: 20260518-rock-5-itx-pcie-refclk-dtsi-17ad4b21df1d
To: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Cc: Heiko Stuebner <heiko@sntech.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779138275; l=2476;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=nXWhlv22BdQ4biJYGVJoWMsWDbM3lIi88u180qRRoSM=;
 b=73+ZcXKA6S2S2YaOlcgHFeNo3Kkq39LHo1EAJAnSoS4vI4yA4CaAFtWAZB4zectXWmmv/WIJ9
 NI8sk6omFxyCf3zoHbKOHc8fUNNlWwrDUgZaMbrANzWF/qJCfDRorqc
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
X-Mailman-Approved-At: Mon, 18 May 2026 23:35:05 +0200
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

The Rock 5 ITX uses a PI6C 100MHz oscillator to drive its M.2 M-key
and SATA PCIe3 controllers. In the Linux DTS the oscillator is
described as a "gated-fixed-clock" node and added to the clocks
list of pcie3x4 and pcie3x2 so that either controller's probe
enables the supply.

U-Boot has no driver for the gated-fixed-clock compatible, so
clk_get_bulk() in pcie_dw_rockchip fails with -ENODEV on the
phandle and the PCIe3 controllers never come up:

  pcie_dw_rockchip pcie@fe150000: Can't get clock: -19
  pcie_dw_rockchip pcie@fe160000: Can't get clock: -19

Override the clocks/clock-names of pcie3x4 and pcie3x2 in the
u-boot dtsi to keep only the CRU clocks. vcc3v3_mkey is already
regulator-always-on here and is the same regulator node as
vcc3v3_pi6c_05, so the oscillator stays powered and the "ref"
input ticks regardless. The Linux DTB is unchanged.

Link: https://lore.kernel.org/r/20240906082511.2963890-6-heiko@sntech.de
Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
Tested on a Rock 5 ITX with an NVMe drive in the M.2 M-key slot.
---
 arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
index 1e5c2674e..51ca79653 100644
--- a/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "rk3588-u-boot.dtsi"
+#include <dt-bindings/clock/rockchip,rk3588-cru.h>
 
 &fspim2_pins {
 	bootph-pre-ram;
@@ -20,3 +21,22 @@
 &vcc3v3_mkey {
 	regulator-always-on;
 };
+
+/* Drop pcie30_port{0,1}_refclk: U-Boot has no gated-fixed-clock driver. */
+&pcie3x4 {
+	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe";
+};
+
+&pcie3x2 {
+	clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
+		 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
+		 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe";
+};

---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260518-rock-5-itx-pcie-refclk-dtsi-17ad4b21df1d

Best regards,
--  
Daniele Briguglio <hello@superkali.me>

