Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E3BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A8C84AA2;
	Tue,  7 Jul 2026 21:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bt9bqGy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31FF84A0A; Tue,  7 Jul 2026 21:12:13 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E79D84A90
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4a0c883ac23so534959b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451530; x=1784056330; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wVxDUnqW4QC2V/Qo76AhUHVGBIx6K0zKatdljrz5PfQ=;
 b=bt9bqGy+dIbrhVfytSUa8aubB3E3IIdZz5sh4B/dSWOc84hk5kTkIND0hc10NumwRM
 PuP+39pHaubw+U3zV4bR+kMqlY0FJzI7+FXVCd7qW7ZbPUCV2NvKvd+DeectUe8ZV9JR
 tp6b5uj2XbhOffn79tWESEyNtBRR7b/KlIYJjG9tMeSuPfQPGVuKdi1lfhS3YyPeYj5g
 hJp4E5rFRkKSFCYgqgEzfA7cB/6ad9shut00cJmOmYloEMxTsoxK6sYF0UOE80U43NVE
 7TUG1kdDh6yk/YNNX5zpi2ETeI9C6GzvG1PJpx/Hag9HrVJkTxhk0vfxPXFy/eM4D4/z
 8Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451530; x=1784056330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wVxDUnqW4QC2V/Qo76AhUHVGBIx6K0zKatdljrz5PfQ=;
 b=A0gxs+EEpQGK4aKC2iRd2EPMyE4MTILiU9eCo9XFqvLXj0GfjFwBOm+eV7WVXY1NvN
 6+FqFymqPP2jhvGywNOPrShaImPDNgggHyLkkKisrR/VEY+2YZySWl0WT+tIfiUExjrw
 YyiVBjlMJpAtkjm1bE4isn5UZ1rAKNV7sY1IbK/A/r0/V8EuXuwH/FX0MKAoLj59ptlj
 R0V5WF6q1AycjxlEEHFLAe6dX5R3p/bsu1YJaJUmaxZsjEu/ZleBf7QQ6zAJVKfwAnjI
 PQ7+GYbAPncJRKUZhE9dQ3Wum6koXeVCeY/fvvmm9IN0hEm4SsRzDSEG1xnPkLW/IXyT
 GVog==
X-Gm-Message-State: AOJu0Ywn1E1bW4Zi+Da1XHVTuAJLsKBIMljkOJ3PwItjPyhWymKS5n9c
 xxceFfeIlPMWOPKCP54blwvbER4fyB+HbDa66CySQTOT89wN5XvsxvpHkMkhN0CoC5E=
X-Gm-Gg: AfdE7cmO4FJx5hAYfOF9jDvBhQIoY1dQCnltcilFTuGyfyfQdX5/rFelMd44IhxvrBU
 e/5nFb9IBotJHa59rozzXnaEs8NOd3ZIhnFqoi9uteX8+LBlisxqluAr0WUC5jU0Z3Hz1QaLdI+
 9rlrph+0f298+aRugFKIqSk0lu62upZu5AmfzP9NTNPsh0GP5NPvm08fW1YOx9sMdkuTQdL9LkB
 M0vUumwNvPKa9AB+xW9otUgZ/EgkmnoW7H7UuD7cc55XBJPkMnvx3aeSSR2Z/IYMuJSp3JYRuU/
 SlvAPKMLtfD59pVmXsA3PBwMatfmeQZEL6XRuTazjObGTxbseGJ4NzpkbVlOJYuHyK9d05rmcqU
 +Rxo+L1fvyhz7jD95qQ1HHx8dE5UULeQyyo8xou5xusiQ307ww/fCSURubcEULro0lB/YIOYjQP
 x3qh4o/kv0rzhzCFCQkA==
X-Received: by 2002:a05:6808:1996:b0:497:e0bc:afe0 with SMTP id
 5614622812f47-49fde0e81a9mr6100166b6e.28.1783451530338; 
 Tue, 07 Jul 2026 12:12:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:12 -0500
Subject: [PATCH 10/15] clk: mediatek: mt8189: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-10-283d9a55361e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WN/UorpXyQJmxlMj9NT1HQ+RbqkGY95M/x+74UuVYzE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU9S0y+HhZrynpJd+rjzXmhbZyaxL4eO/yhf6
 dIQSw0zwO+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PUhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjKgH/RwtYJ93xjokKX/ow+6LJE3rP7d02wJhgYB3Ifg
 QKqMxSZVawXLqALooT1XkrvfaSye4ZZWT3onk5HFolSSs6IlbUyb73343+chAKR0pbzCwUQEsae
 ajdsU+mERKSdiwktBRPxZif9MzQkz3m5tU49UpkHkbHYvZ733tXkKKbIMB++zDWDD8UB7x9UQPR
 E3oFNF9J98iyJ30aW00oLkMGKgxAdKQjcto8jnQXYxc7g5A8rnx9drupi5SoZk7JLygDdSBrM26
 516o00ld0PDi0zlg4JctfrPcUOtwr4jfDoLSEtFdw4bK61QoJL3qMVLLmBTz2+o588ElJovQ07N
 Avvw=
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

Change driver names for MediaTek mt8189 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index a520f4f769c..7dd722dbac4 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -2045,7 +2045,7 @@ static int mt8189_clk_gate_probe(struct udevice *dev)
 					data->gates[0].id);
 }
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.name = "mt8189-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_apmixed,
@@ -2055,7 +2055,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8189_clk_topckgen) = {
 	.name = "mt8189-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_topckgen_compat,
@@ -2065,7 +2065,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_vlpckgen) = {
+U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.name = "mt8189-vlpckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_vlpckgen,
@@ -2075,7 +2075,7 @@ U_BOOT_DRIVER(mtk_clk_vlpckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_gate) = {
+U_BOOT_DRIVER(mt8189_clk_gate) = {
 	.name = "mt8189-gate-clk",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt8189_clk_gate,

-- 
2.43.0

