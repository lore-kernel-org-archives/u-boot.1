Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF0CC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A928987698;
	Thu, 30 Nov 2023 15:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FE7Py2Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0CD876CB; Thu, 30 Nov 2023 15:40:45 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21FB18768A
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a02ba1f500fso150382966b.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 06:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701355240; x=1701960040;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHtB/gjCqoaGx3nMaIVB0z7NCcHI/Pzgwo1G9q5/xWU=;
 b=FE7Py2JfJUWdWS5mY++QWrdbzHz/lbo2UQab2yTlqWPd8bG1m4bXJ4g0GzG05ZyW9R
 PX5W34IzKE8d3OU+3geSsFdMg9O2mr7EUnHr9IX+oaryp64uOL/NUGVBS/k3Zy+5Gox3
 dPWAk+VHqgu7o2hB70HTWJHVBjsaBekNjBgBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701355240; x=1701960040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHtB/gjCqoaGx3nMaIVB0z7NCcHI/Pzgwo1G9q5/xWU=;
 b=sO97MhaAU+ftZnALTORMMUFQNKqpnPo1yd4RqPkq7MBLSAurua6N+lG8Eu1asu4N2C
 eAq51Fsc/5dP31a3tzDjBHI+Mv+07enJi1pwOPYzKoBcNgWrlOvMPKhEkOwGk3ke6T0B
 Sp2lN2MY3Fam+LR1y7XrA3eT0WJAu/fpe5gGRE3hwQk07TlOiEhkGxG3/WbphiAdY9/p
 nZgfWkLQKWJLX9kvnpYNaUPF7MUO70fThELZQuyJpwGSD5hzmqYWtt3dBNR8Mq7JWzLX
 rT0wakXhwGszJbrU0H12Pa24tkHl8hCreMfS07xt+QvwV2sJhugdfbrtAyFo5kO20DXS
 XCVA==
X-Gm-Message-State: AOJu0Yzd+Auy1RGSiak8k87+uVwgFEwjWD2xxyGwAPGv+N/Tn5ngzM5K
 QllINqfXs1/LHhcZSacH5i1+Oc2NMzqJorCUg53XOw==
X-Google-Smtp-Source: AGHT+IGH+tpbxu5/Iz+WVP1mjeVt7A/I9rdfSN22nQ12xWfWAYbhlSJ5UPNKMBB+0/lesec7E0/7Aw==
X-Received: by 2002:a17:906:7e05:b0:9ae:74d1:4b45 with SMTP id
 e5-20020a1709067e0500b009ae74d14b45mr17412283ejr.65.1701355240337; 
 Thu, 30 Nov 2023 06:40:40 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:d1eb:b106:516d:db0a])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a1709064a9500b00a18399ff790sm733470eju.215.2023.11.30.06.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 06:40:40 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [RESEND RFC PATCH v2 1/5] ARM: dts: stm32f469-disco: sync with Linux
 6.5
Date: Thu, 30 Nov 2023 15:40:02 +0100
Message-ID: <20231130144033.1850298-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130144033.1850298-1-dario.binacchi@amarulasolutions.com>
References: <20231130144033.1850298-1-dario.binacchi@amarulasolutions.com>
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

Sync the devicetree with linux 6.5 for stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag.

 arch/arm/dts/stm32f469-disco.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/stm32f469-disco.dts b/arch/arm/dts/stm32f469-disco.dts
index 6e0ffc1903be..c9acabf0f530 100644
--- a/arch/arm/dts/stm32f469-disco.dts
+++ b/arch/arm/dts/stm32f469-disco.dts
@@ -119,7 +119,7 @@
 		};
 	};
 
-	panel-dsi@0 {
+	panel@0 {
 		compatible = "orisetech,otm8009a";
 		reg = <0>; /* dsi virtual channel (0..3) */
 		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
@@ -138,7 +138,7 @@
 	status = "okay";
 
 	port {
-		ltdc_out_dsi: endpoint@0 {
+		ltdc_out_dsi: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
-- 
2.43.0

