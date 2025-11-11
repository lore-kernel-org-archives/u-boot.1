Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C226CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 11:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D1183F7D;
	Tue, 11 Nov 2025 12:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="dxksYAic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314E383B7F; Tue, 11 Nov 2025 12:26:50 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9A683EC9
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8C0931487292; Tue, 11 Nov 2025 12:26:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762860407; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=cpghXdEwn8b06CsH25BXoEGDZ9vgrdOTuXbwpT+jSH8=;
 b=dxksYAicB5s7KxOOh2B6kbbTQRGKvUcaR6kfyQmad1+QcWAbCz6tkGN9OtHlhWI/JkHHsO
 +7l5rKuL2BYCmBu2Q81pORUbSuVHHxOMipQbKwi5oKMinatmTQgC8ji2WfDwDh8jD2NFnw
 pckv+XEVkM5rmesUR7EkpWn6YiqFkdnJXEBbsSeqslmHlLtSy0LfTOl1eDp2wXwjLaNNMp
 UlsxYBbDpV3+GkTwtn4VI0JSynP/QuL1qb5vBn/o/qemn5qt+V/EODlKEgVtuEf2SqKDRh
 HcDmD6ra8edjLn2F25GxbuS14BFAqE2uHeA5jkkxgtzMA39ZVkaCedIOj3RItA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Zixun LI <admin@hifiphile.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH 3/3] ARM: dts: at91: sam9x60: Add spi0 node (flexcom 0)
Date: Tue, 11 Nov 2025 12:26:36 +0100
Message-Id: <20251111112637.919074-4-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251111112637.919074-1-ada@thorsis.com>
References: <20251111112637.919074-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Copied from linux kernel v6.18-rc4.  Stripped attributes not supported
by U-Boot drivers (dma, interrupt, fifo-size).

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/sam9x60.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index a33c0d57398..1ee30422518 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -182,6 +182,16 @@
 				ranges = <0x0 0xf801c000 0x800>;
 				status = "disabled";
 
+				spi0: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+					clock-names = "spi_clk";
+					status = "disabled";
+				};
+
 				i2c0: i2c@600 {
 					compatible = "microchip,sam9x60-i2c";
 					reg = <0x600 0x200>;
-- 
2.39.5

