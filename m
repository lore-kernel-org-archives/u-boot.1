Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB4606A332
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WA0PZ0N5;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=G7FZP6JO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11B78818D7;
	Fri, 20 Nov 2026 22:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9MYgISxz3LeS; Fri, 20 Nov 2026 22:05:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 782A181970
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212342;
	b=ADPVI/0LiQCsYhSSt+KZxHB6W2VJFeujXZUGKReZAwDTnv+3z3YQ9AU6ZzMStwcuOrHL
	 owNL53J8mB8Y24RJzhdzSGTUU29aTh56nPSaPftopzFY9GlyviY+0YmgMsHFj1286owuX
	 T2oC0ChnG7RodkMhsMRNy+Mt7w9lWRvMDOEcgAuWKfbP/gyvq0Zx6y4f/BM9t7Cb1hcnE
	 sXbGnuuTCcZhyyEZ4URR6I5ljzoPquPw58JlBQww26JrGLPhoWtiMHNVMqahqapoqzbxb
	 NbUzLTetGOAE2696svWbSWwQivGveDp/xrC6ZOLogW9XpT4UCjVk1an5xSwGhbmIzYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PQ7fPT9m6gBkNBIEE3xmH9ZTKVC0/ncSehwPpR/fHAo=;
	b=Vp3+PO8jUdaU6W7hsB2uoP6QoVRTyYYSV4NkkfmBgpungWgwKsnFg2n0wRyPVoEFkoSN
	 7ecB08933S3/bZjOX/Mum3GhIiy82yGqw/5/y88Ccw5pdBbIQZz0UqpmLsuhuH8aWSQCW
	 iLRd58/WRzgNSO6O0MPtb83fNk1isgemjFwFRwjnSMEaq7tCxxbfK80rsrnaqNY9sFoDz
	 1rIYipEGraVXraXP8km9CeMOToceORJbohGFiKdNt4ezqGJS/sJI5F1bFFp83OZw5SNw9
	 CyjbJnOKwNS0p7ndZodJqjBKYVEe6z843e1eNvwP4ime85VhjdCHejKxnwvBTheHCRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212341;
	bh=PQ7fPT9m6gBkNBIEE3xmH9ZTKVC0/ncSehwPpR/fHAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WA0PZ0N5xr3XOEXkbyxkFIQxMHUMs0Qqo0MrlSnQQJpZG+HFpeCsRUsrzIRRKfRCX
	 8koWfjL/tNmfWqhaiOkjFCnj/7uYPDC8wx9emod1c0oNmDaUePi9Qrz9mNL3Z1d8oR
	 K4V16ZCOzcn6VwAqgxYnwdY6ajm7HVpM8c7jmuE/zR02q5+L0zpkcWKLfpQIEF5InC
	 lkxoj7nvVA6bZGpC6IdsUL33OssTkeX0mM3sZWJho9ryzVxImsPZLnLmIVS+/nHIB6
	 Xj74mvJ/UDn4clTLtysbzrwkSZwEhpz38AWs4VY0Hhx0pxqcVAhFAwWq1xMQMt2bZq
	 n/SxEyma8MDNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 782A181970;
	Fri, 20 Nov 2026 22:05:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B68029C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8E96605F7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zaaSQ_Nm17Zy for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A93946063A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=G7FZP6JO
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A93946063A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:30 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-703be215729so651145eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212329; x=1795817129;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PQ7fPT9m6gBkNBIEE3xmH9ZTKVC0/ncSehwPpR/fHAo=;
 b=G7FZP6JOe4Pf84KI1EvHH93krBqDlR4e7o7SQ3E2QZOxxbcRsC+XXlU49E+SLCOTpD
 rEBf/YtF7DpPCcCWpYzkUenXbkd/8KLZ4LDhtpHSAfgvQne62nzKuAeKdn2JRM0rtybq
 ymQZ2i7c+zTvOAHXMxT2NuADHbm/Vbh7RgLuo3i8fmVWrjcpw0O6u+tnlZU2T1vtAhbQ
 jXnbfDgWm8p/Qt766li7KxkREjmzC2mVoLZrmP1Qk/chArmgEWBTY2Gv85BbkENkXwrl
 kulLvZ//avPByYzM3X8JDyshIQwEhwlNNcbXcc4ZRxH5//9M1gF0yiLDDdFKdDeTLp++
 jCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212329; x=1795817129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PQ7fPT9m6gBkNBIEE3xmH9ZTKVC0/ncSehwPpR/fHAo=;
 b=x4xWkYhmYFbcJsfEE1gDDqhzSNR7YpfcC7DWBL1W3nX+GisyhGl6A36mqaOuAS142P
 5zAAkKKiguYCCcoAUf2SRz+9jmBDZvFS94kr/TNumUGX/cPlpAx+PcqNgk2acIfw/qSL
 9yRbajDcSQY1i+AhCbTHP4RrY7TxONHCUG2g57ILYK/2VzDDP16T//JZpopaWZhMrcOo
 tmNIxp9V5ao3ZFimdcz0Y792B6b1E/NY9KI8tvULueDvgfkqAOBkEPXuor/YTmiCZ7IT
 Q8Q7bs/Hp9it7EFkCKDmS7QmjXXa/9Zk3FFmB2JY58aqxpSySLsswMMFyKA6cd+8c/Xo
 zTLw==
X-Gm-Message-State: APuU4Z+U1eG+krlYexjLxY9JmIpNxnYD9Rq5s08jomyI21ie7tdeJX4A
 3Q0YcxIDHEbV10Byw0GP3Z7PPxzR4AbZXK49TxzLuAuK9NvBFLDocTLwOsDADmHZrXU=
X-Gm-Gg: AYBFou0KIGFPO0UsAQeoKhN4lQjhmT5s3lPeB2tStyRyLf736ZbiEwDp2lwcX2CqMnR
 NSLCtkyNvCgC1wpTp/zyYKiODCxvClPxga7+6RL0AC+m+RUET30CBvxVTnBBYPXEjaRgZT0tTgF
 pihjWsZ1o7q8Mt1quyDYY68CPdbcitZRI9EMbXNP0kWywb3V5Wxpgofqe+QwfC9W19Pjq59Cv/z
 CLuKaP5y0s5JnRUjdSG+eWtYV44pUTSU1deN5Mx9mN1wDsOFGj51ZdIibUqc/QGEe9/Xig8JXVV
 l7VqPlXzBCmuVTUz0X8Vw/aSs6Y73CQGA+AgOx+WBGSizgtpzAafWRNT42kGPpXpv/Xgib4dkqj
 Oupw2b6knYmnV0n7quSWBVzQziYeCS2l4X+kLMxxaLC3nKLzDv1w5z3fijsEpa0V/V+gvB1Vibb
 BCTkvmHehXOLAmXG2MIuPjYqmUt6JAQ9FKNnUGtojqci694iZGF1wb1FikJJHl9hRPxGmo5+B7m
 qBUCVEqWTV0VPryFB9HkKEx3J/05khBPITkgebNaTB49fcIcC8u42DVCyPV2pOpfaSHIJDgte6O
 DKGjJZITV1Uk/HW/vBXZ9q/7gBu7X2or
X-Received: by 2002:a05:6820:168c:b0:71b:3f6d:610e with SMTP id
 006d021491bc7-71b3f6d6907mr1990365eaf.33.1795212329088; 
 Fri, 20 Nov 2026 14:05:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:49 -0600
Subject: [PATCH v2 08/10] arm: mediatek: describe the Genio images in a
 separate binman devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-8-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9970; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fMHxjX10h/TJk0kAFSFTLczgEaeX7BoY3vafGbbyFkA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMP+l5fSWe4TKo5F+9WndXmZeodNEbDRlNF0B
 aHG2I/lyO+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDD/hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7LIH/2lBPOMcD8Pg3QtToC1jqyvQ2q3OoW7tIwB8uj5
 pI/jXyDgbX12f9HoJ5NKMuhy3KniIgUvQh4QNBgzx21Zb6xOZ+ZZNd49R6XZ1qlK3rRi2REv+N4
 PC0Jpxmdsx8BURSKHWzMPoBi1UR8QFjyjTe0nOuDWsP+hKAOFEAwDWwdEQ3XKGRWs9TSs4FRV6k
 cE7Ilud4o0PKNaF/UxMHwAv/4RAP52eXALsZz+5liL8UXsdaAWZ0RlSq6MpKS4fpSSBqQOoJU/p
 rKo2Kzb74fuH0WyxAC2xKGfzmSI5/cdiYs/YHM9HmZTxncR4l/KlXdKWBlv8rD0Pgm41tnCcQSw
 SvK0=
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

Move the description of the Genio firmware images out of the U-Boot
control devicetree into one binman devicetree per SoC, and select it
with BINMAN_DTB. The binman node does not describe hardware and does not
pass the devicetree schema checks. Nothing in U-Boot reads it at runtime
either. The board -u-boot.dtsi files keep only what U-Boot itself
needs, such as the download agent's USB setup.

The FIT and download agent descriptions now name both boards of a SoC,
e.g. "Genio 510/700" in place of "Genio 510".

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8188-genio-binman.dts           | 15 +++++++++++++++
 arch/arm/dts/mt8189-genio-binman.dts           | 13 +++++++++++++
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi  | 10 ----------
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi       |  6 ------
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi  |  9 ---------
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi  | 10 ----------
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi  |  9 ---------
 arch/arm/dts/mtk-genio-binman.dtsi             | 14 ++++++++++++++
 arch/arm/dts/mtk-genio-bootloaders-binman.dtsi |  2 ++
 arch/arm/dts/mtk-genio-da-fit-binman.dtsi      |  2 ++
 arch/arm/dts/mtk-genio-loader-spl-binman.dtsi  |  2 ++
 arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi    |  1 +
 arch/arm/mach-mediatek/Kconfig                 |  5 +++++
 board/mediatek/MAINTAINERS                     |  1 +
 14 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/arch/arm/dts/mt8188-genio-binman.dts b/arch/arm/dts/mt8188-genio-binman.dts
new file mode 100644
index 00000000000..677c1de9278
--- /dev/null
+++ b/arch/arm/dts/mt8188-genio-binman.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Binman image description for the MediaTek Genio 510 and 700 EVKs
+ *
+ * Copyright (c) 2026 BayLibre SAS
+ */
+
+/dts-v1/;
+
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510/700 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510/700 boot chain"
+#define MTK_DA_DESCRIPTION "MediaTek Genio 510/700 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 510/700 DA bootloaders"
+
+#include "mtk-genio-binman.dtsi"
diff --git a/arch/arm/dts/mt8189-genio-binman.dts b/arch/arm/dts/mt8189-genio-binman.dts
new file mode 100644
index 00000000000..4f471dab7f6
--- /dev/null
+++ b/arch/arm/dts/mt8189-genio-binman.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Binman image description for the MediaTek Genio 520 and 720 EVKs
+ *
+ * Copyright (c) 2026 BayLibre SAS
+ */
+
+/dts-v1/;
+
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 520/720 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 520/720 boot chain"
+
+#include "mtk-genio-binman.dtsi"
diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 2cc5e14a37a..88e1e8abd47 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -7,16 +7,6 @@
 #include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
 
-#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
-#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
-#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
-#include "mtk-genio-binman.dtsi"
-#include "mtk-genio-mtk-boot-binman.dtsi"
-#include "mtk-genio-bootloaders-binman.dtsi"
-#endif
-
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
-#define MTK_DA_DESCRIPTION "MediaTek Genio 510 download agent"
-#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 510 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index ddfa95f4578..410ae24ff58 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -10,12 +10,6 @@
  * controllers disabled, independently of the normal boot USB setup.
  */
 
-#include "mtk-genio-binman.dtsi"
-#include "mtk-genio-da-binman.dtsi"
-#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
-#include "mtk-genio-da-fit-binman.dtsi"
-#endif
-
 &ssusb0 {
 	status = "okay";
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
index 4bd3a87392c..a69e2db5a04 100644
--- a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
@@ -1,12 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 
-#include <config.h>
 #include "mt8371-genio-common-u-boot.dtsi"
-
-#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
-#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 520 bootloaders"
-#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 520 boot chain"
-#include "mtk-genio-binman.dtsi"
-#include "mtk-genio-mtk-boot-binman.dtsi"
-#include "mtk-genio-bootloaders-binman.dtsi"
-#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 9a742483cf5..88e1e8abd47 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -7,16 +7,6 @@
 #include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
 
-#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
-#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
-#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
-#include "mtk-genio-binman.dtsi"
-#include "mtk-genio-mtk-boot-binman.dtsi"
-#include "mtk-genio-bootloaders-binman.dtsi"
-#endif
-
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
-#define MTK_DA_DESCRIPTION "MediaTek Genio 700 download agent"
-#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 700 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
index 1b659a9fa9a..a69e2db5a04 100644
--- a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
@@ -1,12 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 
-#include <config.h>
 #include "mt8371-genio-common-u-boot.dtsi"
-
-#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
-#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 720 bootloaders"
-#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 720 boot chain"
-#include "mtk-genio-binman.dtsi"
-#include "mtk-genio-mtk-boot-binman.dtsi"
-#include "mtk-genio-bootloaders-binman.dtsi"
-#endif
diff --git a/arch/arm/dts/mtk-genio-binman.dtsi b/arch/arm/dts/mtk-genio-binman.dtsi
index ff4557e5072..6e49f758fd2 100644
--- a/arch/arm/dts/mtk-genio-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-binman.dtsi
@@ -5,8 +5,22 @@
  * Author: Carlo Caione <ccaione@baylibre.com>
  */
 
+#include <config.h>
+
 / {
 	binman: binman {
 		multiple-images;
 	};
 };
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
+#endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mtk-genio-da-binman.dtsi"
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+#include "mtk-genio-da-fit-binman.dtsi"
+#endif
+#endif
diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
index cbf35b7a353..08ce5af00e7 100644
--- a/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
@@ -5,6 +5,8 @@
  * Author: Carlo Caione <ccaione@baylibre.com>
  */
 
+#include <config.h>
+
 &binman {
 	bootloaders {
 		filename = "bootloaders.img";
diff --git a/arch/arm/dts/mtk-genio-da-fit-binman.dtsi b/arch/arm/dts/mtk-genio-da-fit-binman.dtsi
index a605ad2504a..e13993eccf1 100644
--- a/arch/arm/dts/mtk-genio-da-fit-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-da-fit-binman.dtsi
@@ -4,6 +4,8 @@
  * Author: Carlo Caione <ccaione@baylibre.com>
  */
 
+#include <config.h>
+
 &da {
 	fit {
 		description = MTK_DA_FIT_DESCRIPTION;
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
index 8c676a6e05e..8f1e8e1c692 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
@@ -5,6 +5,8 @@
  * Author: Carlo Caione <ccaione@baylibre.com>
  */
 
+#include <config.h>
+
 /* Include within a section: the loader and SPL form one contiguous payload. */
 ddr-loader {
 	type = "blob-ext";
diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
index 778b3646465..653130b0365 100644
--- a/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
@@ -5,6 +5,7 @@
  * Author: Carlo Caione <ccaione@baylibre.com>
  */
 
+#include <config.h>
 #include <linux/stringify.h>
 
 &binman {
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 7171cd7a984..4732e5b21c6 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -252,6 +252,11 @@ config MTK_GENIO_BOOT_IMAGES
 	  Enable binman to assemble the MediaTek BootROM image and firmware
 	  FIT from U-Boot and external platform firmware components.
 
+config BINMAN_DTB
+	depends on BINMAN
+	default "./arch/arm/dts/mt8188-genio-binman.dtb" if TARGET_MT8188
+	default "./arch/arm/dts/mt8189-genio-binman.dtb" if TARGET_MT8189
+
 config MTK_GENIO_IMAGE_CONTRACT
 	bool
 
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index cf1e5753be5..9b600d5d94c 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -30,6 +30,7 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
+F:	arch/arm/dts/mt8188-genio-binman.dts
 F:	arch/arm/dts/mt8370*
 F:	arch/arm/dts/mt8390*
 F:	arch/arm/dts/mtk-genio*

-- 
2.53.0

