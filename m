Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18738606A332
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bGWBBqGi;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CnHPsotx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E61C781671;
	Sat,  7 Nov 2026 14:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G-OPkTtbFiIm; Sat,  7 Nov 2026 14:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48DB081655
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061990;
	b=pqJHJ2P+41doZgLIRAAE4W2WMtAgrnmfqUfKvDuLcDK8ovMSXQTMPm2JbssbyHy0hPkS
	 3KdmT+3KiTdomi9qUYQPKba+TLXsFtbW3CSA9LpWgCFONEJv9jsqt/BD9mLzm4RVw+aV+
	 k88s57VU+f6gmw2fE0yGjbDqiMSQ4XWQpgDu8A0IsNXqszc5Noz+IL2/FEHb9Lyee048u
	 GusWXVOdZXG2yZfUUQIAKjsjT6mKqj3EFC9xXMPjK0hlISbQLbFrkXvTlrrXMEqzVRaJq
	 HEoxDKaibSd3CIiGqhEd4ujgV7X1LJNLoHOyZLU66dN67xwU8HxCYEtYv0u/KR9LTZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061990;
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
	b=EOGq1aaAkdha7bfCvX2PPZLaQXmbUiPcuVdfWN7zeii5Xub11jmVeKWTJPiRcnKIMqwj
	 L6ecLCfpGQYdcVlqvW94YlLgCG9pr5m7dlWX5J/Oy7fDsXT3Eh0Rko1reMSb0/pbxa1xL
	 uXFcChRbyPrgLbV/fepmaviZnNCxFnhF106/mpt8ndOQzty/T8FeAjUfqVb8Pp9HnuuhS
	 ElRGiWQ92rEyO1QvWCtPxRro5v5iJnfnFZR9l/EN2siVTMz0EOfXAb0P7Y8R6I4jeIsCu
	 rmz5q3KmHYyuFJaeSPzWNlNNHJ/qg7A6YWLldO7EqaB3InJk3tRQrd5DFkID7w2Wiog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CnHPsotx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061990;
	bh=fJG+SY80IKQjKhoqPH+1C9bBVUCowaqerSlez/bj1Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bGWBBqGiolWani7wLpGaGtOEVUcyGYBX10Gf7/DwWV1P+HZdyxEdkdGx+1Vg/lPUw
	 27HLCVz3ic2zA34GrOz52AHgTtkC0NDr1XZa8fyANpptmEJE8t6Ww+4RkaiXgQmxh8
	 bUw1B4QJUVlKVSQx6XPkO7bVJlOT/r8f2s1IqCtoZdQU2dHF9fzFNN+9Pia4sIB7X8
	 KIEemiMW4WM6G2VuZ0giKfOEKrHbFD91/9AZjK9k3ZqoJaMOITVot1ttiB0v4lDssj
	 BktMoCYJqyOwtdn2+xHxVbS/lsjYYzBXpEM+ra4FH/Lk7dVrcqTMpsVRX1SJVrkwoa
	 PVH+9JUW3/icQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48DB081655;
	Sat,  7 Nov 2026 14:33:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 310CC34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22211815CF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZUCmMv0lwMin for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76687815D8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=CnHPsotx
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76687815D8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:01 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so13018025e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061980; x=1794666780;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJG+SY80IKQjKhoqPH+1C9bBVUCowaqerSlez/bj1Cg=;
 b=CnHPsotxfF6KpFjtyq0rnn7sk3tb8qoyVoL73ZTw87bB6xeih3V/6kk8eIc+L2Zc8A
 nmcbSd4DwusIwhmexxgiQaP+AVV98fhkrQTexO2IlDJ7BXYcfxdfs5dCHnPf4bvEDeRc
 vJRRL2DGmEC34/EM5dPEYG69ezGc9MX/oLcJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061980; x=1794666780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJG+SY80IKQjKhoqPH+1C9bBVUCowaqerSlez/bj1Cg=;
 b=L/g/r7svF9i+iDs7ZyBDLLdYAiHGjmkMf5OLrakOBDhtGZ6EOtOLd8sC6dahbyoCEr
 ZBDdCgAY+UUoLtbHgps96l+yhe4Mi9zpwq8ycpqRc3MM2kH9Fe1nmfIU+CyA4Ea1tETL
 uzJ2xqB/DEWdGu9SkRhPfAPD0YPYvSvpuW50haPmXNpj3RpUTopmrDsKLY/QD177MhKM
 A2X3d7LOoqLHxtMQ8PfzB6lBzXcMU0UVZTnG8QPvZzaROaEQy4J+Av8OTG+ulrDyUEzc
 Rq5SAebDqI9EYZe4RSGJ12jH1TmgNf0WFKwj5v1p0nYMDompX1VIED1JFa044/SJ3E+V
 TN8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0LnjuGkQGLjvnno5e/9/mifvadTkZd0JxmVK924EcT9eR0IuAhS1TF1ZeH3/cDJP4ECzlHww=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z84L6b7abva9Ipe7FYydEgxKJ/6EkkLidynQrPKsOz2CgPNFVYs
 ZWSf0hCyia9g/UIvsJItVaxjmhiJb8G9OKSYsBIcwlhsqK/rPu8uBBJIM03wYhyHomg=
X-Gm-Gg: AYBFou2/gBwe038zxIMw7oDEllacMCgKF6LC9ntyxNjPWgBqxzVeZNvBwGrUB9oRrsH
 HNCorsQT8H1ShUesWgD6+MltpnKlahzW4pCZdHqifZ/v8x0SQILV0ZaR6guWGSVMFGVANQlt6Wy
 n0yDjryge7vmjV0wcJBjnSIfKkuS2UNm6EgM9lByypKvGhZPs81hW64OqwjwGweY0wPyEGUEUHG
 QJRXzUPBZmJM+VPyKO1SyfVqJbW/eBtMSvOiGfOQuBQieDbx5uHs9PPvYVRfoRAW9Wj/YKedFfQ
 V7eLjOzqvpe7a16rq/5IH6Rbpc/zvjMiqNb81iHzGxONYOzb2Hzbm03QHTIySFH9gLH3cJDFhA5
 MwZD73x35V1JHRw07tnuRNl+T+you+5fRiA+bagj4US31OHHmS0fOLhN2Q3WIbCUyjJLXEtdDWE
 aYhNcYLk00HbdIRwtDceYqdnG5ny9ZjPtgAjydjonncQCU6c6Ecnz/cZgPqn93/9nCFvuu9w8LU
 lKVY9HEfQxFwwh8xKWXNndSU2SiO0/JNmn9Wyj345J+ruRtIRdW6zdbnJCXFfMk+A0RUaQh+S5l
 o3cG8EJ9mo05x1wNTVwbmwIifYqBfyZENVzdVkvWwkAhMYeDhCcTYK9ytmNlyE+LwgITi9w8MjD
 rgxO/+17JdL8XcgCs930OCf85h/gCzFhhyVqFQGw9Nu4WOEtZ6I1Y/RHYebE58WTjRgjsNOM0qO
 fJ6vJaqLHlIQFhxffu0+mJh2Q8Hw==
X-Received: by 2002:a05:600c:4e8e:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4b6db4a5dc5mr98545765e9.1.1794061979873; 
 Sat, 07 Nov 2026 06:32:59 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:59 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 07/35] arm64: dts: st: add ltdc pins for stm32mp25
Date: Sat,  7 Nov 2026 15:31:57 +0100
Message-ID: <20261107143241.2236511-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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

