Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E9606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lDhhvNsn;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OrejYg8w
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2C4E80E61;
	Mon, 23 Nov 2026 10:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCmMoH35oFfU; Mon, 23 Nov 2026 10:23:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E79A80E16
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429382;
	b=So1gdmtsVnfk3VyiHITabGoLoeBGwzp2hrGbursMA7y8TFImjCd1z9tK6GzyuwRiKUld
	 CXUroj3SXuCftUL+T1SZ/39aAiabg+HEdaHxZssoJqo1RyTlgvFad7FQq0EcSYRFZOjXB
	 N4g8dZogm/SZRByTeV2KDsL7xy+bR5DFFzppnxsCuQ8fvU4MvWQvbEKLrBlC5ZH1oUhhs
	 QVRtGTzoy6ekcrYj4oC4FxPPap2z9bUIiuWiHr2V+pD7+24B8nor3550NrWts2FQrJ8Mb
	 yYKq1k/pNB+mD43QHZ7BKQcvrF80zI9yH1wmNKoTZqcXZxM1enmW5ieNCsi2K+0ix/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lSsoIbHPreP9AObnVjxcanVG82BPxmymFmBUgHApU3Y=;
	b=hM63NGWvKQr8gRTSIa5jHgtVnQDJEhlirQgswkBzSZw+fi5cRyaGd86lz/XF1OthyZUr
	 VWoFBoD8PHu8B0YoIwm235D/lOO7aptXSN6Nk0ZAOVDKUKSvFrF2v+5yFb/QMlX494zyB
	 jJWImSMIVHsLa+srV+uEGfbHrkRhvXhdigTrik3pq7FG+PmILcgQ06ikuo1XQkCpqs967
	 Q8cTfYy5RarLyLLcPMp0N3CRbzlKqDuJvJcnmEJqCYk7/t0vhgY7aYSjwEgD0XXddetvm
	 TZH0qiiKH5qBBurRsN1oPpwj10x6+65yj4x7B63lblzwOljBRO8YQgYXhcw4WP7bYOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OrejYg8w;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429382;
	bh=lSsoIbHPreP9AObnVjxcanVG82BPxmymFmBUgHApU3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDhhvNsnlhuH0m/LL20dhNaTmmsz8ktjZXx8gh5wHLE4ynZfZWr0Gw3MvY+cRZHZ1
	 L1jKI/nBraDk0zhze3mH45ePh/nK5K+zHL1mhJ0DgwBrhwb05JSWKJsz/8etwmswQ+
	 fIbXJAz/e9mq/GlKRzXcwZRbGQXtlAo1O9uFHWZpmF5JIVcps6s2ENni3jQAR0qF2T
	 s5LsoWlmcUiEL30Y/HMiV7aTFo2GsFNTF6L2It/YGhXyc3FGmYYyGqric1OzYR92Wd
	 IanYmbxUNfwtcWWKqeCzTeCcPSoHZPPu0tbgn1hodqdhxcraK4w+IJV9B74ypOVjvs
	 3lTToxeSkXhZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E79A80E16;
	Mon, 23 Nov 2026 10:23:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA22979D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9D1580E18
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BhgE8HD-1RIS for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 957A480E08
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OrejYg8w
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 957A480E08
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:51 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so29745055e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429370; x=1796034170;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSsoIbHPreP9AObnVjxcanVG82BPxmymFmBUgHApU3Y=;
 b=OrejYg8wEUVsMiQ9OMsMWiw0UNHhOUkk7PNj3GTM5rGAx1dvyoDPKQBa9ceAWrDJuq
 XWzAORNRgp1n7hgnqRLYPoGN2+j7ioXH9rqtTz5AiNrdDqiQuxe30yDJ5smNFnD/pOfV
 aIO03PGkfAghQPbgrRWXTXS0hM6cqNg2UIvzU8F9hUarWxMQHMsisqQgxAX5KX5mw9yy
 hzqBcXAQiErXLE+6quntBC7qHFOsGXjciv0ckcmoObpoZySAJHTIK2rJ6m5xteFQBxqz
 R/4NL6SM5wzsIdE8CYg7f+S0P9u4XChG+Xau2uG3B+GLQGxb37w9qAD8cRnyZG5Kj3qp
 wK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429370; x=1796034170;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lSsoIbHPreP9AObnVjxcanVG82BPxmymFmBUgHApU3Y=;
 b=QxWaisSQO20ZEnBxYPwMyIMLOqIDyU5hsHPggO2aEgvHfs3PxY5BbfPJZRCr6AFN8K
 7vDrBkyjYJvGECS4enrl7AnbFDgff1If1MF+BKsBNM3GKgD+nKbO8AtutnYtHsd8IB+E
 WSqmExJ9s7FW2Ea3ekWu1nLEpWHBRxEM0GeZjt+m5d2j6KzxPlNGLcg0iI7mkr8gfaZD
 Qt6cQkC2oJ+vr5JQE7ASCnhbpIKks2ainpfQdCDvtmkGsVGSNoMknsUH3nbGF+6sAbO6
 AAF+arJIKa+FVqSIuynV0m7/4oSWKnJvPRkPPCxewVyisBzbgXL3dQKLB3vE/Rvcz5Tb
 DBDA==
X-Forwarded-Encrypted: i=1;
 AL+hErEerGkPHXA2NbkAuKLqKIG7M2WJtCFP+mSJk3aXDvlDPxFnwgSCyPA03Z/EtWhU+wkaz2lG/XA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/IpuKKaDeS6GtRGt1ipqtvNhf2OY+FejtfFIuVtX83zKWiseyx
 RNmWMtowb8CuZWuSHUGLMts4fDiSqBIzfWDN1J+prD7RsSC8rNG2DcMMFE1KMcKY/lQdPzDVEkq
 G7NLf
X-Gm-Gg: AZFdTZfQxlORw3O9cT00a01ta5FqA7y31QkGjzypZrZG7bA5p9s09sqWs3VBpGaRPBb
 yfB78+6prXkspGWumF0dxGi6xGl5UsxCQL3lVFxxWLRufPuXM3dPsOIvosintaJZC+7uZASASZf
 ARy0oNZTl/X58/wZBKNim1GKbXqAkN3cqpiZ29gP8lJCmzzjW+uWqLfmib6UNq5ySWJhfKgq+2g
 mEiVq/On0AgTLiR5kVIZMv/n/Vmml1hP2JTd1etMD2+Qr1ssJqxHIL9fXks3SX4DlglQm+Th8SJ
 4tYZFFK7kom/sQomyFxBf4kmxc1oDLE+m6PVADUR09tlID5W8ZU9Dx+RxzH9FVJGQrl6jKYXznr
 aeLCf8RMluY/xO/qeetNYYzWtiI2/mIQ3WTYcgxYqtkqBPva9ABOoJAZCRwv8U4Zjz04NxZYlN7
 kq+Eot7OHM68MuhFzZo5MO2LUrTqaMwUxbRL2K97xnphY3BuEiW73ea5B3vjcLf8pCYHXklhhE4
 PBUQfzMyulfjKVQpM86uvdjfSaMNoKJcRDT6vYkxQM61E9QBmi/0g+jotcmZARDxct0GtXt72Ij
 2v/t+Mkd47Ao492AEjNFw38jYoAc4hWgjhDyZMmT80Jms1dY9SFXL3kRQJTWxVY8hnqu1i+3Sft
 cQua6RHvX3as5gEEfqeLMCIpkfBd9cRZ2a/Al3heIS/HQ8q8BlCKPFgjNyXNtbMwyWMQ=
X-Received: by 2002:a05:600c:1d09:b0:4bb:73d5:ab33 with SMTP id
 5b1f17b1804b1-4bb88816acemr242998525e9.22.1795429369724; 
 Mon, 23 Nov 2026 02:22:49 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:49 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:23 +0100
Subject: [PATCH v2 8/8] arm: mediatek: enable I2C4 and I2C5 on the Genio
 520 and 720 EVKs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-8-7d3f843db7ef@baylibre.com>
References: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
In-Reply-To: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Both EVKs have an MT6375 on I2C4 and an RT1715 on I2C5. Enable the
two buses in their shared board devicetree and the U-Boot i2c command
in their common configuration.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common.dtsi | 32 ++++++++++++++++++++++++++++++++
 configs/mt8189.config                 |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 5b06690620..d24277f9cc 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -12,6 +12,8 @@
 
 / {
 	aliases {
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
 		serial0 = &uart0;
 	};
 
@@ -351,7 +353,37 @@
 	};
 };
 
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
 &pio {
+	i2c4_pins: i2c4-pins {
+		pins {
+			pinmux = <PINMUX_GPIO59__FUNC_SCL4>,
+				 <PINMUX_GPIO60__FUNC_SDA4>;
+			bias-pull-up;
+		};
+	};
+
+	i2c5_pins: i2c5-pins {
+		pins {
+			pinmux = <PINMUX_GPIO61__FUNC_SCL5>,
+				 <PINMUX_GPIO62__FUNC_SDA5>;
+			bias-pull-up;
+		};
+	};
+
 	disp_pwm0_pins: disp-pwm0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO29__FUNC_DISP_PWM0>;
diff --git a/configs/mt8189.config b/configs/mt8189.config
index 52d9cfbc4c..2285bc499d 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -17,6 +17,7 @@ CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_UFS=y
@@ -24,6 +25,8 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CLK=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MTK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y

-- 
2.56.1

