Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1EE606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kx3ysC8o;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Yvw921TU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 211DD80E61;
	Sat, 28 Nov 2026 13:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQ4l7wQDrQS0; Sat, 28 Nov 2026 13:12:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D00AA81107
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871528;
	b=AURRd7nRy5zD8hlivlJX9cI5Z8x7XUnti/knY5zI6OX+qttCyeAeEF2+kQQxSNUhWPpT
	 E3Q5dgJwVqYQV3WaB06XJx63vqzP0KHifwJ4YD5AycTGPBEhox1Dkny1FRhXKOGPQyZXz
	 Q8IF0mR5wY6AWEQyFFM9e7qq4GYE14i9T+AqDXZ5TwtYh0OPAoriYQIEUz+EO1HyNo4a4
	 zBnH3LcDsIlS8Wo8VibiUgGqMuylZbTZcbVkd+CQCJ34+88Fhfd/bjnTcu+Typ4wpBYUk
	 XTI+Rv3dTRzPx5vgt2MARcmcx3DTDQM+02UJyLhpYxGpJkuOACGaNqIRI4dIN3zW79w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
	b=KXnrxhOSzO0q6Sjo95X7brHPU+zE2K6/C2V6x/sNEad5S5PnfiYcImhIZfwXq7XEXZ7N
	 VOVGoVV1DvzZzhozPKCHYFQkiTHy/0i/AvN+KZ21iiaH+8SEat8xyhTGNcnUo5ppEpnJ8
	 Y2HCCVT2fBluAoE7dKDf2wQmh12rz39Tl5OYT8tx6SkvO21+hrOFfpAnEhqbnSTaIwBHf
	 MaSbg8VV9dlq4Ram1agUzDps+fFtjPLnxo+NGbI7seSQ3GVGyqI9SfIYzToVMBrkyjWDU
	 NDrZ3r+zkGNLCa+xogG5IbHCKqFtlYDzAnjX5kf5ofKU2RJFpQ8r5x3gQEcaPGuVxZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871528;
	bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kx3ysC8omG7Ww2eCtXtui7CO17umt3IUESZgzZKFDNq3GiJz+U0mhg7xx0j9L8oJ9
	 KUuQYu/iLFcqELETFxL3u+pyrSlSwcLKayLP81WwYqnftdppZXCE1Eeq8VUoqoCeKU
	 dTYlo0VZOtvgPVBfcuVVulloN9vVzhMS39MdiCNsReJBSbx14ETIQgYG8Q/nzpMKIP
	 1tK86SyuJDjfvK3HsPr7x2NsGnynlJ4NOdtZipVQYC58Ngk6XVad02sL1zMcCRfNL6
	 LlWJaw+50OKr2oiwwnbAH0yFzu3Qxliz3yr0glhI/RZ8Eq657kL9/k9+7BxF1AnqLQ
	 cWjzqtPDwl0jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D00AA81107;
	Sat, 28 Nov 2026 13:12:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E4AD26D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 006ED40659
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lAYHJQVqZHJ3 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE51A40645
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=Yvw921TU
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE51A40645
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:54 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so87139395e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871513; x=1796476313;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
 b=Yvw921TUZnHN34JTtaGUINx84/WkMGctAbGDRhuITE7PhKYHc18uF4LfuRDrRivIXT
 ZUT3Bd9VVpeGDM303+zEU+O3orngehsMxEKjke6IVSOYvXQuEjT3l4r+8VdeJIfAgxih
 nPwYrMzX3syHQQJzdqQXyx5bnxcqmQqIfipkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871513; x=1796476313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
 b=Eq/A4aCnh30eaR4/NHs3Nis/v+2cHbIEzU4L4dbGRSuwlkl/GgD0QkV9X9nOfvPEZc
 y6eVTZ5E5ZY5DY+gP4yDXpvTLTWmH5q05MVgU3RhQ4rdJlOu/2nZL19bUxvRYZRs7ASX
 pBxS7hnwLMjG4rEwR+L2lttFOExKxPj8Hka4Rmh94UGHaWTCmkuyTrbA990/tzG2nIx2
 bWWsLgLszKofHSofvAWfwUcEHGP4aq17LrNnwyVRzTbPzBBV1WZ1XNOwxeTZZdsI6Ili
 OmVG2L5+lNL/i5Aw5POzxziFeQ80flQLvBqI/dljNwBFE0KmwgmwNzNTbptPxxVe/Udz
 8h0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEdlMc1+kcNab6uaOpYHchqSkp5BbH/7UC8brXX2v0Mn7yf6PwPVQl/t+mW/YBytM17e6K7OSo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+nE8MgFM8IUwa41peE2S6Cxbd3Vu1HyPCYRKWZX3uYlhIPtwv+
 58SjNxM3mjfEUM07uaXfVqEiWC8q/1UckI5JtVX2TfV4q4iIuiny5MdOH9SIWMvIxVk=
X-Gm-Gg: AZFdTZeHFHzvp/euCUJD8EZP1Q7FB+TZOEBueb5Jf7wy+kcux7slfIf3cdIJMCELXDZ
 ixqiJXHNZY8y3O3HZrgmyY4RLWqJ8bEQxAQ32llDNj3arIaFLUoblQZTFUEADwuAFsx12hDwduf
 fz4ikM/ikSmdqZwKY4MIyFxqWaT0QKT0AkGokNC/0ws2GLWxxVckmpXO57YqY39vczIsg9IZeqd
 pgRmj9MjlULbuCb0Td/aMOgXeCR/tUY2ebr+DPdCpagUYCHdusaveclfeQ30gGvTiaVvMettd7h
 qIY5aCxZOTclXuitZqAJrnVy0Rg3GmLaNolRZhfp5gNWynWz/rLqtcgEFYXo26+tXR4T9Uciqoc
 i2Faobksz6wCbeh+JJd1PhZBDj8I9peX1DXipQtuXLyKbhts/mSZ8bR+qNGR7jjN9m7Ow3K2K0o
 ZjnKCRXevWXFpKZP74OccIWbwuLUlDz5sPu3IHiPP7mkIsCdcRMZhsWfoJum2zL6eykTgY3JQV/
 Mj9VyHc31ZK29R8k6H7u/nHdTNELzHSsTse2z16h7IHyBG2JxxTvC3nJybxQyBYICx/29fsRfNc
 Sa5sFyoT2UtOxyPfKwKofjnhSMm8bBydzUnQmrq5bcwkvwHW2P+Qpn2WzGicuhrIW/pW9NcDOTn
 YCwwd+FHh3+y21Fl43iw7LK4v/oXVXNZubcpyqs+gmumREfOB0KXSQ/xr0rmz+5KsYZzMAWjmpF
 YC7Lop1cH2YFeRbuSvgHTlNuqx1Ug=
X-Received: by 2002:a05:600c:4585:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4bb8882948dmr569509075e9.18.1795871512661; 
 Sat, 28 Nov 2026 05:11:52 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:52 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 13/29] arm64: dts: st: add usart1 pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:30 +0100
Message-ID: <20261128131125.2141352-14-dario.binacchi@amarulasolutions.com>
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

Add the usart1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-14-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 2bb7d85d7a644e20b7b9097a966acec8edd5c7cf ]

(cherry picked from commit 99b28029f7153bab8e870e9510470d21f6722f76)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 4e570e2e5157..d515e44832d7 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -766,6 +766,39 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	usart1_pins_b: usart1-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 8, AF6)>; /* USART1_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 10, AF6)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	usart1_idle_pins_b: usart1-idle-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 8, ANALOG)>; /* USART1_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 10, AF6)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	usart1_sleep_pins_b: usart1-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 8, ANALOG)>, /* USART1_TX */
+				 <STM32_PINMUX('B', 10, ANALOG)>; /* USART1_RX */
+		};
+	};
+
 	/omit-if-no-ref/
 	usart2_pins_a: usart2-0 {
 		pins1 {
-- 
2.43.0

