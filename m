Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D01CA1008
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1AA88C9C;
	Fri, 30 Aug 2024 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dCgaW393";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C818088CF7; Fri, 30 Aug 2024 17:57:47 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B77B88C4D
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70f6cb5518aso346659a34.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033464; x=1725638264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9pNeFmCdL12rOn66diT5pbvz0zTbF7OwHhL6mMDQC8=;
 b=dCgaW393yBlXz26ZtGoplDjSEtsNUwIKsPK6P6ALq95+vqGjsU5t8hkpstEKGLjACO
 s4Oi+dvj2kYM3KuoHQaUY3LPCCiVri+ZaXOIW3zsGNrLuI1hC7LrrvGEpCYayDAyAAsG
 Xj/dkBNPpdeI+1F9Y155t94//BhntFoHuxBHTSG5U5X+NMndkLNFrd1Va08YQ/QlPra/
 HdRe/RG7nHdmoSiA7GMTvvIBY2RWkOXgeMFC9Cgb1sxQuqEA1wtv05UqM2v6t8KFPH1C
 RxO1XyKGI6cTRPcGPGHGPJI4wGQjlbryFY2CBBT0IjKxn9a9E79VkobS2iQEX70O7fk0
 zJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033464; x=1725638264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m9pNeFmCdL12rOn66diT5pbvz0zTbF7OwHhL6mMDQC8=;
 b=JWVKjYJNoSfTed28YmaY+dosjUyJnWTkjvNQJ3nh7yTHVtSMbXNuauITcWkcLLZQSo
 BYs7y08sfyGPmINvhKFacs4T+exBmqbFic2UoxxCINy3jd1HqfNQ8ZXkXoCkFEJad0LT
 iOzNzmWOJx032Silxew1o3iNvKsxcqyonU0H4/zlh6hz2L+fsTDOYhEKJnmXrkGTnb6p
 +ued8K0UEpgVa1mV5t/NP5uJC+ulIAzT08+ozkp4CERm3K8UNSAdXTlMh7nm/56WCwcL
 DUXRp7pNwb8k950ZjJ9w16W+kmU2R6hZMsiDwtg7BdtfXsIjLuUR7w/rlJ5wDxKUsIAs
 sHbg==
X-Gm-Message-State: AOJu0Yz+GJDr2HkUwGn58uBOWGNv+dfXbd4Sm4OXM7uuvCevkfafAMru
 86VTIVmERgxw0o3xVgrkrVOKYTksN8NO22eS+JhTZReai350GebN+WfAKw==
X-Google-Smtp-Source: AGHT+IEQy20l9GSiVtUdNG0/vDPOm/WmLKzLq6SKpe8+EWNVSjp3VgC/btzwfI4RQI/eivjzghVwgA==
X-Received: by 2002:a05:6830:916:b0:708:29dc:d2fc with SMTP id
 46e09a7af769-70f5c3a9a52mr6552587a34.19.1725033464013; 
 Fri, 30 Aug 2024 08:57:44 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:43 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 8/9] arm64: dts: allwinner: h616: Change RG35XX PMIC to
 r_i2c
Date: Fri, 30 Aug 2024 10:55:13 -0500
Message-Id: <20240830155514.481410-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830155514.481410-1-macroalpha82@gmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Change the Anbernic RG35XX series to use the r_i2c bus for the PMIC
instead of the r_rsb bus. This is to keep the device tree consistent
as there are at least 3 devices (the RG35XX-SP, RG28XX, and RG40XX-H)
that have an external RTC on the r_i2c bus.

Link: https://lore.kernel.org/linux-sunxi/172252952262.1669767.7675865282122079154.b4-ty@csie.org/

[ upstream commit: c712e5d0985628b1df13930489b49b740e610a2b ]

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts           | 6 +++---
 .../arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
index ee30584b6a..e2bbd22bd8 100644
--- a/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -201,12 +201,12 @@
 	vcc-pi-supply = <&reg_cldo3>;
 };
 
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp717: pmic@3a3 {
+	axp717: pmic@34 {
 		compatible = "x-powers,axp717";
-		reg = <0x3a3>;
+		reg = <0x34>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-parent = <&nmi_intc>;
diff --git a/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index ee30584b6a..e2bbd22bd8 100644
--- a/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -201,12 +201,12 @@
 	vcc-pi-supply = <&reg_cldo3>;
 };
 
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp717: pmic@3a3 {
+	axp717: pmic@34 {
 		compatible = "x-powers,axp717";
-		reg = <0x3a3>;
+		reg = <0x34>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-parent = <&nmi_intc>;
-- 
2.34.1

