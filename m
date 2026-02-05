Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1091ECD9AA
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 23:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5573083AA7;
	Fri,  6 Feb 2026 00:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QUV89Ni8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A9A1838FA; Fri,  6 Feb 2026 00:52:16 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04CB8382A
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 00:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4096aab5521so146483fac.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770335532; x=1770940332;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qok3CUzPZfIaNddyS79R7ejmcEgwvJCIc4Nl4WPftIU=;
 b=QUV89Ni83RLY5856ptnuCXT0hi99V4lg0/TID1i9ojbLkionzal0tG8T8Q7vvIaqNY
 0JfKxx7oSOKiqw2PP4hM7bmcNLXrPdC3/qUnk2vaOAS6bvQNkJlxN/z+pX3EwGYFYtZj
 eisY4CTULmDOwyLzNy9yX1rSlfx4riNfI4tC3hXH5Ln0rMShTF7dm84YPUDUIuYnGzmD
 BwqNxipCipDZ39vJc5bQu3YqlBtoAn3UUJXhlObCyrdn17Juho3goelkZHPnxLKGIBl7
 3eGzIlmFxOCl8d+16debzaFd0AXruUv/HhTgfmL8//82enWVe/3MQ+AF1dF1u4mkMxHc
 Ltzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770335532; x=1770940332;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qok3CUzPZfIaNddyS79R7ejmcEgwvJCIc4Nl4WPftIU=;
 b=InedWBPAzDud089YZWbgdghovqYXvvtV0TCnO89GrKXrIHhsw2C+EoYA8nIOFLQ03q
 Iz7uCqyArPtG/G0HJyBvTyGCJw+N4P7DKgGIIEh5l3MwsjdH1Ca6HVC5yW+JfZVyNl7p
 Qf7OCn9Jf37/fBL94SKogKsQkWgN1EXD+UlxQswMbg/qqIuyq8QFiHVGOO0RA8dlQ4vR
 I9oLtk+YMP7y6AVo5I6Aq3MchT91f7w14+CtiGeQaBI63m134BiYf3VL1Y8AQnQFZoPz
 Crm9AkVeP/lwiSItmH3C3v2NaiUmhNY3PLJzslW4+QncWn9dmCka9LXzfsJKLZTNWT0K
 OcUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe7b6K2CBdr/yXYTUh56nn959oCrDJyUoUwP7oZVako1uSb8ruuRxs23eLQu7Lv6gsgoW/sGw=@lists.denx.de
X-Gm-Message-State: AOJu0YwIqQ1nbI/bAHh6603eFzqMsweRj1O1XV4GvgWu+hhCvqxZm0Ly
 reohU+woVpTQ7Bc8hBueQHsWK73fRz+QNOFNqtHsJsPKtA4K36c1WUeGAoI1oe56Dak=
X-Gm-Gg: AZuq6aIy5M4PWzXCc+KYxDi2FldJzx/YFCJPWYY39ObTXDRnmcFPO1EpSbM/TVg+YEZ
 QEMVgDssCQVBy9wNEP/X28l/WGK2ACEtN/uMNZYw8qq8ghu4t/8M7BMMBUnYn8iBEGI7VvqNdxB
 CbU9VB1B2WYbPQ2lPw8y5coAGWZwEKClBdQ9pdPVebcMnbTC/x8NNKBJMe/La3BVAenmg7IGTnj
 N4Y0KtriWoaoNVgUq0Y3TFYdLwV+Zg0B0Ra457T5v8FaULDkVuqh5iOYMkK1ad9TiAh2wUz0W6H
 z2zEts74De47I1SW+OQdiuWRq3z1mH931bQYKfx7ue/XaOKtmeqnzDhxGkpIyQlU5Cn+QP/zQMo
 OEBlsDUMJxPu6Damv6DrWtkZuAMJoPFi/5YRqqV1vpgBHeYMLvqwTlSw5+ic4G3Y9GB5Nunwknd
 THc5xNGRRKILDAu9o=
X-Received: by 2002:a05:6820:623:b0:662:ff03:c213 with SMTP id
 006d021491bc7-66d0cb3cbd3mr488190eaf.61.1770335532469; 
 Thu, 05 Feb 2026 15:52:12 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3adcae3csm312165eaf.9.2026.02.05.15.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:52:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 17:51:25 -0600
Subject: [PATCH 1/5] arm: mediatek: use default weak mtk_soc_early_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mach-clean-up-duplicates-v1-1-b7d4a43c18eb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DfoYQpYFZSh+y/LojVLmTYIkc61Qd+wZI3EHDVKVyC8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphS0JLnpav2Y03zX3VWCtvDQdJvvcFzw5+rXIJ
 hd7jby/xYCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUtCRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArbwH/jYS9ye9Erausfkrhf+bC3RuO5rNu5sE4Vfq/EJ
 8gj1zHjjfKcwzjhez0i/7N0/rWO7h091dr/BZ6c3QP+aSqMX/s7fytPUiYj4ypPu8f/xmmKBuwg
 /QMSCkkcm+DxZsY7v9r4u7qwt05MsNp8Bb0vowLKDyIZS+BuSLpzT2wXEV9k/dmIDzZBni8fKvl
 fEycfMeQj4Y6MfJ1TumrCiKVWPhGzViavCmuSVWT4v5fvumJevAE4fWjnqqZVpol1qKuBSUFMGj
 J0BT9USaK8YZdXJqmYFmEgZG/73ikP8SNAEhn25lTcyYRGkGIdXgT6EaLJ+nv1bGUO87G3wf1Uu
 fghc=
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

Add a weak default implementation of mtk_soc_early_init() in spl.c to
avoid having to define it in every SoC init.c file that does not need
any additional early initialization.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt7623/init.c | 5 -----
 arch/arm/mach-mediatek/mt8183/init.c | 5 -----
 arch/arm/mach-mediatek/mt8188/init.c | 5 -----
 arch/arm/mach-mediatek/mt8365/init.c | 5 -----
 arch/arm/mach-mediatek/spl.c         | 5 +++++
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7623/init.c b/arch/arm/mach-mediatek/mt7623/init.c
index 3d6ba3f383c..8713889b92d 100644
--- a/arch/arm/mach-mediatek/mt7623/init.c
+++ b/arch/arm/mach-mediatek/mt7623/init.c
@@ -16,11 +16,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct boot_argument *preloader_param;
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 int dram_init(void)
 {
 	u32 i;
diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index 37243547da8..39072622788 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -42,11 +42,6 @@ int mtk_pll_early_init(void)
 	return 0;
 }
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	psci_system_reset();
diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index ed67150e611..9743e39d582 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -45,11 +45,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	struct udevice *wdt;
diff --git a/arch/arm/mach-mediatek/mt8365/init.c b/arch/arm/mach-mediatek/mt8365/init.c
index 8f03ed28763..fb14a5a1902 100644
--- a/arch/arm/mach-mediatek/mt8365/init.c
+++ b/arch/arm/mach-mediatek/mt8365/init.c
@@ -26,11 +26,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	struct udevice *wdt;
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 247d7ee6f1d..bcd8441bbd9 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -11,6 +11,11 @@
 
 #include "init.h"
 
+__weak int mtk_soc_early_init(void)
+{
+	return 0;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;

-- 
2.43.0

