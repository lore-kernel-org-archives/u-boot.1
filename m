Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49333606A327
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bDZS5fNA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DF646085B;
	Wed, 21 Oct 2026 12:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3O9oyYUFYvKT; Wed, 21 Oct 2026 12:45:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D59A60849
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586758;
	b=EbhabCpZGYS5lPkWIT6GM8+LOwNWVOmOYrMLaRijauR3uMF5VGamXGY0RNyWDspYv4hU
	 VMtK2hg9aXOoiFMBV0t4pN0EQZZ41mkPWecCvSyMWpp4zA5LSvuJDBn+iyMsjg57CrQ6T
	 GgN50v64djGdP+m6p030/wkecsX2Uq0A4S0mRIME/huB0DLR8Kpx/NlfKoaU097yIExtw
	 fF5vqWV09HT+9r8iVNOukUygikyEU/iEOKHCoD4Rj1K53HSqGP4x+vBSF+Glypj0mGZFx
	 FNcsDa9wlbkbvQQvE5ljSSlIV/SQkZiTQx+0JOGRi3h5bcFLeoWPLGf5GCDbxwI47rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uskiCSNRnreR+baYK+WAuC50PT3gyMoIUXP90snsb9I=;
	b=PLiuY0kE+GQYuJHWgtSPOwkai/+ec6BqIiqm7oFcAiWJCDqRQQzJd7oUUQ27VLT7aSU3
	 fa00cUZM312V6xufrAXJiLLuwqC6s1ZQtRHSxhHirtWdpPkQUqSxTEwgbZI47l8mVVskC
	 3ZqJHL4RHjxhQVUQhHhI2+EvbATVDtSswfJwKKTQXkS4YbkpnEEUrf+kieu30d012Km4U
	 pwfj4Z0TYVM8MB8oIKjblZYRPOtX9ZnMqV1jgDfVJS7jPW7DsrtXJ+esCYUNqx4azoAj+
	 KIXV7mygEa1bx3E/36jF7nQgXj2M6TM4yYNJveifrnO5p4nDc4HzeI9q8X+Dy7TzxrA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586758;
	bh=uskiCSNRnreR+baYK+WAuC50PT3gyMoIUXP90snsb9I=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDZS5fNA8IclORazhjO2rZ4xW3u6/3xmaLL+NJEUGSDhf+BQcxvwIWnUqIYyRW56j
	 LaCEFkSi6rnBKGeVttXdLjxMBtVllj1vOYrTRmILyF5hpzkEbT6+QiOTtOsQOwGCUy
	 F2Vj5YDdcy9XRR6vjFdYLZZuDvCXllDTceNqwHacqAauW0YBERUFaKF1wfsrA8LV20
	 C437Tc4AkDWkO/KVzihJnYJyKMRJcSw2Qk/m5glrgBot5C9YBe8GAgBpMaOT3rYjz9
	 30r2qJBme3djIb7b8WL4tqv8Z88HGXjPFpGxsSPZi8jX19637Uv1cr332dfh5e8Rrs
	 HCaNYhmofHJ6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D59A60849;
	Wed, 21 Oct 2026 12:45:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C373711CE
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA0384072E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DW3VjjhZXhWT for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D07A240674
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564762;
 b=UlR4+o7QXbfCWi91b/J8bVdPDV0TRG+HjVfR7v8r9lGYb4pyyO9x9UVO5BhfZY+s/MJi
 g3182utqm7xzPZ/RjKdRvyiH7l15n3dK0w54jEe+29X0XSaTFs4iHGKpxiTuzwC1KaQyB
 JeHjBBtJLqZk4EcrAsjkmY+rDsAwLOezVNzQrVZafJDK7W1E8Eq0GCq/ubETot/AA3W0I
 hHg4LakHZbKnvLeCnmpbu7kHqcqxpqzFY3Ik5WThPV84e7yzWkPaqp5HNdbXksR6HqoKK
 UpXYvd8lg6XIKVIOL9MaCn6BCc0nBoSAKrPr26X41fzNuk0sGSorBE6CnkgijEB7CdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564762;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:References:
 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=uskiCSNRnreR+baYK+WAuC50PT3gyMoIUXP90snsb9I=;
 b=H2z+IVX5m29cQrhrfaNI9MkQwEwKn3gaisF8cbTeiwvg7BtnHubwIWtScw+HopmXla1l
 QdLcvlTbXYqaYXtVoSKfAVWqF20lZkTK2hmBNRqpXlbvf/1GSiw32PfIT8KePJ8sesy2h
 cqLpub48Eg3VMEnUgkIVtufLtIBioK5MBJnpqxgxyN5FNL94e52VJEVdkLLuHOndp5KsE
 OLX/TqzGsbpMMVJiYvK6PehZmt3jT/zeCSRB2FyHO4VmGSaWwLl5HujpGbqn3uMt6zigh
 EMfQIruM7PI2uh/+BEdDNNg8o0uqqaoT6sf19yKjRW0Uq+0x+WmeQ5GLL2p2FXNZq3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D07A240674
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 14:34:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 14:34:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 21 Oct 2026 14:34:08 +0800
Subject: [PATCH 5/6] arm: dts: ast2700: add aspeed,scu property for MAC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ftgmac-rgmii-delay-v1-5-fce405523118@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564449; l=1358;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=ZZOved6WHsODem/wB0Ir4ZuCnLr5btnmDq+L6he7t1Q=;
 b=fmTMVejSwmdeX5Mu/8AQVXx9083JRRE3sKCf7YXTq6oYUv52ULM+0P6i3K4BusduIfsvH4OLN
 vlwyGUqi2KoCONV1QQfuufnUCmDaDi+ahYWjDhpFZPfzQPdAMQXAmQp
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

Add the aspeed,scu phandle property to the mac0-mac2 nodes so the
ftgmac100 driver can look up the SCU1 regmap to configure the RGMII
delay chain on boards that opt in via the tx-internal-delay-ps and
rx-internal-delay-ps properties.

ast2700-evb.dts already sets phy-mode = "rgmii-id" and
tx/rx-internal-delay-ps = <0> for mac0/mac1, so no board-level dts
change is needed here.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/dts/ast2700.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/ast2700.dtsi b/arch/arm/dts/ast2700.dtsi
index 3dd6826fd0c..c7c30e24130 100644
--- a/arch/arm/dts/ast2700.dtsi
+++ b/arch/arm/dts/ast2700.dtsi
@@ -372,6 +372,7 @@
 			reg = <0x0 0x14050000 0x0 0x200>;
 			clocks = <&syscon1 SCU1_CLK_GATE_MAC0CLK>;
 			resets = <&syscon1 SCU1_RESET_MAC0>;
+			aspeed,scu = <&syscon1>;
 			status = "disabled";
 		};
 
@@ -380,6 +381,7 @@
 			reg = <0x0 0x14060000 0x0 0x200>;
 			clocks = <&syscon1 SCU1_CLK_GATE_MAC1CLK>;
 			resets = <&syscon1 SCU1_RESET_MAC1>;
+			aspeed,scu = <&syscon1>;
 			status = "disabled";
 		};
 
@@ -388,6 +390,7 @@
 			reg = <0x0 0x14070000 0x0 0x200>;
 			clocks = <&syscon1 SCU1_CLK_GATE_MAC2CLK>;
 			resets = <&syscon1 SCU1_RESET_MAC2>;
+			aspeed,scu = <&syscon1>;
 			status = "disabled";
 		};
 

-- 
2.34.1

