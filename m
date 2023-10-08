Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3352EE95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 15:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F1AF86672;
	Sun,  8 Oct 2023 17:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A+taauqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5065786C67; Sun,  8 Oct 2023 17:46:01 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F4386C26
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 17:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ba1eb73c27so51967666b.3
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696779958; x=1697384758;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5eR9bRRHywOAXEL1MIXLGvA1aY2uYlOIkNO9+SPfqo=;
 b=A+taauqFRSA00RnjLydkknWL+DQ3v3MUopCCzW427qbIl8oluFs7gsmCfFv9VrK2ZO
 kpnmG0EugcM8ky3iXqi73BV82duJVDqX8gEreB4RAz1eWArwzXXLFUV2OdF2SbY7E66o
 5gRmu/2iB86EKzDaO9JaxZRr++n4uOcq7p0yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696779958; x=1697384758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5eR9bRRHywOAXEL1MIXLGvA1aY2uYlOIkNO9+SPfqo=;
 b=C+DfQxfSWW7MD5Fax4zXpFn3tVWRF/YhtloDbz7QBak4HIYT8EjOrpO6O0UzP4aF+U
 AnMY5yz8eaP4sDT9tXYFJ9JKnvtPUEcPwWeETMGa6Yme81PAMtHCJcPQ0relHbwXRY0P
 IoVRypGR96bpO9bQUeABhXge1FJ+4koHduODXiTBWl1m6CH96iNglbNEf9vY2X//a7Z9
 R+mSljXwSaIr9eNk5HDLOx6JX2zVuDj/zZmQWZ5aJ8kZf1LAPpzOBoQXqzBbJeFMw5fT
 sLTX+jKhA4vwN3pKb9RTbD3pJgAkLSD/J8wbH6t8F//uhPyVcPxdYHiN+B7PE9dEil7e
 EU1w==
X-Gm-Message-State: AOJu0Yy5jJOsyxjiBAto6oM/9tTapkFTUhSd/r4L1fFLuK1Q5U4HWxNo
 RRzuZW4vz3ele6WWnWXdneYvATAXK+U/dWxZJqo=
X-Google-Smtp-Source: AGHT+IHnf8QADa4o3KbV/r04CNVqzif7AjhOewt7ufnOEzPplovXFTQzANdkT40WauVECRRbMGWkmg==
X-Received: by 2002:a17:906:7696:b0:9a2:24f9:fabe with SMTP id
 o22-20020a170906769600b009a224f9fabemr11907644ejm.66.1696779958558; 
 Sun, 08 Oct 2023 08:45:58 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-50-102-159.retail.telecomitalia.it. [79.50.102.159])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170906f90b00b009b9aa8fffdasm5623981ejb.131.2023.10.08.08.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 08:45:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v2 1/5] ARM: dts: stm32f469-disco: sync with Linux 6.5
Date: Sun,  8 Oct 2023 17:44:53 +0200
Message-ID: <20231008154538.1622772-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008154538.1622772-1-dario.binacchi@amarulasolutions.com>
References: <20231008154538.1622772-1-dario.binacchi@amarulasolutions.com>
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
2.42.0

