Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569FDC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 18:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE8180AE1;
	Fri, 28 Feb 2025 19:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TO34MiUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E8980FF2; Fri, 28 Feb 2025 19:59:50 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 309AB809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 19:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso1788176276.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740769186; x=1741373986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YV9hscI03JczUraK0sQLfJC2qCeZKGEQA0htob5HXWE=;
 b=TO34MiUvxiE/aQlCvaNVk8g8A45a1CFRajhR9v5CMCrrgaXN7QymfPJeMjwTx255ip
 Ndz3uVKMyVs+7v3AaO/l4PdWV3gHGaOakZDwnp2JCkbToqjsPX6NSyHS00MZJQ1psZE4
 pNeDn8/LsWev2lQUcYZt3g3PifWj6Gr3mnp9Kd2TfMcVs8OSKTHY7gpr3nXVRxg5EkM5
 xczGAVS8TqVVfMyz1Wu1WAlUn3oIJd+h9Hyqdf3ZrtSKrDGIG9OwUmCUy+CyZzswLIpk
 xPhbl9SPF9RW8N2sTT8t9q7Xn15vCFwHSqSF9spbZqUIlH57GeOzhU/RY3CMNVR0NF8y
 yb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740769186; x=1741373986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YV9hscI03JczUraK0sQLfJC2qCeZKGEQA0htob5HXWE=;
 b=Tsh/YUT/iG0VmIhgD3bBT1xnZDjX9YMGwh6dzUUyDoyocaMco6NTL+iKRYe4DYTiZF
 tdBmLenyIDKk9F7dbPwgJ1u/LIQVPj2HLphyYFkVbr20xYcDl7J9dLaW31RdyzZJJ9gj
 LkQClLGgtwS4+B0bkGusR/AKenE2JOhD1yEW6SEKyvRMNNzHaIQhKUT8WhYADozyHiSF
 U9PPpYpXKY+vSd4Q1sgcgtuV7kDll7mtSymUpDJ43ZOHjjyy5mRQpfP4R9iBVfqYJT0v
 9geO/vEaK6204yb/fO1skpVaZRUM/Lxeqv5Qfo+67ulhpubp1UayxeHYS13Aei3MBaYT
 sUPw==
X-Gm-Message-State: AOJu0YwX2ZgwENIpODDrWqwKK4WLLV7U8ATkVyIoR3FK8Wb4yBwhaEum
 IWEyfB0ftNTuTxlxma8ZvFCElt5X7nczmVdonaY9KEWIoidFqkqcNmBm
X-Gm-Gg: ASbGncsQkbMFxRiN2vOZTJW99MuywV3Q9fyzHpXOL7Z3zpqvLfLHwwxcx3FAYLI9UOV
 dYmS+mRl7KzAmBH/zBc64+9njZsCNRklKTXz9c6035ccBiBnbv+zGHfWwLF0c8iza/PM2x2seGT
 gMB7xmySo/ePhbi0zry+7tUVsabnIIDUyXvXMiL5iFujshsveWUru5MscsY3tCh1z3quzF/kpxW
 5ZqzSXl3ANxnUY6w+aLxF1O+vjySYpuALolIWUbsW5Zp53Ajnnn5BcRvRETLxlyYFhVlbfMjF5L
 scxwrEAHeJf+asKi970hKxAKfOw5b/ZQ+zm6c4dhkw==
X-Google-Smtp-Source: AGHT+IG3IumjgMLBcZx/OR+tSVeLZudAF7c+Q1Z6kNgFHhTL7Ovn1fLsH+mZD3Q8YuXJ0pbNuRlqRQ==
X-Received: by 2002:a05:6902:128a:b0:e54:9cb1:21a6 with SMTP id
 3f1490d57ef6-e60b2ea00eemr5628344276.11.1740769186483; 
 Fri, 28 Feb 2025 10:59:46 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a41ab9sm1257976276.27.2025.02.28.10.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 10:59:46 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, adsp-linux@analog.com
Subject: [PATCH 1/2] arm: mach-sc5xx: Remove manual bss_clear
Date: Fri, 28 Feb 2025 13:58:33 -0500
Message-ID: <20250228185837.25741-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
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

The arm library includes an implementation of bss_clear that is already
called from crt0.S. This re-clearing of BSS should not be performed in
the machine code and should therefore be removed.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 arch/arm/mach-sc5xx/soc.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/mach-sc5xx/soc.c b/arch/arm/mach-sc5xx/soc.c
index f3619206e91..9bf7c314e01 100644
--- a/arch/arm/mach-sc5xx/soc.c
+++ b/arch/arm/mach-sc5xx/soc.c
@@ -172,34 +172,8 @@ void fixup_dp83867_phy(struct phy_device *phydev)
 		phy_write(phydev, MDIO_DEVAD_NONE, 0, 0x3100);
 }
 
-extern char __bss_start, __bss_end;
-extern char __rel_dyn_end;
-
-void bss_clear(void)
-{
-	char *bss_start = &__bss_start;
-	char *bss_end = &__bss_end;
-	char *rel_dyn_end = &__rel_dyn_end;
-
-	char *start;
-
-	if (rel_dyn_end >= bss_start && rel_dyn_end <= bss_end)
-		start = rel_dyn_end;
-	else
-		start = bss_start;
-
-	u32 *pt;
-	size_t sz = bss_end - start;
-
-	for (int i = 0; i < sz; i += 4) {
-		pt = (u32 *)(start + i);
-		*pt = 0;
-	}
-}
-
 int board_early_init_f(void)
 {
-	bss_clear();
 	return 0;
 }
 
-- 
2.45.2

