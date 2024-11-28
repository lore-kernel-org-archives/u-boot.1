Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FB9D6D25E
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 04:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6F689833;
	Thu, 28 Nov 2024 05:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p1RWS7y7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CxLlOOw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D328983E; Thu, 28 Nov 2024 05:11:59 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC5A89634
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 05:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XzNDX2PsFz9t0S;
 Thu, 28 Nov 2024 05:11:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1732767116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=loV7kM3Dg/ZCk7mAo1b0R/qDU8xR4o0utsvh+IyQIVE=;
 b=p1RWS7y7yxxSkvfPoD6g+EoT//Hn7eJhXH89blFh6+23yhyHZG8jn++CNnb8ky6ake5dy0
 tQlOSExOkPZE2uUrbaAxa8NtqDJK4OEI8BcDeTbErC6y7EKvhvFH8IWCii1yXzBqEraxGv
 IFQ0eDYYcONAPmuxsv5ZmMGiyVfoq71LXRYTiNccTKQlyUg85he6kx5oY0iSjFhQbNXAm3
 ifrKrJ//Q5isbj62MHtzsRmoRcXLJRdsvE1lzo5c7h09vZQZ+voRZFLkXJT4PVvYnvcrON
 0AJKdNnyUiLTnvrjPSR1FNb7m3UsqOgxpphYF5oZH8njmTh3DzKB9Tfd5TpKGw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1732767114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=loV7kM3Dg/ZCk7mAo1b0R/qDU8xR4o0utsvh+IyQIVE=;
 b=CxLlOOw+lAtvAM6DPCT873eplacWR9A/nnouLk105J2TQ2Xl5VI/mwSwh1uyBOSMhhJD3T
 KCmjGwhvSHFn4NE8I3+w5nQX6sdIGEakaAwvVehjQXB1vTaEyfWKz2J1qj8lsMvdj/NFgh
 BybZXcDOsptMfV74DdYxRKj7hZ8FkjcpZkBdvte6OGvrLllGveLr94XU73f9c35YjWbQNp
 pxZxw67rsK17BBBO6Ly2gb3Sgf0t3GgaLxdhXLMu/nSu65VW6MbXzWFq1gJ3037E8C88ch
 Hw//uy316IKfWXDg0EL+779XZP8tv2DRUBXwNVoCemuj/Pcjv6w78Aa5G7M3dg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Cong Dang <cong.dang.xn@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Disable AVB1 and AVB2 on R8A779G0 V4H White
 Hawk board
Date: Thu, 28 Nov 2024 05:11:19 +0100
Message-ID: <20241128041140.293109-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5hxd1bzpxi6jnrm67mwfzf3ec8wr9owx
X-MBO-RS-ID: bf99006b58c8f8afe8f
X-Rspamd-Queue-Id: 4XzNDX2PsFz9t0S
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

The U-Boot is currently not capable of handling ethernet-phy-ieee802.3-c45
PHYs correctly, and also does not handle MDIO bus wide reset-gpios property.
Until proper C45 PHY support lands in U-Boot, disable AVB1/AVB2 interfaces.
This only disables the two MACs with 88Q2110/88Q2112 100/1000BASE-T1 PHYs
on ethenet sub-board, the main board AVB0 ethernet is unaffected.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Cong Dang <cong.dang.xn@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
index c3704d789e8..531767cfdb2 100644
--- a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
@@ -13,6 +13,14 @@
 	};
 };
 
+&avb1 {
+	status = "disabled";
+};
+
+&avb2 {
+	status = "disabled";
+};
+
 &rpc {
 	flash@0 {
 		spi-tx-bus-width = <1>;
-- 
2.45.2

