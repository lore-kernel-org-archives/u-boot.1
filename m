Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C84C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 14:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF27881F6;
	Sun, 28 Apr 2024 16:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AxQmLP2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BADA880F4; Sun, 28 Apr 2024 16:24:24 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6378828B
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 16:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heesub@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ac16b59fbeso3167840a91.2
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714314260; x=1714919060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SOBZ07hLcIVya2JI+W8ZuSOXxCBaGDbY3A7AEZ+QJuY=;
 b=AxQmLP2U184fnhQ3URFntpVPT7lUfYB7fB57Eag/tMgnhNzbBRHbe7H5Df3V/nPkCp
 e3xJ99i404ItkQiZUk7uI09T7KnX+MFoXTxhy9N7unfdj0jWNNkH7fLCktRrgqOsHwpE
 e0Xcm5aCbwRGgnFk8b/8LsB9DDKXMrXPtq20es5Iqb5I8z1Gjxz8Sosy/JqjsLH/0LdV
 mASR7VioSzQLSiyuDixHdYBfgcFBXHjlfj9SEOveHVBYeKZbCadEDUYwlhMNaA5tGe17
 p4JZUdebw9HE0F2vLFKgnVoXLuCXlGObJA/TEWIsnuFaSQeuiyaO3ce+VUczGXIEFWBO
 eByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714314260; x=1714919060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SOBZ07hLcIVya2JI+W8ZuSOXxCBaGDbY3A7AEZ+QJuY=;
 b=CUTw58pSxaMTy4EmsfymRATo5dxrVlEgxChnLGXlAO/G/vgdbbAVZS3HBis1nlm27U
 Fz4kdDDxpR3H73OnPKPT2ID+OXjYOyt6EAVWh0AdU2v5y4hKy6a+MfTMW2FFQEoZ/vAl
 IUJ4bKUj2cx/FCF1AIeUfE6wS9nqMhVCuP7YbQsUsNrqJqmQ9cPyZ0nMPxtJcnBeHgHX
 htfHN0yr9MR2SYinAdV55fOKPROS71M0+DvHFDJ4T68S1YeBtJJKB5CBulOwmy0zstdm
 6xsQWxNOYMZrJMQPyCA1EWwhiiP+2Y0hCRewlXBIMb9TyXGVIELIxpk9IfOU0GW8vUdb
 Kavg==
X-Gm-Message-State: AOJu0YxOHcH/o/JSKfHt8CVBXTStvMalnNdpzunNdZHR/GIJgWqN8tWO
 G9hB79beMBeNV3zv0UusRG4kWMMpCy/S23AZelo+wysHRBODtuUdquwsVA==
X-Google-Smtp-Source: AGHT+IFEYH2+czUhzLbU62hn10B9n7QVAABr+pvbnFcg1rPYGH7FhWxxvaukkTQRcHihP7jAcgGAdQ==
X-Received: by 2002:a17:90b:4f85:b0:2af:8959:2cc with SMTP id
 qe5-20020a17090b4f8500b002af895902ccmr7898371pjb.9.1714314260026; 
 Sun, 28 Apr 2024 07:24:20 -0700 (PDT)
Received: from heesub-ubuntu.localdomain ([58.229.217.38])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a635343000000b005f077dce0f6sm17568744pgl.31.2024.04.28.07.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 07:24:19 -0700 (PDT)
From: Heesub Shin <heesub@gmail.com>
To: u-boot@lists.denx.de
Cc: Heesub Shin <heesub@gmail.com>
Subject: [PATCH 1/5] dts: stm32mp157c-odyssey: set PLL4_P to 125Mhz for ETH_CLK
Date: Sun, 28 Apr 2024 23:24:02 +0900
Message-Id: <20240428142406.28445-1-heesub@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Apr 2024 16:40:40 +0200
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

Odyssey board requires ETH_CLK of 125Mhz. This commit sets PLL4_P/Q/R to
125, 62.5 and 62.5Mhz in respectively.

Signed-off-by: Heesub Shin <heesub@gmail.com>
---
 arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi b/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
index b780dbd95e..d07fdcf4bc 100644
--- a/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
@@ -115,11 +115,11 @@
 		bootph-all;
 	};
 
-	/* VCO = 594.0 MHz => P = 99, Q = 74, R = 74 */
+	/* VCO = 750.0 MHz => P = 125, Q = 62.5, R = 62.5 */
 	pll4: st,pll@3 {
 		compatible = "st,stm32mp1-pll";
 		reg = <3>;
-		cfg = < 3 98 5 7 7 PQR(1,1,1) >;
+		cfg = < 3 124 5 9 9 PQR(1,1,1) >;
 		bootph-all;
 	};
 };
-- 
2.34.1

