Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF103C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF5682DF2;
	Fri, 13 Jun 2025 15:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m7vSRSaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66DCE82D32; Fri, 13 Jun 2025 15:22:17 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997CC82CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-606fdbd20afso4146422a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820935; x=1750425735;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QSwIA5mNa4+xpp+hTFw/bktLVt7ObwE492iQQt71g1k=;
 b=m7vSRSaMiBotleG8eYPXdcaT844SZFB1kx9vgXaDXAhUjc57+TGVhHTUkmXWPPEk91
 H90oV2SY1ytjh3/k/whMuweT+/ar7gOVdscHVvR7B6evMHZb9y/t09lABBkEPQFylaQP
 AoBsYBt8x+ngfMkFOqjZxNAc8EoSxxktenijnuZwSOiB9h4RXIcAt1de6XvQ2YpbS6lK
 1khHARAW06T+B0JzOVmy1zyKlQMfdkTXPGxX9iaBhzQfxEnt1IHqV8nsWNNE96yv2cuw
 3WvqPjZbHO38Rb0kXmGBbhhd9HNFCYvlRpqAAfskuQO9juihoImU4TQe8GWvTiLYFjGF
 5+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820935; x=1750425735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSwIA5mNa4+xpp+hTFw/bktLVt7ObwE492iQQt71g1k=;
 b=UDbhtpoAjk2+GVl2z7kcmvQ+k2yg7wYPqx9f13s8nvKazMa7aYP6WzC+QvR9TyUBDq
 s9rPw4pqjW1Ov9wcJwwcQPXyRTdGQzIZSJMPExj+La7P+yZP3NYnFBBTR1GPpWhKheDA
 5NOcXqGLRB+fSeNbNSsZHOr7LH4q4G/6uGGcI217t6gZJu1LfRaKfNL1PM0taiu2J5xX
 WVsIdXgCF/imiNLLls8UD0LcmSgx7al/skD6/K7Tzp00kiO6gGJ0k/3YWfq3DIP1jZnO
 4djKT3/CIiWQFekziXa50Q1bc8TnALUVxfVjx/NUvb+o/KZFQg1Lqm/RyOuRzZPflupm
 gRNg==
X-Gm-Message-State: AOJu0YwR1lUEjz1ap8hirSXurnHYgAffOdAxtpctoywjrAGBrBRuCiEA
 5+qrLQNgicICmvBZke4dlh4a/7lJOhns3LHkUI1LIG8DY5HJezMKM+SO8DHckfaUpiZI3EbmRNl
 j8snn
X-Gm-Gg: ASbGnctemqzw9T9hLGplKMGNl2EQVxP95SmaHNf99NspbL0JGzkDKu+5jA2nfZvyfKy
 JJqZZuBnNAZxJTeZ4qXJh3VoHNEunt591l4uXTaESQA9Wl9A8vq5646LUxmvYH0OCFVJ9IxkM/T
 aWy27NoLOb6ll13VzNuQC/ht0JUMwP9aD57Ptd+awPA+t2BSIMuLHAvXtyhD+6zTD1JXywBLWhd
 9umCu3ZU61tbTXEfDWLMESh7Ix3PB/LDi57+GKVJAsgSZwLwQMc/lmHSaXVRLOOjBR9SatsTVs3
 anW/kNDjLKOpHMsNB98ajU3glV9+kxPxYUk1VyS2C+gvhtJUx2nTu7r8Vas=
X-Google-Smtp-Source: AGHT+IFddZaiQp9OMJFiBVillGhrGuD2JUaWdfzZYcF4P3mUZ7TKz8HrKLiJmD281fJHRd3M7mClWA==
X-Received: by 2002:a17:907:7e85:b0:ad8:9e80:6ba3 with SMTP id
 a640c23a62f3a-adec5593608mr257247066b.7.1749820934493; 
 Fri, 13 Jun 2025 06:22:14 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec88fe7e0sm127389466b.76.2025.06.13.06.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:14 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:39 +0200
Subject: [PATCH v2 19/22] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-19-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=msp@baylibre.com;
 h=from:subject:message-id; bh=v8z25nqKH9oS4wesytZdHU8dhpwffiQJU5A55TVG9OY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1TtcnL+DDn++WWFWX1+0yJLZI2m6yo8vR3f2PLOzf
 jlx5gbOjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhI2S1GhhNbV87+evaft6Dw
 kTUS1nMubrnDe2ri/nO7Jnt4aoduEClmZDjSGj7L5XaGYaq9J/e9E+KPfURNTrTbL4j/+oRjrji
 jIgMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

These are needed in SPL to be able to resume from DDR immediately after
booting from IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index a70fc88317e04de032e4da1428e25eb78ecc30cf..7e6a76f72b2a63bf706c3839189b6213aee4497d 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -14,6 +14,14 @@
 	memory@80000000 {
 		bootph-all;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
 };
 
 &cbass_main {
@@ -68,6 +76,14 @@
 	bootph-all;
 };
 
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};
+
 &cbass_wakeup {
 	bootph-all;
 };

-- 
2.49.0

