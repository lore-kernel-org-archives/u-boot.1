Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF1AC9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB52340EED;
	Wed, 23 Sep 2026 21:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpS_NX6yEu59; Wed, 23 Sep 2026 21:18:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9166C40EF8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790198300;
	b=isdpcmahzV6peYMJTvyiZ7F2EBO38FMQnDKv752UvalWUUAqKFun7V/Vdpty5fae0al7
	 dct8gRFYVFgJrmey0Buwsr9bEkvJynQakw4Wl7bBMcxn4/20KjZOIEp/aHdLKeaJgsrgy
	 yj77g1HdVCFuc3/Dr/Tr1E68MZLKPnU++qPs14+R5VbjbIrjnfGfXYbM4o9Fs5cFvbmCw
	 qAAutTMYK9+l+tV2zzeAT2FAyB7t/Z/dZHBsCSv6w9KQUfCusgIuuRNsDncvPq39jinA9
	 mi5H9PWoxs738qOghkZ28oFwKECcyLFil4HYyZu6GEv8QfrErK1aCxmfqt9qIkpH72w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790198300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=obRPgJToSBHOkvcqfkPfh2x54X4UIQEboyQxanXgkG0=;
	b=WihRSchgYthbx9V1qjw0L8z5QtF7VffuEjS0HSVYamPlYuVhfl+50CNGLPjmutCXYpXP
	 fF0YHznMbdXNhwkKwZqipAifIWcFuh5YYggE6pxE6EXF1xPx0/v+bDqM5P9Dej98Xn8oD
	 ZZuTOCz1esW44+BGR2eSN43mo4RmVV1g/S8c2HzUU60QM9wtJx5XHUPUgEHBXvQG8XZtf
	 tRiIEr1IO2ql835IxRLJbcxqgl8jwINd0mKMBpst/WF/P/auU8zu0WsfoPdyIHtHBoWHL
	 LqEnQ0Wmqd6FQHXcfBzM9lnAQNNQVaODYUjhYKWCb1GHqS7lsX2udgJaIXoLVUa+MXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790198300;
	bh=obRPgJToSBHOkvcqfkPfh2x54X4UIQEboyQxanXgkG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XgWYyJ3STyXVfeZ+h4g59ucxrzWGIyPDU0OgSEjPbCi9lkgWVSKT5QXBdLpDY4Qd/
	 hGiHoKOecDOzWG2l0dgRNoXf9F9jiWNij8CaPgeV6R3eQFrgflmOkrzWpIxkbjLdwr
	 VNWx925ZJJX7EzeaDi1iyJmq8MCPM+QP8jSDO7adzWIaCFS4ib3pABjcjuEKU+XaHO
	 /5NzFVB1Ws2ntnQjBSoLT8996bVqlHiO6l86TMhAVSt7fEyMn6sSpMdW4IQ5O6P/ma
	 vqPVeeRBoZZTHnBnz0rE/ilTrWuhi0fnALih2PG/JUQY14B8od/fU6Jdh7IWNXew9R
	 re1Uf/5h82Qyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9166C40EF8;
	Wed, 23 Sep 2026 21:18:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 070843A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC64A40390
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fl9V_XTzqqzD for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2C65F40270
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790198297;
 b=HZM5NySKCg6Oyd2ySlh2gae4jWJs9BDSnzGYHgWYKVGm+3yjX+St2Wo23J7EUsZRk24u
 JIL9ev1nTvm/556FQ0Qjvd6WcuTIG8CPzCXonmoslE/NDulx00d62hYlNaylpCW97Gkzn
 O3FXPh7//A4G5JHC0uXq5W5scC5W6l51+Gi7JxUP/EfNXiYg4xPAnyMx5N4iH7CnwCwQR
 dFANByoifTRoP96XezvKChL9UYuQfFKOMOu/QDSCEjRXEhT6e68tk3ld8Qoj/WeY+EHHB
 Yh4sb/epgHjP/5Avt6JnZ5tZOfNsTwLa/1Toa7moBzo/7N/FcQrdkkIlwi8mKkZcO0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790198297;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=obRPgJToSBHOkvcqfkPfh2x54X4UIQEboyQxanXgkG0=;
 b=SxDThWV3P93g8S65fmQKoFgh58IikFOxwUE1xj2s+ItE8DGYSkbeMduggQv2ZVEpovnq
 l+WhqkiDRWsa+DIX4A27KVEN7w18tUsgPQf/18VhKevJ5LfNUiSr01PXAgV1OwUF3oiq3
 yYy0UAzkM9fnvu89EpehHRGy6ztkaIzrbQQ+qBOomh2Kf5Y0cwT6H2EkeKIWrzq4BGUzR
 5lggtL9AbytnaKJEGR5RQhhIropAsVZ/UX/KgNEwBbE71fr4AMmb6mhgjkrF5oMtY7bWN
 N0qGlVIsRlGUKVzQNaGNWOgTM+PYpjyRhhvWmla7QfLYomye9NLI7M/LmG6+epPuX8Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Sn6FYzW2; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Sn6FYzW2
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C65F40270
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:15 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so945738f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790198294; x=1790803094;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=obRPgJToSBHOkvcqfkPfh2x54X4UIQEboyQxanXgkG0=;
 b=Sn6FYzW2Jelo2oRvY4spupZ01TB4fvvKgf18hMFXUFBb/qr76m1UmExObrQQvHkrlg
 pDgKX7rHIagU0mLze9+b62x4zpoyicOaBzATD77jjdUJ5iF0ecJCRsaaiWGnijtpbh/L
 r/GGHDBaNtT7ZVJEMhQHxgH9ESvb1OK/M+Tr4+tIYQDt0Tx0JOfnYbBeiZsiCm929ZNB
 E9oKZZDMeD1yHCMqCpHia/J8I9TV0a1d5CSJnU/MbbRzY2AdLOHACQ6y0iIYFdXHde25
 jeSo2m8Qc8ipbuVJW3aptRT/x61D7jn2NvXwEvPp8C4c90pHHbrwd5xMdrwRkWwbL2mi
 cPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790198294; x=1790803094;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=obRPgJToSBHOkvcqfkPfh2x54X4UIQEboyQxanXgkG0=;
 b=XuUEgjdzxUrx4GlKSNByPwWMHofsMslOGdXJL4Xs0Igs6A8fjr2K6MFpQIjv2s4Yp4
 AeWIRKdlLGs32IHO0ew+UTZZsCCaaSTkudks9HiauJ5fl5jGgAHWgbwQsYF3Pqxd2j63
 FWiteiUsDAMuLkp8+koNlPl65svoEqGpGxJfH5jAyDazMtckTWbzzasrUEmSA0fcBydz
 YQ1WYjV1P894M7mlYM3yOVgcak/ghUACjF8WAcoeOfsErwGOixsv0SVBUCnn1VMHQLqf
 2xlWu/aIru1HozkZvCsqlsvxzasTB4UjShuwp8e+gBkfWkU2GzP5Wf4OeIONt77B/HNP
 N7yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ5LYxd4jPkGLTcxWniZiBzX72Og/dWpl51ZbilfJCxHNEeWfgj2NPjU7hUhDHiNvLC8walrw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ldpd/qmQcPJD0/mmBt7NCFyWWVw0gUxJg8Laqzl9TkjIgZKKg3
 hXMTh0M8kmYWVYACLeh7GxzN7zU22qetiXzSy2WYNCXe3WvrXm+u+a6cFdQqVT7mRSY=
X-Gm-Gg: AYBFou3AN/Tu6e7cP9rBFYFqhUeRpVMth2MkuyQzn5v/rLNFBHboo653QkacEvGQ9Lp
 aUPHBDfK8EGDZWIDsCJ3cqpBjXFQMrHdYy8/WfwU8IO+v1kDQyUblmg9V+geVWwPrLqMqeZ0XBz
 ZXMECkZE8/+4O998CDKn1Kk1MnUkRYMlzoOa0aeEjoz8Tx3wG6Vs7PNCnifrAylAGj+DK+b9ql7
 ciuRzdmGJTJVzEgVe9xJ3lck+AROPwr2ywZw/nqXzYVSshyq1TS7dNIRoWGxXNdo/qoPRkxW4hz
 VxsAmuPynUUDLaY35HbCbqEc93wV2BMGbw3Abuo7Y1HNgP9S7mPboLUOlG2xwtCNoRCZTutK5SQ
 qzYSsWlJH1iE+JHbN5BwIhiMrmH/TIm7LkfCNM5Il8GipHhXF86obxZKM1CEmtMfvB3fGB8QCRH
 C20x4BcxDS9dEeuxejjpgL7i79n91wyzC6pT2TA9M+taFNNoRPrIu80IkCCePbHo8W3BJIhOx7O
 5B0LF0nWQoZ0nWkWNNnTVRtBlut8Alo0df38y9UM8z6yEjKfN5ADisyGuBG9UWR8pc+od0mDQ==
X-Received: by 2002:a05:6000:992:b0:487:780:6a27 with SMTP id
 ffacd0b85a97d-488716c4862mr728384f8f.19.1790198293609; 
 Wed, 23 Sep 2026 14:18:13 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488687791cdsm8684345f8f.22.2026.09.23.14.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:18:13 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 23 Sep 2026 23:17:42 +0200
Subject: [PATCH v2 1/3] arm: mediatek: enable SPL fastboot DAs on Genio 510
 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ccaione-upstream-mt8390-da-v2-1-8f264678ac29@baylibre.com>
References: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
In-Reply-To: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Carlo Caione <ccaione@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
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

From: Julien Masson <jmasson@baylibre.com>

Genio 510 and 700 need a way to provision blank eMMC and recover from
unusable boot firmware without relying on the installed bootloader.
Add a BootROM-loaded fastboot agent that also prepares the eMMC boot
settings so newly flashed firmware can boot.

U-Boot proper is preferred when the complete agent fits BootROM's SRAM
download area before DRAM initialization. Provide the SPL alternative
for tighter payload budgets, avoiding the space required by BL31 and
U-Boot proper. An external DDR loader is still required.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           | 61 +++++++++++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 17 ++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  2 +-
 arch/arm/mach-mediatek/Kconfig                     | 28 +++++++++
 arch/arm/mach-mediatek/Makefile                    |  3 +
 arch/arm/mach-mediatek/spl_fastboot.c              | 68 ++++++++++++++++++++++
 board/mediatek/MAINTAINERS                         |  5 ++
 common/spl/Kconfig                                 |  2 +-
 configs/mt8370-genio-da-spl-fastboot.config        | 21 +++++++
 configs/mt8370-genio-da.config                     | 12 ++++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
 drivers/usb/mtu3/mtu3_core.c                       |  5 +-
 15 files changed, 233 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 10b9a142f37..2ee7fb1f40c 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8370-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
new file mode 100644
index 00000000000..9d0d057cfc9
--- /dev/null
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+/*
+ * Download agents (DAs) run from RAM to provision or recover eMMC.
+ * Both variants expose USB0 as a peripheral and leave unused USB
+ * controllers disabled, independently of the normal boot USB setup.
+ */
+
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-da-binman-u-boot.dtsi"
+
+&ssusb0 {
+	dr_mode = "peripheral";
+};
+
+&ssusb1 {
+	status = "disabled";
+};
+
+&ssusb2 {
+	status = "disabled";
+};
+
+/* Only the SPL fastboot variant needs these USB dependencies in SPL. */
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
+&pericfg_ao {
+	bootph-pre-ram;
+};
+
+&ssusb0 {
+	bootph-pre-ram;
+};
+
+&u3phy0 {
+	bootph-pre-ram;
+};
+
+&u2port0 {
+	bootph-pre-ram;
+};
+
+&usb_default_pins {
+	bootph-pre-ram;
+
+	pins-iddig {
+		bootph-pre-ram;
+	};
+
+	pins-valid {
+		bootph-pre-ram;
+	};
+
+	pins-vbus {
+		bootph-pre-ram;
+	};
+};
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 6230b016ca0..4fedbda9b3f 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8370-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
new file mode 100644
index 00000000000..9627785cc56
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&binman {
+	da: da {
+		filename = "da.bin";
+		pad-byte = <0>;
+
+/* DA authentication is handled by the BootROM download tooling. */
+#define MTK_GENIO_SPL_NO_FIT_KEYS
+#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+#undef MTK_GENIO_SPL_NO_FIT_KEYS
+	};
+};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
index 2dd13d261a0..6c99d0926c4 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -12,7 +12,7 @@ ddr-loader {
 	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
 };
 
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#if defined(CONFIG_SPL_FIT_SIGNATURE) && !defined(MTK_GENIO_SPL_NO_FIT_KEYS)
 u-boot-spl {
 	type = "section";
 	size = <CONFIG_SPL_MAX_SIZE>;
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e572cfe8571..eece6456e43 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -249,6 +249,34 @@ config MTK_GENIO_BL31_LOAD_ADDR
 
 endif
 
+config MTK_BROM_DOWNLOAD_AGENT
+	bool
+	depends on TARGET_MT8188 && SPL
+	select BINMAN
+	select MTK_GENIO_IMAGE_CONTRACT
+
+choice
+	prompt "MediaTek BootROM download agent"
+	optional
+	depends on TARGET_MT8188 && SPL && SUPPORT_EMMC_BOOT
+	depends on !MTK_GENIO_BOOT_IMAGES
+	help
+	  Select where to run fastboot after the BootROM downloads the agent
+	  into RAM. Leave this disabled for normal storage boot.
+	  Download agents cannot also build the normal storage-boot images.
+
+config MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
+	bool "Run download-agent fastboot from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	select MTK_BROM_DOWNLOAD_AGENT
+	select SPL_BOARD_INIT
+	help
+	  Build an SPL which enters USB fastboot after the MediaTek BootROM
+	  downloads it into RAM. The download agent also configures the eMMC
+	  boot partition so that a newly flashed board can boot normally.
+
+endchoice
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..2a371664d1d 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,9 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+ifdef CONFIG_XPL_BUILD
+obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= spl_fastboot.o
+endif
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/spl_fastboot.c b/arch/arm/mach-mediatek/spl_fastboot.c
new file mode 100644
index 00000000000..73744946314
--- /dev/null
+++ b/arch/arm/mach-mediatek/spl_fastboot.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <dm/uclass.h>
+#include <fastboot.h>
+#include <mmc.h>
+#include <stdio.h>
+#include <linux/errno.h>
+
+static int mtk_mmc_boot_prepare(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	int ret;
+
+	/* No storage loader has run yet, so probe the device here. */
+	ret = uclass_get_device_by_seq(UCLASS_MMC,
+				       CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV), &dev);
+	if (ret) {
+		printf("Cannot load MMC device: %d\n", ret);
+		return ret;
+	}
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	ret = mmc_init(mmc);
+	if (ret) {
+		printf("MMC init failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable BOOT1 and boot acknowledgment for normal BootROM startup. */
+	ret = mmc_set_part_conf(mmc, 1, 1, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot partition: %d\n", ret);
+
+	/* Reset to x1 SDR, backward-compatible timing for each boot. */
+	ret = mmc_set_boot_bus_width(mmc, 0, 0, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot bus: %d\n", ret);
+
+	if (!mmc->ext_csd[EXT_CSD_RST_N_FUNCTION]) {
+		ret = mmc_set_rst_n_function(mmc, 1);
+		if (ret)
+			printf("Cannot enable the eMMC reset function: %d\n", ret);
+	}
+
+	return 0;
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	ret = mtk_mmc_boot_prepare();
+	if (ret)
+		printf("MMC boot preparation failed: %d\n", ret);
+
+	puts("Waiting for fastboot commands...\n");
+	ret = fastboot_usb_run(0, NULL, 0);
+	if (ret)
+		printf("Fastboot failed: %d\n", ret);
+}
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 20befdba0e2..61fefcf9a34 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -18,13 +18,18 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
+F:	arch/arm/dts/mt8370-genio-da-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	configs/mt8370-genio-da-spl-fastboot.config
+F:	configs/mt8370-genio-da.config
 F:	configs/mt8188.config
+F:	configs/mt8370_genio_510_evk_da_spl_defconfig
 F:	configs/mt8370_genio_510_evk_defconfig
+F:	configs/mt8390_genio_700_evk_da_spl_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
 F:	doc/board/mediatek/mt8188-genio-evk.rst
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 9bce4ab3955..c6fa647670b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -194,7 +194,7 @@ config SPL_SHOW_ERRORS
 config SPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in SPL"
 	depends on SPL_FRAMEWORK && BINMAN
-	default n if MTK_GENIO_BOOT_IMAGES
+	default n if MTK_GENIO_IMAGE_CONTRACT
 	default y
 	help
 	  This enables use of symbols in SPL which refer to other entries in
diff --git a/configs/mt8370-genio-da-spl-fastboot.config b/configs/mt8370-genio-da-spl-fastboot.config
new file mode 100644
index 00000000000..6ba12f7d282
--- /dev/null
+++ b/configs/mt8370-genio-da-spl-fastboot.config
@@ -0,0 +1,21 @@
+#include <configs/mt8370-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
+# dlmalloc also caps individual SPL allocations at SYS_MALLOC_LEN.
+CONFIG_SYS_MALLOC_LEN=0x1000000
+# Resume from the user-area FIT after fastboot continue.
+CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
+CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=0
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_USB_MTU3=y
+CONFIG_SPL_FASTBOOT=y
+CONFIG_SPL_FASTBOOT_REBOOT=y
+CONFIG_SPL_FASTBOOT_FLASH_MMC=y
+CONFIG_SPL_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
diff --git a/configs/mt8370-genio-da.config b/configs/mt8370-genio-da.config
new file mode 100644
index 00000000000..46cb42b37ba
--- /dev/null
+++ b/configs/mt8370-genio-da.config
@@ -0,0 +1,12 @@
+# USB identity and transfer buffer shared by both download-agent modes.
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
+CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
+CONFIG_FASTBOOT_BUF_ADDR=0x65000000
+CONFIG_FASTBOOT_BUF_SIZE=0x15000000
diff --git a/configs/mt8370_genio_510_evk_da_spl_defconfig b/configs/mt8370_genio_510_evk_da_spl_defconfig
new file mode 100644
index 00000000000..bb537616b53
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8370-genio-da-spl-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_spl_defconfig b/configs/mt8390_genio_700_evk_da_spl_defconfig
new file mode 100644
index 00000000000..7f1ba02c6e7
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8370-genio-da-spl-fastboot.config>
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index f296a72cf18..d8ef6e6afba 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -843,7 +843,10 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 	mtu->mac_base = ssusb->mac_base;
 	mtu->ssusb = ssusb;
 	mtu->max_speed = usb_get_maximum_speed(dev_ofnode(ssusb->dev));
-	mtu->force_vbus = dev_read_bool(ssusb->dev, "mediatek,force-vbus");
+	/* Fixed peripheral mode must not depend on OTG session detection. */
+	mtu->force_vbus =
+		usb_get_dr_mode(dev_ofnode(ssusb->dev)) == USB_DR_MODE_PERIPHERAL ||
+		dev_read_bool(ssusb->dev, "mediatek,force-vbus");
 
 	ret = mtu3_hw_init(mtu);
 	if (ret) {

-- 
2.55.0

