Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B99606A881
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xw+Q/pC6;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=llt2AXM6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DDEB6082D;
	Mon, 16 Nov 2026 22:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nh8CzGBUeYo5; Mon, 16 Nov 2026 22:34:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B15E660801
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868448;
	b=efaG/y12rEzc+BsJpj5Xbra2/YV4IalJk5cnBOljrDRmWmgy61W86yoMFzwXxOt2zLF3
	 rjB54w7UZaQJmQ/UEAvGjH0ke6eh0xVasDpmR6H9grgZn9we7MQXcOdL0Zj239Gj/gr/l
	 THsADawJlX0FujB93pJQTle0woVvn2RIHDDDVWx/7PCcHtTocK/G8sPWBK7W2B6EBdhcb
	 4CM3Gh+QZZX731FmlWUU13+T7encZsy3OAx/ZPbDXXObr/i/8mDWm8FCUuZnyV/ikSFR4
	 3nSTQH95z5+jTIyFghZZPGNJKt5q3zwnrI9IYojjegdL1GtU1RZkBIXdnLRF/N/JYWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4ZnwIdNPEjE8h78ch64jWWPyloUxKM3aa1741GcKBLE=;
	b=ZMEVOZoOucH7GIKnC6Czg4In20FDkfhXKbplJp/U2a7ilG2Gz+O/kIUybaJygiu6Qa0A
	 do2fPB7SH95quVuCPJ45M0FiA/XiitYEA+sgekMJ5UFlAiTwGR+iiPhyS6oqhr7DISYGY
	 pg4E9tRoTArBx9bSRHwbDSpJkBea5iEkGbDdS2PnIPCZkygpNo7nHT3hhPe8GbMp5ifGS
	 H9Pbs2ntTNT/FLJ9Z0bBffPX1N3Envp1b01EmfeC6vIdzaynUdGaQegKB3Hb32AwoSlFq
	 UXd4vYGc2VItDqH5YMx1a8Yzro1ejiCye0fzSGodIniMLSNvgiK2ThccXVk1AFqCUxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868448;
	bh=4ZnwIdNPEjE8h78ch64jWWPyloUxKM3aa1741GcKBLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xw+Q/pC62NJGhfhJAXE6IyGfDiPjY5oJZgediyNCDQU006mfA46KL4TwvO/L1Z3Xc
	 w+ROyiG2ZL+Hexef9qfCNdZcYFPoG3Aj5nkX4Rsct85qWbMPsf+ykf2aExrNawoZZc
	 KcbcOmxyFTCjJQ605LtTBFJMCJNT5zRdAwn5NdPsDFoR+oanyFaAQDz3bmySRnMdZM
	 OoCrn8GOIkAL07/kWD1J73hqdE0KM6dBxbhHMqJv94ttmZAGgG+4YXaO8Cm9jpwv5O
	 2xH3VzyKUT96XHeDiQfGPCtXfjrFpg8KSVrBh+U7LiG/VPgnegDEyCvR5nq2JmvJS3
	 Ki01TYevrx8Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B15E660801;
	Mon, 16 Nov 2026 22:34:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0DC3109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1E1180DBA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxsvENo7n-JI for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D109381066
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=llt2AXM6
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D109381066
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:05 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-5058b105df7so1091280b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868444; x=1795473244;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ZnwIdNPEjE8h78ch64jWWPyloUxKM3aa1741GcKBLE=;
 b=llt2AXM6g5uLjs8AEQtTbgzpZ3YTmAnH+KrCtQzv36QEWVL98KpJqt7+a8q6YlfTbu
 Y4aLIFo+a6jovlZ0yBh0BIxNM0cCk5tZJNe1P7oFvYoPNz3xySw70Vwm2+DHsokHbey7
 jioEtlPN/1VNNFvQpud04Jis1AFCl3tBC1G3qOCZX1uDu7B78gDnXrDpGz1mJDHGz9Qt
 LeEvNunDT874wWgudyXPMzlaqt1VN7dCBrWJhw4AG4dUU9ikPq5puDgwADB4Q2fMUX4T
 5diow2sC0+QRjvgaWhmtb6Z3PLgmhY1OLpqkfst2F8lpzvU9d1LhiAwvuKxulumcGaoJ
 b5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868444; x=1795473244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ZnwIdNPEjE8h78ch64jWWPyloUxKM3aa1741GcKBLE=;
 b=HiRVIEGPjH6z+GeuhIqEstJHe0zQm0ihJd+tMCQzZEMn78L+Kwm+zkJkr3gTp8ZExR
 5d/OA5Ivg46yEJ+vc0m7C1lLDrNoH+vjTYovaelph+JVW47Udz14C8GlsfzeMmuSBLXY
 tXjVBcJ8cgtinC6S3Xq1zGrQHjfLsJWE26J7CHLm0neUuGZ8UilLmctD444MJ6KUG+IP
 K+IL14FqWuOgDqTGmKU5wxdri3dpMGr3qF1AZmUSsBUyTYwSXQUy1/DKZEaWpg5g/+pS
 Qe0sqoQrHokJFK4DZ54lGgqFbVLRIpXmKUh6g/o5OTXYE+ZxHDluQMFnCLibwPq7xzDl
 r/JQ==
X-Gm-Message-State: APuU4Z+yS/WvYblO8rT2y91cgmjQyCRMHUt2+B32moPZWu/9pkXB8TmG
 W7VZ6fKNc5zacO+BRlu7qvxzTWQvrNPZUOnw+do9CzzDfdX+VG3YcjxOJEYUuzki1ck=
X-Gm-Gg: AYBFou1nZ4MsGYm5I0xsxlNktC2CMfMm9WhKg4hcVGtvRqgI8vgKQ7bXTOZOBSjCTHm
 HcxWPHpnTVcUlEzICogK2KWb8+B5DPkHgtvbKaymtAfOUtt1Haz6wNzUaIkO5IuEE7TYNKWTep0
 AKFPVCg2cUMri2P3C0nK/G//h2LfhL6owcI0iKF9WvOa0ntx5KMxIZ+0h/aq5fS33vlIVuvE9Bg
 PF81TynOjNt39wT4ja0CR9Y0uwbnQDWtV8Yi2UV4cKmZfo/FsFDSUOaceq1voRCJWaEfTQ7lRry
 0uTCR+2vGqu9fbQdhWL32iHqh9Mgyra+uM+M5YIgEZQi6dK9T1PnVtQSDftW/Kxcnxi2eBoL6jh
 O7G2hUslqwISYr6qBhn5TogryJ72GZFAudf9Yl0froeogTCpxFTfLQsnD2qjGnMHLmJCypOwAQW
 aoBEmIf3ruiMYOw+arH7ht3rRtbuiyLQAuP9ylmfbK+J+5o5BFGcQN+H0/hTjByHtAQK4thBiII
 qkeWWV9nyqw8qSgZMm38XqBqj7SabCdn4x3+Q76iHH5nMFEputmaydvCjmCkJ37rd+yykX5Edca
 eJ2ep9gSKO3qneAJOEV3K0k391vYwdXdSQ==
X-Received: by 2002:a05:6808:2384:b0:53c:af69:84e2 with SMTP id
 5614622812f47-575c9654e0emr1283942b6e.6.1794868444356; 
 Mon, 16 Nov 2026 14:34:04 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:34:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:45 -0600
Subject: [PATCH v3 4/8] arm: mediatek: require the DRAM description from
 the earlier boot stage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-4-ca423d2d8038@baylibre.com>
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3537; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=b7p7jDD163lDndVacpRRvSav6UcIOB4nGWQUl5yIVKI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4SqEMH+5NH7cdXVnNRztCawoervhUV5IBVOx
 pysrd/DloKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuEqhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AeDwH/Ay4Fx7VrBsarZidHjPOi/kJwkroAuEqQLrjIcV
 4Lw2In0NrzOFVsEHn9mtRm2BwjA5R7VcjMmbezMaAjNEV27mRTx1xIOLBEh3wXpbuVcqVq++G4g
 7zcEE0elcULK1o+hW5n4k8N73I091czBpj7R6cxd2fl2pr5hsBzuaOxKA6TRwKEcmm1L6dEzLlc
 TR/t929yZEWqy8u3xM4o5zUERiH8f0t76e9itEiCMGWl1eU1IGtBuGGDxFMrgHNK4HtUsHVVsPQ
 JZcODGZTUzyKVwNXj8Bu7WtM6jVOd7An+DUqSZpbK3uMav2Oxc07FcX76GhvCuQQ0mJ0qt2GpOa
 GYts=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add MTK_DRAM_DESC_HANDOFF to stop in SPL if the boot stage that
initializes the DRAM did not pass a transfer list with a devicetree
overlay, and enable it on MT8189.

The overlay describes the DRAM size and the memory reserved for the DRAM
controller, which depend on the DRAM fitted to the board. The devicetree
built into U-Boot cannot describe them, so booting without the overlay
would give the OS a wrong memory size and let it use reserved memory.

The option is not specific to MT8189. The DRAM initialization on MT8366
has the same code to reserve memory for the DRAM controller, so the
Genio 360 can use it as well once support for that is added later.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig | 13 +++++++++++++
 arch/arm/mach-mediatek/spl.c   | 26 ++++++++++++++++++++++++++
 configs/mt8189.config          |  1 +
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 01db231a4f9..0e5ffb2e68f 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -343,6 +343,19 @@ config MTK_GENIO_DA_FIT_MAX_SIZE
 
 endif
 
+config MTK_DRAM_DESC_HANDOFF
+	bool "Require the DRAM description in a transfer list"
+	depends on BLOBLIST
+	depends on SPL_BLOBLIST || !SPL
+	help
+	  The DRAM size and the memory reserved for the DRAM controller depend
+	  on the DRAM fitted to the board, so the devicetree built into U-Boot
+	  cannot describe them. The boot stage that initializes the DRAM
+	  describes them instead, with a devicetree overlay in a Firmware
+	  Handoff transfer list.
+
+	  Make SPL stop if it does not receive such an overlay.
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 95e2157b507..f6012d4ec22 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -4,16 +4,39 @@
  * Author: Ryder Lee <ryder.lee@mediatek.com>
  */
 
+#include <bloblist.h>
 #include <clk.h>
+#include <errno.h>
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
+#include <stdio.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 __weak int mtk_soc_early_init(void)
 {
 	return 0;
 }
 
+/*
+ * The boot stage that initializes the DRAM describes the DRAM size and the
+ * memory reserved for the DRAM controller with a devicetree overlay in a
+ * transfer list. The devicetree cannot describe them, so do not boot without
+ * the overlay.
+ */
+static int mtk_dram_desc_check(void)
+{
+	if (!(gd->flags & GD_FLG_BLOBLIST_HANDOFF) ||
+	    !bloblist_find(BLOBLISTT_FDT_OVERLAY, 0)) {
+		printf("No DRAM description from the previous boot stage\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -29,6 +52,9 @@ void board_init_f(ulong dummy)
 	ret = mtk_soc_early_init();
 	if (ret)
 		hang();
+
+	if (IS_ENABLED(CONFIG_MTK_DRAM_DESC_HANDOFF) && mtk_dram_desc_check())
+		hang();
 }
 
 u32 spl_boot_device(void)
diff --git a/configs/mt8189.config b/configs/mt8189.config
index efa95a2fe03..356673af059 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -8,6 +8,7 @@ CONFIG_DM_GPIO=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8189=y
 CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000
+CONFIG_MTK_DRAM_DESC_HANDOFF=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y

-- 
2.53.0

