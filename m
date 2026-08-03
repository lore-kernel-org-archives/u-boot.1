Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E2C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48099606BF;
	Mon,  3 Aug 2026 23:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EunfDWhpaZwB; Mon,  3 Aug 2026 23:31:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80087606B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799879;
	bh=fCYFGROotIOuNPTKfvds3nCasslAMV4FdgO1ST10SjM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=jrQ6obFD3qVdNRWDNc84aoyDuLBdZuS7gXgKZ6W3oL1fm0LaQROMt+EONj7x0ybNr
	 wgG6ocCuOuEC60TwVQFVHuIdbgwCnI+1vCxZO8SZC+nz8jx9+hkW2wH3PqIS9DVTpc
	 CUJcfmvahfSXuCRlsY2JmOCyB4XFQSH2N2odpYTH0g8dSbdzMkxFme/LYb/p4OomeD
	 JUlrAjv2PnxNr4p24x1g782DUT5GMBtIZT4/z0FmM6sRb4Gh8TzosQpbFc5iW8w3BQ
	 kh+FuLGr5M0dtpJ2P0ps4eiM373eb/ZkXWZJdyPJcQQ+A9JIxtlIsB/ax3yIl7ZCV4
	 3pBvfyQeqw6eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80087606B0;
	Mon,  3 Aug 2026 23:31:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DB832DE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5777E606B0
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqaX-eF92Hqx for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:31:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9BDEE606AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BDEE606AE
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BDEE606AE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDXxF6n1RzMlGJ;
 Tue, 04 Aug 2026 01:31:13 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm: renesas: Bind RPC on R-Car R8A78000 X5H Cortex-M33
 RSIP port
Date: Tue,  4 Aug 2026 01:30:30 +0200
Message-ID: <20260803233104.391908-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4922addb47a2cdd2125
X-MBO-RS-META: p4jr6ukckdgjb8x455zn31cq4qtqxzqw
X-Rspamd-Queue-Id: 4hDXxF6n1RzMlGJ
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fCYFGROotIOuNPTKfvds3nCasslAMV4FdgO1ST10SjM=;
 b=HgmAIPfVdq99rCU0cXosjsABzCDRMAwebf6zEZ8E3HBAM6xMzj86fgbAdQSqB3qrJTqCOX
 d3H6Ofg5MP66+vObT+F7EsgUS6A2tL3djn3WKpurOp2flHY8aFPNHGVG4DFgU/fL2TdxWO
 LiPqEFz0CCwhBne845w1brk4S343eB4Q23dJisgqKNoG2xVB2jPcv/0ZwsmlmYVkV1Chq0
 9qVsqnUNdXWH4wAvj0ngPYAYleVKj7aVZhOZ8S+h7qXDyfX/NMdtHRzCO/i9th7ICS4I4n
 Je2GjE/9Jo8v0EBZferGbd3uX/HNQB7VW80hLMDyTTCbcgcXudJm0QN7CjCW4g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fCYFGROotIOuNPTKfvds3nCasslAMV4FdgO1ST10SjM=;
 b=ixD5UTENruLMmi7krauTG5IWMwQYkP9e8W7kEOR1IVk86/9aiaG/BFJWhD9fY54biGVT2q
 Zke8YGSHArUFeBMQxc+sLS7roELnKCWyrQ34TUMXJm5I+5j8uG1FQsDDqbwuwx2kUUOSGv
 ympTTNahpTnP6Emvg7Dp55nkdD7IhMCqh62E2tL55wAa0NpuW6bU+btZZ59Mj/h4o/cM2s
 k/MJKajSficz5Ovp9TiTdhKZ/97HdSyt9wE4Ix5sE/d9KOJeDxZ7LZSrByKtf9KhhP6YrW
 d/yuSXPf2T17TNQj3ehoPO2Ycqr8+jBgTFz6muI2qlpcWV2H6Z3hVS2UTtxrOA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=HgmAIPfV; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ixD5UTEN
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ixD5UTEN;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Bind RPC and HyperFlash in DT on R-Car R8A78000 X5H Cortex-M33 RSIP.
RPC is used both to update the HF content, which includes the U-Boot on
RSIP itself and SCP firmware, as well as access the U-Boot environment
for U-Boot on RSIP.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
index 356f633135d..872cbfdbad6 100644
--- a/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
@@ -70,6 +70,23 @@
 		reg = <0 0xb8940000 0 0xf000>;
 	};
 
+	spi@c08c0000 {
+		compatible = "renesas,r8a78000-rpc-if",
+			     "renesas,rcar-gen5-rpc-if";
+		reg = <0 0xc08c0000 0 0x200>,
+		      <0 0x34000000 0 0x04000000>,
+		      <0 0xc08c8000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
+		clocks = <&dummy_clk_rclk>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "cypress,hyperflash", "cfi-flash";
+			reg = <0>;
+		};
+	};
+
 	scp@c1340000 {
 		compatible = "renesas,r8a78000-rproc";
 		reg = <0 0xc1340000 0 0x80000>;
-- 
2.53.0

