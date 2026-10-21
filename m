Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD58606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W09Lx18F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE7416082C;
	Wed, 21 Oct 2026 12:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdP1drcWii7M; Wed, 21 Oct 2026 12:45:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8DD460834
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586755;
	b=LFhC19fwZmzICie1jPjLaqaLt//mGmS4uOFHkumbMGuF8Zs5uizO18b1pp67cXsHDMWr
	 /7hUnN2idRW3I+gwQaBJu3fRTlSAVbaylEJx1vtjeZ21eNfZ2vlVLC1RzEpvlh7NllYSY
	 +q0NdtugW98uLv4jpkvf20Ee+8NcAcjdg9/1SeDjY/gRWN32gaFuQDN6XiQ43H8p9Q4dY
	 v7AXOdnFISNS4pak9xrb3eTPYPHHcokCvv2qEi986ep6EI3KDez9r3XLXz0/CuWBm31/w
	 TZ0K3Jps9QfqbttqiBtl25VDTwNI6qcTydLkdMTwiY1LU8Jl9FuOj9dDDB2jwVAbgjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U/0FswUUui9SEuJ4SL+RkxCtgySadc8qrJNiwRMqUKY=;
	b=Qxqx+ahq3pQ2fNFkhBhyx7kLC/CaM0jCh/BwRnv46JHEECWGq1gZiBGocBeOKg4ocfxm
	 39pZkTdHp6qCAABdspmaTmeQhgnhzaxWtDfqBIWV5AR2F0WBLpxocJgXaq1lIYlY5qUHU
	 Gao3nl2AUpz7v0PYln13I/EdlwgsmsBGS6yaMx2s89am8fJVueBrJ6yw7bmejuc488GA0
	 I6RWk4nI4Cn+9qU1jqttNnM74MFfRq1wpcPSs65ou+n4GJlNZRraH8H3GZIzIVTCvQ5ym
	 vJfd2H43VAKu2PhY8bIrN+jEU5SClSRrOIAydU5SY+kK7rKXMQ2s0uMhpd2PnWFUluA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586755;
	bh=U/0FswUUui9SEuJ4SL+RkxCtgySadc8qrJNiwRMqUKY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W09Lx18F3N7utQlkB/e60dFuZ3SU917Hd0qAO5fm2DBrI3Vl+Wa0EZxrctrKtMXMR
	 GbnYasQ1GKn1GKfMNmVaGuuzwriq5KPxjABJcxj1hkIAXzlXOYGskft98FC5CCx3xI
	 /F/ogceJFp7kfn9+CCigtWnJl85UUJWl8CeEO/nIllm/oulRbQ7scJobaEFjfjMoB/
	 XyNOdf/lunOj4Q5Cf9+H03nhJjpCdSmEjii1yIJaDq3Zj7y7iQnhGnDi676Snv2xXx
	 y8Mj3pCclq8IcINkBLXfcMCEcMwnH0fydwDclSyJyw2zF915H4msutUPLB61goYfSC
	 876tBHP6V9YhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8DD460834;
	Wed, 21 Oct 2026 12:45:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A2732A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FF5740728
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJdnmUGY4B1f for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4BFC7405B3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564761;
 b=l9b0QOYwDMtD99KI2bt4ukGkehSjl75NFFzmFM+uqEOTywy3BLjPHEhgh9nzugCQVQEn
 SaU26hLKrowygUWUnDPlR/3pWn+l3vmlwPwsrz+SHb1C6rWmCoF0343eN9p0j14SzgEAT
 dZZFyAP56iBrmgddZQZnr4CHPMlxU9X1v8QmENbtDqRl7jx3CV3W31bEOw8gk3Y/4Igjf
 7Ika8cd6efFgSTvw38XHVkJuDFYBnylg+AcXCl1wiF7BLcRtbrGATmgyR2fFOdM+ge9oS
 5jMqYX9gdL6Ta6zVpOhssJ1CLviQosnkeAnKi2eHkYIxJdFf9QojdAURovGWctpNOYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564761;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:References:
 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=U/0FswUUui9SEuJ4SL+RkxCtgySadc8qrJNiwRMqUKY=;
 b=eQlPNY8bHL0qUISINj28ojgYFG4lfp3e9dyDV8AU0YqO3XuaR39SCIBCrts2iMmOygtF
 O+YCD2yeK2ABBURrmci4+ANl7U64y77IQ/NV7uU+6ewocoGTCYTnasfo1ku0SNWaAwBYN
 sivocq8gCN3YvCeNVy76acZFi+MUBFf1cAK5MpKSdNR3Jl9wS3IpIyKlTMHgisMl0cbF7
 bvK+G8gj3HxPUPTgfeZGKPiIg1rBy+1EI9ky4zcsDCerAVqnPJG+fmYLNxfn7CoTaPsb1
 YvoLlpTq3s81UO5A7nH+iU9arHAvF2rxi2SWbpC5E1qGNJPxRZODnWvutDUAA0F4GLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BFC7405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 14:34:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 14:34:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 21 Oct 2026 14:34:07 +0800
Subject: [PATCH 4/6] arm: dts: ast2600-evb: Configure RGMII delay for MAC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ftgmac-rgmii-delay-v1-4-fce405523118@aspeedtech.com>
References: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
In-Reply-To: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Jacky Chou" <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564449; l=2126;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=ZoNMG8xW4ZIBMIQLi7ahMKhqlYCvzWpzvlDrb5DiYuM=;
 b=4QrhgR09RO8se5iztr/Eudx/F/gSSIDEH4HrKaYvc0vmQ21M511E9ZqdpNo7DwsqrmHuCDMCd
 cn5xe/tLT/pAx6nphNxkRjgUtaDs+jF9K4Ej+JxVGoxISf+EIaCz5tG
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch mac0-mac3 to phy-mode "rgmii-id" and set tx-internal-delay-ps/
rx-internal-delay-ps to let the ftgmac100 driver configure the RGMII
delay chain through the SCU instead of relying on the PHY-side delay
implied by "rgmii-rxid"/"rgmii".

This also drops the mac0-clk-delay/mac1-clk-delay/mac2-clk-delay/
mac3-clk-delay properties under &scu, which are not consumed by any
driver in the tree.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/dts/ast2600-evb.dts | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm/dts/ast2600-evb.dts b/arch/arm/dts/ast2600-evb.dts
index 570ba61965a..9516b0fbced 100644
--- a/arch/arm/dts/ast2600-evb.dts
+++ b/arch/arm/dts/ast2600-evb.dts
@@ -212,49 +212,46 @@
 
 &mac0 {
 	status = "okay";
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default>;
+
+	tx-internal-delay-ps = <0>;
+	rx-internal-delay-ps = <0>;
 };
 
 &mac1 {
 	status = "okay";
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default>;
+
+	tx-internal-delay-ps = <0>;
+	rx-internal-delay-ps = <0>;
 };
 
 &mac2 {
 	status = "okay";
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
+
+	tx-internal-delay-ps = <0>;
+	rx-internal-delay-ps = <0>;
 };
 
 &mac3 {
 	status = "okay";
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
-};
 
-&scu {
-	mac0-clk-delay = <0x1d 0x1c
-			  0x10 0x17
-			  0x10 0x17>;
-	mac1-clk-delay = <0x1d 0x10
-			  0x10 0x10
-			  0x10 0x10>;
-	mac2-clk-delay = <0x0a 0x04
-			  0x08 0x04
-			  0x08 0x04>;
-	mac3-clk-delay = <0x0a 0x04
-			  0x08 0x04
-			  0x08 0x04>;
+	tx-internal-delay-ps = <0>;
+	rx-internal-delay-ps = <0>;
 };
 
 &hace {

-- 
2.34.1

