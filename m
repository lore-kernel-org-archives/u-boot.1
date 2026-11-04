Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54E606A334
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0zby6NzH;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=KkEpChKw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3281840752;
	Wed,  4 Nov 2026 08:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJ7k2fGNwmeK; Wed,  4 Nov 2026 08:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D72040719
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782280;
	b=kqYKi5BafgF+TmCIYZ88GHD4+N3f4vXAkHOlRM6ifm6Ezoh3Qin+McTxiHpvG4Arrsh4
	 p+0vcpSQITSce5yoVkwuGtOXVaLedIEJW3fI/pqLtHkOKIGjmGs4gA5bKJ+o5eYoxCLSl
	 PtQFQQwdBBEzWMA331z5Y2EU+H+IvtjJMnyfnKmHzn7Bkr+J+gyO22N1EbAVJQeCP1JRx
	 RN0yn5sonmrHwXqTCshAOI8cRgQ4zG02fdbk39RyDBLn3m3b/JW2SxqUCf0YBhEPPgBHv
	 Mw+AX9zaCaeAvFfOUAi9Ed4TGLlhCgZYb/EASYV83Xvy/Or9iYmreZBRbF6z98nsmjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iIWLchaKzzVjXQsJ5oRF07h5BzYNBMDDOZUG7W3Inwk=;
	b=cksaor3ltbB/VY0JpfgXiOYnwYRIQW8movdKjftdjLpqaQEP7lDeqgQQq+jurPyo68Or
	 iblaFOoYXbTkOM8dWVZ37eLe2J8v9ceytunk7i9bbCKX0urmRrzac4lfv4mqgLsv/JVt3
	 WVYieKC6kYpFqH7ZNmqxWrh/5Fd5Nh1S0NhePxnv9sbvuBNvUErxPFysN8GuMbBixOWiE
	 xrUItSpwbm7X5txZTWykpkZsYKsOnyJfDI61s/Vs5a+IAEj1rLRpkUaTzw1lX0ygXExQZ
	 xjKVZvrqzDDdF8D6BtT5SLTdelMIyXsFTtkmnFbBQwP2fRBX65gLEJmwcByeCLgCX3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782280;
	bh=iIWLchaKzzVjXQsJ5oRF07h5BzYNBMDDOZUG7W3Inwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0zby6NzHnEXKFsbBMwK50Okni6Ea+eVqSLP3/D8kSUdFCFKj3edduL6JGYe79Cqon
	 r89Ze8BUfaKKZzEuyjUiNv3ZDXqEjVlejDr/oJeZC0kB4foYo+IWPqac5rVGbavW59
	 RkykhYeb+vZ5BtabxNZjgEeN1q8IORmbZac/wIN5TeB01gx19YGdIRDQioWIfvtXUq
	 1ZJONneMWFui11kvu6ILHxQPuJVGiKicsRBRX+n9aL9mqs9PhjpZMceH7a6ovl4d4F
	 VR67koZr3xPI79u3z2PrGOYiGHo6LgD+DWzmDurvPllGb+xCVsC5dA6X5CTDfpra20
	 1oXXN6h3Mp+SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D72040719;
	Wed,  4 Nov 2026 08:51:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 600409C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D5C660778
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oBVDARkjynT9 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4ACC66070E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782278;
 b=dS2s/e65hLqWWV3CH0vZ/lHTrnHI6JeiwY0Yx3ZUvjahcJ5LWc2owC2/2RYqnb0ng75b
 8nsXt2sVU5Kh4koPOSGOBelM5nEQJ5TQw3BQa9Zp9tJ1gFTM8DtMPwdayFMGCQPqKvAt3
 w8VvwwyU2JuiiAicdBTSo07Hvs46XOG7RO/qNc0qe+YnTn+RrQ/eUDxtshII4Al1WTgWK
 h7O+/NqSw2wuwf+pGJkRxjHZf0I0IGF9Y5beI0tjZW9uILO8w9WFpqI0IrpaSDMwKUWpv
 hug5u0BGBmvvpxTJ08AS7at9gKwAss77X11OAnc2iHKjLmkNHzz4EljvukEvrWqH6RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=iIWLchaKzzVjXQsJ5oRF07h5BzYNBMDDOZUG7W3Inwk=;
 b=PVqGrAyUpOkBWVIEuPTd/OEDZA3MuWjvNbzXuEdP2Xrn0Tibh8QlvtWizj52Pa0a4pkL
 YjzV+IgDLIrtbNt0hRpN5dXgcPG//+0FZVg44dVDgjzHa6hF8GUGOQ0YYHd29j2GmUW/q
 eq53bi8SqvuanIZxRaAEDjcJJOnj8MOq81cxcCAJD4LnhgybG9jjhV3TLqivXnoZ03Cdl
 6xqGQowg1wTV02ckUIP5jICAX6r1XW+wnW1d6p2o5DM2jG5Vs8rmlmU7VAtADk04fifGu
 U4wdV8EskGgz/gWihc06X6uV6k4rFPuUopF797iOR0r0IV1EDandYJY9vnltvumj1fg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=KkEpChKw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=KkEpChKw
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4ACC66070E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:17 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso3697165e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782275; x=1794387075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iIWLchaKzzVjXQsJ5oRF07h5BzYNBMDDOZUG7W3Inwk=;
 b=KkEpChKwLzJjajQpt55kpraqCN2Ol8+zg030ZfkRaJ5vTAlplUGFiEJ9fXhWKQWC3M
 2aTwbvHS480K+yQFwR65JH5uGaVItvT+anOHGxX7yBx8dLIy4cwSVyrCjE4I3YO6TcF7
 iB6FR3BlMIshPz0sncO1miScsRcb37t7ErFxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782275; x=1794387075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iIWLchaKzzVjXQsJ5oRF07h5BzYNBMDDOZUG7W3Inwk=;
 b=hkzlwlLr45nk8xj7SULWjram47aqe/5WLAIKdC5YEiZZRkjaW8uvlybMTNGpD3cjNU
 f8VC60oUK1NcqGKTMynQmluLfeXRF/OyIDpzrSbByGw5qdXYI7/txkJfNXrKCBZO0N+T
 v496ZGJHAwv6E4uwRtjx8onm3vSXuPc0QgWn2/st0rQPhTtKaqSC9ACb605LtW6K3C12
 YCVk9K1nSQlJgFE/g7QrvpETy7blpteRosToL44TagjhQcadJjUhvm2r4YjsOWP9O2vH
 bC0T+d2m2jmrgnei2gplajz7C/Qrlh5unYB4VAZrX120Svv4B5I7MrOlXFV6GMDneuSp
 dcJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2O6eWwW5dx28xjzXazdwXSrgf9R2A5SX5Us++ncapiSoO7W+ysR4Fdj34kqYB7Z6tB6cLwEY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8gxgHrgPq7/kf85oRc/sNOuJ2Onm1HbBLGLDoCpdLlG/3hqZFH
 Bg3KGkXBLV2KtECT5tTlQA3TccoQnJVZX3jefXsOCCXoqv5+UI2DxWkiE17qL0mG/1o=
X-Gm-Gg: AYBFou2Z60T7Rw/Qacw0rHQmeuL6pXh32p28Yh6hE/3iU7V8jbVfcTYbdbftk6jfcG4
 yzmmbunEn1lLWqOQ8d1ojrHdCSLo9Mwqqg6Jk0SVgmfKKpS4eGHEh15zjyOoHrRr4+FqQtfOw9S
 sVsgyZHOxlMP8Gx069gbzyFaK0WxWQthSc3ta1sTvdeIHpCbuOHZ2UoeflPNNrEK3/WPgnaqgF1
 bIOztM/u6Eq9BazX99xHAhJqp7ZWCu47BT6aRSvlBokN0Ch4PR/3mg4EppvE3Zjdr+MbVivo/Bl
 TPLe/6SIvxLFUH7SCrYe6ot9GPgT8INNs/W0TM+03PIkO7XQlDTQNsRx5aBBcH4EvQKkbCJO9F2
 vD8YbgU5e44nTFKBlJxhODY391YlbnU10dR/QXN3V8KpW6+Rt3uwbkJvKNz3CY17eYVymWvYl+r
 4tq7o7JAvuvtvlrs4g67dpffBfz36Hlv+IeLFe2FjLkQPEUOw2W6dmgT/FPZvnMdDnr3I/J8XZD
 EsCKod9LJVgKmcUdZRnQPhWkKCazAUBv1bu4uMxnZwQLV11XupP+F/EDzaXWcdyAUr8kP8KhcdO
 JCyg7qy4K8cLZH0aKLzdMhXOZsSDZ6ctA4lHdltrGRcFq+JvtJEFxxlB1eBrTQa45y9PThRk71v
 B6Zp7DAbd8TDRVc0S6gAzK6fMn6M=
X-Received: by 2002:a05:600c:e555:10b0:4b4:49d7:bc62 with SMTP id
 5b1f17b1804b1-4b449d7bfa3mr14911145e9.26.1793782275239; 
 Wed, 04 Nov 2026 00:51:15 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:14 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 08/33] arm64: dts: st: add can1 pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:41 +0100
Message-ID: <20261104085036.4012238-9-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the can1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-9-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: b9efa6d3c580feeb4af6204457ce3ebf351b2af4 ]

(cherry picked from commit e9b8701fc994a04a4dcd15598de7bbd9d81ecfe9)
---

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 50f454630cf2..6482dd47e977 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -331,6 +331,28 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	m_can1_pins_a: m-can1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 9, AF7)>; /* CAN1_TX */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 11, AF7)>; /* CAN1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	m_can1_sleep_pins_a: m-can1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 9, ANALOG)>, /* CAN1_TX */
+				 <STM32_PINMUX('B', 11, ANALOG)>; /* CAN1_RX */
+		};
+	};
+
 	/omit-if-no-ref/
 	ospi_port1_clk_pins_a: ospi-port1-clk-0 {
 		pins {
-- 
2.43.0

