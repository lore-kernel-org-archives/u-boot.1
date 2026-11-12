Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301A7606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cIAMSxME;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SSVyXMaU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0718781842;
	Thu, 12 Nov 2026 21:16:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jw4a5QyvbYeq; Thu, 12 Nov 2026 21:16:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7B708153C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518208;
	b=QtPrkf6z1ynpLqOn/pUU6D3uALAIpF2n1Qbg6XtTqBdiq9SbFYpmDjOS2oiGs/NJaSrP
	 gSfTrHGO9SEYM1pp2JoXbHYiBzeyFSui9043NwbfzUMvW2LPvWz0KTI796yvPp8rSMTb4
	 Uj6EbaU0yLreDQLv4cbrY87+yKDatqwnNHmcvw1zNMFiKPJJMOEfXGQTP/7g/EFsMpVFL
	 CULMifvY55Br9ZU7QmZKtAgMsJdD1Irrhxgu0W93+ihlD/lK/z9oT0eKRmZFv/D18p1WP
	 c7LEjzUUWAfK1xUAIaeghi/RwXoZOAG0yr9fjX7mA9MAFMiN+Wp5oUxx29tMwNyfLbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qtQX9/d7yXlWoHCFW4gwl/AjymMehxLWMRYSdYtmEVw=;
	b=Rjc/bG3DYoPQhF8fHbRvXrw1UhtwVmC1Ul43KVR3jOTXOM/7SG1Kh9pqvz5n5dZu7Q8P
	 HqSrRYsn0QZ+GXTaJ+aF5A/GvgRCJRIUQdLbnVnWGEnDdtoYGXUs5j8DQ9mLN+aOZ+ExM
	 /sR8+9Y08RGTGW+AMwxRmU2ew61RHZS95qYgILhVNY4L2Fn1vUXB42O6eX6gC+kgdot5E
	 /cPSKow5D3q/6VTumA6E3elZRoIxBz8uzk5FoFhU4SKoi5hYQ8w3C5SEaSGF9GIgSCntz
	 zMUW6BSzgdkJVPCEjCz2J3+OkNj3KyC1/PmbTxmyLILMVP1X6t1VVNzXXo9241AxArg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518208;
	bh=qtQX9/d7yXlWoHCFW4gwl/AjymMehxLWMRYSdYtmEVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIAMSxMEIZSKTRucLe2vc8iiZEdUeERTbiwOMuW0nHiyMmTlFs99bQDiV+i1lCXfL
	 qVF4mq0N/3rQcQttjG9CwBrVt7SlxzdGgaQxTDDcglTK2onvfqwWtmnvLBRzTuOOlH
	 5uH7GoS/bdRXAuNBrdInJja6Ef2BVlCqpY+oR2zFqlETiZ4/sGYHxtNgUd2ya9mTyC
	 kfZBTxtSzKOKTwZEkFgP/CymgvmAseY9V669YcWrIS7Xw82q9hppujyp2ycs3X9rOw
	 2mwX1uz2cmiplDYXJIlFZY7wwJlTEe5NjBFtxbTEGH1M6x3ucFLlBdC5vmFpf+/c6U
	 z0DziSi2BM00g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7B708153C;
	Thu, 12 Nov 2026 21:16:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 709AF1790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F51D4009E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-ZJjcvh98Uy for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5A8CB4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SSVyXMaU
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A8CB4005F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:44 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4d198f1a591so261336b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518203; x=1795123003;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qtQX9/d7yXlWoHCFW4gwl/AjymMehxLWMRYSdYtmEVw=;
 b=SSVyXMaUcMVNhixZhSZ82My4jsl9g0Tu1mktO68StYHaQMwHm88+5r1M/5T7wqmrhV
 6CpGSLySd44whQxIJmNtd3Zbq7wSKlS4ZH9BjXEZfD+jcIcDqFdaR9vSPwzOO0lb7Nl1
 kev/OUw2pogn6doaU2V5hwy204EzBDUsUYxMY/CbxlohZSySxN8VxFnr9bqB/hmFZTzJ
 bsKiTuEuPzu3l4pB9pVT7z9T7Ki5n4t8aUKuuiIXzy7hUjZFNvh2RPBuTHXNJCpIvw9h
 csIyVvKJQH35U81Sxrbot6EOWXFvnQ9nk5wP34rbmiWlOOAhNfzAG6rDEb1GQXA5++rF
 HIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518203; x=1795123003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qtQX9/d7yXlWoHCFW4gwl/AjymMehxLWMRYSdYtmEVw=;
 b=d9iid76dME7kITc6MxKJCU3ChHImhC6GgZ7IcBWIMHbgP3ziDjvsSjKbErp/K1VNY+
 XK8OoaQUD5Oshe0cUfQfG3JJYV7rgGRxJSyML+nz+pSNlxjqKWftqSEECh0FXDWBt8NT
 Kq1FoBy2AibmfbQHkGsmrW/kKxz8tt4Gd63DpEHH0vVV3ykNKdOLBHBzLJVGQaaIpU/0
 V5Z5UfLBSMh+o1bPP9+pBYF6AlyTGCDe4ieapSVK65P5RMukdAURbm0p3fdq8vRuqhEU
 Qtuo5qr6hYRS8D8EmjZhDrhaNG6AOFxmjqNhmZ6xapaIbFUSBlFRx71aF+L65BJGgjoh
 XxLA==
X-Gm-Message-State: APuU4Z8DDv8EK5wzvnP73tu8TvzsoFmtiZFBMilsiXkvu3qB/Wknqqpp
 00jOl9EZb3Ez6JNI09t7EXo+utKYPTyH1OuFsWpvBC6d6hneOYgOgndsXfB7fuX2JgA=
X-Gm-Gg: AYBFou3xmjg6MDnyH9gr5yuyHI398MlCNnkK2mFeVj7uhQEsNfLWX3YjqhblJIBLcs7
 9Z/JqHiXtrT+co3fAIobGI2+deOBvqa4McjkpR0ozl+ZtzFS/0rhZgOa3cUVtjpfjPtpqshUgkD
 gV9VsXRnsk+skdFAjahlxawYStvsDHFd+qw/mHvZR2auVbRkznBhKHch+OMJuocIJnCXghlGMpO
 BVHaTYfs/dmS3/Sf5WsplIUdJeetkVA2P4nJZlDDacXzBF+P4nOr0UL1is1U2mdW0JTR0E35qhI
 upoWl9GjmKksp/lTHZlY1QYg4JOSLXQkno1mXbYJmws9Q1F+Ypr24ESXSivBCM77UhclGOHX9+o
 grXIdsuBrP3HR0WLX1EsolZorJ13ZYTtXLshZSQEwhAF8N7aY6ZjqA5DHAFGQuSr+pNM4JbatpS
 gd1BGVvR7omisdILteX1Hbr/ZBexMHJy2e+ml9zY4jyN0053U/0Cr07SFoRjzNb/ly/lglfbR6p
 vLhqk3M8sZyq1kq9zNIXbHNvU+BwlKpHHZXKXGS5ul0pQOaCVYfHgfGCK+SRzT8mMAs5CAzSGsL
 2XXWx1dwGc+SueVi9/BDzqgkp0OOMKSTeA==
X-Received: by 2002:a05:6808:3094:b0:4ea:18f:64b0 with SMTP id
 5614622812f47-56e6637036dmr375701b6e.67.1794518202729; 
 Thu, 12 Nov 2026 13:16:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:15:03 -0600
Subject: [PATCH 08/10] arm: mediatek: describe the Genio images in a
 separate binman devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-8-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9955; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=tCATDQxYNG7F90TptrW694SZxOaFYMBQHM41+Eee3CM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9iyQHkjaIRIBGyVeft4OOOrD/NwfqkDiYy/Eu
 PFKT4oeWayJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYskBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Am10IAIJR+mJ21A82MVzy06pFJrPTQ07WLsiC8KZ07qt
 5S4EhVvOHCMjedcGAu34sH94BctT5I+Crovzk+iBRPBzLQBD8NgFcPBw8Lk7ZqBNNzCXlE/GjBR
 Ahgb6NGlJVyvNzuc+6L8Pp0GbJtUkk6QAl6nh39D+IrK2BIr+rAhkNHx1/0IKfPQKB8vVCY7NPl
 7YiXeoVThAGQUGbvUty5qLfnbtteNmt802E6eWeeluyoqTQ6Gy46txvJj/7R8RfegBc2U14TgFN
 fo3bMsqPLULLl8Hx0KsREzxkVylhhdS1BWMvGZdphzN4O+KH/mS8OdKd4qI8OHOcImayV7kzmVB
 xrIU=
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
index 00517a753f6..a29fd71c41e 100644
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
 	dr_mode = "peripheral";
 };
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
index 4f7bedcb28b..09c36b3f317 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -258,6 +258,11 @@ config MTK_GENIO_BOOT_IMAGES
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
index bd0afb35995..486fc67983f 100644
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

