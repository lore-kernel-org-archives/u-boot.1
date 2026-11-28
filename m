Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DC606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O+M+GJ/6;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=anM1G2NZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36A93810D0;
	Sat, 28 Nov 2026 13:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PRl5jqTsQyIC; Sat, 28 Nov 2026 13:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D67A1810A8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871515;
	b=N8I6PSQR4zhrw9wmPoNEdeU10NefC1N6Et1zHA31fhslbpAq2Jogc67NRpi0KbK2Kf/I
	 Z5koqQFU0deFXz7QcQyWjoa6/udlCz2BBfp+1G/XBN+1orfS8KUASMxUchDiFt4Ozmk6U
	 M2zvmSF8kh8bdiToAiD1Dmjvldmq6ecbulaN/pTFjLwevyguAM8KpC3T54EYdqmQkre0A
	 /CrBpySDeZzXYl/JpaC+muqGlEuDIj3w4353HsiC2neSQtcm51wdbRUdlt7cEa4AUJ5eE
	 0WkRAaGB+qlr9NG3CF3PXFJzxeoSrPc5Jx83XERYTQH5U30klEJmyTkR6hwwZ4Aej1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871515;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fJG+SY80IKQjKhoqPH+1C9bBVUCowaqerSlez/bj1Cg=;
	b=Uiz9K0ODi8pJAYDsOXahTrYaSfYV06pmaEPNx8g/LruEy5c4r238KvOvwwbrN+eHza8F
	 djNjj/+ngGwzUK0rY8RfyFLeLPm6wbLdNQnWf3hd1X3l+CcGYXJ+cJxYadEqmaE1BlJK5
	 WhTrDRuvjVmbsfna0ZoLgBBWsc0SYpzf0Cx6tncW6JrzgKnG/mxn6xyIy6N+a2qwngPVc
	 1ek8sVQzUS8Lj8LcWBGAKiFBhHE+E2yY/cmEMC4mBByEcGRDIOelQpjKKwXosDVShgoHu
	 Az+iE22Z1bZq4ztsgUrU6Eb2Aa/6pVGo26i8Ge75PMjS76Z4SKTeGDiHHPtt5H8XKvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871515;
	bh=fJG+SY80IKQjKhoqPH+1C9bBVUCowaqerSlez/bj1Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+M+GJ/6MFD9t0qjC9O7D/PPggr9vJKpBFrYFXx18d2Q0sLRCbR2RNYAQducM3A/B
	 WaqhH5sLuGHzZ+djP05mf0tJ1sB/ChnXCkvhW8BjDuoOExnpXotGFW59hvZrtZDRKH
	 NpKZzXVsV6Yc0OQo0nXyER7hNgDJjWGPNilDgOQwtkh89G/7GEBHDThNYdahlsV+jo
	 RVwdI2wdIodaaGAmI03OJeaVYl3vY+52a3ffGapltdfnxAsvOInaxOuZY6XBmqitJk
	 w/uQhhZoPHEnANi8wA+2ayWx21jcQxo0PjvCKVNe+EEIoX3JAiyPpaAhxKJaDu+Vgz
	 IyZiG2gR/PgYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D67A1810A8;
	Sat, 28 Nov 2026 13:11:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 82E8ABF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8004E400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EjWaCucA5CPj for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5C0594005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=anM1G2NZ
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C0594005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:44 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so61077035e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871503; x=1796476303;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJG+SY80IKQjKhoqPH+1C9bBVUCowaqerSlez/bj1Cg=;
 b=anM1G2NZYetcwHV/UWmzGi8HLGS5opArBUjB1onLKwKHk8W+7TShYnrBnE2TSb8ji4
 MZMUciciIQgDJp7r6lUZdhWTPn/rSun/cdLb56z5h/bO+5Cv5ZLh43Er2uYjITBhD2pE
 sCgvNOfdy7YzVo/sowDhxJeSbp1Lkfa6RRZz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871503; x=1796476303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJG+SY80IKQjKhoqPH+1C9bBVUCowaqerSlez/bj1Cg=;
 b=esDkf1EIKLy98GvmikV2tOtsKSDiDeSZalB+UJD7WxI87Azz/4HyCLy3oLf7L6FOut
 IuwGF/RJCQ7LPRuEbaGRxTtcoftt+BAGYMQoh9NyW52wtVptwSVKxZuRYUxa6C900FYJ
 oIBE+vZCA+0yNVrY7oke/1kUB9YlM1h0IO+0ImRga/jkmOScmVQAUC/28RG/abY8QwrZ
 B6+IwOIAE486o0yVl6x8BU4kUrjt+U5InqCEZrFCufM99VMz4ACUHkHebRO9FEnw9aCG
 E3W3quB6Ek9FZjWOm9bWDH2QAW/6hmQLTEHjd+Sb3CxIflkPIyxspAiEekN6DZvK0QSo
 wQtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFrwojhPZnWhj7v5XGeKDQUerEu5Fte3oFw7mcnikBmWy6xP+433Rt2scbFO4EUkl+VUuVZUB4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+o/iMOLUvpmbaAzLM0wKImmXaHiifs316NqiajoB3RtgXDc/Zg
 JNt8MV3IKx9CGrR+/9MXN/gnw0plZhJ0l1UI1WktrKFnANpIEqcNdFxBA0d+nj3cG3w=
X-Gm-Gg: AZFdTZd2/PJLbI36gudxGLA5pagA18oXgArO5ladEKHsY2u0ytrdS6HtKP/pglj340l
 Ou8yoIll/SGWUstlkUBMuIQ9xgqHAlzpi+nWyT8mzRbkuZae0x7FEx3neVj28kRL/NWWaCzNu94
 zGMHuM42E/yZM9Xz9i4kqFnpD5pT4eqSzdg33O/UnEeFrwrPxYszEJFNqBijsMn5Ye0JaH5JZP7
 DgLipg+uYo1pdWY3Lu5KsV8RpmfPuk4kK2WGBemQhcUSK3TC+93Aa9p9yYzYl4Z0gGFvlXnTXtT
 NCi6nNj9gXRY08PU8euXoJK3ub0ao/yHAJqe1UyBh4I86uXgNQ9lFHnWeLMZe/d2g3jACMHR6D/
 7k01zLN67OOF1F9s016o0bwwcUSNkfCOJfIkeF/GzXsDp4F+PNVRFZ0dDyoJ/W2gghaCdZqfzal
 J+cz85/htqBGxxTI+xj7kU32kvgD5e3zL9nJTi4HogQ7YkW6KjdaDuSaEPyW/BHzidbdQ2Cn4dX
 RZKZpa6y9eJZf7l8nK2o9Hm8aoF3vkgIMND+DLLBH0Zbm2Y+WtnRgwaCV5texcH1nsd4UJMLQXg
 3kJ4Nd1KufGTYgROWAu6QeSsVfSRzde803NGOt0+lAl1FYT7aWiiwAzHI2T4D+OoIh59AB9nqwt
 i45Mt7ju0utYWH9tEtweSYXFWiBSbELvwVfGfnjKKlJ7x7+PrCCwhhuzzo5MSXzciqa7zenz3Ek
 VVk+v+FtH31Ejj912ZF0gD/4/hnQ==
X-Received: by 2002:a05:600c:8888:b0:4bb:aa4f:c022 with SMTP id
 5b1f17b1804b1-4bbaa4fc136mr155963185e9.2.1795871503136; 
 Sat, 28 Nov 2026 05:11:43 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:42 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 07/29] arm64: dts: st: add ltdc pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:24 +0100
Message-ID: <20261128131125.2141352-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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

Add the LTDC pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-8-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 0183a9f7ba2de9fc9c1e0ee53e4cc7b049e69181 ]

(cherry picked from commit 24128ab8c8a3c29003deb325424d39d31ee08165)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index db485b9ed904..50f454630cf2 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -260,6 +260,77 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	ltdc_pins_a: ltdc-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C',  6, AF14)>, /* LCD_CLK */
+				 <STM32_PINMUX('G',  2, AF13)>, /* LCD_HSYNC */
+				 <STM32_PINMUX('G',  1, AF13)>, /* LCD_VSYNC */
+				 <STM32_PINMUX('C',  5, AF14)>, /* LCD_DE */
+				 <STM32_PINMUX('H',  4, AF10)>, /* LCD_R0 */
+				 <STM32_PINMUX('F',  7, AF13)>, /* LCD_R1 */
+				 <STM32_PINMUX('C', 11, AF13)>, /* LCD_R2 */
+				 <STM32_PINMUX('A',  1, AF11)>, /* LCD_R3 */
+				 <STM32_PINMUX('B', 15, AF13)>, /* LCD_R4 */
+				 <STM32_PINMUX('G',  3, AF13)>, /* LCD_R5 */
+				 <STM32_PINMUX('A', 10, AF12)>, /* LCD_R6 */
+				 <STM32_PINMUX('G',  7, AF13)>, /* LCD_R7 */
+				 <STM32_PINMUX('F',  8, AF13)>, /* LCD_G0 */
+				 <STM32_PINMUX('H',  5, AF10)>, /* LCD_G1 */
+				 <STM32_PINMUX('C',  9, AF13)>, /* LCD_G2 */
+				 <STM32_PINMUX('C', 10, AF13)>, /* LCD_G3 */
+				 <STM32_PINMUX('A',  6, AF10)>, /* LCD_G4 */
+				 <STM32_PINMUX('G', 11, AF13)>, /* LCD_G5 */
+				 <STM32_PINMUX('G', 12, AF13)>, /* LCD_G6 */
+				 <STM32_PINMUX('A',  9, AF12)>, /* LCD_G7 */
+				 <STM32_PINMUX('F',  6, AF13)>, /* LCD_B0 */
+				 <STM32_PINMUX('A',  3, AF11)>, /* LCD_B1 */
+				 <STM32_PINMUX('G', 15, AF13)>, /* LCD_B2 */
+				 <STM32_PINMUX('I',  0, AF13)>, /* LCD_B3 */
+				 <STM32_PINMUX('I',  1, AF13)>, /* LCD_B4 */
+				 <STM32_PINMUX('A',  7, AF10)>, /* LCD_B5 */
+				 <STM32_PINMUX('F',  5, AF13)>, /* LCD_B6 */
+				 <STM32_PINMUX('I',  4, AF13)>; /* LCD_B7 */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+	};
+
+	/omit-if-no-ref/
+	ltdc_sleep_pins_a: ltdc-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C',  6, ANALOG)>, /* LCD_CLK */
+				 <STM32_PINMUX('G',  2, ANALOG)>, /* LCD_HSYNC */
+				 <STM32_PINMUX('G',  1, ANALOG)>, /* LCD_VSYNC */
+				 <STM32_PINMUX('C',  5, ANALOG)>, /* LCD_DE */
+				 <STM32_PINMUX('H',  4, ANALOG)>, /* LCD_R0 */
+				 <STM32_PINMUX('F',  7, ANALOG)>, /* LCD_R1 */
+				 <STM32_PINMUX('C', 11, ANALOG)>, /* LCD_R2 */
+				 <STM32_PINMUX('A',  1, ANALOG)>, /* LCD_R3 */
+				 <STM32_PINMUX('B', 15, ANALOG)>, /* LCD_R4 */
+				 <STM32_PINMUX('G',  3, ANALOG)>, /* LCD_R5 */
+				 <STM32_PINMUX('A', 10, ANALOG)>, /* LCD_R6 */
+				 <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_R7 */
+				 <STM32_PINMUX('F',  8, ANALOG)>, /* LCD_G0 */
+				 <STM32_PINMUX('H',  5, ANALOG)>, /* LCD_G1 */
+				 <STM32_PINMUX('C',  9, ANALOG)>, /* LCD_G2 */
+				 <STM32_PINMUX('C', 10, ANALOG)>, /* LCD_G3 */
+				 <STM32_PINMUX('A',  6, ANALOG)>, /* LCD_G4 */
+				 <STM32_PINMUX('G', 11, ANALOG)>, /* LCD_G5 */
+				 <STM32_PINMUX('G', 12, ANALOG)>, /* LCD_G6 */
+				 <STM32_PINMUX('A',  9, ANALOG)>, /* LCD_G7 */
+				 <STM32_PINMUX('F',  6, ANALOG)>, /* LCD_B0 */
+				 <STM32_PINMUX('A',  3, ANALOG)>, /* LCD_B1 */
+				 <STM32_PINMUX('G', 15, ANALOG)>, /* LCD_B2 */
+				 <STM32_PINMUX('I',  0, ANALOG)>, /* LCD_B3 */
+				 <STM32_PINMUX('I',  1, ANALOG)>, /* LCD_B4 */
+				 <STM32_PINMUX('A',  7, ANALOG)>, /* LCD_B5 */
+				 <STM32_PINMUX('F',  5, ANALOG)>, /* LCD_B6 */
+				 <STM32_PINMUX('I',  4, ANALOG)>; /* LCD_B7 */
+		};
+	};
+
 	/omit-if-no-ref/
 	ospi_port1_clk_pins_a: ospi-port1-clk-0 {
 		pins {
-- 
2.43.0

