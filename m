Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6915C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E032E81CFD;
	Sat, 22 Mar 2025 19:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZNZ52Y13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D480581BC0; Sat, 22 Mar 2025 19:38:44 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFE681DCC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c5675dec99so358979485a.0
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668721; x=1743273521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztTMBjppQCrJBHbQas0AWBGYUApKql2DEYy0ofkfE1Q=;
 b=ZNZ52Y13v7sC+yILnEH6gwGOIG3rZkxNXLdHWl1SDf8U/EGP/8qH9wbwGZDBjR2msh
 3aXt+NKnUsXFBmCasEN79pm5dQXl2I8lGUWhN6J97tk+jNDUpwUyEiP1MkPl8ux8EdMY
 8KcVicm9SVyXzUAymLegKNG20Z2FdSRZq4w7qVn4n6c3Z0gaJxSx3Q83GGjbc20PsBna
 GZ2UMI1yoroVzN5DFaLE0JE8SjOZM0HQK7k9BqPEbBenvIAbwH9HLHytZ4m1wdS0h4B2
 WOonDFlHza0k+FKgY87QpDfRoHYca0Qse+HCPNMDlisQAwXfPEmf99WHNw+EbLIClmCX
 bx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668721; x=1743273521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztTMBjppQCrJBHbQas0AWBGYUApKql2DEYy0ofkfE1Q=;
 b=v4BY1/NJCzxCeNIA+YlQPu6Ns9EjRE3fisSxllnQfGpNbAGA+r73jsO7mGQx/QnJxo
 3z8TOhz5wzAc0W8HYmAEh7/zj37RyKO/o15W91qQfpRsFaBAqjQneClMAPxxnjWV2lZw
 jtRFd5iONs2XLbgmPGjtabCcU5fyltrQ2VG7w+iO6fqw2XwA+PSOJ8meYzVQ0BNI4Y+1
 Zvx8hSeI9C2XGbG4vU0vK9lxI3Fz8woHRCP/VS4LDcgvOl9TbmC1PF8Ur33TIuUUDHdj
 4tnzAAuN8JVfy8TUGdffyUc0jRUMgwTGVwr0li+ZA5/Uk36d5xkExZKBOGB0eW3X2+EL
 Rg2w==
X-Gm-Message-State: AOJu0Ywp8RPqGE/nAxw85JEPEySgz3O1VToT0AbjzuzZG2V8Utq7Qpgr
 iM8GYKnKES+EnWgecw39WKa03afNozsfw9UtftK37rd/xguqmX0cD8DGwA==
X-Gm-Gg: ASbGncvgK+78xWFNvauyB4H32ZqiD/DnGtmxgofJgEVz9vukW9ZVMrLI07BI8TiKrn+
 tyijm6XqlAxzPP38XqelYiizsSD/BWC15XteF0pPPW1m6vSdIipgJiCyj2OrEFOi1EJ8vE2ojgF
 Pmj8QjP8FhjaeZVcg2EU/W1zuwSUFlXywh7mnJ2dbD6lkkz2tkCGhW2cQ4YhUj/Mzz4+L0tyAB1
 o+zH7l6cwXwETfEFU2OwNcVuY49f6Myg+E1IFn2PpFhXgMuFdZPEOXt7O07Bj7o3qmO1wBUzExA
 sk72RWpxacsBdWOzgShWAKYvv+MkpWu0A6d89MOGayYdo0SAscBolhLrXK5oQXWufoeXklVKAT/
 DTCnvZGSoCMDpflXOrt8=
X-Google-Smtp-Source: AGHT+IE+5esxFspUtQ0ZZc5iCLQ0EFAVYmFHi24MaOdO/grikkX8RR2eXYV87D0oRB3Db/8/A0o0Rw==
X-Received: by 2002:a05:620a:170d:b0:7c5:6410:3a6 with SMTP id
 af79cd13be357-7c5ba17d196mr1132042585a.27.1742668721026; 
 Sat, 22 Mar 2025 11:38:41 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm278126185a.61.2025.03.22.11.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:38:40 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Sumit Garg <sumit.garg@kernel.org>, Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V3 4/6] imx: imx8m: Imply CPU_IMX by default
Date: Sat, 22 Mar 2025 13:38:06 -0500
Message-ID: <20250322183812.784676-5-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250322183812.784676-1-aford173@gmail.com>
References: <20250322183812.784676-1-aford173@gmail.com>
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

The imx8_cpu driver is a CPU Driver that supports the i.MX8M
family, and when it is enabled, it acts as an alternative to
arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
model where cpu.c does not.  Imply this newer driver by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 8ee699a343c..988495d217a 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -9,6 +9,8 @@ config IMX8M
 	select ROM_UNIFIED_SECTIONS
 	select ARMV8_CRYPTO
 	imply IMX_TMU
+	imply CPU
+	imply CPU_IMX
 
 config IMX8MQ
 	bool
-- 
2.45.2

