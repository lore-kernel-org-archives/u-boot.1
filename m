Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AFEC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39E6831D7;
	Tue,  5 Aug 2025 11:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzyAJXoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0053801DD; Tue,  5 Aug 2025 11:19:48 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC1E801DD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76b77a97a04so3218016b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385585; x=1754990385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDrSWzzNW9qcUnSpsmpSOBUgluhQyOePdSNbQ4n9AVU=;
 b=kzyAJXoeMK/R9dFgvzHJ8ve2M4raZWhz1caBBnl9GIUdyNhUclfcIIzInHhszFYFYG
 yT4Qkk6wnSqyAKC+19O+LArGxjfvUHV1OyA+uGjRP/OetzLiZB8Cd4BjGpgmaOeaWtNL
 f6GNKsU2Hs1zdiMTgQWRCOX4X8k6hqWRBy8WPrpa3KdvRNzlU6N5mEyZlyIj6hPtj0Ya
 f4wTkC5CNp/LBqfIYphM2EwxwgQs1KRmnbHQgHd8u85Jq7byg5PP6cSeEyLGOV7ArOwp
 hZnmTBHkVtVcK1o8pGMdnuSGJ1Is2DnwUs0L3m8IA34OdbhbWqcudcDakXfZONfn+u6v
 jtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385585; x=1754990385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDrSWzzNW9qcUnSpsmpSOBUgluhQyOePdSNbQ4n9AVU=;
 b=tvLIlShmcWRQKQSFfU7evIlGzwFsLvZboO+QwjU2SaWUbPcvMTgd5EBlM/DNn9c/xv
 bZKo8xIQ98i1caYpBX/6FqRQHbcNORyAp7A/U1x9c60gMQwAJJdUyhaPkMhEM7O8yOdd
 SN7i6ht4hOn0/G4vs9HeDL0erJ3fSx+DRNpIYTH+v36FWBmt2kobroQZtMEsUNkN/9Tu
 j6FYo5RiaQc1EQKDdTTzUNTp2tnuG4fWokkDUhKnOqw7gID7crjo/x2F10T6iOjHiZOR
 be/sPB9Miw2iN+RkmKxsiEi3hEVnG7BHq9wuR896mNewc/Q+dK49OKI07CKkqglQPfE3
 GIqA==
X-Gm-Message-State: AOJu0YxtuVh3gwhFwj5a2NdymVJmgGDCVVm3f952ZByPzByAiU3X6N0u
 V9Rhd07M8toyMv5cvrPnA9b5d1IjDG96eSgAULwENTvNhVu3AP+l0YBA
X-Gm-Gg: ASbGncv3CD5HXC9RflPXWdV2KwTnhC66xyGirrTl+sQ/M2K740ph2ievhln1LFhaDED
 vibiNFZLA3XzHbrGUJDfDdxvd1/uP//bF0nWtR19r6H+kLmPiQ5EwffPyKl5GpHNz11bD78Eti1
 zCk1d2yYp6EYGYIByWQ4gGwkrcJhmG0GB1YQCDTSrlIsxjvagaqWKZB6K2emqmAVk63Z/5kjroP
 JZidsnZ9gukrhvP3RXHKjaQ2VO9zisUXJApAMVdW/1sdnD2BYx5a7adKcVYdPjdXrnMnmhtC7Kd
 5wrNNwEY6APscpm4LMNo1O7FAuMWyqnHA7fkXkVI5Mhkxjrdu2CZsUFGwWwufrKgEBGQSOyVttU
 I2TjpovcGkepyAxYQa+VlZeJN+M5Nv+RzlaYdrSZ6vtVr
X-Google-Smtp-Source: AGHT+IHL5CotJyoYZdydlNdjQdfPzkFkoVOy6zS0YZkPmWgbWdV0S5FV1SGhZgvXMxpu/sv7e4hMcg==
X-Received: by 2002:a05:6a20:729c:b0:240:cf:7978 with SMTP id
 adf61e73a8af0-24000cf7aa5mr12761259637.29.1754385584898; 
 Tue, 05 Aug 2025 02:19:44 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:19:44 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 1/9] arm: dts: npcm8xx: add pinmux for VCD input
Date: Tue,  5 Aug 2025 17:18:42 +0800
Message-Id: <20250805091850.2051096-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Stanley Chu <yschu@nuvoton.com>

Add pinmux to select the HSYNC signal as the VCD input.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
index bc047d4b443..6f933355d9e 100644
--- a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
+++ b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
@@ -1056,5 +1056,9 @@
 			groups = "jtag2";
 			function = "jtag2";
 		};
+		vcdhs_pins: vcdhs-pins {
+			groups = "vcdhs";
+			function = "vcdhs";
+		};
 	};
 };
-- 
2.34.1

