Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF903EB3641
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E0F83FC5;
	Tue,  3 Mar 2026 01:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l9RPX6e8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B217480517; Tue,  3 Mar 2026 01:05:18 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6365383F98
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4638fe85a7eso2216546b6e.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496309; x=1773101109;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SFMdrhZB+N3rR3lfY9jXFV3BcqlPQ//sXmM/62cQK9c=;
 b=l9RPX6e8HcVN+KwH5S2NjGek2lpgDwOvRJE9g9Bnf9cM2trJAM5sKdTPSWCKC+2yfS
 /6lNnomG8wG4n/3AkEKWGq+h+OsEZJ1mgmnvQ+vcJJ9D7wHPNsNf0vE5YdsVMesOPWQB
 +sh4RcnP64P36/s3DGoXqWBBkibTT/y9OU+ou/Wc65RWs7IfwXMwYYLC8sjOO+dUKkQp
 wy2Y9/TExu/UX3zzkrViu6k7+Inhzu/JxDNqCt5Ci5bte6RyfU8ZgpKGeKR4yI0xdhul
 M5daV2JvMlvQ6Sccc1phQBOcR6lHe7xWOfwF7xfGPDmAA3IO8WwnSdVsT6RttB0rnc05
 vCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496309; x=1773101109;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SFMdrhZB+N3rR3lfY9jXFV3BcqlPQ//sXmM/62cQK9c=;
 b=o9UOGIAU44CFumYD1JGXwTsneFwUKdVwvpd8NcXm3iUrj1w0r3CSUb471OMpdSHnB0
 sOw99lChQ+cNWPv7PkKnZMFZzFaKnAPefZ6XtvwwVDRiOkfrjF76X2BD7E+eMK9mg3Xq
 QGcwEzWBxzGyvDbJJNiCZFxaJlwfHguSEARjLTLs24nJUmUdkOGZgHmQ3cxYJ+r7i1uP
 g8AOMSiEjg+fo+CKMu3xTgqL+2OilmHjhNsWXjyRPyFKd4gfEVRHReIWMMhxDloX+eZB
 buUxGANMSBG3lWbMyYItORQfvMQ3iEN7aBbgRYCoaN+AAr/i7ZqwXTzR4alO2HqfXOkD
 DgNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpZAlw3ca5fL7hSm/vsjSuokZKIKin0vqrsa++lnhCVtzRhYzHftDjOf6g19FJnFT8rL6I4Es=@lists.denx.de
X-Gm-Message-State: AOJu0YyUG9GsGb4NFRYTISbLGKK1rv21yJVN0ivnHlJp8mtkVbXPy0LO
 BbasUMKZwlt3Wxv2aCZdZb9cMbH8VvYOOphAgkT3xVmliEcKgQHUfF5tjTP9Ckmm9zM=
X-Gm-Gg: ATEYQzxSz6qw787o3PUDWwM0IVzyCFx0EX+tMHJu5BpJ5m5EKmIZQlwyTBsGQmwRYdZ
 v0XKT0chujPdrlSufKIwahUsl1XajhXn3GQNa5GkLUVKADx7IyN4oyCOzXfyQkaTxEOiwvWQdSs
 AJn3srhvuXy1S86cwK7f2GFi0C7GHfi9VI+lIcN23fOrzqM4ufNDErIQeUXOqcOo61FCsOYka/x
 BzHy1v7tdAW2UrTUcrx3k9J8pF+GbDfbS1ZOk+U0B8kuAvKOA93zbBB1wXwRqPtGWdFfOM5TAE2
 iVPXn4dtaIDTiO2nx4pGjSPl1/kv8Rg6iMXhjvBM/qvGC50crb16fSfW87iXRdfijs9pRix/Zzm
 dtNi4IWeOFONhmgxafMLz2LGeDDZg8MIcC48Cj3u3Cj3pnwORTlvVCMz1zxvx3NnCrbcjOaOhLY
 TAeQgphYwAibc58tUFbkt8EifsWCrZ
X-Received: by 2002:a05:6808:1a2a:b0:450:d143:b77e with SMTP id
 5614622812f47-464bed0f57bmr7252428b6e.58.1772496308943; 
 Mon, 02 Mar 2026 16:05:08 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:18 -0600
Subject: [PATCH 09/14] clk: mediatek: mt8365: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-9-32f45085f4d0@baylibre.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20439;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Sw3RvI6ETkGxBJkUUMZDGfY2h3SnykLHR+rQiEJ6ToU=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiWFQYNL5dMKIGR3H+bKbo5/tCCQ60yldIYG3
 TIGPqqU7LaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlhRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ApOUH/iDXJj02Rdlww3Mx/5RZIbfWcKGc2qv5f9ZPQte
 uNewwE2xdjSuJdPSo1RC1G9FTNBMrUBuu7CdRVAdCSdLTa85E3hd1g69yB7seadciQiLL9zym+w
 GpRrl49SUguogo8Z7IFKn3JNY6b5Hne9Nx19xbRHVFWZAVi5wEwBIjHMVTBze5yZxy4ueJ8tRYD
 Yp34foE4/6XLU3Rm825lGaZHKRSH6/u9LcTrG7f9vVBZHv6VvlK223QThvVBdv5c+4nvXQnG+8F
 qhcBcHWkRTrU3UKrg13O4tAsxd+v22Sp2OzXAKnws6c1/28IEmrIFHzGP2r1zHLBu9RIUf50ssh
 VhXM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Convert all parent clock arrays to use struct mtk_parent. This will
allow us to simplify core code later by having only one possible data
type for mux parent arrays.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 522 +++++++++++++++++++-------------------
 1 file changed, 261 insertions(+), 261 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 2b1703e7203..41dd2479c5a 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -298,347 +298,347 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR2(CLK_TOP_CLK26M_D52, "clk26m_d52", CLK_XTAL, 1, 52),
 };
 
-static const int axi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL3_D2
-};
-
-static const int mem_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL1_D2
-};
-
-static const int mm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_MMPLL_D2,
-};
-
-static const int scp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D3
+static const struct mtk_parent axi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+};
+
+static const struct mtk_parent mem_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+};
+
+static const struct mtk_parent mm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent scp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 };
 
-static const int mfg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MFGPLL,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D3
+static const struct mtk_parent mfg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MFGPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 };
 
-static const int atb_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL1_D2
+static const struct mtk_parent atb_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 };
 
-static const int camtg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_USB20_192M_D8,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_USB20_192M_D4,
-	CLK_TOP_UNIVPLL2_D32,
-	CLK_TOP_USB20_192M_D16,
-	CLK_TOP_USB20_192M_D32,
+static const struct mtk_parent camtg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_USB20_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_USB20_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D32),
+	TOP_PARENT(CLK_TOP_USB20_192M_D16),
+	TOP_PARENT(CLK_TOP_USB20_192M_D32),
 };
 
-static const int uart_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int spi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int msdc50_0_hc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL2_D2
+static const struct mtk_parent msdc50_0_hc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 };
 
-static const int msdc50_0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL4_D2
+static const struct mtk_parent msdc50_0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 };
 
-static const int msdc50_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4
+static const struct mtk_parent msdc50_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
 };
 
-static const int msdc30_1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent msdc30_1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int audio_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL1_D16
+static const struct mtk_parent audio_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
 };
 
-static const int aud_intbus_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL4_D2
+static const struct mtk_parent aud_intbus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 };
 
-static const int aud_1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1
+static const struct mtk_parent aud_1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
 };
 
-static const int aud_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2
+static const struct mtk_parent aud_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2),
 };
 
-static const int aud_engen1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1_D2,
-	CLK_TOP_APLL1_D4,
-	CLK_TOP_APLL1_D8
+static const struct mtk_parent aud_engen1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL1_D8),
 };
 
-static const int aud_engen2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2_D2,
-	CLK_TOP_APLL2_D4,
-	CLK_TOP_APLL2_D8,
+static const struct mtk_parent aud_engen2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2_D2),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D8),
 };
 
-static const int aud_spdif_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2
+static const struct mtk_parent aud_spdif_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
 };
 
-static const int disp_pwm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent disp_pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int dxcc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL1_D8
+static const struct mtk_parent dxcc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
-static const int ssusb_sys_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2
+static const struct mtk_parent ssusb_sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
 };
 
-static const int spm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D8
+static const struct mtk_parent spm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
-static const int i2c_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL2_D8
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
 };
 
-static const int pwm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
-static const int senif_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2
+static const struct mtk_parent senif_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
-static const int aes_fde_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2
+static const struct mtk_parent aes_fde_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 };
 
-static const int dpi0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_LVDSPLL_D2,
-	CLK_TOP_LVDSPLL_D4,
-	CLK_TOP_LVDSPLL_D8,
-	CLK_TOP_LVDSPLL_D16
+static const struct mtk_parent dpi0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_LVDSPLL_D2),
+	TOP_PARENT(CLK_TOP_LVDSPLL_D4),
+	TOP_PARENT(CLK_TOP_LVDSPLL_D8),
+	TOP_PARENT(CLK_TOP_LVDSPLL_D16),
 };
 
-static const int dsp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_DSPPLL,
-	CLK_TOP_DSPPLL_D2,
-	CLK_TOP_DSPPLL_D4,
-	CLK_TOP_DSPPLL_D8
+static const struct mtk_parent dsp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_DSPPLL_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL_D4),
+	TOP_PARENT(CLK_TOP_DSPPLL_D8),
 };
 
-static const int nfi2x_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D5
+static const struct mtk_parent nfi2x_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
 };
 
-static const int nfiecc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D5
+static const struct mtk_parent nfiecc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
-static const int ecc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D2
+static const struct mtk_parent ecc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2),
 };
 
-static const int eth_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL4_D2
+static const struct mtk_parent eth_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 };
 
-static const int gcpu_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL2_D2
+static const struct mtk_parent gcpu_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 };
 
-static const int gcpu_cpm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2
+static const struct mtk_parent gcpu_cpm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 };
 
-static const int apu_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2,
-	CLK_TOP_APUPLL,
-	CLK_TOP_MMPLL,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4
+static const struct mtk_parent apu_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+	TOP_PARENT(CLK_TOP_APUPLL),
+	TOP_PARENT(CLK_TOP_MMPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x040, 0, 2, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x040, 8, 2, 15),
-	MUX_GATE(CLK_TOP_MM_SEL, mm_parents, 0x040, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x040, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x040, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x040, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_MM_SEL, mm_parents, 0x040, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x040, 24, 3, 31),
 	/* CLK_CFG_1 */
-	MUX_GATE(CLK_TOP_MFG_SEL, mfg_parents, 0x050, 0, 2, 7),
-	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x050, 8, 2, 15),
-	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x050, 16, 3, 23),
-	MUX_GATE(CLK_TOP_CAMTG1_SEL, camtg_parents, 0x050, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_MFG_SEL, mfg_parents, 0x050, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x050, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG_SEL, camtg_parents, 0x050, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG1_SEL, camtg_parents, 0x050, 24, 3, 31),
 	/* CLK_CFG_2 */
-	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x060, 0, 1, 7),
-	MUX_GATE(CLK_TOP_SPI_SEL, spi_parents, 0x060, 8, 2, 15),
-	MUX_GATE(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents, 0x060, 16, 2, 23),
-	MUX_GATE(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents, 0x060, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x060, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI_SEL, spi_parents, 0x060, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents, 0x060, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents, 0x060, 24, 2, 31),
 	/* CLK_CFG_3 */
-	MUX_GATE(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents, 0x070, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents, 0x070, 8, 3, 15),
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x070, 16, 3, 23),
-	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x070, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents, 0x070, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents, 0x070, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x070, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x070, 24, 2, 31),
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x080, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AUD_1_SEL, aud_1_parents, 0x080, 8, 1, 15),
-	MUX_GATE(CLK_TOP_AUD_2_SEL, aud_2_parents, 0x080, 16, 1, 23),
-	MUX_GATE(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x080, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x080, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD_1_SEL, aud_1_parents, 0x080, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUD_2_SEL, aud_2_parents, 0x080, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x080, 24, 2, 31),
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x090, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents, 0x090, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DISP_PWM_SEL, disp_pwm_parents, 0x090, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x090, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents, 0x090, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_DISP_PWM_SEL, disp_pwm_parents, 0x090, 16, 2, 23),
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_DXCC_SEL, dxcc_parents, 0x0a0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents, 0x0a0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents, 0x0a0, 16, 2, 23),
-	MUX_GATE(CLK_TOP_SPM_SEL, spm_parents, 0x0a0, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_DXCC_SEL, dxcc_parents, 0x0a0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents, 0x0a0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents, 0x0a0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_SPM_SEL, spm_parents, 0x0a0, 24, 1, 31),
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_I2C_SEL, i2c_parents, 0x0b0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x0b0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_SENIF_SEL, senif_parents, 0x0b0, 16, 2, 23),
-	MUX_GATE(CLK_TOP_AES_FDE_SEL, aes_fde_parents, 0x0b0, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_I2C_SEL, i2c_parents, 0x0b0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x0b0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_SENIF_SEL, senif_parents, 0x0b0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_AES_FDE_SEL, aes_fde_parents, 0x0b0, 24, 3, 31),
 	/* CLK_CFG_8 */
-	MUX_GATE(CLK_TOP_CAMTM_SEL, senif_parents, 0x0c0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_DPI0_SEL, dpi0_parents, 0x0c0, 8, 3, 15),
-	MUX_GATE(CLK_TOP_DPI1_SEL, dpi0_parents, 0x0c0, 16, 3, 23),
-	MUX_GATE(CLK_TOP_DSP_SEL, dsp_parents, 0x0c0, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_CAMTM_SEL, senif_parents, 0x0c0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_DPI0_SEL, dpi0_parents, 0x0c0, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_DPI1_SEL, dpi0_parents, 0x0c0, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_DSP_SEL, dsp_parents, 0x0c0, 24, 3, 31),
 	/* CLK_CFG_9 */
-	MUX_GATE(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0x0d0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x0d0, 8, 3, 15),
-	MUX_GATE(CLK_TOP_ECC_SEL, ecc_parents, 0x0d0, 16, 3, 23),
-	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x0d0, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0x0d0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x0d0, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_ECC_SEL, ecc_parents, 0x0d0, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x0d0, 24, 3, 31),
 	/* CLK_CFG_10 */
-	MUX_GATE(CLK_TOP_GCPU_SEL, gcpu_parents, 0x0e0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents, 0x0e0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_APU_SEL, apu_parents, 0x0e0, 16, 3, 23),
-	MUX_GATE(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_GCPU_SEL, gcpu_parents, 0x0e0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents, 0x0e0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_APU_SEL, apu_parents, 0x0e0, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
 };
 
 /* topckgen cg */

-- 
2.43.0

