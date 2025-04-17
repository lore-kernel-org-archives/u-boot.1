Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CBBC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0069C8309E;
	Thu, 17 Apr 2025 14:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="fEMhn2dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDF98301F; Thu, 17 Apr 2025 11:10:14 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37CD82FB8
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso5019645e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881012; x=1745485812;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ue0vUqJbCDjcMBz8GKeXN1ojlKSfWBHjEtQ2CY1KHTs=;
 b=fEMhn2dgtImGGgWAAXtOLSY8bMl2GmfRPCW5gIwXafnzXeLa8ZUeVr17YtNUXjz9x7
 hZVZZ35f2DWvmnnctH4cZ8KK15lWohKnedmfoyuegY0DM63SZxeRMYFzqOvpMjpLI7p4
 KvgrtLATEOJ185fB6LyC+Vi9WD9XCxUaPzDv/POD6XE8iIaF3bsyuJz8XjmQucTqXEv7
 NfJjRhuJ1GJ6xq5USzX41uu6ie3nPI5qpSyi8KrvEkeig6X9qfOtNf55g+Stxx1BTDH8
 wASLZoWchq2zZKvtnzF8pB6EGOPI4EhgTviyYqz9U+5ITJN2qraRVnCKDr5MJkaFB5lh
 K5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881012; x=1745485812;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ue0vUqJbCDjcMBz8GKeXN1ojlKSfWBHjEtQ2CY1KHTs=;
 b=ZnxAQvdJr7usnwiQ6GR65xZqeK/uYri7m+a+g10+FG9tO4k03gXepE03lA96tmJh9w
 pmac8cXNjzh7YRftWQn9ROurlpfvUvy412ju4HFr88Ii/nGZ1si0mAAW7LUcg+qTJZuj
 4RiKsFkt54ikKS/oc5RlPSpsgcFN4pCcQQPmqYy8dX6LaURL3Yd5YeUvFg+H9Wo6v3T0
 2hPL4o2LMs0F/4yCSKEdrEcnl0xcV76hGvo9vbpXNrZgmNJb5a104e0cExUOZweVFaRz
 QtM7MaJYMVbbiLNaRj7Qf9jcYrYCyF895EHpKGFuHaQta/NZoLE5TTKovjO8b12CtuuF
 VQkw==
X-Gm-Message-State: AOJu0YzjkP9W/A7v/ERwJMRJgJS2OshewXd5K9X5t/yg9YmKzjiAZ6U0
 /K/1QR8qCFc/uMrZUs9a1SycZKzTUgaJ0B21hu9jg9juc7WvnYuzQiozRLy4bqu1ATrQcvyNoEo
 T
X-Gm-Gg: ASbGncv3wA8vKFPmVU43UjUp/gJnMIxYA8GEGMoNCbsMaMHqS4NftDlZ68+WprOLMj7
 lV+kRBT+V7YrAp7SWXsIjc0bEH+Dup5cAB+FYorscpehkBvK/9IyWj23OqE+OQzth5J41zDI0tm
 NVBdoWHiz57aKM+/Kv62AfewbrKeMh9L9SOEv7R0f8M4lgFaiHsLIuwfVWRK9N3e9LKh0ZJHFpg
 EXKi3qcptGuMcAxvPTaKIglonrVs4dIFdX71VO5Y7FvVkoMwoW0pCljQ0hY6WLuvz/nDVA1A970
 RoGlYxlcgSBuoB0N0iWlHD7xDhY8tOm/U3gTUFY=
X-Google-Smtp-Source: AGHT+IECoBIZPL/f2svgxWY60gXRmq7J2IFkgKylDeBU+IF7aRJ+Nxy9Fcj7f8Ugb8tKBoV0N5J5mg==
X-Received: by 2002:a05:600c:a30a:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-4406801fbf2mr2012815e9.31.1744881012086; 
 Thu, 17 Apr 2025 02:10:12 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:11 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:54 +0200
Subject: [PATCH v2 7/8] ARM: dts: sam9x60: Add watchdog DT node.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-7-49939de473e1@hifiphile.com>
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
In-Reply-To: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 17 Apr 2025 14:34:54 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add the watchdog timer node for the sam9x60 SoC's.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/sam9x60.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 60de9140226981003c06747e103966b696b7b700..6a5465cf31d5ab48e1205896884f41d2203b5812 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -298,6 +298,13 @@
 				clocks = <&slow_rc_osc>, <&slow_xtal>;
 				#clock-cells = <1>;
 			};
+
+			watchdog: watchdog@ffffff80 {
+				compatible = "microchip,sam9x60-wdt";
+				reg = <0xffffff80 0x24>;
+				clocks = <&clk32 0>;
+				status = "disabled";
+			};
 		};
 	};
 

-- 
2.49.0

