Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD18C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D7F88A20;
	Tue, 30 Apr 2024 15:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M/7jiVuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F3C88A3B; Tue, 30 Apr 2024 15:36:22 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DD988A24
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78f043eaee9so343355985a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484179; x=1715088979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tdICnB07g8KpTELzfqXoLbS16y/3zpbCN+52xm9yHqk=;
 b=M/7jiVuXa8md/iM734G9hKS0R5fG49c7lS8r1+ErMaIx8DT5lzgu8L3uO4Ftzy5ic0
 cdnKbMfDvkx5bR4hDRM+KrfXExrBEmlUEAax9FSOBTTurLbPFvFdS2azlDQe1E9rR+XP
 2ViFzThTi5IpfMrr1bAxw8eIi2WfzJihvCe/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484179; x=1715088979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdICnB07g8KpTELzfqXoLbS16y/3zpbCN+52xm9yHqk=;
 b=pcCBbenXyHjoUg3RZOUzSb21yjHSd2eKq7la9W1PDFWjok+znidR204ZXou5krE2sr
 AS2jfn3T5qCQa1ujkHBLGdICMw0bavLdnsRgeBcWwuGSRJxqejAnucUoxhg+EtfKRDKF
 R9jYEc5uAg+oGnmzUcggW/cLHsJuTw460D8KvX/cooFeQRo8wuRY0RAa+l3eDJWnQLBK
 0DdmqNU1jOqW75BEt83WN1D4G4sPiu3HN7h4gtGTmGMRPGsdnD7Mmn3+85nstwEAx3RF
 giX5w9DYdGavjowyeAIrloBFGbczFcrb0bO/nXlfBnhcQSOTLWdadyUZ5k4XqnOiowTD
 w32w==
X-Gm-Message-State: AOJu0Yzr9Tu+X1n3wxw+mQrVyMKRPCEpuMUkBlyTVfMuNJ/lsTIQ14Mg
 OXz+u8mnoz+xy7x4w3W8N3bBqg9jFOpy6ywBDLaLbIcihAGqjrk30+43du4YEqcAAqaR4BF/tTG
 tedTBNA==
X-Google-Smtp-Source: AGHT+IG8yAFRPblswq3VGsfZ5fX5429dpNIYn5GYDLRmhWj8b9xI9I5aX+qmbheKeOYsoRswFfuM0w==
X-Received: by 2002:a05:6214:224c:b0:6a0:d312:2ba5 with SMTP id
 c12-20020a056214224c00b006a0d3122ba5mr3199147qvc.61.1714484178818; 
 Tue, 30 Apr 2024 06:36:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 15/33] arm: octeontx: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:41 -0600
Message-Id: <20240430133559.1836389-15-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-octeontx files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-octeontx/clock.c | 1 -
 arch/arm/mach-octeontx/cpu.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-octeontx/clock.c b/arch/arm/mach-octeontx/clock.c
index 9da21077ecdc..ffdee8799fb6 100644
--- a/arch/arm/mach-octeontx/clock.c
+++ b/arch/arm/mach-octeontx/clock.c
@@ -5,7 +5,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/board.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-octeontx/cpu.c b/arch/arm/mach-octeontx/cpu.c
index aa5f4585c6f5..90454edca257 100644
--- a/arch/arm/mach-octeontx/cpu.c
+++ b/arch/arm/mach-octeontx/cpu.c
@@ -5,7 +5,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-- 
2.34.1

