Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA14DE7E64E
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 16:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B199586DDC;
	Tue, 26 Sep 2023 18:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="DHjx2evp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F56786DD8; Tue, 26 Sep 2023 18:36:02 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7894F86DA2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 18:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bffc55af02so149807641fa.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1695746160; x=1696350960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGeZiwQvQKHUL/EkGldWNVVSSUTJm9yvyDbIsBDoeoM=;
 b=DHjx2evpoBNMrSJswvbPE5OI8PBFVChrHNIkrbkbFSZd+zSm/NltsgYPquHGdBuiyS
 iwWer/8VWt+qIphSs6FbVqAdTGEL/o49chFE8zfR9YWrgPykwOuNbND9XdYXrq7YwWYS
 chjNWP4V6Lv2c2TDCwRJT37cjHSz2NLp+FdjZfgEQB9XUYbXMbxkHcC4WCkA19cbWpN4
 U/GJqYHU0aHICB5xo2lJwtk9m2cMQjfKY960d54Y2pgDXwTeyVG8X1qQS35L8iU3BYr/
 TTULmHCrvd6b7cv62hPMuT0MovXgqF6lKNjWwpesBUJvyWpMKblEXXvAQyB7fEnvtss7
 KQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746160; x=1696350960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGeZiwQvQKHUL/EkGldWNVVSSUTJm9yvyDbIsBDoeoM=;
 b=cXuC4prDiUX02ftg1iIsv1iqlpcrZFW1YkWB23gx0PGWYdOjpK4CFUlunITExTU92t
 YL5SgP2IOKkcElVTyrd+V+Ur6hJjkSb5d/o00fkGHbW+UKdxvuE4OVpF+VMfOjsBMHgg
 ubxNP+zHCXXAfEhCELamKljQ5boa6o47QXACgWbPzMIe2pGqRb63W7Tmbu+cXT4DzXgz
 jc7ywj8CHg6ygl5cnjUc8Ucmc47xfTGD5nem3XgjAaM0M40q7hTlW10HeSCFs88TXsqi
 2V7Ben0Us7xJCxusSBsc7zPTdy9lWOxmHsiNeBRozwPKqspJUZzUKyftkb6uVIPq/t6H
 vo5w==
X-Gm-Message-State: AOJu0YzfqJc68dYIVvDo0vKu1koRUDYSdS+4+CchtYMhbi9T5Sz7WCPF
 9o6WgByuqngxuetWfGpppcTrAQ==
X-Google-Smtp-Source: AGHT+IFRM5N1HSnlYrKAuuMKS6DasEkNnJTxIwl3aayJnp2QYZtoRriMaZo8Ai4rrNLw2kuuIEe7jg==
X-Received: by 2002:a2e:3a13:0:b0:2bd:16e6:f07c with SMTP id
 h19-20020a2e3a13000000b002bd16e6f07cmr8354325lja.17.1695746159663; 
 Tue, 26 Sep 2023 09:35:59 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 x18-20020a2e9c92000000b002c12630e4d3sm2698544lji.127.2023.09.26.09.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:35:59 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de,
 Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v2 2/3] arm: dts: at91: sama5: Add flexcom4 node
Date: Tue, 26 Sep 2023 18:35:09 +0200
Message-ID: <20230926163510.219804-3-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926163510.219804-1-artur@conclusive.pl>
References: <20230926163510.219804-1-artur@conclusive.pl>
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

Set up flexcom4 for Microchip SAMA5D27 SoC and prepare it for usage in
I2C mode.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v2: new patch

 arch/arm/dts/sama5d2.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index dd6468ed96aa..819564fdd5bb 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -781,6 +781,26 @@
 				status = "disabled";
 			};
 
+			flx4: flexcom@fc018000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc018000 0x200>;
+				clocks = <&flx4_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc018000 0x800>;
+				status = "disabled";
+
+				i2c6: i2c@600 {
+					compatible = "atmel,sama5d2-i2c";
+					reg = <0x600 0x200>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&flx4_clk>;
+					clock-names = "i2c6_clk";
+					status = "disabled";
+				};
+			};
+
 			aic: interrupt-controller@fc020000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,sama5d2-aic";
-- 
2.42.0

