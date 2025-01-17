Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F72C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE4FA807F3;
	Fri, 17 Jan 2025 15:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/J/gaSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05F080748; Fri, 17 Jan 2025 11:46:03 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AB080312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 11:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-215770613dbso25665705ad.2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737110760; x=1737715560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fM11TG8Vfiw1vwUeXCtyWOPBAPPH7dy9tKFap6t8Dbk=;
 b=P/J/gaSR7v1DGSIuMWed/Xw3USyY7obuRmgza2clct6nTtNQpkInjV9+VkHQhutBfJ
 R3aCXTy4OtM5T/svu19IvA6axaIf/sRPZpFPVkn5eJ4WUiJWhMSOTiEQR8HZgmmbfqHC
 aCuTUxGaaHdOePgU/pn/JnIk1qtSsisPZbyDUIjTuIsSXlwYynoW4dMx69NSA1wOLnHS
 im4lW5Aqs4eTMVAamqaWTwykAVv/sIeTyxJW7izzZRsUFarlUECKsfGRcN6SwqDNQqmI
 5YdE4ghbiGx6BYJIs1ZBZ5TJdNEj21pZchJbKefIfJEs2/AeYmLNTfqAu934dKFCOHiX
 balA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110760; x=1737715560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fM11TG8Vfiw1vwUeXCtyWOPBAPPH7dy9tKFap6t8Dbk=;
 b=uzf8NWpupPrBjAzPTHkmer/BmesOKM0PGt5uDycsGTZwo+VvC/zpKsuys8PrvrNQAI
 IgpFJT1Gj9K2Fk4/ULv3euaSkk+5tjPiVR3roeIGMFrjTNgi8472yfwYzV70k4iOm5g3
 Mt2nZtsJZwrtjdN9aEJnJJu46SEbEH7E3RMRjTaU2Z5q9KdwSPTpds1aF39SEPbOQqZN
 +J+j55+Ucxu+LsqDDeOnSBDwd6qK9/1XrdHcx4sUaCm0xk2NiPxox/99ulxCyaNTTn7w
 yRhDuNa4zA6vR9GleavmOXvT6DbZZEbHIA9vRilHQD5KLaQTlqvxmwlvwP16fzOSwlRZ
 zZSA==
X-Gm-Message-State: AOJu0YxP9kwAAWoliCLsD8oJHMkZ4LFGv1Rk6zEksFZeSplShhbaUhTh
 WCVBQMcXYASJO7dzxv3BDHnbM1lRRLEHRdMvjXIgjkPEMRm7sUzE
X-Gm-Gg: ASbGncucvX0uGwcOI0f7h323pzJg8H69xuizdHdORyqgzokbb9kxiBBgTVUWVqiKE9P
 YLwoP+2BZRauaytsoGj6GJOZG2+9EuTlokln+Qznmgc8fq4uP/HMFBVjNuuBz+WojlbZhhxHgxf
 VclKuawhnUaHLY1ZXfRf1fbjVp1SEXt6j6G1XB0pls+B2jz/sir5g3H8MK7+RERN9jdisXz6c5n
 YfbxdjZ6tDDBO7r4iKmTBjyb3aWKPCj1ugjZCRQeqtjiyA5LyxNbRjMMPGYl3/LxEqOtZE878Mh
 itUmUwHGowuZt1DF2zOFUeA7sZlq
X-Google-Smtp-Source: AGHT+IHh1Qkt85hIobwDgak14bNxR3hjn7jfQs8OjhafxPgplvhbHqSiUyvXxvwRujAQ5bWWr51RtA==
X-Received: by 2002:a17:903:1108:b0:212:68e2:6c81 with SMTP id
 d9443c01a7336-21c355405edmr40443705ad.24.1737110760238; 
 Fri, 17 Jan 2025 02:46:00 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028d6sm12972885ad.226.2025.01.17.02.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:45:59 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com, yschu@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 2/3] ARM: configs: nuvoton: add bitbang feature for npcm8xx.
Date: Fri, 17 Jan 2025 18:45:39 +0800
Message-Id: <20250117104540.1580343-3-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117104540.1580343-1-zhang971090220@gmail.com>
References: <20250117104540.1580343-1-zhang971090220@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:59 +0100
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

Enable bitbang and multiple bitbang feature for npcm8xx platform.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Michael Chang <zhang971090220@gmail.com>
---
 configs/arbel_evb_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 4a58146e61..c93fa34eb5 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -80,6 +80,10 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_NPCM8XX=y
 CONFIG_DM_REGULATOR=y
+CONFIG_BITBANGMII=y
+CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ADDR=0
 CONFIG_DM_REGULATOR_NPCM8XX=y
 CONFIG_RNG_NPCM=y
 CONFIG_DM_SERIAL=y
-- 
2.34.1

