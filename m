Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA86C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 19:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D026081FC0;
	Mon, 31 Mar 2025 21:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="i1vtfKsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01B581E6C; Mon, 31 Mar 2025 21:16:37 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E48C481DE3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 21:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43948021a45so48594635e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743448595; x=1744053395;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXt2vRu61z0jBTsyEAsz8S6NR66zPfB+9qtffZap4G4=;
 b=i1vtfKsGZQkdS1CpOIyW28dyB2LXnmQaRSUC0Ys6j5s+7kSrxuIr+mBhxdp7x1sPI3
 QjwATg1/TuDGEb3F8v4oTY3yH+wCm8r8fj2EuEmxqKDnZefqohbFwcMdw0pvALhg74PD
 cIz5UlWz2XphVF3P+yxTr1vLa9Ir4XYD7sDnCysRzB4DT7ompyvgw6lmtBPT9oHciNaR
 dQd8R28ACNVIaDETI3ddRyfJi/d4lCqXGkaE1f+M4wVoAoWhaKkQVXrHCGGVamlFm2kR
 pCSbJsIt1fgfGVX6o9zwe/wp2GB0s1+sS4ncHa8PNqZCTwJtNFK2ETk4fxqS1NZ4Us+L
 x+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448595; x=1744053395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXt2vRu61z0jBTsyEAsz8S6NR66zPfB+9qtffZap4G4=;
 b=WWu0W26md6E/q+EgOhQV/IZ36B0p9gTG+8DXUJn3UBfzkxyeBHuSncFhAwsZrti2Ha
 PNSChSfUTLJQkUCL3gkAuJiGvv2CeM9kw8XttiVJu89uwrS7kO0TOVWY/m05IxC3yCsc
 FlF1C0sdegiDgAHYo5uGMgn5hPUa71BQsS729+3X5Y6/luhlowpQTA3lorQZo/5fUq7e
 S9M166HqNKeHE/MhYinqbIDka57TgeXGn0I2uTS8BzzsUdK9Rh3rhQI1N/tmdbEP7dwS
 iHTunqO+5J9tzJKoa6AfoEpJTRmhNSVIMdibQbC4dM3yXtUJTyAXcDuIyTXxeOVfLKxd
 VAuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUikq73u4+2++oxEpQZ94wJXzYUwyzh+ZUkW/dsRcIVTxx6Nlrg3+2zjHH8aVDqljepRTgaI/c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4LDeS8k7H98ZodOry7n9KFasZxSCmXbTbHolsvJjF+YvnN2XI
 0sVZPrNfTLu3fos0d8qIdMlJSfKFIDg8iZC/udVEPDTz+ZFE8pQwZs7rvUY0+WY=
X-Gm-Gg: ASbGncsV8eVVrz49Ng1vE8keXXfttN9tnNVIFW+SoV7EJ26k8WLax9ZoZ5IgINFannU
 uTas5c+0EufECBJ5HebEKqx9gNsia8lAt4Npv/I/1P5yJmYul7UMEczBxVMXhdjrEyP+CmOe8oO
 RlaR8fFLA0zYe4nNB08Ymlr8HXVjYTYg5G1wV51WYA57Q/AUv5JJi9YO3/pMSPBwO5YAus0if0B
 utnAGz3vYBHt6abmmpJ6ISFLwdOSDfB4X5K5kRMZmQtJfkJv/l3rzW9tX81vl8Auq25LFkft8NT
 2VFvGuolrAhN/c4ITestsXxgVSER2UcDdv8kRq/tpljAaTAg0/2sgqTFGjeDxfphdXs=
X-Google-Smtp-Source: AGHT+IFaBw5qKG8ut+dI7ft8ckHRNzUy3jk0ZmBe7RZub8TWSqQHEbj2GKuos2AgDu/XWK0QlA0/HQ==
X-Received: by 2002:a05:600c:45c7:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-43db62264c7mr96520115e9.9.1743448595288; 
 Mon, 31 Mar 2025 12:16:35 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm173144165e9.6.2025.03.31.12.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:16:34 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 6/7] ARM: dts: sam9x60: Add watchdog DT node.
Date: Mon, 31 Mar 2025 21:15:15 +0200
Message-ID: <20250331191520.1805001-7-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331191520.1805001-1-admin@hifiphile.com>
References: <20250331191520.1805001-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 21:19:48 +0200
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

Add the watchdog timer node for the sam9x60 SoC's.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/sam9x60.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 3b684fc63d5..f32d51eb231 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -333,6 +333,13 @@
 				clocks = <&slow_rc_osc>, <&slow_xtal>;
 				#clock-cells = <1>;
 			};
+
+			watchdog: watchdog@ffffff80 {
+				compatible = "microchip,sam9x60-wdt";
+				reg = <0xffffff80 0x24>;
+				clocks = <&clk32 0>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.49.0

