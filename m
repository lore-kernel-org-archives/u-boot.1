Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79532606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gF2V7yzr;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=X/2VHb3z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 589EA608B5;
	Thu,  5 Nov 2026 23:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XVWqR_UvxEH; Thu,  5 Nov 2026 23:46:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D4546085F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922400;
	b=DfW0Cho6k4qI+Uj+ycVj7MKSojnKctafU0tIdB1IQia8vd1RV5QPcgWfYlJfHv0FC5xI
	 WzHXbBUkBcaqKYnfJaXpKaRySHeMk4hkq7BHr8wv3o0ISqMuI+XUPzYTYHspWq+vIViwU
	 v4U5qcuoTSvX+mmPKQ8igkrRPtNamYWJepFlawH1pJp+Q1KXoCa/DXqAMFHYYpGljZJOr
	 BFiw1UnaaZrpfYRAr7rAjHk5OBqqGC/RaakpwnwqfJCRGSTm/0ym8yXnE6QyuYfEmK1a3
	 DPHA2mnCN671mnNkSvzW/P4Y+puDimSv8eqXv5F9B1NGc4Dq/OyapsBYfYV7FvdwyHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EAGLxTGVlvPveAnnAPYvcjmuhUvUdx/n0sBHEtQZ7h0=;
	b=mCdmv29WYvWukQbbC4TtWsLcn0kPm+Ot0m2GWCPWu45hU/rEezYrZhZPYz6JdThY/ta/
	 L+yoKOuOmirAMSPYJ93g9V+QTElhJ/FNihTNNoxz7n2lRjhM+eE5BZa/B04qVYNtK5mhE
	 5bZcEMnc+WwsbDuPmCiVx6Ckj6XQCqyz1ynMAaPatUZpHzdXJWMdnfJb1WF5LdlR6zY2j
	 pCt+Wi21A3ottw+dCxExF4gmGVi7zI1vhfusUURPezslZ41otWEJTRMEmV8MrMRZs7mGo
	 Dv4OcEVTDPDvOAsyXheUKGuLyde2tLnqqkBO+zenjJEbDXnC6of4KSda3f1VhrfVv4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922400;
	bh=EAGLxTGVlvPveAnnAPYvcjmuhUvUdx/n0sBHEtQZ7h0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gF2V7yzrCKa8qZpEaF56EifCrTLblTa3kQytuPv0FL++HIN2UrZKVimMkgSqI+h6H
	 Op6vmxkQtyajApR9PmGVzd+BxJrBvDe1wDKUxYzBqT5pi2Y5P57WnbQyW7BOof5swG
	 OKbPFhyRWHlxZ03+TcC14H1mG7Q0Bm3IpM8syc93z7sxbHEP9nYLKF6KoBnNATDanI
	 RDm/zWPx9/kh5hgiWnp1MRgb/xnNfyvYSM6rLjwe3vuUR40Ypu4+Hfl3+B3pjfxBar
	 6tQ10MW8vbY4PqjAeWSxGbIVP6dHMBCACAZY0TousK5isNGEHF1b+ZIFvUkEnS4DTq
	 stWwqCWRmsDbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D4546085F;
	Thu,  5 Nov 2026 23:46:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 70E2D211
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A4FE811D8
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMk7KRo6bqzj for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E420C811DD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=X/2VHb3z
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E420C811DD
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-854b6e2e41fso80518a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922392; x=1794527192;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAGLxTGVlvPveAnnAPYvcjmuhUvUdx/n0sBHEtQZ7h0=;
 b=X/2VHb3zTIs1ETJcFVQ4jcmwOQgGlNay9G1eT/SSR63bQVRg4yThNpBQHoZuyYfj28
 07DlYHGzJKxkL4ZprOZhKsJRbuUpXmHNKQTvbGE9nR/RGFepw0UxYkZoZXSwBp2DqpFy
 TE3aDh6AeSmnnNfO3iXBeDCcE8GFron5/o7jSuUMK989TGbIR+icRx7crzY5F0Lczexr
 i1Rsi7LrakWeTDZXsEmsoUqgBDOK3BFw4zLZ6crYm690lHNpW/2Kn3nWNxWx0vev9Ymc
 +zXa/CtTW60+FoG4KV9fxKCtoI6glXekMtCEmx7gL4xsyxrBG5N0BA3VyinQrz/sxNt1
 tkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922392; x=1794527192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAGLxTGVlvPveAnnAPYvcjmuhUvUdx/n0sBHEtQZ7h0=;
 b=gLLeICEV/JFOXkAGtwEFfh9PZaZUZNEDncw07XLGVjLLF2NvL68eqlyJTneyB4z0x9
 a2EUujO8Hj4B/gTs+Frz+AmIoJLvsPoE1W/N4t2NNuJgCVg+aP47c6XFyj5kdd1Rpx1J
 o56A77fIVGkj0InJxDRaX2zIXpk8j7jM4FTHQwbEg7upgvFGzu4Y3yxfs0l2paU0aoXe
 T1/df3SK2UEjA5Y2xwRlsjVL5e1D75N9kQXHK2zK1On/Xz7WtLtNeLeqNhznz6F4FysW
 afV7LM2P5VzZyw5J8HkMhF4OrW30er08PP4RTA/fya6cwfAaTKMpoVfRJkjSmFfNGVgi
 /x6Q==
X-Gm-Message-State: APuU4Z80072oRqUOh6Vfpmg8uH+IbKNcpOahCVMcS8oj8WBOf4z3d3jL
 DlUqg1XNEvaTLGv/RvAD3xRRWz9zOKgRzjhVMAAKCQiIFt1Tf1T7qf3bdtRarEDhnMc=
X-Gm-Gg: AYBFou0VvEo7tL5FdF4UcjPqO/D/nKo/jX997RWAHMaVKoa9OeYdZn5mqmqlqsSJW4U
 Dmv6yof2huKlM1YscH02NdAdbNbYC9+5ygzMBo14U4Ig+tPlUMuOS0hWpFIs7mkWJ8gZeRcIqXi
 gMjpEnLrrY+WrgrwBZ6/F3dwy7wLnchUCA9OWr+T+o10jAD9Wdw30KfwkQ5K8TuMVlb/vCo8gcJ
 qOwER7eHcjoz2oUL9YDFEONq//A+j3uNCaA/2JrAWx0PlMwTbiU8mCVEa8mCP3h/CX3z58JnhOr
 qTxHl6jW0P/fdMzWECloVqMIjg6nMw6NGHs6GJrSz2nK6/Dn8fNFhgBd5pKmlKgZ8rT88YEeN+f
 YPQY95PeDkOlwuzuqFsiCfU3bnGrOoX1Dir6O+fX8S8sTEp+6ZDfBe4H3VNoyRiuQsrYzABnOhL
 4aQCxFq8BM+bC48gderO5qADS3HoI2iY80Wq63CpJWjFjl8wuvGHB4C1OlvK0An5ksqqCh9Q/sS
 R2p9Y1/IiYoqRBluflUHm5N/3EQt7jupTNYwk4qdTO/3m72K2awWDEXb41udz+zlY3AkAklszNX
 F1M5gQTo1hm6ifKaoj768V580tjlWchpmA==
X-Received: by 2002:a05:6830:3499:b0:7e6:d0ad:5254 with SMTP id
 46e09a7af769-85f1cf837a9mr802159a34.8.1793922392493; 
 Thu, 05 Nov 2026 15:46:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:26 -0600
Subject: [PATCH v2 4/8] arm: mediatek: require the DRAM description from
 the earlier boot stage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-4-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3618; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3yaSV7XSGeYQMc8HX5XwkMee6L0UGs2Y3rHIukoVePg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RUxCW9MGTKEPFyG5rCRbfa1vwTmROzbKtKQG
 bEB62qUCnGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VMRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AoRsH/2wZiO1jHQwFnEiRCfRUBWoC/1YMRvxm7V89w+Z
 etCR3LYLg4Edsuf9ZUOnxT3FBGIqLsPx07Y6kbmNcZpPxwGgeVxEXE9fZwr4CtypACDtvohPBxD
 xJshtPuQIOWLFr1ZjZ19k+D8twfd6XEQZGwju/ccOPE0gQIWnFQc9F298O3825Mt4C72tJfG96K
 JYkO7BFLmKibLuEHmKoHknpXe3LXtAWHP7DZx7aqdfsY+PlORzA/Q4KDpHeyBNTRwjMHMaIBJay
 bE6c1VF8zvOFiOfXbh/2DdCl9RQakTXRQEl0XyXmq/UE02moCywr4cBopWnr+OM93MRP9/fq7DS
 1iVw=
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
 arch/arm/mach-mediatek/spl.c   | 31 +++++++++++++++++++++++++++++++
 configs/mt8189.config          |  1 +
 3 files changed, 45 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 1fde892baa2..42868c9113d 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -278,6 +278,19 @@ config MTK_GENIO_BL31_LOAD_ADDR
 
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
index 125ebcd784f..9150f677b04 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -4,16 +4,43 @@
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
+	if (!IS_ENABLED(CONFIG_MTK_DRAM_DESC_HANDOFF) ||
+	    !CONFIG_IS_ENABLED(BLOBLIST))
+		return 0;
+
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
@@ -29,6 +56,10 @@ void board_init_f(ulong dummy)
 	ret = mtk_soc_early_init();
 	if (ret)
 		hang();
+
+	ret = mtk_dram_desc_check();
+	if (ret)
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

