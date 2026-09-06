Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9168C79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55D15809EB;
	Sun,  6 Sep 2026 15:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zVHlbyeyx6ce; Sun,  6 Sep 2026 15:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A1F080B97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788708631;
	b=KHHSs3YR9cTY59BnwwFSEEGIAjsQ0eYGZoC+DhapqD5aE5gtIwGHEQHJ49AumTTYNyhy
	 6+WQpTGb62/L5QcTIaPn8B3rBeu9iXpUCIXOHFUuCmAWZj5zDaInwpDzXfZY/db7Yk4A+
	 f7QPSELXSgOgqPTc2Ktdj5iIvxsK9ng8VBe93/YTT+ve2sYWxQbH2fek7CyG6UhYqCsyd
	 aMRJWsX3tWb9tnGKnGlU3CpaYorp6oJG67fqWi9U7hAKPLtmUu+7MmKypKdsp/UgZyx66
	 WU5KYgQPacM15HozDL+Db1ksB0dJVpwwZNJ7eqxIul3pIDQCdWMKCxS3ELnYn/DYWTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788708631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/dxXF/dIRGr0r7M7xjUXsEodojctphE0nON5zEVdevg=;
	b=EJ6HKxR+qsiIJ6otapvyDKygrnc4v+KJab+K6dI9qQ4llRSfhFNKx3c90WoGkk8Tjfvn
	 mPhVaRFCvOf2+0hHCiAHPaQfRobp67PeBvU3ugoIa5ePmsllAy4EE18aPixmell6K5Fo6
	 ZqyaNYDt2cSLaQJHx1SsVrjBiovWt6lQi9yVuPIVDLBW5yJilj2ArkNK4KKIiJBKoZxr4
	 1SkbRfOt/kBWI9YDMrKTT2O0cYRNmLe0pM6/X6IC4OGqP25q0F3MtWa49p8f4GYKXA8Fa
	 u9dDRQx8AutBQTETzam2Poto+kjTcJqnUwtk03gOdZknAKDSGaVOYU7H93Bl5zBWgFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788708631;
	bh=/dxXF/dIRGr0r7M7xjUXsEodojctphE0nON5zEVdevg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DYKL7karvI23WBLCImBDWxxKzsgfndOupfe/hv2Nsk1hQKfAfyUiJL6wymBWMbfAh
	 lXmacPvwoikO+IvQJ24NO5QIhXn5cszVvd/Vpu/QyMraL+UDBUJfVliQ0GPAEm7YiQ
	 bGdYVW6x4CDZJaOlzpcgGXgAoTmrmvprdorSl9Ge/tVSDmOdBOlcMBZArSYUCFfSzJ
	 JsZ6tZ4KtqHuZluDQKWs7ri4T0pmDmOPj+4lM/7oAkodMkGyiXS/98lDmSM1csFfdM
	 7j7pgavxJpuGWuX/MmcfMbg6R4raW3V3tQ/Tc0pPPEosS/mQcoUPFs/K/mU+qYd05L
	 eG6qgBq5SP1nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A1F080B97;
	Sun,  6 Sep 2026 15:30:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CEFB970
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EBCC405B6
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUFM5hoEi-BD for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:30:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BA52D405B5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788708627;
 b=WTASeR6HS/i4Z6YtrcSI/prChwAaliaLaKp0VU367n5xyShrbeV5xgoEdRU/UcxQQ9jr
 6pZ5Zl/f+8pHW8dUKKZDMbjXYtuLM91xqxyMozYNQSYVJGuoMH4Ck9bgO6EL+mYOSrBHJ
 80ForvoSHQgxYuB/d4NZdGInlkWQc6MK3jhUi1i4wqkY1yJ/mXZIF+WA9ZcjndSaXtSRs
 1eHoV9XjiszCvNDX8AYqQlw+w2HsWi29TA6Bg0Rp1QC4iMWF5olHYjpgdnrJGQ6htAEPo
 fn+rqhtYmUSOPeMk3MvDZ+9rSMMCtiMPYYXZKYdRSR7M6nWIclkyweUhdRo3nqNZCvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788708627;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=/dxXF/dIRGr0r7M7xjUXsEodojctphE0nON5zEVdevg=;
 b=Yby4F1+ona5GfDFiQlX+mNn2CMTxY2ztcug/up/dG9KUBdtA5BoNRJzuYAac1f+5Zrka
 hARGe+835jbmzWtoncCFXOBrHm9B+8Xl41e7Pri9osddClMKLHQSMwtTBEqrOUEeUx//S
 RSqFqmexnpnT6QycHfKiRW9TKdVxS7Nw6J0KEboIRwVli2mCxVzobcnD+3ui6BXbNfmaB
 2XKP9EDhfoohrwRwD+usjG3S3lfzX/1krC/rUrv544wHZUa/4Edh6ny4nH0+XRVxh+hGB
 KOpsv4jb3acZ6oBZ7g71RXiMkbP4e1YNX755ijuBAc67NUxW8nTUqtQsbDibYOzIEAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hWtp38CB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hWtp38CB
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA52D405B5
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:26 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso22161545e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788708624; x=1789313424;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dxXF/dIRGr0r7M7xjUXsEodojctphE0nON5zEVdevg=;
 b=hWtp38CBYiUAhQ/5lFjillHzBSMxIis2QLwUgE/DLmWpv/kQNKDGQqGeABPWvBeFTR
 sUj558adhMwY1DP6xxAylXT49CPQAEuQmOz4EUnZhK2SK60K3p3cHe9qEPeionQ7Ka87
 pHOm/KaubbQ+sAk32/4LCdK9/0Hic+hFjYUubvAz4GAny7rr1USa27C0Nb+5ZM7XvtCO
 RAfDbYvdfQ/VNx4A1idPsJaNZjK2wMnQ73ARtybAMs2YhY2ZV1eQP7niLM6xRAeoV2Wu
 XYFUk7qvX3tKi3U+chg+q3qfsHqzpXRNqSpgpCEEJIqcqHXQz2MEYbgdsvcWnJ/vIMzo
 2CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708624; x=1789313424;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/dxXF/dIRGr0r7M7xjUXsEodojctphE0nON5zEVdevg=;
 b=H0XvNutSudp3hEJhc0PFPr73sZn+8Gaj1qwmUrvdMSr2thBFdbNk4UPb71a+UpAkvs
 vKfIR+n6tnFm4mry86nz5zl9FVlubO8VcM5Hex+gCHQVZB33m2DHsYy9rWA8gMncjgvH
 7GgqvGMt5w0QgKi2FlAb6kJ2lcZuoNZoUqIG+GB3xUPG/IHysH0fYE5DH0NCmjUcgkW8
 8wob0u9ZL3QhrH8UmVUpiQ//b4i3NdH1+iW9VQf+aY2SU4wRRQaNuGut7Di99tHxS7ju
 rbCp5slLsGg0XyhRas6cXOaufBx9DU/OPt+XTtvoL8N/1nL6d0rq9jon0yEKJFWnSfYZ
 fZxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh0GECMPkYXI154I8HFpK8zcadGHciqwEeGGC4H+syuPOTZZcai2gTZs7oFUwtNLEylrOlhZg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lE7hTwHAIKeWN6FlYORnb73Xlt1jXVGmf54dWA34KRhTI2YRAg
 a++m6bYsCTCwp8SRBvWopUOvHVVVz2wlYH/3mXmxWp82OlPuH1/b/Fxbs1w2Fl0zQ0g=
X-Gm-Gg: AYBFou2pkjCYJ6TAE2ds2MZozAf1kP9obkv/xbsgV3Lj3K1bu2ybGiPPfYFJ6D/bbNP
 Hoq+0/cXbEt1glPi+98+i49Eb/XM832sJNMOvw50fIlRDOxFV0CiS3sFmfIUVZiT+5Bc1dYtS65
 SIwJIqdyg/p6ZqijFlTBKwV1OPWJKZxc+G+1QR5ud5qSyrX1vwhwYcyRRWG8GNrXkiRrG5cY5ut
 cybRfgIrU6tPYkZR/Uvxq86p3W/z1tOJCKEXjoOloecn4J+zSaRZuOYmZRDmZvJ5BAnmASKjZa1
 JC8X7bMaSxt9nn6Qdt62cLRLrVuH40NxhALGd5bPu+94IzWQu7LH6iuhRIX3KhlUq0xs3fL0nx8
 lfS6HBC+0cp8rmniCVvQIH8zkjTZr6qzM2VrFaTu4qL94zBaam1+t7lN0gg9kcaWyxHVFNpGeOS
 PV3yVFP1Om9eCZy2g8FVF8Hfjl+pF8SHOZzymR+iKYn+nq6AQZ2VTPrnrjY8BCAwM5FeLtbkrEt
 QBhoEOiGmZsFEhq2RM3yQRUke0U8JBOi3hgogNhdpiXu8KRPraD
X-Received: by 2002:a05:600c:8b05:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-49cf82787camr181392535e9.15.1788708624151; 
 Sun, 06 Sep 2026 08:30:24 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm238069605e9.6.2026.09.06.08.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:30:23 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 17:30:18 +0200
Subject: [PATCH v6 1/6] arm: dts: mediatek: prepare Genio 510 and 700
 devices for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-mt8390-spl-v6-1-4d4a11d5741d@baylibre.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
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
 <pablo.sun@mediatek.com>
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
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 96 +++++++++++++++++++++++++++
 board/mediatek/MAINTAINERS                    |  1 +
 4 files changed, 103 insertions(+), 6 deletions(-)

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
index 00000000000..6371f7d5953
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,96 @@
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
+/ {
+	memory@40000000 {
+		/* Preserve the board memory description; the loader initializes DRAM. */
+		bootph-pre-ram;
+	};
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

