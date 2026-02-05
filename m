Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244B7ECD9AA
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 23:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5A183B95;
	Fri,  6 Feb 2026 00:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O2kk/FQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12108341A; Fri,  6 Feb 2026 00:52:19 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A3F83AA4
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 00:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3f9ebb269c3so751896fac.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 15:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770335536; x=1770940336;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WJkcOzgvtdS3lgvKIiIH0Y2i+93555r5yUco8FDXnwU=;
 b=O2kk/FQWCxvFsf9wMtG6b8/fegYspAH2jYMmossaSQqC41Kn4RVAM0XAlo9AsjuhWR
 3zmKm4GUSR6QLkTn1zNHyY0SRLqI/qSncGYp791TgBjZscFYzzyJDmAxb60waa+dtvCu
 +bvDJcDnGY3kexTFAJyqgi9exGGc7818XE9/X6R11MIcUuc4hXPwyFKO5OE7UlqTu/sf
 wx6fiWyR7f1KpjWXbNp7ZyBr6NStCBru5Rc780Y0Yui1Oe3fFTSHYp0GsqYZTegn6B0R
 0JtII9/5zEwecFY8IqoeDfvHrobI6GX+Bywguqtv7mp1cmmBE0wA++dGOJCBlzw+1UAe
 ll5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770335536; x=1770940336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WJkcOzgvtdS3lgvKIiIH0Y2i+93555r5yUco8FDXnwU=;
 b=L5H2vcu3H0CyMi67+PwwEsRUV2tpeGdQvRIl/5avnf4/pllHThIh2fcQqXW4APkTEF
 34LOUQLdtR9+JcruQ6eGfsIL/CcFZraWXsErw2v+LBdqu7tgfGlAtgdBc3nROXzMLTnT
 ZoUxceXJLdIALecqv0TaedBYn8BWX4drRu5vNWgWcKYWRQmIc6iW3qdgY2O4/6clzKo6
 LNwmbWIF/J1URvvUbnDi92uglR2izswn4FoMMeMsnUoN8mozcm59M+HKfuG2tTtfEJTQ
 LDY7XWZsHa1lgghQqsN7dKKSl0v493hOK0Pot/q6hSyAfVW52M6MxHJyJtdqItWL3r+3
 On1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhVmhA18BI00s/Kw0zrtVZL0chYn7eQrAXRv4AJfQh1Wdq1VMXnydp23wJs1KPEm8f7T2hs/A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx56/9RUClWnvqUq6WsjK5xBEXHR7aEMzYWogrYNEqvJr+GaFW9
 T5i0nHqUD0ZxMks7eCM2Kd8JfnXzsTLK9CUsZWKbJltuQ7QoCyMXgkY50O0h9KP9ukQ=
X-Gm-Gg: AZuq6aIa7tp22iQiIL6nBkF/FFYTPT0yF2kfwE3Q1CPyMZlULwq/fAjh+6pe/ko9PC2
 8j61sRIBsCC5CXgsdcAjLOh1zo/HP3cT3ySyqh+JXNxpAi6LI+rHeN8NCtCC/3dLK6OG2w4hwXR
 mE4gPy577Z59idMjCobh1wG6NeKgU9iyuxK72iJiCs6XNehUqzcO1UVvWU3AAtN7LMQYKLecGM4
 crNsPWfHVRKKNmbpSZwkEAtQ72WjlZRHPGG0xkHcxMGBM3RyBhC1m3zDihpMBDTSY1d6GJc/JYJ
 aQVpfC4+rBHURCTe2yj2xOOdhsuEKTWLR4yUwB+kMzNNRDDOh3UXaUw/j6DGvVWOGrUWIlavIaY
 iSoJgQJQuXXih1dThYgAiTTAkI5O26WTHK7g8DYov8vH5qk4WvRWmD//Uhc+nhW+W3g3puM+ZdZ
 SJyYlRGwnIqEOGLnc=
X-Received: by 2002:a05:6820:22a4:b0:662:f4cb:208f with SMTP id
 006d021491bc7-66d0bea66d8mr525784eaf.51.1770335535958; 
 Thu, 05 Feb 2026 15:52:15 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3adcae3csm312165eaf.9.2026.02.05.15.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:52:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 17:51:28 -0600
Subject: [PATCH 4/5] arm: mediatek: make mtk_pll_early_init() static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mach-clean-up-duplicates-v1-4-b7d4a43c18eb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BFjqKadARI0vggSmPYWo8UBjOg9AZyvkdYViC5PTO1w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphS0dsllsueXqdFfCHSd+e2gYOrNbBCDwFSZkq
 ZcV4TO7kfWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUtHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMdIH/iSddRYGrPd/S5VqtBjEljs9Ld9rNzkDXcNZgFl
 yMnsB76LmSMwPGIxSC2aNDHbD5+dTh/rTCna0nrFl4ablf5QwZ7Q+BijsqDfilXX3rqvgtYgvmu
 hfD3FA+xBgNQamn1zcOZRVoqBxLbVm2bC7heU6YGdl045FrkDi8NoBlAihMnP5iWrtC/UAKnfQ0
 0EYTRhs/wsYL20sn5Cs6Z1EbKLYpGH5RpL21cNSY6OuTiiB/S7fcYNmimsY5srdCHZZi64dGCzw
 qOmStFZXLuXg1F/lWp5gA5Ljk937qyijBpSr32Mna9+6IHB+EQi4oCHp4709GARxPo08hswF3+d
 o1M8=
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

Make the mtk_pll_early_init() function static in several files. It is
only used within those files, so there is no need to have it in the
global namespace.
---
 arch/arm/mach-mediatek/mt7629/init.c | 2 +-
 arch/arm/mach-mediatek/mt8516/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7629/init.c b/arch/arm/mach-mediatek/mt7629/init.c
index 7cb8b72c364..ff027ed03ef 100644
--- a/arch/arm/mach-mediatek/mt7629/init.c
+++ b/arch/arm/mach-mediatek/mt7629/init.c
@@ -27,7 +27,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int mtk_pll_early_init(void)
+static int mtk_pll_early_init(void)
 {
 	unsigned long pll_rates[] = {
 		[CLK_APMIXED_ARMPLL] = 1250000000,
diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 892bd441a33..82f8c509745 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -40,7 +40,7 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int mtk_pll_early_init(void)
+static int mtk_pll_early_init(void)
 {
 	unsigned long pll_rates[] = {
 		[CLK_APMIXED_ARMPLL] =   1300000000,

-- 
2.43.0

