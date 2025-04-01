Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93A7C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993AA81F54;
	Wed,  2 Apr 2025 00:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/bOkoHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36AA481E6C; Wed,  2 Apr 2025 00:52:38 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B32B8171B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso46419125e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547956; x=1744152756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MAhmRFd74I3yT9uRFvKNock/ejiQI0z0vKOX86u72Ec=;
 b=c/bOkoHPeaCLNSFaKx/lpVtcKo/T36+zhQqKHpPTAh2CqLM5W3qvEYyFrYfvMU6+xW
 cnHuxKCaRiYTB5C3nJ4NLD4XmQHPGaiC6y9V4MLpWLzO13zYGoI1LB7OvkCtZzoa1DSX
 OM0i6vWJOLQqFZs/3T0yyiBMAFuWwNiZSiaeduMgGahNSQ4FvpjwV6M6MI4AesuUOqsO
 ppnlzjAd0vLCIXkJe86KH8D6Cq5uid2KqlLQOZf9YTlizqE8ORPlYX7I2Y7L8TvQvH8+
 ogqoRD7Jwcdd9UOXu1DYzo4ng9VYqfvbMn4U1SLUXGRv20iS62TTA8mzAdoh6creoUE6
 zqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547956; x=1744152756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAhmRFd74I3yT9uRFvKNock/ejiQI0z0vKOX86u72Ec=;
 b=gRVF+7O1Mq7Xnopydqc1qpIAhMb5hEUPwtXl7ceaYtyiIC/3Yioag0OK/yoaBdA50f
 JJSnPlXmRKHXCfOIAd6yqSCmH+bEo7+U2XBSoWVFJAIjIfhCOBtbkGfupN8hVOBGGRQ6
 KSpn0UyP8auxba8v/Mxopa4CnYSECFmWOBkZTnRzQTZLCbGu91tZ5fPyrvKXyilaKgEe
 9RSc9n/H7r+j6DnLwyQMDLiqciqVtH9gYP4vW3x17f+igQHZ9m7EuMfgEw/gxRkyYtk2
 dH7R+KoV362D9rTNTI97TRn//ePuFTrMVHdcr5/ML6+XEhhS/TVbquL+NfnKQH26Mguy
 fruQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj2MbhJo17S2fKcXQAbQIIeDjBf3JI73Y05i1D3J9VyYuMRfV7GGm4HyKjjt8LutxFg2JJT3w=@lists.denx.de
X-Gm-Message-State: AOJu0YygkqtshMWAov43YAfDFOAq1nK78Ss98hHXCSWpysgmCN9kW5FN
 6TWmsBsL7zrDLeWoWBBRhJh6b5S3QNMW6vh89fiZV0uycB6PnNdX
X-Gm-Gg: ASbGnctMP1hrBV9lrw0Mbis1T8PyRc9UFVOmYDyW8ZExosCcgTGXTCwlVn9qVMK33gu
 xSXzkM219Nej68+bHospOjaAwP8plYKL0MNR22U3hqU9N2M1mCJk3+PQjpkP1dFkh95gFwCQFbj
 QOiPTwBhvB2Xd7V9wmQw20o4OTwLgMA2uDMhIZgIEdBskHjQpgKGoWQVHDmnOp+hXmjt4ZM0Oyc
 JcNz+rHdG0vxiFzDLTCFcwPmJKUNLKAfFjNYOH8rLqQX3Hjgv7PGoCid8izsrS7mz/nyMMB16+6
 80E4JhBlNQ9FmbWh4d/Wzn9uDssy22TLrZwjyGRSot3yssBy10YvNOge/9x848PzwZ8o31387kh
 xVW6ola+769p1Iw==
X-Google-Smtp-Source: AGHT+IGVtjyzNsdh/mhw01pxS4xj7hZoLUtw/b0Uyvd/Q2dhyH7mLsbL+vBEYtFxlh85L9O7ILnioQ==
X-Received: by 2002:a05:600c:1f8b:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43dbc6fb97fmr152192455e9.31.1743547955541; 
 Tue, 01 Apr 2025 15:52:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 01/14] arch: arm: dts: an7581: add Chip SCU node
Date: Wed,  2 Apr 2025 00:51:33 +0200
Message-ID: <20250401225156.25790-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Add pending Chip SCU node for clock node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 0316b73f3a5..9f8abfc3bcf 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -11,6 +11,13 @@
 			reg = <0x0 0x80000000 0x0 0x40000>;
 		};
 	};
+
+	soc {
+		chip_scu: syscon@1fa20000 {
+			compatible = "airoha,en7581-chip-scu", "syscon";
+			reg = <0x0 0x1fa20000 0x0 0x388>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.48.1

