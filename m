Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506E606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zoCCwScr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRbaiiIP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 326F3817B1;
	Fri, 13 Nov 2026 06:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iObICs-rSDjk; Fri, 13 Nov 2026 06:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 525A08184F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794549607;
	b=OU5SuEQi22jCLz+QDhdsz841aEJuMX+/Zkn5Whrs3/mui/Zl1bH4E4TUjyu0nDaf7q5v
	 uBejWS52XoOf+56GMIN9J7j2PuKra0kreCtE/mTd9lJSG3ejsu94LzvCl9X9tqtasuUoW
	 YDUbU6nMroxXBiCCtzppa9hbGnxNOBVLXAyIp7H36rzClvzDD+3BKBJiic8xO9zGbgDKI
	 yAmxErK8PSU9sc2ojBKZTRKdMfwWsJuulKyCq+8WBAQx3AevNsyMxnImkA/yb/h8bfsSS
	 3TzWR5dxC0EjwvLgFEgZ0Q1B1K3rNQ6lXCbb4Ffkj8RQtOlEZo1p8+6huYkEZ0xYXJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794549607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nPNBdcDN3AMGCkWNditqze+2ot4Zklntkii3VgHNlXo=;
	b=ScaepEiLi5UaQ1GlhuScAYEZ0RdrgRnND6ek4qIev/Ek8i14k2+TgmSIHfTC/7sBN5nI
	 YWfdKGD4d8qdODvfv//7a0F2DlkFKeneZK+8EnR9vosPprxCc+jVcY6PsuOfsBMhpJjq3
	 tlm+IOC5AO7jbgK6WB84pQQxZsgoGz0Km7P2B5IOTEwfkjiGEib0AAlBQy6GkY+5aZxAH
	 YRUA0Dx0AKq+RfGxfq00cmW9kEgjXoNBawpLMRE7R/Ey2NqSpIXPbdnZ8nhiP4mAzPJE+
	 fnBnXggnxGO/954l1X64g404paihpIwH2N97ONiULPFyg9JIM+kLSR7REeakxUiVhFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794549607;
	bh=nPNBdcDN3AMGCkWNditqze+2ot4Zklntkii3VgHNlXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zoCCwScr6AiNJn+cVnfFLYU5550XunYNB9EzsHIczJr9khXqmdM0xFJ/deWUeQjjH
	 fMW/7yo0vHJS8lBgTkpgUCi1O+xGkBa4IcjUvh5ayZHB51werk6J4uGS3xWEe6pR+b
	 c23Xe0xn8f/kaLSWpjyZPZlhiLyvZv8zLmJKhA0kJM6lbnMczrtLd7IxNAeYQTwTRZ
	 pp7+m/rdAIpiA3vBkdjKYGxhuoIMj3b+c6xD0beYI/CbFfqLA/jZfqCOSQ/jl7NTWx
	 Pt00fOcApbUcwQqptRRVbu2lvmLf6MaKgMP4vfYZH5YGJijaCDSzXaP5a5hdPWcpM4
	 /i62G5q8dsJqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 525A08184F;
	Fri, 13 Nov 2026 06:00:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A4091370
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30D4660DAB
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q41T6k_7t0ps for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 06:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35E7360DA0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RRbaiiIP
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35E7360DA0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:04 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso4937665e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 22:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794549602; x=1795154402;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nPNBdcDN3AMGCkWNditqze+2ot4Zklntkii3VgHNlXo=;
 b=RRbaiiIP5dpP6hZ47GQAYJ2jNCNRier4TaOxEC+zukTeq4luaMMnC70nlAQTDhHwNs
 SJmyRbwADz+jOe66yuwhy/E/5+tUFdrl4kSnh+CZGWQw87GoNckS14+QA6PG+QRvBi3m
 zxoQa8Fn4dvzTL4ODD3OwQjCmUrZ58sPdbDYsTYYil3tX+rgw9/IDykdhj77f841f7Vj
 +VswULyk1I1tk/TqrDZUvPp7Gw2c4w3pC78t6ZSrHJ8zHiZCN77CyrEKmnOHhezjP6I/
 j1BcmhAHWUntssKuUlJz3B5iy/uwJ80MUQw6V+rp+ce2ffB0w3p6SXHFr2L6qOiSm0FI
 DdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794549602; x=1795154402;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nPNBdcDN3AMGCkWNditqze+2ot4Zklntkii3VgHNlXo=;
 b=2QOKYU/+HrainfonYlAJJ8krffExCydIjXzA8B5eZeeWl2uqaAx2v4VM52EUQg/Krg
 U8hYxJFoeP7u6FL3uJVPV8cbRhelGWUwrXybaaVQoLzYQ+iFjOUx2U6saVTb4jS0i+Fg
 DjC144CBprn7nOGUZHsQiPwGzo/u0ZBfY73+EV54A4lOM0YjOFu7XoRyomswRZp5ha72
 HDxCYLJ2WfnYsjuiMllAsctNc2LEsi6vC8lSn0WIsr0JlEq9appG6tgKaV1bkO54j8vb
 g3gJZYRuwDM600x6TCspf3yTBQX8EPNFa2PXWWRCDDXyicuHR+8jRqipn5aU3aJKN6vC
 lmKA==
X-Gm-Message-State: APuU4Z8G7Y4P3di+oybQDS4ZGiW74+lPo4QbFUQ13x7SZvfhRBOOJljE
 Q3BsRdH6HqhH02pRxi7uo1nZdX9jSVk55Oool/jIeqPzslJnpNmU9HC1Zh1amg==
X-Gm-Gg: AYBFou0pcspZJMAZbLdllkciWQ8KgeYgULNpTzhJYzf2TrR/V/bwvjavaWx6TryHfCm
 ql3J9NwRxV4t6B8JGj6bDuioK/yYtu9wa6SMSU6oPYARk8K6tGHi3nQWNiw6C+V9QNzrnSVW+lM
 iGlXXCwvuU5Yrf9sYy4dEFqsLeRw9KDDNqos3C28y2vax3izvVbJtkq2sh67F4c0LpNxn/P5Pia
 nk48jgcbUDN0tA1aSazMSOvsIlQtmeln0i78doseHYOS5dtXlaxc2Jutpv0IVweT7UDCklVGfL9
 VPy9qgmxE5Te/yaDHWnzB/1nqzPTd0+zCvCtPJkYgdaRKMns11sN99H35b9vw2AH3faJMHvdJWE
 lHjczmqOFSRcZKEdnxAoRlrp4h+vU0Og04iIfGMer2qzHU5SNEvyeaK+z+HEdLPxEix+Zut6Zx1
 qywfc9620B0KkbfW9g+9AEeIA+TgQeHLfUsQVQWtgn5OYPmKbu2E5ZHW2O9UIbDM+n1OqRQpDQc
 DneVSCtEmLNWIxgk5md3+OrhN2xGtT3Nohn+tQyU6kAA3e1wucZSU5ynV2SekLQclygWUE1txM8
 JxVaE3KoZSsi9vzNQMaDUx9d62c8MLflMcZwfi/p
X-Received: by 2002:a05:600c:83ca:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4bb55a4d9b3mr30972725e9.13.1794549602117; 
 Thu, 12 Nov 2026 22:00:02 -0800 (PST)
Received: from [127.0.1.1] ([151.51.254.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm32906355e9.7.2026.11.12.22.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 22:00:01 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 13 Nov 2026 06:59:58 +0100
Subject: [PATCH 2/2] arm: mack-k3: Kconfig: Keep SoC dependecies sorted and
 readable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-remoteproc-v1-2-be4c313f577f@gmail.com>
References: <20261113-remoteproc-v1-0-be4c313f577f@gmail.com>
In-Reply-To: <20261113-remoteproc-v1-0-be4c313f577f@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Beleswar Padhi <b-padhi@ti.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Judith Mendez <jm@ti.com>, Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Keeping config option dependencies from SoC respectful of the original
SoCs sorted list, and breaking them into more shorter lines, helps the
readability comparison and maintenance.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-k3/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 36580f27d48..a44e3e43bbd 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -175,12 +175,16 @@ config NR_DRAM_BANKS
 	default 2
 
 config K3_REMOTEPROC_R5F
-	def_bool y if ARM64 && (SOC_K3_AM62A7 || SOC_K3_AM654 || SOC_K3_J721E || SOC_K3_J784S4 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_AM62P5 || SOC_K3_AM642)
+	def_bool y if ARM64 && (SOC_K3_AM62A7 || SOC_K3_AM62P5 || \
+				SOC_K3_AM642 || SOC_K3_AM654 || \
+				SOC_K3_J721E || SOC_K3_J721S2 || \
+				SOC_K3_J722S || SOC_K3_J784S4)
 	imply REMOTEPROC
 	imply REMOTEPROC_TI_K3_R5F
 
 config K3_REMOTEPROC_DSP
-	def_bool y if ARM64 && (SOC_K3_AM62A7 || SOC_K3_J721E || SOC_K3_J784S4 || SOC_K3_J721S2 || SOC_K3_J722S)
+	def_bool y if ARM64 && (SOC_K3_AM62A7 || SOC_K3_J721E || \
+				SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_J784S4)
 	imply REMOTEPROC
 	imply REMOTEPROC_TI_K3_DSP
 
@@ -196,7 +200,7 @@ config K3_REMOTEPROC_PRU
 
 config K3_HSM_FW
 	bool "Package firmware for HSM core"
-	depends on (SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S)
+	depends on (SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_J784S4)
 	help
 	  Enabling this will indicate that the system has a HSM (High Security
 	  Module) M4 Core and the firmware for the core is available. When

-- 
2.34.1

