Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C62C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185DC82A33;
	Fri, 16 May 2025 10:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fEGuabGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA7580079; Fri, 16 May 2025 10:17:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255CC82935
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a0b9303998so1193301f8f.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747383468; x=1747988268;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rCYwOIBybZR6nf+d8e/UVgwWCDNZDITAgE4kMnVH23U=;
 b=fEGuabGCZ+1Mqrg5TkykidsL0r2/yprGfNL2CosidFKkDJTba1vUPbtvJMEWgkA1Tx
 LooXUXpqJ/M6FJKbN23EB2Rf9/47fDc9K/PzG449dnywiD8ItlvqIU7EcBVYwHvz99uw
 NWz1wNUWkbNRCk271ry8HFrxbn/DtZXarFuTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383468; x=1747988268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCYwOIBybZR6nf+d8e/UVgwWCDNZDITAgE4kMnVH23U=;
 b=qooh9k/wZLB1SZ+s+tWRzcvnDqudBGNvzNJL8fpfgVtKeL+/yjQOCK0tDMcO9K78vf
 4Uc8wQJ+M2pGK0v04JIamL2TSFT14howPaH1P59F8uY5V66byL/kcIdsEJEDW4CoAa6M
 ZBZ7XHLO78Njip29gOe9Ey4qxzqqUooaZ1RhjyDf8YbBwXlqikzH7qD15jFr1C8eQBME
 gB/gBWS+/s93yiUUjzuWW9zXJdw90wZA2JQCkpwd9tjCQN6vC2dvUG5XuyMepvl+pn9P
 ilCpP0AIEp4IuAuzkuqMRrsmySDJUXPPij+W9T7XQPazxa7cA9c8IJrg+mfR4hAgA+EH
 KY7A==
X-Gm-Message-State: AOJu0YysirOB/EbpPCA5QrC2rOMRCd62IsWSLOMEpr+dooTWuTKyO6q1
 WXeFyK9AiM6e7JekUxa1taj+Rp3MKRoYAVLuZ72kC6bgAdCj4ysbHLbcI6GdY3M250OGn0eWvoX
 JMtVyH6qE2xgT
X-Gm-Gg: ASbGnctBCq6tQmQprHURrG9etO7XmnjRh4x+1ek7UKgRDb8el04kREd/vv/JyrFaUZA
 F2Tjl8II4Eq+QO6p+lH59C00LvGbdnLjZrSG+s+VeaoAiMETeCmPVXvGyKV8TI49FSNJbEwekG7
 Q0eFBww11joFJ+ShDlLmG5m32cOjj+5rixWuNuWptdAf63JRfuwq4kkQXKhg9RJsnxexqSj4bD7
 x7Kax8aokHp6KUkOgkdqElMc0mo7o1RYXaizzlrUUqz9YLDmPNZoEx//ChKr4j3qMcS3bk718Hl
 5KpKsDv+io/doeEOTttGTjBjbE39Wf3g7vkvpL4lYaFabcPi+DDBZ7GqyMdJvPksL9/u3af3FzZ
 gZ4yc1Qc5obsaYJ+oA3halzj7OK385g==
X-Google-Smtp-Source: AGHT+IHeP71rs00/GYYCIJ02zrk5WMc/vdPugrmm3JTXCRJ9rwvH/PRMuLMlRTLm5CT54fOKmxGadQ==
X-Received: by 2002:a05:6000:2ae:b0:3a3:5c8c:e542 with SMTP id
 ffacd0b85a97d-3a35ca7b0c6mr1766291f8f.10.1747383468087; 
 Fri, 16 May 2025 01:17:48 -0700 (PDT)
Received: from panicking.rbg.bshg.com (p5b26784b.dip0.t-ipconnect.de.
 [91.38.120.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d0fasm2098172f8f.8.2025.05.16.01.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:47 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm: dts: imx6ulz-bsh-smm-m2-u-boot: Drop soc node
Date: Fri, 16 May 2025 10:17:19 +0200
Message-ID: <20250516081738.2524518-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The node is specified on the parent architecture u-boot.dtsi
file

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi b/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi
index 7730bb60dd0..c67622821e7 100644
--- a/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi
+++ b/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi
@@ -5,10 +5,6 @@
  * Author: Michael Trimarchi <michael@amarulasolutions.com>
  */
 
-&{/soc} {
-	bootph-all;
-};
-
 &aips2 {
 	bootph-all;
 };
-- 
2.43.0

base-commit: 7a18328d70cddf8d9ffab046ff38def5d2f61add
branch: next
