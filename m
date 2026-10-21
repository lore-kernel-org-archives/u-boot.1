Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1254606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eD3rFx2k
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39DE46089D;
	Wed, 21 Oct 2026 12:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETiDgNKamj45; Wed, 21 Oct 2026 12:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5939F60865
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586751;
	b=BV2TCXPeIm/3YW7dfwu3e407n6Xj8m9ct7ttmBrHRZJXtVHA7a4UARsyG0oJd1rtd+Gm
	 RM68y6kifiXcGjQ0YgCULwB1J9JyhMyK9gbvKLnm9bmbL/WPAlrjSEkGI1oFzdyGmU3QN
	 +Y6Z8C79O/Je47tD8W8EedpprwOLlZzPkCvID/u3TAVtmky/kcJe0ggDNiOgWKhm4wh5U
	 qfzcAJo9pohCEnIZjANGyDyvM+if+cqzg6i30R41dcmZCmhRlOiD07pvN2AmzYBnVyL+5
	 buCO5dtLrycdAfyy+rgI319/0vCm2EB4L/1DGMBXr2bVDA/+t6glxLD2JRanXzBOn8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nmxCRgeT61k16PHst1kraLlLt22gSA9HCT0wYtrbrvY=;
	b=HWBrv6avXgINVk66Db2lh0mnCCLox9zMdwGdJ7lJ3aA1AxPwXn8v7/O7HWPJMIuwEutA
	 LFsx6LhJHnJTVn9DS4n6Pz1BjsRkBmyDRSh1rPFnN8s03m40kZscYbVPC0RQ868efyQvU
	 GA9C+j5W0iy2+9fLmZeKmQbGOwxbM9YWspUCsp0YJmrR+9ClrA8NBIzmwoBmRzBtySvT9
	 EZZ55C1Fy4bFAHYidRCglqAWJJD2yHrJLrTMEhjf19zyTzZq3gsF5wUFQTyw7WS7b5AcN
	 MWtoUvmgBmBXiNiP0vKVXxYzy60VmNj74bCnxZXbu+yDHSC2ODi5i17kJ/TrJdvuHDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586751;
	bh=nmxCRgeT61k16PHst1kraLlLt22gSA9HCT0wYtrbrvY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eD3rFx2k2GOmC8LLxfpX2spmFB1x9Ohl5/4GrgbcgHYmuGo21EtnwlEdg1f+Q2ZLD
	 tbGtaYd29zplQsqJCymjR3EDuapfPAUG2Y/2iZkg7g5Adh8aDZUen9DjfxVaPLaamn
	 d6T5EVgKymea56kViXrhB6HSI3ul0JD83hHRjvNPRE6ts6jDpPCaFFVGgQ7FGLr5x7
	 TBvMP9KQ6P1mofJMrPSlp7aDvMhId5HIwKb4G/k9prDMMOoslve0PEgzlGtXwU45eL
	 6nPJDfAe1QkuGtHaqo7VLxduHaii2jx71MOYWSZFUSV40IjyAvni3jnY2OW7LWCouG
	 Sx6iyyW88Sswg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5939F60865;
	Wed, 21 Oct 2026 12:45:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 809431E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E4674060C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CVWxDLOHlx4 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ADB2B40674
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564761;
 b=gd9raIJPxygYNqyXO6vnn/eTDq0JWJsFO1xDEpV+3VTRlWjdkb6SyVnOWzkr35yaWkEx
 NGYPhNl5XaH5s4pV+AbrYUCRE1gZSQxsoGJTrVbRcp9qnrLYzUtVqy1h1uyCWkKN73syX
 DjfNwtSrasWx9F2KUrf/bkE6DQWrGbb/XCa+aoJVtyqqcu91JLYXH5lxVOz4wvtEa9YTx
 UVjLe5XLqc0GugzbvYGyG2WOGsDTOL8hL7KztaysPk+skTBTfxlru96ZSwt/pkP5D4glc
 9wu7XTJU5iipwx0AGDRZo+EdSWXJsODI8atSnWVoK9EXrXHpAaPCzdxuT4FoLJ3abDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564761;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:References:
 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=nmxCRgeT61k16PHst1kraLlLt22gSA9HCT0wYtrbrvY=;
 b=BFr5V5ugDMmVngzUqTlDEcU8wUXXxiBal00VyihAk+QeU+kKzj6t2p4bCweVVLRzUXyn
 7cg7rXQRwmxC81CDJSnI8UPd2tX2xkcTpQ1tefiRvFB2fxiGmrra2aU7gjZkU2KnZKxBi
 I4bV/VGoHPHOXeyOSYYgrMuhHW85kaSRaim95hmtZYCJ466Bcl17LKoLsTUQUykrQpU4j
 raOTTa0oGiAF+SwkFFMT+Brdb9Dlik+/7l+WlHLvGH6MRMnZzRGfVQpkcXlSP22+FxaVv
 ASyZAKDRqCK2j+0bCfcd2boxJiHJISIzRclVfGp4xDlv8WoKalap83vEz2lKpClfjLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADB2B40674
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:20 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 14:34:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 14:34:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 21 Oct 2026 14:34:06 +0800
Subject: [PATCH 3/6] arm: dts: ast2600: add aspeed,scu property for MAC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ftgmac-rgmii-delay-v1-3-fce405523118@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564449; l=1415;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/bqkjDtF9ezXAQ/sJmhKfTohp8StlZHSNJ2DGmcyPOM=;
 b=Kz9QKhW94ARWlcV3aqQh/hjdREAArp++dR3UtHhc0ijxeuHi3QHqycM1kha8EAZzwlQPSrHD9
 EZ213BiMcevB92xIjn4GC68WKt8/bt2lRUraVs7OVT3WTq9Wpj7w4IQ
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the aspeed,scu phandle property to the mac0-mac3 nodes so the
ftgmac100 driver can look up the SCU regmap to configure the RGMII
delay chain on boards that opt in via the tx-internal-delay-ps and
rx-internal-delay-ps properties.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/dts/ast2600.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/ast2600.dtsi b/arch/arm/dts/ast2600.dtsi
index a048951fa18..30f06cbe824 100644
--- a/arch/arm/dts/ast2600.dtsi
+++ b/arch/arm/dts/ast2600.dtsi
@@ -277,6 +277,7 @@
 			reg = <0x1e660000 0x180>, <0x1e650000 0x4>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scu ASPEED_CLK_GATE_MAC1CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -287,6 +288,7 @@
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scu ASPEED_CLK_GATE_MAC2CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -297,6 +299,7 @@
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scu ASPEED_CLK_GATE_MAC3CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -307,6 +310,7 @@
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scu ASPEED_CLK_GATE_MAC4CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 

-- 
2.34.1

