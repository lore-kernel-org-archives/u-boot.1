Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55B5ECD9B5
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 23:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D499B83B72;
	Fri,  6 Feb 2026 00:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sFWfKWXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767D98341A; Fri,  6 Feb 2026 00:52:18 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FD58382A
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 00:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45e934bb51dso55853b6e.1
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770335535; x=1770940335;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7sAvchmgEzKoKa93CF5TA/gaoa9LZRahPuNedYnHhwg=;
 b=sFWfKWXOnppPMZ9Thqm8aTDHpoQ+p2eaKMqk320H2MWXJ8VFbyI7DYlPNUISf1HNrr
 Nt4urAEYSpw3wXlZCbWWSlQgvVfbu1tkR/fm675+njJK580FtBqmiBWZlmR1/kHJbuhG
 katVH740kT8hoDqNbQ5lY3epyTThfQg09KJM2dn3elUYHd7uvlfV8/N5TYqJl8cXuLgb
 Hx4FfT0ySAs8/UPDI9DHEz/CTEg8lNl3dm/vxsXMMOTFByzZvXcxp4cKeefQPFTO5UeI
 r/Ci6hiF3+N0aSXOTSPVMdwO/5OTPr4qXEFGZzP1Q8bvSvFAnC2JbR1icG78XDAgA1V+
 9qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770335535; x=1770940335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7sAvchmgEzKoKa93CF5TA/gaoa9LZRahPuNedYnHhwg=;
 b=vAoiliWEjuZ6WSIeIiGn4jkdx1jfXhvg53ce3wPklnpwx1wGL19demn1t7bpb/I28q
 QE/wP6DmPAL75WfqP7P0y6yXVBGm0QRTh5XOe/Yx42CPNeD5V1l6swGOte/UPPl6MD0Z
 gcSQN5D7B9I6GZQQAXA2g1A8QhSPfIBEf3a1zv4XfI/r/ITyoANs8vP0kjdgadVBnXRH
 xyZr/V4cBMvX7dBIB/TZGwKh+AdcDj3IWb7BBMSyJUJbgbQedIEU7bSfpOdSET2/b6pO
 T5m7dtzZ+3uW4Cj2s9PFmuL5OaHp+iMFkNxz88LWgoHC9DtXag3QthU1BzNDGpO7Ti8j
 IMYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9rtlx51VYXEXyI4VB6PYRr0g8pWCE0oJZxl4kOot1LaGPXCuhpy7tPReksohTkJtKU1/m2pw=@lists.denx.de
X-Gm-Message-State: AOJu0YxcbhUkvtKW7bEwG71iIjvZVendRAKBtHowZcCDpyuVNH4RRuM2
 6sz8y7KharniXxp8sbFOE3NGYTDl3RqKouq9vbOsABHhzJHAZHzELPUKCXQNWQiplkxRZ8Sk1hy
 f2IsE
X-Gm-Gg: AZuq6aIzFk8HxPEELy2cKg06DD4EoKsU2sClYWker5czOrtWvu57vuv96CZPHW5XuKn
 tz0bg8eeiQhq0QxEI/evqrOzSFNSpDBcJyvxD4UCPmp2IxKE/4ORw6DIonoDRX3Df4AsBCmvSVr
 okN/SY1C+v5CajfFiIf7mrDrIJjgn806+YhoU7vvbX7dJ93ZoNaVZor7sw/tKMXqj+VG7TOnDGw
 GntU8GlKJdvCx6VieUCyNAyLM3+iT2AC68gLmfpOMvMItAHYE9wpj3a6raGM/yTg279dI/E5NRn
 eJCBSZlS0IOkeVo3Eg6T0rjUAuDIy6IHULhbgYx4gmieARXdOBF98ccbFJKZgK/gQlTSq7ZkbPl
 CP4Nd35laoywwBjDrG0N5ioO5hNv2/aeKC0CNHhdsEO1qLCOxheT2Y58iULkJEJ6hZoRNS7Vnxy
 a96Z6UXbiM4PGtIK0=
X-Received: by 2002:a05:6820:603:b0:66a:1886:e4c2 with SMTP id
 006d021491bc7-66d0a477cebmr512108eaf.20.1770335535164; 
 Thu, 05 Feb 2026 15:52:15 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3adcae3csm312165eaf.9.2026.02.05.15.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:52:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 17:51:27 -0600
Subject: [PATCH 3/5] arm: mediatek: mt8183: remove unused function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mach-clean-up-duplicates-v1-3-b7d4a43c18eb@baylibre.com>
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
In-Reply-To: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QryjxLwE5wbmxvrbkAoWPcWPZWEPiPplm45AL9h/Dl8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphS0XIAeEmw5qx139vgN6xTBpRE22ktUbrUdOg
 xYRrOhlX5aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUtFxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaOUH/1ugsvmB1CGSpqDX1S98msKlfVK9FzufQcDv+oi
 vcd5JQdLG3skD16sSkVygbYSad5ppEDD9BNWqWc405Vn/w3h4I0uyGhOmhUpebPGgV5m9oTJfE5
 GIDn8yS5RgPO46yW3Pjqc9ZjWDGwmQMnqG0hbZ8SKO5tpHc06yGOeR1hNm+h70gtYvUCjfGoOOU
 rUbjrUwKH2TyNtKRdwUA7XpbfeOxTh4UAaf+halzG+tQzBKdrx2RlcQsyjv9Zo5tihcatLcHdEm
 ykpWrtWIbGGNIPMiS7Nej5v9LZL/plHi8D7Lebt3OEeIK3E47BspsfdEmp1LCkZLgvN/WDJbjCi
 H7hc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 06 Feb 2026 00:52:32 +0100
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

Remove the mtk_pll_early_init() function as it is not used anywhere.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8183/init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index 39072622788..b445f3ea1e3 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -37,11 +37,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int mtk_pll_early_init(void)
-{
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	psci_system_reset();

-- 
2.43.0

