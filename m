Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F033E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CB983C91;
	Mon,  9 Feb 2026 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="puukaIk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D56FF83BF4; Mon,  9 Feb 2026 17:40:28 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8EA383C23
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d18d9503eeso3465846a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655225; x=1771260025;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7sAvchmgEzKoKa93CF5TA/gaoa9LZRahPuNedYnHhwg=;
 b=puukaIk2rE679dA0+/CslRuY8k1hfBg1Pnh+QYHWmLS9SkQSKO1iYN4u7Tg4ZbALAS
 NEnrsL/55pQ45aMpcu5NwIunYEkDeHqBzL9xDQD23+Zgmc7jJYr2+nAMBlgDGpyEC0h9
 zgeqPBQ/AEOTH2GuoT8Kdn1py/JlVrI0mmP2zsJQheknoXjK3XWOpYSITwnb9wneUnyE
 2jg4yx3NbRp9KbYo75yQCilEtGvzrFrJTzf9H3SRfzhPw5JeJL8WUWxE0e4e6f44HNMo
 YYezeFSKAOSf/Y7CJkVoYiJQoK3T1NE4LCNQlG5g6lJ0N8dqxUBrqaDioD3x12Cv/Ys8
 srtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655225; x=1771260025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7sAvchmgEzKoKa93CF5TA/gaoa9LZRahPuNedYnHhwg=;
 b=lOqzAJxMAAdlfnknt8y5yazACdP92FybNESU9g4gFg8SQMSNseK4fZJ4VaYOhilpc3
 sFFdNrkiX1dYVrqtbE80p8BJsYKKbAsVwV+rkyNPcpV3Pj+tHMVC/Sdj05EFa8wXWJok
 +YDkUNBvruZKeyCoS2bzIDae9J5HL0pJsLPaiYKv6iorMkzhhXxuMyFoULPby2z76FeM
 ecUWiP6QUkEa2e8diS9RkTct3/hXxdGXRn7tzY8Yz6l0z/AaJd8vHs+LYQ1krV5p0SUN
 OUa7k33UEjjDAZ3boTVRNRm+6I5UuWCB0G/9UHGt34Hrj2UWfRXKh5OagdOmlZTvmiN6
 T16g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF51r63by7jW6p2ofVGPiS5dIJT9uz7iYUdBj7txxKIy+73/PSVghEVzafnPQ2d/E8sKb7ub4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg0z7N95VP0NL40jbOD1lyOZYdszTwT+VrMOVvAkvLHYPKPf4S
 DWYkevHnTgaKuHJpD3fOV3AbcypPJFHR9yPdMwZ/2/xa0sCU+SfCQt1WdPz+gfHaaXU=
X-Gm-Gg: AZuq6aIlpNMlmEi+s7B9JESogzKdtcuMCqE7RYzeUCTE279CkLXBzox/iHvHpR+P/qL
 18OVk+GpSRs0kEgBnkRn7tQiatJYsMUwLI3SCUpiSmlId/59Kjvrjy4SC6zme7kkXmSUdURjzVj
 XztR1lNdHiDFCHiqba+9Vi/RItP2PypFreU3iVwiCOqFpap+FPCAHwByenf7DlR9QwhfvJt2rEM
 qbo8aYOpipNeNRCBYuhUQzo14ySCWsz0RIVP/IAh/9BZhiDoFluPchAXeWeu1srq17lATLdw9WL
 trxWz2U1gRptW6WM7CEciIwxhcH1dBIAihgqJXJcJK0eBdy4NPN0Y0XhR9Ko3JaI+tmN+UmoS8/
 tRWng0lqvwVzyxqsfONl5jCw50MCSMyGb4zIdPY6zow15lHQ1j2PWGryeCjh1cUwASZqGPYSVji
 7Z7kmvVk5YqyBUrDo=
X-Received: by 2002:a05:6830:82f7:b0:7cf:d119:8d93 with SMTP id
 46e09a7af769-7d4641e52bemr6632287a34.0.1770655225445; 
 Mon, 09 Feb 2026 08:40:25 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 10:39:28 -0600
Subject: [PATCH v2 3/7] arm: mediatek: mt8183: remove unused function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-3-e3b22282c74d@baylibre.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QryjxLwE5wbmxvrbkAoWPcWPZWEPiPplm45AL9h/Dl8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3V/niobAes9bBerpA5kjGizkQ5FNU/t8/ob
 HdPV9tmIaWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoN1RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATMYH/i/X6LE/fQai0ORYJNtHdNb5S5NHIDpoJ0UUXpc
 +/+cJmnBiyy7hw0P1yecHDBhpzCgG9SWzOgq1OTsCDfHNMSzljJtv5IWQE79jgwgwxNLNhLtuSc
 hiCSIrcQzW1YP6o2ZN8SULE+ugteMmtVtw6B7NTYZPOUDFvntHGRtD+Lmlec17J0fHMAnbroYNX
 CogKWZ2RjxiZvZ/Tv9XU8pogIM/EpuFvcnfuxaAOyYgYdwPRkSf19pi+gx5dUH6RkiMvBx1NGlS
 gqJ0CXgIuLtOegNstrK+ZMMjokoAQ4d9Xmo08Cp5wfzxFw565zt34vfqJ+ZuVTpwxa02NBcQTse
 ubZM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:12:16 +0100
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

