Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18014C79FB7
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85EDC40862;
	Thu, 10 Sep 2026 06:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iNOXmL74-wO; Thu, 10 Sep 2026 06:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8B3B440818
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789021577;
	b=JyOc2Z+A7zudHbD+j1gNmhY4M3hkEMBzdbuI+VP/bwjVACCgyaMY3CDp/7XqbdiKjb3z
	 W0myP3yCo0R7QlxNovXxZF+f6ICF13TOuqetnlyzG+XP+qi2gPCuZHG3PCTmVpzPN+zgr
	 Gn5WCwiq8Q8bF3KrtUVDayDDlU7Gixm8BINXXB1zl9Xpz7Gs7Aqyxg/zc/wp8kNEZm3sw
	 yi5a5vy8Ce0mQnhH94lJHvurvDjsu1n2XGvDrdncL/xkuseaJjcqptesV/hL8kZdSLo8o
	 q5ULhHA10FmjRlFhXrCMOqUncObLyl/4g4s/ETcwhCNFzddHJclr7lUAVQu+sshJaPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789021577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HmngbE9KsZKD16t9Qbj6fVW6nl8BWLDU+s14OLxMgZM=;
	b=O8LWBhfrAGWG6n9nQTHAK0EiW0JN3Q8OyT/5RE+N9EPySnKIPs2iVpbG91FcaP7Kco6+
	 kGbnOzFvYElMvO0KsyiY3dUw9F+XXeotclr54nqsfxSAlf/NsF1nCSaeYl95/LrtP+7Rk
	 ZB1ESoB6223T6EZZ2p28m4jZV/KdP8OlIytXN3yosQ8aH/ypLZKmWbEJUnCZ+RpqnvCx8
	 pbhA0Xl7YMHTvObdAFG5ZXadhpmxW7IzvvU8WbrwtYAMpK2tXZgfuR9q68smnQECJMHuV
	 o/jYdnkbpfo4b1/c/J2rba4hmMvzd85qNYQR4TvXDt/d2LwlS/kkIIjLAADF0UXAn5A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789021577;
	bh=HmngbE9KsZKD16t9Qbj6fVW6nl8BWLDU+s14OLxMgZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MH97BLZKX7YaCoOv0hs0Gy21fr9qDgWgXZUrxAhnxClFaFuA3/1ZyQNJY9T1ohENt
	 wBtG50nY6xZqHAn3jW6WApDOwNqtOPk/nfwqYnutos0DJ/mjtT2iNrPW1mzX9HUK7g
	 aJBjq4DoqLMkn6gGYnCyzJeXMFn1s7pteoa0uo5acItM4RmCUgoq/+wd7mv2TWetG2
	 eu4ddupBFdoDSvWOI8uJvCi14ri+ADY4ozbGtv/VR6xEUQjUHtTjDsrM9jtzizp9u0
	 Ax20xcl6G00vKd8AUrXLiOfrgycFaW1YLpA0O8nLf7uN/0Qukj05VDkI21SkfGYxww
	 vT7MfmGt7WJNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B3B440818;
	Thu, 10 Sep 2026 06:26:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24A5C43F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15FD580F0D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJEKYaI2Xoiw for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:26:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E03880EEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789021575;
 b=YE3qoiQBbTnDNZjvOv8Vb55I1Gy/4Hi6I+j6veAkl3I/FgH5QCTwZNkhnoB/KPfHY3Wp
 OGw+J0jiiVA9C7vDial7mi9M1JxtlebORu7o4SnjwObEn4TsSbQkyvq2f65MeI5Ba3Z5q
 dVoJiEkMSnrrKFt8RLRAihFtkUo2HxfTBCK9/S0cJab6wAJ/JxZvwtMtLJm0TCbGiYkz6
 Pr6w6jwDjprbMzlR3W8dIoKwEbbUHLuI4IZbSbnfzdwphjrjnI3XxyT1KaOHSFIXMBgd1
 /kB4fjQvBg9lgaPJER644Vdqa7UDVMpWD0qL3CDJ9Pm9A8ce0vvw3xjcRx5HUshaSow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789021575;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=HmngbE9KsZKD16t9Qbj6fVW6nl8BWLDU+s14OLxMgZM=;
 b=P/51vQrhv/ZlmbnlAuLRN3bSyCCf34GUWGjcPVLYP3rPiijtBpX34DDCU3v3Wxep7AIK
 q743tmwTVjzTzCX/hna3KJMpEKhCgpkBomvJOquX8oGEuPy7hrBTjWYPgx+CrHHedgk2x
 r3zWc+3LH0Nvjz3W1y6LF0MQ6G+AHBkjxifZrF7gXc9IBhVD8YzPIvR4/GP/IDUFl2OA8
 wzgeuYj4Y0Fg16MepqLS+1VemksDmuuGU8UD0Dd9VMF7KcoGCwwCym66w50e79jYxbSCD
 c96SJFTa8qjZkoKzhDwnGAqnIFnrhpYYBlvCZK5sN1IG1w4Ak9i+IW/GrWqTEdDPN7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Co1TKQYs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Co1TKQYs
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E03880EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:13 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so74553625e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789021571; x=1789626371;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HmngbE9KsZKD16t9Qbj6fVW6nl8BWLDU+s14OLxMgZM=;
 b=Co1TKQYsVnkzuGH76su1/dF9eHIWRwH+JpTDK9oSiSn7yqET781AcZUU23NJUPWyfg
 lXGp44unK00KxJzMWgrOBHbqkhaPt3wt4a1cQWurNbkc5HIXC+8zPG2bB/8MQP6CM57E
 szHCNWlmpJA3nP8XMokdvnxgoKOaKYsFiMauIgKVcaoJznabio0r/k1wUt+gaunNK5AX
 xvfcjwuvBztzps1hyl/SIU3IGC2SHH0KFIkA7cDfM3ZUgI9eIp7GeVhaWB79Sl+P4A1P
 UoE/cinlkx0Qw1AQgtHkaLX/WNrX5wJtvtd0zud5MTuSx5RCArgYY++0gmxNFS1kmDFW
 SfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789021571; x=1789626371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HmngbE9KsZKD16t9Qbj6fVW6nl8BWLDU+s14OLxMgZM=;
 b=Mv6JhSn85Y7SGxHlsG/EydLtd5FeAC3UYTdIs6NPMcBR9xDhI75nW+yboDp6tJ7p1t
 Es1J6Z/5UFCVAlWxVSbD4bT0w4R2IId4oBu9si+CtmNivG++rkODYHjVHmwmBxABz2eE
 3qb3QzbN1xPblZkQ404rBtJVpfGfewbUjkH5eIMsYFqDmlud099mZIOpxKlCH/bU+UZ9
 bK/eNjD0Xi8Rft/tKIwQ+o/izHCMSYE+ESKsb7FkUqbxOgK64K2rmRM4dNqIFtnqo7mw
 zXualcKTLdzWWrKUe8nQaW4q2I/zf6JUcef2rgOMqT14TUSL3qklcFFjp//pO7bLGYnE
 xABQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1VkUKRVUMnYqwxTHwfY49Xs1ZLLfsdIEHegN8T9ROfRF3Be8Jwf7rEPHnIMi35qS+Ky6lrTg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ncXED2lxEaXZ5hEKSDHezH7bZFjaxZsU1HC42hjeJZHzLEF9gy
 zQKU8QrjCySHGc03yC4z/29Tk0HNYbcPBdAgiiBkT6g/SLtWlEtbX+ymrTU59rGAKZ0=
X-Gm-Gg: AYBFou1Td9w92YmlGFDNzh5zeuCEm2Zm/67pGToZbAdWNrudlTEPmE6uQj8Z21miRie
 Lvu7IYMe+TyV1Ut6yt502DvHslF2yxvEuCq+EVADOVCeyRmoFX5cPMbkU5soGxMD6B3s6c9d7YJ
 5CrSrcW66pw7fA65FGVYOsH2AIUW6VZMwts7Nw8zmaV1ZylFGDCpZ66DCCgkbEKkc0innvFRt+e
 UQhOUz1rn0vXtQuwvLSC6kbIcUWk7UrkHmQMh4fxmKPCCNTopqIL71SqVeN5/xcm01qN8zskYZa
 PyGdJR9B5s2Li5k5dPnC316Fr4rjrs0BUw8w5uoFYssgDlvQOIBcn3tqaQxOCeWp5SE4C97xt1L
 P60cbBZSkTgMdEi+Pi8vKdOoR3GKOK0Azj/f+99pgF1X4vRBx3dZWovBlmf9BaUZGoFPt5DFB5B
 nzZxzud08NhjU06LVAir52UtcSc6dWn1g5d0PhqwA4MdNdsFP1JdgjhQJ+2hnRbIqYJ78rdhwif
 KLSURc+mg2+pLvhHnVbP+Ur2Sq3QPh1usMiYBRBrd+uqO9ZAIZLMRaEWK8ZOGp83cZuaCs9McEl
 Sm3Wa+aDAcDH54E=
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49cfc6e8e51mr354878975e9.24.1789021571634; 
 Wed, 09 Sep 2026 23:26:11 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm52279585e9.9.2026.09.09.23.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 23:26:11 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 10 Sep 2026 08:25:50 +0200
Subject: [PATCH v7 1/6] arm: dts: mediatek: prepare Genio 510 and 700
 devices for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ccaione-upstream-mt8390-spl-v7-1-0a5cf09c5761@baylibre.com>
References: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
In-Reply-To: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.16.0
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

The Genio 510 and Genio 700 boot flows enter U-Boot SPL after an
external DDR loader has initialized DRAM. SPL then needs the debug UART
and eMMC controller, together with their clock, syscon, pinctrl and
watchdog providers, to load the firmware FIT.

Both boards share this MT8188-family dependency chain, so keep the
pre-RAM annotations in a common include used by their board-specific
U-Boot devicetrees.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  6 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  6 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 89 +++++++++++++++++++++++++++
 board/mediatek/MAINTAINERS                    |  1 +
 4 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 586d15bf72e..223f1371b9e 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
- * Copyright (c) 2026 BayLibre, SAS.
+ * Copyright (c) 2026 BayLibre SAS
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 586d15bf72e..223f1371b9e 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
- * Copyright (c) 2026 BayLibre, SAS.
+ * Copyright (c) 2026 BayLibre SAS
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
new file mode 100644
index 00000000000..8fd48930c39
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include "mt8188-u-boot.dtsi"
+
+&clk26m {
+	bootph-pre-ram;
+};
+
+&gic {
+	/* Retain the eMMC interrupt parent even though SPL uses polling. */
+	bootph-pre-ram;
+};
+
+&topckgen {
+	bootph-pre-ram;
+};
+
+&infracfg_ao {
+	bootph-pre-ram;
+};
+
+&pio {
+	bootph-pre-ram;
+};
+
+&watchdog {
+	bootph-pre-ram;
+};
+
+&apmixedsys {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
+
+&mmc0_default_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_uhs_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-ds {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&uart0_pins {
+	bootph-pre-ram;
+
+	pins {
+		bootph-pre-ram;
+	};
+};
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d99c6d708b2..d0d25b096e5 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -22,6 +22,7 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config

-- 
2.55.0

