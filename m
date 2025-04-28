Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02725C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939D78212A;
	Mon, 28 Apr 2025 19:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="TYHG/43C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E2182724; Mon, 28 Apr 2025 10:38:03 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10DD82385
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so46370755e9.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745829479; x=1746434279;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9gffl1VoYpT+vp4eddlvLOT/og2Q2KowTxjVPosPhlA=;
 b=TYHG/43CH6V95VaevEuw4bu2+NcWr5443jpXgdVeEQ1uRG3TKGWvwQGMQZASEZ5xDB
 HnhkCoe7sY9AOm6XPCy49V1L69rA5gex0qICAQsW2gOBm8p+nyNweKN2C8tUXK/6s4wB
 P/ijQL9kUMEIm4gwx/cptdBHfhtOSr0b6/Dj4nHnCUeLB3TN0TTeToGWcBBHnPPGYolH
 1Rfha2iOPJpv+njIn6ybCs4CnDtZrDk9gsN1a/vlIQFhTslFvCPkBECV9s76bKeexHGx
 R9pThExK1WEFmEu0akRl+9yjFVZp0utFLg0B3bHj0q4Ga7zfZhJav8sGA6bYiR545A7g
 MOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745829479; x=1746434279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gffl1VoYpT+vp4eddlvLOT/og2Q2KowTxjVPosPhlA=;
 b=qSbH1lnbJrkIKFcncppNSfYK0bh7T1CgOP/gT+AjO3UwJVhntMvhxQ4oz7K3Gnu/Z1
 i1mCsGPcZOOUJXD8MVrNYJeeBCKpAftumx5fRCSvPK0XZXWuC+CD6Z64k0qwE7Dn9UA3
 1CxycxqAsmEgSXvhgFLuljRVNn7l9RwlWOOwp7Ibsfmg2H4JWglG8dKVNUddY66ABizA
 EE3XWV6UL3HD1JZ/C8KYgqZjdgojCtrI7jXDlsUr1T6QcaanC1we4OZhhNwRNnNAc42o
 e2y1iyhrLgnY0cdJ64CW53Cgt6+/Vjp2rahHFpIPBGQKDrDmcYrVtM1jU/fDebMORIu6
 BDCw==
X-Gm-Message-State: AOJu0YwOKemHMiLHhdpN/MOtKdN+IdGv/jz13IqscmaD4fBplQehocd4
 GaeZF9T1fJlyYBfLOO6EV7p7Jz1xeJEQQM0l25y37wmsdpYSyOY1WjEHECRh71w=
X-Gm-Gg: ASbGnctE1lJZ6nog7A+5QQgFvI5VgoNN4FCG2whwqkZGcQ0G4I3kZjCUytikqpiT3YO
 RWYTm+DeBhqZLHwc7/93/Kc8ANZSViv/oB+btuhVNqkmKsdMRk22stu8ukCU7NbXrDBPa+LfaLy
 s38337oOlnzn/gvBhomkHNnLGGzoSQc+OfhRS4SeS+XpjCAq803rTxnAji6V4/x8vtkjDTykb26
 gOOMPPeDj+TpU/G2rXez/WSi/jTbrQ8la4kTGkvaG2SUJ82hNnEC1htHWXiQh9uPBgT8ZR61DjY
 bUB11OwVRt2TIChOjv4DCNQ63nFNeHNFciQ5bF8=
X-Google-Smtp-Source: AGHT+IGXyY9eI2oIO3oU7D9wrb7jOa/4xYPHdQXFmuveBWDP7zMhQkVzLdG+ORLHzZmfa1qdYOQq5A==
X-Received: by 2002:a05:600c:3d87:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-440aa428e25mr78788705e9.17.1745829479191; 
 Mon, 28 Apr 2025 01:37:59 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm121139285e9.8.2025.04.28.01.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 01:37:57 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 10:37:38 +0200
Subject: [PATCH v3 5/6] ARM: dts: sam9x60: Add watchdog DT node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v3-5-86f0c5d92c32@hifiphile.com>
References: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
In-Reply-To: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

A default timeout of 16s is added which is the maximum supported value,
also matching Linux driver's behavior.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/sam9x60.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 7631dfaa07fc1e7c605c70840da1196c1daeb638..588d2cb9f5109396b11a11e497eac282dffb4fb0 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -311,6 +311,15 @@
 				clocks = <&slow_rc_osc>, <&slow_xtal>;
 				#clock-cells = <1>;
 			};
+
+			watchdog: watchdog@ffffff80 {
+				compatible = "microchip,sam9x60-wdt";
+				reg = <0xffffff80 0x24>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32 0>;
+				timeout-sec = <16>;
+				status = "disabled";
+			};
 		};
 	};
 

-- 
2.49.0

