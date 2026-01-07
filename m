Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231C1CFD65B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AB484099;
	Wed,  7 Jan 2026 17:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oYR26SZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CAD8398C; Wed,  7 Jan 2026 16:51:33 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACE580433
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e7f68df436so733652fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801090; x=1768405890;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gD3JTAQUAdeki81bMKB4j4lbcNXdfEQPQdZtM+Jleis=;
 b=oYR26SZxpPCfKRcuOhGCxmSFB8zR11cSxbms2b8+ckVkMpmrL/rvKl78UfLI7XkD10
 ZvsrumoEHGzhbcx4AlWfMTOiS8zZaZ6GAqWH1azCGVjT1pA8sRit8w4VRN/hO/qqyqby
 oSQ0+4v1PxlvLsDfoFeB563yuDCzBxPmF5Tx5sjYnG+erMJya+Q8csDMIKUtOrkMGkwJ
 RVKV0uAR543RpFSofqPMkAttRpbtUEfsah0qhl7Ab4j548gye/4W3YUsZlTKzA/RNO6e
 wPsPhubAKdfPlt54fIIEBsisVUpRG5ANyFGHiPpUlH3iLT7xU6oTfBMtF3rj22H5bjH8
 TJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801090; x=1768405890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gD3JTAQUAdeki81bMKB4j4lbcNXdfEQPQdZtM+Jleis=;
 b=apjXhNAL5JnRKumKxntkoypnvS3a+gk8+IhVeALaVauEN3xTt7htKReOd775+wDzqd
 ZS+/OzMcmZaemNzS/G5OZmU6NV9O1O6vvEC5swUHN/wgjlYD9/HIJFvbfUyCDg7Wrtd3
 P4q0Ry+2Dh+u59xhGYZovMIl4jUgLgFhqB/jTXPwI8vfH8NRCjlPQz1bNgrvnGkKOIYP
 DEQxIk4kkLTBhBQFO4gIdeb2OALld5rZFGLjO7H0jI8PNPHHu0o/94ouZvUJwnxbuDVn
 Bru7ya17yPQbn8ID9oR7NtFUJvZTdKp0LP8D2B+eGqdKoi3j0qRbPEgMhQHv7ms4tXTm
 bPVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwyUSAbsZ8+fQmsd6yVLp3LTw2OCdtrBhMzATHA4OJeuZXj4JGj4+euW3OR9jcENVaGNlTbaE=@lists.denx.de
X-Gm-Message-State: AOJu0YyJK1AumB5cCrtzaYwqbLkF1Xepcw6Fx1UevWd0008o5MkCKoKs
 s37cpyJ4dU+0LzDccZwy58tew+Fpc7fFebM1nhnv9DusICkpVJHS57+qOOw7mFg0SZQ=
X-Gm-Gg: AY/fxX7pJpXQH7fvGzHPQ0RAIGdrDwWSYSHcbslOWhgwosuWAwMCBh1uv+TcySLDZky
 mOEaSV6UKLbJCuxKmWD/7NeKrV6Em7lfWg5C0ohfMhBA99y3LtCx74ip3H7hiJEmpnPoEhOaqzY
 ANaGCkfl8yPCK9unaBUCBc7kh7EguBFvp7CPThRF35MXClxKTFDhtt5XydWa3VFXU+OuRv0oqMr
 bPvx72byTegIxmOCGMt7G4oIP6JkoRDpBFJRw5MCV/suIEjSjDG03kl6NBPTl1ujFk4LCextB2L
 zm8Qmzn4cNTVXN3xNXPosj5P9idL0Budcm6m7QSDGmzV4hCxUusTzJ+cS9e4FHMdhUOhqmSNJah
 sRbNFS/LThCFsAINAmWsoIqSc8+8yWMjgS9WBcbajBzqFUSnSsbRx+3ObJIwn5QbdM92HckAusn
 oAbURuOrHqZ2/Z/o0=
X-Google-Smtp-Source: AGHT+IFNiFDwD3ykeABMurt6mHZefdNMUQMC5xaeDbhfkstXKOOAl821/PZCiCUPctuqbpIDyCKgfw==
X-Received: by 2002:a05:687c:2609:b0:3ff:c029:d24c with SMTP id
 586e51a60fabf-3ffc029d4a6mr1157900fac.17.1767801089984; 
 Wed, 07 Jan 2026 07:51:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:17 -0600
Subject: [PATCH v2 7/8] clk: mediatek: mt7623: set unmapped IDs to -1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-7-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gfpOIod3WRv7xKKVBcV5wEw/YKY2k9KWceHRU+LE58U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoDnVpJiNiB6sTgPXVSSCpzqM2TpbtCDz+mzd
 /OgdKcR95+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6A5xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AajkIAIDyj7u0cfxHa5Zv3Dwl3Q/nuLtoUBpd+0SAMFG
 x9aeVqOOQXpmVir7dHAiejgvEbd2agw6VKlijVLL361BgMQaS0nlI70q/9RPxbPS8sFZGbFTJ1E
 M9g3PcVaj5RfvZSyrlrYxm4v8lu0vt31ZNZkB0k8ST9uSRDDzZdqo7c5dsK4xz0m/IN5xon32A7
 hQIXBpnUOxU+uGnkR8Bgqaq7z3DChuQlViIfQIorowPqLri0W9h82RWBjHKFfcCvz6kfq+xMfdW
 3xhh/LsN0D3SbHWNqZhQhPAimgZ+DTa6tn4jiSU90P6aLiBYC/KtkfeHcpiIPx72x82Z4MejQ5B
 qrBY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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

Add range initializers to the id_offs_map arrays in the mt7623 clk
driver to set unmapped IDs to -1. This prevents accidental usage of
unmapped IDs that would otherwise map to 0.

mtk_common_clk_of_xlate() checks these values for < 0 and returns
-ENOENT in that case.

A range initializer covering the entire array is used since it is less
error-prone than manually looking up the value of each macro in the
existing initializers and checking for gaps. It is placed first so that
the specific initializers override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index eca8352d8e6..6ce1d729736 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -26,6 +26,7 @@
 
 /* apmixedsys */
 static const int pll_id_offs_map[] = {
+	[0 ... CLK_APMIXED_NR - 1]		= -1,
 	[CLK_APMIXED_ARMPLL]			= 0,
 	[CLK_APMIXED_MAINPLL]			= 1,
 	[CLK_APMIXED_UNIVPLL]			= 2,
@@ -92,6 +93,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 #define CLK_TOP_HDMITX_CLKDIG_CTS		CLK_TOP_NR
 
 static const int top_id_offs_map[CLK_TOP_NR + 1] = {
+	[0 ... CLK_TOP_NR]			= -1,
 	/* Fixed CLK */
 	[CLK_TOP_DPI]				= 0,
 	[CLK_TOP_DMPLL]				= 1,
@@ -808,6 +810,7 @@ static const struct mtk_gate infra_cgs[] = {
 
 /* pericfg */
 static const int peri_id_offs_map[] = {
+	[0 ... CLK_PERI_NR - 1]			= -1,
 	/* MUX CLK */
 	[CLK_PERI_UART0_SEL]			= 1,
 	[CLK_PERI_UART1_SEL]			= 2,

-- 
2.43.0

