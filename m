Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A44CC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC48787F6F;
	Tue, 19 Mar 2024 15:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jg6DYEpY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9519588064; Tue, 19 Mar 2024 15:04:43 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0866E879E8
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1def3340682so34429045ad.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710857078; x=1711461878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y73B2o79nKGa8eV/tvLv0M4OVxADy3qL9IkqkjX/8tc=;
 b=jg6DYEpYBBL1QNbLvcFGRvXYTsv57Uxp8jriAfXQ9tKz0bj1mEN1JEIvAlvRO6DIZL
 kTcCmS9vTQ9pmq8MC4khWMX0ynKVUlcYCkn3xhsBWsYu0cRecVh4WwQech39d23XFSdD
 vz1LZ7Kp0o8HMOFrB4feY8Tj+WLkOz/TJlDiVuGDAwhFwCMRnlPwWHmJlWW5F02tt8ND
 K8/0eaTMzje8E7kDxTo4f5c6UBOO/J7v81Ohy0o7yt2X8XZwbO2Wf3uypnk5CQiNAZdB
 AdX2i3cZAY4iB9eoYb70NUPkVFPC5l/gdGjsrr2SDSpe2lBLQ6gOusSCcFGUynqVT6bG
 JrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710857078; x=1711461878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y73B2o79nKGa8eV/tvLv0M4OVxADy3qL9IkqkjX/8tc=;
 b=XLtGlod8tdv5Y4VZHcODTcEu4FZgX6ISWRr8iJZOsAKZa3bScosR4HoRLjnHGTnRWE
 Ymyon0ePFSAxclyQ1kNzSVmIe6OvmZnnZpTrOCEYkAStZRRrBZL0mI2PHhz4/ENZQg7r
 MRH2NXREP4TcIYOAY/ZZD2u4BF4IO4MTURBa0qB5FqJGytepgBj1V+DXSrB5OiQ0/ecR
 21JFbVPV6hPqMPbJ06rHBTBLP4Iook2/tftF/0IGHGTA3sa+Oz09+Fb4EYqPJVk9R0WR
 myrCwqNHDEc8Hdc2JENjkEvhfXs9KUyosNXv7fXhG2TuicNNEKDiZ58dxdB++8v5sVHP
 VQcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxQr6B1/E2kokiprV5KhbqjrwmwCOKvaYW78cO/WvbpNnoPg4RMFe+OeUuB3rrOliOTPBVbeLU/TM/QuSyD7cajks3DQ==
X-Gm-Message-State: AOJu0YysdN0iQdiLriguhn2X3jXC/eX9nPqm+lOgAvwwW12erKS1Bx1B
 JZPVql/GRUDwRsQ+lXuvGcXd4L2ETm656sTAP1fmT14BzW/gWQyA
X-Google-Smtp-Source: AGHT+IEFV3/QEJLdNpDk6fRZr/GZKsgkESmgckfD5hZoZofW79rAXEIRiLfKIj6hG3cGJiPUYjLzTw==
X-Received: by 2002:a17:902:c213:b0:1dd:dbf6:57c2 with SMTP id
 19-20020a170902c21300b001dddbf657c2mr2972091pll.43.1710857078291; 
 Tue, 19 Mar 2024 07:04:38 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902e88d00b001e027e5449bsm4161538plg.88.2024.03.19.07.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:04:37 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to 800MHz
Date: Tue, 19 Mar 2024 11:04:27 -0300
Message-Id: <20240319140427.73721-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

The lowest speed grade of Toradex AM62 SoMs is K speed, resulting in a
max value of 800MHz for the CPU operating frequency. A solution with
runtime selection of the CPU frequency is already planned to avoid these
kinds of problems in the future.

Fixes: 8fb8a6d49977 ("arm: dts: k3-am625-verdin-r5:Change CPU
frequency to 1000MHz")
Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 arch/arm/dts/k3-am625-verdin-r5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
index 6b03e7405af..2b333e70f5c 100644
--- a/arch/arm/dts/k3-am625-verdin-r5.dts
+++ b/arch/arm/dts/k3-am625-verdin-r5.dts
@@ -23,7 +23,7 @@
 		 */
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
 		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
-		assigned-clock-rates = <200000000>, <1000000000>, <25000000>;
+		assigned-clock-rates = <200000000>, <800000000>, <25000000>;
 		clocks = <&k3_clks 61 0>;
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-- 
2.34.1

