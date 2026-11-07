Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F6606A32E
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tvOWcj+m;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=iJ/1L7Mu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1ED660746;
	Sat,  7 Nov 2026 14:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uesRw6512aiM; Sat,  7 Nov 2026 14:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5BF7607FB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061995;
	b=KBrKvO3q7717aiUk/hNREleCzT8jei9a+++BdBf2cgPFUJpJHR4X4Ypb8OEQTV40ZMXX
	 Fn21ZoQ63PnFKMzULbYuggGcN8kZWJONPnOCtGxCC3ZALKTePZKbxCux2YVv7Zgq+4mXO
	 T6Ttg1PQhSre4qab/HUn4831NE7EikHtdc7N6NDBPQber/+31rf0gpOBg9rfPx6gcCxfl
	 tdaicbq2cfVb2eC//aCS/1YfACQCtbiaXURNhuFtDP7J0HKOX2aG8+R41TnZ9lM2bDG7W
	 93XDjrV5iUZfsul/e4n05PfMUHqIZplnc9TgUmUKCLz6FOcTxodW8+iIKI5/Y/qmXnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
	b=TuBPcFf0brNYyzCVJPN92W1PLGcfVSuwKteR/Gjt8lMD7BiHukuv1tRKrk3ZtF6KvjKf
	 G3mx5JcIImCBtVfIsCyJgbxxon7oKMpzpvhg/gc3bvasASwBBTLk6cVfEaYCxQUTjNhcQ
	 qoTbF+EquRhEG7UdMACcVf9j6Iq9o/HHFFTZVCaUAzsIYFw3Xk3bwrAc4a9/bmjdejTP4
	 GbA5tXrh0CWg1MwqdYeAM6izI5FkZogAXY148FzuiGpa98FjaDnZQEEXzACnQqeKuVDRf
	 4CAtNwS6Hwmv3IhGYLaOS+MH5YORU2Ij2i6YYlriCBR51klnPj0bSsAg3g55Ufq/rcw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061994;
	bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvOWcj+mpMaMyNEbZ7cbi5Bt+lKYzwdpcoQgL3J8bsdaxOajNxdW9JbIfoGLV/oWZ
	 910/CtnW6qubxkjkpx+7USFCYtuYognMeWebYwzRirIwekxuFzQkjwfby2k03mQVOe
	 oP0ayzCuKftJjkHLiQtvFROOd/Odbb9LxeKOWiX0/iaes+unbbdQJd5EAkjYmkO5LB
	 JuNg1UF5aqep6ZRmUYD0MMvN2lPo2wsF5HDcbf1KiOtuXfRMwEOuiwZ7aS3RbU8lSN
	 iiTVEi8cfgwJKA4POL+ysddj6L63HV/uSJT1DNML8fKBRzRIcgrKqYaNRTADE17fKn
	 ExSkhJufUcn5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5BF7607FB;
	Sat,  7 Nov 2026 14:33:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C54CC1E3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB04B4075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLoDDvPC3QIb for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A710640757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=iJ/1L7Mu
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A710640757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:05 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-49318428d98so699669f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061983; x=1794666783;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
 b=iJ/1L7Mukz0dbI9wdAnTAFtIBBx6XqfRG62Udb/XhJvLWhVUlQ37rIgk2+hkuhNG1e
 CMn9d4MNxV22fqEtWNSrK1Ytk7Xnn1yKw+1tfmysUgCdBhze82KRxK4rWIso02ng0ihS
 Y+DPXyBiNW+FcF0RJP6hA+5EmUMKtIJ7j7G8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061983; x=1794666783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
 b=Tp0InaOurwYc+lteMhu9XPIh+hC9E1pQ3QZCZKwWWumXASoMewTM0WkimYtk1esUaC
 yWAPPGiNe1qFFXZSnaSl0M0DUdpqW4MgHOACDVAPcHIhtoIxV89FbbW3Cb6zVTNRF87G
 j1qsdH/D9wlUwuyu+FzgCwdw0m8cSgNalPCkk6thcGY3auhawnVY37S+N7gjRIQjESQb
 rVmntsmpKL4KQru0PpMm3CWnxFRzIXESOHT/7cE9lNx9U+bjkV5TLYdFxLbO0dQg/JkZ
 gvmw8Io0s4Q1SgHY/u+z8mgtko7SsdM9U6fO+kCobaQGJ4x+uihS7/Cz8EDx2slUmYdz
 oQ1A==
X-Forwarded-Encrypted: i=1;
 AL+hErHpUgtUmN3vkd6gPfgTMpcj2+XFB2J3YN+YnMkXKeJxhiHvFbv/kOlj7z+GKcK+gsBPvrge2wE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+iiFjH1w+ZWQCDglLIt9kVhnTwmqeYfJCBh3izupDSqETSbE37
 nJMTt33DTQ8+62eTZiqbMbhGzle7u3JJt/rR6Ct8r4ZoFdtSBXTHzqaGsbmnoOVcHvw=
X-Gm-Gg: AYBFou1WJte0UkwHR0M/XVtvfr488jonzjJocNmKm9o0F7TTTjyYAQi4UpSvuZhfxXa
 Fl5nmkQ9vYOyi2qaIbtgQJEe4oqh9iReoMniiZpJmTipKfzgDL6h1i103I4VqPyp4AM8YSRfWIv
 MfKYVT3O61IDGnqa1OyVHs8j+vdaptovXCb7qN7BNbftPECHxJC5FL5T7qm1vpqPF8BdELuYZ/x
 Z8ECnmaWxHPniE85R6mnV494Hqo4MlsQTpJ4NWRhHbKOI25fFhp+TdBcvaTAxSWXRztDafMfTUy
 7xtHJFrvCoY8F+XSocX/dPUxhLTNyonQ5ZjZLBET0aQQBT2SM4uq6xUOkfA9JmSb+wFmh0r6xNK
 MCHVFHTZ9qOmOez4mMnrYB4iSRItSUAnopX0aenzE9xXYW6qVX+o+lZ5K5nkfqu0/hQ+cq82xik
 gYLG8G/w3tDJht//JbnUO1Axf8EcUvHVPJFC9jPt4CWx8GEW8bNxik1/p4vsRkVYmTfAdjMFrwS
 5rdqvB2xGu8f/DwcENx8CQKRQyL+LkHJqaCKL5BiK11p2ikpX1O/udXoQy2nN/0PCo1STg9Yb+D
 7FBJ5ZsX0KfhMAiA/CD2aHyZHH7Ky3wfE5TtITf6Na9tOPTp79PVliVVkCfN5sNVeL1x+yJus7r
 zUiJ3EraD8vUiXqY7ffSd2JQ/wQKuPmvjXbZT586bSTaXPdXVnIdluwPEORk51t7nLvEjRhnwD1
 FDArDUYISfges3NSmm+gRaCo1Elv1xpvH11T0F2uFRdk/ldY0=
X-Received: by 2002:a05:6000:4284:b0:493:59c9:ebcf with SMTP id
 ffacd0b85a97d-49359c9eed9mr9576033f8f.57.1794061983168; 
 Sat, 07 Nov 2026 06:33:03 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:02 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 09/35] arm64: dts: st: add pwm2/pwm4 pins for stm32mp25
Date: Sat,  7 Nov 2026 15:31:59 +0100
Message-ID: <20261107143241.2236511-10-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the pwm2 and pwm4 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-10-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 3c7876c003f01223e111444a93d5861d86d8022c ]

(cherry picked from commit 1d936c8ac7bcd3a7d8aa42ca88f8fbaaf3e63194)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 6482dd47e977..695c9d771853 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -433,6 +433,23 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	pwm2_pins_a: pwm2-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 7, AF7)>; /* TIM2_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm2_sleep_pins_a: pwm2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 7, ANALOG)>; /* TIM2_CH1 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm3_pins_a: pwm3-0 {
 		pins {
@@ -450,6 +467,23 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	pwm4_pins_a: pwm4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 12, AF7)>; /* TIM4_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm4_sleep_pins_a: pwm4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 12, ANALOG)>; /* TIM4_CH1 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm8_pins_a: pwm8-0 {
 		pins {
-- 
2.43.0

