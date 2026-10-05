Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1F0CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56D0D80B80;
	Mon,  5 Oct 2026 22:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eu-C6DtxjP4T; Mon,  5 Oct 2026 22:11:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BA61D80BD6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791238282;
	b=FZ9NMbNqPyFD7j9yW2m4s+2ltIbC6ONhNksp/UW1CcB/67SljSVYAXaZKn57jOD8oxjl
	 5HcA7TLB4ARTHvTdwrBp8BHyVhC7wGf+OdTosEDxES1eX7sRi/KlcWUwgCFbaL//rlV3w
	 AHToywJdiaI2AOibsOcqpVtc+9IC13xe/z6lEn04SefE9HNXnmhLurJA5CNtkfht8A5sm
	 zcNsSNbR6z1LvA8DkGiAIIFv1nBFCp44iH7LPCVWtOjVd3ldOFQRugX0IyWDwFUbcG6yp
	 O8FzrkxRQnXiSNnV0WhfDPwCfGoIXkH82uKP+uJgdlBTEVrdYHfI6G/WwClVYMcax4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791238282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8fycBkv5M0VAAHJ5GCGYyIDxRmBRk78XX0W4nKfZFhs=;
	b=Et7kWH3P5plwcz1SnbPb0MFwxSY45jjEqLdfY+s34F5HjFgJ2KtkdJaQLKXgqsSBgbsR
	 qFW9i3cJJXuflf9V+9p2QEhSGYzk0RWMPI4qnu/J4HT6SmR+tHqyxz/gE/JUssOZqgEQv
	 oc9EzMEg4gU5yR/6RGRLjSyb971eoksCNKb1Q4bRZWLhmpO0pwEwEMwGj3f1e4IkNCmH1
	 DHO0tes+o2vowPdOu61PC0ESJ6dlQ52K5d/gDYb6lIlsxPIb+hqM5AmIoCPQ9g0HODKpe
	 Rc8ar9vFQghbjXloK67GyppwVBLNOWFPSAx2feySdwRprnkW6SWuG51Hk3v/5WFnkRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gZZYWpZH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791238282;
	bh=8fycBkv5M0VAAHJ5GCGYyIDxRmBRk78XX0W4nKfZFhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TovSLSjgVPc8SDLrxZEc70VX1h9hopgH8itBobMLx6D/g164qJoUHRWs6f9cVcEti
	 XefnyVhoNZAEvsWjJ3pRdn3AM5ZkCO6MEkek6GYv+wf1BPd5+OAvn9Fu7V6z/fyrp/
	 39cQf9/jLwHOVTomL2VsM3nWLTuvwabk70lonZaJBsaYaOzRmO2sIfeIPzuiaQodkf
	 TAnU8uFIV7t/bVV+7ZmP3H0ncQJHf8bj0Xsnn9opMYKCIduH/k0R+/3hl/kGnaPsGk
	 2hLFhIdEaHg6+DKtXjar7ibGjYVDRmbVQdEFFP7NAwGHNwPlKo9TI7SdnrV1g1MZl/
	 aB1tSa9OuLUMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA61D80BD6;
	Mon,  5 Oct 2026 22:11:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD4201A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87FB180A87
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5aNh0hHmVnZ for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8517380A8C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791238108;
 b=l2+1wurpzNrhU9P0MUlz1bRo2yBbrtCFk2Z/RN+xDJXMTBPVkEpdiC7Z/6h0XO0LjrjX
 Ec0czd+PCfafdvo+0kaHbzUcW1gDs1ZU9GClz7KD9u4D5670AyNh2OHqnuhB8Phwbx7e0
 hm8oIvXC/9hZdBM2CTnydl2tX9ajMHzAPqNR6Kw+M8roN8PBEqzl5UbLqEBaGPrKDMspF
 hoUns2VL5BXRb6iE0oIapnYFbYUjVH4IMmOq6FF9h+Qv5fc8alPyvkv5SLz49Ja2ReSds
 NZXsRcDhsNUEnzhsk/VoUa0DAvi0bwAl8f1jLy1GMwWofSpJ+GEs1B8xzWYJwnODPBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791238108;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=8fycBkv5M0VAAHJ5GCGYyIDxRmBRk78XX0W4nKfZFhs=;
 b=QogAYqFbYTcYhku53cLib8ZbG/LOIU07bhWMWAOG9ncFEVL+7sqH7lleueVizbhZ6ZUj
 BqShRjGp9E6vyGyhhvZ/0duRZ49mD+rX8WfImIBHfRVetx2T291gpis/POvqBITTLIpGW
 LwnSOaM1TYEHVrndKpEAMgyusFO9T8ocDPmf4BbxtBjETSR6p/77OTr7MZ9rA57rvANEZ
 0K+diMb5Rn7Y/O7lB6liLM8TGjLnw3s9mLqWZVDYd5omN3ERxm21kZtpb5ClA97Y1Qrld
 SJAf1WD6v+4KGKejgcoaQ60Vvk0PsTrJUf2FkCYCb8Gg5/esHI0hVG7N59FmNGNpkOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gZZYWpZH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gZZYWpZH
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8517380A8C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:27 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-825572e6701so957855a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791238106; x=1791842906;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8fycBkv5M0VAAHJ5GCGYyIDxRmBRk78XX0W4nKfZFhs=;
 b=gZZYWpZHojX5LUtKAjZItB/EyhyAjtFfA54qLsfEfrM061Qtm7bGxpH4EH+iE6868b
 V2mRZO47kQB06bCQrbGMninhwYPknk7e1NrXIqWtyuIWp4yHEMfyFlft9dRLWBfwMpyk
 Cb5onY8l8IOV4B1+RzMcYqy374ylSLvL2HDM3mgUpZ5VbPPANfkzvhu++deBeBMokrYy
 I+47eg1b1kssJFHfHwdvfuU4Cb8UJDDJSlyr5uETKoU71UbnwcTqRc59IUR5IZXdwaVq
 ohh9dV3pmEoSXA4tpOQwzs4McmUUQdsRztqXQwnoRi6Fs0OLfEAvRAfwFVBI3lgtOR+z
 bkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791238106; x=1791842906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8fycBkv5M0VAAHJ5GCGYyIDxRmBRk78XX0W4nKfZFhs=;
 b=T0vB/gnxwzGs07EaYPEhfPBazdOd1A00j4Ovc0qE6nx08JYnsPLZxW15+xWJ9ih6KD
 yETBvgPKFIDdPoyyE1mfFpQSFLVe83BnXRu+3++XhAMJdmklVL2NmZp/nnDByMUhfz0v
 9bLOCMXxo5S6HnDEK2oV4RzlT/eyg9f8EXzSO4dv5iEgxDRQ0I9qdSMhYdVtNkETkanp
 yXbnU/agvmAtXRa/RL75x6ojzHBD2BJi0Z4O2bMOoSBfVBF0pX87WTcIpseZf2BDXCU8
 L4nktMvut+22+OYMbMQYF/vD4PbhS41Hm+KSpvStsH/bPH3LZReDeTeBhFLa++WVe7Z9
 MkcQ==
X-Gm-Message-State: AFuF++lhihSZ8oOs5BfpA+BHR9f1UR+5i0N9FYFPNB8clt8/K1vcTp+s
 QkWUHYT6apHWbRjSYLYM/kVwNvIhwkjn6nRRbR9oUtsUWTeAwYeq95ugZW9/1uOgCU8=
X-Gm-Gg: AYBFou2lvnXHOLUOSzJ1sE67X7CF5dPQVQzrvOV3CfaMjCsw8z1LonJlcGI4FGbR/eX
 7MYTczFaI081D2TE+/t24kqdS3p5cPzXpFuYCIWNab1Bxr6lc8VrsCgnIwvouL/H0EN0b8uM4Pp
 fOVIhb3Prwj0+w2+72FIAG6FKNE0EIgvAT+MLdPwHmK1wLc2w8dMge/5G1IOh1uoLygqR4oB2Hi
 dcZfdSHz5ysZo11MoxW1j4iWEbQH/JfWivhkHwwDoUl6GRLmrR/oAfMtxnBZ7Hmtf5/vy+k+jX7
 n/zckZfMmrlmaf9uCBh1krBIDk8HsAuBVd1smTE/snhV+80PXI6pSVaDbiahuOXN7JtXXJrTwR3
 qI6zXKr3yB/ar+MqgQbrjH5JY7AMdUFhpinjOZVTDBK3iUkAjGhslw9osmKIzrsc0fxc4V+zqqu
 v214DhCFT8o1lDeYawhe2z6ysgi0TNXH05cJqxa7w7RP5fwPJq+ywci/3z++Od8ddsUkKQLYO6a
 G4=
X-Received: by 2002:a05:6830:83b7:b0:805:bf8b:9523 with SMTP id
 46e09a7af769-823fc4402c6mr9426638a34.10.1791238105780; 
 Mon, 05 Oct 2026 15:08:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8281db4582esm655718a34.3.2026.10.05.15.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:08:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:07:47 -0500
Subject: [PATCH v6 1/4] arm: dts: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-mtk-genio-360-bringup-v6-1-630f99bf3ce3@baylibre.com>
References: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
In-Reply-To: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=76299;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=E8AOuo5NT6v/nBc+k38Ug3+hqmj/+4DXxrq2Eaibnm8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxB+9AtQL4Xr9IVmCDKWlInHXrPx4X1qcoJXhi
 oevjXVU0uSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQfvRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+SAIAITrYQ1Mplx5+O/i7MW3A3DhAMAqAGEvnGohURk
 qZytaDjIeISEWaTblXH/Jun/jj5fAR9kje56viIQwUwZonF6aybKAP/1Bkm+/t089J4kLLtSv4e
 g4u89Cwms3rVOO4b9gkrlJ2bpCbASjkNlhq3QUiNICNkWzkm/VlhJ9FpP4Il35GqMgF4A5edNIB
 mvxl5rxSXg0hPtJjBGRCBQTiSmdqjdH8O8Cdl0pWrf/0qeSfxS4qP2hLIvrop/c+z4tR3L7Qymk
 iMiyd9gc1TLneWem6Bkr/rhkDFFfHTcSopT7y4RU0kwZ84UaJK79GPpW2ZD7gkSaegkwbhwY2fL
 ELQs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add MT8366 application processor .dtsi file for systems based on this
chip.

Upstreaming of MT8366 has not even started yet, so we will have to
carry a downstream version of this for some time. As a consequence,
none of the mediatek,mt8366-* compatible strings used here have a
binding yet. Where an existing MediaTek block is compatible, the node
also lists that block's compatible string as a fallback (uart, wdt,
mmc, nor, disp-pwm, disp-rdma, mipi-tx, tphy, xhci, mtu3). The others
follow the naming pattern of the existing MediaTek bindings so that
the eventual upstream bindings should match.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8366.dtsi                           | 770 ++++++++++++++++++
 include/dt-bindings/gce/mt8366-gce.h               | 858 +++++++++++++++++++++
 .../memory/mediatek,mt8366-memory-port.h           | 263 +++++++
 3 files changed, 1891 insertions(+)

diff --git a/arch/arm/dts/mt8366.dtsi b/arch/arm/dts/mt8366.dtsi
new file mode 100644
index 00000000000..eae1af57707
--- /dev/null
+++ b/arch/arm/dts/mt8366.dtsi
@@ -0,0 +1,770 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/clock/mt8366-clk.h>
+#include <dt-bindings/memory/mediatek,mt8366-memory-port.h>
+#include <dt-bindings/gce/mt8366-gce.h>
+#include <dt-bindings/power/mediatek,mt8366-power.h>
+
+/ {
+	compatible = "mediatek,mt8366";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		dsi0 = &dsi0;
+		mutex0 = &mutex0;
+		ovl0 = &disp_ovl0_4l;
+		ovl1 = &disp_ovl1_4l;
+		rdma0 = &disp_rdma0;
+		rdma1 = &disp_rdma1;
+	};
+
+	clk26m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,wr-osr-lmt = <0x7>;
+		snps,rd-osr-lmt = <0x7>;
+		snps,blen = <0 0 0 0 16 8 4>;
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-wrr;
+
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+
+		queue1 {
+			snps,weight = <0x11>;
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue2 {
+			snps,weight = <0x12>;
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue3 {
+			snps,weight = <0x13>;
+			snps,dcb-algorithm;
+			snps,priority = <0x3>;
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			#redistributor-regions = <1>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x40000>,
+			      <0 0x0c040000 0 0x200000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		topckgen_clk: clock-controller@10000000 {
+			compatible = "mediatek,mt8366-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg_ao_clk: clock-controller@10001000 {
+			compatible = "mediatek,mt8366-infracfg-ao", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt8366-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11c30000 0 0x1000>,
+			      <0 0x11d40000 0 0x1000>,
+			      <0 0x11e20000 0 0x1000>,
+			      <0 0x11ea0000 0 0x1000>,
+			      <0 0x11f10000 0 0x1000>,
+			      <0 0x11f20000 0 0x1000>,
+			      <0 0x1000b000 0 0x1000>;
+			reg-names = "gpio", "iocfg_rm", "iocfg_bm",
+				    "iocfg_lb", "iocfg_tr", "iocfg_lt",
+				    "iocfg_tl", "eint";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 172>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH 0>;
+			#interrupt-cells = <2>;
+		};
+
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8366-scpsys", "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8366-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				power-domain@MT8366_POWER_DOMAIN_PCIE {
+					reg = <MT8366_POWER_DOMAIN_PCIE>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8366_POWER_DOMAIN_CSI_RX {
+					reg = <MT8366_POWER_DOMAIN_CSI_RX>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8366_POWER_DOMAIN_CONN {
+					reg = <MT8366_POWER_DOMAIN_CONN>;
+					mediatek,infracfg = <&infracfg_ao_clk>;
+					#power-domain-cells = <0>;
+				};
+
+				mfg0: power-domain@MT8366_POWER_DOMAIN_MFG0 {
+					reg = <MT8366_POWER_DOMAIN_MFG0>;
+					clocks = <&apmixedsys_clk CLK_APMIXED_MFGPLL>;
+					clock-names = "mfg_top";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					mfg1: power-domain@MT8366_POWER_DOMAIN_MFG1 {
+						reg = <MT8366_POWER_DOMAIN_MFG1>;
+						clocks = <&topckgen_clk CLK_TOP_MFG_REF_SEL>;
+						clock-names = "mfg";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8366_POWER_DOMAIN_MFG2 {
+							reg = <MT8366_POWER_DOMAIN_MFG2>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8366_POWER_DOMAIN_MFG3 {
+							reg = <MT8366_POWER_DOMAIN_MFG3>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8366_POWER_DOMAIN_DISP {
+					reg = <MT8366_POWER_DOMAIN_DISP>;
+					clocks = <&topckgen_clk CLK_TOP_DISP_SEL>,
+						 <&dispsys_config CLK_MM_SMI>;
+					clock-names = "disp", "ss-disp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8366_POWER_DOMAIN_DP_TX {
+						reg = <MT8366_POWER_DOMAIN_DP_TX>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8366_POWER_DOMAIN_EPD {
+						reg = <MT8366_POWER_DOMAIN_EPD>;
+						clocks = <&topckgen_clk CLK_TOP_EPD_SEL>;
+						clock-names = "epd";
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8366_POWER_DOMAIN_MMLSYS_SHUTDOWN {
+						reg = <MT8366_POWER_DOMAIN_MMLSYS_SHUTDOWN>;
+						clocks = <&topckgen_clk CLK_TOP_MDP_SEL>;
+						clock-names = "mdp";
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8366_POWER_DOMAIN_VDEC {
+						reg = <MT8366_POWER_DOMAIN_VDEC>;
+						clocks = <&topckgen_clk CLK_TOP_VDEC_SEL>,
+							 <&vdec_gcon_base_clk CLK_VDE2_LARB1_CKEN>;
+						clock-names = "vdec", "ss-vdec";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8366_POWER_DOMAIN_VENC {
+						reg = <MT8366_POWER_DOMAIN_VENC>;
+						clocks = <&topckgen_clk CLK_TOP_VENC_SEL>;
+						clock-names = "venc";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8366_POWER_DOMAIN_ISP_IPE {
+						reg = <MT8366_POWER_DOMAIN_ISP_IPE>;
+						clocks = <&topckgen_clk CLK_TOP_IPE_SEL>,
+							 <&ipesys_clk CLK_IPE_GALS>;
+						clock-names = "ipe", "ss-ipe";
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8366_POWER_DOMAIN_CAM {
+						reg = <MT8366_POWER_DOMAIN_CAM>;
+						clocks = <&topckgen_clk CLK_TOP_CAM_SEL>,
+							 <&camsys_main_clk CLK_CAM_M_CAM2MM_GALS>;
+						clock-names = "cam", "ss-cam";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8366_POWER_DOMAIN_CAM_RAWA {
+							reg = <MT8366_POWER_DOMAIN_CAM_RAWA>;
+							#power-domain-cells = <0>;
+						};
+					};
+
+					power-domain@MT8366_POWER_DOMAIN_ISP_IMG1 {
+						reg = <MT8366_POWER_DOMAIN_ISP_IMG1>;
+						clocks = <&topckgen_clk CLK_TOP_IMG1_SEL>;
+						clock-names = "img1";
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8366_POWER_DOMAIN_ISP_IMG2 {
+							reg = <MT8366_POWER_DOMAIN_ISP_IMG2>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8366_POWER_DOMAIN_VADSP_AO {
+					reg = <MT8366_POWER_DOMAIN_VADSP_AO>;
+					clocks = <&topckgen_clk CLK_TOP_VADSP_SEL>,
+						 <&topckgen_clk CLK_TOP_VADSP_26M_SEL>;
+					clock-names = "vadsp", "vadsp_26m";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8366_POWER_DOMAIN_VADSP_INFRA {
+						reg = <MT8366_POWER_DOMAIN_VADSP_INFRA>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8366_POWER_DOMAIN_AUDIO {
+							reg = <MT8366_POWER_DOMAIN_AUDIO>;
+							clocks = <&topckgen_clk
+								  CLK_TOP_AUD_INTBUS_SEL>;
+							clock-names = "audio";
+							mediatek,infracfg = <&infracfg_ao_clk>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8366-wdt", "mediatek,mt6589-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			status = "disabled";
+		};
+
+		apmixedsys_clk: clock-controller@1000c000 {
+			compatible = "mediatek,mt8366-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pwrap: pwrap@10026000 {
+			compatible = "mediatek,mt8366-pwrap", "syscon";
+			reg = <0 0x10026000 0 0x1000>;
+			reg-names = "pwrap";
+			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_PMIC_AP>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REG_PMIC_TMR>,
+				 <&topckgen_clk CLK_TOP_PWRAP_ULPOSC_SEL>,
+				 <&topckgen_clk CLK_TOP_OSC_D10>;
+			clock-names = "spi", "wrap", "sys", "tmr";
+		};
+
+		gce0: mailbox@10228000 {
+			compatible = "mediatek,mt8366-gce";
+			reg = <0 0x10228000 0 0x4000>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_GCE>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REG_GCE_26M>;
+			clock-names = "gce", "gce-timer";
+			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt8366-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_UART0>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		disp_pwm0: pwm@1100e000 {
+			compatible = "mediatek,mt8366-disp-pwm", "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100e000 0 0x1000>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DISP_PWM0>,
+				 <&topckgen_clk CLK_TOP_DISP_PWM_SEL>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		disp_pwm1: pwm@1100f000 {
+			compatible = "mediatek,mt8366-disp-pwm", "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100f000 0 0x1000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DISP_PWM1>,
+				 <&topckgen_clk CLK_TOP_DISP_PWM_SEL>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		snor: spi@11018000 {
+			compatible = "mediatek,mt8366-nor", "mediatek,mt8186-nor";
+			reg = <0 0x11018000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SFLASH>;
+			clock-names = "spi", "sf";
+			assigned-clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		eth: ethernet@11019000 {
+			compatible = "mediatek,mt8366-gmac", "snps,dwmac-5.10a";
+			reg = <0 0x11019000 0 0x4000>;
+			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			clock-names = "mac_main",
+				      "ptp_ref",
+				      "rmii_internal";
+			clocks = <&topckgen_clk CLK_TOP_SNPS_ETH_250M_SEL>,
+				 <&topckgen_clk CLK_TOP_SNPS_ETH_62P4M_PTP_SEL>,
+				 <&topckgen_clk CLK_TOP_SNPS_ETH_50M_RMII_SEL>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_SNPS_ETH_250M_SEL>,
+					  <&topckgen_clk CLK_TOP_SNPS_ETH_62P4M_PTP_SEL>,
+					  <&topckgen_clk CLK_TOP_SNPS_ETH_50M_RMII_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_ETHPLL_D2>,
+						 <&topckgen_clk CLK_TOP_ETHPLL_D8>,
+						 <&topckgen_clk CLK_TOP_ETHPLL_D10>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_PCIE>;
+			mediatek,pericfg = <&infracfg_ao_clk>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <16>;
+			status = "disabled";
+		};
+
+		ssusb: usb@11201000 {
+			compatible = "mediatek,mt8366-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2e00>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u3port0 PHY_TYPE_USB3>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P0_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_FRMCNT>;
+			clock-names = "sys_ck",
+				      "ref_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "xhci_ck",
+				      "frmcnt_ck";
+			mediatek,syscon-wakeup = <&infracfg_ao_clk 0x3d4 103>;
+			dr_mode = "otg";
+			usb-role-switch;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			usb_host0: usb@11200000 {
+				compatible = "mediatek,mt8366-xhci", "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+				assigned-clocks = <&topckgen_clk CLK_TOP_USB_XHCI_P0_SEL>;
+				assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+				clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_SYS>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_REF>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_H>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_F>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_XCHI>;
+				clock-names = "sys_ck",
+					      "ref_ck",
+					      "mcu_ck",
+					      "dma_ck",
+					      "xhci_ck";
+			};
+		};
+
+		usb_host1: usb@11210000 {
+			compatible = "mediatek,mt8366-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11210000 0 0x1000>,
+			      <0 0x11213e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port1 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P1_SEL>,
+					  <&topckgen_clk CLK_TOP_USB_XHCI_P1_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_FRMCNT>;
+			clock-names = "sys_ck",
+				      "ref_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "xhci_ck",
+				      "frmcnt_ck";
+			power-domains = <&spm MT8366_POWER_DOMAIN_PCIE>;
+			status = "disabled";
+		};
+
+		usb_host2: usb@11220000 {
+			compatible = "mediatek,mt8366-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11220000 0 0x1000>,
+			      <0 0x11223e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P2_SEL>,
+					  <&topckgen_clk CLK_TOP_USB_XHCI_P2_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_FRMCNT>;
+			clock-names = "sys_ck",
+				      "ref_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "xhci_ck",
+				      "frmcnt_ck";
+			status = "disabled";
+		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8366-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11230000 0 0x1000>,
+			      <0 0x11ed0000 0 0x1000>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC50_0_SEL>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0_MST_F>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8366-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11240000 0 0x1000>,
+			      <0 0x11c70000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC30_1_SEL>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC1_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC1>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC1_MST_F>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk";
+			status = "disabled";
+		};
+
+		u2phy2: t-phy@11e40000 {
+			compatible = "mediatek,mt8366-tphy", "mediatek,generic-tphy-v3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port2: usb-phy@11e40000 {
+				reg = <0 0x11e40000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P2_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		mipi_tx_config0: dsi-phy@11e50000 {
+			compatible = "mediatek,mt8366-mipi-tx", "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11e50000 0 0x1000>;
+			clocks = <&clk26m>;
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			clock-output-names = "mipi_tx0_pll";
+			status = "disabled";
+		};
+
+		u3phy0: t-phy@11e80000 {
+			compatible = "mediatek,mt8366-tphy", "mediatek,generic-tphy-v3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port0: usb-phy@11e80000 {
+				reg = <0 0x11e80000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			u3port0: usb-phy@11e80700 {
+				reg = <0 0x11e80700 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		dptx_phyd_sifslv_dig_glb_clk: clock-controller@11ec1400 {
+			compatible = "mediatek,mt8366-dptx", "syscon";
+			reg = <0 0x11ec1400 0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		u2phy1: t-phy@11ef0000 {
+			compatible = "mediatek,mt8366-tphy", "mediatek,generic-tphy-v3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port1: usb-phy@11ef0000 {
+				reg = <0 0x11ef0000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P1_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		dispsys_config: syscon@14000000 {
+			compatible = "mediatek,mt8366-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			mboxes = <&gce0 0 CMDQ_THR_PRIO_HIGHEST>,
+				 <&gce0 1 CMDQ_THR_PRIO_HIGHEST>;
+
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1400XXXX 0 0x1000>;
+		};
+
+		mutex0: mutex@14001000 {
+			compatible = "mediatek,mt8366-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			clocks = <&dispsys_config CLK_MM_DISP_MUTEX0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1400XXXX 0x1000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_0_ENG_EVENT>;
+			status = "disabled";
+		};
+
+		disp_ovl0_4l: ovl@14002000 {
+			compatible = "mediatek,mt8366-disp-ovl";
+			reg = <0 0x14002000 0 0x1000>;
+			interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			iommus = <&mm_iommu M4U_L0_P0_DISP_OVL0_4L_RDMA0>;
+			clocks = <&dispsys_config CLK_MM_DISP_OVL0_4L>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1400XXXX 0x2000 0x1000>;
+			status = "disabled";
+		};
+
+		disp_ovl1_4l: ovl@14003000 {
+			compatible = "mediatek,mt8366-disp-ovl";
+			reg = <0 0x14003000 0 0x1000>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			iommus = <&mm_iommu M4U_L1_P0_DISP_OVL1_4L_RDMA0>;
+			clocks = <&dispsys_config CLK_MM_DISP_OVL1_4L>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1400XXXX 0x3000 0x1000>;
+			status = "disabled";
+		};
+
+		disp_rdma0: rdma@14006000 {
+			compatible = "mediatek,mt8366-disp-rdma", "mediatek,mt8195-disp-rdma";
+			reg = <0 0x14006000 0 0x1000>;
+			interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			clocks = <&dispsys_config CLK_MM_DISP_RDMA0>;
+			iommus = <&mm_iommu M4U_L0_P1_DISP_RDMA0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1400XXXX 0x6000 0x1000>;
+			status = "disabled";
+		};
+
+		disp_rdma1: rdma@14007000 {
+			compatible = "mediatek,mt8366-disp-rdma", "mediatek,mt8195-disp-rdma";
+			reg = <0 0x14007000 0 0x1000>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			clocks = <&dispsys_config CLK_MM_DISP_RDMA1>;
+			iommus = <&mm_iommu M4U_L1_P1_DISP_RDMA1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1400XXXX 0x7000 0x1000>;
+			status = "disabled";
+		};
+
+		dsi0: dsi@14016000 {
+			compatible = "mediatek,mt8366-dsi";
+			reg = <0 0x14016000 0 0x1000>;
+			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			phys = <&mipi_tx_config0>;
+			phy-names = "dphy";
+			clocks = <&dispsys_config CLK_MM_DISP_DSI0_MM>,
+				 <&dispsys_config CLK_MM_DISP_DSI0>,
+				 <&mipi_tx_config0>;
+			clock-names = "engine", "digital", "hs";
+			status = "disabled";
+		};
+
+		smi_larb0: larb@1401c000 {
+			compatible = "mediatek,mt8366-smi-larb";
+			reg = <0 0x1401c000 0 0x1000>;
+			clocks = <&dispsys_config CLK_MM_SMI>,
+				 <&dispsys_config CLK_MM_MM_CK_GLOBAL>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			mediatek,larb-id = <0>;
+			mediatek,smi = <&smi_disp_common>;
+			status = "disabled";
+		};
+
+		smi_larb1: larb@1401d000 {
+			compatible = "mediatek,mt8366-smi-larb";
+			reg = <0 0x1401d000 0 0x1000>;
+			clocks = <&dispsys_config CLK_MM_SMI>,
+				 <&dispsys_config CLK_MM_MM_CK_GLOBAL>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			mediatek,larb-id = <1>;
+			mediatek,smi = <&smi_disp_common>;
+			status = "disabled";
+		};
+
+		smi_disp_common: smi@1401f000 {
+			compatible = "mediatek,mt8366-smi-common";
+			reg = <0 0x1401f000 0 0x1000>;
+			clocks = <&dispsys_config CLK_MM_SMI>,
+				 <&dispsys_config CLK_MM_MM_CK_GLOBAL>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			status = "disabled";
+		};
+
+		mm_iommu: iommu@14020000 {
+			compatible = "mediatek,mt8366-iommu-mm";
+			reg = <0 0x14020000 0 0x5000>;
+			clocks = <&dispsys_config CLK_MM_SMI>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			interrupts = <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8366_POWER_DOMAIN_DISP>;
+			mediatek,larbs = <&smi_larb0>, <&smi_larb1>;
+			status = "disabled";
+		};
+
+		vdec_gcon_base_clk: clock-controller@1602f000 {
+			compatible = "mediatek,mt8366-vdec-gcon", "syscon";
+			reg = <0 0x1602f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_main_clk: clock-controller@1a000000 {
+			compatible = "mediatek,mt8366-camsys-main", "syscon";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipesys_clk: clock-controller@1b000000 {
+			compatible = "mediatek,mt8366-ipesys", "syscon";
+			reg = <0 0x1b000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		epdsys_clk: clock-controller@1c000000 {
+			compatible = "mediatek,mt8366-epdsys", "syscon";
+			reg = <0 0x1c000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+	};
+};
diff --git a/include/dt-bindings/gce/mt8366-gce.h b/include/dt-bindings/gce/mt8366-gce.h
new file mode 100644
index 00000000000..46e5089638a
--- /dev/null
+++ b/include/dt-bindings/gce/mt8366-gce.h
@@ -0,0 +1,858 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_GCE_MT8366_GCE_H
+#define _DT_BINDINGS_GCE_MT8366_GCE_H
+
+/* assign timeout 0 also means default */
+#define CMDQ_NO_TIMEOUT		0xffffffff
+#define CMDQ_TIMEOUT_DEFAULT	1000
+
+/* GCE thread priority */
+#define CMDQ_THR_PRIO_LOWEST	0
+#define CMDQ_THR_PRIO_1		1
+#define CMDQ_THR_PRIO_2		2
+#define CMDQ_THR_PRIO_3		3
+#define CMDQ_THR_PRIO_4		4
+#define CMDQ_THR_PRIO_5		5
+#define CMDQ_THR_PRIO_6		6
+#define CMDQ_THR_PRIO_HIGHEST	7
+
+/* CPR count in 32bit register */
+#define GCE_CPR_COUNT	1312
+
+/* GCE General Purpose Register (GPR) support
+ * Leave note for scenario usage here
+ */
+/* GCE: write mask */
+#define GCE_GPR_R00	0x00
+#define GCE_GPR_R01	0x01
+/* MDP: P1: JPEG dest */
+#define GCE_GPR_R02	0x02
+#define GCE_GPR_R03	0x03
+/* MDP: PQ color */
+#define GCE_GPR_R04	0x04
+/* MDP: 2D sharpness */
+#define GCE_GPR_R05	0x05
+/* DISP: poll esd */
+#define GCE_GPR_R06	0x06
+#define GCE_GPR_R07	0x07
+/* MDP: P4: 2D sharpness dst */
+#define GCE_GPR_R08	0x08
+#define GCE_GPR_R09	0x09
+/* VCU: poll with timeout for GPR timer */
+#define GCE_GPR_R10	0x0A
+#define GCE_GPR_R11	0x0B
+/* CMDQ: debug */
+#define GCE_GPR_R12	0x0C
+#define GCE_GPR_R13	0x0D
+/* CMDQ: P7: debug */
+#define GCE_GPR_R14	0x0E
+#define GCE_GPR_R15	0x0F
+
+/* GCE subsys table */
+#define SUBSYS_1400XXXX		0 /* MMSYS */
+#define SUBSYS_1401XXXX		1 /* MMSYS */
+#define SUBSYS_1402XXXX		2 /* MMSYS */
+#define SUBSYS_1f00XXXX		3 /* MMSYS */
+#define SUBSYS_1f01XXXX		4 /* MDP */
+#define SUBSYS_1600XXXX		5 /* MDP */
+#define SUBSYS_1601XXXX		6 /* VDEC */
+#define SUBSYS_1602XXXX		7 /* VDEC */
+#define SUBSYS_1c00XXXX		8 /* EPD */
+#define SUBSYS_1c01XXXX		9 /* EPD */
+#define SUBSYS_1022XXXX		10 /* GCE */
+#define SUBSYS_1b00XXXX		11 /* IPE */
+#define SUBSYS_1501XXXX		12 /* IMG */
+#define SUBSYS_1502XXXX		13 /* IMG */
+#define SUBSYS_1581XXXX		14 /* IMG */
+#define SUBSYS_1582XXXX		15 /* IMG */
+#define SUBSYS_1700XXXX		16 /* VENC */
+#define SUBSYS_1701XXXX		17 /* VENC */
+#define SUBSYS_1702XXXX		18 /* VENC */
+#define SUBSYS_1703XXXX		19 /* VENC */
+#define SUBSYS_1704XXXX		20 /* VENC */
+#define SUBSYS_1706XXXX		21 /* VENC */
+#define SUBSYS_1a00XXXX		22 /* CAM */
+#define SUBSYS_1a01XXXX		23 /* CAM */
+#define SUBSYS_1a03XXXX		24 /* CAM */
+#define SUBSYS_1a04XXXX		25 /* CAM */
+#define SUBSYS_1a05XXXX		26 /* CAM */
+#define SUBSYS_1a06XXXX		27 /* CAM */
+#define SUBSYS_1a09XXXX		28 /* CAM */
+#define SUBSYS_1a0aXXXX		29 /* CAM */
+#define SUBSYS_NO_SUPPORT	99
+/* HWTCON event */
+
+#define CMDQ_EVENT_VENC_EVENT_0					0
+#define CMDQ_EVENT_VENC_CMDQ_FRAME_DONE				1
+#define CMDQ_EVENT_VENC_CMDQ_PAUSE_DONE				2
+#define CMDQ_EVENT_JPGENC_CMDQ_DONE				3
+#define CMDQ_EVENT_VENC_CMDQ_MB_DONE				4
+#define CMDQ_EVENT_VENC_CMDQ_128BYTE_CNT_DONE			5
+#define CMDQ_EVENT_JPGDEC_CMDQ_DONE				6
+#define CMDQ_EVENT_JPGDEC_INSUFF_CMDQ_DONE			7
+#define CMDQ_EVENT_VENC_CMDQ_PPS_DONE				8
+#define CMDQ_EVENT_VENC_CMDQ_SPS_DONE				9
+#define CMDQ_EVENT_VENC_CMDQ_VPS_DONE				10
+#define CMDQ_EVENT_VENC_EVENT_11				11
+#define CMDQ_EVENT_VENC_EVENT_12				12
+#define CMDQ_EVENT_VENC_EVENT_13				13
+#define CMDQ_EVENT_VENC_EVENT_14				14
+#define CMDQ_EVENT_VENC_EVENT_15				15
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_0			33
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_1			34
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_2			35
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_3			36
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_4			37
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_5			38
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_6			39
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_7			40
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_8			41
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_9			42
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_10			43
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_11			44
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_12			45
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_13			46
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_14			47
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_15			48
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_16			49
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_17			50
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_18			51
+#define CMDQ_EVENT_IMG2_DIP_DMA_ERR_EVENT			52
+#define CMDQ_EVENT_IMG2_AMD_FRAME_DONE				53
+#define CMDQ_EVENT_IMG2_MFB_DONE				54
+#define CMDQ_EVENT_IMG2_WPE_DONE				55
+#define CMDQ_EVENT_IMG2_MSS_DONE				56
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_0			65
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_1			66
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_2			67
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_3			68
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_4			69
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_5			70
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_6			71
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_7			72
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_8			73
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_9			74
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_10			75
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_11			76
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_12			77
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_13			78
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_14			79
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_15			80
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_16			81
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_17			82
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_18			83
+#define CMDQ_EVENT_IMG1_DIP_DMA_ERR_EVENT			84
+#define CMDQ_EVENT_IMG1_AMD_FRAME_DONE				85
+#define CMDQ_EVENT_IMG1_MFB_DONE				86
+#define CMDQ_EVENT_IMG1_WPE_DONE				87
+#define CMDQ_EVENT_IMG1_MSS_DONE				88
+#define CMDQ_EVENT_IPE_FDVT_DONE				113
+#define CMDQ_EVENT_IPE_FE_DONE					114
+#define CMDQ_EVENT_IPE_RSC_DONE					115
+#define CMDQ_EVENT_IPE_DVS_DONE					116
+#define CMDQ_EVENT_IPE_DVP_DONE					117
+#define CMDQ_EVENT_DISP_OVL0_4L_SOF				128
+#define CMDQ_EVENT_DISP_OVL1_4L_SOF				129
+#define CMDQ_EVENT_DISP_RSZ0_SOF				130
+#define CMDQ_EVENT_DISP_RSZ1_SOF				131
+#define CMDQ_EVENT_DISP_RDMA0_SOF				132
+#define CMDQ_EVENT_DISP_RDMA1_SOF				133
+#define CMDQ_EVENT_DISP_COLOR1_SOF				134
+#define CMDQ_EVENT_DISP_CCORR1_SOF				135
+#define CMDQ_EVENT_DISP_CCORR3_SOF				136
+#define CMDQ_EVENT_DISP_AAL1_SOF				137
+#define CMDQ_EVENT_DISP_GAMMA1_SOF				138
+#define CMDQ_EVENT_DISP_DITHER1_SOF				139
+#define CMDQ_EVENT_VPP_MERGE0_SOF				140
+#define CMDQ_EVENT_DISP_DSI0_SOF				141
+#define CMDQ_EVENT_DP_INTF0_SOF					142
+#define CMDQ_EVENT_DPI0_SOF					143
+#define CMDQ_EVENT_DISP_WDMA0_SOF				144
+#define CMDQ_EVENT_DISP_DSI1_SOF				145
+#define CMDQ_EVENT_DISP_PWM0_SOF				146
+#define CMDQ_EVENT_DISP_PWM1_SOF				147
+#define CMDQ_EVENT_EPD_DLI_RELAY_SOF				148
+#define CMDQ_EVENT_DISP_OVL0_4L_FRAME_DONE			154
+#define CMDQ_EVENT_DISP_OVL1_4L_FRAME_DONE			155
+#define CMDQ_EVENT_DISP_RSZ0_FRAME_DONE				156
+#define CMDQ_EVENT_DISP_RSZ1_FRAME_DONE				157
+#define CMDQ_EVENT_DISP_RDMA0_FRAME_DONE			158
+#define CMDQ_EVENT_DISP_RDMA1_FRAME_DONE			159
+#define CMDQ_EVENT_DISP_COLOR1_FRAME_DONE			160
+#define CMDQ_EVENT_DISP_CCORR1_FRAME_DONE			161
+#define CMDQ_EVENT_DISP_CCORR3_FRAME_DONE			162
+#define CMDQ_EVENT_DISP_AAL1_FRAME_DONE				163
+#define CMDQ_EVENT_DISP_GAMMA1_FRAME_DONE			164
+#define CMDQ_EVENT_DISP_DITHER1_FRAME_DONE			165
+#define CMDQ_EVENT_VPP_MERGE0_FRAME_DONE			166
+#define CMDQ_EVENT_DISP_DSI0_FRAME_DONE				167
+#define CMDQ_EVENT_DP_INTF0_FRAME_DONE				168
+#define CMDQ_EVENT_DPI0_FRAME_DONE				169
+#define CMDQ_EVENT_DISP_WDMA0_FRAME_DONE			170
+#define CMDQ_EVENT_DISP_DSI1_FRAME_DONE				171
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT0		179
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT1		180
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT2		181
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT3		182
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT4		183
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT5		184
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT6		185
+#define CMDQ_EVENT_DISP_MUTEX0_BUF_UNDERRUN_EVENT7		186
+#define CMDQ_EVENT_VPP_MERGE0_ENG_EVENT				187
+#define CMDQ_EVENT_DISP_DSI0_TE_EVENT				188
+#define CMDQ_EVENT_DISP_DSI0_FRAME_DONE_EVENT			189
+#define CMDQ_EVENT_DISP_DSI0_TARGET_LINE_EVENT			190
+#define CMDQ_EVENT_DISP_INTF0_SEL_ENG_EVENT4			191
+#define CMDQ_EVENT_DISP_INTF0_SEL_ENG_EVENT3			192
+#define CMDQ_EVENT_DISP_INTF0_SEL_ENG_EVENT2			193
+#define CMDQ_EVENT_DISP_INTF0_SEL_ENG_EVENT1			194
+#define CMDQ_EVENT_DISP_INTF0_SEL_ENG_EVENT0			195
+#define CMDQ_EVENT_DISP_INTF0_EXTERNAL_TARGET_VDE_END_EVENT	196
+#define CMDQ_EVENT_DISP_INTF0_EXTERNAL_TARGET_VSYNC_START_EVENT	197
+#define CMDQ_EVENT_DISP_INTF0_INTERNAL_TARGET_LINE0_EVENT	198
+#define CMDQ_EVENT_DISP_WDMA0_SW_RESET_EVENT			200
+#define CMDQ_EVENT_DISP_DSI1_TE_EVENT				201
+#define CMDQ_EVENT_DISP_DSI1_FRAME_DONE_EVENT			202
+#define CMDQ_EVENT_DISP_DSI1_TARGET_LINE_EVENT			203
+#define CMDQ_EVENT_DISP_OVL0_4L_RST_DONE_EVENT			204
+#define CMDQ_EVENT_DISP_OVL1_4L_RST_DONE_EVENT			205
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_0_ENG_EVENT		208
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_1_ENG_EVENT		209
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_2_ENG_EVENT		210
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_3_ENG_EVENT		211
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_4_ENG_EVENT		212
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_5_ENG_EVENT		213
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_6_ENG_EVENT		214
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_7_ENG_EVENT		215
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_8_ENG_EVENT		216
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_9_ENG_EVENT		217
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_10_ENG_EVENT		218
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_11_ENG_EVENT		219
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_12_ENG_EVENT		220
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_13_ENG_EVENT		221
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_14_ENG_EVENT		222
+#define CMDQ_EVENT_DISP_MUTEX0_STREAM_DONE_15_ENG_EVENT		223
+#define CMDQ_EVENT_MDP_RDMA0_SOF				256
+#define CMDQ_EVENT_MDP_RDMA1_SOF				257
+#define CMDQ_EVENT_MDP_RDMA2_SOF				258
+#define CMDQ_EVENT_MDP_BIRSZ0_SOF				259
+#define CMDQ_EVENT_MDP_HDR0_SOF					260
+#define CMDQ_EVENT_MDP_AAL0_SOF					261
+#define CMDQ_EVENT_MDP_RSZ0_SOF					262
+#define CMDQ_EVENT_MDP_RSZ1_SOF					263
+#define CMDQ_EVENT_MDP_RSZ2_SOF					264
+#define CMDQ_EVENT_MDP_RSZ3_SOF					265
+#define CMDQ_EVENT_MDP_TDSHP0_SOF				266
+#define CMDQ_EVENT_MDP_COLOR0_SOF				267
+#define CMDQ_EVENT_MDP_WROT0_SOF				268
+#define CMDQ_EVENT_MDP_WROT1_SOF				269
+#define CMDQ_EVENT_MDP_WROT2_SOF				270
+#define CMDQ_EVENT_MDP_WDMA0_SOF				271
+#define CMDQ_EVENT_MDP_GAMMA0_SOF				272
+#define CMDQ_EVENT_MDP_DTH0_SOF					273
+#define CMDQ_EVENT_MDP_WROT2_FRAME_DONE				274
+#define CMDQ_EVENT_MDP_WROT1_FRAME_DONE				275
+#define CMDQ_EVENT_MDP_WROT0_FRAME_DONE				276
+#define CMDQ_EVENT_MDP_WDMA0_FRAME_DONE				277
+#define CMDQ_EVENT_MDP_TDSHP0_FRAME_DONE			278
+#define CMDQ_EVENT_MDP_RSZ3_FRAME_DONE				279
+#define CMDQ_EVENT_MDP_RSZ2_FRAME_DONE				280
+#define CMDQ_EVENT_MDP_RSZ1_FRAME_DONE				281
+#define CMDQ_EVENT_MDP_RSZ0_FRAME_DONE				282
+#define CMDQ_EVENT_MDP_RDMA2_FRAME_DONE				283
+#define CMDQ_EVENT_MDP_RDMA1_FRAME_DONE				284
+#define CMDQ_EVENT_MDP_RDMA0_FRAME_DONE				285
+#define CMDQ_EVENT_MDP_HDR0_FRAME_DONE				286
+#define CMDQ_EVENT_MDP_GAMMA0_FRAME_DONE			287
+#define CMDQ_EVENT_MDP_DTH0_FRAME_DONE				288
+#define CMDQ_EVENT_MDP_COLOR0_FRAME_DONE			289
+#define CMDQ_EVENT_MDP_BIRSZ0_FRAME_DONE			290
+#define CMDQ_EVENT_MDP_AAL0_FRAME_DONE				291
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_0			292
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_1			293
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_2			294
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_3			295
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_4			296
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_5			297
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_6			298
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_7			299
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_8			300
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_9			301
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_10			302
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_11			303
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_12			304
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_13			305
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_14			306
+#define CMDQ_EVENT_STREAM_DONE_ENG_EVENT_15			307
+#define CMDQ_EVENT_MDP_WROT2_SW_RST_DONE_ENG_EVENT		308
+#define CMDQ_EVENT_MDP_WROT1_SW_RST_DONE_ENG_EVENT		309
+#define CMDQ_EVENT_MDP_WROT0_SW_RST_DONE_ENG_EVENT		310
+#define CMDQ_EVENT_MDP_WDMA0_SW_RST_DONE_ENG_EVENT		311
+#define CMDQ_EVENT_MDP_RDMA2_SW_RST_DONE_ENG_EVENT		312
+#define CMDQ_EVENT_MDP_RDMA1_SW_RST_DONE_ENG_EVENT		313
+#define CMDQ_EVENT_MDP_RDMA0_SW_RST_DONE_ENG_EVENT		314
+#define CMDQ_EVENT_EPD_COLOR_DET0_ENG_EVENT			315
+#define CMDQ_EVENT_EPD_COLOR_DET1_ENG_EVENT			316
+#define CMDQ_EVENT_EINK_COLOR0_ENG_EVENT			317
+#define CMDQ_EVENT_EPDC_DPI0_SOF				320
+#define CMDQ_EVENT_MAIN_SOF					321
+#define CMDQ_EVENT_PIPELINE_SOF					322
+#define CMDQ_EVENT_WB_WDMA_SOF					323
+#define CMDQ_EVENT_WF_LUT_SOF					324
+#define CMDQ_EVENT_LUT_MERGE_SOF				325
+#define CMDQ_EVENT_WF_LUT_DISP_RDMA_SOF				326
+#define CMDQ_EVENT_RESERVED0_SOF				327
+#define CMDQ_EVENT_EPDC_DPI0_FRAME_DONE				328
+#define CMDQ_EVENT_LUT_ASSIGN_DONE				329
+#define CMDQ_EVENT_PIPELINE_DONE				330
+#define CMDQ_EVENT_WB_WDMA_DONE					331
+#define CMDQ_EVENT_WF_LUT_FRAME_DONE				332
+#define CMDQ_EVENT_LUT_FRAME_DONE				333
+#define CMDQ_EVENT_EPDC_DISP_RDMA0_FRAME_DONE			334
+#define CMDQ_EVENT_LUT_COL_EVENT				335
+#define CMDQ_EVENT_DPI_UPDATE_DONE				336
+#define CMDQ_EVENT_LUT_RELEASE_DONE				337
+#define CMDQ_EVENT_TCON_END_EVENT				338
+#define CMDQ_EVENT_TC_CMD_FINISH				339
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_0			340
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_1			341
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_2			342
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_3			343
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_4			344
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_5			345
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_6			346
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_7			347
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_8			348
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_9			349
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_10			350
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_11			351
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_12			352
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_13			353
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_14			354
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_15			355
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_16			356
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_17			357
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_18			358
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_19			359
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_20			360
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_21			361
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_22			362
+#define CMDQ_EVENT_TCON_TARGET_POINT_EVENT_23			363
+#define CMDQ_EVENT_ACVCOM_END_EVENT				364
+#define CMDQ_EVENT_ACVCOM_READ_DATA_END_EVENT			365
+#define CMDQ_EVENT_VPP_BUFFER_0_ENG_EVENT			368
+#define CMDQ_EVENT_VPP_BUFFER_1_ENG_EVENT			369
+#define CMDQ_EVENT_VPP_BUFFER_0_FRAME_DONE			370
+#define CMDQ_EVENT_VPP_BUFFER_1_FRAME_DONE			371
+#define CMDQ_EVENT_WF_BLEND_FRAME_DONE				372
+#define CMDQ_EVENT_WF_BLEND_TARGER_LINE_EVENT			373
+#define CMDQ_EVENT_LUT_RELEASE_EN				376
+#define CMDQ_EVENT_LINE_COUNT_THRESHOLD_INTERRUPT		384
+#define CMDQ_EVENT_VDEC_INT					385
+#define CMDQ_EVENT_VDEC_PAUSE					386
+#define CMDQ_EVENT_VDEC_DEC_ERROR				387
+#define CMDQ_EVENT_MC_BUSY_OVERFLOW_OR_MDEC_TIMEOUT		388
+#define CMDQ_EVENT_VDEC_DRAM_IDLE				389
+#define CMDQ_EVENT_INI_FETCH_RDY				390
+#define CMDQ_EVENT_PROCESS_FLAG					391
+#define CMDQ_EVENT_VLD_EVENT_0					392
+#define CMDQ_EVENT_VLD_EVENT_1					393
+#define CMDQ_EVENT_VLD_EVENT_2					394
+#define CMDQ_EVENT_VLD_EVENT_3					395
+#define CMDQ_EVENT_GCE_CNT					399
+#define CMDQ_EVENT_CAM_SOF_EVENT_0				448
+#define CMDQ_EVENT_CAM_RAWA_DONE_EVENT_1			449
+#define CMDQ_EVENT_CAM_RAWB_DONE_EVENT_2			450
+#define CMDQ_EVENT_CAM_RAWC_DONE_EVENT_3			451
+#define CMDQ_EVENT_CAM_CAMSV01_DONE_EVENT_4			452
+#define CMDQ_EVENT_CAM_CAMSV02_DONE_EVENT_5			453
+#define CMDQ_EVENT_CAM_CAMSV1_DONE_EVENT_6			454
+#define CMDQ_EVENT_CAM_CAMSV2_DONE_EVENT_7			455
+#define CMDQ_EVENT_CAM_CAMSV3_DONE_EVENT_8			456
+#define CMDQ_EVENT_CAM_CAMSV41_DONE_EVENT_9			457
+#define CMDQ_EVENT_CAM_CAMSV42_DONE_EVENT_10			458
+#define CMDQ_EVENT_CAM_MRAW0_DONE_EVENT_11			459
+#define CMDQ_EVENT_CAM_MRAW1_DONE_EVENT_12			460
+#define CMDQ_EVENT_CAM_SENINF0_EVENT_13				461
+#define CMDQ_EVENT_CAM_SENINF1_EVENT_14				462
+#define CMDQ_EVENT_CAM_SENINF2_EVENT_15				463
+#define CMDQ_EVENT_CAM_SENINF3_EVENT_16				464
+#define CMDQ_EVENT_CAM_SENINF4_EVENT_17				465
+#define CMDQ_EVENT_CAM_SENINF5_EVENT_18				466
+#define CMDQ_EVENT_CAM_SENINF6_EVENT_19				467
+#define CMDQ_EVENT_CAM_SENINF7_EVENT_20				468
+#define CMDQ_EVENT_CAM_SENINF8_EVENT_21				469
+#define CMDQ_EVENT_CAM_SENINF9_EVENT_22				470
+#define CMDQ_EVENT_CAM_SENINF10_EVENT_23			471
+#define CMDQ_EVENT_CAM_SENINF11_EVENT_24			472
+#define CMDQ_EVENT_CAM_SENINF12_EVENT_25			473
+#define CMDQ_EVENT_CAM_RAWA_TG0_EVENT_26			474
+#define CMDQ_EVENT_CAM_RAWA_DMA_EVENT_27			475
+#define CMDQ_EVENT_CAM_RAWB_TG0_EVENT_28			476
+#define CMDQ_EVENT_CAM_RAWB_DMA_EVENT_29			477
+#define CMDQ_EVENT_CAM_RAWC_TG0_EVENT_30			478
+#define CMDQ_EVENT_CAM_RAWC_DMA_EVENT_31			479
+#define CMDQ_EVENT_CAM_MRAW_TG01_EVENT_32			480
+#define CMDQ_EVENT_CAM_MRAW_DMA01_EVENT_33			481
+#define CMDQ_EVENT_CAM_MRAW_TG0_EVENT_34			482
+#define CMDQ_EVENT_CAM_MRAW_TG1_EVENT_35			483
+#define CMDQ_EVENT_CAM_RAWA_TG1_EVENT_36			484
+#define CMDQ_EVENT_CAM_RAWA_CQ_EVENT_37				485
+#define CMDQ_EVENT_CAM_RAWB_TG1_EVENT_38			486
+#define CMDQ_EVENT_CAM_RAWB_CQ_EVENT_39				487
+#define CMDQ_EVENT_CAM_RAWC_TG1_EVENT_40			488
+#define CMDQ_EVENT_CAM_RAWC_CQ_EVENT_41				489
+#define CMDQ_EVENT_CAM_PAD_EVENT_42				490
+#define CMDQ_EVENT_CAM_SENINF13_EVENT_43			491
+#define CMDQ_EVENT_CAM_SENINF14_EVENT_44			492
+
+/* event id is 9 bit */
+#define CMDQ_SYNC_TOKEN_MAX	0x3FF
+#define CMDQ_SYNC_TOKEN_INVALID	-1
+
+/* end of hw event and begin of sw token */
+#define CMDQ_MAX_HW_EVENT	512
+
+/* CMDQ sw tokens
+ * Following definitions are gce sw token which may use by clients
+ * event operation API.
+ * Note that token 512 to 639 may set secure
+ */
+
+/* begin of GCE-D sw token */
+/* MML sw tokens */
+#define CMDQ_SYNC_TOKEN_MML_BUFA		661
+#define CMDQ_SYNC_TOKEN_MML_BUFB		662
+#define CMDQ_SYNC_TOKEN_MML_BUF_NEXT		663
+#define CMDQ_SYNC_TOKEN_MML_IR_MML_READY	664
+#define CMDQ_SYNC_TOKEN_MML_IR_DISP_READY	665
+#define CMDQ_SYNC_TOKEN_MML_MML_STOP		666
+#define CMDQ_SYNC_TOKEN_MML_PIPE0		667
+#define CMDQ_SYNC_TOKEN_MML_PIPE1		668
+#define CMDQ_SYNC_TOKEN_MML_PIPE1_NEXT		669
+#define CMDQ_SYNC_TOKEN_MML_APU_START		670
+
+/* Config thread notify trigger thread */
+#define CMDQ_SYNC_TOKEN_CONFIG_DIRTY	640
+/* Trigger thread notify config thread */
+#define CMDQ_SYNC_TOKEN_STREAM_EOF	641
+/* Block Trigger thread until the ESD check finishes. */
+#define CMDQ_SYNC_TOKEN_ESD_EOF		642
+#define CMDQ_SYNC_TOKEN_STREAM_BLOCK	643
+/* check CABC setup finish */
+#define CMDQ_SYNC_TOKEN_CABC_EOF	644
+
+/*VFP period token for Msync*/
+#define CMDQ_SYNC_TOKEN_VFP_PERIOD	645
+/* SW sync token for dual display */
+#define CMDQ_SYNC_TOKEN_CONFIG_DIRTY_1	694
+#define CMDQ_SYNC_TOKEN_STREAM_EOF_1	695
+#define CMDQ_SYNC_TOKEN_ESD_EOF_1	696
+#define CMDQ_SYNC_TOKEN_STREAM_BLOCK_1	697
+#define CMDQ_SYNC_TOKEN_CABC_EOF_1	698
+
+/* GPR access tokens (for HW register backup)
+ * There are 15 32-bit GPR, 3 GPR form a set
+ * (64-bit for address, 32-bit for value)
+ * MUST NOT CHANGE, these tokens sync with MDP
+ */
+#define CMDQ_SYNC_TOKEN_GPR_SET_0	700
+#define CMDQ_SYNC_TOKEN_GPR_SET_1	701
+#define CMDQ_SYNC_TOKEN_GPR_SET_2	702
+#define CMDQ_SYNC_TOKEN_GPR_SET_3	703
+#define CMDQ_SYNC_TOKEN_GPR_SET_4	704
+
+#define CMDQ_SYNC_TOKEN_TE_0			705
+#define CMDQ_SYNC_TOKEN_PREFETCH_TE_0		706
+#define CMDQ_SYNC_TOKEN_VIDLE_POWER_ON		707
+#define CMDQ_SYNC_TOKEN_CHECK_TRIGGER_MERGE	708
+
+/* Resource lock event to control resource in GCE thread */
+#define CMDQ_SYNC_RESOURCE_WROT0	710
+#define CMDQ_SYNC_RESOURCE_WROT1	711
+
+/* HW TRACE sw token */
+#define CMDQ_SYNC_TOKEN_HW_TRACE_WAIT	712
+#define CMDQ_SYNC_TOKEN_HW_TRACE_LOCK	713
+
+/* SW sync token for dual display */
+#define CMDQ_SYNC_TOKEN_CONFIG_DIRTY_3	714
+#define CMDQ_SYNC_TOKEN_STREAM_EOF_3	715
+#define CMDQ_SYNC_TOKEN_ESD_EOF_3	716
+#define CMDQ_SYNC_TOKEN_STREAM_BLOCK_3	717
+#define CMDQ_SYNC_TOKEN_CABC_EOF_3	718
+/* end of GCE-D sw token */
+
+/* begin of GCE-M sw token */
+/* IMGSYS_POOL */
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_1	514
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_2	515
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_3	516
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_4	517
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_5	518
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_6	519
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_7	520
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_8	521
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_9	522
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_10	523
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_11	524
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_12	525
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_13	526
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_14	527
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_15	528
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_16	529
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_17	530
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_18	531
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_19	532
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_20	533
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_21	534
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_22	535
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_23	536
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_24	537
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_25	538
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_26	539
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_27	540
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_28	541
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_29	542
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_30	543
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_31	544
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_32	545
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_33	546
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_34	547
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_35	548
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_36	549
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_37	550
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_38	551
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_39	552
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_40	553
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_41	554
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_42	555
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_43	556
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_44	557
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_45	558
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_46	559
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_47	560
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_48	561
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_49	562
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_50	563
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_51	564
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_52	565
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_53	566
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_54	567
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_55	568
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_56	569
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_57	570
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_58	571
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_59	572
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_60	573
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_61	574
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_62	575
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_63	576
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_64	577
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_65	578
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_66	579
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_67	580
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_68	581
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_69	582
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_70	583
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_71	584
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_72	585
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_73	586
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_74	587
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_75	588
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_76	589
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_77	590
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_78	591
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_79	592
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_80	593
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_81	594
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_82	595
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_83	596
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_84	597
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_85	598
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_86	599
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_87	600
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_88	601
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_89	602
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_90	603
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_91	604
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_92	605
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_93	606
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_94	607
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_95	608
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_96	609
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_97	610
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_98	611
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_99	612
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_100	613
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_101	614
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_102	615
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_103	616
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_104	617
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_105	618
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_106	619
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_107	620
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_108	621
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_109	622
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_110	623
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_111	624
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_112	625
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_113	626
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_114	627
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_115	628
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_116	629
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_117	630
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_118	631
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_119	632
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_120	633
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_121	634
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_122	635
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_123	636
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_124	637
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_125	638
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_126	639
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_127	640
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_128	641
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_129	642
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_130	643
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_131	644
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_132	645
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_133	646
+
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_134	694
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_135	695
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_136	696
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_137	697
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_138	698
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_139	699
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_140	700
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_141	701
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_142	702
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_143	703
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_144	704
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_145	705
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_146	706
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_147	707
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_148	708
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_149	709
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_150	710
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_151	711
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_152	714
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_153	715
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_154	716
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_155	717
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_156	718
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_157	719
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_158	720
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_159	721
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_160	722
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_161	723
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_162	724
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_163	725
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_164	726
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_165	727
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_166	728
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_167	729
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_168	730
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_169	731
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_170	732
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_171	733
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_172	734
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_173	735
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_174	736
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_175	737
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_176	738
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_177	739
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_178	740
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_179	741
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_180	742
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_181	743
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_182	744
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_183	745
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_184	746
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_185	747
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_186	748
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_187	749
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_188	750
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_189	751
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_190	752
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_191	753
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_192	754
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_193	755
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_194	756
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_195	757
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_196	758
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_197	759
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_198	760
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_199	761
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_200	762
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_201	763
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_202	764
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_203	765
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_204	766
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_205	767
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_206	784
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_207	785
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_208	786
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_209	787
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_210	788
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_211	789
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_212	790
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_213	791
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_214	792
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_215	793
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_216	794
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_217	795
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_218	796
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_219	797
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_220	798
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_221	799
+
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_222	833
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_223	834
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_224	835
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_225	836
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_226	837
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_227	838
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_228	839
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_229	840
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_230	841
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_231	842
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_232	843
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_233	844
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_234	845
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_235	846
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_236	847
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_237	848
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_238	849
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_239	850
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_240	851
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_241	852
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_242	853
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_243	854
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_244	855
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_245	856
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_246	857
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_247	858
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_248	859
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_249	860
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_250	861
+
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_251	901
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_252	902
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_253	903
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_254	904
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_255	905
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_256	906
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_257	907
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_258	908
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_259	909
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_260	910
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_261	911
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_262	912
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_263	913
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_264	914
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_265	915
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_266	916
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_267	917
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_268	918
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_269	919
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_270	920
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_271	921
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_272	922
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_273	923
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_274	924
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_275	925
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_276	926
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_277	927
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_278	928
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_279	929
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_280	930
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_281	931
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_282	932
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_283	933
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_284	934
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_285	935
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_286	936
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_287	937
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_288	938
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_289	939
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_290	940
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_291	941
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_292	942
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_293	943
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_294	944
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_295	945
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_296	946
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_297	947
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_298	948
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_299	949
+#define CMDQ_SYNC_TOKEN_IMGSYS_POOL_300	950
+
+/* ISP sw token */
+#define CMDQ_SYNC_TOKEN_MSS	951
+#define CMDQ_SYNC_TOKEN_MSF	952
+/* end of GCE-M sw token */
+
+/* begin of common sw token */
+
+/* VENC sw token */
+#define CMDQ_SYNC_TOKEN_HISTOGRAM_VENC_WAIT	689
+#define CMDQ_SYNC_TOKEN_HISTOGRAM_VENC_SET	690
+
+/* Notify normal CMDQ there are some secure task done
+ * MUST NOT CHANGE, this token sync with secure world
+ */
+#define CMDQ_SYNC_SECURE_THR_EOF	647
+
+/* CMDQ use sw token */
+#define CMDQ_SYNC_TOKEN_USER_0		649
+#define CMDQ_SYNC_TOKEN_USER_1		650
+#define CMDQ_SYNC_TOKEN_POLL_MONITOR	651
+#define CMDQ_SYNC_TOKEN_TPR_LOCK	652
+
+/* TZMP sw token */
+#define CMDQ_SYNC_TOKEN_TZMP_DISP_WAIT	653
+#define CMDQ_SYNC_TOKEN_TZMP_DISP_SET	654
+#define CMDQ_SYNC_TOKEN_TZMP_ISP_WAIT	655
+#define CMDQ_SYNC_TOKEN_TZMP_ISP_SET	656
+#define CMDQ_SYNC_TOKEN_TZMP_AIE_WAIT	657
+#define CMDQ_SYNC_TOKEN_TZMP_AIE_SET	658
+#define CMDQ_SYNC_TOKEN_TZMP_ADL_WAIT	659
+#define CMDQ_SYNC_TOKEN_TZMP_ADL_SET	660
+
+/* PREBUILT sw token */
+#define CMDQ_SYNC_TOKEN_PREBUILT_MDP_LOCK	682
+#define CMDQ_SYNC_TOKEN_PREBUILT_MML_LOCK	685
+#define CMDQ_SYNC_TOKEN_PREBUILT_VFMT_LOCK	688
+#define CMDQ_SYNC_TOKEN_PREBUILT_DISP_LOCK	691
+#define CMDQ_SYNC_TOKEN_DISP_VA_START		692
+#define CMDQ_SYNC_TOKEN_DISP_VA_END		693
+
+/* event for gpr timer, used in sleep and poll with timeout */
+#define CMDQ_TOKEN_GPR_TIMER_R0		994
+#define CMDQ_TOKEN_GPR_TIMER_R1		995
+#define CMDQ_TOKEN_GPR_TIMER_R2		996
+#define CMDQ_TOKEN_GPR_TIMER_R3		997
+#define CMDQ_TOKEN_GPR_TIMER_R4		998
+#define CMDQ_TOKEN_GPR_TIMER_R5		999
+#define CMDQ_TOKEN_GPR_TIMER_R6		1000
+#define CMDQ_TOKEN_GPR_TIMER_R7		1001
+#define CMDQ_TOKEN_GPR_TIMER_R8		1002
+#define CMDQ_TOKEN_GPR_TIMER_R9		1003
+#define CMDQ_TOKEN_GPR_TIMER_R10	1004
+#define CMDQ_TOKEN_GPR_TIMER_R11	1005
+#define CMDQ_TOKEN_GPR_TIMER_R12	1006
+#define CMDQ_TOKEN_GPR_TIMER_R13	1007
+#define CMDQ_TOKEN_GPR_TIMER_R14	1008
+#define CMDQ_TOKEN_GPR_TIMER_R15	1009
+
+#define CMDQ_EVENT_MAX	0x3FF
+/* end of common sw token */
+/* CMDQ sw tokens END */
+
+#endif
diff --git a/include/dt-bindings/memory/mediatek,mt8366-memory-port.h b/include/dt-bindings/memory/mediatek,mt8366-memory-port.h
new file mode 100644
index 00000000000..f8d437902e3
--- /dev/null
+++ b/include/dt-bindings/memory/mediatek,mt8366-memory-port.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ * Author: Friday Yang <friday.yang@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_MEMORY_MEDIATEK_MT8366_MEMORY_PORT_H_
+#define _DT_BINDINGS_MEMORY_MEDIATEK_MT8366_MEMORY_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+#define SMI_L0_ID		0
+#define SMI_L1_ID		1
+#define SMI_L2_ID		2
+#define SMI_L3_ID		3
+#define SMI_L4_ID		4
+#define SMI_L7_ID		7
+#define SMI_L8_ID		8
+#define SMI_L9_ID		9
+#define SMI_L11_ID		11
+#define SMI_L13_ID		13
+#define SMI_L14_ID		14
+#define SMI_L16_ID		16
+#define SMI_L20_ID		20
+#define SMI_L22_ID		22
+
+/* Fake LARB ID for APU */
+#define APU_L0_ID		0
+
+/*
+ * MM IOMMU:
+ *	domain 0:	DISP: larb0, larb1,	MDP: larb2,
+ *	domain 1:	VDEC: larb4		VENC: larb7
+ *			EPD: larb3, larb8
+ *	domain 2:	IMG: larb9, larb11
+ *			IPE: larb20
+ *			CAM: larb13, larb14, larb16(larb16a)
+ */
+
+/* Larb0 -- disp*/
+#define M4U_L0_P0_DISP_OVL0_4L_RDMA0		MTK_M4U_ID(SMI_L0_ID, 0)
+#define M4U_L0_P1_DISP_RDMA0			MTK_M4U_ID(SMI_L0_ID, 1)
+#define M4U_L0_P2_DISP_WDMA0			MTK_M4U_ID(SMI_L0_ID, 2)
+#define M4U_L0_P3_DISP_FAKE_ENG0		MTK_M4U_ID(SMI_L0_ID, 3)
+
+/* Larb1 -- disp*/
+#define M4U_L1_P0_DISP_OVL1_4L_RDMA0		MTK_M4U_ID(SMI_L1_ID, 0)
+#define M4U_L1_P1_DISP_RDMA1			MTK_M4U_ID(SMI_L1_ID, 1)
+#define M4U_L1_P2_DISP_FAKE_ENG1		MTK_M4U_ID(SMI_L1_ID, 2)
+
+/* Larb2 -- mmlsys(mdp)*/
+#define M4U_L2_P0_MDP_COLOR_IP_RDMA		MTK_M4U_ID(SMI_L2_ID, 0)
+#define M4U_L2_P1_MDP_RDMA0			MTK_M4U_ID(SMI_L2_ID, 1)
+#define M4U_L2_P2_MDP_RDMA1			MTK_M4U_ID(SMI_L2_ID, 2)
+#define M4U_L2_P3_MDP_WROT0			MTK_M4U_ID(SMI_L2_ID, 3)
+#define M4U_L2_P4_MDP_WROT1			MTK_M4U_ID(SMI_L2_ID, 4)
+#define M4U_L2_P5_MDP_RDMA2			MTK_M4U_ID(SMI_L2_ID, 5)
+#define M4U_L2_P6_MDP_WROT2			MTK_M4U_ID(SMI_L2_ID, 6)
+#define M4U_L2_P7_MDP_WROT3			MTK_M4U_ID(SMI_L2_ID, 7)
+#define M4U_L2_P8_DISP_FAKE0			MTK_M4U_ID(SMI_L2_ID, 8)
+
+/* Larb3 --EPD*/
+#define M4U_L3_P0_EPD_WF_GREQ0			MTK_M4U_ID(SMI_L3_ID, 0)
+#define M4U_L3_P1_EPD_WF_GREQ2			MTK_M4U_ID(SMI_L3_ID, 1)
+#define M4U_L3_P2_EPD_WF_GREQ4			MTK_M4U_ID(SMI_L3_ID, 2)
+#define M4U_L3_P3_EPD_WF_GREQ6			MTK_M4U_ID(SMI_L3_ID, 3)
+#define M4U_L3_P4_EPD_WF_GREQ8			MTK_M4U_ID(SMI_L3_ID, 4)
+#define M4U_L3_P5_EPD_WF_GREQ10			MTK_M4U_ID(SMI_L3_ID, 5)
+#define M4U_L3_P6_EPD_WF_GREQ12			MTK_M4U_ID(SMI_L3_ID, 6)
+#define M4U_L3_P7_EPD_WF_GREQ14			MTK_M4U_ID(SMI_L3_ID, 7)
+#define M4U_L3_P8_EPD_WF_LUT_RDMA0_GREQ		MTK_M4U_ID(SMI_L3_ID, 8)
+#define M4U_L3_P9_EPD_WF_LUT_RDMA1_GREQ		MTK_M4U_ID(SMI_L3_ID, 9)
+#define M4U_L3_P10_EPD_IMG_BUF_RDMA_GREQ	MTK_M4U_ID(SMI_L3_ID, 10)
+#define M4U_L3_P11_EPD_DISP_FAKE_ENG_GREQ	MTK_M4U_ID(SMI_L3_ID, 11)
+
+/* Larb4 -- vdec*/
+#define M4U_L4_P0_HW_VDEC_MC_EXT		MTK_M4U_ID(SMI_L4_ID, 0)
+#define M4U_L4_P1_HW_VDEC_PP_EXT		MTK_M4U_ID(SMI_L4_ID, 1)
+#define M4U_L4_P2_HW_VDEC_PRED_RD_EXT		MTK_M4U_ID(SMI_L4_ID, 2)
+#define M4U_L4_P3_HW_VDEC_PRED_WR_EXT		MTK_M4U_ID(SMI_L4_ID, 3)
+#define M4U_L4_P4_HW_VDEC_PPWRAP_EXT		MTK_M4U_ID(SMI_L4_ID, 4)
+#define M4U_L4_P5_HW_VDEC_TILE_EXT		MTK_M4U_ID(SMI_L4_ID, 5)
+#define M4U_L4_P6_HW_VDEC_VLD_EXT		MTK_M4U_ID(SMI_L4_ID, 6)
+#define M4U_L4_P7_HW_VDEC_VLD2_EXT		MTK_M4U_ID(SMI_L4_ID, 7)
+#define M4U_L4_P8_HW_VDEC_AVC_MV_EXT		MTK_M4U_ID(SMI_L4_ID, 8)
+#define M4U_L4_P9_HW_VDEC_RG_CTRL_DMA_EXT	MTK_M4U_ID(SMI_L4_ID, 9)
+
+/* Larb5 --dummy*/
+
+/* Larb6 --dummy*/
+
+/* Larb7 -- venc*/
+#define M4U_L7_P0_VENC_RCPU			MTK_M4U_ID(SMI_L7_ID, 0)
+#define M4U_L7_P1_VENC_REC			MTK_M4U_ID(SMI_L7_ID, 1)
+#define M4U_L7_P2_VENC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 2)
+#define M4U_L7_P3_VENC_SV_COMV			MTK_M4U_ID(SMI_L7_ID, 3)
+#define M4U_L7_P4_VENC_RD_COMV			MTK_M4U_ID(SMI_L7_ID, 4)
+#define M4U_L7_P5_VENC_CUR_LUMA			MTK_M4U_ID(SMI_L7_ID, 5)
+#define M4U_L7_P6_VENC_CUR_CHROMA		MTK_M4U_ID(SMI_L7_ID, 6)
+#define M4U_L7_P7_VENC_REF_LUMA			MTK_M4U_ID(SMI_L7_ID, 7)
+#define M4U_L7_P8_VENC_REF_CHROMA		MTK_M4U_ID(SMI_L7_ID, 8)
+#define M4U_L7_P9_JPGENC_Y_RDMA			MTK_M4U_ID(SMI_L7_ID, 9)
+#define M4U_L7_P10_JPGENC_C_RDMA		MTK_M4U_ID(SMI_L7_ID, 10)
+#define M4U_L7_P11_JPGENC_Q_RDMA		MTK_M4U_ID(SMI_L7_ID, 11)
+#define M4U_L7_P12_JPGENC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 12)
+#define M4U_L7_P13_JPGDEC_WDMA			MTK_M4U_ID(SMI_L7_ID, 13)
+#define M4U_L7_P14_JPGDEC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 14)
+#define M4U_L7_P15_JPGDEC_HUFF_OFFSET		MTK_M4U_ID(SMI_L7_ID, 15)
+
+/* Larb8 -- EPD*/
+#define M4U_L8_P0_EPD_WF_GREQ1			MTK_M4U_ID(SMI_L8_ID, 0)
+#define M4U_L8_P1_EPD_WF_GREQ3			MTK_M4U_ID(SMI_L8_ID, 1)
+#define M4U_L8_P2_EPD_WF_GREQ5			MTK_M4U_ID(SMI_L8_ID, 2)
+#define M4U_L8_P3_EPD_WF_GREQ7			MTK_M4U_ID(SMI_L8_ID, 3)
+#define M4U_L8_P4_EPD_WF_GREQ9			MTK_M4U_ID(SMI_L8_ID, 4)
+#define M4U_L8_P5_EPD_WF_GREQ11			MTK_M4U_ID(SMI_L8_ID, 5)
+#define M4U_L8_P6_EPD_WF_GREQ13			MTK_M4U_ID(SMI_L8_ID, 6)
+#define M4U_L8_P7_EPD_WF_GREQ15			MTK_M4U_ID(SMI_L8_ID, 7)
+#define M4U_L8_P8_EPD_WF_LUT_RDMA2_GREQ		MTK_M4U_ID(SMI_L8_ID, 8)
+#define M4U_L8_P9_EPD_WF_LUT_RDMA3_GREQ		MTK_M4U_ID(SMI_L8_ID, 9)
+#define M4U_L8_P10_EPD_WB_BUF_RDMA_GREQ		MTK_M4U_ID(SMI_L8_ID, 10)
+#define M4U_L8_P11_EPD_WB_BUF_WDMA_GREQ		MTK_M4U_ID(SMI_L8_ID, 11)
+#define M4U_L8_P12_EPD_VCOM_GREQ		MTK_M4U_ID(SMI_L8_ID, 12)
+#define M4U_L8_P13_EPD_DISPLAY_RDMA0_GREQ	MTK_M4U_ID(SMI_L8_ID, 13)
+#define M4U_L8_P14_EPD_DISPLAY_FAKE_ENG_GREQ	MTK_M4U_ID(SMI_L8_ID, 14)
+
+/* Larb9 --imgsys1*/
+#define M4U_L9_P0_IMGI_D1			MTK_M4U_ID(SMI_L9_ID, 0)
+#define M4U_L9_P1_IMGBI_D1			MTK_M4U_ID(SMI_L9_ID, 1)
+#define M4U_L9_P2_DMGI_D1			MTK_M4U_ID(SMI_L9_ID, 2)
+#define M4U_L9_P3_DEPI_D1			MTK_M4U_ID(SMI_L9_ID, 3)
+#define M4U_L9_P4_LCE_D1			MTK_M4U_ID(SMI_L9_ID, 4)
+#define M4U_L9_P5_SMTI_D1			MTK_M4U_ID(SMI_L9_ID, 5)
+#define M4U_L9_P6_SMTO_D2			MTK_M4U_ID(SMI_L9_ID, 6)
+#define M4U_L9_P7_SMTO_D1			MTK_M4U_ID(SMI_L9_ID, 7)
+#define M4U_L9_P8_CRZO_D1			MTK_M4U_ID(SMI_L9_ID, 8)
+#define M4U_L9_P9_IMG3O_D1			MTK_M4U_ID(SMI_L9_ID, 9)
+#define M4U_L9_P10_VIPI_D1			MTK_M4U_ID(SMI_L9_ID, 10)
+#define M4U_L9_P11_SMTI_D5			MTK_M4U_ID(SMI_L9_ID, 11)
+#define M4U_L9_P12_TIMGO_D1			MTK_M4U_ID(SMI_L9_ID, 12)
+#define M4U_L9_P13_UFBC_W0			MTK_M4U_ID(SMI_L9_ID, 13)
+#define M4U_L9_P14_UFBC_R0			MTK_M4U_ID(SMI_L9_ID, 14)
+#define M4U_L9_P15_WPE_RDMA1			MTK_M4U_ID(SMI_L9_ID, 15)
+#define M4U_L9_P16_WPE_RDMA0			MTK_M4U_ID(SMI_L9_ID, 16)
+#define M4U_L9_P17_WPE_WDMA			MTK_M4U_ID(SMI_L9_ID, 17)
+#define M4U_L9_P18_MFB_RDMA0			MTK_M4U_ID(SMI_L9_ID, 18)
+#define M4U_L9_P19_MFB_RDMA1			MTK_M4U_ID(SMI_L9_ID, 19)
+#define M4U_L9_P20_MFB_RDMA2			MTK_M4U_ID(SMI_L9_ID, 20)
+#define M4U_L9_P21_MFB_RDMA3			MTK_M4U_ID(SMI_L9_ID, 21)
+#define M4U_L9_P22_MFB_RDMA4			MTK_M4U_ID(SMI_L9_ID, 22)
+#define M4U_L9_P23_MFB_RDMA5			MTK_M4U_ID(SMI_L9_ID, 23)
+#define M4U_L9_P24_MFB_WDMA0			MTK_M4U_ID(SMI_L9_ID, 24)
+#define M4U_L9_P25_MFB_WDMA1			MTK_M4U_ID(SMI_L9_ID, 25)
+#define M4U_L9_P26_RESERVE6			MTK_M4U_ID(SMI_L9_ID, 26)
+#define M4U_L9_P27_RESERVE7			MTK_M4U_ID(SMI_L9_ID, 27)
+#define M4U_L9_P28_RESERVE8			MTK_M4U_ID(SMI_L9_ID, 28)
+
+/* Larb10 -- dummy*/
+
+/* Larb11 -- imgsys2*/
+#define M4U_L11_P0_IMGI_D1			MTK_M4U_ID(SMI_L11_ID, 0)
+#define M4U_L11_P1_IMGBI_D1			MTK_M4U_ID(SMI_L11_ID, 1)
+#define M4U_L11_P2_DMGI_D1			MTK_M4U_ID(SMI_L11_ID, 2)
+#define M4U_L11_P3_DEPI_D1			MTK_M4U_ID(SMI_L11_ID, 3)
+#define M4U_L11_P4_LCE_D1			MTK_M4U_ID(SMI_L11_ID, 4)
+#define M4U_L11_P5_SMTI_D1			MTK_M4U_ID(SMI_L11_ID, 5)
+#define M4U_L11_P6_SMTO_D2			MTK_M4U_ID(SMI_L11_ID, 6)
+#define M4U_L11_P7_SMTO_D1			MTK_M4U_ID(SMI_L11_ID, 7)
+#define M4U_L11_P8_CRZO_D1			MTK_M4U_ID(SMI_L11_ID, 8)
+#define M4U_L11_P9_IMG3O_D1			MTK_M4U_ID(SMI_L11_ID, 9)
+#define M4U_L11_P10_VIPI_D1			MTK_M4U_ID(SMI_L11_ID, 10)
+#define M4U_L11_P11_SMTI_D5			MTK_M4U_ID(SMI_L11_ID, 11)
+#define M4U_L11_P12_TIMGO_D1			MTK_M4U_ID(SMI_L11_ID, 12)
+#define M4U_L11_P13_UFBC_W0			MTK_M4U_ID(SMI_L11_ID, 13)
+#define M4U_L11_P14_UFBC_R0			MTK_M4U_ID(SMI_L11_ID, 14)
+#define M4U_L11_P15_WPE_RDMA1			MTK_M4U_ID(SMI_L11_ID, 15)
+#define M4U_L11_P16_WPE_RDMA0			MTK_M4U_ID(SMI_L11_ID, 16)
+#define M4U_L11_P17_WPE_WDMA			MTK_M4U_ID(SMI_L11_ID, 17)
+#define M4U_L11_P18_MFB_RDMA0			MTK_M4U_ID(SMI_L11_ID, 18)
+#define M4U_L11_P19_MFB_RDMA1			MTK_M4U_ID(SMI_L11_ID, 19)
+#define M4U_L11_P20_MFB_RDMA2			MTK_M4U_ID(SMI_L11_ID, 20)
+#define M4U_L11_P21_MFB_RDMA3			MTK_M4U_ID(SMI_L11_ID, 21)
+#define M4U_L11_P22_MFB_RDMA4			MTK_M4U_ID(SMI_L11_ID, 22)
+#define M4U_L11_P23_MFB_RDMA5			MTK_M4U_ID(SMI_L11_ID, 23)
+#define M4U_L11_P24_MFB_WDMA0			MTK_M4U_ID(SMI_L11_ID, 24)
+#define M4U_L11_P25_MFB_WDMA1			MTK_M4U_ID(SMI_L11_ID, 25)
+#define M4U_L11_P26_RESERVE6			MTK_M4U_ID(SMI_L11_ID, 26)
+#define M4U_L11_P27_RESERVE7			MTK_M4U_ID(SMI_L11_ID, 27)
+#define M4U_L11_P28_RESERVE8			MTK_M4U_ID(SMI_L11_ID, 28)
+
+/* Larb12 -- dummy*/
+
+/* Larb13 -- cam*/
+#define M4U_L13_P0_MRAWI			MTK_M4U_ID(SMI_L13_ID, 0)
+#define M4U_L13_P1_MRAWO_0			MTK_M4U_ID(SMI_L13_ID, 1)
+#define M4U_L13_P2_MRAWO_1			MTK_M4U_ID(SMI_L13_ID, 2)
+#define M4U_L13_P3_CAMSV_1			MTK_M4U_ID(SMI_L13_ID, 3)
+#define M4U_L13_P4_CAMSV_2			MTK_M4U_ID(SMI_L13_ID, 4)
+#define M4U_L13_P5_CAMSV_3			MTK_M4U_ID(SMI_L13_ID, 5)
+#define M4U_L13_P6_CAMSV_4			MTK_M4U_ID(SMI_L13_ID, 6)
+#define M4U_L13_P7_CAMSV_5			MTK_M4U_ID(SMI_L13_ID, 7)
+#define M4U_L13_P8_CAMSV_6			MTK_M4U_ID(SMI_L13_ID, 8)
+#define M4U_L13_P9_CCUI				MTK_M4U_ID(SMI_L13_ID, 9)
+#define M4U_L13_P10_CCUO			MTK_M4U_ID(SMI_L13_ID, 10)
+#define M4U_L13_P11_FAKE			MTK_M4U_ID(SMI_L13_ID, 11)
+#define M4U_L13_P12_PDAI_0			MTK_M4U_ID(SMI_L13_ID, 12)
+#define M4U_L13_P13_PDAI_1			MTK_M4U_ID(SMI_L13_ID, 13)
+#define M4U_L13_P14_PDAO			MTK_M4U_ID(SMI_L13_ID, 14)
+
+/* Larb14 -- cam */
+#define M4U_L14_P0_RESERVE			MTK_M4U_ID(SMI_L14_ID, 0)
+#define M4U_L14_P1_RESERVE			MTK_M4U_ID(SMI_L14_ID, 1)
+#define M4U_L14_P2_RESERVE			MTK_M4U_ID(SMI_L14_ID, 2)
+#define M4U_L14_P3_CAMSV_0			MTK_M4U_ID(SMI_L14_ID, 3)
+#define M4U_L14_P4_CCUI				MTK_M4U_ID(SMI_L14_ID, 4)
+#define M4U_L14_P5_CCUO				MTK_M4U_ID(SMI_L14_ID, 5)
+#define M4U_L14_P6_CAMSV_7			MTK_M4U_ID(SMI_L14_ID, 6)
+#define M4U_L14_P7_CAMSV_8			MTK_M4U_ID(SMI_L14_ID, 7)
+#define M4U_L14_P8_CAMSV_9			MTK_M4U_ID(SMI_L14_ID, 8)
+#define M4U_L14_P9_CAMSV_10			MTK_M4U_ID(SMI_L14_ID, 9)
+
+/* Larb15 -- dummy*/
+
+/* Larb16 -- cam*/
+#define M4U_L16_P0_IMGO_R1_A			MTK_M4U_ID(SMI_L16_ID, 0)
+#define M4U_L16_P1_RRZO_R1_A			MTK_M4U_ID(SMI_L16_ID, 1)
+#define M4U_L16_P2_CQI_R1_A			MTK_M4U_ID(SMI_L16_ID, 2)
+#define M4U_L16_P3_BPCI_R1_A			MTK_M4U_ID(SMI_L16_ID, 3)
+#define M4U_L16_P4_YUVO_R1_A			MTK_M4U_ID(SMI_L16_ID, 4)
+#define M4U_L16_P5_UFDI_R2_A			MTK_M4U_ID(SMI_L16_ID, 5)
+#define M4U_L16_P6_RAWI_R2_A			MTK_M4U_ID(SMI_L16_ID, 6)
+#define M4U_L16_P7_RAWI_R3_A			MTK_M4U_ID(SMI_L16_ID, 7)
+#define M4U_L16_P8_AAO_R1_A			MTK_M4U_ID(SMI_L16_ID, 8)
+#define M4U_L16_P9_AFO_R1_A			MTK_M4U_ID(SMI_L16_ID, 9)
+#define M4U_L16_P10_FLKO_R1_A			MTK_M4U_ID(SMI_L16_ID, 10)
+#define M4U_L16_P11_LCESO_R1_A			MTK_M4U_ID(SMI_L16_ID, 11)
+#define M4U_L16_P12_CRZO_R1_A			MTK_M4U_ID(SMI_L16_ID, 12)
+#define M4U_L16_P13_LTMSO_R1_A			MTK_M4U_ID(SMI_L16_ID, 13)
+#define M4U_L16_P14_RSSO_R1_A			MTK_M4U_ID(SMI_L16_ID, 14)
+#define M4U_L16_P15_AAHO_R1_A			MTK_M4U_ID(SMI_L16_ID, 15)
+#define M4U_L16_P16_LSCI_R1_A			MTK_M4U_ID(SMI_L16_ID, 16)
+
+/* Larb17 -- cam tie value */
+
+/* Larb19 -- ipesys tie value */
+
+/* Larb20 -- ipesys*/
+#define M4U_L20_P0_FDVT_RDA_0			MTK_M4U_ID(SMI_L20_ID, 0)
+#define M4U_L20_P1_FDVT_RDB_0			MTK_M4U_ID(SMI_L20_ID, 1)
+#define M4U_L20_P2_FDVT_WRA_0			MTK_M4U_ID(SMI_L20_ID, 2)
+#define M4U_L20_P3_FDVT_WRB_0			MTK_M4U_ID(SMI_L20_ID, 3)
+#define M4U_L20_P4_RSC_RDMA			MTK_M4U_ID(SMI_L20_ID, 4)
+#define M4U_L20_P5_RSC_WDMA			MTK_M4U_ID(SMI_L20_ID, 5)
+
+/* fake larb & port for svp and dual svp and wfd */
+#define M4U_PORT_SVP_HEAP			MTK_M4U_ID(SMI_L22_ID, 0)
+#define M4U_PORT_DUAL_SVP_HEAP			MTK_M4U_ID(SMI_L22_ID, 1)
+#define M4U_PORT_WFD_HEAP			MTK_M4U_ID(SMI_L22_ID, 2)
+
+/* fake larb0 for apu */
+#define M4U_LARB_APU				SMI_L22_ID
+
+#endif

-- 
2.53.0

