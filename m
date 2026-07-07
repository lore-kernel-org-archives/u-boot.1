Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B63C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F6CD84AA5;
	Tue,  7 Jul 2026 21:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="T0uELBXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B6784AB5; Tue,  7 Jul 2026 21:12:16 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8E2849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-49190e20a0cso2120483b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451533; x=1784056333; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n3AMpgBQeukJZKRSY7aq/pHbugi8Pa0q7WN9f9KUKpg=;
 b=T0uELBXUkMRTq6lMTxqmm/mwj4SaQl3iqzK39FMd7XbYBHzNQvwVWRSiiHN/Dbfh/7
 podFLRJgflYlbHOTbuaumPpVcI0mstMrhwZvwwEHwZrRzqsBOrM/EF0o38oNJAz0xgPk
 hJ88Lg8gLnwBwlImnUhLCyyy5LhZviU2ENmMMbH6UKM5Z9NQcnTIqnt7SauUxx8wDpsG
 vHGNeFSgeC3Y4IEUjQ9TKRHrqs9Odq7UwrcR3i8u/0JGntxehXU4y+MYgSdElkPkXsuJ
 p2ow0lGbzNWQsVSjgmrUu2yFJvTtUZIGFVcWPanjM2gHijw9gG7uV2zbqsKrZIYGMSEj
 PrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451533; x=1784056333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n3AMpgBQeukJZKRSY7aq/pHbugi8Pa0q7WN9f9KUKpg=;
 b=RdApZKK7l49AopRxZ6h51242qNJ813oKUAAweRjRE64E2zOjnC3wnvYB2i6QtUzQ3o
 DCLZZ7eWKxbpGCvkSwDYtWlJcpkURCxE8l5Gglw06Uv7WY6Owsu4uk25j8gEEQuKRrqG
 k3itEAmIcRPbanPYDz2zlP7b27i4YpO5yGn6cWEzyndhSAUuN3OhDkDtfJQCwESWKXio
 VR2AD3XPYAeZ7vvrMibz31bKzuhuZrkv1GvS9U5JLGbky2bBHjWnrRZWkRDr28ZFTvo6
 EC6GO1Jqgfx6yK4urTZLOU648nDyCEgH9vKdFwmoGpzzcB4a+kFgpEJqLE5ejoLRu5RD
 2RxQ==
X-Gm-Message-State: AOJu0YxecLPFNvEt9CiNJtatOkpiRCdrli4/BLG5yecu59BHwivMrLzx
 JSPz1GIlWq43KeK0p44aNK5u0XFD7gkEyDUXfs8FLgJDRtJjK900nWSgZvIBWUY5o64=
X-Gm-Gg: AfdE7cm5LglhNo8CwrVoIwkYO2gsJRlqMqS9lfyDQX/aOWPxr+HMErE5J+R/D+vJ9kB
 JpOKT9nUnRbSjAy0qoV3iADephQZOBZnKT2bBGVCj2kCE+y8Q98EYwwsf+hhRxkOH0cEkHuCyuF
 P3E+qG4GMxAMEa+2s3rtS9jZxkzRjnqfpWMFaZdifiFJKiFo1kNp8vCFnVXt8vQ1IchXZ0Tx83H
 DMw0xukhGClA51VUlaiMV4SKRrSlEUNd1/qFDt6kBRFG6oW2+iAZZ+2kJ8+0hE5VkJ1MBbKERHZ
 vECX25pgqFoQLXfFBpaYNSmMMqGKyjSjCPX4ziIZUrHZlJGXc8SBXWN6JRExy2Wi/FeM0sNHS4f
 /wNdKQjAyAznRmGUjCXM9fWEWjHuXXLWJCx68r5m8ME9FdpkfmEabbDFwI/2J3mHBvI3PSbs9gW
 GCQ0BdTKRn/EiK61l0UQ==
X-Received: by 2002:a05:6808:1202:b0:496:9b5:4eda with SMTP id
 5614622812f47-49fde2e02e5mr4565731b6e.29.1783451533284; 
 Tue, 07 Jul 2026 12:12:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:14 -0500
Subject: [PATCH 12/15] clk: mediatek: mt8365: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-12-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Bem06ey1WnGfcJAsH0ri0/0ziM9xoXG9eyRUttWLnMo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU9j3aT5Ab1FknrjIsCDNGfMSRAVGZcoau0FL
 7skGwbiSseJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PYxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfboH/3G9vsaInSFAtrgUzhbKf8fwYb+lgNvNOXYISMB
 ajbu3o0/LueZkHgE5Ch9UX6B5toCwJtDxgQflGBadJe86mXOpVrY1NJ6fWKf+2Mr2wSqf8k2fS4
 4X8KpJdc+kiW7hpnreXsDOuvj1Jih57k1TBjoDmQHQPtjOrx3pbs+7p1QDhANeHA5zSRpq3CCZM
 +qZQlwuHPDSYOitXk0gENhr5oprC/TyRaNBFaWN55CfeuBGWMAd7ydG9IEX/xJuyvsum8aQr615
 ij00SL5M32rR+SYin233/+kssBM6KcdAb4JT6pqrEPtfXeMlOZD6lk1xSqrIxA/Z09KhfqxXcTs
 mW+o=
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

Change driver names for MediaTek mt8365 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 1882ff9d6cd..1394dbbdd5d 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -790,7 +790,7 @@ static const struct udevice_id mt8365_infracfg_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.name = "mt8365-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_apmixed_compat,
@@ -800,7 +800,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8365_clk_topckgen) = {
 	.name = "mt8365-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_topckgen_compat,
@@ -810,7 +810,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt8365_clk_infracfg) = {
 	.name = "mt8365-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_infracfg_compat,

-- 
2.43.0

