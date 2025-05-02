Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B46CC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E2D82CCF;
	Fri,  2 May 2025 17:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kq5TcPmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D993F812BC; Fri,  2 May 2025 13:36:39 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6C880F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 13:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brunosampaioleite@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54e816aeca6so2299977e87.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746185797; x=1746790597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DngyGE71O+5KDO/rvz04RbpQsOQkezoG7f0TpieMlfY=;
 b=Kq5TcPmbn0Rhk31YlT+kplpZzUNzXBPccXjevDo7h/k85+TWOTc4M2QHJ0YOsu9LG5
 2q986yYvMHOnf9b9k77E4f2VufqBhmghcpdcgDRwob2eP0wGhOfOKquy40a7oPJ0m5zp
 nPKwoxg+zDHA0fD/e9U3yvbr//gRThBNnj0HUPHfzcZeEdSh3rxLjJDgv+12aqqsdzyb
 N6qlAhoFMsGwULpi0Sr5JcJo8z5D9Y8MSph/nKDa+oifOIHZ+uNUH3BAATM2NK2Dkxas
 8W6acfXkliNJ1wzZdHTWk3Z++g3jU8DHEiUQsXRLNZgMvpavJfUfoCEXdh8aJ5SVw1l3
 BYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746185797; x=1746790597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DngyGE71O+5KDO/rvz04RbpQsOQkezoG7f0TpieMlfY=;
 b=fME3MBRehlplv8/GeFB6kVbczlEEGtjmBdlcIqs4GRZCQ179nAkeBTD8ceaP3cgw4x
 Ly46bFo/eQIL5t4UU1UDyNDmpT/PN7HgplQ5B0clzkq/4k3KT5Bo39E9brBt4qht5dR4
 sNBB5YPhAQWXd+jzZARdr65eFV/Zdclt5d+r+jrVC1b9aB1oaa3iNsbUGCeRoZFJANx4
 OBm0llb5e9bRqv6W69PHbvgT16sahd5rdY0X2QANk7LPdZzBYlrqQzfZDiADBtjYIhy9
 knGjoc3YcMRXrEWI4RofbMtTVPnUh4TeWIgmd7JWt7YtuLG8SsJkx9TRFM5G5MHGiX8W
 kuNg==
X-Gm-Message-State: AOJu0Yza3eRM5AZCRJR76yGDYBm5EmSJpRnrc8QahR85P3vYSMRRnLGQ
 BW4ArioSscwf2JIxMFKvEalpgkPhG1H2pxn2b6WkurCYDS1Zvuyq4rw/B2H/yDE=
X-Gm-Gg: ASbGncv3aAZczMPeZ0L7kNcIcIeb2N+EH9VU/0Fsv8DtIkMu8prFNk7ZhVMTxg/V9vO
 yHnFKEpqSxN4sGe19QDQZTnIf8UxY5uteUHsDNnKmD3ClKCLy6mUbJhI6YA5au/TRv2I5JHKvuF
 gwuQ2bqB3IjDYoyJvHEiocDo9/OcaMex28kD7bb+iOe+y3kcetIlFIPj6NIwzEu5fb1g8ESDx8+
 aOKRCDf3lK3RLEEnNBkynRkyPOkBv+V84jvKLQA9x7YNdTVwWoafet7G3FTpI8hgkFVdsPweGFC
 jccfdNLxO62V2muMfhQNedEi3+7YivMav6FOgL+N8A5ytYkIeYs9nwz6a5THQxr2+4l8xhQmcw=
 =
X-Google-Smtp-Source: AGHT+IFRU2TMHIyNdDRXyFqxQ1iPW+8qXzcwLRopPH9qJDltj+sm8CDNrhxbJlmcIi02oqzB/FQ9DA==
X-Received: by 2002:a05:6512:1585:b0:549:b0f3:439f with SMTP id
 2adb3069b0e04-54eac20b9e2mr512841e87.25.1746185796641; 
 Fri, 02 May 2025 04:36:36 -0700 (PDT)
Received: from brule-Precision-3590.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3202a89ef3fsm3172141fa.69.2025.05.02.04.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 04:36:36 -0700 (PDT)
From: Bruno Leite <brunosampaioleite@gmail.com>
To: u-boot@lists.denx.de
Cc: ravi@prevas.dk, probinson@gmail.com, Matthias Brugger <mbrugger@suse.com>,
 clast@prevas.dk, Bruno Leite <brule@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: dts: rpi5: add rpi5 u-boot.dtsi
Date: Fri,  2 May 2025 13:34:34 +0200
Message-ID: <20250502113556.134731-2-brunosampaioleite@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250502113556.134731-1-brunosampaioleite@gmail.com>
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 May 2025 17:01:15 +0200
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

From: Bruno Leite <brule@prevas.dk>

bcm283x-u-boot.dtsi modifies dts nodes that the upstream
rpi5 dts does not have and thus break build. add an empty
dtsi that is more specific to the upstream dts to prevent
u-boot from trying to build that one.

Signed-off-by: Bruno Leite <brule@prevas.dk>
---

 arch/arm/dts/bcm2712-rpi-5-b-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 arch/arm/dts/bcm2712-rpi-5-b-u-boot.dtsi

diff --git a/arch/arm/dts/bcm2712-rpi-5-b-u-boot.dtsi b/arch/arm/dts/bcm2712-rpi-5-b-u-boot.dtsi
new file mode 100644
index 00000000000..65219f158e4
--- /dev/null
+++ b/arch/arm/dts/bcm2712-rpi-5-b-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Empty device tree for raspberrypi5
+ *
+ */
+
+/ {
+};
-- 
2.45.2

