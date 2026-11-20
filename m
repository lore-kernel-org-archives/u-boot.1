Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F68606A33D
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tzc6Kkep;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gmKWYl45
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72B74817A1;
	Fri, 20 Nov 2026 22:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvxXHoe5a0Jq; Fri, 20 Nov 2026 22:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38BA0818C0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212334;
	b=ZgThjrDltIT28kWjL926RMcywNuBI5lFLEL86/RmhyHetu6cUTvO5GBoyBNsLayYDrfv
	 M0+VDqU6u3J7CMh0sZSGEtWbiORd8vzPn/J3y+35O252AG2N4/RwDD9O9Gv0T1iqxn4Ad
	 dTII3de7OZz52l96q4Z/8Y7oSuqlcg/IftZO6Tmebv//WTwaD9pYIh14yY3VAWo/+PQkc
	 EW68w1QVfIfDphs8/sQ/EnExbjzTXmqJNQc9VyXTZGYPPyxj/Y/9jU2WkZokiMZr6Sdtk
	 P1PBRi3tIvfjitKQN4QMLrUX4o7DZlE+74ym+G4FgI22vX0BlKVg8Vz2dIS8mwETwtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212334;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lvPWIE6cXtC20g32giKuiPe71xxNimfKb9QHokGjMcM=;
	b=ChPlJRwLUBsELVNy1CNNhTtTDYLQeREINz2R5EEVhlj4HDAYru2GkAQMgP4IWf1oNIVm
	 GTI0tk5R/5FhHpvzB7f5cw7Z9IN6mGARCm7TfcPGrnIk9f8+POYC+FeM89eSJFtKK2v29
	 5VUic3EGM7L/ICT+aVRR69Q5IQj0P/aUZD/AvxdNCnF+ymXi00seEklm4yA861lh39mUI
	 SQkkgbHgs/IzZFcrzOazyp3/w/UixaGS0yS9ln8AA7CDoDlqPHdHRZVzDXyEjDzADUPqe
	 pRgHiK9oZnUU7o8vJdDnoLmer+QhQcgQfdRlk9tZc9vSWPrOMTcXMUcw1/wJeHrvuRA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212334;
	bh=lvPWIE6cXtC20g32giKuiPe71xxNimfKb9QHokGjMcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tzc6Kkepcez5K49f2NbuhijEADLvfx3ije2T16wRSwpIpwGppSRJNvZurSecIP1z9
	 pJIudkvxsfLM37Nm6tXPArcPSzh+z8fe/yXknTyBttrZ6qB0EeQK90pmi44xK8+ffs
	 VhdZvxRYtxDJUKi6qIhyFAx/vLjuxOWiipynYqMybOluJMrhseJzPk5DOZmEoGkBBW
	 WNrM4bEVn2fFEiZvPQpRuJ3MKJPeCKiO8zqlwQyt1z5WKmuqODnPeMIun3AaMxX/KH
	 nmSAyhhZX4hqmHxQa2w8ziDPugWHmJz57wAwOFQz3y9pZxBZS/8hI0vowHN2h8a4f7
	 AITssufFrCvng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38BA0818C0;
	Fri, 20 Nov 2026 22:05:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B45B79C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A74440A81
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJ-NWkUy_fHk for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97C0F4076C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gmKWYl45
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97C0F4076C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:27 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6d68de53053so1017625eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212327; x=1795817127;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lvPWIE6cXtC20g32giKuiPe71xxNimfKb9QHokGjMcM=;
 b=gmKWYl45BEevbcvbIHN+mAJoUkrXqSJJPsd87fSzusMV7qW56RFb361Sgig5JumsHc
 TcaiWp61YpToPZDMuXUbjp9sUluNBw6Orv9JZ8zLuAywP3Q2CsoSUwuHX4rrfF3I5aqv
 en+/BUthKUfPzFiBJZjOHW8+ZuBwbwb/UWNVze+/e085Uzu94erhnk8XwAqgPSf8zZ+0
 ikHlBLl3lUhKBkNElMIHqgO46Ofv08CrimUahPIl2Tj2TIDJpflNI9chtccCA2e1vNOt
 391D0l3ktW9MuJN1Ooh+fw/0Ch1BKaYQvZBLxNW7TNUmAln2tmCfHHkeIeKALlrs7YQE
 t9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212327; x=1795817127;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lvPWIE6cXtC20g32giKuiPe71xxNimfKb9QHokGjMcM=;
 b=oh06LD8qdiB2IuxwGlyjNjhQUI6IUxz3ccr2hbraD6TCgMftcnPgRPjlN6ted8Ccaf
 giKjhnUXlzd3dxi/CR+XYl5tgRUv+/zKqNaiR7zwICbGZryTZTI6hq9KQ7bKbRh7IBYh
 +TzZONnD63nft8wn6+ktNmE4TerYyrvJ/9rxxINrpYlKtOcHaQnWfN+DTq89yaQ0nU8c
 kKI9rqAYPIpNlNcKF+DPkZmx49IDgMez3zFztFsYGgpwfQN99HLJ2YguiJCm29MPicmm
 MoFAAKA64NSFukAvRgrkulKrbyQEGyyP3gsAj6bqHJhSyALg9SI0fMxwCPlUSRKXkmoh
 10dQ==
X-Gm-Message-State: APuU4Z+tgdmhW75m50XM8d7BTMECGVb0dldFZot234m4eGFRTUyg9H79
 81i489eyM3xq7Q4+Wn3ev5cj3F+MigHBIGQmwm+NlndQuKryOuJjiM52eiZDi9uFwoY=
X-Gm-Gg: AYBFou2aHypLAPNHTqOW6Ie3rECOwVsHfJij3q1hSaspOtm2sVCfWre6AV1oEgTPKHh
 hcjxpewKEH0uu5Jy3DRCeUcZMyHPExr6UvQpYoVBISID6U2r/keliKvRLDOVo9HQhdVfRj8mEO3
 QC83cpsN5vxiHK03fndh88rdcS/et/h/XooebEqan+qgYFdrC6Mz3XoNUr45BLHEoB6/S4QHvoP
 sXw/dDwJtYTZNFU/o9H/Iq7ZzgAaWywolr7TdU4u+DHCTPNNPGKrPRMCntrP3+hhd2CSqq8/2uV
 cMhXBrCxhQe2LF1jeA17rfrodp4hRAa2+nFcsnc9p7XXNaof8JjNVRTo0fPhS/pd1Nqytg9wtbj
 9rFhw/ZvDfy3cTAynFnbpGKQb/DDY6Yklfa1Sdcs7ARIdcKEa6UjWatXxwEKkdjfyBcIbw+1Vr7
 q0/khANeEVnHTGoulZC/2iKuMtCMYW4BCyU3dFMrWZ5ePvjv2mfTccwm/G90cnoAg/9O6G5ILP3
 bikBCmIeD2YGI8DgGfXaL6BVhEo5JZFCpiKfKWvLgpg+A/AOl0rWs898ph4GmOypI/2M/bKyqMh
 UJ3hh1LOHT7K5M2IEYcpjsFRLnzvTWrN
X-Received: by 2002:a05:6820:55c2:20b0:715:2954:68e2 with SMTP id
 006d021491bc7-71b3920fc58mr2550257eaf.4.1795212326965; 
 Fri, 20 Nov 2026 14:05:26 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:48 -0600
Subject: [PATCH v2 07/10] arm: dts: mediatek: drop the -u-boot suffix from
 the Genio binman files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-7-4fa1894b7e2f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8569; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BnK7EUlYPJJqJqglzjQJx1tbgssO/7o4VEqBqvd3qv8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMP3vpY3HBxUkyzjDjouIbzxVB+hlYHtyFDEv
 e7meSa+eh2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDD9xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AllEH/jhD+5Gz0dCCSMYXH5Fl/Pn8R+BHbmRLhUpdJDk
 yH0c+djf7ziVU7Z8GlNbK9CLKs0eKl9E2yWitgOAxrFGoZo1hpWoI6EgYjmyvTt9a81UwD+JhYX
 LpwLayk1wVkFx2xfuEPDFvZfR/p54G9JHX5DAD7Q2C3K9PFbx+uf+FgfJHqtSR0Lm2SOBT8diZK
 dWCVVStQTE54DiclQmZ5URuGqNTB/WEdNU4CcnK+yc/2RSg7LZfiVSTN8o3aSSfNnXxX9wFKip2
 zOM9A6DKEqDrMgJr8O7l9mw/QwL9BqY2dlVN1hILQKL66W+WEpKdMtNq2ZIOQWnZofsoyeIS33I
 vHd8=
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

Rename the dtsi files that describe the Genio firmware images so that
their names no longer suggest that they are part of the U-Boot control
devicetree. They are about to move to a separate binman devicetree.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi                       | 6 +++---
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi                            | 6 +++---
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi                       | 6 +++---
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi                       | 6 +++---
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi                       | 6 +++---
 .../arm/dts/{mtk-genio-binman-u-boot.dtsi => mtk-genio-binman.dtsi} | 0
 ...loaders-binman-u-boot.dtsi => mtk-genio-bootloaders-binman.dtsi} | 0
 .../{mtk-genio-da-binman-u-boot.dtsi => mtk-genio-da-binman.dtsi}   | 2 +-
 ...genio-da-fit-binman-u-boot.dtsi => mtk-genio-da-fit-binman.dtsi} | 0
 ...ader-spl-binman-u-boot.dtsi => mtk-genio-loader-spl-binman.dtsi} | 0
 ...o-mtk-boot-binman-u-boot.dtsi => mtk-genio-mtk-boot-binman.dtsi} | 2 +-
 board/mediatek/MAINTAINERS                                          | 4 ++--
 doc/board/mediatek/mt8188-genio-evk.rst                             | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index f81ae1c82e2..2cc5e14a37a 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -10,9 +10,9 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index b57351bf892..ddfa95f4578 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -10,10 +10,10 @@
  * controllers disabled, independently of the normal boot USB setup.
  */
 
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-da-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-da-binman.dtsi"
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
-#include "mtk-genio-da-fit-binman-u-boot.dtsi"
+#include "mtk-genio-da-fit-binman.dtsi"
 #endif
 
 &ssusb0 {
diff --git a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
index 53e06bc6af1..4bd3a87392c 100644
--- a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
@@ -6,7 +6,7 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 520 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 520 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 395241173a0..9a742483cf5 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -10,9 +10,9 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
diff --git a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
index 0ee1ef3a869..1b659a9fa9a 100644
--- a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
@@ -6,7 +6,7 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 720 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 720 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
diff --git a/arch/arm/dts/mtk-genio-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman.dtsi
similarity index 80%
rename from arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-da-binman.dtsi
index eb956c91a80..1e602fd9565 100644
--- a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-da-binman.dtsi
@@ -9,6 +9,6 @@
 		filename = "da.bin";
 		pad-byte = <0>;
 
-#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+#include "mtk-genio-loader-spl-binman.dtsi"
 	};
 };
diff --git a/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-fit-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-da-fit-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
similarity index 91%
rename from arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
index af5cb96398b..778b3646465 100644
--- a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
@@ -20,7 +20,7 @@
 			section {
 				filename = "mtk-boot-payload.bin";
 				pad-byte = <0>;
-#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+#include "mtk-genio-loader-spl-binman.dtsi"
 			};
 		};
 	};
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 98a3d889a3d..cf1e5753be5 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -4,8 +4,8 @@ S:	Maintained
 F:	arch/arm/dts/mt8189*
 F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
-F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
-F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-*-binman.dtsi
+F:	arch/arm/dts/mtk-genio-binman.dtsi
 F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index 8a7694c89b1..4b3871e02de 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -448,7 +448,7 @@ start of the image, and region sizes include padding::
            |                      |           | 572 KiB              |
    0xfa000 +----------------------+   0xff000 +----------------------+
 
-Both DA modes use the shared ``mtk-genio-*-binman-u-boot.dtsi`` templates and
+Both DA modes use the shared ``mtk-genio-*-binman.dtsi`` templates and
 ``CONFIG_MTK_GENIO_IMAGE_CONTRACT`` settings. The image starts with the DDR
 loader padded to ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by SPL padded
 to ``CONFIG_SPL_MAX_SIZE``. The loader copies that SPL region to

-- 
2.53.0

