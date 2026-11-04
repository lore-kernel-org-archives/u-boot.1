Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A179606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gKUaYhb4;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=XpzCnM2e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06F704077C;
	Wed,  4 Nov 2026 08:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id haGS_718f3tB; Wed,  4 Nov 2026 08:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B51D4078E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782299;
	b=hyUUjIPiSpFMNNblSqkhQbchvRDWjxX4V5ulJ0nzPuiYySbi0mzh6xG5Jl4fJPaCpwzB
	 9zN4YAEXyAyw/JQTsO4AhaZd6Es0ZAv75cNOxvFrw/XW96eAlfg37+W899PlC1tehs0G+
	 pmLkqRoaO3awTShjV92bbT5PaNeeRCTiRy3vYGXvdmkP2Pxoj6ZzlT+QFqqM0mCqAK8GI
	 EmCzU0i5l1fNE7VWE8++wMmmlL2ohf2AXN/rXDPs7vl/zcPMbiZfZBpNt8ZYlaWuhKEyL
	 70Sb2O17Y2g0fK2HOuRrnXHt3axOmBUreCZ/Vu8vroW+C36IcWFT/SjbRDktvU+1w5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/n45Zt/R3fLkAImpDHmkl6eZq2hLjuT4DZoBbMyjPTY=;
	b=sPSCbaVINXvsDMqAsSj0LnJHw3qxTv3nRoS7h3WuPAFGGrG4NdHpbl6ley3VrT1X7Coy
	 aXzxBFnFm8bSMeW+tpMgg52tN+6IBB8hnh68xVU/5fzLfkky5SxmmrFCxxNbcb9RNnk7Q
	 NgaPqYyYnjE3oOEKqPredShFnrBPU0Zp89ytjdkWCO7veXthw/JBsJhhNCQwBHCNn75oG
	 fl5MPAIqOFjb06AVyPKOQqz1j2rkBKk+rIQHVAAt4QNz8nnNdow9zRZh8M7/Rkcg3znhE
	 mOQJribpj6BpOfSW7kFx64IptZ1IyjBHlqQh4HmMy0z7cMZBOi7tVPkod+/Us8TK5OQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782299;
	bh=/n45Zt/R3fLkAImpDHmkl6eZq2hLjuT4DZoBbMyjPTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gKUaYhb4IGzwjFo89FxYtzKWQjCcHz5xC6oohgkELrm6hycp3cBFkPPoZCIuokI+2
	 tgGgYRmoaM2BKNzm+bPQxPjXxeQeWVo2yP2MS+Y2VTE734J23n8eilRRj60DuTAgG0
	 wFMraOlcoybJ1JAseeYuWj+1o3XPf/MBopeTNIfSYhWqb7s1+VF48SB0BBynbb9z7C
	 Y7aswMdi5XjikgmtYyrv/sqMQUAQ9yf7mDIHLa2HaiEg3YHv+Fdh45uyD5km/kTHmM
	 8I7KQy+KlGlbl2Bm4K/I4AwMSowQqKRqg+kQZlMhX/DvQ7KGIu2spJap15+1ab7Cm8
	 aSEJv1udv9v3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B51D4078E;
	Wed,  4 Nov 2026 08:51:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83294A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74BB7401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzjY44vJ6eHq for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 31EDF4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782296;
 b=G74UXjIEiRYU9o30rD+JYW0ExH3hkyAR42Z75sfJl/XgMpkPa2P5NmmT5rDATMoFplWU
 ibn1V9LmmFbiofeilKdH4qGo1MUQWTLO0jlw1nDEap1nJxrqCq6nuLwjuLzRgQ9UbRo4n
 SMeSVDx10c5zCeEjRv90oI0iwzj8glLnJHn2SOj4UH7PkJ51QAvkSMKc6HTv7J20yXrwk
 V/a/RPGvw5GMHlXlMQn/46IsYHF2I0Elf/doex2vBBW/lahyc60w1+3hzgNg7FmjB3oRy
 a8Bx79yqCItI0vafVZ52yN6kqDThBB5O5QqGdgFafBnvlABG5bobpYnVT6PCN7BGM2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782296;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=/n45Zt/R3fLkAImpDHmkl6eZq2hLjuT4DZoBbMyjPTY=;
 b=QRX7zUiFMSn2fmYm6JOPedH+heWIv8fFnkX+T3LOrspV68LnLLifdUmtWsAQaUxUBQZA
 OnMUCqVhTu4nZaJqnR+eAIC98P8413AzrzQa6OjrjisvJVQ2b52Mq6lc/KYhn3nLpbPr1
 cl0vZXc2qr8U+4qRskuKp3tWC89RRwaf9hZu0wTdyhnbfJEf2hG3P1Jc8i6wImimS5qPc
 5GoVhaNi/jmgHw51Mr6W+f+kqZTsMjKaQlz+Q4+awNf3nYsfdrmi6UNJMvE7yB1FsDczi
 Qx3cSGOR4YNvez1yPrGYYIhAcFUWJHGI8q5jSl1i3qDud0mNtH2aQ37PVipGxk+46IQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=XpzCnM2e; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=XpzCnM2e
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31EDF4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:35 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so230959f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782294; x=1794387094;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/n45Zt/R3fLkAImpDHmkl6eZq2hLjuT4DZoBbMyjPTY=;
 b=XpzCnM2eNqXrU5WHgIrXgSPYK6HaT6sa1lHxJkyY/ZhahNguHnJEgO/fFRrmInNdxM
 ikDruN6Xiw0u4vamivX0dRLE31VsaLR1J/wMCYBx04C+nhh+xp4sj0RyYaBT43ICWbfh
 vvx0enyJQu4snX3a4cuAD1Sp4IiNPMQmy9kk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782294; x=1794387094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/n45Zt/R3fLkAImpDHmkl6eZq2hLjuT4DZoBbMyjPTY=;
 b=wtHx4UJjw/Gl8niwjzEPaRo6HEGW9x3PzzBxsYWOKMmczdjG1CW3PNn7h5x+DVLcc+
 dkotFY6VRjXFKkVNlHLPEwbweDyUY1EiZWReJdOVJ4m/Z1mlAidp93l9yft6/MoEy452
 uXTXf0UTyngqtGDPIvpZXN7Erg6hF7kZ3JwL7D3z2kOjbeEwmOoccElsy6ONBE3LFqfh
 su5gYYweITqMwGVha72+PirVIoZr63skF7Y3BsmCHwWPcRdaOpePf3NBw0/09796dbez
 +AKUSZyZ1QEpNub59U8TF3/hugGM7EuhSVsGWwk/5+CIjgazciknCcuk4RXe0+OKtjsP
 gsIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzv1zdu8dVAxLWOcn2TH7tHJ0Hsxll6pm8MF/vZlSzYyWjL2mTuuyNTkuR1lzzy3ATRGnDUzmQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/aZgqqUMORc/OmOl1qtNeRbbnh8q/07hXKzyx2baqlptT1mPcY
 SaYyMSTlc/8or48Qua4DyIk1LGAlaXEnkQJF1ZAoFXT8MarmFp8+UB5GGp3sjJk8NiQ=
X-Gm-Gg: AYBFou2OCE0bsUcYTCFtKukLAbbPM6i/Pu9OosDcwpSbXCkRx8JIsBZcIZqMcb4x1IM
 kZfASt0KgLNlw/OsCA9QWD9Kp66khzGVNtqnWH/SjWk/At1v9rhHjJ8Le+925qJA3juypeoAKAg
 FpWSOBpcVQMf569dp+7Kr8cs7JFpLVKUALkGmMpX+4piTbXgbLVt/RkbPjq2HHMMrOVKtPRgqlv
 DEy8/78XY5oQKMFiQnBLl6HagKTw+xg/YuNqrWqaiCG/4jTBZmue9kavuqOn3jkrcQWYZ7NzjJ5
 sGaQojg8H95Yn+4ZY2dn+Ofr91MCdZG/vwiM0yOHHjAHQM5LxIx9PdHI1tmLhGLl5zC5Wf2x1IS
 hfGHAT9smlfG8AoeExVIOn/0nGYnUeASsDZBzHcxG/xulVKyPMZOSYJuoChkzP6C/Xa0s/iq0jx
 1n9n0nRcd0wK13ZRNgUsJDxeE+gu6mvQHfaHyZ/UwiIpIHgFMxh9cXgP/1xnFUS1otfwriNLsOL
 4M0HnfrPsvHhwEHuB4fJpU4vYFkQJifT8UvwYL5F0UqfJPlyNv4CTn0ltlbtThq8pUd/BYnJL29
 Jfi2jsTLyl0MFEfT7u1TbrRDs+CX9Vwm7vz4Bx7c/AW/PiW7M6rGxlhLCpNHrBeGDi4vVXet9AN
 8nV7x/pu0XKMRsEZu3Dbm1uLrai8=
X-Received: by 2002:a05:600c:8b55:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4ac17b2b023mr381036125e9.19.1793782293822; 
 Wed, 04 Nov 2026 00:51:33 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:33 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 14/33] arm64: dts: st: support Engicam MicroGEA-STM32MP257 SoM
Date: Wed,  4 Nov 2026 09:49:47 +0100
Message-ID: <20261104085036.4012238-15-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Support Engicam MicroGEA-STM32MP257 SoM with:

 - 8 GB eMMC Flash
 - 2 GB LPDDR4 DRAM

The SoM also provides an Ethernet MAC, but Ethernet support is not
enabled at this stage due to a known silicon limitation documented in
[1].

This corresponds to section 2.21.2 ("ETH1 RMII mode could have CRC
errors"), where CRC errors may occur in ETH1 RMII direct mode when
directly connected to I/Os.

The workaround requires use of the Ethernet switch (ETHSW), which
introduces additional DT bindings and topology complexity. This is
intended to be addressed in a separate patch series.

[1] https://www.st.com/resource/en/errata_sheet/es0598-stm32mp23xx25xx-device-errata-stmicroelectronics.pdf

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-15-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: c5ce8d7bcc787c8aa4896629c14fe7b837c78ec6 ]

(cherry picked from commit 64dbd1de4f75d254211eae12b8ed6318d2e830e4)
---

 .../arm64/st/stm32mp257-engicam-microgea.dtsi | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi

diff --git a/dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi b/dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi
new file mode 100644
index 000000000000..5b4287e86def
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/st,stm32mp25-regulator.h>
+#include "stm32mp257.dtsi"
+#include "stm32mp25-pinctrl.dtsi"
+#include "stm32mp25xxai-pinctrl.dtsi"
+
+/ {
+	model = "Engicam MicroGEA STM32MP257 SoM";
+	compatible = "engicam,microgea-stm32mp257", "st,stm32mp257";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+};
+
+&scmi_regu {
+	scmi_vddio1: regulator@0 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	scmi_vddcore: regulator@b {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK2>;
+		regulator-name = "vddcore";
+	};
+	scmi_v1v8: regulator@e {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK5>;
+		regulator-name = "v1v8";
+	};
+	scmi_v3v3: regulator@10 {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK7>;
+		regulator-name = "v3v3";
+	};
+	scmi_vdd3v3_usb: regulator@14 {
+		reg = <VOLTD_SCMI_STPMIC2_LDO4>;
+		regulator-name = "vdd3v3_usb";
+	};
+};
+
+/* eMMC */
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+	bus-width = <8>;
+	vmmc-supply = <&scmi_v3v3>;
+	vqmmc-supply = <&scmi_vddio2>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
-- 
2.43.0

