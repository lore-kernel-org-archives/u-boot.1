Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849C2E81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A5983C5E;
	Mon,  9 Feb 2026 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cv9pePyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DEF83C5E; Mon,  9 Feb 2026 17:40:28 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9685839A5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d148dd3421so1182740a34.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655225; x=1771260025;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IcqXFxa7UNGxVkb4LjSpb7nbh5Jt1d32fGvi1mcBbqE=;
 b=Cv9pePyqFdc4x96DqtZP/mnALuED63EyrXFcxx4FwYBmk8HTGRuKQ/gotbYYNhSy6R
 Ul6NXbK61YHNW44xiquMpZmKQkY7xZHqcTjIiMv5Dv9WSwZmkPbtnD89mSFEj32ZKnNM
 nGpcfgxCzGvTmldm60Kb/QbRgGmMvbpPBERISpQoT8SNgGbB8Jf7R8r/nFpiu7UUpujw
 +2C5rHQxDaULTIBZJemqp0LL/X6Oh3MzqnijmaycTK8jRpBNrJ1CIWezKuoqtueKpdeM
 20Rq5vq6RKsHGrK3lP7MgDjGq1U6ZPdr3cTXAYlPNUpYQ0TIac+hFES4Wq7B1Ro0c1dQ
 DKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655225; x=1771260025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IcqXFxa7UNGxVkb4LjSpb7nbh5Jt1d32fGvi1mcBbqE=;
 b=XdWxlfQQB1CRktsxFNMwBvV1EiCsMEYf49gGILYRoyAG5JlTihFxP4987t1wL7UcXB
 CVQpPaxYfdBkTe7dxxmPPpiHzj/5wMESAml0Wf4XfLkDzB42cLE8MENIEE0OhNSqdtbN
 ikKPaK3AMi64sbV/uSlekc/ivCEy0uU5MNBAl7LXMxIP4VXm4ISe+vD+6fxGXUv3tG8W
 QqXU8QjfubczTSkBmdglO5/XjXfFWBIyUjZzb1YDAnmLlkBHSWlHS0luhz3OHLcIMFpZ
 U/NADDURimUV4hMwVykWAeNZAQsi4iVX/fUXrYvAdGI0e+Lg2oQaVnzoSINf7eXD0llx
 E1Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWEKJj38Nhuu26jq2A28JxbDe3tHWC+n3zc0RwikErMSs/UPkEZNWLaKzsMXM37bahmXmkpug=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9I826tdfkFu29mvCF+sINrVOLjz8R0buhsSWGBIrG8+++RKIh
 d+7Tlu46/1KXgBC+NKB/RN/2YaP1K6pemLp6z8LVMpYTw1o1ObXcoN9Em/hFsNvSyVg=
X-Gm-Gg: AZuq6aJLeTckn+OVSIhQnyW4B/H5Ib9jbHxCDlqnf363X+o2++Ulh1q9PAoC8DxFtTd
 xMH2yCCQqeJ7opN4mqmpD0jCEcANMJpp0vcsFcUX2+vGqFeAfse8faLUsTuRUs3fhrA5NVVSOfP
 72o2jEAWB3202TplUpdyQmY0iEije/lL2PGr+Nz/jgIL+3TNIc2pNOoUj9IVw3pSXUJA9OVxHms
 4IMOT+w91gMNp78b84dZlcKf+wS5xpXPyFvbS2/kWm1zNt3M1hZcsfuu7k555QOiYgwNDtExXDS
 kLlMIb56BZINmUBAUrYUFCxOHGjdjDgGqRndNyanoZxFGm3GQguTJMbGyqJn7Xb2JOeGpdd4ayJ
 Rc79/goN8ZoGPPEO4Sdge1X18sKR7wG6GIgzjzMS+zP/VmKRKhLTXr+hLqfYnJzAUHPuJdSlNzY
 15eeX2688LhZkyZc8=
X-Received: by 2002:a05:6830:440d:b0:7cf:dbb4:320e with SMTP id
 46e09a7af769-7d46447f6a1mr7722235a34.18.1770655224624; 
 Mon, 09 Feb 2026 08:40:24 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 10:39:27 -0600
Subject: [PATCH v2 2/7] board: mediatek: mt8390_evk: remove empty board_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-2-e3b22282c74d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=f9ky2WuqbmXYjRAvzIVgmtJ/BHoA9ZpleuDqy5iFJx0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3Prn6sw62TGiQA/Iwe+6haxXIgMIAFYqoCl
 n13N1zOM/mJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoNzxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AG7oH/ithw+lOX/sFpYBGlP51wXhUnS+YUFBdkdUtg0A
 AZRGSym6hgjYzOhh1TAYLd/VjB/CDPUfFkTCoILBhMKBY3l0yc+iCWQNacny2wrrz48m3/rLZCd
 brvoM1QUIb1kDCU0aK4ybZVl39XlDcI6KzKVoAoM3+CCG35BKS43EqREe3fDzbmn89rFhKcdsOs
 /txK6kQVKNiX4Ulvfd/pDFaioTASaKN2VeSRSBP4ekXcQzWxjUNy1DZpssnvzSFe+fn2CScifqd
 XeH+ezfnxeMKUUJKIXp976ENvcVDgSjQeix1Gc1AzHmJTTrmyvV04zLH45OH1j5+LitaCskskfq
 lF0M=
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

Remove empty board_init() function and adjust defconfig to not require
it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/mt8390_evk/mt8390_evk.c | 5 -----
 configs/mt8390_evk_defconfig           | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/board/mediatek/mt8390_evk/mt8390_evk.c b/board/mediatek/mt8390_evk/mt8390_evk.c
index 1ca40366a55..5731199bf83 100644
--- a/board/mediatek/mt8390_evk/mt8390_evk.c
+++ b/board/mediatek/mt8390_evk/mt8390_evk.c
@@ -7,11 +7,6 @@
 #include <linux/types.h>
 #include <asm/armv8/mmu.h>
 
-int board_init(void)
-{
-	return 0;
-}
-
 static struct mm_region mt8390_evk_mem_map[] = {
 	{
 		/* DDR */
diff --git a/configs/mt8390_evk_defconfig b/configs/mt8390_evk_defconfig
index 9bc1d922587..06437be625e 100644
--- a/configs/mt8390_evk_defconfig
+++ b/configs/mt8390_evk_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
 CONFIG_TARGET_MT8188=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_IDENT_STRING="mt8390-evk"
+# CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y

-- 
2.43.0

