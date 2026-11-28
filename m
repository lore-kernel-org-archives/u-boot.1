Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F801606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GHZ0RtVH;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=U60M6kip
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52D9860658;
	Sat, 28 Nov 2026 13:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PceluPubGzJ1; Sat, 28 Nov 2026 13:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 674CC6064F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871524;
	b=hHBhidHKX6fo7XtAZy+Zq+ia6YCsLMnjxdrWcAe8AS+X9Viiap5LvDOBKKMF7oKwcz66
	 al0+mHcrzM26A7dy7BO5GurVWxnUUwSBR7nmyn5sNv/Oyw0MH1wdG1LclcFHiYkyH4Ohl
	 nI1mVGSa8uU3iQ13wHoBKzF/HLlYYHSeV5VmQ9Po5rOctwnMaxi4Ct1i4ytZF+c47fRI6
	 f7NSWB+ZA2pVeO22ihPBAf4fHAnHAGDxHRvUw/1Gfr18q2GG6ZWyH8xkM2U1+qiDyeiql
	 U7GKnFENT+ZuSNzqPgAsq1orBILUwI/MFX6hDM30pXJANnNbg5WcyRDpVEv+sv+Qpvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
	b=m4prHxN8VzhGJOZadZ+ajlj16Ukm9KSjv7kq5Te6ecjNFriGxSuxrFxCz7UfS7F/ivgA
	 +ujd2cO8dw+Gb7YlUwclxb9S4DIb1OljQdoV2HwZbVUI6bI9QFMqz91cHx7E+ty+LObL4
	 FiwPnlA4/Cgg1h36M5r6KEDMdHCCqrBX/qvUnCXh4+7T7KDisdYoc5cwb9LnVpPpgdmuP
	 op2r81I9kMSjO5xf+ebWoSUsaugLwaLbzF+yCqrnEn69+3ahQp9BX41NRI8D7Y8i8Rayc
	 aACATOM2eFPPfd9o0jVprrMJwL44aqB3wSKfLXkskVaMzFeQa/yB0YOKpT1228PKEYA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871524;
	bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GHZ0RtVHPhALgLPK6xHwYxh3kvrkvHvN/oymVllZjEpROU+skd2HBRCd+ARCHtiV1
	 ajvW0nmJ2sZz58ECOgVRET1lt3WnGvWt0Kxt5nyoVaGyLzpPUYoQUPWt26KmHxCgxC
	 h51lA1bn5uXILVpOLJXEnT8TRR5zC+K20xN2KMBdTLNnic9YNec5HKwzOpshgQttsI
	 fphq9egQcuDZPSDqrXjaw2djXqNcV6YfS2ojcN33QxjpUH1ONXPvOUcS62woVxuyz1
	 GjwBqGA/SBTquWlPgXIGl4PdIXFa6s1Qitmop7LXqDgbH0KKuOoTI3K1xIW3lri9IX
	 24n7fYHbYGcmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 674CC6064F;
	Sat, 28 Nov 2026 13:12:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AC7BD13
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DF264005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ear7pwj1ATNr for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1DBA6400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=U60M6kip
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DBA6400F3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:51 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso63978995e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871510; x=1796476310;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
 b=U60M6kipG6fmurVAo/0EU1ZDrNigv/1zu//DKFSuSaScHsqY4iqVsh0lfIt7HwKBnq
 0nem69a2AcwLUG+rIoDELSj1MWdd5162CwlEKDRXXNzUM3HQ4zOmYWvpomAvahbeI7yZ
 ntvAzYpDP5V2LImgnc1eCUJunD3agrXrkPgGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871510; x=1796476310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
 b=nt7igc9SXKeURYx9ky2eSD4op1ermCWBMI0WKJMqPp9rmGAheMzfcfzSYGJ9I1eoiY
 ghZAusTs24wv42fRFufcQFV6EpnpX4uWdb/5mGbYp7U7Cau8ac+lYj4rYiSo+eMKZ0Sh
 qZopmWevOooSq2udgAw8aNJoQAdX/0XI7MlMr8Rw4FATv+ga2D583U+LiG8kPEqiR0/K
 HB3m8CBT9lQ2F1cPZPyQY0qnvbzVfQ2IMVz+93wm7ZiGMYudKOEEADeFUIz0bVkJDeGb
 GNIqVrOi2Lr38k0SEhFB+hKlY5bxnt38x60IO057KfTK72gzXmS207H1nuMzsZXhZDcz
 sl1w==
X-Forwarded-Encrypted: i=1;
 AL+hErHBBj1QjhiOOsMzP5o6+U4ymhWBIwxL+oeFdK/wQxD3U9vdSCXfuXVn9y2mB+vbKo1Be62SvN0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+WHRdS0ik0yTRosb4T4PRGY2sB1Q9fTM0Bf9vCuFQvOa4J/W7X
 xS6UruEJ4r19YDne7kVmUBqZvR1bTa+VNkbiW37u3gQcq0fO7CfEG7NYmp4ViRnnQhA=
X-Gm-Gg: AZFdTZeyH/IJasaHOJyA3lz8FKZAiG/PGXet6Sax4sJsvsD4EYxnunnkbHF74NYDhxW
 QS8UoVqw+m0owtKGWEAZVIPRz6X9enLwN8e29xstyhKt7gs5re/0c4KbDzqM8d5cDxLLkibWi/m
 acaPSBYDTse0hwCvnBnmJKgQMaC1Jqgs3OBGFDd3kJRnbTmbvdlmKQ/qNF/PnKjnYI63yUy/m6d
 19lwOrS5mjsSej4QFrmX3+rHTsOfsZufTI0ArUqec5YLBewG0h3Ev0kpE4p2t129d4Lw8wPwgWg
 H3+AXQDDMNKCB2VsIiKuVaD2YXi4yAihBtvALjbnVoDsa+er+r7vPd2O9FHeR+IdH42+IowWP00
 3yb6qCAg1uAGrTxm1g3DeiFXyCcwfbvGUlXHbmNnuaR+R0zAi/b5RA6RGo8t4uZLZwiXhMrvXBC
 /i8wcw0LbqPqXzxFEM7l7YESiw/mIBQGviJAZtCLfGRex6ZHEXwgIe5BSKm7rz6y/Ur8jxR32ZB
 P9erjliieL98nZouWNd/Kt7q117GuofNvCOhz7Mqz135vYwOkj2dAZ4vv3fdnRdeaVc0Lmw4ZQ6
 4gD0gjeSBLq3miKsEKHm/6IqUu2vl1CjUtcjyE9gheTwp1C4Zvs679HX9YRhyb2Nrd8rRjcStAz
 cr5uOtebZ/3uFwhUUrjJnsLbmaCOl07Cpo8d+1mRdfq2iC5nG7SwSfkdBLZHdH1qZLX/QylVn07
 9cqfWNUhfhX0HlELXiNXSjD/BqF+8=
X-Received: by 2002:a05:600c:530f:b0:4bb:68b9:f615 with SMTP id
 5b1f17b1804b1-4bb88810b22mr556098905e9.17.1795871509900; 
 Sat, 28 Nov 2026 05:11:49 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:49 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 11/29] arm64: dts: st: add sdmmc2 pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:28 +0100
Message-ID: <20261128131125.2141352-12-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the sdmmc2 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-12-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 17d813da16896a7ced144acf41bf7edc419a9fe5 ]

(cherry picked from commit 9bf2959090b5831f7ac2caf05aa880768def9f32)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 002fbc724b9d..c816a6aece47 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -622,6 +622,86 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	sdmmc2_b4_pins_a: sdmmc2-b4-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 13, AF12)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('E', 11, AF12)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('E', 8, AF12)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('E', 12, AF12)>, /* SDMMC2_D3 */
+				 <STM32_PINMUX('E', 15, AF12)>; /* SDMMC2_CMD */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 14, AF12)>; /* SDMMC2_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 13, AF12)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('E', 11, AF12)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('E', 8, AF12)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('E', 12, AF12)>; /* SDMMC2_D3 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 14, AF12)>; /* SDMMC2_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('E', 15, AF12)>; /* SDMMC2_CMD */
+			slew-rate = <1>;
+			drive-open-drain;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 13, ANALOG)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('E', 11, ANALOG)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('E', 8, ANALOG)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('E', 12, ANALOG)>, /* SDMMC2_D3 */
+				 <STM32_PINMUX('E', 14, ANALOG)>, /* SDMMC2_CK */
+				 <STM32_PINMUX('E', 15, ANALOG)>; /* SDMMC2_CMD */
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_d47_pins_a: sdmmc2-d47-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 10, AF12)>, /* SDMMC2_D4 */
+				 <STM32_PINMUX('E', 9, AF12)>, /* SDMMC2_D5 */
+				 <STM32_PINMUX('E', 6, AF12)>, /* SDMMC2_D6 */
+				 <STM32_PINMUX('E', 7, AF12)>; /* SDMMC2_D7 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_d47_sleep_pins_a: sdmmc2-d47-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 10, ANALOG)>, /* SDMMC2_D4 */
+				 <STM32_PINMUX('E', 9, ANALOG)>, /* SDMMC2_D5 */
+				 <STM32_PINMUX('E', 6, ANALOG)>, /* SDMMC2_D6 */
+				 <STM32_PINMUX('E', 7, ANALOG)>; /* SDMMC2_D7 */
+		};
+	};
+
 	/omit-if-no-ref/
 	spi3_pins_a: spi3-0 {
 		pins1 {
-- 
2.43.0

