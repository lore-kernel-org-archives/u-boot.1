Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFDEC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 07:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3598687E6D;
	Mon, 26 Feb 2024 08:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AluJcd07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AB887E7F; Mon, 26 Feb 2024 08:14:22 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2740487DEF
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 08:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a437a2a46b1so11657866b.2
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 23:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1708931659; x=1709536459;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Lky+e7UjjadIrtOdD+T3IkSI5Q5XTDB9A++yDGrII8=;
 b=AluJcd07+k/od6UMy6QnarpMJFQCgsnqPEXh3X4i+Sjdh7QCQNYr+WNhLx98SnKKLx
 EX/fIOR8/qB5QfkXS8BiV2W/8Itjuraw+z1Zf6go7yC1wg4e81H3MG2RO0l8Cq+r2I8e
 geZUxMSZ3YY9cpuq1/dE9g0xt0d22Li/eDm8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708931659; x=1709536459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Lky+e7UjjadIrtOdD+T3IkSI5Q5XTDB9A++yDGrII8=;
 b=kLbpNBm/MQjmGfTIyIleD/zT6DqALp3wSp8Y2MGKWMOIegLZYTzc9DvpLRnwFqFoI3
 jLTMMO1fI/4GbbZO3jy5ynnxsLxRO4zH/F5S03wlWGICWYvPKszdcGKOtdTIif6dw2dz
 TJUSNdniJeqm3Fb0wGjlVI5u6j2D2Ipf6NILXq2g+aloWPwMNvKEEvRRAAOO6TzEQuTE
 L6mb7oDjrQG2w2SqXOl6GX+/KUmdd5XpbKKWJVNl8qJUYzoObcWlKamE+eE7JZAgUox6
 l0eUrk5qDLMVN3IAqV/oiyAmZWLPVythuov1Sk5zhKdCN9apHG9AW9c1yfTXPyqq3W7s
 +O0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDdPFesZPBmjVpMNMEZfrDDbvgT0Rpm4FQ7MlrS17Iy5Di80/hLf3QTafRX0cuxT5czuAjUYx9geb6maMWLts41tW3CA==
X-Gm-Message-State: AOJu0YyAF6GbdC1enUKPt92obkboZwlKrFNGm2shVDC11sJ4nj/J/VNf
 9ch6gUyvWrXTUAROSNkbqu91CwhDC3dxBp8Mtu0ijRB6jHal7IcuxTxzDA+fl/k1KQ/cDoatRW4
 ltgYl8Q==
X-Google-Smtp-Source: AGHT+IHCRZG4Jp8a4mqSA7OHxKdBIq91PrYr3ah2mcClR0VE/CEPem6kIgkEddHMhwtd+19Av3XfhQ==
X-Received: by 2002:a17:906:a891:b0:a43:7a2a:127a with SMTP id
 ha17-20020a170906a89100b00a437a2a127amr207150ejb.77.1708931659422; 
 Sun, 25 Feb 2024 23:14:19 -0800 (PST)
Received: from panicking.. (host-188-15-122-229.business.telecomitalia.it.
 [188.15.122.229]) by smtp.gmail.com with ESMTPSA id
 le5-20020a170907170500b00a412e9e9741sm2121685ejc.110.2024.02.25.23.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 23:14:19 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2] arm: dts: k3-binman: Make optee optional as requirement
Date: Mon, 26 Feb 2024 08:14:15 +0100
Message-Id: <20240226071415.1705492-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.40.1
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

Allow boards that use ti_spl_template to not use optee part in
configuration.
Vendor can have module with 256 Mb of memory and they try to optimize
the available memory just using the essential components.
This change allow to remove tee from configuration without binman
fail.

configurations {
	default = "conf-0";

	conf-0 {
		description = "k3-am62_ccm_m3";
		firmware = "atf";
		loadables = "dm", "spl";
		fdt = "fdt-0";
	};
};

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
V1->V2:
	Adjust commit message
---
 arch/arm/dts/k3-binman.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 758c8bf6ea..5ef5af315a 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -293,6 +293,7 @@
 						keyfile = "custMpk.pem";
 					};
 					tee: tee-os {
+						optional;
 					};
 				};
 
@@ -360,6 +361,7 @@
 					entry = <0x9e800000>;
 					tee-os {
 						filename = "tee-raw.bin";
+						optional;
 					};
 				};
 
-- 
2.40.1

