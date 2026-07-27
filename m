Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ECCC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F559606E0;
	Mon, 27 Jul 2026 11:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 131zNHgubMn0; Mon, 27 Jul 2026 11:57:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F57C606D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153471;
	bh=e110CM0+8WamM4tCqOy2Abz6EsQRUCTbFpywEaRUNFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XKEQmKpJSeMKdB2Mi5Nh9bgj1Ebedxo5vn6t/DvVwdblkLLQU5gxtvNQ1bjD4dZJh
	 lectnsSwIswDzDdFvWaGPZuwGXk9q2xiDPuWSnve9qJ2GvjxrBopkbQU1zBdNiWgyW
	 AmCAkeIlgoIfTlz8sVAPC1FXrS12iN6fA9e9z24O3+/D7ab7PEKmoIZNtxZM7tIFFa
	 Z0L8kP0SW8AZ+j185Klu5EkT4BweMaA54nmFMSvf5F8Vxz5SrUAQmx7xzvVn9OCP/X
	 zbO+7UoEttez5fUHIL5VXGrgQPVhWY9Jl0ze8Za2f27PJvVp3om2N35pvmD8hpkMzz
	 dDfGpSxqhC0ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F57C606D6;
	Mon, 27 Jul 2026 11:57:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C05326C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47B1C80D47
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLkQ5huTRow1 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:57:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3570880D5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3570880D5C
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3570880D5C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:49 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxq-000Epq-2U; Mon, 27 Jul 2026 13:57:46 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxq-000Fh8-1Y; Mon, 27 Jul 2026 13:57:46 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 13:57:39 +0200
Subject: [PATCH RESEND 3/4] arm: dts: tqma6ul: integrate tq,eeprom sysinfo
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6ul-eeprom-v1-3-ad1d4e2fa1ae@ew.tq-group.com>
References: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
In-Reply-To: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=e110CM0+8WamM4tCqOy2Abz6EsQRUCTbFpywEaRUNFE=; b=TbLQ6yaAR8H9Nwnap5g7YBdo3N
 tDFB18EQgvTzz8IntDTa48Q1IRoY+rtPJdHYTjaQE9bW8PrRoc/7H4OdMAw/fj1e6AIpUpIwmRjul
 CPCZInUSY08J79t5UszCR+5buWxzv21b82L6jpFzUaZiTLmpK/LvgtkpASbmxxXnA2M2LtbORIHlr
 307aMFpcID+NgMDTWmL02HEZ8GLQfmfEtsETFXfvKbGiPPIUAI9jEdYQmwRTKkQuqmIn0OiWLT2mF
 LnEvb2/Ke7qU6Q9U/V7zA1shBXoQqzwFWB6NoUqfkzdQrSNBULxwOn8P1BBDsfzqyPmzP/zZAK1ri
 TrNJVOjw==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=TbLQ6yaA
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add sysinfo node for tq,eeprom sysinfo driver.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
index 1ed44c57f59..c9e6cef38a2 100644
--- a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
@@ -14,6 +14,12 @@
 		u-boot,mmc-env-offset = <0x100000>;
 		u-boot,mmc-env-offset-redundant = <0x110000>;
 	};
+
+	sysinfo: sysinfo {
+		compatible = "tq,eeprom-sysinfo";
+		nvmem-cells = <&module_info>;
+		nvmem-cell-names = "device_info";
+	};
 };
 
 &clks {

-- 
2.43.0

