Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB21EC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 15:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE0F8643D;
	Wed, 30 Aug 2023 17:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HDvRjJdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2AE86516; Wed, 30 Aug 2023 17:26:24 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070C0863DD
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 17:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41205469f4eso4818011cf.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693409180; x=1694013980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ciVLhFOApJ5WosxSUNQWC2nzXQTWtF0n6fVuP1zkdl4=;
 b=HDvRjJdbC7UNnp2hZ4OdLl27cj9BMiTsc7811OJOYu8IbMYiXk7XEpwpxoc4IIcE+N
 CvOi6lu87Lqb8Ocwla1JGs043aThwpPBHwhn6D4iLneEpi46BgygqxaZutH117pZ0eTM
 Q35/OxAxabLKBjPHYs+CX5JVcWH6kW6m2c7WZCxe19yz3fQMl+4p86o2nnMSR3CpkrKm
 uS9dd0WSqRrrjDQao94fXwjyQ4B3CXDQjNKjA2/WQ1wYLHFoMx1k/4afpV7EdZK/nIAu
 VXEzknSFjbaBiSZqHAecPQlJRy2wKFCoDsms1JgN8Ig/AghCh1c1rz+7dHXJ/1DIzLZg
 G3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693409180; x=1694013980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciVLhFOApJ5WosxSUNQWC2nzXQTWtF0n6fVuP1zkdl4=;
 b=UVHpZZ8C3q0bw/OFqvd9YLuGqGLQRo336TspiOeXXU0QHVb2Y+xODNYnxBx1qIuWZZ
 8p9zwbyeezjlFIffHAXLjA7GRo6dBrWiKtir4pb2eUY+V9B//amQTFaNxyw7Xgpk2THx
 ISJcGa16XOUAvtLV6KR+JG6hlqqIbZHIODoDBdbMFUUssip7YS7g8fh4ySN6K9mcDkTR
 okhPWxrpIL1Chn0un8c3+Qvn9E4UCPmzKmwDuMjoHyG8qz/L+X7l6Ddk2lx9UfqFhtjs
 PNnWRSO9XHT+DGk5X/lDoL9wn3DzsFNAMxQe/Op7e9oC+xU1rCrxkk8DV1H3DYJS7uOz
 N52A==
X-Gm-Message-State: AOJu0YxebMr1/GuQuZ6ayuCaWUFHp6Cyu1c7oBhyrptrwIRnMR7H0lKv
 i23wZazIG/9CEuh2BlHQXFn97a0x/c8=
X-Google-Smtp-Source: AGHT+IEGkMbAxsRUxN9izia7xkQGYXv8+RKdliaUQ8rcYHXrT6fTiYrpSMBVIF2Y7ElYYJwd52S5/w==
X-Received: by 2002:ac8:5912:0:b0:40f:de47:9b6c with SMTP id
 18-20020ac85912000000b0040fde479b6cmr40955qty.30.1693409179818; 
 Wed, 30 Aug 2023 08:26:19 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05620a102b00b0076cf49bcb50sm3799372qkk.37.2023.08.30.08.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:26:19 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Pierre Lebleu <pierre.lebleu@pile-engineering.com>,
 Andrew Davis <afd@ti.com>
Subject: [PATCH] ARM: dts: am335x-pocketbeagle: choose tick-timer
Date: Wed, 30 Aug 2023 11:25:52 -0400
Message-ID: <20230830152553.15465-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
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

Commit 4b2be78ab66c ("time: Fix get_ticks being non-monotonic")
requires '/chosen/tick-timer' in device-tree. Otherwise we get:

	U-Boot 2023.07.02 (Jul 11 2023 - 15:20:44 +0000)

	CPU  : AM335X-GP rev 2.1
	Model: TI AM335x PocketBeagle
	DRAM:  512 MiB
	Core:  154 devices, 16 uclasses, devicetree: separate
	Could not initialize timer (err -19)

	resetting ...

Suggested-by: Pierre Lebleu <pierre.lebleu@pile-engineering.com>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/dts/am335x-pocketbeagle.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/am335x-pocketbeagle.dts b/arch/arm/dts/am335x-pocketbeagle.dts
index b379e3a5570d..02e3aac56064 100644
--- a/arch/arm/dts/am335x-pocketbeagle.dts
+++ b/arch/arm/dts/am335x-pocketbeagle.dts
@@ -15,6 +15,7 @@
 
 	chosen {
 		stdout-path = &uart0;
+		tick-timer = &timer2;
 	};
 
 	leds {
-- 
2.41.0.327.gaa9166bcc0ba

